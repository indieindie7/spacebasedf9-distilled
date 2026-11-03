local LH=require('UI.LH')
local btn,c,hl,hv,lc,tx=LH.btn,LH.c,LH.hl,LH.hv,LH.lc,LH.tx
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local nButtonWidth, nButtonHeight  = 418, 98
local nLabelX, nLabelStartY = 105, -228
local nHotkeyX, nHotkeyStartY = nButtonWidth - 52, -270
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
        {
            key = 'LargeBar',
            type = 'onePixel',
            pos = { 0, 0 },
            scale = { nButtonWidth, 'g_GuiManager.getUIViewportSizeY()' },
            color = Gui.SIDEBAR_BG,
            bDoRolloverCheck = true,
        },
        btn('BackButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'BackButton',{ 0, 0, 0 },'BackLabel','BackHotkey',true),hv(Gui.BLACK,'BackButton',Gui.AMBER,'BackLabel','BackHotkey'),BRIGHT_AMBER,AMBER),
        lc('MenuSublabel',{ 40, -106 },"HUDHUD020TEXT",'dosissemibold22',{ 0, 100, 200, 0 },Gui.AMBER),
        lc('BackLabel',{ nLabelX, -20 },'HUDHUD009TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        tx('BackHotkey',{ nHotkeyX, -60 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER),
    },
}
