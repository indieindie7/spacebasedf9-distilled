local LH=require('UI.LH')
local btn,hl,lc,px,tex,tx=LH.btn,LH.hl,LH.lc,LH.px,LH.tex,LH.tx
local function _h1(a0,a1) return {SidebarLabel=a0,SidebarIcon=a1} end
local function _h2(a0,a1,a2,a3,a4,a5) return {key=a0,type=a1,layoutFile=a2,replacements=a3,buttonName=a4,pos=a5} end
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
local numButtons = 8
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
        btn('DoneButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,{ { key = 'DoneButton', color = Gui.AMBER, }, { key = 'DoneLabel', color = Gui.BLACK, }, { key = 'DoneHotkey', color = Gui.BLACK, }, hl(), },{ { key = 'DoneButton', color = Gui.BLACK, }, { key = 'DoneLabel', color = Gui.AMBER, }, { key = 'DoneHotkey', color = Gui.AMBER, }, }),
        lc('DoneLabel',{ nLabelX, nDoneLabelStartY },'HUDHUD035TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        tx('DoneHotkey',{ nHotkeyX, nDoneHotkeyY },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        lc('MenuSublabel',{ 40, -90 },"HUDHUD053TEXT",'dosissemibold22',{ 0, 100, 200, 0 },Gui.GREY),
        _h2('FireButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD054TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY }),
        _h2('MeteorButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD055TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY-nButtonHeight }),
        _h2('KillbotButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD056TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY-nButtonHeight*2 }),
        _h2('RaiderButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD057TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY-nButtonHeight*3 }),
        _h2('BreachButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD058TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY-nButtonHeight*4 }),
        _h2('ParasiteButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD059TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY-nButtonHeight*5 }),
        _h2('DerelictButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD060TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY-nButtonHeight*6 }),
        _h2('DockButton', 'templateButton', 'UILayouts/SidebarButtonLayout', _h1({linecode='HUDHUD061TEXT', pos={nLabelNoIconX, nLabelButtonStartY}}, {hidden=true, }), 'SidebarButton', { 0, nButtonStartY-nButtonHeight*7 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, nButtonStartY - numButtons*nButtonHeight },Gui.SIDEBAR_BG,{ 1.28, 1.28 }),
    },
}
