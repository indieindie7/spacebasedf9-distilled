-- Copyright (c) 2012 Double Fine Productions
local Class = {} function Class.create(superclass, baseFactory) local class = {} class.super = superclass class.__baseFactory = baseFactory
local class_metatable = { __index = class } class.new = function(...) local instance = {} if class.__baseFactory then
local baseObject = class.__baseFactory() instance._UserData = baseObject baseObject._Instance = instance instance._Instance = instance
local mt = { } mt.__index = function(t,k) if class[k] then return class[k] end return baseObject[k] end setmetatable(instance, mt) else
setmetatable(instance, class_metatable) end instance:init(...) return instance end if superclass then
setmetatable(class, { __index = superclass }) end function class:is(targetClass) local testClass = class while testClass ~= nil do
if testClass == targetClass then return true else testClass = testClass.super end end end return class end return Class
