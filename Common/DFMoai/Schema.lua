local Delegate = require('DFMoai.Delegate')
local Schema = {}
Schema.BasicType = {}
Schema.ContainerType = {}
Schema.ArrayType = {}
Schema.ObjectType = {}
Schema.EnumType = {}
Schema.Vec2Type = {}
Schema.Vec3Type = {}
Schema.Vec4Type = {}
Schema.RectType = {}
Schema.PathType = {}
Schema.ColorType = {}
Schema.CurveKeyframeType = {}
Schema.CurveType = {}
local defaultNext = next
local mpNext = function(tTable, key)
    local mt = getmetatable(tTable)
    local nextFunc = mt and mt.__next or defaultNext
    return nextFunc(tTable, key)
end
local mpPairs = function(tTable)
    return next, tTable, nil
end
function Schema.enableMonkeyPatching()
    _G['next'] = mpNext
    _G['pairs'] = mpPairs
end
function Schema.bool(default, sDescription, sGroup)
    return Schema.BasicType.new('bool', default, sDescription, sGroup)
end
function Schema.number(default, sDescription, sGroup)
    return Schema.BasicType.new('number', default, sDescription, sGroup)
end
function Schema.string(default, sDescription, sGroup)
    return Schema.BasicType.new('string', default, sDescription, sGroup)
end
function Schema.table(rValueSchema, sDescription, sGroup)
    return Schema.ContainerType.new(rValueSchema, sDescription, sGroup)
end
function Schema.array(tContainedType, sDescription, sGroup)
    return Schema.ArrayType.new(tContainedType, sDescription, sGroup)
end
function Schema.object(tFieldSchemas, sDescription, sGroup)
    return Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
end
function Schema.enum(default, tCandidates, sDescription, sGroup)
    return Schema.EnumType.new(default, tCandidates, sDescription, sGroup)
end
function Schema.vec2(default, sDescription, sGroup)
    return Schema.Vec2Type.new(default, sDescription, sGroup)
end
function Schema.vec3(default, sDescription, sGroup)
    return Schema.Vec3Type.new(default, sDescription, sGroup)
end
function Schema.vec4(default, sDescription, sGroup)
    return Schema.Vec4Type.new(default, sDescription, sGroup)
end
function Schema.rect(default, sDescription, sGroup)
    return Schema.RectType.new(default, sDescription, sGroup)
end
function Schema.path(default, sRoot, sExtension, sDescription, sGroup)
    return Schema.PathType.new(default, nil, sRoot, sExtension, sDescription, sGroup)
end
function Schema.relativePath(default, sRoot, sSubdir, sExtension, sDescription, sGroup)
    return Schema.PathType.new(default, sRoot, sSubdir, sExtension, sDescription, sGroup)
end
function Schema.color(default, sDescription, sGroup)
    return Schema.ColorType.new(default, sDescription, sGroup)
end
function Schema.curve(default, sDescription, sGroup)
    return Schema.CurveType.new(default, sDescription, sGroup)
end
function Schema.prepareForEditing(tObject, tParent, parentKey)
    if type(tObject) ~= 'table' then
        return
    end
    tObject.__schemaParent = tParent
    tObject.__schemaParentKey = parentKey
    function tObject:path()
        if not tObject.__schemaParent then
            return {}
        else
            local path = tParent:path()
            table.insert(path, parentKey)
            return path
        end
    end
    function tObject:parentContainer()
        return tObject.__schemaParent
    end
    function tObject:parentKey()
        return tObject.__schemaParentKey
    end
    Schema.enableMonkeyPatching()
    local mt = getmetatable(tObject) or {}
    mt.__next = function(tTable, prevKey)
        local key, value = defaultNext(tTable, prevKey)
        while key == 'parentContainer' or key == 'path' or key == 'parentKey' or key == '__schemaParent' or key == '__schemaParentKey' do
            key, value = defaultNext(tTable, key)
        end
        return key, value
    end
    setmetatable(tObject, mt)
    for key, value in pairs(tObject) do
        if type(value) == 'table' and value ~= tObject.__schemaParent and value ~= tObject.__schemaParentKey then
            Schema.prepareForEditing(value, tObject, key)
        end
    end
end
function Schema.new(tTypes, default, sDescription, sGroup)
    local self = {}
    setmetatable(self, { __index = Schema })
    self.tTypes = tTypes
    self.default = default
    self.sDescription = sDescription
    self.sGroup = sGroup
    return self
end
function Schema:getFieldSchema(field)
    return nil
end
function Schema:_getPath(tData, tPath, pathIndex)
    if not pathIndex then
        pathIndex = 1
    end
    if pathIndex > #tPath then
        return tData, self
    end
    local field = tPath[pathIndex]
    local tChild = tData[field]
    local rFieldSchema = self:getFieldSchema(field)
    if pathIndex == #tPath then
        return tChild, rFieldSchema
    end
    if rFieldSchema then
        return rFieldSchema:_getPath(tChild, tPath, pathIndex + 1)
    else
        for i = pathIndex + 1, #tPath do
            field = tPath[i]
            tChild = tChild[field]
        end
        return tChild
    end
end
setmetatable(Schema.BasicType, { __index = Schema })
function Schema.BasicType.new(sTypeName, default, sDescription, sGroup)
    local self = Schema.new({ sTypeName }, default, sDescription, sGroup)
    setmetatable(self, { __index = Schema.BasicType })
    return self
end
setmetatable(Schema.ContainerType, { __index = Schema })
function Schema.ContainerType.new(rValueSchema, sDescription, sGroup)
    local self = Schema.new({ 'table' }, nil, sDescription, sGroup)
    setmetatable(self, { __index = Schema.ContainerType })
    self.rValueSchema = rValueSchema
    self.sDescription = sDescription
    self.sGroup = sGroup
    self.tChangeDelegates = {}
    self.tRecursiveChangeDelegates = {}
    self.tFieldChangeDelegates = {}
    if rValueSchema then
        rValueSchema.rParent = self
    end
    return self
end
function Schema.ContainerType:getFieldSchema(field)
    return self.rValueSchema
end
setmetatable(Schema.ArrayType, { __index = Schema.ContainerType })
function Schema.ArrayType.new(rValueSchema, sDescription, sGroup)
    local self = Schema.ContainerType.new(rValueSchema, sDescription, sGroup)
    setmetatable(self, { __index = Schema.ArrayType })
    table.insert(self.tTypes, 1, 'array')
    self.tInsertDelegates = {}
    self.tRemoveDelegates = {}
    return self
end
setmetatable(Schema.ObjectType, { __index = Schema.ContainerType })
function Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
    local self = Schema.ContainerType.new(nil, sDescription, sGroup)
    setmetatable(self, { __index = Schema.ObjectType })
    table.insert(self.tTypes, 1, 'object')
    self.tFieldSchemas = tFieldSchemas
    for _, rFieldSchema in pairs(tFieldSchemas) do
        rFieldSchema.rParent = self
    end
    return self
end
function Schema.ObjectType:getFieldSchema(field)
    return self.tFieldSchemas[field]
end
setmetatable(Schema.EnumType, { __index = Schema.BasicType })
function Schema.EnumType.new(default, tCandidates, sDescription, sGroup)
    local self = Schema.BasicType.new('enum', default, sDescription, sGroup)
    setmetatable(self, { __index = Schema.EnumType })
    table.insert(self.tTypes, 1, 'enum')
    self.tCandidates = tCandidates
    return self
end
setmetatable(Schema.Vec2Type, { __index = Schema.ObjectType })
function Schema.Vec2Type.new(default, sDescription, sGroup)
    if not default then
        default = {}
    end
    local tFieldSchemas = {
        [1] = Schema.number(default[1], 'X component'),
        [2] = Schema.number(default[2], 'Y component'),
    }
    local self = Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
    setmetatable(self, { __index = Schema.Vec2Type })
    table.insert(self.tTypes, 1, 'vec2')
    self.tDefaultVec = default
    return self
end
setmetatable(Schema.Vec3Type, { __index = Schema.ObjectType })
function Schema.Vec3Type.new(default, sDescription, sGroup)
    if not default then
        default = {}
    end
    local tFieldSchemas = {
        [1] = Schema.number(default[1], 'X component'),
        [2] = Schema.number(default[2], 'Y component'),
        [3] = Schema.number(default[3], 'Z component'),
    }
    local self = Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
    setmetatable(self, { __index = Schema.Vec3Type })
    table.insert(self.tTypes, 1, 'vec3')
    self.tDefaultVec = default
    return self
end
setmetatable(Schema.Vec4Type, { __index = Schema.ObjectType })
function Schema.Vec4Type.new(default, sDescription, sGroup)
    if not default then
        default = {}
    end
    local tFieldSchemas = {
        [1] = Schema.number(default[1], 'X component'),
        [2] = Schema.number(default[2], 'Y component'),
        [3] = Schema.number(default[3], 'Z component'),
        [4] = Schema.number(default[4], 'W component'),
    }
    local self = Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
    setmetatable(self, { __index = Schema.Vec4Type })
    table.insert(self.tTypes, 1, 'vec4')
    self.tDefaultVec = default
    return self
end
setmetatable(Schema.RectType, { __index = Schema.ObjectType })
function Schema.RectType.new(default, sDescription, sGroup)
    if not default then
        default = {}
    end
    local tFieldSchemas = {
        [1] = Schema.number(default[1], 'X minimum'),
        [2] = Schema.number(default[2], 'Y minimum'),
        [3] = Schema.number(default[3], 'X maximum'),
        [4] = Schema.number(default[4], 'Y maximum'),
    }
    local self = Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
    setmetatable(self, { __index = Schema.RectType })
    table.insert(self.tTypes, 1, 'rect')
    return self
end
setmetatable(Schema.PathType, { __index = Schema.BasicType })
function Schema.PathType.new(default, sRoot, sSubdirectory, sExtension, sDescription, sGroup)
    local self = Schema.BasicType.new('string', default, sDescription, sGroup)
    setmetatable(self, { __index = Schema.PathType })
    table.insert(self.tTypes, 1, 'path')
    self.sRoot = sRoot
    self.sExtension = sExtension
    self.sSubdirectory = sSubdirectory
    return self
end
setmetatable(Schema.ColorType, { __index = Schema.ObjectType })
function Schema.ColorType.new(default, sDescription, sGroup)
    if not default then
        default = {}
    end
    local tFieldSchemas = {
        [1] = Schema.number(default[1], 'R component'),
        [2] = Schema.number(default[2], 'G component'),
        [3] = Schema.number(default[3], 'B component'),
        [4] = Schema.number(default[4], 'A component'),
    }
    local self = Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
    setmetatable(self, { __index = Schema.ColorType })
    table.insert(self.tTypes, 1, 'color')
    return self
end
setmetatable(Schema.CurveKeyframeType, { __index = Schema.ObjectType })
function Schema.CurveKeyframeType.new(default, sDescription, sGroup)
    if not default then
        default = {}
    end
    local tFieldSchemas = {
        [1] = Schema.number(default[1], 'Time offset'),
        [2] = Schema.number(default[2], 'Value'),
        [3] = Schema.number(default[3], 'Tangent'),
        [4] = Schema.number(default[4], 'Variance'),
    }
    local self = Schema.ObjectType.new(tFieldSchemas, sDescription, sGroup)
    setmetatable(self, { __index = Schema.CurveKeyframeType })
    table.insert(self.tTypes, 1, 'curve_keyframe')
    return self
end
setmetatable(Schema.CurveType, { __index = Schema.ArrayType })
function Schema.CurveType.new(defaultValue, sDescription, sGroup)
    if not default then
        default = {}
    end
    local rKeyframeType = Schema.CurveKeyframeType.new({ 0, defaultValue, 0, 0 })
    local self = Schema.ArrayType.new(rKeyframeType, sDescription, sGroup)
    setmetatable(self, { __index = Schema.CurveType })
    table.insert(self.tTypes, 1, 'curve')
    self.defaultValue = defaultValue
    return self
end
return Schema
