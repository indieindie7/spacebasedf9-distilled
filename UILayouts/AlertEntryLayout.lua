local LH=require('UI.LH')
local btn,tx=LH.btn,LH.tx
local Gui = require('UI.Gui')
local tLayout =
{
    posInfo = LH.pos(nil, 'top', 0, 0, {1,1}),
    tElements =
    {
        btn('Button',{ 0, 0 },{ 440, 100 },Gui.ALERTLOG_BG,{ { key = 'Button', color = Gui.AMBER, }, },{ { key = 'Button', color = Gui.ALERTLOG_BG, }, }),
        tx('AlertText',{ 10, -10 },"Log goes here.  Let's make sure the length is correct.",'dosissemibold22',{ 0, 300, 430, 0 },Gui.BLACK),
        tx('TimeText',{ 10, -50 },"0 minutes ago",'dosissemibold20',{ 0, 300, 450, 0 },Gui.BLACK),
    },
}
return tLayout
