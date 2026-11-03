local Delegate = {}
function Delegate.new()
    local self = {}
    setmetatable(self, { __index = Delegate })
    self._tRecords = {}
    return self
end
function Delegate:dispatch(...)
    local dispatched = nil
    local tUnregisterList = {}
    for _, tRecord in ipairs(self._tRecords) do
        if not tRecord.firstArg then
            dispatched = tRecord.listener(...)
        else
            dispatched = tRecord.listener(tRecord.firstArg, ...)
        end
        if dispatched == nil then
            dispatched = true
        end
    end
    return dispatched
end
function Delegate:register(listener, firstArg)
    local bFound = false
    for i, tRecord in ipairs(self._tRecords) do
        if listener == tRecord.listener and firstArg == tRecord.firstArg then
            bFound = true
            break
        end
    end
    if not bFound then
        local tRecord = {}
        tRecord.listener = listener
        tRecord.firstArg = firstArg
        table.insert(self._tRecords, tRecord)
        Delegate.dRegistered:dispatch( listener, firstArg )
    else
        Trace( TT_Warning, "Trying to register a record that already exists! "..tostring(listener).." "..tostring(firstArg) )
    end
end
function Delegate:unregister(listener, firstArg)
    for i, tRecord in ipairs(self._tRecords) do
        if listener == tRecord.listener and firstArg == tRecord.firstArg then
            table.remove(self._tRecords, i)
            Delegate.dUnregistered:dispatch( listener, firstArg )
            return
        end
    end
end
Delegate.dRegistered = Delegate.new()
Delegate.dUnregistered = Delegate.new()
return Delegate
