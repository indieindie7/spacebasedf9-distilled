local function _h1(a0,a1,a2,a3) return {name=a0,desc=a1,propdesc=a2,zoneName=a3} end
local m = {}
local DFUtil = require("DFCommon.Util")
local DFInput = require('DFCommon.Input')
local ScrollableUI = require('UI.ScrollableUI')
local UIElement = require('UI.UIElement')
local ZoneRezoneButton = require('UI.ZoneRezoneButton')
local sUILayoutFileName = 'UILayouts/ZoneRezoneTabLayout'
local tZoneOptions =
{
    _h1("ZONEUI036TEXT", "INSPEC034TEXT", "INSPEC041TEXT", 'AIRLOCK'),
    _h1("ZONEUI001TEXT", "INSPEC035TEXT", "INSPEC042TEXT", 'LIFESUPPORT'),
    _h1("ZONEUI003TEXT", "INSPEC036TEXT", "INSPEC043TEXT", 'POWER'),
    _h1("ZONEUI037TEXT", "INSPEC037TEXT", "INSPEC044TEXT", 'REFINERY'),
    _h1("ZONEUI042TEXT", "INSPEC038TEXT", "INSPEC045TEXT", 'RESIDENCE'),
    _h1("ZONEUI046TEXT", "INSPEC039TEXT", "INSPEC046TEXT", 'PUB'),
    _h1("ZONEUI069TEXT", "INSPEC083TEXT", "INSPEC084TEXT", 'GARDEN'),
    _h1("ZONEUI109TEXT", "INSPEC116TEXT", "INSPEC115TEXT", 'FITNESS'),
    _h1("ZONEUI126TEXT", "INSPEC119TEXT", "INSPEC120TEXT", 'RESEARCH'),
    _h1("ZONEUI049TEXT", "INSPEC138TEXT", "INSPEC139TEXT", 'INFIRMARY'),
    _h1("ZONEUI142TEXT", "ZONEUI143TEXT", "ZONEUI144TEXT", 'BRIG'),
    {
        name = "ZONEUI005TEXT",
        desc = "INSPEC040TEXT",
        zoneName= 'PLAIN',
    },
}
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    Ob.rZone = nil
    Ob.bDoRolloverCheck = true
    Ob.tButtons = {}
    function Ob:init()
        self:processUIInfo(sUILayoutFileName)
        Ob.Parent.init(self)
        local y=0
        for i, rZoneInfo in ipairs(tZoneOptions) do
            local rButton = ZoneRezoneButton.new(rZoneInfo)
            local w,h = rButton:getDims()
            self:addElement(rButton)
            rButton:setLoc(0,y)
            y=y+h
            table.insert(self.tButtons, rButton)
        end
        self:_calcDimsFromElements()
    end
    function Ob:setRoom(rRoom)
        self.rRoom = rRoom
        for i, rButton in ipairs(self.tButtons) do
            rButton:setRoom(rRoom)
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
            bHandled = rButton:onFinger(touch, x, y, props)
        end
        return bHandled
    end
    function Ob:inside(wx, wy)
        Ob.Parent.inside(self, wx, wy)
        for i, rButton in ipairs(self.tButtons) do
            rButton:inside(wx, wy)
        end
    end
    return Ob
end
function m.new(...)
    local Ob = m.create()
    Ob:init(...)
    return Ob
end
return m
