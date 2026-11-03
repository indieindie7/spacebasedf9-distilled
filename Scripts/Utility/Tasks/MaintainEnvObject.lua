local Task=require('Utility.Task')
local Class=require('Class')
local World=require('World')
local Log=require('Log')
local Character=require('CharacterConstants')
local DFMath = require("DFCommon.Math")
local Fire = require('Fire')
local Malady = require('Malady')
local GameRules = require('GameRules')
local Base = require('Base')
local EnvObject = require('EnvObjects.EnvObject')
local Effect=require('Effect')
local MaintainEnvObject = Class.create(Task)
MaintainEnvObject.MAINTAIN_MIN_DURATION = 8
MaintainEnvObject.MAINTAIN_MAX_DURATION = 10
function MaintainEnvObject:init(rChar,tPromisedNeeds,rActivityOption)
    self.super.init(self,rChar,tPromisedNeeds,rActivityOption)
    self.duration = MaintainEnvObject.MAINTAIN_DURATION
    self.rTarget = rActivityOption.tData.rTargetObject
    assert(rActivityOption.tBlackboard.rChar == rChar)
    assert(rActivityOption.tBlackboard.rTargetObject == self.rTarget)
    self:setPath(rActivityOption.tBlackboard.tPath)
end
function MaintainEnvObject:_tryToMaintain()
    if self.rChar:isElevated() then return false end
    local cx,cy = self.rChar:getLoc()
    local tx,ty = self.rTarget:getLoc()
    if World.areWorldCoordsAdjacent(cx,cy,tx,ty,true,true) then
        self.bMaintaining = true
        self.rChar:playAnim('maintain')
        self.rChar:faceWorld(tx,ty)
        self.duration = self:getDuration(MaintainEnvObject.MAINTAIN_MIN_DURATION, MaintainEnvObject.MAINTAIN_MAX_DURATION, self.rTarget.tData.maintainJob or Character.TECHNICIAN)
        self.startingCondition = self.rTarget.nCondition
        Malady.interactedWith(self.rChar,self.rTarget)
        return true
    end
end
function MaintainEnvObject:onUpdate(dt)
    if self.rTarget:slatedForTeardown() then
        self:interrupt('slated for teardown')
        return
    end
    if self.bMaintaining then
        self.duration = self.duration - dt
        if self.duration < 0 then
            if self:getJobSuccess(self.rTarget.tData.maintainJob or Character.TECHNICIAN) then
                if self.startingCondition == 0 then
                    self.rChar:alterMorale(Character.MORALE_REPAIR_OBJECT, 'RepairedObject')
                    self.rChar.tStats.tHistory.nTotalRepairedObjects = 1 + (self.rChar.tStats.tHistory.nTotalRepairedObjects or 0)
                else
                    self.rChar:alterMorale(Character.MORALE_MAINTAIN_OBJECT, 'MaintainedObject')
                    self.rChar.tStats.tHistory.nTotalMaintainedObjects = 1 + (self.rChar.tStats.tHistory.nTotalMaintainedObjects or 0)
                end
                local nConditionImprovement = self.rTarget:maintain(self.startingCondition, self.rChar:getJobCompetency(self.rTarget.tData.maintainJob or Character.TECHNICIAN))
                if nConditionImprovement > 0 and self.rChar:getInventoryItemOfTemplate('SuperMaintainer') then
                    self.rTarget:preventDecayFor(60*15)
                end
                self.rChar.tStats.tHistory.nTotalMaintenceImprovement = nConditionImprovement + (self.rChar.tStats.tHistory.nTotalMaintenceImprovement or 0)
				self.rTarget.sLastMaintainer = self.rChar.tStats.sUniqueID
				self.rTarget.sLastMaintainTime = require('GameRules').sStarDate
                local tLogData = {
                    sDutyTarget = self.rTarget.sFriendlyName,
                    sLinkTarget = self.rTarget.sUniqueName,
                    sLinkType = 'EnvObject',
                }
				if self.rChar.tStats.nJob == Character.TECHNICIAN then
					Log.add(Log.tTypes.DUTY_TECH, self.rChar, tLogData)
				end
            else
                self.rChar:angerEvent(Character.ANGER_JOB_FAIL_MINOR)
				local wx,wy = self.rTarget:getLoc()
				Effect.new(EnvObject.sSparkFX, wx, wy, nil, nil, {0,64,0})
                local bFire = self.rTarget:damageCondition(EnvObject.MAINTAIN_FAILURE_DAMAGE, true)
            end
            return true
        end
    elseif self.tPath then
        self:tickWalk(dt)
    else
        if not self:_tryToMaintain() then
            self:interrupt("can't maintain: did the target move?")
        end
    end
end
return MaintainEnvObject
