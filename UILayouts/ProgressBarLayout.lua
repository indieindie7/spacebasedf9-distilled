local LH=require('UI.LH')
local px=LH.px
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
return
{
    posInfo = LH.pos('left', 'top', 0, 0),
    tExtraInfo =
    {
    },
    tElements =
    {
        px('Foreground',{ 0, 0 },nil,Gui.AMBER),
        px('Background',{ 0, 0 },nil,Gui.BLACK),
    },
}
