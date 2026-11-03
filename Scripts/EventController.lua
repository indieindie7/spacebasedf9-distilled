local Docking=require('Docking')
local GameRules=require('GameRules')
local Character=require('Character')
local Base = require('Base')
local Inventory = require('Inventory')
local Room=require('Room')
local Renderer=require('Renderer')
local CharacterManager=require('CharacterManager')
local DFMath = require('DFCommon.Math')
local DFGraphics = require('DFCommon.Graphics')
local SoundManager = nil
local MiscUtil = require('MiscUtil')
local Gui = require('UI.Gui')
local Delegate = require('DFMoai.Delegate')
local ModuleData = require('ModuleData')
local Malady = require('Malady')
local AutoSave=require('AutoSave')
local EventController= {}
g_EventController = EventController
EventController.nSaveVersion = 1.6
EventController.dForecastGenerated = Delegate.new()
EventController.nEventForecastMax = 15
EventController.nPrevEventsCount = 10
EventController.nFinalSiegeTime = 60 * 60 * 4
EventController.nMaxPlaytime = 60 * 60 * 8
EventController.tFirstEventTimeRange = { 400, 440 }
EventController.tAlertTimeRange = { 45, 45 }
EventController.RENDER_LAYER = 'WorldFloor'
EventController.RENDER_LAYER_BG = 'WorldFloor'
local ImmigrationEvent = require('GameEvents.ImmigrationEvent')
local DerelictEvent = require('GameEvents.DerelictEvent')
local HostileImmigrationEvent = require('GameEvents.HostileImmigrationEvent')
local DockingEvent = require('GameEvents.DockingEvent')
local BreachingEvent = require('GameEvents.BreachingEvent')
local MeteorEvent = require('GameEvents.MeteorEvent')
local HostileDockingEvent = require('GameEvents.HostileDockingEvent')
local HostileDerelictEvent = require('GameEvents.HostileDerelictEvent')
local CompoundEvent = require('GameEvents.CompoundEvent')
EventController.tEventClasses = {
    [ImmigrationEvent.sEventType]         = ImmigrationEvent,
    [HostileImmigrationEvent.sEventType]  = HostileImmigrationEvent,
    [BreachingEvent.sEventType]           = BreachingEvent,
    [DerelictEvent.sEventType]            = DerelictEvent,
    [DockingEvent.sEventType]             = DockingEvent,
    [MeteorEvent.sEventType]              = MeteorEvent,
    [HostileDockingEvent.sEventType]              = HostileDockingEvent,
    [HostileDerelictEvent.sEventType]              = HostileDerelictEvent,
    [CompoundEvent.sEventType]              = CompoundEvent,
}
function EventController.init()
    EventController.nEventsThisPlaySession = 0
	EventController.hideMeteorStrikeIndicator()
    SoundManager = require('SoundManager')
    Docking.init()
    EventController.fromSaveData({})
end
function EventController.setBaseSeeds()
    local tLandingZone = GameRules.getLandingZone()
    EventController.tS.tSpawnModifiers = {}
    local nTotal = 0.0
    local nClasses = 0
    for _, rClass in pairs(EventController.tEventClasses) do
        local nMod = rClass.getSpawnLocationModifier()
        EventController.tS.tSpawnModifiers[rClass.sEventType] = nMod
        local nWeight = rClass.getWeight(25, 60*60*2, true)
        nTotal = nTotal + nMod * nWeight
        nClasses = nClasses + nWeight
        print('    ',rClass.sEventType,nMod,'weight:',nWeight)
    end
    print('total',nTotal,'out of',nClasses)
    local nAvg = nTotal / nClasses
    local nMinAvg = 78/130
    local nMaxAvg = 244/130
    local nRange = nMaxAvg-nMinAvg
    nAvg = math.min(math.max(nMinAvg,nAvg),nMaxAvg)
    nAvg = (nAvg-nMinAvg)/nRange
    nAvg = 1-nAvg
    nAvg = nAvg*nAvg*nAvg*nAvg
    local nTimeBetween = 135 + nAvg * 465
    print('avg time between events',nTimeBetween)
    EventController.tS.tSpawnModifiers.nAvgTimeBetweenEvents = nTimeBetween
end
function EventController.getTeamForEvent(eFactionBehavior)
    if EventController.tCurrentEventPersistentState then
        if eFactionBehavior == Character.FACTION_BEHAVIOR.EnemyGroup and EventController.tCurrentEventPersistentState.nEnemyFactionTeam then
            return EventController.tCurrentEventPersistentState.nEnemyFactionTeam
        end
        if eFactionBehavior == Character.FACTION_BEHAVIOR.Friendly and EventController.tCurrentEventPersistentState.nFriendlyFactionTeam then
            return EventController.tCurrentEventPersistentState.nFriendlyFactionTeam
        end
    end
    local nTeam = Base.createNewTeamID(eFactionBehavior)
    if EventController.tCurrentEventPersistentState then
        if eFactionBehavior == Character.FACTION_BEHAVIOR.EnemyGroup then
            EventController.tCurrentEventPersistentState.nEnemyFactionTeam = nTeam
        end
        if eFactionBehavior == Character.FACTION_BEHAVIOR.Friendly then
            EventController.tCurrentEventPersistentState.nFriendlyFactionTeam = nTeam
        end
    end
    return nTeam
end
function EventController._portOldSaves(tSaveData)
    if not tSaveData.nSaveVersion or tSaveData.nSaveVersion < EventController.nSaveVersion then
        tSaveData = {}
        return tSaveData
    end
    local updateEventSave = function(t)
        if t and t.tModuleData then
            t.sModuleName=t.tModuleData.sModuleName
            t.sSetName=t.tModuleData.sSetName
            t.sModuleEventName = t.tModuleData.sModuleEventName
            if not Docking.tLoadedModules[t.sSetName] then
                local tSets={'hostileDerelictEvents','hostileDockingEvents','friendlyDerelictEvents','friendlyDockingEvents'}
                for _,sSet in ipairs(tSets) do
                    if Docking.tLoadedModules[sSet][t.sModuleName] then
                        t.sSetName = sSet
                        break
                    end
                end
            end
            t.tModuleData = nil
        end
        if t and t.tRaiderChallengeLevels then
            return false
        end
        return true
    end
    if not updateEventSave(tSaveData.tPrevEventData) then tSaveData.tPrevEventData = nil end
    if not updateEventSave(tSaveData.tNextEventData) then tSaveData.tNextEventData = nil end
    for i,v in ipairs(tSaveData.tEventForecast) do
        if not updateEventSave(v) then
            table.remove(tSaveData.tEventForecast,i)
        end
    end
    return tSaveData
end
function EventController.fromSaveData(tSaveData)
    EventController.fnOngoingEventTick = nil
    EventController.tCurrentEventPersistentState = nil
    if tSaveData then
        tSaveData = EventController._portOldSaves(tSaveData)
    end
    EventController.tS = tSaveData or {}
    EventController.tS.nSaveVersion = EventController.nSaveVersion
    local defaults = {
        tEventForecast = {},
        tPrevEventInfo = {},
        tSpawnModifiers = {},
    }
    local bRegenSeeds = EventController.tS.tSpawnModifiers == nil
    if not bRegenSeeds then
        for _, rClass in pairs(EventController.tEventClasses) do
            if not EventController.tS.tSpawnModifiers[rClass.sEventType] then
                bRegenSeeds = true
                break
            end
        end
    end
    for k,v in pairs(defaults) do
        if not EventController.tS[k] then EventController.tS[k] = v end
    end
    if bRegenSeeds then
        EventController.setBaseSeeds()
    end
    if EventController.tS.tEventForecast and #EventController.tS.tEventForecast > 0 then
        local n = #EventController.tS.tEventForecast
        EventController.stNextEventID = math.max(
            EventController.stNextEventID or 1,
            (EventController.tS.tEventForecast[n].nUniqueID or 1) + 1)
    elseif EventController.tS.tNextEventData then
        EventController.stNextEventID = math.max(
            EventController.stNextEventID or 1,
            (EventController.tS.tNextEventData.nUniqueID or 1) + 1)
    else
        EventController.stNextEventID = 1
    end
    if #EventController.tS.tEventForecast == 0 then
        EventController.generateEventForecast()
    end
    if EventController.tS.tNextEventData == nil then
        EventController.tS.tNextEventData = table.remove(EventController.tS.tEventForecast, 1)
        EventController.bAlertedNextEvent = false
    end
    if #EventController.tS.tEventForecast == 0 then
        EventController.generateEventForecast()
    end
    if EventController.tS.tNextEventData then
        EventController.tS.tNextEventData.bAlertedNextEvent = false
    end
end
function EventController.getSaveData()
    return EventController.tS
end
function EventController.DBG_forceForecastRegen()
    if EventController.tS and EventController.tS.tEventForecast then
        EventController.generateEventForecast()
        EventController._eventCompleted({sEventType = 'CompoundEvent'})
    end
end
function EventController.DBG_forceNextEvent()
    EventController._forceNextEvent()
end
function EventController._forceNextEvent()
    if EventController.tS and EventController.tS.tNextEventData then
        local nDelta = 0
        local nOldStart = EventController.tS.tNextEventData.nStartTime
        EventController.tS.tNextEventData.nStartTime = GameRules.elapsedTime + EventController.tAlertTimeRange[2]
        EventController.tS.tNextEventData.nAlertTime = GameRules.elapsedTime
        EventController.tS.tNextEventData.bDebugQueued = true
        nDelta = nOldStart - EventController.tS.tNextEventData.nStartTime
        if nDelta > 0 then
            for idx, tEvent in ipairs(EventController.tS.tEventForecast) do
                tEvent.nStartTime = tEvent.nStartTime - nDelta
                tEvent.nAlertTime = tEvent.nStartTime - math.random(EventController.tAlertTimeRange[1],EventController.tAlertTimeRange[2])
            end
        end
    end
end
function EventController.DBG_forceQueue(sEventName, bDBGForceHostile, nDelay)
	nDelay = nDelay or 0
    local nStartTime = GameRules.elapsedTime + nDelay
    local nAlert = nStartTime - math.random(EventController.tAlertTimeRange[1],EventController.tAlertTimeRange[2])
    EventController.tS.tNextEventData = {
        sEventType = sEventName,
        nStartTime = nStartTime,
        nAlertTime = nAlert,
        nUniqueID = EventController.stNextEventID,
    }
    EventController.stNextEventID = EventController.stNextEventID + 1
    EventController.tS.tNextEventData.bDBGForceHostile = bDBGForceHostile
    EventController.tS.tNextEventData.bAlertedNextEvent = false
    EventController.tEventClasses[sEventName].onQueue(
        EventController, EventController.tS.tNextEventData,
        CharacterManager.getOwnedCitizenPopulation(), nStartTime)
    return EventController.tS.tNextEventData
end
function EventController._failed(tNextEventState, sOptionalFailMsg)
    tNextEventState.nFailures = (tNextEventState.nFailures and tNextEventState.nFailures + 1) or 1
    if tNextEventState.nFailures > EventController.tEventClasses[tNextEventState.sEventType].nAllowedSetupFailures then
        if sOptionalFailMsg then
            Base.eventOccurred(Base.EVENTS.EventFailure, {sLineCode=sOptionalFailMsg, tPersistentData=tNextEventState})
        end
        tNextEventState.bFailed=true
        tNextEventState.sFailureMessage=sOptionalFailMsg
        EventController._eventCompleted(tNextEventState)
    end
end
function EventController.attemptExecuteEvent(tNextEventData)
    local rEventClass = EventController.tEventClasses[tNextEventData.sEventType]
    local tTransientState = {}
    local bSuccess, sFailMsg = rEventClass.preExecuteSetup(EventController, tNextEventData, tTransientState)
    if bSuccess then
        if GameRules.elapsedTime - AutoSave.nTimeSinceLastSave > 45 then
            AutoSave.saveGame()
        end
        EventController.fnOngoingEventTick = rEventClass.tick
        EventController.tCurrentEventPersistentState = tNextEventData
        EventController.tCurrentEventTransientState = tTransientState
        EventController.nEventsThisPlaySession = EventController.nEventsThisPlaySession + 1
    else
        EventController._failed(tNextEventData, sFailMsg)
    end
end
function EventController.clearCurrentEventFromSaveTable(id)
    if EventController.tS.tNextEventData and EventController.tS.tNextEventData.nUniqueID == id then
        EventController.tS.tNextEventData = nil
    else
        if EventController.tS.tNextEventData and EventController.tS.tNextEventData.sEventType == 'CompoundEvent' then
        else
            Print(TT_Warning, 'not clearing event id',id)
            EventController.tS.tNextEventData = nil
        end
    end
end
function EventController._eventCompleted(tEventPersistentState)
    EventController.clearCurrentEventFromSaveTable(tEventPersistentState.nUniqueID)
    local rClass = EventController.tEventClasses[tEventPersistentState.sEventType]
    if rClass then
        rClass.cleanup(EventController, tEventPersistentState)
        while #EventController.tS.tPrevEventInfo >= EventController.nPrevEventsCount do
            table.remove(EventController.tS.tPrevEventInfo, 1)
        end
        local tPrevEventInfo = {
            sEventType = tEventPersistentState.sEventType,
            tx = tEventPersistentState.tx,
            ty = tEventPersistentState.ty,
            nCompletionTime = GameRules.elapsedTime
        }
        table.insert(EventController.tS.tPrevEventInfo, tPrevEventInfo)
    end
    EventController.fnOngoingEventTick = nil
    EventController.tCurrentEventPersistentState = nil
    EventController.tCurrentEventTransientState = nil
    if not tEventPersistentState.bDebugQueued then
        EventController.generateEventForecast()
    end
    EventController.tS.tNextEventData = table.remove(EventController.tS.tEventForecast, 1)
    if EventController.tS.tNextEventData then EventController.tS.tNextEventData.bAlertedNextEvent = false end
    if tEventPersistentState.bFailed and not tEventPersistentState.sFailureMessage then
        EventController._forceNextEvent()
    end
end
function EventController.initCameraMove(tx,ty)
    local tCutscene={}
    local rCamera = Renderer.getGameplayCamera()
    tCutscene.xEnd,tCutscene.yEnd = g_World._getWorldFromTile(tx,ty)
    tCutscene.xStart,tCutscene.yStart,tCutscene.zStart=rCamera:getLoc()
    local dx,dy = tCutscene.xEnd-tCutscene.xStart,tCutscene.yEnd-tCutscene.yStart
    tCutscene.dx,tCutscene.dy=dx,dy
    tCutscene.nDist = math.sqrt(dx*dx+dy*dy)+1
    tCutscene.nDuration = math.max(0.5, math.min(1.5, tCutscene.nDist / 5000))
    tCutscene.nElapsed = 0
    tCutscene.t = 0
    return tCutscene
end
function EventController.tickCamera(dt,tCutscene)
    tCutscene.nElapsed=tCutscene.nElapsed+dt
    local t = math.min(tCutscene.nElapsed / tCutscene.nDuration, 1)
    local newX,newY =  DFMath.lerp(tCutscene.xStart, tCutscene.xEnd, t),
                       DFMath.lerp(tCutscene.yStart, tCutscene.yEnd, t)
    GameRules.setCameraLoc(newX,newY,tCutscene.zStart)
    tCutscene.t = t
    return t == 1
end
function EventController._doAlert(tEventData)
    local rNextEventClass = EventController.tEventClasses[tEventData.sEventType]
                if rNextEventClass.preAlertSetup then
                    if not rNextEventClass.preAlertSetup(EventController, tEventData) then
                        EventController._failed(tEventData)
                        return false
                    end
                end
                if not rNextEventClass.bSkipAlert then
                    EventController.tEventClasses[tEventData.sEventType].onAlertShown(EventController, tEventData)
                    local wx, wy = nil,nil
                    if tEventData.tx then
                        wx, wy = g_World._getWorldFromTile(tEventData.tx, tEventData.ty)
                    end
                    Base.eventOccurred(Base.EVENTS.EventAlert,
                        {
                            sLineCode = rNextEventClass.sAlertLC,
                            tPersistentData = tEventData,
                            nPriority = rNextEventClass.nAlertPriority,
                            wx=wx,wy=wy,
                        })
                end
                return true
end
function EventController.onTick(dt)
	if EventController.rMeteorIndicator then
		local r,g,b = unpack(Gui.RED)
		local a = math.abs(math.sin(GameRules.elapsedTime * 4)) / 2 + 0.5
		r,g,b = r*a, g*a, b*a
		EventController.rMeteorIndicator:setColor(r, g, b)
	end
    if CharacterManager.getOwnedCitizenPopulation() > 0 then
        if EventController.fnOngoingEventTick then
            if EventController.fnOngoingEventTick(EventController, dt, EventController.tCurrentEventPersistentState, EventController.tCurrentEventTransientState) then
                EventController._eventCompleted(EventController.tCurrentEventPersistentState)
            end
        elseif EventController.tS.tNextEventData then
            local tNextEvent = EventController.tS.tNextEventData
            local rNextEventClass = EventController.tEventClasses[EventController.tS.tNextEventData.sEventType]
            if GameRules.elapsedTime >= EventController.tS.tNextEventData.nStartTime then
                EventController.attemptExecuteEvent(EventController.tS.tNextEventData)
            elseif not EventController.tS.tNextEventData.bAlertedNextEvent and GameRules.elapsedTime > EventController.tS.tNextEventData.nAlertTime then
                if EventController._doAlert(EventController.tS.tNextEventData) then
                    EventController.tS.tNextEventData.bAlertedNextEvent = true
                end
            end
            if tNextEvent == EventController.tS.tNextEventData and not EventController.tS.tNextEventData.bFailed and GameRules.elapsedTime < EventController.tS.tNextEventData.nStartTime and rNextEventClass.preExecuteTick then
                rNextEventClass.preExecuteTick(EventController,EventController.tS.tNextEventData)
            end
        else
            Trace(TT_Error, "No next event ready?")
            assert(false)
        end
    end
end
function EventController._getNextEventTimeDelta()
    local nElapsedTime = math.min(GameRules.elapsedTime, EventController.nMaxPlaytime)
    local x = nElapsedTime / EventController.nMaxPlaytime
    local alpha = 1.0 - (0.5 + 0.54 * x * math.sin(6.0 * math.pi * x))
    alpha = math.max(0, math.min(1, alpha))
    local t
    local nTimeBetween = EventController.tS.tSpawnModifiers.nAvgTimeBetweenEvents
    if not nTimeBetween then
        local tBetweenEventTimeRange = { 100, 240 }
        t = tBetweenEventTimeRange[1] * alpha +
              tBetweenEventTimeRange[2] * (1.0 - alpha) +
              math.random(-30, 30)
    else
        local nMin = .6 * nTimeBetween
        local nMax = 1.4 * nTimeBetween
        t = nMin * alpha +
              nMax * (1.0 - alpha) +
              math.random(-20,20)
    end
    return t
end
function EventController.generateEventForecast(nForcePop,nForceTime)
    EventController.tS.tEventForecast = {}
    local nAllowedConsecutiveEvents = 3
    local nConsecutiveEvents = 1
    local nPopulationDeltaEstimate = nForcePop or CharacterManager.getOwnedCitizenPopulation()
    local nTimeDeltaEstimate = nForceTime or 0
    for i=1,EventController.nEventForecastMax do
        local nEventTimeDelta = EventController._getNextEventTimeDelta()
        if i == 1 and #EventController.tS.tPrevEventInfo == 0 then
            nEventTimeDelta = math.random(EventController.tFirstEventTimeRange[1],EventController.tFirstEventTimeRange[2])
        end
        local nPopulationEstimate = nPopulationDeltaEstimate
        local nTimeEstimate = GameRules.elapsedTime + nTimeDeltaEstimate + nEventTimeDelta
        local tWeights = {}
        local nCount = 0
        for sEventType, rClass in pairs(EventController.tEventClasses) do
            if (nConsecutiveEvents < 3 or (i > 1 and sEventType ~= EventController.tS.tEventForecast[i-1].sEventType))
                and rClass.allowEvent(nPopulationEstimate, nTimeEstimate) then
                tWeights[sEventType] =
                    rClass.getWeight(nPopulationEstimate, nTimeEstimate)
                    * EventController.tS.tSpawnModifiers[sEventType]
                nCount = nCount + 1
            end
        end
        if nCount == 0 then
            tWeights[ImmigrationEvent.sEventType] = 1
            nCount = 1
        end
        local sNextEventType = MiscUtil.weightedRandom(tWeights)
        if i > 1 and sNextEventType == EventController.tS.tEventForecast[i-1].sEventType then
            nConsecutiveEvents = nConsecutiveEvents + 1
        else
            nConsecutiveEvents = 1
        end
        local tEventData = {
            sEventType = sNextEventType,
            nStartTime = nTimeEstimate,
            nAlertTime = nTimeEstimate - math.random(EventController.tAlertTimeRange[1],EventController.tAlertTimeRange[2]),
            nUniqueID = EventController.stNextEventID,
        }
        EventController.stNextEventID = EventController.stNextEventID + 1
        EventController.tEventClasses[sNextEventType].onQueue(
            EventController,
            tEventData,
            nPopulationEstimate,
            nTimeEstimate)
        table.insert(EventController.tS.tEventForecast, tEventData)
        if sNextEventType == ImmigrationEvent.sEventType then
            nPopulationDeltaEstimate = nPopulationDeltaEstimate + tEventData.nNumSpawns
        elseif sNextEventType == DockingEvent.sEventType
                or sNextEventType == DerelictEvent.sEventType then
            if tEventData.bValidDockingData then
                for _, sLoc in pairs(tEventData.tCrewData) do
                    nPopulationDeltaEstimate = nPopulationDeltaEstimate + 1
                end
            end
        elseif sNextEventType == HostileDockingEvent.sEventType
                or sNextEventType == HostileDerelictEvent.sEventType
                or sNextEventType == HostileImmigrationEvent.sEventType
                or sNextEventType == CompoundEvent.sEventType then
            nPopulationDeltaEstimate = nPopulationDeltaEstimate - 1
        end
        nTimeDeltaEstimate = nTimeDeltaEstimate + nEventTimeDelta
    end
    EventController.dForecastGenerated:dispatch()
end
function EventController.showMeteorStrikeIndicator(tx, ty)
    local p = MOAIProp.new()
    local spriteSheet = DFGraphics.loadSpriteSheet('UI/UIMisc')
    p:setDeck(spriteSheet)
    local idx = spriteSheet.names['meteor_highlight']
    p:setIndex(idx)
    DFGraphics.alignSprite(spriteSheet, idx, "center", "center")
    p:setColor(unpack( Gui.RED ))
    local r = spriteSheet.rects[idx]
    local wx,wy,wz = g_World._getWorldFromTile(tx, ty)
    local w,h = r.origWidth, r.origHeight
    local nScale = MeteorEvent.METEOR_STRIKE_RADIUS / w
    nScale = nScale * 1.2
    p:setScl(nScale, nScale)
    p:setLoc(wx, wy, wz)
    Renderer.getRenderLayer('Cursor'):insertProp(p)
    EventController.rMeteorIndicator = p
end
function EventController.hideMeteorStrikeIndicator()
    if not EventController.rMeteorIndicator then
        return
    end
    Renderer.getRenderLayer('Cursor'):removeProp(EventController.rMeteorIndicator)
    EventController.rMeteorIndicator = nil
    EventController.tMeteorEventIndicated = nil
end
function EventController.rollRandomRaiders(nDifficulty, bAllowKillbots)
    local nRaiders = 1
    if nDifficulty > .4 then
        nRaiders = math.random(1,3)
    elseif nDifficulty > .2 then
        nRaiders = math.random(1,2)
    end
    if nRaiders > 2 then
        nDifficulty = nDifficulty * .75
    elseif nRaiders > 1 then
        nDifficulty = nDifficulty * .85
    end
    local tCharSpawnStats = {}
    local Event=require('GameEvents.Event')
    for i=1,nRaiders do
        tCharSpawnStats[i] =
            {
                nChallengeLevel = Event.getChallengeLevel(nDifficulty),
                sName = 'Raider',
                nJob = Character.RAIDER
            }
        if tCharSpawnStats[i].nChallengeLevel > .75 and bAllowKillbots and math.random() > .5 then
            tCharSpawnStats[i].nRace = Character.RACE_KILLBOT
            tCharSpawnStats[i].sName = 'Kill Bot'
        end
    end
    return tCharSpawnStats
end
function EventController.spawnModuleEntities(tEventData, tModuleData, tTeams)
    local tCrewData = tEventData.tCrewData
    local tObjectData = tEventData.tObjectData
    local tMaladyData = tEventData.tPrerolledMalady
    if not tModuleData or not (tCrewData or tObjectData) then
        return
    end
    local sEventType = tEventData.sEventType
    local Spawner = require('EnvObjects.Spawner')
    local EnvObject = require('EnvObjects.EnvObject')
    local ShipModules = require('ModuleData')
    local Pickup = require('Pickups.Pickup')
    local Base = require('Base')
    local tLocs = Spawner.getAllOnTeam(tTeams.nDefaultTeam)
    if not tLocs then
        return
    end
    local fnGetTeam = function(tSpawnData,tTeams)
        local nTeam = tTeams.nDefaultTeam
        if tSpawnData.nFactionBehavior and tSpawnData.nFactionBehavior ~= tTeams.nDefaultFactionBehavior then
            if not tTeams[tSpawnData.nFactionBehavior] then
                tTeams[tSpawnData.nFactionBehavior] = Base.createNewTeamID(tSpawnData.nFactionBehavior)
            end
            nTeam = tTeams[tSpawnData.nFactionBehavior]
        end
        return nTeam
    end
    local tSpawnTypes = {
        crew = tCrewData, objects = tObjectData
    }
    for sDataType, tCrewOrObjectDataTable in pairs(tSpawnTypes) do
        for sLocName, spawnData in pairs(tCrewOrObjectDataTable) do
            if tLocs[sLocName] then
				if sDataType == "crew" then
					local tData = {}
					local tCopiedTables={'tStatus','tStats','tNeeds',}
					for _,tblName in ipairs(tCopiedTables) do
						if spawnData[tblName] then
							tData[tblName] = {}
							for k,v in pairs(spawnData[tblName]) do
								tData[tblName][k] = v
							end
						end
					end
					tData.x,tData.y = tLocs[sLocName]:getLoc()
					local tx,ty = g_World._getTileFromWorld(tData.x,tData.y)
					if g_World._getTileValue(tx,ty) == g_World.logicalTiles.SPACE then
						tData.tStatus.bSpacewalking = true
					end
					local nTeam = fnGetTeam(spawnData,tTeams)
					local rNewChar = CharacterManager.addNewCharacter(nil, nil, tData, nTeam)
					if tMaladyData and spawnData.bSpawnWithMalady then
						local tMaladyInstance = Malady.reproduceMalady(tMaladyData)
						rNewChar:diseaseInteraction(nil, tMaladyInstance)
					end
				elseif sDataType == "objects" then
					local wx,wy = tLocs[sLocName]:getLoc()
					local bFlipX, bFlipY = tLocs[sLocName].bFlipX, tLocs[sLocName].bFlipY
					if spawnData.bInvItem then
						local tItem
						if spawnData.sTemplate then
							tItem = Inventory.createItem(spawnData.sTemplate, spawnData.tSaveData)
						else
							tItem = Inventory.createRandomStartingStuff()
						end
						Pickup.dropInventoryItemAt(tItem,wx,wy)
					else
						local tData, bPickup = EnvObject.getObjectData(spawnData.sType or spawnData.sTemplate)
						if tData then
							local nTeam = fnGetTeam(spawnData,tTeams)
							if bPickup then
								Pickup.createPickupAt(spawnData.sType, wx,wy, spawnData.tSaveData, nTeam)
							else
								EnvObject.createEnvObject(spawnData.sType or spawnData.sTemplate, wx, wy, bFlipX, bFlipY, true, spawnData.tSaveData, nTeam)
							end
						else
							Print(TT_Error, "Invalid object type in save data: "..tostring(spawnData.sType))
						end
					end
                end
            end
        end
    end
    for sName,rLoc in pairs(tLocs) do
        rLoc:remove()
    end
end
function EventController.getForecastDebugText()
    local s = ""
    if EventController.tS and EventController.tS.tEventForecast then
        local tNextEvent = EventController.tS.tNextEventData
        s = s .. "Next Event"
        s = s .. " | CurTime: " .. MiscUtil.formatTime(GameRules.elapsedTime)
        s = s .. " | Use ^ to force event\n"
        s = s ..  "-------------------------------------------------\n"
        if tNextEvent then
            s = s .. string.format(" 0) %s\n\n", EventController.tEventClasses[tNextEvent.sEventType].getDebugString(EventController, tNextEvent))
        else
            s = s .. "None\n"
        end
        s = s .. string.format("Event Forecast", #EventController.tS.tEventForecast)
        s = s .. " | Use ! to regen forecast\n"
        s = s ..  "-------------------------------------------------\n"
        for idx, tEventState in ipairs(EventController.tS.tEventForecast) do
            local sLine = EventController.tEventClasses[tEventState.sEventType].getDebugString(EventController, tEventState)
            s = s .. string.format("%2d) %s\n", idx, sLine)
        end
    end
    return s
end
return EventController
