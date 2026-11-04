local LH=require('UI.LH')
local tx=LH.tx
local Gui = require('UI.Gui')
return
{
    posInfo = LH.pos('right', 'top', -480, -240),
    tExtraInfo =
    {
        minimizedOverride =
        {
            {
                key = 'Button',
                pos = { 400, 0 },
            },
            {
                key = 'ButtonLabel',
                pos = { 415, 0 },
            },
        },
        maximizedOverride =
        {
            {
                key = 'Button',
                pos = { -50, 0 },
            },
            {
                key = 'ButtonLabel',
                pos = { -35, 0 },
            },
        },
    },
    tElements =
    {
        {
            key = 'Button',
            type = 'onePixelButton',
            pos = { -50, 0 },
            scale = { 50, 50 },
            color = Gui.HINTLOG_HIGHLIGHT,
        },
        tx('ButtonLabel',{ -35, 0 },"?",'dosissemibold38',{ 0, 300, 450, 0 },{ 0, 0, 0 }),
    },
}
