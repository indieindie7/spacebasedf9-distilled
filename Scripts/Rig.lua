local DFGraphics = require('DFCommon.Graphics')
local DFFile = require('DFCommon.File')
local DFUtil = require('DFCommon.Util')
local DFMath = require('DFCommon.Math')
local DFMoaiDebugger = require("DFMoai.Debugger")
local Renderer = require('Renderer')
local Character = require('CharacterConstants')
local SeqCommand = require('SeqCommand')
local DataCache = require('DFCommon.DataCache')
local AssetSet = require('DFCommon.AssetSet')
local Profile = require('Profile')
local Rig = {}
Rig.bDBGExtendedProfiler = false
local gAllRigs = {}
setmetatable(gAllRigs, {__mode = 'k'})
function Rig.new( rEntity, tRigArgs, rAssetSet )
    local self = DFUtil.deepCopy( Rig )
    self.NO_DEEP_COPY = true
	self.rEntity = rEntity
	self.sResource = tRigArgs.sResource
	if not self.sResource then
		Trace(TT_Warning, "No rig file specified!" )
	else
		self:_init(rAssetSet, tRigArgs)
	end
    return self
end
function Rig:_init(rAssetSet, tRigArgs)
    assert(gAllRigs[self] == nil)
    gAllRigs[self] = 1
    local filePath = DFFile.getAssetPath( self.sResource )
	local tData = DataCache.getData("rig", filePath)
	if tData == nil then
        Trace(TT_Error, "Trying to load invalid rig: " .. self.sResource)
		return
	end
    if tData.rRigData == nil then
        local binaryRigFilename = DFFile.stripSuffix(filePath)
        binaryRigFilename = binaryRigFilename .. ".brig"
        tData.rRigData = DFRigData.new()
        tData.rRigData:loadAsync(binaryRigFilename)
    end
	self._bIsActive = false
	self.tJointMap = {}
	self.tMeshMap = {}
	self.tTextures = {}
    self.tMaterials = {}
	self.rMainMesh = nil
    self.tMeshVisibilityOverrides = {}
    self.numMeshVisibilityOverrides = 0
	self.tAnimationAttachments = {}
    self.tAnimationEvents = {}
    self.nextAnimEventIdx = 0
    self.tActiveAnims = {}
	if not tData.tScale then
		if tData.scale then
			self.tScale = { tData.scale, tData.scale, tData.scale }
		else
			self.tScale = { 1, 1, 1 }
		end
	end
	self.scaleX = 1
	self.rUnscaledRootJointProp = MOAITransform.new()
    self.rUnscaledRootJointProp:setAttrLink(MOAIProp.INHERIT_LOCROT, self.rEntity.rProp, MOAIProp.TRANSFORM_TRAIT)
	self.rScaleJointProp = MOAITransform.new()
    self.rScaleJointProp:setScl(self.tScale[1], self.tScale[2], self.tScale[3])
    self.rScaleJointProp:setAttrLink(MOAIProp.INHERIT_LOCROT, self.rUnscaledRootJointProp, MOAIProp.TRANSFORM_TRAIT)
    self.rScaleJointProp:setAttrLink(MOAIProp.OFFSET_SCL, self.rEntity.rProp, MOAIProp.OFFSET_TRANSFORM_TRAIT)
    self.bUseEntityOffsetScale = true
    self.bAllowEntityNavigation = true
    self.rRootJoint = {}
	self.rRootJoint.rProp = MOAITransform.new()
    self.rRootJoint.rProp:setAttrLink(MOAIProp.INHERIT_TRANSFORM, self.rScaleJointProp, MOAIProp.TRANSFORM_TRAIT)
	self.rTrackerOriginTrans = MOAITransform.new()
    self.rTrackerOriginTrans:setScl(self.tScale[1], -self.tScale[2], self.tScale[3])
	self.rTrackerTrans = MOAITransform.new()
    self.rTrackerTrans:setAttrLink(MOAIProp.INHERIT_TRANSFORM, self.rTrackerOriginTrans, MOAIProp.TRANSFORM_TRAIT)
    self.bHasRootMotion = false
    self.numJoints = 0
    self.numMeshes = 0
    self.numSubsets = 0
    tData.rRigData:sync()
    self:_initializeJointHierarchy(tData)
	self:_createMeshes(tData, tRigArgs, rAssetSet)
    self:_initializeAnimController(tData, tRigArgs)
    self:_setTextureReplacements(tRigArgs)
end
function Rig:onAnalyzeAssets(rClump, sID)
	local numTextures = #self.tTextures
	for i=1,numTextures do
        local rTexture = self.tTextures[i]
        rClump:addTexture(rTexture.path, sID)
	end
	local numMaterials = #self.tMaterials
    for i=1,numMaterials do
        local rMaterial = self.tMaterials[i]
        rClump:addMaterial(rMaterial.path, sID)
    end
    local sFilename = DFFile.getAssetPath(self.sResource)
    if MOAIFileSystem.checkFileExists(sFilename) then
        local tData = dofile(sFilename)
        if tData then
            local tMeshDescs = tData.tMeshes
            local numMeshes = #tMeshDescs
            for i=1,self.numMeshes do
                local tMesh = tMeshDescs[i]
                if tMesh.tTriMesh then
                    local tSubsets = tMesh.tTriMesh.tSubsets
                    local numSubsets = #tSubsets
                    for j=1,numSubsets do
                        local tSubset = tSubsets[j]
                        rClump:addTexture(tSubset.sTexture, sID)
                        if tSubset.materialIdx then
                            local sMaterial = tMesh.tTriMesh.tMaterials[tSubset.materialIdx]
                            rClump:addMaterial(sMaterial, sID)
                        end
                    end
                end
            end
        end
    end
end
function Rig:unload()
    assert(gAllRigs[self])
    gAllRigs[self] = nil
	self:deactivate()
	self.tJointMap = {}
	self.tMeshMap = {}
	local numTextures = #self.tTextures
	for i=1,numTextures do
	end
	self.tTextures = {}
	local numMaterials = #self.tMaterials
    for i=1,numMaterials do
        local rMaterial = self.tMaterials[i]
        DFGraphics.unloadMaterial(rMaterial)
    end
    self.tMaterials = {}
    self.rMainMesh:setAnimController(nil)
	self.rMainMesh = nil
	self.tAnimationAttachments = {}
    self.tActiveAnims = {}
    self.rAnimController:stop()
    self.rAnimController:clearLayers(DFAnimController.PRIORITY_MIN)
    self.rAnimController:setTrackerTransform(nil)
    self.rAnimController = nil
end
function Rig:activate( )
	if self._bIsActive then
		return
	end
    if self.tMeshMap ~= nil then
        for sMeshName, tMeshData in pairs(self.tMeshMap) do
            tMeshData.rMesh:setCullMode(MOAIProp.CULL_BACK)
            self.rEntity:addProp(tMeshData.rMesh)
            tMeshData.rMesh:start()
            tMeshData.rMesh:setVisible(true)
        end
    end
    self:resumeAnimations()
	self:update(0)
	self._bIsActive = true
end
function Rig:deactivate( )
	if not self._bIsActive then
		return
	end
    local tAnimNames = {}
    if self.tActiveAnims then
        for sAnimName,rAnim in pairs(self.tActiveAnims) do
            table.insert(tAnimNames, sAnimName)
        end
    end
    local numAnims = #tAnimNames
    for i=1,numAnims do
        self:stopAnimation(tAnimNames[i])
    end
    if self.tMeshMap then
        for sMeshName, tMeshData in pairs(self.tMeshMap) do
            tMeshData.rMesh:stop()
            tMeshData.rMesh:setVisible(false)
            self.rEntity:removeProp(tMeshData.rMesh)
        end
    end
    self:pauseAnimations()
	self._bIsActive = false
end
function Rig:isActive()
	return self._bIsActive
end
function Rig:getJointProp( sName )
    local tJointData = self.tJointMap[sName]
    if tJointData ~= nil then
        if tJointData.rTransform == nil then
            tJointData.rTransform = self.rAnimController:getLinkedJointTransform(tJointData.idx)
            if tJointData.rTransform == nil then
                tJointData.rTransform = MOAITransform.new()
                self.rAnimController:setLinkedJointTransform(tJointData.idx, tJointData.rTransform)
            end
        end
        return tJointData.rTransform
    end
    return nil
end
function Rig:setJointLoc( sName, tLoc, sLayerName )
    local tJointData = self.tJointMap[sName]
    if tJointData ~= nil then
        local x, y, z
        if type(tLoc) == 'table' then
            x, y, z = unpack(tLoc)
        else
            x = tLoc
        end
        self.rAnimController:setJointLoc(sLayerName, tJointData.idx, x, y, z)
    end
end
function Rig:setJointRot( sName, tRot, sLayerName )
    local tJointData = self.tJointMap[sName]
    if tJointData ~= nil then
        local x, y, z
        if type(tRot) == 'table' then
            x, y, z = unpack(tRot)
        else
            x = tRot
        end
        self.rAnimController:setJointRot(sLayerName, tJointData.idx, x, y, z)
    end
end
function Rig:setJointScl( sName, tScl, sLayerName )
    local tJointData = self.tJointMap[sName]
    if tJointData ~= nil then
        local x, y, z
        if type(tScl) == 'table' then
            x, y, z = unpack(tScl)
        else
            x = tScl
        end
        self.rAnimController:setJointScl(sLayerName, tJointData.idx, x, y, z)
    end
end
function Rig:playAnimation(tAnimationData)
    if Rig.bDBGExtendedProfiler then
        Profile.enterScope( "Rig:playAnimation" )
    end
    local animPriority = DFAnimController.PRIORITY_NORMAL
    if tAnimationData.animPriority ~= nil then
        animPriority = tAnimationData.animPriority
    end
    if animPriority == DFAnimController.PRIORITY_NORMAL then
        self.scaleX = 1
        if tAnimationData.bFlipX then
            self.scaleX = -1
        end
    end
    if tAnimationData.bPlayOnce then
        tAnimationData.playbackMode = MOAITimer.NORMAL
    else
        tAnimationData.playbackMode = MOAITimer.LOOP
    end
    local sAnimName = tAnimationData.sAnimPath
    if not tAnimationData.bPlayOnce and self.tActiveAnims[sAnimName] ~= nil then
        if Rig.bDBGExtendedProfiler then
            Profile.leaveScope( "Rig:playAnimation" )
        end
        return
    end
	local sAnimFile = DFFile.getAssetPath(tAnimationData.sAnimPath)
	local tAnimData = DataCache.getData("anim", sAnimFile)
	if tAnimData == nil then
        if Rig.bDBGExtendedProfiler then
            Profile.leaveScope( "Rig:playAnimation" )
        end
		return
	end
    if not tAnimData.rAnimData then
        if tAnimData.sRig ~= self.sResource then
            Trace(TT_Error, string.format("Rig and animation don't match!\nRig : %s\nAnim: %s", tostring(self.sResource), tostring(tAnimData.sRig)))
            self.bDBG_NoAnim = true
        end
        local binaryAnimFilename = DFFile.stripSuffix(sAnimFile)
        binaryAnimFilename = binaryAnimFilename .. ".banim"
        tAnimData.rAnimData = DFAnimData.new()
        tAnimData.rAnimData:loadAsync(binaryAnimFilename)
    end
    if animPriority == DFAnimController.PRIORITY_NORMAL then
        self:_resetToBindPosition()
        self.tInitialTrackerLoc = nil
        self.tFinalTrackerLoc = nil
        local bUseEntityScaling = tAnimationData.bUseEntityScaling
        if tAnimData.bIsScaled == true and not tAnimationData.fnMoveHandler then
            if not bUseEntityScaling then
                self:_enableEntityScaling(false)
            end
            self:_enableEntityNavigation(false)
        end
    else
        self:clearOverlayAnims()
    end
    tAnimationData.animPriority = animPriority
    self.tCurrentAnimationData = DFUtil.deepCopy(tAnimationData)
    self.tActiveAnims[sAnimName] = self:_addAnimationLayer(tAnimationData, tAnimData, animPriority)
    if animPriority == DFAnimController.PRIORITY_NORMAL then
        if tAnimData.deltaTransSpeed ~= nil then
            self.tActiveAnims[sAnimName].deltaTransSpeed = tAnimData.deltaTransSpeed * 300
            self.tActiveAnims[sAnimName].curAnimSpeed = 1.0
        end
        local rAssetSet = AssetSet.new()
        assert(#self.tAnimationAttachments == 0)
        local tAnimAttachments = {}
        if tAnimData.tProps ~= nil and #tAnimData.tProps > 0 then
        end
        assert(#self.tAnimationEvents == 0)
        self.nextAnimEventIdx = 0
        if tAnimData.tAnimEvents and #(tAnimData.tAnimEvents) > 0 then
            for _, tMetaCommand in ipairs( tAnimData.tAnimEvents ) do
                for sCommandType,tCommandAttributes in pairs(tMetaCommand) do
                    local rCmd = SeqCommand.createCommand(sCommandType, tCommandAttributes, self)
                    if rCmd ~= nil then
                        rCmd:setRig(self)
                        table.insert(self.tAnimationEvents, rCmd)
                        rCmd:preloadCutscene(rAssetSet)
                    end
                end
            end
            self.nextAnimEventIdx = 1
        end
        local numFramesStalled = 0
        while not rAssetSet:isLoaded() do
            coroutine.yield()
            numFramesStalled = numFramesStalled + 1
        end
        if numFramesStalled > 0 then
            Trace(TT_Warning, "Prop assets or anim events aren't preloaded for animation: " .. sAnimFile)
        end
        local numAnimAttachments = #tAnimAttachments
        for i=1,numAnimAttachments do
            local rPropRig = tAnimAttachments[i]
            rPropRig:activate()
            local tOffsetLoc = rPropRig.tPropData.tLoc
            if tOffsetLoc == nil then
                tOffsetLoc = { 0, 0, 0 }
            end
            local tOffsetRot = rPropRig.tPropData.tRot
            if tOffsetRot == nil then
                tOffsetRot = { 0, 0, 0 }
            end
            local tScale = rPropRig.tPropData.tScale
            if tScale == nil then
                tScale = { 1, 1, 1 }
            end
            self:_attach(true, rPropRig, rPropRig.tPropData.sJoint, tOffsetLoc, tOffsetRot, tScale)
        end
    end
    if Rig.bDBGExtendedProfiler then
        Profile.leaveScope( "Rig:playAnimation" )
    end
end
function Rig:stopAnimation(sAnimationFile)
    local sAnimName = sAnimationFile
    if self.tActiveAnims[sAnimName] == nil then
        return
    end
    local animPriority = self.rAnimController:getLayerPriority(sAnimName)
    self.rAnimController:removeLayer(sAnimName)
    if animPriority == DFAnimController.PRIORITY_NORMAL then
        self:_unlinkTracker()
        self:_enableEntityScaling(true)
        self:_enableEntityNavigation(true)
        while #self.tAnimationAttachments > 0 do
            local rPropRig = self.tAnimationAttachments[1]
            self:_detach(true, rPropRig)
            rPropRig:unload()
        end
        local numAnimEvents = #self.tAnimationEvents
        if numAnimEvents > 0 then
            for i=1,numAnimEvents do
                local rAnimEvent = self.tAnimationEvents[i]
                rAnimEvent:cleanup()
                rAnimEvent.rSequence = nil
            end
            self.tAnimationEvents = {}
        end
    end
    self.tActiveAnims[sAnimName] = nil
end
function Rig:forceAnimLoad(tAnimationData)
	local sAnimFile = DFFile.getAssetPath(tAnimationData.sAnimPath)
	local tAnimData = DataCache.getData("anim", sAnimFile)
    if tAnimData == nil then
        assertdev(false)
        return
    end
    if not tAnimData.rAnimData then
        if tAnimData.sRig ~= self.sResource then
            Trace(TT_Error, string.format("Rig and animation don't match!\nRig : %s\nAnim: %s", tostring(self.sResource), tostring(tAnimData.sRig)))
            self.bDBG_NoAnim = true
        end
        local binaryAnimFilename = DFFile.stripSuffix(sAnimFile)
        binaryAnimFilename = binaryAnimFilename .. ".banim"
        tAnimData.rAnimData = DFAnimData.new()
        tAnimData.rAnimData:loadAsync(binaryAnimFilename)
	end
	tAnimData.rAnimData:sync()
	return tAnimData
end
function Rig:getAnimDuration(tAnimationData)
	local tAnimData = self:forceAnimLoad(tAnimationData)
	return tAnimData.rAnimData:getDuration()
end
function Rig:clearOverlayAnims()
    for sAnimName,_ in pairs(self.tActiveAnims) do
        local animPriority = self.rAnimController:getLayerPriority(sAnimName)
        if animPriority == DFAnimController.PRIORITY_OVERLAY then
            self.rAnimController:removeLayer(sAnimName)
            self.tActiveAnims[sAnimName] = nil
        end
    end
end
function Rig:pauseAnimations()
    self.rAnimController:stop()
end
function Rig:resumeAnimations()
    self.rAnimController:start()
end
function Rig:setAnimSpeed(animSpeed, bDeltaTransRelative)
    for sAnimName,tAnim in pairs(self.tActiveAnims) do
        local animPriority = self.rAnimController:getLayerPriority(sAnimName)
        if animPriority == DFAnimController.PRIORITY_NORMAL then
            local bSetSpeed = not bDeltaTransRelative
            if bDeltaTransRelative == true and tAnim.deltaTransSpeed ~= nil then
                local relativeSpeed = animSpeed / tAnim.deltaTransSpeed
                if math.abs(tAnim.curAnimSpeed - relativeSpeed) > 0.00001 then
                    animSpeed = relativeSpeed
                    tAnim.curAnimSpeed = relativeSpeed
                    bSetSpeed = true
                end
            end
            if bSetSpeed then
                self.rAnimController:setAnimSpeed(DFAnimController.PRIORITY_NORMAL, animSpeed)
            end
        end
    end
end
function Rig:setRigFlipped(bSetting)
    local bRigFlipped = self.scaleX == -1
    if bRigFlipped == bSetting then
        return
    end
    self.scaleX = 1
    if bSetting then
        self.scaleX = -1
    end
    self:_updateRootProp()
end
function Rig:addMeshVisibilityOverrides(tMeshVisibilityOverrides)
    for sMeshName,tSubsetVisibility in pairs(tMeshVisibilityOverrides) do
        if self.tMeshVisibilityOverrides[sMeshName] == nil then
            self.tMeshVisibilityOverrides[sMeshName] = {}
        end
        local tSubsetVisibilityOverrides = self.tMeshVisibilityOverrides[sMeshName]
        for sSubsetName,visibilityCondition in pairs(tSubsetVisibility) do
            if tSubsetVisibilityOverrides[sSubsetName] == nil and visibilityCondition ~= nil then
                self.numMeshVisibilityOverrides = self.numMeshVisibilityOverrides + 1
            end
            tSubsetVisibilityOverrides[sSubsetName] = visibilityCondition
        end
    end
end
function Rig:attach(otherRig, sJointName, tOffsetPosition, tOffsetRotation, tScale)
	self:_attach(false, otherRig, sJointName, tOffsetPosition, tOffsetRotation, tScale)
end
function Rig:detach(otherRig)
	self:_detach(false, otherRig)
end
function Rig:_addAnimationLayer(tAnimationData, tAnimData, layerPriority)
    if self.bDBG_NoAnim then return end
    tAnimData.rAnimData:sync()
    local playbackMode = MOAITimer.NORMAL
    if tAnimationData.playbackMode then
        playbackMode = tAnimationData.playbackMode
    end
    if tAnimData.playbackMode then
        playbackMode = tAnimData.playbackMode
    end
    local numExtraAnimTracks = 0
    local omitDeltaTransTracks = false
    if not tAnimationData.bUseEntityScaling then
        self:_linkTracker(tAnimationData.fnMoveHandler)
        omitDeltaTransTracks = true
    end
    local tAnimLayerCmds = {}
    table.insert( tAnimLayerCmds, { tAnimationData.sAnimPath, tAnimData.rAnimData, playbackMode, numExtraAnimTracks, layerPriority, omitDeltaTransTracks } )
    local layerID = self.rAnimController:addLayerAndTracks(tAnimLayerCmds)
    if tAnimationData.bApplyFinalTrackerLocation == true then
        self.tFinalTrackerLoc = tAnimData.tFinalDeltaTransLoc
    end
    local tAnim = {}
    tAnim.layerID = layerID
    return tAnim
end
function Rig:_attach(bIsAnimAttachment, otherRig, sJointName, tOffsetPosition, tOffsetRotation, tScale)
    if not otherRig.rRootJoint then return end
    tOffsetPosition = tOffsetPosition or {0,0,0}
    tOffsetRotation = tOffsetRotation or {0,0,0}
    tScale = tScale or {1,1,1}
    local rAttachmentJointProp = self:getJointProp(sJointName)
    if rAttachmentJointProp ~= nil then
        local rOtherAttachmentJointProp = otherRig.rRootJoint.rProp
        rOtherAttachmentJointProp:clearAttrLink(MOAIProp.INHERIT_TRANSFORM)
        rOtherAttachmentJointProp:clearAttrLink(MOAIProp.INHERIT_LOCROT)
        rOtherAttachmentJointProp:setLoc(unpack(tOffsetPosition))
        rOtherAttachmentJointProp:setRot(unpack(tOffsetRotation))
        tScale = tScale or {1,1,1}
        rOtherAttachmentJointProp:setScl(unpack(tScale))
        rOtherAttachmentJointProp:setAttrLink(MOAIProp.INHERIT_TRANSFORM, rAttachmentJointProp, MOAIProp.TRANSFORM_TRAIT)
        rOtherAttachmentJointProp:forceUpdate()
        otherRig.rAnimController:updateLast()
		if self.rMainMesh ~= nil then
            for _, tMeshData in pairs(otherRig.tMeshMap) do
				if tMeshData.rMesh ~= nil then
					self.rMainMesh:addExternalMesh(tMeshData.rMesh)
				end
			end
		end
		if bIsAnimAttachment then
			table.insert(self.tAnimationAttachments, otherRig)
		end
    else
        Trace(TT_Warning, "Attachment failed. Couldn't find joint: " .. sJointName)
    end
end
function Rig:_detach(bIsAnimAttachment, otherRig)
	if bIsAnimAttachment then
		local idxPropRig = self:_findAnimationAttachment(otherRig)
		if idxPropRig > 0 then
			table.remove(self.tAnimationAttachments, idxPropRig)
		else
			Trace(TT_Warning, "Couldn't find animation attachment")
			assert(0)
		end
	end
    local rOtherAttachmentJointProp = otherRig.rRootJoint.rProp
    rOtherAttachmentJointProp:clearAttrLink(MOAIProp.INHERIT_TRANSFORM)
    rOtherAttachmentJointProp:clearAttrLink(MOAIProp.INHERIT_LOCROT)
    if not bIsAnimAttachment then
        local rOtherAttachmentParentJointProp = otherRig.rScaleJointProp
        rOtherAttachmentJointProp:setAttrLink(MOAIProp.INHERIT_TRANSFORM, rOtherAttachmentParentJointProp, MOAIProp.TRANSFORM_TRAIT)
    end
    rOtherAttachmentJointProp:forceUpdate()
	if self.rMainMesh ~= nil then
        for _, tMeshData in pairs(otherRig.tMeshMap) do
			if tMeshData.rMesh ~= nil then
				self.rMainMesh:removeExternalMesh(tMeshData.rMesh)
			end
		end
	end
end
function Rig:_findAnimationAttachment(otherRig)
	local numAnimAttachments = #self.tAnimationAttachments
	for i=1,numAnimAttachments do
		local rPropRig = self.tAnimationAttachments[i]
		if rPropRig == otherRig then
			return i
		end
	end
	return 0
end
function Rig:update(deltaTime)
    if Rig.bDBGExtendedProfiler then
        Profile.enterScope( "Rig:update" )
    end
    if not self.rRootJoint then return end
    self:_updateShaderValues()
	self:_updateRootProp()
    local numAnimAttachments = #self.tAnimationAttachments
    for i=1,numAnimAttachments do
        local rPropRig = self.tAnimationAttachments[i]
        rPropRig:update(deltaTime)
    end
    if self.nextAnimEventIdx > 0 then
        local numAnimEvents = #self.tAnimationEvents
        local animTime = self.rAnimController:getAnimTime(DFAnimController.PRIORITY_NORMAL)
        local animLoopCount = self.rAnimController:getAnimLoopCount(DFAnimController.PRIORITY_NORMAL)
        if animLoopCount ~= self.prevAnimLoopCount then
            self.nextAnimEventIdx = 1
            self.prevAnimLoopCount = animLoopCount
        end
        if self.nextAnimEventIdx <= numAnimEvents then
            for i=self.nextAnimEventIdx,numAnimEvents do
                local rAnimEvent = self.tAnimationEvents[i]
                if rAnimEvent.StartTime < animTime then
                    rAnimEvent:execute()
                    self.nextAnimEventIdx = self.nextAnimEventIdx + 1
                else
                    break
                end
            end
        end
    end
    self:_updateTracker()
    if Rig.bDBGExtendedProfiler then
        Profile.leaveScope( "Rig:update" )
    end
end
function Rig:getProp()
    return self.rUnscaledRootJointProp
end
function Rig:getWorldBounds(bDynamicBounds)
    local x0, y0, z0 = self.rEntity.rProp:modelToWorld()
    local x1, y1, z1 = x0, y0, z0
    if self.rMainMesh ~= nil then
        local cx0, cy0, cz0, cx1, cy1, cz1 = self.rMainMesh:getWorldBounds(bDynamicBounds)
        if bDynamicBounds == false and self.bUseEntityOffsetScale == false then
            cx0 = cx0 - x0
            cy0 = cy0 - y0
            cz0 = cz0 - z0
            cx1 = cx1 - x0
            cy1 = cy1 - y0
            cz1 = cz1 - z0
            local sx, sy, sz = self.rEntity.rProp:getScl()
            cx0 = cx0 * sx
            cy0 = cy0 * sy
            cz0 = cz0 * sz
            cx1 = cx1 * sx
            cy1 = cy1 * sy
            cz1 = cz1 * sz
            cx0 = cx0 + x0
            cy0 = cy0 + y0
            cz0 = cz0 + z0
            cx1 = cx1 + x0
            cy1 = cy1 + y0
            cz1 = cz1 + z0
        end
        x0, y0, z0 = math.min(x0, cx0), math.min(y0, cy0), math.min(z0, cz0)
        x1, y1, z1 = math.max(x1, cx1), math.max(y1, cy1), math.max(z1, cz1)
    end
    return x0, y0, z0, x1, y1, z1
end
function Rig:getMaterials()
    return self.tMaterials
end
function Rig:_setTextureReplacements( tRigData )
    local tTextureReplacements = tRigData.tTextureReplacements
    self.tTextureReplacements = {}
    if tTextureReplacements then
        for _,v in ipairs(tTextureReplacements) do
            self.tTextureReplacements[ v[1] ] = v[2]
        end
    end
end
function Rig:setTexturePath( tReplacements )
	local bSuccess = true
    for _,v in ipairs(tReplacements) do
        local rTexture = DFGraphics.loadTexture( v[3], false )
        local rMaterial = self.rMainMesh.tSubsetMaterials[ v[1] ]
        if rMaterial == nil then
            print("nil material for subset:"..v[1]..", texture:"..v[3])
			bSuccess = false
        else
            rMaterial:setShaderValue(v[2], MOAIMaterial.VALUETYPE_TEXTURE, rTexture)
        end
    end
	return bSuccess
end
function Rig:_resetToBindPosition()
    for sAnimName,_ in pairs(self.tActiveAnims) do
        local animPriority = self.rAnimController:getLayerPriority(sAnimName)
        if animPriority == DFAnimController.PRIORITY_NORMAL then
            self:stopAnimation( sAnimName )
            assert( self.tActiveAnims[sAnimName] == nil )
        end
    end
	self:_unlinkTracker()
    self.rTrackerTrans:setLoc(0, 0, 0)
    self.prevScaleX = nil
    self:_updateRootProp()
end
function Rig:_createMeshes( tDataDesc, tRigArgs, rAssetSet )
	local tMeshDescs = tDataDesc.tMeshes
	self.numMeshes = #tMeshDescs
	for i=1,self.numMeshes do
		local tMeshDesc = tMeshDescs[i]
		assert(self.tMeshMap[tMeshDesc.sName] == nil)
		local tMeshData = {}
		tMeshData.tMeshDesc = tMeshDesc
		self.tMeshMap[tMeshDesc.sName] = tMeshData
		if tMeshDesc.tTriMesh then
			self:_createTriMesh(tDataDesc, tMeshDesc, tMeshData, tRigArgs, rAssetSet)
			if tMeshData.rMesh ~= nil then
				if self.rMainMesh == nil then
					self.rMainMesh = tMeshData.rMesh
                    self.rMainMesh.rEntity = self.rEntity
				else
					self.rMainMesh:addExternalMesh(tMeshData.rMesh)
				end
			end
		end
		local rMeshProp = tMeshData.rMesh
		rMeshProp:setAttrLink(MOAIProp.INHERIT_TRANSFORM, self.rRootJoint.rProp, MOAIProp.TRANSFORM_TRAIT)
	end
end
function Rig:_createTriMesh( tDataDesc, tMeshDesc, tMeshData, tRigArgs, rAssetSet )
	local tTriMeshDesc = tMeshDesc.tTriMesh
	local rMesh = DFDynamicMesh.new()
    rMesh:setName(tMeshDesc.sName)
    rMesh:setAnimController(self.rAnimController)
    rMesh:setReflectable(tRigArgs.bIsReflectable)
    rMesh:setReflectionOffset(tRigArgs.reflectionOffset)
    if tRigArgs.sReflectionOffsetJointName and #tRigArgs.sReflectionOffsetJointName > 0 then
        local rReflectionOffset = nil
        local tJointData = self.tJointMap[tRigArgs.sReflectionOffsetJointName]
        if tJointData ~= nil then
            rReflectionOffset = self:getJointProp(tRigArgs.sReflectionOffsetJointName)
        end
        if rReflectionOffset ~= nil then
            rMesh:setReflectionOffset(rReflectionOffset)
        else
            Trace(TT_Warning, "Couldn't find reflection offset joint: " .. tRigArgs.sReflectionOffsetJointName)
        end
    end
	tMeshData.rMesh = rMesh
    tMeshData.tSubsetIndices = {}
    local rMaterial = Renderer.getGlobalMaterial("meshBase")
    rMaterial = self:_getMaterial( tRigArgs.sMaterial, rAssetSet, rMaterial )
    rMesh:setMaterial( rMaterial )
    rMesh:setDepthMask(true)
    rMesh:setDepthTest(MOAIProp.DEPTH_TEST_LESS_EQUAL)
    local tSubsetMaterials = {}
    if tTriMeshDesc.tMaterials ~= nil and #tTriMeshDesc.tMaterials > 0 then
        local numSubsetMaterials = #tTriMeshDesc.tMaterials
        for i=1,numSubsetMaterials do
            local sSubsetMaterial = tTriMeshDesc.tMaterials[i]
            if tRigArgs.tMaterialMap ~= nil then
                if tRigArgs.tMaterialMap[sSubsetMaterial] ~= nil then
                    sSubsetMaterial = tRigArgs.tMaterialMap[sSubsetMaterial]
                end
            end
            local rSubsetMaterial = self:_getMaterial( sSubsetMaterial, rAssetSet )
            table.insert(tSubsetMaterials, rSubsetMaterial)
        end
    end
    rMesh:setRigData(tDataDesc.rRigData)
    local tSubsetAppearance = {}
    local numSubsets = #tTriMeshDesc.tSubsets
	for i=1,numSubsets do
		local tSubset = tTriMeshDesc.tSubsets[i]
        local subsetIndex = i-1
        local sName = rMesh:getSubsetName(subsetIndex)
        tSubset.sName = sName
        tSubset.nIndex = subsetIndex
        local sTexture = tRigArgs.sTextureOverride or tSubset.sTexture
		local rTexture = self:_getTexture( sTexture, rAssetSet )
        local rSubsetMaterial = nil
        if tSubset.materialIdx ~= nil and tSubsetMaterials ~= nil then
            rSubsetMaterial = tSubsetMaterials[tSubset.materialIdx]
        else
            local sMaterial = tRigArgs.sMaterial
            if not sMaterial then
                sMaterial = "meshDefault"
            end
            rSubsetMaterial = Renderer.loadMaterialInstance(sMaterial)
        end
        table.insert(tSubsetAppearance, { rTexture, rSubsetMaterial })
        if nil == rMesh.tSubsetMaterials then
            rMesh.tSubsetMaterials = {}
        end
        rMesh.tSubsetMaterials[sName] = rSubsetMaterial
        rMesh:addSubsetMaterial(rSubsetMaterial)
	end
    rMesh:setSubsetAppearance(tSubsetAppearance)
    rMesh:setVisible(false)
	return rMesh
end
function Rig:_getTexture( sTexture, rAssetSet )
	local rTexture = nil
	if sTexture then
		rTexture = rAssetSet:preloadTexture(sTexture)
        rTexture:setWrap(true)
		table.insert( self.tTextures, sTexture )
	else
		rTexture = Renderer.getGlobalTexture( "white" )
	end
	return rTexture
end
function Rig:_getMaterial( sMaterial, rAssetSet, rDefaultMaterial )
    local rMaterial = rDefaultMaterial
    if sMaterial ~= nil and #sMaterial > 0 then
        local extension = DFFile.getSuffix(sMaterial)
        if extension and #extension > 0 then
            rMaterial = DFGraphics.loadMaterial(sMaterial)
            table.insert(self.tMaterials, rMaterial)
        else
            rMaterial = Renderer.getGlobalMaterial(sMaterial)
            if rMaterial == nil then
                Trace(TT_Warning, "Undefined shared material: " .. sMaterial)
                rMaterial = Renderer.getGlobalMaterial("meshBase")
            end
        end
    end
    return rMaterial
end
function Rig:_boolToFloat(value)
    if value == true then
        return 1
    else
        return 0
    end
end
function Rig:_initializeJointHierarchy(tData)
    self.rAnimController = DFAnimController.new()
    self.rAnimController:setDebugName(self.rEntity.sName)
    self.rAnimController:setRootTransform(self.rRootJoint.rProp)
    self.rAnimController:initJointHierarchy(tData.rRigData)
    self.rAnimController:stop()
    local numJoints = #tData.tJoints
    for i=1,numJoints do
        local tJointData = {}
        tJointData.idx = i
        local sJointName = tData.tJoints[i]
        self.tJointMap[sJointName] = tJointData
    end
end
function Rig:_initializeAnimController(tData, tRigArgs)
    self.rAnimController:reserveLayers(4)
    self.rAnimController:initRestPose(1, self.rMainMesh)
end
function Rig:_insertVisCommand(tSubset, tVariations, tVisTable)
    local sSubsetName = tSubset.sName
    if tVariations then
        for k,v in pairs(tVariations) do
            if v.prefix then
                if string.sub(sSubsetName, 1, #v.prefix) == v.prefix then
                    local bShow = string.sub(sSubsetName, 1, #v.full) == v.full
                    if v.full == "" then bShow = false end
                    table.insert(tVisTable, {tSubset,bShow})
                end
            elseif v.full then
                if string.find(sSubsetName, v.full) then
                    table.insert(tVisTable, {tSubset, true})
                end
            end
        end
        return false
    end
end
function Rig:setVariationLayer(tVariations)
    if self.bDBG_NoAnim then return end
    self.rAnimController:removeLayer('Variation')
    local variationSubsets = {}
	for sMeshName,tMeshData in pairs(self.tMeshMap) do
        local tTriMeshData = tMeshData.tMeshDesc.tTriMesh
        for idx,subset in ipairs(tTriMeshData.tSubsets) do
            self:_insertVisCommand(subset, tVariations, variationSubsets)
        end
        local variationPriority = DFAnimController.PRIORITY_NORMAL+1
        local numSubsets = #variationSubsets
        local tAnimLayerCmds = {}
        table.insert( tAnimLayerCmds, { "Variation", {}, MOAITimer.NORMAL, numSubsets, variationPriority, true } )
        for i=1,numSubsets do
            local sSubsetName = variationSubsets[i][1].sName
            local subsetIndex = variationSubsets[i][1].nIndex
            local bIsVisible = variationSubsets[i][2]
            table.insert( tAnimLayerCmds, { self:_boolToFloat(bIsVisible), DFAnimController.TARGET_SUBSET_VISIBILITY, tMeshData.rMesh, subsetIndex } )
        end
        self.rAnimController:addLayerAndTracks(tAnimLayerCmds)
    end
end
function Rig:_enableEntityScaling( bEnable )
    if bEnable == false and self.bUseEntityOffsetScale == true then
        self.rScaleJointProp:clearAttrLink(MOAIProp.OFFSET_SCL, self.rEntity.rProp)
        self.bUseEntityOffsetScale = false
    end
    if bEnable == true and self.bUseEntityOffsetScale == false then
        self.rScaleJointProp:setAttrLink(MOAIProp.OFFSET_SCL, self.rEntity.rProp, MOAIProp.OFFSET_TRANSFORM_TRAIT)
        self.bUseEntityOffsetScale = true
    end
    self.rAnimController:enableAnimationRootScaling(not bEnable)
end
function Rig:_enableEntityNavigation( bEnable )
    if bEnable == false and self.bAllowEntityNavigation == true then
        if self.rEntity.CoNavigator ~= nil and self.rEntity.CoNavigator.bUsePathing == true then
            self.rEntity.CoNavigator:cancelNavigation()
            self.rEntity.CoNavigator.bUsePathing = false
            self.bAllowEntityNavigation = false
        end
    end
    if bEnable == true and self.bAllowEntityNavigation == false then
        if self.rEntity.CoNavigator ~= nil and self.rEntity.CoNavigator.bUsePathing == false then
            self.rEntity.CoNavigator.bUsePathing = true
            self.bAllowEntityNavigation = true
        end
    end
end
function Rig:_linkTracker(fnMoveHandler)
    if not self.bHasRootMotion or ( fnMoveHandler and fnMoveHandler ~= self.fnMoveHandler ) then
        self.bHasRootMotion = true
        local rEntityProp = self.rEntity:getProp()
        rEntityProp:clearAttrLink(MOAIProp.OFFSET_LOC)
        if not fnMoveHandler then
            self.rAnimController:setTrackerTransform(self.rTrackerTrans)
            local x, y, z = rEntityProp:getLoc()
            self.tInitialTrackerLoc = { x, y, z }
            rEntityProp:setAttrLink(MOAIProp.OFFSET_LOC, self.rTrackerTrans, MOAIProp.OFFSET_TRANSFORM_TRAIT)
        else
            self.fnMoveHandler = fnMoveHandler
            self._movePrevX, self._movePrevY, self._movePrevZ = nil, nil, nil
        end
        rEntityProp:forceUpdate()
    end
end
function Rig:_unlinkTracker()
    if self.bHasRootMotion == true or self.tFinalTrackerLoc then
        self.bHasRootMotion = false
        local rEntityProp = self.rEntity:getProp()
        rEntityProp:clearAttrLink(MOAIProp.OFFSET_LOC)
        if self.fnMoveHandler == nil then
            self.rAnimController:setTrackerTransform(nil)
            if self.tFinalTrackerLoc ~= nil then
                local cx, cy, cz = rEntityProp:getLoc()
                local ex, ey, ez = unpack(self.tFinalTrackerLoc)
                local x = ex * 300
                local y = ey * -300
                local z = ez * 300
                z = cz
                rEntityProp:setLoc(x, y, z)
            end
        end
        self.fnMoveHandler = nil
        self.tFinalTrackerLoc = nil
        self.rMainMesh:forceUpdate()
    end
end
function Rig:_updateRootProp()
    local rProp = self.rRootJoint.rProp
    if self.rOwnerRig and self.rOwnerRig.rEntity and self.rOwnerRig.rEntity.rProp then
        local sx, sy, sz = self.rOwnerRig.rEntity.rProp:getScl()
        rProp:setScl(self.scaleX * sx, sy, sz)
    else
        if self.prevScaleX ~= self.scaleX then
            rProp:setScl(self.scaleX, 1, 1)
            self.prevScaleX = self.scaleX
        end
    end
end
function Rig:_updateTracker()
    if self.fnMoveHandler then
        local rTracker = self.rTrackerTrans
        local x, y, z = rTracker:modelToWorld()
        if self._movePrevX then
            local dx, dy, dz = x - self._movePrevX, y - self._movePrevY, z - self._movePrevZ
            self.fnMoveHandler(dx, dy, dz)
        end
        self._movePrevX, self._movePrevY, self._movePrevZ = x, y, z
    end
end
function Rig:_updateShaderValues()
    if Rig.bDBGExtendedProfiler then
        Profile.enterScope( "Rig:_updateShaderValues" )
    end
    local tShaderValues = {}
    local bUpdateEntityLoc = false
    local x, y, z = self.rEntity.rProp:modelToWorld()
    if not self.tLastEntityLoc then
        bUpdateEntityLoc = true
    else
        local distSqr = DFMath.distanceSquared( x, y, z, self.tLastEntityLoc[1], self.tLastEntityLoc[2], self.tLastEntityLoc[3] )
        if distSqr > 1 then
            bUpdateEntityLoc = true
        end
    end
    if bUpdateEntityLoc then
        self.rMainMesh:setEntityPivot(x, y, z)
    end
    self.tLastEntityLoc = {x, y, z}
    if self.rEntity.CoLightProbeSampler ~= nil then
        local rSceneLayer = self.rEntity:getSceneLayer()
        if self.sLastSceneLayerName ~= rSceneLayer.Name then
            self.rMainMesh:setLightLayerName(rSceneLayer.Name)
            self.sLastSceneLayerName = rSceneLayer.Name
            self.rTargetSceneLayer = nil
            self.targetSceneLayerAlpha = 0
        end
        if self.rTargetSceneLayer then
            self.rMainMesh:setTargetLightLayerName(self.rTargetSceneLayer.Name, self.targetSceneLayerAlpha)
            self.sLastTargetSceneLayerName = self.rTargetSceneLayer.Name
        else
            if self.sLastTargetSceneLayerName then
                self.rMainMesh:setTargetLightLayerName()
                self.sLastTargetSceneLayerName = nil
            end
        end
    end
    if Rig.bDBGExtendedProfiler then
        Profile.leaveScope( "Rig:_updateShaderValues" )
    end
end
function Rig.debugDrawBox(rSceneLayer, x0, y0, z0, x1, y1, z1)
    local a0, b0 = rSceneLayer:worldToWnd(x0, y0, z0)
    local a1, b1 = rSceneLayer:worldToWnd(x1, y0, z0)
    local a2, b2 = rSceneLayer:worldToWnd(x1, y1, z0)
    local a3, b3 = rSceneLayer:worldToWnd(x0, y1, z0)
    local c0, d0 = rSceneLayer:worldToWnd(x0, y0, z1)
    local c1, d1 = rSceneLayer:worldToWnd(x1, y0, z1)
    local c2, d2 = rSceneLayer:worldToWnd(x1, y1, z1)
    local c3, d3 = rSceneLayer:worldToWnd(x0, y1, z1)
    MOAIDraw.drawLine( a0, b0, a1, b1 )
    MOAIDraw.drawLine( a1, b1, a2, b2 )
    MOAIDraw.drawLine( a2, b2, a3, b3 )
    MOAIDraw.drawLine( a3, b3, a0, b0 )
    MOAIDraw.drawLine( c0, d0, c1, d1 )
    MOAIDraw.drawLine( c1, d1, c2, d2 )
    MOAIDraw.drawLine( c2, d2, c3, d3 )
    MOAIDraw.drawLine( c3, d3, c0, d0 )
    MOAIDraw.drawLine( a0, b0, c0, d0 )
    MOAIDraw.drawLine( a1, b1, c1, d1 )
    MOAIDraw.drawLine( a2, b2, c2, d2 )
    MOAIDraw.drawLine( a3, b3, c3, d3 )
end
function Rig:debugDraw(bDebugDrawJoints, bDebugDrawBounds, bDebugDrawSubsetBounds, bDebugDrawSubsetNames)
	local rSceneLayer = self.rEntity:getSceneLayer() or Renderer.getRenderLayer(Character.RENDER_LAYER)
	if bDebugDrawJoints and rSceneLayer then
		self.rAnimController:debugDrawJointHierarchy(rSceneLayer)
	end
	if bDebugDrawBounds and self.rMainMesh ~= nil and rSceneLayer then
        if bDebugDrawSubsetBounds then
            local idx = 0
            while true do
                idx = idx + 1
                local isVisible, x0, y0, z0, x1, y1, z1, subsetName = self.rMainMesh:getSubsetInfo( idx )
                if isVisible == nil then
                    break
                end
                if isVisible == true then
                    MOAIGfxDevice.setPenColor ( 1, 0, 0, 1 )
                    Rig.debugDrawBox( rSceneLayer, x0, y0, z0, x1, y1, z1 )
                    if bDebugDrawSubsetNames then
                        local x = (x0 + x1) * 0.5
                        local y = (y0 + y1) * 0.5
                        local z = (z0 + z1) * 0.5
                        local cx, cy = rSceneLayer:worldToWnd(x, y, z)
                        cx = math.floor( cx )
                        cy = math.floor( cy )
                        local rFont = Renderer.getGlobalFont("debug")
                        MOAIGfxDevice.setPenColor( 1, 1, 1, 1 )
                        MOAIDraw.drawText(rFont, 30, subsetName, cx, cy, 1, 2, 2)
                    end
                end
            end
        end
        MOAIGfxDevice.setPenColor ( 0, 1, 0, 1 )
        local x0, y0, z0, x1, y1, z1 = self:getWorldBounds(false)
        if x0 ~= nil then
            local offset = 5
            x0 = x0 - offset
            y0 = y0 - offset
            z0 = z0 - offset
            x1 = x1 + offset
            y1 = y1 + offset
            z1 = z1 + offset
            Rig.debugDrawBox( rSceneLayer, x0, y0, z0, x1, y1, z1 )
        end
        MOAIGfxDevice.setPenColor ( 0, 0, 1, 1 )
        local x0, y0, z0, x1, y1, z1 = self.rMainMesh:getWorldBounds(true)
        if x0 ~= nil then
            local offset = 5
            x0 = x0 - offset
            y0 = y0 - offset
            z0 = z0 - offset
            x1 = x1 + offset
            y1 = y1 + offset
            z1 = z1 + offset
            Rig.debugDrawBox( rSceneLayer, x0, y0, z0, x1, y1, z1 )
        end
    end
end
function Rig:setRigShaderValue(valueName, value)
    if Rig.bDBGExtendedProfiler then
        Profile.enterScope("setRigShaderValue per mesh")
    end
    local valueType = nil
    if type(value) == 'number' then
        valueType = MOAIMaterial.VALUETYPE_FLOAT
    elseif type(value) == 'table' then
        if #value == 2 then
            valueType = MOAIMaterial.VALUETYPE_VEC2
        elseif #value == 3 then
            valueType = MOAIMaterial.VALUETYPE_VEC3
        elseif #value == 4 then
            valueType = MOAIMaterial.VALUETYPE_VEC4
        end
    end
    if not valueType then
        print('Rig:setRigShaderValue: unrecognized value type for ' .. value)
        return
    end
    self.rMainMesh:setShaderValue(valueName, valueType, value)
    if Rig.bDBGExtendedProfiler then
        Profile.leaveScope("setRigShaderValue per mesh")
    end
end
function Rig.hotReloadAnim(assetPath)
    print("doing a hot reload for anim: " .. assetPath)
    DataCache.clear( "anim" )
    for rig, _ in pairs(gAllRigs) do
        if rig.tCurrentAnimationData then
            rig:playAnimation(rig.tCurrentAnimationData)
        end
    end
end
function Rig.hotReloadAnimEvents(assetPath)
    print("anim event reload requested, clearing cache for anims and hopefully that's good enough dawg. : " .. assetPath)
    Rig.hotReloadAnim(assetPath)
end
function Rig.hotReloadRig(assetPath)
    print("hot reload not implemented for rig: " .. assetPath)
end
local assetRoot = DFFile.getAssetPath('')
function Rig.onFileChange(path)
    path = path:gsub('/_Cache/', '/Munged/')
    if string.find(path, assetRoot) == 1 then
        local assetPath = string.sub(path, #assetRoot + 1)
        local sExtension = DFFile.getSuffix( assetPath )
        if sExtension == "anim" then
            Rig.hotReloadAnim(assetPath)
        elseif sExtension == "animevents" then
            Rig.hotReloadAnimEvents(assetPath)
        elseif sExtension == "rig" then
            Rig.hotReloadRig(assetPath)
        end
    end
end
DFMoaiDebugger.dFileChanged:register(Rig.onFileChange)
return Rig
