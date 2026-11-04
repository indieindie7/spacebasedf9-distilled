local LH=require('UI.LH')
local tex=LH.tex
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
return
{
    posInfo = LH.pos('left', 'top'),
    tExtraInfo =
    {
        tCallbacks =
        {
            onSelected =
            {
                { key = 'TabActive', color = Gui.AMBER, hidden = false, },
                { key = 'Tab', hidden = true, },
                { key = 'Icon', color = Gui.BLACK, },
            },
            onDeselected =
            {
                { key = 'TabActive', hidden = true, },
                { key = 'Tab', hidden = false, },
                { key = 'Icon', color = Gui.AMBER, },
            },
        },
    },
    tElements =
    {
        tex('TabBackground','ui_inspector_folderTop_5wide','UI/Inspector',{ 0, 8 },Gui.AMBER_OPAQUE,{ 1, 1 }),
        tex('TabActive','ui_inspector_folderActive_5wide','UI/Inspector',{ 0, 0 },Gui.AMBER,{ 1, 1 },true),
        tex('Tab','ui_inspector_folderInactive_5wide','UI/Inspector',{ 0, 0 },Gui.AMBER,{ 1, 1 }),
        {
            key = 'TabButton',
            type = 'onePixel',
            pos = { 12, 0 },
            scale = { 83, 42 },
            color = Gui.RED,
            hidden = true,
            onHoverOn =
            {
                { key = 'TabActive', color = Gui.GREY, hidden = false, },
                { key = 'Tab', hidden = true, },
                { key = 'Icon', color = Gui.BLACK, },
            },
            onHoverOff =
            {
                { key = 'TabActive', hidden = true, },
                { key = 'Tab', hidden = false, },
                { key = 'Icon', color = Gui.AMBER, },
            },
        },
        tex('Icon','ui_iconIso_confirm','UI/Inspector',{ 26, -8 },Gui.AMBER),
    },
}
