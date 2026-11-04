local HK = require('UI.HK')
local function _h1(a0,a1) return {key=a0,color=a1} end
local m = {}
local DFUtil = require("DFCommon.Util")
local UIElement = require('UI.UIElement')
local DFInput = require('DFCommon.Input')
local CommandObject = require('Utility.CommandObject')
local Room = require('Room')
local Base = require('Base')
local EnvObject = nil
local GameRules = nil
local sUILayoutFileName = 'UILayouts/SelectObjectSubmenuLayout'
local nButtonWidth, nButtonHeight  = 430, 81
local nButtonStartY = 278
local nIconX, nIconStartY = 20, -280
local nLabelX, nLabelStartY = 105, -288
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -330
local nIconScale = .6
local kHOTKEYS = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B"}
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    EnvObject = require('EnvObjects/EnvObject')
    GameRules = require('GameRules')
    function Ob:init(sZoneId)
        local tLayoutInfo = self:_loadUIInfoFile(sUILayoutFileName)
        if sZoneId then
            self:addButtonsForZone(sZoneId, tLayoutInfo)
        end
        self:_processUIInfoTable(tLayoutInfo)
        self.rBackButton = self:getTemplateElement('BackButton')
        self.rBackButton:addPressedCallback(self.onBackButtonPressed, self)
        self.rCancelButton = self:getTemplateElement('CancelButton')
        self.rCancelButton:addPressedCallback(self.onCancelButtonPressed, self)
        self.rConfirmButton = self:getTemplateElement('ConfirmButton')
        self.rConfirmButton:addPressedCallback(self.onConfirmButtonPressed, self)
        self.tHotkeyButtons = {}
        self:addHotkey(self:getTemplateElement('BackHotkey').sText, self.rBackButton)
        self:addHotkey(self:getTemplateElement('CancelHotkey').sText, self.rCancelButton)
        self:addHotkey(self:getTemplateElement('ConfirmHotkey').sText, self.rConfirmButton)
        for _,tObj in pairs(self.tObjectTypes) do
            local rButton = self:getTemplateElement(tObj.sId)
			assert(rButton ~= nil)
            rButton:addPressedCallback(self.onObjectButtonPressed, self)
            self:addHotkey(self:getTemplateElement(tObj.sId .. 'Hotkey').sText, rButton)
        end
        self.rNoFundsLabel = self:getTemplateElement('NoFundsLabel')
        self.rLargeBar = self:getTemplateElement('LargeBar')
        local nBarHeight = nButtonStartY + (nButtonHeight * self.nNumObjects)
        self.rLargeBar:setScl(nButtonWidth, nBarHeight)
        self.rEndcap = self:getTemplateElement('SidebarBottomEndcapExpanded')
        local nEndcapY = -(nButtonStartY + (nButtonHeight * self.nNumObjects))
        self.rEndcap:setLoc(0, nEndcapY)
        self.rCostText = self:getTemplateElement('CostText')
        self.sBuildCostLabel = g_LM.line("BUILDM017TEXT")
        self.sVaporizeLabel = g_LM.line("BUILDM018TEXT")
        self.sUndoLabel = g_LM.line("BUILDM019TEXT")
        self:setMatterCostVisible(false)
    end
    Ob.addHotkey = HK.add
    Ob.onKeyboard = HK.key
    function Ob:_getObjectTypesForZone(sZoneId)
        local EnvObjectData = require("EnvObjects.EnvObjectData")
        local tTypesForZone = {}
        for sId, tData in pairs(EnvObjectData.tObjects) do
            if false ~= tData.showInObjectMenu then
                local objZoneName = tData.menuZoneName or tData.zoneName or "ALL"
                if objZoneName == sZoneId and (not tData.researchPrereq or Base.hasCompletedResearch(tData.researchPrereq)) then
					tData.sId = sId
                    tTypesForZone[sId] = tData
                end
            end
        end
        local tSortedTypes = {}
        for i,sType in ipairs(EnvObjectData.tMenus[sZoneId]) do
            table.insert(tSortedTypes, tTypesForZone[sType])
            tTypesForZone[sType] = nil
        end
        for sType,tData in pairs(tTypesForZone) do
            table.insert(tSortedTypes, tData)
        end
        return tSortedTypes
    end
    function Ob:addButtonsForZone(sZoneId, tLayoutInfo)
        local Gui = require('UI.Gui')
        local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
        local BLACK = { Gui.BLACK[1], Gui.BLACK[2], Gui.BLACK[3], 0.95 }
        local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
        local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
        self.tObjectTypes = self:_getObjectTypesForZone(sZoneId)
        self.nNumObjects = 0
        local i = 0
        for _,tObj in pairs(self.tObjectTypes) do
            local buttonKey = tObj.sId
            local buttonData =
            {
                key = buttonKey,
                type = 'onePixelButton',
                pos = { 0, -(nButtonStartY + i * nButtonHeight) },
                scale = { nButtonWidth, nButtonHeight },
                color = BLACK,
                onPressed =
                {
                    _h1(buttonKey, BRIGHT_AMBER),
                },
                onReleased =
                {
                    _h1(buttonKey, AMBER),
                },
                onHoverOn =
                {
                    _h1(buttonKey, Gui.AMBER),
                    _h1(buttonKey .. 'Label', { 0, 0, 0 }),
                    _h1(buttonKey .. 'CostLabel', { 0, 0, 0 }),
                    _h1(buttonKey .. 'Icon', { Gui.AMBER[1],Gui.AMBER[2],Gui.AMBER[3],  1.0}),
                    _h1(buttonKey .. 'Hotkey', { 0, 0, 0 }),
                    {
                    },
                },
                onHoverOff =
                {
                    _h1(buttonKey, Gui.BLACK),
                    _h1(buttonKey .. 'Label', Gui.AMBER),
                    _h1(buttonKey .. 'CostLabel', Gui.AMBER),
                    _h1(buttonKey .. 'Icon', Gui.AMBER),
                    _h1(buttonKey .. 'Hotkey', Gui.AMBER),
                },
            }
            local labelData =
            {
                key = buttonKey .. 'Label',
                type = 'textBox',
                pos = { nLabelX, nLabelStartY - (nButtonHeight * i) },
                linecode = tObj.friendlyNameLinecode,
                style = 'dosisregular40',
                rect = { 0, 300, nButtonWidth, 0 },
                hAlign = MOAITextBox.LEFT_JUSTIFY,
                vAlign = MOAITextBox.LEFT_JUSTIFY,
                color = Gui.AMBER,
            }
            local nCost = tObj.matterCost or 0
            local costLableData =
            {
                key = buttonKey .. 'CostLabel',
                type = 'textBox',
                pos = { nLabelX, nLabelStartY - (nButtonHeight * i) - 42 },
                text = "Cost: " .. tostring(nCost),
                style = 'dosissemibold22',
                rect = { 0, 300, nButtonWidth, 0 },
                hAlign = MOAITextBox.LEFT_JUSTIFY,
                vAlign = MOAITextBox.LEFT_JUSTIFY,
                color = Gui.AMBER,
            }
            local iconData =
            {
                key = buttonKey .. 'Icon',
                type = 'uiTexture',
                textureName = 'ui_iconIso_generic',
                sSpritesheetPath = 'UI/Shared',
                pos = { nIconX, nIconStartY - (nButtonHeight * i) },
                color = Gui.AMBER,
                scale = { nIconScale, nIconScale },
            }
            local hotkeyData =
            {
                key = buttonKey .. 'Hotkey',
                type = 'textBox',
                pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * i) },
                text = kHOTKEYS[i + 1],
                style = 'dosissemibold22',
                rect = { 0, 100, 100, 0 },
                hAlign = MOAITextBox.RIGHT_JUSTIFY,
                vAlign = MOAITextBox.LEFT_JUSTIFY,
                color = Gui.AMBER,
            }
            if tObj.sidebarIcon then iconData.textureName = tObj.sidebarIcon end
            table.insert(tLayoutInfo.tElements, buttonData)
            table.insert(tLayoutInfo.tElements, iconData)
            table.insert(tLayoutInfo.tElements, hotkeyData)
            table.insert(tLayoutInfo.tElements, labelData)
            table.insert(tLayoutInfo.tElements, costLableData)
            self.nNumObjects = self.nNumObjects + 1
            i = self.nNumObjects
        end
    end
    function Ob:onTick(dt)
		if self.sObjectId then
            local nCost = EnvObject.getObjectData(self.sObjectId).matterCost or 0
            local nPendingCost = CommandObject.pendingBuildCost
            if (nCost + nPendingCost) > GameRules.nMatter then
                self.rNoFundsLabel:setVisible(true)
            else
                self.rNoFundsLabel:setVisible(false)
            end
        end
        local sMatterCostText = self:getMatterCostText()
        if sMatterCostText ~= '' then
            self:setMatterCostVisible(true)
            self.rCostText:setString(sMatterCostText)
        else
            self:setMatterCostVisible(false)
        end
    end
    function Ob:onBackButtonPressed(rButton, eventType)
        if eventType == DFInput.TOUCH_UP then
            if g_GuiManager.newSideBar then
                g_GameRules.setUIMode(g_GameRules.MODE_INSPECT)
                g_GuiManager.newSideBar:openSubmenu(g_GuiManager.newSideBar.rObjectMenu)
            end
        end
    end
    function Ob:onCancelButtonPressed(rButton, eventType)
        if eventType == DFInput.TOUCH_UP then
            g_GameRules.cancelBuild()
            g_GuiManager.newSideBar:closeConstructMenu()
        end
    end
    function Ob:onConfirmButtonPressed(rButton, eventType)
        if eventType == DFInput.TOUCH_UP then
            if g_GameRules.confirmBuild() then
                g_GuiManager.newSideBar:closeConstructMenu()
            end
        end
    end
    function Ob:onObjectButtonPressed(rButton, eventType)
        if eventType == DFInput.TOUCH_UP then
            self.sObjectId = rButton.sKey
			local tData = EnvObject.getObjectData(self.sObjectId)
			if tData.door then
				g_GameRules.setUIMode(g_GameRules.MODE_BUILD_DOOR, self.sObjectId)
			else
				g_GameRules.setUIMode(g_GameRules.MODE_PLACE_PROP, self.sObjectId)
			end
        end
    end
    function Ob:setParams(tParams)
        self.tParams = tParams
    end
    function Ob:show(basePri)
        Ob.Parent.show(self, basePri)
    end
    function Ob:hide()
        Ob.Parent.hide(self)
    end
    function Ob:setMatterCostVisible(bVisible)
        if self.bMatterCostVisible ~= bVisible then
            self:applyExtraInfo(bVisible and 'onShowMatterCost' or 'onHideMatterCost')
            self.bMatterCostVisible = bVisible
            self.rConfirmButton:setEnabled(true)
        end
    end
	function Ob:getMatterCostText()
		local text = ''
        local sPlus = ''
        local nPendingBuildCost = g_GameRules.getPendingBuildCost()
        if nPendingBuildCost < 0 then sPlus = '+' else sPlus = '-' end
		if nPendingBuildCost ~= 0 then
            text = sPlus..(math.abs(nPendingBuildCost))..' '..self.sBuildCostLabel..'\n'
		end
        if CommandObject.pendingVaporizeCost > 0 then sPlus = '+' else sPlus = '' end
		if CommandObject.pendingVaporizeCost ~= 0 then
            text = text .. sPlus .. CommandObject.pendingVaporizeCost .. ' ' .. self.sVaporizeLabel .. '\n'
		end
        if CommandObject.pendingCancelCost > 0 then sPlus = '+' else sPlus = '' end
		if CommandObject.pendingCancelCost ~= 0 then
            text = text .. sPlus .. CommandObject.pendingCancelCost .. ' ' .. self.sUndoLabel
		end
		return text
	end
    return Ob
end
m.new = DFUtil.constructor(m)
return m
