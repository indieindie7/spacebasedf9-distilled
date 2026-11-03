local Delegate = require('DFMoai.Delegate') local Debugger = {} __debuggerHandler = Debugger function Debugger:initialize()
self.dFileChanged = Delegate.new() end function Debugger:sendMessage(messageName, messageParam)
local message = { source = 'dfmoai.debugger', name = messageName, param = messageParam } if DF2hb then DF2hb.sendMessage(message)
elseif MOAIHarness then MOAIHarness.sendMessage(message) end end function Debugger:_updateTable(tTarget, tInput, tVisited)
if not tVisited then tVisited = {} end if tVisited[tTarget] then return end tVisited[tTarget] = true
if type(tTarget) == 'table' and type(tInput) == 'table' then for key, value in pairs(tInput) do tTarget[key] = value end
for key, value in pairs(tTarget) do if type(value) == 'table' then tInputValue = tInput[key] if tInputValue then
self:_updateTable(value, tInputValue, tVisited) end end end end end __debuggerHandler:initialize() return Debugger
