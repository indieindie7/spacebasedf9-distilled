local Class=require('Class')
local EnvObject=require('EnvObjects.EnvObject')
local CharacterManager=require('CharacterManager')
local GridUtil=require('GridUtil')
local Room=require('Room')
local EmergencyBeacon=require('Utility.EmergencyBeacon')
local Projectile=require('Projectile')
local Base=require('Base')
local ObjectList=require('ObjectList')
local Asteroid=require('Asteroid')
local Cursor=require('UI.Cursor')
local DFMath=require('DFCommon.Math')
local MiscUtil=require('MiscUtil')
local WorldObject=require('WorldObjects.WorldObject')
local Character=require('CharacterConstants')
local GameRules=require('GameRules')
local SoundManager = require('SoundManager')
local Turret = Class.create(EnvObject, MOAIProp.new)
Turret.FIRE_RANGE_TILES = 16
Turret.FIRE_RANGE_WORLD = 16*128
Turret.FIRE_ANGLE = 150
Turret.FIRE_ANGLE_MIN = -Turret.FIRE_ANGLE * .5
Turret.FIRE_ANGLE_MAX = Turret.FIRE_ANGLE * .5
Turret.FIRE_COOLDOWN = 1.5
Turret.HIT_POINTS = 500
Turret.FIRE_DAMAGE = 75
Turret.ATTACK_TYPE = Character.ATTACK_TYPE.Ranged
Turret.DAMAGE_TYPE = Character.DAMAGE_TYPE.Laser
Turret.VISUAL_TICK_RATE = 0.025
Turret.bDebugFollowMouse = false
Turret.tFrames = {
	{ nMin = 0-180, sSprite = 'turret_frames0005' },
	{ nMin = 45-90, sSprite = 'turret_frames0004' },
	{ nMin = 75-90, sSprite = 'turret_frames0003' },
	{ nMin = 105-90, sSprite = 'turret_frames0002' },
	{ nMin = 135-90, sSprite = 'turret_frames0001' },
	{ nMin = 270-90, sSprite = 'turret_frames0005' },
}
Turret.sDeadFrame = 'turret_destroyed'
function Turret.reset()
	Turret.tTurrets = {}
	Turret.nLastUpdated = 1
end
function Turret:updateActivityOptionList()
    EnvObject.updateActivityOptionList(self)
end
function Turret.addTurret(rTurret)
	table.insert(Turret.tTurrets, rTurret)
end
function Turret.removeTurret(rTurret)
	for i,rOther in pairs(Turret.tTurrets) do
		if rOther == rTurret then
			table.remove(Turret.tTurrets, i)
			break
		end
	end
end
function Turret.tick(dt)
	if not next(Turret.tTurrets) then
		return
	end
	Turret.nLastUpdated = (Turret.nLastUpdated + 1) % (#Turret.tTurrets + 1)
	local rTurret = Turret.tTurrets[Turret.nLastUpdated]
	if rTurret then
		rTurret:calcTargetTiles()
	end
end
function Turret:isExternal()
    return self.bExternal
end
function Turret:charShouldAttack(rChar)
    if not self:isHostileTo(rChar) then return false end
        if self:isExternal() and not rChar:spacewalking() then
            return false, 'Character will not go outside to fight a turret.'
        end
        if self:isExternal() and rChar:getAttackType() ~= Character.ATTACK_TYPE.Ranged then
            return false, 'Characters do not melee external turrets.'
        end
        if not rChar:hasCombatAwarenessIn(rChar:getRoom()) then
            return false, 'Character has no combat awareness of turret.'
        end
        if Base.isFriendly(self,rChar) and not self:_fireOnEveryone() then
            return false, 'same team'
        end
        return true
end
function Turret:hasPower()
    return self.bActive and (not self.tData.nPowerDraw or self.tData.nPowerDraw == 0 or (self.bHasPower or g_PowerHoliday))
end
function Turret:_fireOnEveryone()
    return self.bFireOnEveryone or self:_isSabotaged()
end
function Turret:init(sName, wx, wy, bFlipX, bFlipY, bForce, tSaveData, nTeam)
    if not bFlipY then
        self.bSortDownOneTile = true
    end
	EnvObject.init(self,sName, wx, wy, bFlipX, bFlipY, bForce, tSaveData, nTeam)
	self.nAngle = 0
	self.nVisualTimer = 0
	self.nFireCooldownTimer = 0
	self.sLastTargetFiredAtID = nil
	self:calcTargetTiles()
	self.bFireOnEveryone = (tSaveData and tSaveData.bFireOnEveryone)
    local tData = {}
	tData.rVictim = self
	tData.utilityGateFn = function(rChar)
        return self:charShouldAttack(rChar)
    end
    tData.rTargetObject = self
	self.rAttackOption = g_ActivityOption.new('AttackThreat',tData)
    tData = {}
	tData.rVictim = self
	tData.utilityGateFn = function(rChar)
        return self:charShouldAttack(rChar)
    end
    tData.rTargetObject = self
	self.rAttackOption = g_ActivityOption.new('RangedAttackThreat',tData)
	Turret.addTurret(self)
end
function Turret:getAngleFromTarget(targetX, targetY, bSquareIn)
	if not bSquareIn then
		targetX,targetY = GridUtil.IsoToSquare(targetX, targetY)
		if not targetX then targetX = 0 end
		if not targetY then targetY = 0 end
	end
	local tx,ty = GridUtil.IsoToSquare(self:getTileLoc())
    local dx, dy = targetX - tx, -(targetY - ty)
    local facingX,facingY = MiscUtil.isoDirToCartesian(self:getFacing())
    local nAngle = DFMath.getAngleBetween(facingX,facingY,dx,dy)
    while nAngle > 180 do nAngle = nAngle-360 end
    while nAngle < -180 do nAngle = nAngle+360 end
    return nAngle
end
function Turret:calcTargetTiles()
    local txInFront, tyInFront = self:getTileInFrontOf()
    self.bExternal = g_World._getTileValue(txInFront,tyInFront) == g_World.logicalTiles.SPACE
	self.tTiles = {}
	local tx,ty = GridUtil.IsoToSquare(self:getTileLoc())
    if not tx then return end
	local minX, minY = tx - self.FIRE_RANGE_TILES, ty - self.FIRE_RANGE_TILES
	local maxX, maxY = tx + self.FIRE_RANGE_TILES, ty + self.FIRE_RANGE_TILES
	local nMinAngle = self.FIRE_ANGLE_MIN
	local nMaxAngle = self.FIRE_ANGLE_MAX
    local selfIsoTX,selfIsoTY = self:getTileLoc()
    local addr = g_World.pathGrid:getCellAddr(selfIsoTX,selfIsoTY)
    self.tTiles[addr] = {x=selfIsoTX, y=selfIsoTY}
    for x=minX,maxX do
		for y=minY,maxY do
            if x ~= minX and x ~= maxX and y ~= minY and y ~= maxY then
            else
			    local nAngle = math.abs(self:getAngleFromTarget(x,y,true))
			    if nAngle > nMinAngle and nAngle < nMaxAngle then
                    local tLine = GridUtil.GetTilesForLine(tx, ty, x, y, true)
                    for idx,coord in ipairs(tLine) do
                        if idx == 1 then
			            elseif DFMath.distance2D(tx, ty, coord[1],coord[2]) <= self.FIRE_RANGE_TILES then
                            local isoTX,isoTY = GridUtil.SquareToIso(coord[1], coord[2])
                            if isoTX then
                                local tileValue = g_World._getTileValue(isoTX,isoTY)
                                local rDoor = nil
                                if tileValue == g_World.logicalTiles.DOOR then rDoor = ObjectList.getDoorAtTile(isoTX,isoTY) end
                                if tileValue ~= g_World.logicalTiles.WALL and not Asteroid.isAsteroid(tileValue) and (not rDoor or rDoor:isOpen()) then
                                    addr = g_World.pathGrid:getCellAddr(isoTX,isoTY)
                                    self.tTiles[addr] = {x=isoTX, y=isoTY}
                                else
                                    break
                                end
                            end
                        else
                            break
                        end
                    end
                end
            end
		end
	end
end
function Turret:getValidTargetList()
    local swx,swy = self:getLoc()
	local tTargetChars
	if self:_fireOnEveryone() then
		tTargetChars = CharacterManager.getLivingCharactersInRange(swx, swy, self.FIRE_RANGE_WORLD)
	else
		tTargetChars = CharacterManager.getHostileCharactersInRange(swx, swy, self.FIRE_RANGE_WORLD, self)
	end
    local tTargetWorldObjects = WorldObject.getHostileObjectsInRange(swx, swy, self.FIRE_RANGE_WORLD, self)
    local t = {}
    for _,v in ipairs(tTargetChars) do
        if self:isHostileTo(v.rEnt) then
            table.insert(t,v)
        end
    end
    for _,v in ipairs(tTargetWorldObjects) do
        table.insert(t,v)
    end
	local f = function(x,y) return x.nDist2 < y.nDist2 end
	table.sort(t, f)
	return t
end
function Turret:_canHit(tx,ty,tw)
    local addr = g_World.pathGrid:getCellAddr(tx, ty)
    if self.tTiles[addr] then
        if tw == 1 then
            return true
        else
            if self.bExternal then
                return true
            end
            if g_World._getTileValue(tx,ty) == g_World.logicalTiles.SPACE then
                return true
            end
        end
    end
    return false
end
function Turret:updateCurrentTarget()
    if not self.bWasFriendly and self:getTeam() == Character.TEAM_ID_PLAYER and not self:_fireOnEveryone() then
        self.bWasFriendly = true
    end
	local tRanges = self:getValidTargetList()
    local x,y = self:getLoc()
    local rEnt = nil
    local wxOverride,wyOverride = nil,nil
    local tTestPoints = {}
	for _,tTarget in ipairs(tRanges) do
        if Room.getVisibilityAtTile(tTarget.rEnt:getTileLoc()) ~= g_World.VISIBILITY_FULL then break end
        for i=1,5 do
            local wx,wy,wz,nLevel = tTarget.rEnt:getLoc()
            local bOverride = i~=1
            if i == 2 then
                wx=wx+tTarget.rEnt:getHitRadius()*.5
            elseif i == 3 then
                wx=wx-tTarget.rEnt:getHitRadius()*.5
            elseif i == 4 then
                wy=wy+tTarget.rEnt:getHitRadius()*.5
            elseif i == 5 then
                wy=wy-tTarget.rEnt:getHitRadius()*.5
            end
            if tTarget.rEnt.getVelocity then
                local targetVelX,targetVelY = tTarget.rEnt:getVelocity()
                local wxLead,wyLead = MiscUtil.leadTarget(x, y, Projectile.DEFAULT_SPEED, wx, wy, targetVelX, targetVelY)
                local txLead,tyLead = g_World._getTileFromWorld(wxLead,wyLead)
                if self:_canHit(txLead,tyLead,nLevel) then
                    wx,wy = wxLead,wyLead
                end
            end
            local tx,ty = g_World._getTileFromWorld(wx,wy)
            if self:_canHit(tx,ty,nLevel) then
                rEnt = tTarget.rEnt
                wxOverride = wx
                wyOverride = wy
                break
            end
            if not tTarget.rEnt.getHitRadius then break end
        end
        if rEnt then
            break
        end
    end
    self.rCurrentTarget = rEnt
    self.wxOverride,self.wyOverride = wxOverride,wyOverride
end
function Turret:isHostileTo(rChar)
    if rChar:isDead() then return false end
    if not self:isFunctioning() then return false end
    if self:_fireOnEveryone() then return true end
    if Base.isFriendly(self,rChar) then return false end
    if rChar.tStatus.bCuffed then return false end
    if rChar:inPrison() then
        return false
    end
    if self.bWasFriendly and Base.isFriendlyToPlayer(rChar) then return false end
    return true
end
function Turret:fire(rTarget, wxOverride, wyOverride)
	local targetX,targetY,targetW = rTarget:getLoc()
    if wxOverride then
        targetX = wxOverride
        targetY = wyOverride
    end
	local targetTX,targetTY = g_World._getTileFromWorld(targetX,targetY)
	self:updateVisuals()
    local swx,swy = self:getLoc()
	local bullet = Projectile.new(swx, swy, nil, true, nil)
    local tDamage = {}
	tDamage.nDamage = self.FIRE_DAMAGE
	tDamage.nAttackType = self.ATTACK_TYPE
    tDamage.nDamageType = self.DAMAGE_TYPE
	local sSpriteName = Character.SPRITE_NAME_FRIENDLY_RIFLE
	SoundManager.playSfx3D('turretgunfire', swx, swy, 0)
	bullet:setSprite(sSpriteName,'SpriteAnims/Effects')
    local stx,sty = self:getTileLoc()
	local tLineTiles = GridUtil.GetTilesForLine(stx, sty, targetTX,targetTY)
    bullet:fireAtTarget(rTarget, self, tDamage, nil, self.wxOverride, self.wyOverride)
	self.nFireCooldownTimer = self.FIRE_COOLDOWN
end
function Turret:hover(hoverTime)
	EnvObject.hover(self,hoverTime)
	local bGreenNotRed = self:isFunctioning()
	g_World.layers.cursor.grid:fill(0)
	Cursor.drawTiles(self.tTiles, bGreenNotRed, true, false)
end
function Turret:unHover()
	EnvObject.unHover(self)
	g_World.layers.cursor.grid:fill(0)
	Cursor.drawTiles(self.tTiles, false, false)
end
function Turret:getSpriteFromAngle(nAngle)
	local sSprite = self.tFrames[1].sSprite
    if self.bFlipX then nAngle = -nAngle end
    if self.bFlipY then nAngle = -nAngle end
	for i,tFrame in ipairs(self.tFrames) do
		if nAngle >= tFrame.nMin then
            sSprite = tFrame.sSprite
		end
	end
    if self.bFlipY then
        sSprite = sSprite .. '_flipY'
    end
	return sSprite
end
function Turret:updateVisuals()
	if self:isDead() then
		self:setIndex(self.spriteSheet.names[self.sDeadFrame])
		return
	end
	local sSprite = MiscUtil.randomValue(self.tFrames)
	local rTrackTarget = self.rCurrentTarget
	local nAngle
	if rTrackTarget then
        local tx,ty = rTrackTarget:getTileLoc()
		nAngle = self:getAngleFromTarget(tx,ty)
	else
        local nRange = self.FIRE_ANGLE_MAX - self.FIRE_ANGLE_MIN
        nAngle = math.abs(5 - (GameRules.elapsedTime % 10))
		nAngle = self.FIRE_ANGLE_MIN + (nAngle * nRange)/5
	end
	if Turret.bDebugFollowMouse then
		local cx, cy = g_World.getWorldRenderLayer():wndToWorld(GameRules.cursorX, GameRules.cursorY)
		cx,cy = g_World._getTileFromWorld(cx,cy)
		nAngle = self:getAngleFromTarget(cx, cy)
	end
	sSprite = self:getSpriteFromAngle(nAngle)
	self.nAngle = nAngle
	self:setIndex(self.spriteSheet.names[sSprite])
end
function Turret:onTick(dt)
    EnvObject.onTick(self, dt)
	if self:isDead() or not self:isFunctioning() then
		return
	end
    local bUpdatedTarget = false
	if self.nVisualTimer > 0 then
		self.nVisualTimer = self.nVisualTimer - dt
	else
		self.nVisualTimer  = self.nVisualTimer + self.VISUAL_TICK_RATE
        self:updateCurrentTarget()
        bUpdatedTarget = true
		self:updateVisuals()
	end
	if self.nFireCooldownTimer > 0 then
		self.nFireCooldownTimer = self.nFireCooldownTimer - dt
		return
	end
    if not bUpdatedTarget then
        self:updateCurrentTarget()
        bUpdatedTarget = true
    end
	if self.rCurrentTarget then
		self:fire(self.rCurrentTarget, self.wxOverride, self.wyOverride)
		self.sLastTargetFiredAtID = self.rCurrentTarget:getUniqueID()
	end
end
function Turret:getAvailableEnemyActivities()
	local tActivities = EnvObject.getAvailableEnemyActivities(self)
    if self.rAttackOption and not self:isDead() then
		table.insert(tActivities, self.rAttackOption)
    end
    return tActivities
end
function Turret:getAvailableActivities()
	local tActivities = EnvObject.getAvailableActivities(self)
    if self.rAttackOption and not self:isDead() then
		table.insert(tActivities, self.rAttackOption)
    end
    return tActivities
end
function Turret:remove()
	self:unHover()
	Turret.removeTurret(self)
	EnvObject.remove(self)
end
function Turret:getSaveTable(xShift,yShift)
    local t = EnvObject.getSaveTable(self,xShift,yShift)
	t.bFireOnEveryone = self.bFireOnEveryone
    return t
end
function Turret:getThreatLevel()
    return Character.THREAT_LEVEL.Turret
end
return Turret
