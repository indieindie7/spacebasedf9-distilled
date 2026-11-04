local LH=require('UI.LH')
local tx=LH.tx
local Gui = require('UI.Gui')
return
{
    posInfo = LH.pos('right', 'top', -480, 0),
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
                pos = { -30, 0 },
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
            color = Gui.AMBER,
        },
        tx('ButtonLabel',{ -30, 0 },"!",'dosissemibold38',{ 0, 300, 450, 0 },{ 0, 0, 0 }),
   },
}
