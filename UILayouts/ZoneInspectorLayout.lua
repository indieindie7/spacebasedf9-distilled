local LH=require('UI.LH')
local tex,tx=LH.tex,LH.tx
local function _h1(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
local nTabWidth, nTabHeight = 83, 47
local nTabLineHeight = 3
local nControlButtonX, nControlButtonY = 32, -370
local nControlButtonWidth, nControlButtonHeight = 160, 37
local labelX, labelY = -20, nControlButtonY - 5
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
		nTabWidth = nTabWidth,
		nTabHeight = nTabHeight,
		nTabLineHeight = nTabLineHeight,
    },
    tElements =
    {
        _h1('PictureLargeBG', 'onePixel', { 0, -163 }, { nButtonWidth, 106 }, Gui.AMBER),
        _h1('NameEditBG', 'onePixelButton', { 0, -176 }, { nButtonWidth, 35 }, Gui.AMBER),
        _h1('PictureBG', 'onePixel', { 30, -144 }, { 110, 20 }, Gui.AMBER),
        tex('Picture','portrait_generic','UI/Portraits',{ 33, -145 },Gui.AMBER,{ 0.84, 0.84 }),
        tx('NameLabel',{ 150, -174 },"Reactor Zone Tao",'dosissemibold26',{ 0, 300, 500, 0 },{ 0, 0, 0 }),
        {
            key = 'NameEditButton',
            type = 'onePixelButton',
            pos = { 0, -176 },
            scale = { nButtonWidth, 35 },
            color = { 1, 0, 0 },
            hidden = true,
			clickWhileHidden = true,
            onHoverOn =
            {
                { key = 'NameLabel', color = Gui.AMBER, },
                { key = 'NameEditBG', color = Gui.AMBER_OPAQUE, },
				{ key = 'NameEditTexture', hidden = false, },
            },
            onHoverOff =
            {
                { key = 'NameLabel', color = Gui.BLACK, },
                { key = 'NameEditBG', color = Gui.AMBER },
				{ key = 'NameEditTexture', hidden = true, },
            },
            onSelectedOn =
            {
                { key = 'NameLabel', color = Gui.AMBER, },
                { key = 'NameEditBG', color = Gui.BLACK, },
				{ key = 'NameEditTexture', hidden = true, },
            },
            onSelectedOff =
            {
                { key = 'NameLabel', color = Gui.BLACK, },
                { key = 'NameEditBG', color = Gui.AMBER },
				{ key = 'NameEditTexture', hidden = true, },
            },
        },
        tex('NameEditTexture','ui_inspector_buttonEdit','UI/Inspector',{ 380, -176 },Gui.AMBER,nil,true),
        tx('AlertLabel',{ 150, -216 },"",'dosisregular26',{ 0, 300, 500, 0 },{ 0, 0, 0 }),
        _h1('StatsBG', 'onePixel', { 0, -268 }, { nButtonWidth, 152 }, Gui.AMBER_OPAQUE),
        tx('DescriptionText',{ 20, -280 },"",'dosissemibold26',{ 0, 300, 400, 0 },Gui.AMBER),
        _h1('TabBGSpacer', 'onePixel', { nTabWidth * 3, -420 }, { nTabWidth*2 + 3, nTabHeight }, Gui.AMBER_OPAQUE),
        _h1('TabLineSpacer', 'onePixel', { nTabWidth * 3, -420-nTabHeight }, { nTabWidth*2 + 3, nTabLineHeight }, Gui.AMBER),
        {
            key = 'TabbedPane',
            type = 'tabbedPane',
            pos = { 0, -428 },
            rect = { 0, 0, nButtonWidth-20, '(g_GuiManager.getUIViewportSizeY()-497)' },
        },
    },
}
