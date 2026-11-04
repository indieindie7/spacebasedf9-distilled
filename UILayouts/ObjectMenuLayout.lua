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
local tZones =
{
    { 'All', 'object', 'ZONEUI058TEXT', 'Z' },
    { 'Airlock', 'airlock', 'ZONEUI036TEXT', 'A' },
    { 'Reactor', 'reactor', 'ZONEUI003TEXT', 'T' },
    { 'Garden', 'garden', 'ZONEUI069TEXT', 'G' },
    { 'LifeSupport', 'lifesupport', 'ZONEUI001TEXT', 'S' },
    { 'Pub', 'pub', 'ZONEUI046TEXT', 'B' },
    { 'Refinery', 'refineryAlt', 'ZONEUI037TEXT', 'F' },
    { 'Residence', 'residence', 'ZONEUI042TEXT', 'R' },
    { 'Fitness', 'fitness', 'ZONEUI109TEXT', 'N' },
    { 'Research', 'research', 'ZONEUI126TEXT', 'H' },
    { 'Infirmary', 'infirmary', 'ZONEUI049TEXT', 'I' },
}
local function cat(...)
    local tOut = {}
    for _, tList in ipairs({ ... }) do
        for _, tElem in ipairs(tList) do tOut[#tOut + 1] = tElem end
    end
    return tOut
end
local zoneRows = { btn = {}, icon = {}, label = {}, key = {} }
for i, tZone in ipairs(tZones) do
    local sName, sIcon, sLabelCode, sKey = tZone[1], tZone[2], tZone[3], tZone[4]
    local n = i - 1
    local sBtn, sLabel, sIconKey, sHot = sName .. 'Button', sName .. 'Label', sName .. 'Icon', sName .. 'Hotkey'
    table.insert(zoneRows.btn, btn(sBtn,{ 0, -(nButtonStartY + n*nButtonHeight) },{ nButtonWidth, nButtonHeight },BLACK,{ c(sBtn,AMBER), c(sLabel,{ 0, 0, 0 }), c(sIconKey,{ 0, 0, 0 }), c(sHot,{ 0, 0, 0 }), },hv(BLACK,sBtn,Gui.AMBER,sLabel,sIconKey,sHot),BRIGHT_AMBER,AMBER))
    table.insert(zoneRows.icon, tex(sIconKey,'ui_iconIso_' .. sIcon,'UI/Shared',{ nIconX, nIconStartY - (nButtonHeight * n) },Gui.AMBER,{ nIconScale, nIconScale }))
    table.insert(zoneRows.label, lc(sLabel,{ nLabelX, nLabelStartY - (nButtonHeight * n) },sLabelCode,'dosisregular40',{ 0, 300, nButtonWidth, 0 },Gui.AMBER))
    table.insert(zoneRows.key, tx(sHot,{ nHotkeyX, nHotkeyStartY - (nButtonHeight * n) },sKey,'dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'))
end
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
    tElements = cat(
    {
        px('LargeBar',{ 0, 0 },{ nButtonWidth, nButtonStartY + (numButtons * nButtonHeight) },Gui.SIDEBAR_BG),
        btn('BackButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },BLACK,{ c('BackButton',AMBER), c('BackLabel',{ 0, 0, 0 }), c('BackHotkey',{ 0, 0, 0 }), },hv(BLACK,'BackButton',Gui.AMBER,'BackLabel','BackHotkey'),BRIGHT_AMBER,AMBER),
        btn('CancelButton',{ 0, -nButtonHeight },{ nButtonWidth, nButtonHeight },BLACK,{ c('CancelButton',CONSTRUCT_CANCEL), c('CancelIcon',{ 0, 0, 0 }), c('CancelLabel',{ 0, 0, 0 }), c('CancelHotkey',{ 0, 0, 0 }), },hv(BLACK,'CancelButton',CONSTRUCT_CANCEL,'CancelIcon','CancelLabel','CancelHotkey')),
        btn('ConfirmButton',{ 0, -nButtonHeight * 2 },{ nButtonWidth, nButtonHeight },BLACK,{ c('ConfirmButton',CONSTRUCT_CONFIRM), c('ConfirmLabel',{ 0, 0, 0 }), c('ConfirmIcon',{ 0, 0, 0 }), c('ConfirmHotkey',{ 0, 0, 0 }), c('CostBackground',CONSTRUCT_CONFIRM), c('CostBackgroundEndCap',CONSTRUCT_CONFIRM), c('CostVerticalRule',{ 0, 0, 0 }), c('CostIconMatter',{ 0, 0, 0 }), c('CostText',{ 0, 0, 0 }), },hv(BLACK,'ConfirmButton',CONSTRUCT_CONFIRM,'ConfirmLabel','ConfirmIcon','ConfirmHotkey',{ 0, 0, 0 },'CostBackground','CostBackgroundEndCap',CONSTRUCT_CONFIRM,'CostVerticalRule','CostIconMatter','CostText'),BRIGHT_AMBER,AMBER),
        },
        zoneRows.btn,
        {
        tex('CancelIcon','ui_iconIso_decline','UI/Shared',{ nIconX, nCancelIconStartY },CONSTRUCT_CANCEL,{ nIconScale, nIconScale }),
        tex('ConfirmIcon','ui_iconIso_confirm','UI/Shared',{ nIconX, nCancelIconStartY - nButtonHeight },CONSTRUCT_CONFIRM,{ nIconScale, nIconScale }),
        },
        zoneRows.icon,
        {
        lc('MenuSublabel',{ 40, -244 },"HUDHUD024TEXT",'dosissemibold22',{ 0, 100, 400, 0 },Gui.GREY),
        lc('BackLabel',{ nLabelX, -10 },'HUDHUD009TEXT','dosisregular40',{ 0, 300, 400, 0 },Gui.AMBER),
        lc('CancelLabel',{ nLabelX, nCancelLabelStartY },'HUDHUD034TEXT','dosisregular40',{ 0, 300, 200, 0 },CONSTRUCT_CANCEL),
        lc('ConfirmLabel',{ nLabelX, nCancelLabelStartY - nButtonHeight },'HUDHUD019TEXT','dosisregular40',{ 0, 300, 280, 0 },CONSTRUCT_CONFIRM),
        },
        zoneRows.label,
        {
        tx('BackHotkey',{ nHotkeyX - 4, -50 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        tx('CancelHotkey',{ nHotkeyX, nCancelHotkeyY },'X','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CANCEL,'R'),
        tx('ConfirmHotkey',{ nHotkeyX, nCancelHotkeyY - nButtonHeight },'C','dosissemibold22',{ 0, 100, 100, 0 },CONSTRUCT_CONFIRM,'R'),
        },
        zoneRows.key,
        {
        px('SelectionHighlight',{ 0, 0 },{ nButtonWidth, nButtonHeight },SELECTION_AMBER,true),
        px('CostBackground',{ nButtonWidth, -nButtonHeight * 2 },{ nBGWidth, nButtonHeight },CONSTRUCT_CONFIRM),
        tex('CostBackgroundEndCap','ui_confirm_endcap','UI/Shared',{ nButtonWidth + nBGWidth - 1, -nButtonHeight * 2 },CONSTRUCT_CONFIRM),
        tex('CostVerticalRule','ui_confirm_verticalrule','UI/Shared',{ nButtonWidth, -(nButtonHeight * 2) - 4 },{ 0, 0, 0 }),
        tex('CostIconMatter','ui_confirm_iconmatter','UI/Shared',{ nButtonWidth + 10, -(nButtonHeight * 2) - 10 },{ 0, 0, 0 }),
        tx('CostText',{ nButtonWidth + 34, -(nButtonHeight * 2) - 4 },"-450 Build\n+75 Demolish\n+36 Undo",'dosissemibold18',{ 0, 100, 500, 0 },{ 0, 0, 0 }),
        tex('SidebarBottomEndcapExpanded','ui_hud_anglebottom','UI/HUD',{ 0, -(nButtonStartY + numButtons*nButtonHeight) + 1 },Gui.SIDEBAR_BG,{ 1.28, 1.28 }),
    }),
}
