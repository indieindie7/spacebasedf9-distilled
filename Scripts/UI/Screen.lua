local Class = require('Class')
local Screen = Class.create()

Screen.INPUTMODE_NONE = 1
Screen.INPUTMODE_NORMAL = 2
Screen.INPUTMODE_EXCLUSIVE = 3

-- CONSTRUCTOR --
function Screen:init()
	
    self.sName = "N/A"
	self.bIsOpaque = true
	self.inputMode = Screen.INPUTMODE_EXCLUSIVE

    self:created()
    
	return self
end

-- ABSTRACT FUNCTIONS --
function Screen:onCreated()
end

function Screen:onAdded()
end

function Screen:onRemoved()
end

function Screen:onUpdateStatus(deltaTime)
end

function Screen:onAddLayers(tRenderLayers)
end

function Screen:onPointer(tPointer, bDoubleTap)
    return false
end

function Screen:onHover(x, y)
    return false
end

function Screen:onKeyboard(key, bKeyDown)
    return false
end

-- PUBLIC BASECLASS FUNCTIONS (to prevent the subclasses from having to call the Parent's in the normal case)
function Screen:created()
    self:onCreated()
end

function Screen:added()
    self:onAdded()
end

function Screen:removed()
    self:onRemoved()
end

function Screen:updateStatus(deltaTime)
    self:onUpdateStatus(deltaTime)
end

function Screen:addLayers(tRenderLayers)
    self:onAddLayers(tRenderLayers)
end

function Screen:inputPointer(tPointer, bDoubleTap)
    return self:onPointer(tPointer, bDoubleTap)
end

function Screen:inputHover(x,y)
    return self:onHover(x,y)
end

function Screen:inputKeyboard(key, bKeyDown)
    return self:onKeyboard(key, bKeyDown)
end

-- PROTECTED FUNCTIONS

return Screen