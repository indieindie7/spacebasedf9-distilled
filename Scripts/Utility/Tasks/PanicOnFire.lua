local Task=require('Utility.Task') local World=require('World') local Class=require('Class')
local PanicFire=require('Utility.Tasks.PanicFire') local Fire=require('Fire') local Character=require('CharacterConstants')
local PanicOnFire = Class.create(PanicFire) PanicOnFire.DEATH_DELAY = 500 PanicOnFire.DEATH_CHANCE = 0.04 PanicOnFire.EXTINGUISH_DELAY = 8
PanicOnFire.EXTINGUISH_CHANCE = 0.04 function PanicOnFire:init(rChar,tPromisedNeeds,rActivityOption)
PanicFire.init(self,rChar,tPromisedNeeds,rActivityOption) self.onFireTime = 0 local wx,wy = rChar:getLoc()
self.flame = require('Flame').new(wx,wy, rChar.tHackEntity) end function PanicOnFire:onUpdate(dt) if self.currentTaskIdle then
self.idleTime = self.idleTime - dt if self.idleTime < 0 then self:_walk() end else if self:tickWalk(dt) then self:_idle() end end
self.onFireTime = self.onFireTime + dt if self.onFireTime >= PanicOnFire.EXTINGUISH_DELAY then
if math.random() < PanicOnFire.EXTINGUISH_CHANCE + ((self.onFireTime-PanicOnFire.EXTINGUISH_DELAY) * PanicOnFire.EXTINGUISH_CHANCE) then
return true end end end function PanicOnFire:onComplete(bSuccess) Task.onComplete(self,bSuccess) self.flame:extinguish() self.flame = nil
self.rChar:douseFire() print(self.rChar.tStats.sName .. ' extinguished.') end return PanicOnFire
