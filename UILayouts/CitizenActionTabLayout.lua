local LH=require('UI.LH')
local lc,tex=LH.lc,LH.tex
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local nButtonWidth, nButtonHeight  = 418, 90
local buttonX = 50
return
{
    posInfo =
    {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 20,
    },
    tExtraInfo =
    {
    },
    tElements =
    {
        lc('BedLabel',{ 20, -35 },'INSPEC159TEXT','dosismedium32',{ 0, 300, 150, 0 },Gui.AMBER),
        tex('SecurityArrowL1','button_alert_flag','UI/Shared',{ 30, -108 },Gui.AMBER_OPAQUE,{1, 1}),
        tex('SecurityArrowL2','button_alert_flag','UI/Shared',{ 50, -108 },Gui.AMBER_OPAQUE,{1, 1}),
        tex('SecurityArrowL3','button_alert_flag','UI/Shared',{ 70, -108 },Gui.AMBER_OPAQUE,{1, 1}),
        tex('SecurityArrowR1','button_alert_flag','UI/Shared',{ 350, -108 },Gui.AMBER_OPAQUE,{-1, 1}),
        tex('SecurityArrowR2','button_alert_flag','UI/Shared',{ 370, -108 },Gui.AMBER_OPAQUE,{-1, 1}),
        tex('SecurityArrowR3','button_alert_flag','UI/Shared',{ 390, -108 },Gui.AMBER_OPAQUE,{-1, 1}),
        lc('SecurityLabel',{ 0, -100 },'INSPEC196TEXT','dosismedium32',{ 0, 300, nButtonWidth, 0 },Gui.AMBER,'C',nil,false),
        lc('SecurityWarningLabel',{ 0, -145 },'INSPEC197TEXT','dosissemibold20',{ 0, 300, nButtonWidth, 0 },Gui.RED,'C',nil,false),
        lc('BrigLabel',{ 20, -350 },'INSPEC188TEXT','dosismedium32',{ 0, 300, 150, 0 },Gui.AMBER),
    },
}
