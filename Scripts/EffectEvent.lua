local Util = require('DFCommon.Util')
local Class = require('Class')
local SeqCommand = require('SeqCommand')
local EffectEvent = Class.create(SeqCommand)
local DFSchema = require('DFCommon.DFSchema')
local tFields = Util.deepCopy(SeqCommand.rSchema.tFieldSchemas)
SeqCommand.metaFlag(tFields, "EffectEventCommand")
SeqCommand.nonBlocking(tFields)
EffectEvent.rSchema = DFSchema.object(
	tFields,
	"Abstract base class for all effect events."
)
SeqCommand.addEditorSchema('EffectEvent', EffectEvent.rSchema)
function EffectEvent:stop()
end
function EffectEvent:isDone()
    return true
end
return EffectEvent
