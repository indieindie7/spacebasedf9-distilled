local LH=require('UI.LH')
local tex=LH.tex
local Gui = require('UI.Gui')
return
{
    posInfo =
    {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
    },
    tElements =
    {
        tex('Background','ui_iconIso_confirm_circle','UI/Shared',{ 0, 0 },Gui.WHITE,{ 0.5, 0.5 },false),
        tex('Check','ui_iconIso_confirm','UI/Shared',{ 0, 0 },Gui.AMBER,{ 0.5, 0.5 },false),
        {
            key = 'ButtonToggle',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { 64, 64 },
            color = Gui.WHITE,
            hidden = true,
            clickWhileHidden=true,
        }
    }
}
