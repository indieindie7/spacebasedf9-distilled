local LH=require('UI.LH')
local hl,lc,px,tex,tx=LH.hl,LH.lc,LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local nButtonWidth, nButtonHeight  = 104, 81
local nButtonWidthExpanded = 286
local nButtonStartY = -204
local nIconX, nIconStartY = 10, 0
local nLabelX, nLabelStartY = 105, -10
local nHotkeyX, nHotkeyStartY = nButtonWidth - 104, -50
local nHotkeyExpandedX = nButtonWidthExpanded - 112
local nIconScale = 0.6
local nNumButtons = 7
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
            key = 'SmallBarButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { 104, nButtonHeight * nNumButtons },
            color = Gui.SIDEBAR_BG,
        },
        {
            key = 'LargeBarButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidthExpanded, nButtonHeight * nNumButtons },
            color = Gui.SIDEBAR_BG,
        },
        px('SmallBarHighlight',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.AMBER),
        {
            key = 'InspectButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'InspectButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'InspectButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'InspectButton', color=Gui.AMBER, },
                { key = 'InspectLabel', color = { 0, 0, 0 }, },
                { key = 'InspectIcon', color = { 0, 0, 0 }, },
                { key = 'InspectHotkeyExpanded', color = { 0, 0, 0 }, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'InspectButton', color = Gui.BLACK, },
                { key = 'InspectLabel', color = Gui.AMBER, },
                { key = 'InspectIcon', color = Gui.AMBER, },
                { key = 'InspectHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        tex('InspectIcon','ui_iconIso_inspect','UI/Shared',{ nIconX, nIconStartY },Gui.AMBER,{nIconScale, nIconScale}),
        {
            key = 'AssignButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'AssignButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'AssignButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'AssignButton',  color=Gui.AMBER, },
                { key = 'AssignLabel', color = { 0, 0, 0 }, },
                { key = 'AssignIcon', color = { 0, 0, 0 }, },
                { key = 'AssignHotkeyExpanded', color = { 0, 0, 0 }, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'AssignButton', color = Gui.BLACK, },
                { key = 'AssignLabel', color = Gui.AMBER, },
                { key = 'AssignIcon', color = Gui.AMBER, },
                { key = 'AssignHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        tex('AssignIcon','ui_iconIso_assign','UI/Shared',{ nIconX, nIconStartY - nButtonHeight },Gui.AMBER,{nIconScale, nIconScale}),
        {
            key = 'ResearchButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight * 2 },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'ResearchButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'ResearchButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'ResearchButton',  color=Gui.AMBER, },
                { key = 'ResearchLabel', color = { 0, 0, 0 }, },
                { key = 'ResearchIcon', color = { 0, 0, 0 }, },
                { key = 'ResearchHotkeyExpanded', color = { 0, 0, 0 }, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'ResearchButton', color = Gui.BLACK, },
                { key = 'ResearchLabel', color = Gui.AMBER, },
                { key = 'ResearchIcon', color = Gui.AMBER, },
                { key = 'ResearchHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        tex('ResearchIcon','ui_iconIso_research','UI/Shared',{ nIconX, nIconStartY - nButtonHeight*2 },Gui.AMBER,{nIconScale, nIconScale}),
        {
            key = 'GoalButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 3) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'GoalButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'GoalButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'GoalButton', color = Gui.AMBER, },
                { key = 'GoalLabel', color = { 0, 0, 0 }, },
                { key = 'GoalIcon', color = { 0, 0, 0 }, },
                { key = 'GoalHotkey', color = { 0, 0, 0 }, },
                { key = 'GoalHotkeyExpanded', color = { 0, 0, 0 }, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'GoalButton', color = Gui.BLACK, },
                { key = 'GoalLabel', color = Gui.AMBER, },
                { key = 'GoalIcon', color = Gui.AMBER, },
                { key = 'GoalHotkey', color = Gui.AMBER, },
                { key = 'GoalHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        tex('GoalIcon','ui_iconIso_confirm','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 3) },Gui.AMBER,{nIconScale, nIconScale}),
        {
            key = 'ConstructButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 4) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'ConstructButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'ConstructButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'ConstructButton',  color=Gui.AMBER, },
                { key = 'ConstructLabel', color = { 0, 0, 0 }, },
                { key = 'ConstructIcon', color = { 0, 0, 0 }, },
                { key = 'ConstructHotkey', color = { 0, 0, 0 }, },
                { key = 'ConstructHotkeyExpanded', color = { 0, 0, 0 }, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'ConstructButton', color = Gui.BLACK, },
                { key = 'ConstructLabel', color = Gui.AMBER, },
                { key = 'ConstructIcon', color = Gui.AMBER, },
                { key = 'ConstructHotkey', color = Gui.AMBER, },
                { key = 'ConstructHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        tex('ConstructIcon','ui_iconIso_construct','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 4) },Gui.AMBER,{nIconScale, nIconScale}),
        {
            key = 'MineButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 5) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'MineButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'MineButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'MineButton',  color=Gui.AMBER, },
                { key = 'MineLabel', color = { 0, 0, 0 }, },
                { key = 'MineIcon', color = { 0, 0, 0 }, },
                { key = 'MineHotkeyExpanded', color = { 0, 0, 0 }, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'MineButton', color = Gui.BLACK, },
                { key = 'MineLabel', color = Gui.AMBER, },
                { key = 'MineIcon', color = Gui.AMBER, },
                { key = 'MineHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        tex('MineIcon','ui_iconIso_mine','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 5) },Gui.AMBER,{nIconScale, nIconScale}),
        {
            key = 'BeaconButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 6) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'BeaconButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'BeaconButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'BeaconButton',  color=Gui.AMBER, },
                { key = 'BeaconLabel', color = { 0, 0, 0 }, },
                { key = 'BeaconIcon', color = { 0, 0, 0 }, },
                { key = 'BeaconHotkeyExpanded', color = { 0, 0, 0 }, },
                hl(),
            },
            onHoverOff =
            {
                { key = 'BeaconButton', color = Gui.BLACK, },
                { key = 'BeaconLabel', color = Gui.AMBER, },
                { key = 'BeaconIcon', color = Gui.AMBER, },
                { key = 'BeaconHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        tex('BeaconIcon','ui_iconIso_beacon','UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * 6) },Gui.AMBER,{nIconScale, nIconScale}),
        lc('InspectLabel',{ nLabelX, nLabelStartY },'HUDHUD005TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        lc('AssignLabel',{ nLabelX, nLabelStartY - nButtonHeight },'HUDHUD006TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        lc('ResearchLabel',{ nLabelX, nLabelStartY - nButtonHeight * 2 },'HUDHUD046TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        lc('GoalLabel',{ nLabelX, nLabelStartY - nButtonHeight * 3 },'HUDHUD052TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        lc('ConstructLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 4) },'HUDHUD007TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
        lc('MineLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 5) },'HUDHUD008TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        lc('BeaconLabel',{ nLabelX, nLabelStartY - (nButtonHeight * 6) },'HUDHUD025TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        tx('InspectHotkey',{ nHotkeyX, nHotkeyStartY },'I','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('InspectHotkeyExpanded',{ nHotkeyExpandedX, nHotkeyStartY },'I','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('AssignHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight },'R','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('AssignHotkeyExpanded',{ nHotkeyExpandedX, nHotkeyStartY - nButtonHeight },'R','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ResearchHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight * 2 },'E','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ResearchHotkeyExpanded',{ nHotkeyExpandedX, nHotkeyStartY - nButtonHeight * 2 },'E','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('GoalHotkey',{ nHotkeyX, nHotkeyStartY - nButtonHeight * 3 },'G','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('GoalHotkeyExpanded',{ nHotkeyExpandedX, nHotkeyStartY - nButtonHeight * 3 },'G','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ConstructHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 4) },'C','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('ConstructHotkeyExpanded',{ nHotkeyExpandedX, nHotkeyStartY - (nButtonHeight * 4) },'C','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('MineHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 5) },'M','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('MineHotkeyExpanded',{ nHotkeyExpandedX, nHotkeyStartY - (nButtonHeight * 5) },'M','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('BeaconHotkey',{ nHotkeyX, nHotkeyStartY - (nButtonHeight * 6) },'B','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('BeaconHotkeyExpanded',{ nHotkeyExpandedX, nHotkeyStartY - (nButtonHeight * 6) },'B','dosissemibold20',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tex('SidebarBottomEndcap','ui_hud_anglebottom','UI/HUD',{ -152, -(nButtonHeight * nNumButtons) },Gui.SIDEBAR_BG,{ 1, 1 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, -(nButtonHeight * nNumButtons) },Gui.SIDEBAR_BG,{ 1.12, 1.12 }),
    },
}
