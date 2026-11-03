local ffi = require("ffi")
ffi.cdef[[
void DFFFI_test();
typedef struct { double x, y, z; } DFLuaPoint;
void DFFFI_getLoc(void*, DFLuaPoint*);
void DFFFI_modelToWorld(void*, DFLuaPoint*, double, double, double);
]]
local Point = {}
function Point.getLoc(obj)
    if type(obj) == 'table' then
        obj = obj['_UserData']
    end
    local result = ffi.new('DFLuaPoint')
    ffi.C.DFFFI_getLoc(obj, result)
    return result.x, result.y, result.z
end
function Point.modelToWorld(obj, x, y, z)
    if type(obj) == 'table' then
        obj = obj['_UserData']
    end
    local result = ffi.new('DFLuaPoint')
	ffi.C.DFFFI_modelToWorld(obj, result, x or 0, y or 0, z or 0)
	return result.x, result.y, result.z
end
return Point
