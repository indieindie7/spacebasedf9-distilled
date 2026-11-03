local HK = require('UI.HK')
local m = {}
local DFUtil = require("DFCommon.Util")
local DFInput = require("DFCommon.Input")
local UIElement = require('UI.UIElement')
local SoundManager = require('SoundManager')
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    Ob.tEventData = nil
    Ob.sRenderLayerName = 'UIForeground'
    function Ob:init(sLayoutFile, cb, sAcceptButton, sDeclineButton, sAcceptHotkey, sDeclineHotkey)
        self:processUIInfo(sLayoutFile)
        self.cb = cb
        local rAcceptButton = self:getTemplateElement(sAcceptButton or 'AcceptButton')
        local rDeclineButton = self:getTemplateElement(sDeclineButton or 'DeclineButton')
        if rAcceptButton then rAcceptButton:addPressedCallback(function(rButton,eventType) self:pressed(true,eventType) end) end
        if rDeclineButton then rDeclineButton:addPressedCallback(function(rButton,eventType) self:pressed(false,eventType) end) end
        self.tHotkeyButtons = {}
        local rAcceptHotkey = self:getTemplateElement(sAcceptHotkey or 'AcceptHotkey')
        local rDeclineHotkey = self:getTemplateElement(sDeclineHotkey or 'DeclineHotkey')
        if rAcceptHotkey then
            self:addHotkey(rAcceptHotkey.sText, rAcceptButton)
        end
        if rDeclineHotkey then
            self:addHotkey(rDeclineHotkey.sText, rDeclineButton)
        end
    end
    Ob.addHotkey = HK.add
    Ob.onKeyboard = HK.key
    function Ob:replaceText(tReplacements)
        for k,v in pairs(tReplacements) do
            local r = self:getTemplateElement(k)
            if r then
                r:setString(g_LM.line(v))
            end
        end
    end
    function Ob:pressed(bAccept,eventType)
        if eventType == DFInput.TOUCH_UP then
            self.cb(bAccept)
            g_GuiManager.removeFromPopupQueue(self, true)
            SoundManager.playSfx('confirm')
        end
    end
    function Ob:show(nPri)
        local nPri = Ob.Parent.show(self, nPri)
        g_GuiManager.createEffectMaskBox(500, 0, 850, 800, 0.3, 2)
        SoundManager.playSfx('inspectorshow')
        return nPri
    end
    return Ob
end
function m.new(...)
    local Ob = m.create()
    Ob:init(...)
    return Ob
end
return m
