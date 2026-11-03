local Task=require('Utility.Task') local Class=require('Class') local Log=require('Log') local Malady=require('Malady')
local OptionData=require('Utility.OptionData') local CharacterConstants=require('CharacterConstants')
local Incapacitated = Class.create(Task) function Incapacitated:init(rChar,tPromisedNeeds,rActivityOption)
self.super.init(self,rChar,tPromisedNeeds,rActivityOption) self.duration = 9999 if self.rChar.tStatus.bCuffed then
self.rChar:playAnim("incapacitated_cuffed") elseif self.rChar.tMaladies and self.rChar.tMaladies['BrokenLeg'] then
self.rChar:playAnim("incapacitated") else self.rChar:playAnim("sleep") end end function Incapacitated:onUpdate(dt)
if self.rChar:getPendingTaskName() or not Malady.isIncapacitated(self.rChar) then return true end end function Incapacitated:getPriority()
return OptionData.tPriorities.PUPPET end function Incapacitated:availableForInterruption(sProposedQueuedTaskName)
if sProposedQueuedTaskName == 'GetFieldScanned' then return true else return false end end return Incapacitated
