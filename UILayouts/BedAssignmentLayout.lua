local LH=require('UI.LH')
local lc,px=LH.lc,LH.px
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 286, 98
local nHotkeyX, nHotkeyStartY = nButtonWidth - 110, -68
local nScrollAreaTopMargin = 160
local nRoomScrollerX = 400
local nZoneButtonX = 16
local nHeadingY = 110
local nHeadingHeight = 90
local nHeadingLineWidth = 4
local nZoneHeadingWidth = 402
local nProjectHeadingX = nZoneHeadingWidth + nZoneButtonX + 4
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
            key = 'ZoneScrollPane',
            type = 'scrollPane',
            pos = { nRoomScrollerX, -nScrollAreaTopMargin },
            rect = { 0, 0, 925, 'g_GuiManager.getUIViewportSizeY() - 192' },
            scissorLayerName='UIScrollLayerLeft',
        },
        {
            key = 'CancelButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/ActionButtonLayout',
            replacements = {
                ActionLabel={linecode='INSPEC161TEXT'},
            },
            buttonName='ActionButtonTexture',
            pos = { nRoomScrollerX, -20 },
        },
        lc('SelectBedLabel',{ 380, -20 },'INSPEC162TEXT','dosismedium44',{ 0, 300, 400, 0 },Gui.AMBER),
        px('ZoneHeadingShade',{ nZoneButtonX, -nHeadingY },{ nZoneHeadingWidth, nHeadingHeight },Gui.AMBER_OPAQUE),
        px('ZoneHeadingDiv',{ nZoneButtonX, -(nHeadingY + nHeadingHeight) },{ nZoneHeadingWidth, nHeadingLineWidth },Gui.AMBER),
        lc('ZoneHeadingText',{ nZoneButtonX + 32, -nHeadingY - nHeadingHeight + 40 },'RSCHUI003TEXT','dosissemibold26',{ 0, 300, 200, 0 },Gui.AMBER),
    },
}
