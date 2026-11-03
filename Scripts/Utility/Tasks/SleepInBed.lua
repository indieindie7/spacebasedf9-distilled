local Task=require('Utility.Task')
local UtilityAI=require('Utility.UtilityAI')
local Class=require('Class')
local Log=require('Log')
local World=require('World')
local GameRules=require('GameRules')
local Character=require('CharacterConstants')
local Base = require('Base')
local ObjectList=require('ObjectList')
local SleepInBed = Class.create(Task)
function SleepInBed.staticFromSaveData(rChar,tData)
    local rTargetObject = ObjectList.getObject(tData.tTargetObject)
    if rTargetObject then
        local rAO = rTargetObject.rSleepInBedOption
        local bSuccess, sReason = rAO:fillOutBlackboard(rChar)
        if bSuccess then
            local rTask = rAO:createTask(rChar, tData.nPromisedUtility, tData)
            return rTask
        end
    end
end
function SleepInBed:init(rChar,tPromisedNeeds,rActivityOption,tSaveData)
    self.super.init(self,rChar,tPromisedNeeds,rActivityOption)
    if tSaveData then
        self.rTargetObject = ObjectList.getObject(tSaveData.tTargetObject)
        self.duration = tSaveData.duration
        if not self.rTargetObject then
            self:interrupt('failed to resume after load: no target bed')
            return
        else
            if not self:attemptInteractOnObject('sleep', self.rTargetObject, self.duration) then
                self:interrupt('Failed to resume after load: failed to interact with bed')
                return
            end
            self.nSleepStartTime = tSaveData.nSleepStartTime
			self.bSnoozing = true
        end
    else
        self.duration = math.random(Character.SLEEP_DURATION*.9, Character.SLEEP_DURATION*1.1)
        self.rTargetObject = rActivityOption.tData.rTargetObject
        self.bInterruptOnPathFailure = true
        assert(rActivityOption.tBlackboard.rChar == rChar)
        assert(rActivityOption.tBlackboard.rTargetObject == self.rTargetObject)
        self:setPath(rActivityOption.tBlackboard.tPath)
        if self.rTargetObject.rUser then
            Print(TT_Error, "User already in bed!", self.rChar, self.rTargetObject.rUser)
        end
	    self.bSnoozing = false
    end
end
function SleepInBed:onUpdate(dt)
	if self:interacting() then
		if not self.rTargetObject or self.rTargetObject.bDestroyed then
			self.rChar:angerEvent(Character.ANGER_JOB_FAIL_MAJOR)
			self:interrupt('bed destroyed')
		end
		self.duration = self.duration - dt
        return self:tickInteraction(dt)
    elseif self:tickWalk(dt) then
        if not self:attemptInteractOnObject('sleep', self.rTargetObject, self.duration) then
            self:interrupt('Failed to get to bed')
        else
            self.nSleepStartTime = GameRules.elapsedTime
			self.bSnoozing = true
        end
    end
end
function SleepInBed:onComplete(bSuccess)
    Task.onComplete(self,bSuccess)
	self.bSnoozing = false
    if not self.nSleepStartTime then
		return
	end
	local nSleepBenefit = 1
	if not bSuccess then
		nSleepBenefit = math.min(1,.8 * (GameRules.elapsedTime-self.nSleepStartTime) / self.duration)
		self:_addNeedReward(nSleepBenefit)
	end
	if bSuccess then
		local tLogType = Log.tTypes.SLEEP_BED_UNOWNED
		local bBedOwned = false
		local nMorale = Character.MORALE_WOKE_UP_BED
		if Base.tCharToBed[ObjectList.getTag(self.rChar)] == self.rTargetObject then
			bBedOwned = true
			tLogType = Log.tTypes.SLEEP_BED_OWNED
			nMorale = nMorale * 2
			nSleepBenefit = 1.5
			self:_addNeedReward(nSleepBenefit)
		end
		Log.add(tLogType, self.rChar)
		self.rChar:alterMorale(nMorale, 'WokeUpInBed')
		self.rChar:addRoomAffinity(Character.AFFINITY_CHANGE_MEDIUM)
		self.rChar:addObjectAffinity(self.rTargetObject, Character.AFFINITY_CHANGE_MEDIUM)
		self.rChar:storeMemory(Character.MEMORY_LAST_BED, self.rTargetObject._ObjectList_ObjectMarker)
	else
		self.rChar:addRoomAffinity(-Character.AFFINITY_CHANGE_MINOR)
		self.rChar:addObjectAffinity(self.rTargetObject, -Character.AFFINITY_CHANGE_MINOR)
	end
	if nSleepBenefit > .7 then
		if self.rChar:getNeedValue('Duty') > 0 then
			self.rChar:setNeedValue('Duty',0)
		end
	end
end
return SleepInBed
