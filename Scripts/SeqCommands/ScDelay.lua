local Util = require('DFCommon.Util')
local Class = require('Class')
local SeqCommand = require('SeqCommand')
local ScDelay = Class.create(SeqCommand)
ScDelay.Duration = 0
local DFSchema = require('DFCommon.DFSchema')
local tFields = Util.deepCopy(SeqCommand.rSchema.tFieldSchemas)
tFields['Duration'] = DFSchema.number(0, "Seconds to wait before executing the next command")
SeqCommand.metaPriority(tFields, -1000)
SeqCommand.implicitlyBlocking(tFields)
ScDelay.rSchema = DFSchema.object(
    tFields,
    "Creates a new instance of the specified protoype at the given location."
)
SeqCommand.addEditorSchema('ScDelay', ScDelay.rSchema)
function ScDelay:onExecute()
    if self:_getDebugFlags().DebugExecution then
        Trace("Waiting " .. tostring(self.Duration) .. " seconds")
    end
    if not self.bSkip then
        local duration = self.Duration
        local endTime = nil
        if self.rSequence.rSyncTimer then
            local curTime = self.rSequence.rSyncTimer:getTime()
            local slippedTime = curTime - self.StartTime
            duration = duration - slippedTime
            endTime = self.StartTime + duration
            if duration > 0.04 then
                duration = duration - 0.04
            end
        end
        local rTimer = MOAITimer.new()
        rTimer:setType(MOAIAction.ACTIONTYPE_GAMEPLAY)
        rTimer:setSpan(0, duration)
        rTimer:start()
        while rTimer:isBusy() and not self.bSkip do
            coroutine.yield()
        end
        rTimer:stop()
        if endTime then
            local curTime = self.rSequence.rSyncTimer:getTime()
            local overhangTime = curTime - endTime
            if overhangTime < -0.032 then
                coroutine.yield()
            end
        end
    end
end
return ScDelay
