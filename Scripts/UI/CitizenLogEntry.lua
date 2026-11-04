local m = {}
local DFUtil = require("DFCommon.Util")
local UIElement = require('UI.UIElement')
local DFInput = require('DFCommon.Input')
local GameRules = require('GameRules')
local sUILayoutFileName = 'UILayouts/CitizenLogEntryLayout'
local kBUFFER = 20
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    Ob.nIndex = 1
    function Ob:init()
        self:setRenderLayer('UIScrollLayerLeft')
        Ob.Parent.init(self)
        self:processUIInfo(sUILayoutFileName)
        self.rBGButton = self:getTemplateElement('BGButton')
        self.rDateText = self:getTemplateElement('Date')
        self.rLogText = self:getTemplateElement('LogText')
        self:_calcDimsFromElements()
        self:setLogEntry()
    end
    function Ob:setLogEntry(rEntry)
        local sDateString = ""
        local sLogString = ""
        if rEntry then
            if rEntry.time then
                sDateString = tostring(rEntry.time)
            elseif rEntry.nTime then
				sDateString = GameRules.getFullStarDateString(rEntry.nTime)
			end
            if rEntry.sLine then
                sLogString = rEntry.sLine
            end
        end
        self.rDateText:setString(sDateString)
        self.rLogText:setString(sLogString)
        local length = string.len(sLogString)
        if length > 1 then
            local xMin, yMin, xMax, yMax = self.rLogText:getStringBounds(1, length)
            local nHeight = math.abs(yMax - yMin)
            local nScaleX, nScaleY = self.rBGButton:getScl()
            self.rBGButton:setScl(nScaleX, nHeight + kBUFFER)
            self:_calcDimsFromElements()
        end
    end
    function Ob:getDims()
        return self.rBGButton:getDims()
    end
    function Ob:setIndex(nIndex)
        if nIndex then
            self:applyExtraInfo(nIndex % 2 == 0 and 'evenIndex' or 'oddIndex')
            self.nIndex = nIndex
        end
    end
    return Ob
end
m.new = DFUtil.constructor(m)
return m
