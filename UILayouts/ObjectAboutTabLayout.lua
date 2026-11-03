local LH=require('UI.LH')
local lc=LH.lc
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
local nStatLabelMargin, nStatTextMargin  = 35, 210
local nStatsStartY = 0
local nLineSize = 40
local nInspectorWidth = 418
return
{
    posInfo =
        {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = -6,
    },
    tExtraInfo =
    {
		nLineSize = nLineSize,
    },
    tElements =
    {
        lc('FlavorText',{ 8, nStatsStartY - 2 },'OBFLAV007TEXT','dosissemibold20',{ 0, 800, 400, 0 },Gui.AMBER),
    },
}
