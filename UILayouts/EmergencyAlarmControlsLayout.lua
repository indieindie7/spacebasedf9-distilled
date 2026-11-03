local LH=require('UI.LH')
local btn,lc,tex,v=LH.btn,LH.lc,LH.tex,LH.v
local Gui = require('UI.Gui')
local buttonX, buttonY = 18, -225
local buttonWidth, buttonHeight, buttonSpacing = 190, 37, 0
local labelY = -192
return
{
    posInfo =
        {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = -30,
    },
    tElements =
    {
        btn('OnButton',{ buttonX, buttonY },{ buttonWidth, buttonHeight },{ 0, 0, 0, 0 },{ { key = 'OnLabel', color = Gui.BLACK, }, v('OnButtonTexture',true), v('OnButtonTexturePressed',false), },{ { key = 'OnLabel', color = Gui.AMBER, }, v('OnButtonTexture',false), v('OnButtonTexturePressed',true), }),
		tex('OnButtonTexture','buttontoggle2_left','UI/Shared',{ buttonX, buttonY },Gui.AMBER,{ 1, 1 }),
		tex('OnButtonTexturePressed','buttontoggle2_left_pressed','UI/Shared',{ buttonX, buttonY },Gui.AMBER,{ 1, 1 },true),
        lc('OnLabel',{ buttonX + 40, labelY },'PROPSX042TEXT','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'C','C'),
        btn('OffButton',{ buttonX + buttonWidth + buttonSpacing, buttonY },{ buttonWidth, buttonHeight },{ 0, 0, 0, 0 },{ { key = 'OffLabel', color = Gui.BLACK, }, v('OffButtonTexture',true), v('OffButtonTexturePressed',false), },{ { key = 'OffLabel', color = Gui.AMBER, }, v('OffButtonTexture',false), v('OffButtonTexturePressed',true), }),
 		tex('OffButtonTexture','buttontoggle2_right','UI/Shared',{ buttonX + buttonWidth + buttonSpacing, buttonY },Gui.AMBER,{ 1, 1 }),
		tex('OffButtonTexturePressed','buttontoggle2_right_pressed','UI/Shared',{ buttonX + buttonWidth + buttonSpacing, buttonY },Gui.AMBER,{ 1, 1 },true),
       lc('OffLabel',{ buttonX + buttonWidth + buttonSpacing + 50, labelY },'PROPSX043TEXT','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'C','C'),
    },
}
