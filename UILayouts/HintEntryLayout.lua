local LH=require('UI.LH')
local tx=LH.tx
local Gui = require('UI.Gui')
local tLayout =
{
    posInfo = LH.pos(nil, 'top', 0, 0, {1,1}),
    tElements =
    {
        {
            key = 'Button',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { 570, 70 },
            color = Gui.HINTLOG_BG,
        },
        tx('HintText',{ 10, -10 },"Log goes here.  Let's make sure the length is correct.",'dosissemibold22',{ 0, 300, 450, 0 },{ 0, 0, 0 }),
    },
}
return tLayout
