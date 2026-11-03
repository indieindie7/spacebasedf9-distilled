local LH=require('UI.LH')
local btn,lc,px,tex,tx=LH.btn,LH.lc,LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 330, 81
local nTextHeight = nButtonHeight + 20
local nButtonStartY = -134
local nIconX, nIconStartY = 10, -136
local nDoneIconStartY = -2
local nLabelX, nLabelStartY = 94, -144
local nLabelNoIconX, nLabelButtonStartY = 10, -10
local nDoneLabelStartY = -10
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -180
local nDoneHotkeyY = -46
local nIconScale = .6
local numButtons = 4
local nBGWidth = 160
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
        px('LargeBar',{ 0, 0 },{ nButtonWidth, -nButtonStartY + (nButtonHeight * numButtons) },Gui.SIDEBAR_BG),
        btn('DoneButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,{ { key = 'DoneButton', color = Gui.AMBER, }, { key = 'DoneLabel', color = Gui.BLACK, }, { key = 'DoneHotkey', color = Gui.BLACK, }, },{ { key = 'DoneButton', color = Gui.BLACK, }, { key = 'DoneLabel', color = Gui.AMBER, }, { key = 'DoneHotkey', color = Gui.AMBER, }, }),
        btn('ClearBeaconButton',{ 0, nButtonStartY },{ nButtonWidth, nButtonHeight },Gui.BLACK,{ { key = 'ClearBeaconButton', color = Gui.AMBER, }, { key = 'ClearBeaconLabel', color = Gui.BLACK, }, { key = 'ClearBeaconIcon', color = Gui.BLACK, }, { key = 'ClearBeaconHotkey', color = Gui.BLACK, }, },{ { key = 'ClearBeaconButton', color = Gui.BLACK, }, { key = 'ClearBeaconLabel', color = Gui.AMBER, }, { key = 'ClearBeaconIcon', color = Gui.AMBER, }, { key = 'ClearBeaconHotkey', color = Gui.AMBER, }, }),
        tex('ClearBeaconIcon','ui_iconIso_erase','UI/Shared',{ nIconX, nIconStartY },Gui.AMBER,{ nIconScale, nIconScale }),
        lc('ClearBeaconLabel',{ nLabelX, nLabelStartY },'HUDHUD037TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        {
            key = 'ViolenceLowButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/SidebarButtonLayout',
            replacements = {
                SidebarLabel={linecode='HUDHUD051TEXT', pos={nLabelNoIconX, nLabelButtonStartY}, color=Gui.GREEN},
                SidebarIcon={hidden=true, },
            },
            buttonName='SidebarButton',
            pos = { 0, nButtonStartY-nButtonHeight },
        },
        {
            key = 'ViolenceDefaultButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/SidebarButtonLayout',
            replacements = {
                SidebarLabel={linecode='HUDHUD049TEXT', pos={nLabelNoIconX, nLabelButtonStartY} },
                SidebarIcon={hidden=true, },
            },
            buttonName='SidebarButton',
            pos = { 0, nButtonStartY-nButtonHeight*2 },
        },
        {
            key = 'ViolenceHighButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/SidebarButtonLayout',
            replacements = {
                SidebarLabel={linecode='HUDHUD050TEXT', pos={nLabelNoIconX, nLabelButtonStartY}, color=Gui.RED},
                SidebarIcon={ hidden=true, },
            },
            buttonName='SidebarButton',
            pos = { 0, nButtonStartY-nButtonHeight*3 },
        },
        lc('MenuSublabel',{ 40, -90 },"HUDHUD036TEXT",'dosissemibold22',{ 0, 100, 100, 0 },Gui.GREY),
        lc('DoneLabel',{ nLabelX, nDoneLabelStartY },'HUDHUD035TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        tx('DoneHotkey',{ nHotkeyX, nDoneHotkeyY },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ClearBeaconHotkey',{ nHotkeyX, nHotkeyStartY },'X','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, nButtonStartY - numButtons*nButtonHeight },Gui.SIDEBAR_BG,{ 1.28, 1.28 }),
    },
}
