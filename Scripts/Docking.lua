local Character=require('CharacterConstants')
local ObjectList=require('ObjectList')
local Room=require('Room')
local Asteroid=require('Asteroid')
local ModuleData=require('ModuleData')
local Zone=require('Zones.Zone')
local DFMath=require('DFCommon/Math')
local DFUtil=require('DFCommon.Util')
local GridUtil=require('GridUtil')
local LuaGrid=require('LuaGrid')
local MiscUtil=require('MiscUtil')
local CommandObject=require('Utility.CommandObject')
local Docking = {}
Docking.nDerelictFreq = .67
Docking.nMaxEventsPerAttempt = 2
Docking.nBridgeLength = 5
Docking.nMaxTestTilesPerRoom = 3
Docking.tEventRequirements=
{
    editMode={ bLoadModule=false, },
    immigrationEvents=
    {
        bLoadModule=false,
        tSpawnRange={15,20},
    },
    hostileImmigrationEvents=
    {
        bLoadModule=false,
        tSpawnRange={15,20},
    },
    friendlyDockingEvents=
    {
        bLoadModule=true,
        bDocking=true,
        tSpawnRange={40,60},
    },
    friendlyDerelictEvents=
    {
        bLoadModule=true,
        bAllowSpawnInAsteroid = true,
        tSpawnRange={40,60},
    },
    hostileDockingEvents=
    {
        bLoadModule=true,
        bDocking=true,
        tSpawnRange={40,60},
    },
    hostileDerelictEvents=
    {
        bLoadModule=true,
        bAllowSpawnInAsteroid = true,
        tSpawnRange={40,60},
    },
}
Docking.CREATE_BRIDGES = true
Docking.DISABLED = false
Docking.nTimeUntilNextEvent = nil
function Docking.init()
    if Docking.DISABLED then
        return
    end
    Docking.tLoadedModules = {}
    local function precomputeEventData(sCategory)
        for k,tEvent in pairs(ModuleData[sCategory]) do
            Docking._loadEventData(sCategory,k)
        end
    end
    precomputeEventData('friendlyDockingEvents')
    precomputeEventData('friendlyDerelictEvents')
    precomputeEventData('hostileDerelictEvents')
    precomputeEventData('hostileDockingEvents')
end
function Docking._loadEventData(sCategory,k)
    local tEvent = ModuleData[sCategory][k]
        if not Docking.tLoadedModules[sCategory] then Docking.tLoadedModules[sCategory] = {} end
        if Docking.tLoadedModules[sCategory][k] then return end
        tEvent.sName=k
        local tModuleData = require('GameRules').loadModule(sCategory,k)
        Docking.tLoadedModules[sCategory][k] = tModuleData
        local tSaveData = tModuleData.tSaveData
        if not tSaveData then return end
        tSaveData.tWorldSaveData.pathGrid = LuaGrid.fromSaveData(tSaveData.tWorldSaveData.pathGrid, false, {nDefaultVal=g_World.logicalTiles.SPACE})
        tSaveData.tWorldSaveData.oxygenGrid = LuaGrid.fromSaveData(tSaveData.tWorldSaveData.oxygenGrid, false, {nDefaultVal=0})
        tEvent.isoBoundsUpperLeftX = 0
        tEvent.isoBoundsLowerLeftX = 0
        tEvent.isoBoundsUpperRightX = 0
        tEvent.isoBoundsLowerRightX = 0
        tEvent.isoBoundsLowerRightY = 0
        tEvent.isoBoundsLowerLeftY = 0
        tEvent.isoBoundsUpperRightY = 0
        tEvent.isoBoundsUpperLeftY = 0
        if next(tSaveData.tWorldSaveData.pathGrid.tTiles) == nil then
        else
            local bZero = false
        local lowerLeftX = tSaveData.tWorldSaveData.minX
        local lowerLeftY = tSaveData.tWorldSaveData.minY
        while lowerLeftY <= tSaveData.tWorldSaveData.maxY and lowerLeftY >= tSaveData.tWorldSaveData.minY do
            local currentX = lowerLeftX
            local currentY = lowerLeftY
            local hitSomething = false
            while currentX >= tSaveData.tWorldSaveData.minX and currentY >= tSaveData.tWorldSaveData.minY and
                  currentX <= tSaveData.tWorldSaveData.maxX and currentY <= tSaveData.tWorldSaveData.maxY do
                if tSaveData.tWorldSaveData.pathGrid:getTileValue(currentX, currentY) ~= g_World.logicalTiles.SPACE then
                    lowerLeftX = currentX
                    lowerLeftY = currentY
                    hitSomething = true
                    break
                else
                    currentX, currentY = g_World._getAdjacentTile(currentX, currentY, g_World.directions.SE)
                end
            end
            if hitSomething then
                break
            else
                lowerLeftX, lowerLeftY = g_World._getAdjacentTile(lowerLeftX, lowerLeftY, g_World.directions.N)
            end
        end
        local lowerRightX = tSaveData.tWorldSaveData.maxX
        local lowerRightY = tSaveData.tWorldSaveData.minY
        while lowerRightX >= tSaveData.tWorldSaveData.minX and lowerRightX <= tSaveData.tWorldSaveData.maxX do
            local currentX = lowerRightX
            local currentY = lowerRightY
            local hitSomething = false
            while currentX >= tSaveData.tWorldSaveData.minX and currentY >= tSaveData.tWorldSaveData.minY and
                  currentX <= tSaveData.tWorldSaveData.maxX and currentY <= tSaveData.tWorldSaveData.maxY do
                if tSaveData.tWorldSaveData.pathGrid:getTileValue(currentX, currentY) ~= g_World.logicalTiles.SPACE then
                    lowerRightX = currentX
                    lowerRightY = currentY
                    hitSomething = true
                    break
                else
                    currentX, currentY = g_World._getAdjacentTile(currentX, currentY, g_World.directions.NE)
                end
            end
            if hitSomething then
                break
            else
                lowerRightX, lowerRightY = g_World._getAdjacentTile(lowerRightX, lowerRightY, g_World.directions.W)
            end
        end
        local upperRightX = tSaveData.tWorldSaveData.maxX
        local upperRightY = tSaveData.tWorldSaveData.maxY
        while upperRightX >= tSaveData.tWorldSaveData.minX and upperRightX <= tSaveData.tWorldSaveData.maxX do
            local currentX = upperRightX
            local currentY = upperRightY
            local hitSomething = false
            while currentX >= tSaveData.tWorldSaveData.minX and currentY >= tSaveData.tWorldSaveData.minY and
                  currentX <= tSaveData.tWorldSaveData.maxX and currentY <= tSaveData.tWorldSaveData.maxY do
                if tSaveData.tWorldSaveData.pathGrid:getTileValue(currentX, currentY) ~= g_World.logicalTiles.SPACE then
                    upperRightX = currentX
                    upperRightY = currentY
                    hitSomething = true
                    break
                else
                    currentX, currentY = g_World._getAdjacentTile(currentX, currentY, g_World.directions.NW)
                end
            end
            if hitSomething then
                break
            else
                upperRightX, upperRightY = g_World._getAdjacentTile(upperRightX, upperRightY, g_World.directions.S)
            end
        end
        local upperLeftX = tSaveData.tWorldSaveData.minX
        local upperLeftY = tSaveData.tWorldSaveData.maxY
        while upperLeftX >= tSaveData.tWorldSaveData.minX and upperLeftX <= tSaveData.tWorldSaveData.maxX do
            local currentX = upperLeftX
            local currentY = upperLeftY
            local hitSomething = false
            while currentX >= tSaveData.tWorldSaveData.minX and currentY >= tSaveData.tWorldSaveData.minY and
                  currentX <= tSaveData.tWorldSaveData.maxX and currentY <= tSaveData.tWorldSaveData.maxY do
                if tSaveData.tWorldSaveData.pathGrid:getTileValue(currentX, currentY) ~= g_World.logicalTiles.SPACE then
                    upperLeftX = currentX
                    upperLeftY = currentY
                    hitSomething = true
                    break
                else
                    currentX, currentY = g_World._getAdjacentTile(currentX, currentY, g_World.directions.SW)
                end
            end
            if hitSomething then
                break
            else
                upperLeftX, upperLeftY = g_World._getAdjacentTile(upperLeftX, upperLeftY, g_World.directions.E)
            end
        end
        tEvent.isoBoundsLowerLeftX, tEvent.isoBoundsLowerLeftY = GridUtil.ComputeIsoIntersect(lowerLeftX, lowerLeftY, lowerRightX, lowerRightY)
        tEvent.isoBoundsLowerRightX, tEvent.isoBoundsLowerRightY = GridUtil.ComputeIsoIntersect(upperRightX, upperRightY, lowerRightX, lowerRightY)
        tEvent.isoBoundsUpperRightX, tEvent.isoBoundsUpperRightY = GridUtil.ComputeIsoIntersect(upperRightX, upperRightY, upperLeftX, upperLeftY)
        tEvent.isoBoundsUpperLeftX, tEvent.isoBoundsUpperLeftY = GridUtil.ComputeIsoIntersect(lowerLeftX, lowerLeftY, upperLeftX, upperLeftY)
        end
        assert(tEvent.isoBoundsUpperLeftX <= tEvent.isoBoundsLowerLeftX)
        assert(tEvent.isoBoundsUpperRightX <= tEvent.isoBoundsLowerRightX)
        assert(tEvent.isoBoundsLowerRightY >= tEvent.isoBoundsLowerLeftY)
        assert(tEvent.isoBoundsUpperRightY >= tEvent.isoBoundsUpperLeftY)
end
function Docking._createDoorAt(tx,ty)
    if not ObjectList.getDoorAtTile(tx,ty) then
        local wx,wy = g_World._getWorldFromTile(tx,ty)
        require('EnvObjects.EnvObject').createEnvObject('Door', wx, wy, nil, nil, true)
    end
end
function Docking._testModuleFit(tPossibleEvent, tModuleData, tDockingTile, nDockingCoordsX, nDockingCoordsY, sEventType)
        local moduleOffsetTX,moduleOffsetTY
        local tSaveData
        local tEventRequirements = Docking.tEventRequirements[sEventType]
        if not tEventRequirements.bLoadModule then
            tSaveData={ tWorldSaveData={ minX=123,minY=117,maxX=133,maxY=139} }
            tPossibleEvent = {}
            tPossibleEvent.isoBoundsLowerLeftX = 127.75
            tPossibleEvent.isoBoundsLowerLeftY = 112.5
            tPossibleEvent.isoBoundsLowerRightX = 135.25
            tPossibleEvent.isoBoundsLowerRightY = 127.5
            tPossibleEvent.isoBoundsUpperLeftX = 120.25
            tPossibleEvent.isoBoundsUpperLeftY= 127.5
            tPossibleEvent.isoBoundsUpperRightX = 127.75
            tPossibleEvent.isoBoundsUpperRightY = 142.5
        else
            tSaveData = tModuleData.tSaveData
        end
        if tEventRequirements.bDocking then
            local tDockingPort = tSaveData.tWorldSaveData.dockingPoints and tSaveData.tWorldSaveData.dockingPoints[tDockingTile.nRoomDirection]
            if tDockingPort == nil then
                Print(TT_Error, "Shouldn't create a docking event without a docking port. Data error", tPossibleEvent.sName)
            else
                local portWX,portWY = g_World._getWorldFromTile(tDockingPort.tileX, tDockingPort.tileY)
                local dockingCoordsWX,dockingCoordsWY = g_World._getWorldFromTile(nDockingCoordsX,nDockingCoordsY)
                local dockingOffsetWX = dockingCoordsWX - (portWX-tSaveData.tWorldSaveData.worldMinX)
                local dockingOffsetWY = dockingCoordsWY - (portWY-tSaveData.tWorldSaveData.worldMinY)
                moduleOffsetTX,moduleOffsetTY = g_World._getTileFromWorld(dockingOffsetWX,dockingOffsetWY)
            end
        else
            local tw,th = tSaveData.tWorldSaveData.maxX-tSaveData.tWorldSaveData.minX,tSaveData.tWorldSaveData.maxY-tSaveData.tWorldSaveData.minY
            moduleOffsetTX = nDockingCoordsX - math.ceil(tw*.5)
            moduleOffsetTY = nDockingCoordsY - math.ceil(th*.5)
        end
        if moduleOffsetTX then
            if Docking._testModuleFitAtOffset(sEventType, tPossibleEvent, tModuleData, moduleOffsetTX, moduleOffsetTY) then
                return moduleOffsetTX,moduleOffsetTY
            end
        end
end
function Docking.getModule(sSet,sModule)
    if not Docking.tLoadedModules[sSet] or not Docking.tLoadedModules[sSet][sModule] then
        Docking._loadEventData(sSet,sModule)
    end
    return Docking.tLoadedModules[sSet][sModule]
end
function Docking.testModuleFitAtOffset(sEventType, tPossibleEvent, sModuleSet, sModuleName, moduleOffsetTX, moduleOffsetTY)
    local tModuleData = Docking.tLoadedModules[sModuleSet][sModuleName]
    return Docking._testModuleFitAtOffset(sEventType, tPossibleEvent, tModuleData, moduleOffsetTX, moduleOffsetTY)
end
function Docking._testModuleFitAtOffset(sEventType, tPossibleEvent, tModuleData, moduleOffsetTX, moduleOffsetTY)
    local tSaveData = tModuleData.tSaveData
            local lowerLeftX, lowerLeftY, lowerRightX, lowerRightY, upperRightX, upperRightY, upperLeftX, upperLeftY
            lowerLeftX = moduleOffsetTX + (tPossibleEvent.isoBoundsLowerLeftX - tSaveData.tWorldSaveData.minX)
            lowerLeftY = moduleOffsetTY + (tPossibleEvent.isoBoundsLowerLeftY - tSaveData.tWorldSaveData.minY)
            lowerRightX = moduleOffsetTX + (tPossibleEvent.isoBoundsLowerRightX - tSaveData.tWorldSaveData.minX)
            lowerRightY = moduleOffsetTY + (tPossibleEvent.isoBoundsLowerRightY - tSaveData.tWorldSaveData.minY)
            upperRightX = moduleOffsetTX + (tPossibleEvent.isoBoundsUpperRightX - tSaveData.tWorldSaveData.minX)
            upperRightY = moduleOffsetTY + (tPossibleEvent.isoBoundsUpperRightY - tSaveData.tWorldSaveData.minY)
            upperLeftX = moduleOffsetTX + (tPossibleEvent.isoBoundsUpperLeftX - tSaveData.tWorldSaveData.minX)
            upperLeftY = moduleOffsetTY + (tPossibleEvent.isoBoundsUpperLeftY- tSaveData.tWorldSaveData.minY)
            if Docking._isIsoAreaSpace(sEventType, lowerLeftX, lowerLeftY, lowerRightX, lowerRightY, upperRightX, upperRightY, upperLeftX, upperLeftY) then
                return true
            end
end
function Docking.spawnModule(tEventData)
    local tModuleData = {}
    if tEventData.sModuleName then
        tModuleData = Docking.tLoadedModules[tEventData.sSetName][tEventData.sModuleName]
        tModuleData.tRoomTile = tEventData.tRoomTile
        tModuleData.sModuleEventName = tEventData.sModuleEventName
    end
    local sEventName = Docking._spawnModule(
            tEventData,
            tModuleData,
            tEventData.tx, tEventData.ty,
            tEventData.tDockingTile)
end
function Docking._spawnModule(tEventData, tModuleData, tx, ty, tDockingTile)
    local sEventType = tEventData.sEventType
    local tCrewData = tEventData.tCrewData
    local tObjectData = tEventData.tObjectData
    local tSaveData = tModuleData.tSaveData
    local wx,wy = g_World._getWorldFromTile(tx,ty)
    local nDefaultFactionBehavior = (tModuleData.bHostile and Character.FACTION_BEHAVIOR.EnemyGroup) or Character.FACTION_BEHAVIOR.Friendly
    local nNewTeam = g_World.loadModule(tSaveData.nSavegameVersion, tSaveData.tWorldSaveData, wx, wy, nDefaultFactionBehavior )
    require('EventController').spawnModuleEntities(
        tEventData, tModuleData,
        {
            nDefaultTeam = nNewTeam,
            nDefaultFactionBehavior = nDefaultFactionBehavior
        })
    g_World.bSuspendFixupVisuals = true
    if tDockingTile then
        local doorX, doorY = g_World._getAdjacentTile(tDockingTile.x, tDockingTile.y, tDockingTile.nRoomDirection)
        Docking._createDoorAt(doorX,doorY)
        local nDockingCoordsX = tDockingTile.x
        local nDockingCoordsY = tDockingTile.y
        local nEmptySpaceDirection = g_World.getOppositeDirection(tDockingTile.nRoomDirection)
        local nLeftDirection = g_World.getPerpindicularDirection(nEmptySpaceDirection)
        local nRightDirection = g_World.getOppositeDirection(nLeftDirection)
        while g_World._getTileValue(nDockingCoordsX, nDockingCoordsY) == g_World.logicalTiles.SPACE do
            g_World._setTile(nDockingCoordsX, nDockingCoordsY, g_World.logicalTiles.ZONE_LIST_START)
            local leftWallX, leftWallY = g_World._getAdjacentTile(nDockingCoordsX, nDockingCoordsY, nLeftDirection)
            g_World._setTile(leftWallX, leftWallY, g_World.logicalTiles.WALL)
            local rightWallX, rightWallY = g_World._getAdjacentTile(nDockingCoordsX, nDockingCoordsY, nRightDirection)
            g_World._setTile(rightWallX, rightWallY, g_World.logicalTiles.WALL)
            nDockingCoordsX, nDockingCoordsY = g_World._getAdjacentTile(nDockingCoordsX, nDockingCoordsY, nEmptySpaceDirection)
        end
        g_World._setTile(nDockingCoordsX, nDockingCoordsY, g_World.logicalTiles.DOOR)
        Docking._createDoorAt(nDockingCoordsX, nDockingCoordsY)
    end
    local fn = ObjectList.getTypeIterater(ObjectList.ENVOBJECT,false,'DockPoint')
    local rEnvObj = fn()
    while rEnvObj do
        rEnvObj:remove()
        rEnvObj = fn()
    end
    g_World.bSuspendFixupVisuals = false
    if tDockingTile then
        local tRooms = Room.getRoomsOfTeam(nNewTeam)
        for rRoom, id in pairs(tRooms) do
            rRoom.bForceSim = true
        end
        local tChars = require('CharacterManager').getTeamCharacters(nNewTeam,true)
        for _,rChar in pairs(tChars) do
            rChar.tStatus.bForceSim=true
        end
        require('CharacterManager').updateOwnedCharacters()
    end
    return tModuleData.sModuleName
end
function Docking._queueUpBuild(tModuleData,tx,ty,sEventType, tDockingTile,bDBGForceHostile)
    Docking.tQueuedEvent = {}
    Docking.tQueuedEvent.sSetName = tModuleData.sSetName
    Docking.tQueuedEvent.sModuleName = tModuleData.sModuleName
    Docking.tQueuedEvent.tRoomTile = tModuleData.tRoomTile
    Docking.tQueuedEvent.sModuleEventName = tModuleData.sModuleEventName
    Docking.tQueuedEvent.tx = tx
    Docking.tQueuedEvent.ty = ty
    Docking.tQueuedEvent.tDockingTile = tDockingTile
    Docking.tQueuedEvent.sEventType = sEventType
    Docking.tQueuedEvent.bDBGForceHostile = bDBGForceHostile
    return Docking.tQueuedEvent
end
function Docking.attemptQueueEvent(sEventType, nEventDifficulty)
    nEventDifficulty = nEventDifficulty or 0
    local tEventRequirements = Docking.tEventRequirements[sEventType]
    local bDockingEvent = tEventRequirements.bDocking
    local tExteriorRooms = {}
    local tRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
    local nRooms = DFUtil.tableSize(tRooms)
    local bAdded = false
    for room,id in pairs(tRooms) do
        if room.bExterior and not room:isDangerous() then
            tExteriorRooms[id] = room
            bAdded = true
        end
    end
    if nRooms == 0 or (not bAdded and tEventRequirements and tEventRequirements.bDocking) then
        return
    end
    local tValidEvents = {}
    local nTotalWeight = 0
    for name,event in pairs(ModuleData[sEventType]) do
        if event.difficulty and event.difficulty > nEventDifficulty then
        elseif event.tRequiredZones then
            assert(sEventType == 'hostileDockingEvents' or sEventType == 'friendlyDockingEvents')
            event.tPotentialRooms = {}
            local bValidEvent = false
            for i,room in pairs(tExteriorRooms) do
                if event.tRequiredZones[room.zoneName] then
                    table.insert(event.tPotentialRooms, room)
                    bValidEvent = true
                end
            end
            if bValidEvent then
                table.insert(tValidEvents, event)
                nTotalWeight = nTotalWeight + (event.weight or 1)
            end
        else
            event.tPotentialRooms = {}
            for i,room in pairs(tExteriorRooms) do
                table.insert(event.tPotentialRooms, room)
            end
            table.insert(tValidEvents, event)
            nTotalWeight = nTotalWeight + (event.weight or 1)
        end
    end
    if #tValidEvents == 0 then
        return
    end
    local tPossibleEvents = Docking._selectRandomEvents(tValidEvents, nTotalWeight, Docking.nMaxEventsPerAttempt)
    for tPossibleEvent in tPossibleEvents do
        local tCandidateRoom = nil
        if #tPossibleEvent.tPotentialRooms > 0 then
            tCandidateRoom = DFUtil.arrayRandom(tPossibleEvent.tPotentialRooms)
        elseif tEventRequirements and not tEventRequirements.bDocking then
            _, tCandidateRoom = DFUtil.tableRandom(tRooms, nRooms)
        end
        local tModuleData, tx, ty, tDockingTile = Docking._testCandidateRoom(tCandidateRoom,tPossibleEvent,sEventType)
        if tModuleData then
            if not bDockingEvent then
                tDockingTile = nil
            end
            tModuleData.tRoomTile = { tCandidateRoom.nCenterTileX, tCandidateRoom.nCenterTileY, tCandidateRoom.nLevel }
            tModuleData.sModuleEventName = tPossibleEvent.sName
            return Docking._queueUpBuild(tModuleData, tx, ty, sEventType, tDockingTile)
        end
    end
end
function Docking._getNonDockedSpawnLoc(tCandidateTile,tSpawnRange)
    local nEmptySpaceDirection = g_World.getOppositeDirection(tCandidateTile.nRoomDirection)
    local nDist = math.random(tSpawnRange[1],tSpawnRange[2])
    local tx,ty = tCandidateTile.x,tCandidateTile.y
    for i=1,nDist do
        tx,ty = g_World._getAdjacentTile(tx,ty,nEmptySpaceDirection)
    end
    return g_World.clampTileToBounds(tx, ty)
end
function Docking._testTileForDockingBridge(tCandidateTile)
    if #tCandidateTile.tWallDirections == 3 and (tCandidateTile.nRoomDirection >= g_World.directions.NW and tCandidateTile.nRoomDirection <= g_World.directions.SE) then
        local nEmptySpaceDirection = g_World.getOppositeDirection(tCandidateTile.nRoomDirection)
        local nLeftDirection = g_World.getPerpindicularDirection(nEmptySpaceDirection)
        local nRightDirection = g_World.getOppositeDirection(nLeftDirection)
        local nDockingCoordsX = tCandidateTile.x
        local nDockingCoordsY = tCandidateTile.y
        local bCanBuildBridge = true
        for nBridgeIndex = 2,Docking.nBridgeLength do
            nDockingCoordsX, nDockingCoordsY = g_World._getAdjacentTile(nDockingCoordsX, nDockingCoordsY, nEmptySpaceDirection)
            if g_World._getTileValue(nDockingCoordsX, nDockingCoordsY) ~= g_World.logicalTiles.SPACE or
               g_World._getTileValue(g_World._getAdjacentTile(nDockingCoordsX, nDockingCoordsY, nLeftDirection)) ~= g_World.logicalTiles.SPACE or
               g_World._getTileValue(g_World._getAdjacentTile(nDockingCoordsX, nDockingCoordsY, nRightDirection)) ~= g_World.logicalTiles.SPACE
            then
                bCanBuildBridge = false
                break
            end
        end
        if bCanBuildBridge then
            return nDockingCoordsX, nDockingCoordsY
        end
    end
end
function Docking._testCandidateRoom(tCandidateRoom,tPossibleEvent,sEventType)
    assertdev(sEventType)
    if not sEventType then return end
    local tEventRequirements = Docking.tEventRequirements[sEventType]
    local tExteriorCopies = DFUtil.deepCopy(tCandidateRoom.tExteriors)
    local nExteriorTiles = DFUtil.tableSize(tExteriorCopies)
    if nExteriorTiles == 0 then
        if tEventRequirements.bDocking then
            return
        else
            tExteriorCopies = DFUtil.deepCopy(tCandidateRoom.tBorders)
            nExteriorTiles = DFUtil.tableSize(tExteriorCopies)
            if nExteriorTiles == 0 then return end
        end
    end
    local nMaxTests = (tEventRequirements.bDocking and math.min(Docking.nMaxTestTilesPerRoom, nExteriorTiles)) or 1
    local tModuleData
    for nTileIndex = 1, nMaxTests do
        local tCandidateTile, nCandidateIndex = DFUtil.tableRandom(tExteriorCopies, nExteriorTiles)
        tExteriorCopies[nCandidateIndex] = nil
        nExteriorTiles = nExteriorTiles - 1
        local nDockingCoordsX, nDockingCoordsY
        if tEventRequirements.bDocking then
            nDockingCoordsX, nDockingCoordsY = Docking._testTileForDockingBridge(tCandidateTile)
        else
            nDockingCoordsX, nDockingCoordsY = Docking._getNonDockedSpawnLoc(tCandidateTile,tEventRequirements.tSpawnRange)
        end
        if nDockingCoordsX then
            if not tEventRequirements.bLoadModule then
                tModuleData = {}
            elseif not tModuleData then
                tModuleData = DFUtil.deepCopy(Docking.tLoadedModules[sEventType][tPossibleEvent.sName])
            end
            local spawnTX,spawnTY = Docking._testModuleFit(tPossibleEvent, tModuleData, tCandidateTile, nDockingCoordsX,nDockingCoordsY, sEventType)
            if spawnTX then
                return tModuleData, spawnTX,spawnTY, tCandidateTile
            end
        end
    end
end
function Docking._selectRandomEvents(tPossibleEvents, totalWeight, nEvents)
    local i = 1
    local tEvent = tPossibleEvents[i]
    local weight = tEvent.weight or 1
    return function()
        while nEvents > 0 do
            local x = totalWeight * (1 - math.pow(math.random(), 1.0 / nEvents))
            totalWeight = totalWeight - x
            while x > weight do
                x = x - weight
                i = i + 1
                tEvent = tPossibleEvents[i]
                weight = (tEvent.weight or 1)
            end
            weight = weight - x
            nEvents = nEvents - 1
            return tEvent
        end
    end
end
function Docking._isIsoAreaSpace(sEventType, lowerLeftX, lowerLeftY, lowerRightX, lowerRightY, upperRightX, upperRightY, upperLeftX, upperLeftY)
    local nTilesHoriz = math.floor(((lowerRightX - lowerLeftX) * 2) + 0.5)
    local nTilesVert = math.floor((upperLeftY - lowerLeftY) + 0.5)
    local tEventRequirements = Docking.tEventRequirements[sEventType]
    local bAsteroidsAllowed = tEventRequirements.bAllowSpawnInAsteroid
    local baseX = lowerLeftX
    local baseY = lowerLeftY
    for i = 1,nTilesHoriz do
        local testX = baseX
        local testY = baseY
        for j = 1,nTilesVert do
            if testX < g_World.CHARACTER_SAFETY_TOLERANCE or testY < g_World.CHARACTER_SAFETY_TOLERANCE
                    or testX > g_World.width - g_World.CHARACTER_SAFETY_TOLERANCE or testY > g_World.height - g_World.CHARACTER_SAFETY_TOLERANCE then
                return false
            end
            local tileValue = g_World._getTileValue(testX, testY)
            if not tileValue or tileValue == 0 or (tileValue ~= g_World.logicalTiles.SPACE and (not bAsteroidsAllowed or not Asteroid.isAsteroid(tileValue))) then
                return false
            end
            if CommandObject.getConstructionAtTile(testX,testY) then
                return false
            end
            testX, testY = g_World._getAdjacentTile(testX, testY, g_World.directions.NW)
        end
        baseX, baseY = g_World._getAdjacentTile(baseX, baseY, g_World.directions.NE)
    end
    return true
end
return Docking
