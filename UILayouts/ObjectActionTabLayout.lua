local LH=require('UI.LH')
local lc=LH.lc
local Gui = require('UI.Gui')
local nLabelX, nLabelY = 16, -170
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
		lc('CustomControlsLabel',{ nLabelX, nLabelY },'PROPSX089TEXT','dosissemibold26',{ 0, 100, 400, 0 },Gui.AMBER,'L','C'),
    },
}
