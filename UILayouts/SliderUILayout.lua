local LH=require('UI.LH')
local px=LH.px
local Gui = require('UI.Gui')
return
{
    posInfo = LH.pos('left', 'top', 0, 0),
    tElements =
    {
        px('Background',{ 0, 0 },{ 400, 40 },Gui.WHITE),
        px('Foreground',{ 0, 0 },{ 400, 40 },Gui.AMBER),
        px('Thumb',{ 0, 0 },{ 10, 40 },Gui.BLACK),
    }
}
