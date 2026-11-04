local LH=require('UI.LH')
local btn,c,hh,hv,lc,px,tex,tx,v=LH.btn,LH.c,LH.hh,LH.hv,LH.lc,LH.px,LH.tex,LH.tx,LH.v
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local CONSTRUCT_CANCEL = Gui.RED
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 430, 81
local nButtonStartY = 278
local nIconX, nIconStartY = 20, -280
local nLabelX, nLabelStartY =  105, -288
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -330
local nIconScale = .6
local nCancelIconStartY = -82
local nCancelLabelStartY = -90
local nCancelHotkeyY = -130
local nBGWidth = 160
return
{
    posInfo = LH.pos('left', 'top', 0, 0, {1,1}),
    tExtraInfo =
    {
        onShowMatterCost =
        hh(false,'CostBackground','CostBackgroundEndCap','CostVerticalRule','CostIconMatter','CostText'),
        onHideMatterCost =
        hh(true,'CostBackground','CostBackgroundEndCap','CostVerticalRule','CostIconMatter','CostText'),
    },
    tElements =
    {
        px('LargeBar',{ 0, 0 },{ nButtonWidth, (nButtonStartY + 7*nButtonHeight) },Gui.SIDEBAR_BG),
        btn('BackButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'BackButton',{ 0, 0, 0 },'BackLabel','BackHotkey',true),hv(Gui.BLACK,'BackButton',Gui.AMBER,'BackLabel','BackHotkey'),BRIGHT_AMBER,AMBER),
        lc('BackLabel',{ nLabelX, -10 },'HUDHUD009TEXT','dosisregular40',{ 0, 300, 400, 0 },Gui.AMBER),
        tx('BackHotkey',{ nHotkeyX - 4, -50 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        lc('MenuSublabel',{ 40, -244 },"HUDHUD026TEXT",'dosissemibold22',{ 0, 100, 400, 0 },Gui.GREY),
        btn('CancelButton',{ 0, -nButtonHeight },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(CONSTRUCT_CANCEL,'CancelButton',{ 0, 0, 0 },'CancelIcon','CancelLabel','CancelHotkey',true),hv(Gui.BLACK,'CancelButton',CONSTRUCT_CANCEL,'CancelIcon','CancelLabel','CancelHotkey')),
        btn('ConfirmButton',{ 0, -nButtonHeight * 2 },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(CONSTRUCT_CONFIRM,'ConfirmButton',{ 0, 0, 0 },'ConfirmLabel','ConfirmIcon','ConfirmHotkey',CONSTRUCT_CONFIRM,'CostBackground','CostBackgroundEndCap',{ 0, 0, 0 },'CostVerticalRule','CostIconMatter','CostText',true),hv(Gui.BLACK,'ConfirmButton',CONSTRUCT_CONFIRM,'ConfirmLabel','ConfirmIcon','ConfirmHotkey',{ 0, 0, 0 },'CostBackground','CostBackgroundEndCap',CONSTRUCT_CONFIRM,'CostVerticalRule','CostIconMatter','CostText'),BRIGHT_AMBER,AMBER),
        tex('CancelIcon','ui_iconIso_decline','UI/Shared',{ nIconX, nCancelIconStartY },CONSTRUCT_CANCEL,{ nIconScale, nIconScale }),
        tex('ConfirmIcon','ui_iconIso_confirm','UI/Shared',{ nIconX, nCancelIconStartY - nButtonHeight },CONSTRUCT_CONFIRM,{ nIconScale, nIconScale }),
        lc('CancelLabel',{ nLabelX, nCancelLabelStartY },'HUDHUD034TEXT','dosisregular40',{ 0, 300, 200, 0 },CONSTRUCT_CANCEL),
        lc('ConfirmLabel',{ nLabelX, nCancelLabelStartY - nButtonHeight },'HUDHUD019TEXT','dosisregular40',{ 0, 300, 280, 0 },CONSTRUCT_CONFIRM),
        tx('CancelHotkey',{ nHotkeyX, nCancelHotkeyY },'X','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CANCEL,'R'),
        tx('ConfirmHotkey',{ nHotkeyX, nCancelHotkeyY - nButtonHeight },'C','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CONFIRM,'R'),
        lc('NoFundsLabel',{ nButtonWidth + 30, -810 },'BUILDM016TEXT','dosisregular40',{ 0, 300, 500, 0 },Gui.RED,nil,nil,true),
        px('CostBackground',{ nButtonWidth, -nButtonHeight * 2 },{ nBGWidth, nButtonHeight },CONSTRUCT_CONFIRM),
        tex('CostBackgroundEndCap','ui_confirm_endcap','UI/Shared',{ nButtonWidth + nBGWidth - 1, -nButtonHeight * 2 },CONSTRUCT_CONFIRM),
        tex('CostVerticalRule','ui_confirm_verticalrule','UI/Shared',{ nButtonWidth, -(nButtonHeight * 2) - 4 },{ 0, 0, 0 }),
        tex('CostIconMatter','ui_confirm_iconmatter','UI/Shared',{ nButtonWidth + 10, -(nButtonHeight * 2) - 10 },{ 0, 0, 0 }),
        tx('CostText',{ nButtonWidth + 34, -(nButtonHeight * 2) - 4 },"-450 Build\n+75 Demolish\n+36 Undo",'dosissemibold18',{ 0, 100, 500, 0 },{ 0, 0, 0 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, -(nButtonStartY + 7*nButtonHeight) + 1 },Gui.SIDEBAR_BG,{ 1.68, 1.68 }),
    }
}
