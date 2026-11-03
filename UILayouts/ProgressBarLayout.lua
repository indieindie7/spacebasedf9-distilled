local LH=require('UI.LH')
local px=LH.px
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
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
