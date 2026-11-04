local LH=require('UI.LH')
local px=LH.px
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
return
{
    posInfo =
       {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
    },
    tExtraInfo =
    {
    },
    tElements =
    {
        px('Foreground',{ 0, 0 },nil,Gui.AMBER),
        px('Background',{ 0, 0 },nil,Gui.BLACK),
    },
}
