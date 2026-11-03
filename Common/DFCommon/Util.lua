local m = {}
TT_Cache = -6
TT_Info = -5
TT_Gameplay = -4
TT_System = -3
TT_Error = -2
TT_Warning = -1
TT_ENABLED = {
    [TT_Error]=true,
    [TT_Warning]=true,
    [TT_System]=true,
    [TT_Gameplay]=true,
    [TT_Info]=true,
}
function Trace(tt, ...)
    if type(tt) ~= 'number' then
        return Trace(TT_Info, tt, ...)
    elseif not TT_ENABLED[tt] then
        return
    end
    local fmt = ...
    if tt == TT_Error then
        MOAILogMgr.log(debug.traceback())
        fmt = 'ERROR ' .. fmt
    elseif tt == TT_Warning then
        fmt = 'WARN ' .. fmt
    end
    if select('#', ...) == 1 then
        MOAILogMgr.log(fmt)
    else
        MOAILogMgr.log(string.format(fmt, select(2, ...)))
    end
end
function Print(tt, ...)
    assert(type(tt) == 'number')
    if not TT_ENABLED[tt] then
        return
    end
    local n = select('#', ...)
    local txt = ...
    txt = tostring(txt)
    if tt == TT_Error then
        MOAILogMgr.log(debug.traceback())
        txt = 'ERROR ' .. txt
    elseif tt == TT_Warning then
        txt = 'WARN ' .. txt
    end
    for i = 2,n do
        txt = string.format('%s\t%s', txt, tostring(select(i, ...)))
    end
    MOAILogMgr.log(txt)
end
function m.printTable(t, ttype, prefix, max)
    max = max or 1000
    prefix = prefix or ""
    if not t or not type(t) == "table" then
        Print(ttype, prefix.."NIL")
        return
    end
    for k,v in pairs(t) do
        Print(ttype, prefix,tostring(k),tostring(v))
        if type(v) == "table" then
            if max > 1 then
                m.printTable(v, ttype, prefix .. " - ", max - 1)
            end
        end
    end
end
function m.copy(object)
    assert(not rawget(object, 'NO_DEEP_COPY'))
    local new_table = {}
    for k, v in pairs(object) do
        new_table[k] = v
    end
    setmetatable(new_table, getmetatable(object))
    return new_table
end
function m.copyi(object)
    assert(not rawget(object, 'NO_DEEP_COPY'))
    local new_table = {}
    for k, v in ipairs(object) do
        new_table[k] = v
    end
    setmetatable(new_table, getmetatable(object))
    return new_table
end
function m.deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        assert(not rawget(object, 'NO_DEEP_COPY'))
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end
function m.assert(cond, ...)
    if not cond then
        assert(cond, ...)
    end
end
function m.timedCallback(delay, actionType, loop, func, ...)
    local timer = MOAITimer.new()
    timer:setType(actionType)
    timer:setSpan( delay )
    if loop then timer:setMode(MOAITimer.LOOP) end
    local args = {...}
    timer:setListener( MOAITimer.EVENT_TIMER_END_SPAN, function () func(unpack(args)) end)
    timer:start()
    return timer
end
function m.sleep(time, actionType)
	local rTimer = MOAITimer.new()
    if actionType then
        rTimer:setType(actionType)
    end
	rTimer:setSpan(0, time)
    MOAICoroutine.blockOnAction(rTimer:start())
end
function m.split(input, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    input:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end
function m.removeFromArray(array, removeValue)
    for index, value in ipairs(array) do
        if value == removeValue then
            table.remove(array, index)
            return
        end
    end
end
function m.tableMergeNew(t1,t2)
    local t3 = {}
    for k,v in pairs(t1) do t3[k] = v end
    for k,v in pairs(t2) do t3[k] = v end
    return t3
end
function m.tableSize(table)
    local count = 0
    for k,v in pairs(table) do
        count = count + 1
    end
    return count
end
function m.tableRandom(table, tableSize)
    if tableSize == nil then
        tableSize = m.tableSize(table)
    end
    local maxstep = math.random(1,tableSize)
    local count = 0
    for k,v in pairs(table) do
        count = count + 1
        if count == maxstep then
            return v, k
        end
    end
end
function m.arrayRandom(array)
    return array[math.random(1,#array)]
end
function m.arrayRandomExcept(array,except)
    if not except then return m.arrayRandom(array) end
    local len = #array-1
    local idx = math.random(1,len)
    if idx >= except then idx = idx+1 end
    return array[idx]
end
function m.arrayShuffle(array)
    local n = #array
    while n >= 2 do
        local k = math.random(n)
        array[n], array[k] = array[k], array[n]
        n = n - 1
    end
    return array
end
function m.createSubclass(parentClass)
	assert(parentClass)
	local klass = {}
	klass.Parent = parentClass
	setmetatable(klass, { __index = parentClass })
    while parentClass do
        klass._UserData = parentClass
        parentClass = parentClass.Parent
    end
	return klass
end
function m.findFileCase(dir, filename)
    if not MOAIFileSystem.checkPathExists(dir) then
        return
    end
    filename = string.lower(filename)
    for _, f in ipairs(MOAIFileSystem.listFiles(dir)) do
        if string.lower(f) == filename then
            return f
        end
    end
end
local weakIndex = function(t, k)
    local ref = rawget(t, '_UserData')
    return ref[k]
end
local weakRefMT = {
    __mode = 'v',
    __index = weakIndex,
}
return m
