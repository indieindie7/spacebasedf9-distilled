local LH=require('UI.LH')
local lc,px,tx=LH.lc,LH.px,LH.tx
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 286, 98
local nHotkeyX, nHotkeyStartY = nButtonWidth - 110, -68
local nScrollAreaTopMargin = 160
local nZoneButtonX = 16
local nHeadingY = 110
local nHeadingHeight = 90
local nHeadingLineWidth = 4
local nZoneHeadingWidth = 402
local nProjectHeadingX = nZoneHeadingWidth + nZoneButtonX + 4
local nProjectHeadingWidth = 480
local nProjectTabY = 48
local nProjectTabScale = 1.25
return
{
    posInfo =
        {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
        scale = { 1, 1 },
    },
    tElements =
    {
        px('LargeBar',{ 0, 0 },{ 'g_GuiManager.getUIViewportSizeX()', 'g_GuiManager.getUIViewportSizeY()' },Gui.SIDEBAR_BG),
        {
            key = 'ProjectScrollPane',
            type = 'scrollPane',
            pos = { 1000, -nScrollAreaTopMargin },
            rect = { 0, 0, 970, '(g_GuiManager.getUIViewportSizeY() - 192)' },
            scissorLayerName='UIScrollLayerRight',
        },
        {
            key = 'ZoneScrollPane',
            type = 'scrollPane',
            pos = { 0, -nScrollAreaTopMargin },
            rect = { 0, 0, 925, 'g_GuiManager.getUIViewportSizeY() - 192' },
            scissorLayerName='UIScrollLayerLeft',
        },
        {
            key = 'BackButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'BackButton', color = Gui.AMBER, },
            },
            onReleased =
            {
                { key = 'BackButton', color = Gui.AMBER, },
            },
            onHoverOn =
            {
                { key = 'BackButton', color = Gui.AMBER, },
                { key = 'BackLabel', color = Gui.BLACK },
                { key = 'BackHotkey', color = Gui.BLACK },
            },
            onHoverOff =
            {
                { key = 'BackButton', color = Gui.BLACK, },
                { key = 'BackLabel', color = Gui.AMBER, },
                { key = 'BackHotkey', color = Gui.AMBER, },
            },
        },
        lc('BackLabel',{ 96, -20 },'HUDHUD035TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        tx('BackHotkey',{ nHotkeyX, -60 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        lc('ResearchLabel',{ 380, -20 },'HUDHUD048TEXT','dosismedium44',{ 0, 300, 400, 0 },Gui.AMBER),
        px('ZoneHeadingShade',{ nZoneButtonX, -nHeadingY },{ nZoneHeadingWidth, nHeadingHeight },Gui.AMBER_OPAQUE),
        px('ZoneHeadingDiv',{ nZoneButtonX, -(nHeadingY + nHeadingHeight) },{ nZoneHeadingWidth, nHeadingLineWidth },Gui.AMBER),
        lc('ZoneHeadingText',{ nZoneButtonX + 32, -nHeadingY - nHeadingHeight + 40 },'RSCHUI003TEXT','dosissemibold26',{ 0, 300, 200, 0 },Gui.AMBER),
        px('ProjectHeadingShade',{ nProjectHeadingX, -nHeadingY },{ nProjectHeadingWidth, nHeadingHeight },Gui.AMBER_OPAQUE),
        px('ProjectHeadingDiv',{ nProjectHeadingX, -(nHeadingY + nHeadingHeight) },{ nProjectHeadingWidth, nHeadingLineWidth },Gui.AMBER),
        lc('ProjectHeadingText',{ nProjectHeadingX + 32, -nHeadingY - nHeadingHeight + 40 },'RSCHUI004TEXT','dosissemibold26',{ 0, 300, 200, 0 },Gui.AMBER),
        {
            key = 'TechTabButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/TabButtonLayout',
            replacements = {
                TabText={linecode='RSCHUI005TEXT'},
                ActiveTabTexture={scale = {nProjectTabScale, nProjectTabScale},},
                InactiveTabTexture={scale = {nProjectTabScale, nProjectTabScale},},
            },
            buttonName='ActiveTabTexture',
            pos = { 1000, -nProjectTabY },
        },
        {
            key = 'DiseaseTabButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/TabButtonLayout',
            replacements = {
                TabText={linecode='RSCHUI006TEXT'},
                ActiveTabTexture={scale = {nProjectTabScale, nProjectTabScale},},
                InactiveTabTexture={scale = {nProjectTabScale, nProjectTabScale},},
            },
            buttonName='ActiveTabTexture',
            pos = { 1000 + 172 * nProjectTabScale - 5, -nProjectTabY },
        },
		px('TabLine',{ 1000 + (172 * nProjectTabScale * 2) - 5, -nProjectTabY - (42 * nProjectTabScale) + 3},{ 515, 4 },Gui.AMBER),
    },
}
