local Task=require('Utility.Task') local Class=require('Class') local Log=require('Log') local World=require('World')
local Character=require('CharacterConstants') local CheckInToHospital = Class.create(Task)
function CheckInToHospital:init(rChar,tPromisedNeeds,rActivityOption) self.super.init(self,rChar,tPromisedNeeds,rActivityOption)
self.rTargetObject = rActivityOption.tData.rTargetObject self.bInterruptOnPathFailure = true
assert(rActivityOption.tBlackboard.rChar == rChar) assert(rActivityOption.tBlackboard.rTargetObject == self.rTargetObject)
self:setPath(rActivityOption.tBlackboard.tPath) Log.add(Log.tTypes.HEALTH_CITIZEN_HOSPITAL_CHECKIN, self.rChar) end
function CheckInToHospital:_testInBed(dt)
if self.rChar:getPerceivedDiseaseSeverity(true) == 0 and not self.rChar:retrieveMemory(Character.MEMORY_SENT_TO_HOSPITAL) then
self:complete() end if not self.rTargetObject:isOperational() then self:interrupt('Bed no longer functional.') end end
function CheckInToHospital:onUpdate(dt) if self:interacting() then if self:tickInteraction(dt) then return true end
elseif self:tickWalk(dt) then self.nTimeSinceOnDutyDoctor = 0 if not self:attemptInteractOnObject('sleep', self.rTargetObject, 999999) then
self:interrupt('Failed to reach bed.') return else self.rChar:setVisibilityOverride(false) end end self:_testInBed(dt) end
function CheckInToHospital:onComplete(bSuccess) Task.onComplete(self, bSuccess) self.rChar:clearMemory(Character.MEMORY_SENT_TO_HOSPITAL)
self.rChar:setVisibilityOverride(nil) if self.rChar:isPlayingAnim('sleep') then self.rChar:playAnim('breathe') end end
return CheckInToHospital
