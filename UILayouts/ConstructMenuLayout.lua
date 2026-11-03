local LH=require('UI.LH')
local btn,c,hh,hv,lc,px,tex,tx,v=LH.btn,LH.c,LH.hh,LH.hv,LH.lc,LH.px,LH.tex,LH.tx,LH.v
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CANCEL = Gui.RED
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 330, 81
local nTextHeight = nButtonHeight + 20
local nButtonStartY = -204
local nIconX, nIconStartY = 10, -206
local nCancelIconStartY = -2
local nLabelX, nLabelStartY = 105, -214
local nCancelLabelStartY = -10
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -250
local nCancelHotkeyY = -46
local nIconScale = .6
local numButtons = 7
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
        btn('CancelButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(CONSTRUCT_CANCEL,'CancelButton',{ 0, 0, 0 },'CancelIcon','CancelLabel','CancelHotkey',true),hv(Gui.BLACK,'CancelButton',CONSTRUCT_CANCEL,'CancelIcon','CancelLabel','CancelHotkey')),
        btn('ConfirmButton',{ 0, -nButtonHeight },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(CONSTRUCT_CONFIRM,'ConfirmButton',{ 0, 0, 0 },'ConfirmLabel','ConfirmIcon','ConfirmHotkey',CONSTRUCT_CONFIRM,'CostBackground','CostBackgroundEndCap',{ 0, 0, 0 },'CostVerticalRule','CostIconMatter','CostText',true),hv(Gui.BLACK,'ConfirmButton',CONSTRUCT_CONFIRM,'ConfirmLabel','ConfirmIcon','ConfirmHotkey',{ 0, 0, 0 },'CostBackground','CostBackgroundEndCap',CONSTRUCT_CONFIRM,'CostVerticalRule','CostIconMatter','CostText'),BRIGHT_AMBER,AMBER),
        btn('AreaButton',{ 0, nButtonStartY },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'AreaButton',{ 0, 0, 0 },'AreaLabel','AreaIcon','AreaHotkey',true),hv(Gui.BLACK,'AreaButton',Gui.AMBER,'AreaLabel','AreaIcon','AreaHotkey'),BRIGHT_AMBER,AMBER),
        btn('WallButton',{ 0, nButtonStartY - nButtonHeight },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'WallButton',{ 0, 0, 0 },'WallLabel','WallIcon','WallHotkey',true),hv(Gui.BLACK,'WallButton',Gui.AMBER,'WallLabel','WallIcon','WallHotkey'),BRIGHT_AMBER,AMBER),
        btn('FloorButton',{ 0, nButtonStartY - (nButtonHeight*2) },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'FloorButton',{ 0, 0, 0 },'FloorLabel','FloorIcon','FloorHotkey',true),hv(Gui.BLACK,'FloorButton',Gui.AMBER,'FloorLabel','FloorIcon','FloorHotkey'),BRIGHT_AMBER,AMBER),
        btn('ObjectButton',{ 0, nButtonStartY - (nButtonHeight*3) },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'ObjectButton',{ 0, 0, 0 },'ObjectLabel','ObjectIcon',true),hv(Gui.BLACK,'ObjectButton',Gui.AMBER,'ObjectLabel','ObjectIcon'),BRIGHT_AMBER,AMBER),
        btn('DemolishButton',{ 0, nButtonStartY - (nButtonHeight*4) },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'DemolishButton',{ 0, 0, 0 },'DemolishLabel','DemolishIcon','DemolishHotkey',true),hv(Gui.BLACK,'DemolishButton',Gui.AMBER,'DemolishLabel','DemolishIcon','DemolishHotkey'),BRIGHT_AMBER,AMBER),
        btn('VaporizeButton',{ 0, nButtonStartY - (nButtonHeight*5) },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'VaporizeButton',{ 0, 0, 0 },'VaporizeLabel','VaporizeIcon','VaporizeHotkey',true),hv(Gui.BLACK,'VaporizeButton',Gui.AMBER,'VaporizeLabel','VaporizeIcon','VaporizeHotkey'),BRIGHT_AMBER,AMBER),
        btn('EraseButton',{ 0, nButtonStartY - (nButtonHeight * 6) },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'EraseButton',{ 0, 0, 0 },'EraseLabel','EraseIcon','EraseHotkey',true),hv(Gui.BLACK,'EraseButton',Gui.AMBER,'EraseLabel','EraseIcon','EraseHotkey'),BRIGHT_AMBER,AMBER),
        tex('CancelIcon','ui_iconIso_decline','UI/Shared',{ nIconX, nCancelIconStartY },CONSTRUCT_CANCEL,{ nIconScale, nIconScale }),
        tex('ConfirmIcon','ui_iconIso_confirm','UI/Shared',{ nIconX, nCancelIconStartY - nButtonHeight },CONSTRUCT_CONFIRM,{ nIconScale, nIconScale }),
        tex('AreaIcon','ui_iconIso_room','UI/Shared',{ nIconX, nIconStartY },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('WallIcon','ui_iconIso_Wall','UI/Shared',{ nIconX, nIconStartY - nButtonHeight },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('FloorIcon','ui_iconIso_floor','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 2) },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('ObjectIcon','ui_iconIso_object','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 3) },Gui.AMBER,{nIconScale, nIconScale}),
        tex('DemolishIcon','ui_iconIso_demolish','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 4) },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('VaporizeIcon','ui_iconIso_demolish','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 5) },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('EraseIcon','ui_iconIso_erase','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 6) },Gui.AMBER,{ nIconScale, nIconScale }),
        lc('MenuSublabel',{ 40, -166 },"HUDHUD012TEXT",'dosissemibold22',{ 0, 100, 200, 0 },Gui.GREY),
        lc('CancelLabel',{ nLabelX, nCancelLabelStartY },'HUDHUD034TEXT','dosisregular40',{ 0, 300, 200, 0 },CONSTRUCT_CANCEL),
        lc('ConfirmLabel',{ nLabelX, nCancelLabelStartY - nButtonHeight },'HUDHUD019TEXT','dosisregular40',{ 0, 300, 280, 0 },CONSTRUCT_CONFIRM),
        lc('AreaLabel',{ nLabelX, nLabelStartY },'HUDHUD013TEXT','dosisregular40',{ 0, 300, nTextHeight, 0 },Gui.AMBER),
        lc('WallLabel',{ nLabelX, nLabelStartY - nButtonHeight },'HUDHUD014TEXT','dosisregular40',{ 0, 300, nTextHeight, 0 },Gui.AMBER),
        lc('FloorLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 2) },'HUDHUD027TEXT','dosisregular40',{ 0, 300, nTextHeight, 0 },Gui.AMBER),
        lc('ObjectLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 3) },'HUDHUD023TEXT','dosisregular40',{ 0, 300, nTextHeight, 0 },Gui.AMBER),
        lc('DemolishLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 4) },'HUDHUD017TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        lc('VaporizeLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 5) },'HUDHUD045TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        lc('EraseLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 6) },'HUDHUD011TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        lc('NoFundsLabel',{ nButtonWidth + 30, -810 },'BUILDM016TEXT','dosisregular40',{ 0, 300, 500, 0 },Gui.RED,nil,nil,true),
        tx('CancelHotkey',{ nHotkeyX, nCancelHotkeyY },'X','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CANCEL,'R'),
        tx('ConfirmHotkey',{ nHotkeyX, nCancelHotkeyY - nButtonHeight },'C','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CONFIRM,'R'),
        tx('AreaHotkey',{ nHotkeyX, nHotkeyStartY },'R','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('WallHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight },'W','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('FloorHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 2) },'F','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ObjectHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 3) },'B','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('DemolishHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 4) },'D','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('VaporizeHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 5) },'V','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('EraseHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 6) },'E','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        px('SelectionHighlight',{ 0, 0 },{ nButtonWidth, nButtonHeight },SELECTION_AMBER),
        px('CostBackground',{ nButtonWidth, -nButtonHeight },{ nBGWidth, nButtonHeight },CONSTRUCT_CONFIRM),
        tex('CostBackgroundEndCap','ui_confirm_endcap','UI/Shared',{ nButtonWidth + nBGWidth - 1, -nButtonHeight },CONSTRUCT_CONFIRM),
        tex('CostVerticalRule','ui_confirm_verticalrule','UI/Shared',{ nButtonWidth, -nButtonHeight - 4 },{ 0, 0, 0 }),
        tex('CostIconMatter','ui_confirm_iconmatter','UI/Shared',{ nButtonWidth + 10, -nButtonHeight - 10 },{ 0, 0, 0 }),
        tx('CostText',{ nButtonWidth + 34, -nButtonHeight - 4 },"-450 Build\n+75 Demolish\n+36 Undo",'dosissemibold18',{ 0, 100, 500, 0 },{ 0, 0, 0 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, nButtonStartY - (nButtonHeight * numButtons) },Gui.SIDEBAR_BG,{ 1.28, 1.28 }),
    },
}
