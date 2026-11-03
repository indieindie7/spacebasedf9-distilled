local LH=require('UI.LH')
local hl,lc,px,tex,tx=LH.hl,LH.lc,LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CANCEL = Gui.RED
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 430, 81
local nTextHeight = nButtonHeight + 20
local nButtonStartY = 278
local nIconX, nIconStartY = 20, -280
local nLabelX, nLabelStartY =  105, -288
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -330
local nIconScale = .6
local numButtons = 7
local nCancelIconStartY = -82
local nCancelLabelStartY = -90
local nCancelHotkeyY = -130
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
        {
            { key = 'CostBackground', hidden = false, },
            { key = 'CostBackgroundEndCap', hidden = false, },
            { key = 'CostVerticalRule', hidden = false, },
            { key = 'CostIconMatter', hidden = false, },
            { key = 'CostText', hidden = false, },
        },
        onHideMatterCost =
        {
            { key = 'CostBackground', hidden = true, },
            { key = 'CostBackgroundEndCap', hidden = true, },
            { key = 'CostVerticalRule', hidden = true, },
            { key = 'CostIconMatter', hidden = true, },
            { key = 'CostText', hidden = true, },
        },
    },
    tElements =
    {
        px('LargeBar',{ 0, 0 },{ nButtonWidth, (nButtonStartY + 3*nButtonHeight) },Gui.SIDEBAR_BG),
        {
            key = 'BackButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            hidden = true,
            onPressed =
            {
                { key = 'BackButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'BackButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'BackButton', hidden = false, },
                { key = 'BackLabel', color = Gui.BLACK, },
                { key = 'BackHotkey', color = Gui.BLACK, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'BackButton', hidden = true, },
                { key = 'BackLabel', color = Gui.AMBER, },
                { key = 'BackHotkey', color = Gui.AMBER, },
            },
        },
        lc('BackLabel',{ nLabelX, -10 },'HUDHUD009TEXT','dosisregular40',{ 0, 300, 400, 0 },Gui.AMBER),
        tx('BackHotkey',{ nHotkeyX - 4, -50 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        lc('MenuSublabel',{ 40, -244 },"HUDHUD026TEXT",'dosissemibold22',{ 0, 100, 400, 0 },Gui.GREY),
        {
            key = 'CancelButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight },
            scale = { nButtonWidth, nButtonHeight },
            color = CONSTRUCT_CANCEL,
            hidden = true,
            onHoverOn =
            {
                { key = 'CancelButton', hidden = false, },
                { key = 'CancelIcon', color = Gui.BLACK, },
                { key = 'CancelLabel', color = Gui.BLACK, },
                { key = 'CancelHotkey', color = Gui.BLACK, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'CancelButton', hidden = true, },
                { key = 'CancelIcon', color = CONSTRUCT_CANCEL, },
                { key = 'CancelLabel', color = CONSTRUCT_CANCEL, },
                { key = 'CancelHotkey', color = CONSTRUCT_CANCEL, },
            },
        },
        {
            key = 'ConfirmButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight * 2 },
            scale = { nButtonWidth, nButtonHeight },
            color = CONSTRUCT_CONFIRM,
            hidden = true,
            onPressed =
            {
                { key = 'ConfirmButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'ConfirmButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'ConfirmButton', hidden = false, },
                { key = 'ConfirmLabel', color = Gui.BLACK, },
                { key = 'ConfirmIcon', color = Gui.BLACK, },
                { key = 'ConfirmHotkey', color = Gui.BLACK, },
                { key = 'CostBackground', color = CONSTRUCT_CONFIRM, },
                { key = 'CostBackgroundEndCap', color = CONSTRUCT_CONFIRM, },
                { key = 'CostVerticalRule', color = Gui.BLACK, },
                { key = 'CostIconMatter', color = Gui.BLACK, },
                { key = 'CostText', color = Gui.BLACK, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'ConfirmButton', hidden = true, },
                { key = 'ConfirmLabel', color = CONSTRUCT_CONFIRM, },
                { key = 'ConfirmIcon', color = CONSTRUCT_CONFIRM, },
                { key = 'ConfirmHotkey', color = CONSTRUCT_CONFIRM, },
                { key = 'CostBackground', color = Gui.BLACK, },
                { key = 'CostBackgroundEndCap', color = Gui.BLACK, },
                { key = 'CostVerticalRule', color = CONSTRUCT_CONFIRM, },
                { key = 'CostIconMatter', color = CONSTRUCT_CONFIRM, },
                { key = 'CostText', color = CONSTRUCT_CONFIRM, },
            },
        },
        {
            key = 'DoorButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonStartY },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            hidden = true,
            onPressed =
            {
                { key = 'DoorButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'DoorButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'DoorButton', hidden = false, },
                { key = 'DoorLabel', color = Gui.BLACK, },
                { key = 'DoorIcon', color = Gui.BLACK, },
                { key = 'DoorHotkey', color = Gui.BLACK, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'DoorButton', hidden = true, },
                { key = 'DoorLabel', color = Gui.AMBER, },
                { key = 'DoorIcon', color = Gui.AMBER, },
                { key = 'DoorHotkey', color = Gui.AMBER, },
            },
        },
        {
            key = 'AirlockButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            hidden = true,
            onPressed =
            {
                { key = 'AirlockButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'AirlockButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'AirlockButton', hidden = false, },
                { key = 'AirlockLabel', color = Gui.BLACK, },
                { key = 'AirlockIcon', color = Gui.BLACK, },
                { key = 'AirlockHotkey', color = Gui.BLACK, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'AirlockButton', hidden = true, },
                { key = 'AirlockLabel', color = Gui.AMBER, },
                { key = 'AirlockIcon', color = Gui.AMBER, },
                { key = 'AirlockHotkey', color = Gui.AMBER, },
            },
        },
        {
            key = 'HeavyDoorButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + nButtonHeight*2) },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            hidden = true,
            onPressed =
            {
                { key = 'HeavyDoorButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'HeavyDoorButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'HeavyDoorButton', hidden = false, },
                { key = 'HeavyDoorLabel', color = Gui.BLACK, },
                { key = 'HeavyDoorIcon', color = Gui.BLACK, },
                { key = 'HeavyDoorHotkey', color = Gui.BLACK, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'HeavyDoorButton', hidden = true, },
                { key = 'HeavyDoorLabel', color = Gui.AMBER, },
                { key = 'HeavyDoorIcon', color = Gui.AMBER, },
                { key = 'HeavyDoorHotkey', color = Gui.AMBER, },
            },
        },
        tex('CancelIcon','ui_iconIso_decline','UI/Shared',{ nIconX, nCancelIconStartY },CONSTRUCT_CANCEL,{ nIconScale, nIconScale }),
        tex('ConfirmIcon','ui_iconIso_confirm','UI/Shared',{ nIconX, nCancelIconStartY - nButtonHeight },CONSTRUCT_CONFIRM,{ nIconScale, nIconScale }),
        tex('DoorIcon','icon_door','UI/Shared',{ nIconX, nIconStartY },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('AirlockIcon','icon_airlock_door','UI/Shared',{ nIconX, nIconStartY - nButtonHeight },Gui.AMBER,{ nIconScale, nIconScale }),
        tex('HeavyDoorIcon','icon_heavydoor','UI/Shared',{ nIconX, nIconStartY - nButtonHeight*2 },Gui.AMBER,{ nIconScale, nIconScale }),
        lc('CancelLabel',{ nLabelX, nCancelLabelStartY },'HUDHUD034TEXT','dosisregular40',{ 0, 300, 200, 0 },CONSTRUCT_CANCEL),
        lc('ConfirmLabel',{ nLabelX, nCancelLabelStartY - nButtonHeight },'HUDHUD019TEXT','dosisregular40',{ 0, 300, 280, 0 },CONSTRUCT_CONFIRM),
        lc('DoorLabel',{ nLabelX, nLabelStartY },'HUDHUD015TEXT','dosisregular40',{ 0, 300, nTextHeight, 0 },Gui.AMBER),
        lc('AirlockLabel',{ nLabelX, nLabelStartY - nButtonHeight },'HUDHUD016TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        lc('HeavyDoorLabel',{ nLabelX, nLabelStartY - nButtonHeight*2 },'HUDHUD044TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        tx('CancelHotkey',{ nHotkeyX, nCancelHotkeyY },'X','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CANCEL,'R'),
        tx('ConfirmHotkey',{ nHotkeyX, nCancelHotkeyY - nButtonHeight },'C','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CONFIRM,'R'),
        tx('DoorHotkey',{ nHotkeyX, nHotkeyStartY },'1','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('AirlockHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight },'2','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('HeavyDoorHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight*2 },'3','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        lc('NoFundsLabel',{ nButtonWidth + 30, -810 },'BUILDM016TEXT','dosisregular40',{ 0, 300, 500, 0 },Gui.RED,nil,nil,true),
        px('SelectionHighlight',{ 0, 0 },{ nButtonWidth, nButtonHeight },SELECTION_AMBER),
        lc('DoorCostLabel',{ nLabelX, nLabelStartY - 42 },'BUILDM023TEXT','dosissemibold22',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('AirlockDoorCostLabel',{ nLabelX, nLabelStartY - nButtonHeight - 42 },'BUILDM023TEXT','dosissemibold22',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        lc('HeavyDoorCostLabel',{ nLabelX, nLabelStartY - nButtonHeight*2 - 42 },'BUILDM023TEXT','dosissemibold22',{ 0, 300, nButtonWidth, 0 },Gui.AMBER),
        px('CostBackground',{ nButtonWidth, -nButtonHeight * 2 },{ nBGWidth, nButtonHeight },CONSTRUCT_CONFIRM),
        tex('CostBackgroundEndCap','ui_confirm_endcap','UI/Shared',{ nButtonWidth + nBGWidth - 1, -nButtonHeight * 2 },CONSTRUCT_CONFIRM),
        tex('CostVerticalRule','ui_confirm_verticalrule','UI/Shared',{ nButtonWidth, -(nButtonHeight * 2) - 4 },{ 0, 0, 0 }),
        tex('CostIconMatter','ui_confirm_iconmatter','UI/Shared',{ nButtonWidth + 10, -(nButtonHeight * 2) - 10 },{ 0, 0, 0 }),
        tx('CostText',{ nButtonWidth + 34, -(nButtonHeight * 2) - 4 },"-450 Build\n+75 Demolish\n+36 Undo",'dosissemibold18',{ 0, 100, 500, 0 },{ 0, 0, 0 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, -(nButtonStartY + 3*nButtonHeight) },Gui.SIDEBAR_BG,{ 1.68, 1.68 }),
    }
}
