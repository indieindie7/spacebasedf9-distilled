local LH=require('UI.LH')
local btn,c,hh,hl,hv,lc,px,tex,tx,v=LH.btn,LH.c,LH.hh,LH.hl,LH.hv,LH.lc,LH.px,LH.tex,LH.tx,LH.v
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 330, 81
local nTextHeight = nButtonHeight + 20
local nButtonStartY = -123
local nIconX, nIconStartY = 10, -125
local nLabelX, nLabelStartY = 105, -133
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -169
local nIconScale = .6
local numButtons = 2
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
    tExtraInfo =
    {
        onShowMatterCost =
        hh(false,'CostBackground','CostBackgroundEndCap','CostVerticalRule','CostIconMatter','CostText'),
        onHideMatterCost =
        hh(true,'CostBackground','CostBackgroundEndCap','CostVerticalRule','CostIconMatter','CostText'),
    },
    tElements =
    {
        px('LargeBar',{ 0, 0 },{ nButtonWidth, -nButtonStartY + (nButtonHeight * numButtons) },Gui.SIDEBAR_BG),
        btn('DoneButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(CONSTRUCT_CONFIRM,'DoneButton',{ 0, 0, 0 },'DoneLabel','DoneHotkey',CONSTRUCT_CONFIRM,'CostBackground','CostBackgroundEndCap',{ 0, 0, 0 },'CostVerticalRule','CostIconMatter','CostText',true),hv(Gui.BLACK,'DoneButton',CONSTRUCT_CONFIRM,'DoneLabel','DoneHotkey',{ 0, 0, 0 },'CostBackground','CostBackgroundEndCap',CONSTRUCT_CONFIRM,'CostVerticalRule','CostIconMatter','CostText'),BRIGHT_AMBER,AMBER),
        btn('MineButton',{ 0, nButtonStartY },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'MineButton',{ 0, 0, 0 },'MineLabel','MineIcon','MineHotkey',true),hv(Gui.BLACK,'MineButton',Gui.AMBER,'MineLabel','MineIcon','MineHotkey'),BRIGHT_AMBER,AMBER),
        btn('EraseButton',{ 0, nButtonStartY - nButtonHeight },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'EraseButton',{ 0, 0, 0 },'EraseLabel','EraseIcon','EraseHotkey',true),hv(Gui.BLACK,'EraseButton',Gui.AMBER,'EraseLabel','EraseIcon','EraseHotkey'),BRIGHT_AMBER,AMBER),
        tex('MineIcon','ui_iconIso_mine','UI/Shared',{ nIconX, nIconStartY },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('EraseIcon','ui_iconIso_erase','UI/Shared',{ nIconX, nIconStartY - nButtonHeight },Gui.AMBER,{ nIconScale, nIconScale }),
        lc('MenuSublabel',{ 40, -85 },"HUDHUD010TEXT",'dosissemibold22',{ 0, 100, 100, 0 },Gui.GREY),
        lc('DoneLabel',{ nLabelX, -10 },'HUDHUD019TEXT','dosisregular40',{ 0, 300, 280, 0 },CONSTRUCT_CONFIRM),
        lc('MineLabel',{ nLabelX, nLabelStartY },'HUDHUD008TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        lc('EraseLabel',{ nLabelX, nLabelStartY - nButtonHeight },'HUDHUD011TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        tx('DoneHotkey',{ nHotkeyX, -46 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CONFIRM,'R'),
        tx('MineHotkey',{ nHotkeyX, nHotkeyStartY },'M','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('EraseHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight },'E','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        px('SelectionHighlight',{ 0, 0 },{ nButtonWidth, nButtonHeight },SELECTION_AMBER,true),
        px('CostBackground',{ nButtonWidth, 0 },{ nBGWidth, nButtonHeight },CONSTRUCT_CONFIRM),
        tex('CostBackgroundEndCap','ui_confirm_endcap','UI/Shared',{ nButtonWidth + nBGWidth - 1, 0 },CONSTRUCT_CONFIRM),
        tex('CostVerticalRule','ui_confirm_verticalrule','UI/Shared',{ nButtonWidth, -4 },{ 0, 0, 0 }),
        tex('CostIconMatter','ui_confirm_iconmatter','UI/Shared',{ nButtonWidth + 10, -10 },{ 0, 0, 0 }),
        tx('CostText',{ nButtonWidth + 34, -4 },"-450 Build\n+75 Demolish\n+36 Undo",'dosissemibold18',{ 0, 100, 500, 0 },{ 0, 0, 0 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, nButtonStartY - numButtons*nButtonHeight },Gui.SIDEBAR_BG,{ 1.28, 1.28 }),
    },
}
