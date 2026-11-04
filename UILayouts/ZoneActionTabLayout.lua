local LH=require('UI.LH')
local lc=LH.lc
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 90
local nLabelX = 8
local nCustomControlLabelY = -120
local nScrollAreaTopMargin = 210
return
{
    posInfo = LH.pos('left', 'top', 0, 20),
    tExtraInfo =
    {
    },
    tElements =
    {
		lc('CustomControlsLabel',{ nLabelX, nCustomControlLabelY },'PROPSX098TEXT','dosissemibold26',{ 0, 100, 500, 0 },Gui.AMBER,'L','C'),
        {
            key = 'AssignmentButtonScrollPane',
            type = 'scrollPane',
            pos = { 60, -nScrollAreaTopMargin },
            rect = { 0, 0, 330, '(g_GuiManager.getUIViewportSizeY()- 720)' },
            scissorLayerName='UIScrollLayerLeft',
        },
    },
}
