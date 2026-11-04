local LH=require('UI.LH')
local btn,c,hh,hv,lc,px,tex,tx,v=LH.btn,LH.c,LH.hh,LH.hv,LH.lc,LH.px,LH.tex,LH.tx,LH.v
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BLACK = { Gui.BLACK[1], Gui.BLACK[2], Gui.BLACK[3], 1 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CANCEL = Gui.RED
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 330, 78
local nButtonStartY = 278
local nIconX, nIconStartY = 20, -280
local nLabelX, nLabelStartY =  105, -288
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -330
local nIconScale = .6
local numButtons = 12
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
        px('LargeBar',{ 0, 0 },{ nButtonWidth, nButtonStartY + (numButtons * nButtonHeight) },Gui.SIDEBAR_BG),
        btn('BackButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },BLACK,{ c('BackButton',AMBER), c('BackLabel',{ 0, 0, 0 }), c('BackHotkey',{ 0, 0, 0 }), },hv(BLACK,'BackButton',Gui.AMBER,'BackLabel','BackHotkey'),BRIGHT_AMBER,AMBER),
        btn('CancelButton',{ 0, -nButtonHeight },{ nButtonWidth, nButtonHeight },BLACK,{ c('CancelButton',CONSTRUCT_CANCEL), c('CancelIcon',{ 0, 0, 0 }), c('CancelLabel',{ 0, 0, 0 }), c('CancelHotkey',{ 0, 0, 0 }), },hv(BLACK,'CancelButton',CONSTRUCT_CANCEL,'CancelIcon','CancelLabel','CancelHotkey')),
        btn('ConfirmButton',{ 0, -nButtonHeight * 2 },{ nButtonWidth, nButtonHeight },BLACK,{ c('ConfirmButton',CONSTRUCT_CONFIRM), c('ConfirmLabel',{ 0, 0, 0 }), c('ConfirmIcon',{ 0, 0, 0 }), c('ConfirmHotkey',{ 0, 0, 0 }), c('CostBackground',CONSTRUCT_CONFIRM), c('CostBackgroundEndCap',CONSTRUCT_CONFIRM), c('CostVerticalRule',{ 0, 0, 0 }), c('CostIconMatter',{ 0, 0, 0 }), c('CostText',{ 0, 0, 0 }), },hv(BLACK,'ConfirmButton',CONSTRUCT_CONFIRM,'ConfirmLabel','ConfirmIcon','ConfirmHotkey',{ 0, 0, 0 },'CostBackground','CostBackgroundEndCap',CONSTRUCT_CONFIRM,'CostVerticalRule','CostIconMatter','CostText'),BRIGHT_AMBER,AMBER),
        btn('AllButton',{ 0, -nButtonStartY },{ nButtonWidth, nButtonHeight },BLACK,{ c('AllButton',AMBER), c('AllLabel',{ 0, 0, 0 }), c('AllIcon',{ 0, 0, 0 }), c('AllHotkey',{ 0, 0, 0 }), },hv(BLACK,'AllButton',Gui.AMBER,'AllLabel','AllIcon','AllHotkey'),BRIGHT_AMBER,AMBER),
        btn('AirlockButton',{ 0, -(nButtonStartY + nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('AirlockButton',AMBER), c('AirlockLabel',{ 0, 0, 0 }), c('AirlockIcon',{ 0, 0, 0 }), c('AirlockHotkey',{ 0, 0, 0 }), },hv(BLACK,'AirlockButton',Gui.AMBER,'AirlockLabel','AirlockIcon','AirlockHotkey'),BRIGHT_AMBER,AMBER),
        btn('ReactorButton',{ 0, -(nButtonStartY + 2*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('ReactorButton',AMBER), c('ReactorLabel',{ 0, 0, 0 }), c('ReactorIcon',{ 0, 0, 0 }), c('ReactorHotkey',{ 0, 0, 0 }), },hv(BLACK,'ReactorButton',Gui.AMBER,'ReactorLabel','ReactorIcon','ReactorHotkey'),BRIGHT_AMBER,AMBER),
        btn('GardenButton',{ 0, -(nButtonStartY + 3*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('GardenButton',AMBER), c('GardenLabel',{ 0, 0, 0 }), c('GardenIcon',{ 0, 0, 0 }), c('GardenHotkey',{ 0, 0, 0 }), },hv(BLACK,'GardenButton',Gui.AMBER,'GardenLabel','GardenIcon','GardenHotkey'),BRIGHT_AMBER,AMBER),
        btn('LifeSupportButton',{ 0, -(nButtonStartY + 4*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('LifeSupportButton',AMBER), c('LifeSupportLabel',{ 0, 0, 0 }), c('LifeSupportIcon',{ 0, 0, 0 }), c('LifeSupportHotkey',{ 0, 0, 0 }), },hv(BLACK,'LifeSupportButton',Gui.AMBER,'LifeSupportLabel','LifeSupportIcon','LifeSupportHotkey'),BRIGHT_AMBER,AMBER),
        btn('PubButton',{ 0, -(nButtonStartY + 5*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('PubButton',AMBER), c('PubLabel',{ 0, 0, 0 }), c('PubIcon',{ 0, 0, 0 }), c('PubHotkey',{ 0, 0, 0 }), },hv(BLACK,'PubButton',Gui.AMBER,'PubLabel','PubIcon','PubHotkey'),BRIGHT_AMBER,AMBER),
        btn('RefineryButton',{ 0, -(nButtonStartY + 6*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('RefineryButton',AMBER), c('RefineryLabel',{ 0, 0, 0 }), c('RefineryIcon',{ 0, 0, 0 }), c('RefineryHotkey',{ 0, 0, 0 }), },hv(BLACK,'RefineryButton',Gui.AMBER,'RefineryLabel','RefineryIcon','RefineryHotkey'),BRIGHT_AMBER,AMBER),
        btn('ResidenceButton',{ 0, -(nButtonStartY + 7*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('ResidenceButton',AMBER), c('ResidenceLabel',{ 0, 0, 0 }), c('ResidenceIcon',{ 0, 0, 0 }), c('ResidenceHotkey',{ 0, 0, 0 }), },hv(BLACK,'ResidenceButton',Gui.AMBER,'ResidenceLabel','ResidenceIcon','ResidenceHotkey'),BRIGHT_AMBER,AMBER),
        btn('FitnessButton',{ 0, -(nButtonStartY + 8*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('FitnessButton',AMBER), c('FitnessLabel',{ 0, 0, 0 }), c('FitnessIcon',{ 0, 0, 0 }), c('FitnessHotkey',{ 0, 0, 0 }), },hv(BLACK,'FitnessButton',Gui.AMBER,'FitnessLabel','FitnessIcon','FitnessHotkey'),BRIGHT_AMBER,AMBER),
        btn('ResearchButton',{ 0, -(nButtonStartY + 9*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('ResearchButton',AMBER), c('ResearchLabel',{ 0, 0, 0 }), c('ResearchIcon',{ 0, 0, 0 }), c('ResearchHotkey',{ 0, 0, 0 }), },hv(BLACK,'ResearchButton',Gui.AMBER,'ResearchLabel','ResearchIcon','ResearchHotkey'),BRIGHT_AMBER,AMBER),
        btn('InfirmaryButton',{ 0, -(nButtonStartY + 10*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c('InfirmaryButton',AMBER), c('InfirmaryLabel',{ 0, 0, 0 }), c('InfirmaryIcon',{ 0, 0, 0 }), c('InfirmaryHotkey',{ 0, 0, 0 }), },hv(BLACK,'InfirmaryButton',Gui.AMBER,'InfirmaryLabel','InfirmaryIcon','InfirmaryHotkey'),BRIGHT_AMBER,AMBER),
        tex('CancelIcon','ui_iconIso_decline','UI/Shared',{ nIconX, nCancelIconStartY },CONSTRUCT_CANCEL,{ nIconScale, nIconScale }),
        tex('ConfirmIcon','ui_iconIso_confirm','UI/Shared',{ nIconX, nCancelIconStartY - nButtonHeight },CONSTRUCT_CONFIRM,{ nIconScale, nIconScale }),
        tex('AllIcon','ui_iconIso_object','UI/Shared',{ nIconX, nIconStartY },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('AirlockIcon','ui_iconIso_airlock','UI/Shared',{ nIconX, nIconStartY - nButtonHeight },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('ReactorIcon','ui_iconIso_reactor','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 2) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('GardenIcon','ui_iconIso_garden','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 3) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('LifeSupportIcon','ui_iconIso_lifesupport','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 4) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('PubIcon','ui_iconIso_pub','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 5) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('RefineryIcon','ui_iconIso_refineryAlt','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 6) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('ResidenceIcon','ui_iconIso_residence','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 7) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('FitnessIcon','ui_iconIso_fitness','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 8) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('ResearchIcon','ui_iconIso_research','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 9) },Gui.AMBER,{ nIconScale, nIconScale}),
        tex('InfirmaryIcon','ui_iconIso_infirmary','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 10) },Gui.AMBER,{ nIconScale, nIconScale}),
        lc('MenuSublabel',{ 40, -244 },"HUDHUD024TEXT",'dosissemibold22',{ 0, 100, 400, 0 },Gui.GREY),
        lc('BackLabel',{ nLabelX, -10 },'HUDHUD009TEXT','dosisregular40',{ 0, 300, 400, 0 },Gui.AMBER),
        lc('CancelLabel',{ nLabelX, nCancelLabelStartY },'HUDHUD034TEXT','dosisregular40',{ 0, 300, 200, 0 },CONSTRUCT_CANCEL),
        lc('ConfirmLabel',{ nLabelX, nCancelLabelStartY - nButtonHeight },'HUDHUD019TEXT','dosisregular40',{ 0, 300, 280, 0 },CONSTRUCT_CONFIRM),
        lc('AllLabel',{ nLabelX, nLabelStartY },'ZONEUI058TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('AirlockLabel',{ nLabelX, nLabelStartY - nButtonHeight },'ZONEUI036TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('ReactorLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 2) },'ZONEUI003TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('GardenLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 3) },'ZONEUI069TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('LifeSupportLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 4) },'ZONEUI001TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('PubLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 5) },'ZONEUI046TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('RefineryLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 6) },'ZONEUI037TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('ResidenceLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 7) },'ZONEUI042TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('FitnessLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 8) },'ZONEUI109TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('ResearchLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 9) },'ZONEUI126TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('InfirmaryLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 10) },'ZONEUI049TEXT','dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        tx('BackHotkey',{ nHotkeyX - 4, -50 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('CancelHotkey',{ nHotkeyX, nCancelHotkeyY },'X','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CANCEL,'R'),
        tx('ConfirmHotkey',{ nHotkeyX, nCancelHotkeyY - nButtonHeight },'C','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CONFIRM,'R'),
        tx('AllHotkey',{ nHotkeyX, nHotkeyStartY },'Z','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('AirlockHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight },'A','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ReactorHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 2) },'T','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('GardenHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 3) },'G','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('LifeSupportHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 4) },'S','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('PubHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 5) },'B','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('RefineryHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 6) },'F','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ResidenceHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 7) },'R','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('FitnessHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 8) },'N','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ResearchHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 9) },'H','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('InfirmaryHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 10) },'I','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        px('SelectionHighlight',{ 0, 0 },{ nButtonWidth, nButtonHeight },SELECTION_AMBER,true),
        px('CostBackground',{ nButtonWidth, -nButtonHeight * 2 },{ nBGWidth, nButtonHeight },CONSTRUCT_CONFIRM),
        tex('CostBackgroundEndCap','ui_confirm_endcap','UI/Shared',{ nButtonWidth + nBGWidth - 1, -nButtonHeight * 2 },CONSTRUCT_CONFIRM),
        tex('CostVerticalRule','ui_confirm_verticalrule','UI/Shared',{ nButtonWidth, -(nButtonHeight * 2) - 4 },{ 0, 0, 0 }),
        tex('CostIconMatter','ui_confirm_iconmatter','UI/Shared',{ nButtonWidth + 10, -(nButtonHeight * 2) - 10 },{ 0, 0, 0 }),
        tx('CostText',{ nButtonWidth + 34, -(nButtonHeight * 2) - 4 },"-450 Build\n+75 Demolish\n+36 Undo",'dosissemibold18',{ 0, 100, 500, 0 },{ 0, 0, 0 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, -(nButtonStartY + numButtons*nButtonHeight) + 1 },Gui.SIDEBAR_BG,{ 1.28, 1.28 }),
    },
}
