local DFFile = require('DFCommon.File')
local Util = require('DFCommon.Util')
local Class = require('Class')
local SeqCommand = require('SeqCommand')
local ScCreateEntity = Class.create(SeqCommand)
local Scene = require('Scene')
local Entity = require('Entity')
local EntityManager = require('EntityManager')
local GameRules = require('GameRules')
local AssetAnalysis = nil
local kPositonScale = 300
ScCreateEntity.ActorName = ""
ScCreateEntity.PrototypeName = ""
ScCreateEntity.Position = { 0, 0, 0 }
ScCreateEntity.FinalPosition = nil
ScCreateEntity.SceneLayerName = ""
ScCreateEntity.LocatorName = ""
ScCreateEntity.UseCurrentPosition = false
ScCreateEntity.ApplyFinalPosition = true
ScCreateEntity.SortActorName = ""
local DFSchema = require('DFCommon.DFSchema')
local tFields = Util.deepCopy(SeqCommand.rSchema.tFieldSchemas)
tFields['ActorName'] = DFSchema.entityName(nil, "Name of the actor", "ControllingActor")
tFields['PrototypeName'] = DFSchema.prototype(nil, "Name of the prototype to spawn")
tFields['Position'] = DFSchema.vec3({ 0, 0, 0 }, "The location of the actor")
tFields['FinalPosition'] = DFSchema.vec3({ 0, 0, 0 }, "The final location of the actor")
tFields['SceneLayerName'] = DFSchema.string(nil, "(optional) Name of the layer in which to spawn the entity")
tFields['LocatorName'] = DFSchema.entityName(nil, "(optional) Name of the locator to create the actor at")
tFields['UseCurrentPosition'] = DFSchema.bool(false, "(optional) Use the current position of the entity")
tFields['ApplyFinalPosition'] = DFSchema.bool(true, "(optional) Should the final position be applied or ignored")
tFields['SortActorName'] = DFSchema.entityName(nil, "(optional) Name of the actor to (micro) sort with")
SeqCommand.nonBlocking(tFields)
SeqCommand.metaPriority(tFields, 10)
ScCreateEntity.rSchema = DFSchema.object(
    tFields,
    "Creates a new instance of the specified protoype at the given location."
)
SeqCommand.addEditorSchema('ScCreateEntity', ScCreateEntity.rSchema)
ScCreateEntity.ENTITY_UNKNOWN = 0
ScCreateEntity.ENTITY_USE_EXISTING = 1
ScCreateEntity.ENTITY_LOCATOR_RELATIVE = 2
ScCreateEntity.ENTITY_SCENELAYER_RELATIVE = 3
function ScCreateEntity:onCreated()
    self.Position = { 0, 0, 0 }
    self.FinalPosition = nil
end
function ScCreateEntity:onAnalyzeAssets(rClump)
    if not AssetAnalysis then
        AssetAnalysis = require('AssetAnalysis')
    end
    local sID = "Munged/" .. self.rSequence:_getFullName()
    AssetAnalysis.addPrototype(self.PrototypeName, sID, rClump, self.ActorName, self.SceneLayerName, true)
end
function ScCreateEntity:onPreloadCutscene(rAssetSet)
    self.entityMode = ScCreateEntity.ENTITY_UNKNOWN
    self.rEntity = EntityManager.getEntityNamed( self.ActorName )
    if self.rEntity ~= nil then
        if self:_getDebugFlags().DebugExecution then
            Trace(TT_Gameplay, "Reusing entity " .. self.ActorName)
        end
        self.bDestroyEntity = false
        self.entityMode = ScCreateEntity.ENTITY_USE_EXISTING
        local rLocatorEntity = self:_getLocatorEntity()
        if rLocatorEntity ~= nil then
            self.entityMode = ScCreateEntity.ENTITY_LOCATOR_RELATIVE
        end
        if rLocatorEntity == nil and #self.SceneLayerName > 0 then
            local rSceneLayer = Scene.CurrentScene:getNamedLayer(self.SceneLayerName)
            if rSceneLayer ~= nil then
                self.entityMode = ScCreateEntity.ENTITY_SCENELAYER_RELATIVE
                local rEntitySceneLayer = self.rEntity:getSceneLayer()
                if rEntitySceneLayer ~= rSceneLayer then
                    self.rEntity:setSceneLayer( rSceneLayer )
                end
            end
        end
        if GameRules:getPlayerEntity() == self.rEntity then
            self.rSequence.bUsesPlayerEntity = true
        end
        return
    end
    self.bDestroyEntity = true
    if self:_getDebugFlags().DebugExecution then
        Trace(TT_Gameplay, "Instantiating prototype " .. self.PrototypeName .. " as entity " .. self.ActorName)
    end
    if not (#self.LocatorName > 0 or #self.SceneLayerName > 0) then
        local scStartShot = self:getSibling("ScStartShot")
        if scStartShot then
            self.LocatorName = scStartShot.LocatorName
            self.SceneLayerName = scStartShot.SceneLayerName
        end
    end
    local rLocatorEntity = self:_getLocatorEntity()
    if rLocatorEntity ~= nil then
        self.entityMode = ScCreateEntity.ENTITY_LOCATOR_RELATIVE
    end
    local rSceneLayer = nil
    if rLocatorEntity == nil and #self.SceneLayerName > 0 then
        rSceneLayer = Scene.CurrentScene:getNamedLayer(self.SceneLayerName)
        if rSceneLayer ~= nil then
            self.entityMode = ScCreateEntity.ENTITY_SCENELAYER_RELATIVE
        end
    end
    if rLocatorEntity == nil and rSceneLayer == nil then
        Trace(TT_Error, "Couldn't create entity " .. self.ActorName .. " because neither locator nor scene-layer exist")
        return
    end
    self.rEntity = Entity.createEntity(rLocatorEntity, self.PrototypeName, self.ActorName, rAssetSet, rSceneLayer, nil, true)
    self.bShowEntity = true
    self.rEntity:setVisible(false)
end
function ScCreateEntity:setEntityLoc(rEntity, tLoc)
    rEntity.rProp:setLoc( unpack(tLoc) )
    rEntity.rProp:forceUpdate()
end
function ScCreateEntity:onExecute()
    local rEntity = self.rEntity
    if rEntity ~= nil then
        if self:_getDebugFlags().DebugExecution then
            Trace(TT_Gameplay, "Materializing entity " .. self.ActorName)
        end
        if self.bShowEntity == true then
            rEntity:setVisible(true)
        end
        if self.bDestroyEntity or not self.UseCurrentPosition then
            local x, y, z = rEntity.rProp:getLoc()
            local ox, oy, oz = self:_getScaledLocation(self.Position)
            local fx, fy, fz = self:_getScaledLocation(self.FinalPosition)
            self.tOrgLoc = { x, y, z }
            x = 0
            y = 0
            z = 0
            if self.entityMode == ScCreateEntity.ENTITY_LOCATOR_RELATIVE then
                local rLocatorEntity = self:_getLocatorEntity()
                assert(rLocatorEntity)
                x, y, z = rLocatorEntity.rProp:getLoc()
            end
            self.tFinalLoc = { x + fx, y + fy, z + fz }
            x = x + ox
            y = y + oy
            z = z + oz
            self:setEntityLoc( self.rEntity, {x, y, z} )
            if self.entityMode ~= ScCreateEntity.ENTITY_USE_EXISTING then
                if rEntity:getState() ~= Entity.STATE_READY then
                    rEntity:complete()
                    rEntity:sceneReady()
                end
                self.entityMode = ScCreateEntity.ENTITY_USE_EXISTING
            end
        end
        local sEntityName = rEntity:getName()
        if sEntityName ~= self.ActorName then
            Trace(TT_Warning, "Entity name " .. self.ActorName .. " already exists. Updating to " .. sEntityName)
            self.rSequence:_updateActorName(self.ActorName, sEntityName)
            self.ActorName = sEntityName
        end
        self:_addRemoveExternalMeshes(true)
        self:_prepGameplaySystems( rEntity )
    else
        Trace(TT_Error, "Couldn't create sequence entity: " .. self.ActorName .. " (Prototype: " .. self.PrototypeName .. " )")
    end
end
function ScCreateEntity:onCleanup()
    if self.rEntity ~= nil then
        self:_addRemoveExternalMeshes(false)
        if self.bDestroyEntity then
            if self:_getDebugFlags().DebugExecution then
                Trace(TT_Gameplay, "Deleting entity " .. self.ActorName)
            end
            self.rEntity:destroy()
        elseif not self.UseCurrentPosition then
            local tFinalLoc = self.tOrgLoc
            if self.FinalPosition ~= nil and self.ApplyFinalPosition then
                tFinalLoc = self.tFinalLoc
            end
            if tFinalLoc then
                self:setEntityLoc( self.rEntity, tFinalLoc )
            end
        end
        self.rEntity = nil
        if self.bCleanUpControls then
            GameRules:setLockPlayerControls(false)
        end
    end
end
function ScCreateEntity:_prepGameplaySystems( rEntity )
    if rEntity.CoNavigator then
        rEntity.CoNavigator:cancelNavigation()
    end
    if rEntity == GameRules.getPlayerEntity() then
        self.bCleanUpControls = true
        GameRules:setLockPlayerControls(true)
    end
end
function ScCreateEntity:_getLocatorEntity()
    local rLocatorEntity = nil
    if #self.LocatorName > 0 then
        rLocatorEntity = EntityManager.getEntityNamed( self.LocatorName )
        if rLocatorEntity == nil then
            Trace(TT_Warning, "Couldn't find locator: " .. self.LocatorName)
        end
    end
    return rLocatorEntity
end
function ScCreateEntity:_getScaledLocation(tUnscaledLoc)
    if tUnscaledLoc ~= nil then
        local ox, oy, oz = unpack(tUnscaledLoc)
        ox = ox * kPositonScale
        oy = oy * kPositonScale
        oz = oz * kPositonScale
        if self.entityMode == ScCreateEntity.ENTITY_USE_EXISTING or self.entityMode == ScCreateEntity.ENTITY_SCENELAYER_RELATIVE then
            local lz = self.rEntity:getSceneLayer().ZDepth
            oz = oz - lz
        end
        return ox, oy, oz
    end
    return 0, 0, 0
end
function ScCreateEntity:_addRemoveExternalMeshes(bAdd)
    local rEntity = self.rEntity
    if rEntity ~= nil then
        local coRig = rEntity.CoRig
        if coRig ~= nil then
            if self.SortActorName ~= nil and #self.SortActorName > 0 then
                local rSortActor = EntityManager.getEntityNamed( self.SortActorName )
                if rSortActor ~= nil and rSortActor.CoRig ~= nil then
                    if bAdd then
                        rSortActor.CoRig:addExternalRig(coRig)
                    else
                        rSortActor.CoRig:removeExternalRig(coRig)
                    end
                end
            end
        end
    end
end
return ScCreateEntity
