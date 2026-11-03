local function _h1(a0,a1,a2) return {enum=a0,name=a1,desc=a2} end
local m = {}
local DFUtil = require("DFCommon.Util")
local Character = require('Character')
local CitizenDutyButton = require('UI.CitizenDutyButton')
local UIElement = require('UI.UIElement')
local sUILayoutFileName = 'UILayouts/CitizenDutyTabLayout'
local tJobOptions =
{
    _h1(Character.UNEMPLOYED, "DUTIES001TEXT", "DUTIES002TEXT"),
    _h1(Character.BUILDER, "DUTIES003TEXT", "DUTIES004TEXT"),
    _h1(Character.TECHNICIAN, "DUTIES005TEXT", "DUTIES006TEXT"),
    _h1(Character.MINER, "DUTIES007TEXT", "DUTIES008TEXT"),
    _h1(Character.EMERGENCY, "DUTIES009TEXT", "DUTIES010TEXT"),
    _h1(Character.BARTENDER, "DUTIES013TEXT", "DUTIES014TEXT"),
    _h1(Character.BOTANIST, "DUTIES016TEXT", "DUTIES017TEXT"),
    _h1(Character.SCIENTIST, "DUTIES018TEXT", "DUTIES019TEXT"),
    _h1(Character.DOCTOR, "DUTIES020TEXT", "DUTIES021TEXT"),
}
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    Ob.rCitizen = nil
    Ob.tButtons = {}
    Ob.bDoRolloverCheck = true
    function Ob:init()
        self:processUIInfo(sUILayoutFileName)
        Ob.Parent.init(self)
        local y=0
        for i, rDutyInfo in ipairs(tJobOptions) do
            local rButton = CitizenDutyButton.new(rDutyInfo)
            local w,h = rButton:getDims()
            self:addElement(rButton)
            rButton:setLoc(0,y)
            y=y+h
            table.insert(self.tButtons, rButton)
        end
    end
    function Ob:show(n)
        local n2 = Ob.Parent.show(self,n)
        return n2
    end
    function Ob:hide()
        Ob.Parent.hide(self)
    end
    function Ob:setCitizen(rCitizen)
        self.rCitizen = rCitizen
        for i, rButton in ipairs(self.tButtons) do
            rButton:setCitizen(rCitizen)
        end
    end
    function Ob:setHostileMode(bSet)
        self.bHostileMode = bSet
        if bSet then
            local tOverrides = self:getExtraTemplateInfo('tHostileMode')
            if tOverrides then
                self:applyTemplateInfos(tOverrides)
            end
        else
            local tOverrides = self:getExtraTemplateInfo('tCitizenMode')
            if tOverrides then
                self:applyTemplateInfos(tOverrides)
            end
        end
    end
    function Ob:onTick(dt)
        for i, rButton in ipairs(self.tButtons) do
            rButton:onTick(dt)
        end
    end
    function Ob:onFinger(touch, x, y, props)
        local bHandled = false
        for i, rButton in ipairs(self.tButtons) do
            bHandled = rButton:onFinger(touch, x, y, props) or bHandled
        end
        return bHandled
    end
    function Ob:inside(wx, wy)
        local bInside = Ob.Parent.inside(self, wx, wy)
        for i, rButton in ipairs(self.tButtons) do
            bInside = rButton:inside(wx, wy) or bInside
        end
        return bInside
    end
    return Ob
end
function m.new(...)
    local Ob = m.create()
    Ob:init(...)
    return Ob
end
return m
