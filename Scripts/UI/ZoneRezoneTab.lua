local m = {}
local DFUtil = require("DFCommon.Util")
local DFInput = require('DFCommon.Input')
local ScrollableUI = require('UI.ScrollableUI')
local UIElement = require('UI.UIElement')
local ZoneRezoneButton = require('UI.ZoneRezoneButton')
local sUILayoutFileName = 'UILayouts/ZoneRezoneTabLayout'
local tZoneOptions =
{
    {
        name = "ZONEUI036TEXT",
        desc = "INSPEC034TEXT",
        propdesc = "INSPEC041TEXT",
        zoneName = 'AIRLOCK',
    },
    {
        name = "ZONEUI001TEXT",
        desc = "INSPEC035TEXT",
        propdesc = "INSPEC042TEXT",
        zoneName= 'LIFESUPPORT',
    },
    {
        name = "ZONEUI003TEXT",
        desc = "INSPEC036TEXT",
        propdesc = "INSPEC043TEXT",
        zoneName = 'POWER',
    },
    {
        name = "ZONEUI037TEXT",
        desc = "INSPEC037TEXT",
        propdesc = "INSPEC044TEXT",
        zoneName = 'REFINERY',
    },
    {
        name = "ZONEUI042TEXT",
        desc = "INSPEC038TEXT",
        propdesc = "INSPEC045TEXT",
        zoneName = 'RESIDENCE',
    },
    {
        name = "ZONEUI046TEXT",
        desc = "INSPEC039TEXT",
        propdesc = "INSPEC046TEXT",
        zoneName = 'PUB',
    },
    {
        name = "ZONEUI069TEXT",
        desc = "INSPEC083TEXT",
        propdesc = "INSPEC084TEXT",
        zoneName = 'GARDEN',
    },
    {
        name = "ZONEUI109TEXT",
        desc = "INSPEC116TEXT",
        propdesc = "INSPEC115TEXT",
        zoneName = 'FITNESS',
    },
    {
        name = "ZONEUI126TEXT",
        desc = "INSPEC119TEXT",
        propdesc = "INSPEC120TEXT",
        zoneName = 'RESEARCH',
    },
    {
        name = "ZONEUI049TEXT",
        desc = "INSPEC138TEXT",
        propdesc = "INSPEC139TEXT",
        zoneName = 'INFIRMARY',
    },
    {
        name = "ZONEUI142TEXT",
        desc = "ZONEUI143TEXT",
        propdesc = "ZONEUI144TEXT",
        zoneName = 'BRIG',
    },
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
