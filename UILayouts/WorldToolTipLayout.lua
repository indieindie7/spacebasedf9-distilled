local function _h1(a0,a1) return {key=a0,pos=a1} end
local function _h2(a0,a1) return {key=a0,hidden=a1} end
local function _h3(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
local function _h4(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,color=a4,hidden=a5,pos=a6} end
local Gui = require('UI.Gui')
local nWidth, nHeight = 200, 120
local nBorderThickness = 4
local nTextMargin = 18
local nTextWithTextureMargin = 42
local nTextStartY = -10
local nTextHeight = 30
local nTextureMargin = 16
local nTextureStartY = -16
local nTextureHeight = 30
return
{
    posInfo =
        {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
        scale = { 1, 1 },
    },
    tExtraInfo =
    {
        texture1ShowOverride =
        {
            _h1('TipText1', { nTextWithTextureMargin, nTextStartY + 3 }),
            _h2('TipTexture1', false),
        },
        texture1HideOverride =
        {
            _h1('TipText1', { nTextMargin, nTextStartY + 3 }),
            _h2('TipTexture1', true),
        },
        texture2ShowOverride =
        {
            _h1('TipText2', { nTextWithTextureMargin, nTextStartY - nTextHeight }),
            _h2('TipTexture2', false),
        },
        texture2HideOverride =
        {
            _h1('TipText2', { nTextMargin, nTextStartY - nTextHeight }),
            _h2('TipTexture2', true),
        },
        texture3ShowOverride =
        {
            _h1('TipText3', { nTextWithTextureMargin, nTextStartY - (nTextHeight * 2) }),
            _h2('TipTexture3', false),
        },
        texture3HideOverride =
        {
            _h1('TipText3', { nTextMargin, nTextStartY - (nTextHeight * 2) }),
            _h2('TipTexture3', true),
        },
        texture4ShowOverride =
        {
            _h1('TipText4', { nTextWithTextureMargin, nTextStartY - (nTextHeight * 3) }),
            _h2('TipTexture4', false),
        },
        texture4HideOverride =
        {
            _h1('TipText4', { nTextMargin, nTextStartY - (nTextHeight * 3) }),
            _h2('TipTexture4', true),
        },
        texture5ShowOverride =
        {
            _h1('TipText5', { nTextWithTextureMargin, nTextStartY - (nTextHeight * 4) }),
            _h2('TipTexture5', false),
        },
        texture5HideOverride =
        {
            _h1('TipText5', { nTextMargin, nTextStartY - (nTextHeight * 4) }),
            _h2('TipTexture5', true),
        },
    },
    tElements =
    {
        _h3('Background', 'onePixel', { 0, 0 }, { nWidth, nHeight }, { 0, 0, 0 }),
        _h3('TopBorder', 'onePixel', { 0, 0 }, { nWidth, nBorderThickness }, Gui.AMBER),
        _h3('BottomBorder', 'onePixel', { 0, -(nHeight - nBorderThickness) }, { nWidth, nBorderThickness }, Gui.AMBER),
        _h3('LeftBorder', 'onePixel', { 0, 0 }, { nBorderThickness, nHeight }, Gui.AMBER),
        _h3('RightBorder', 'onePixel', { nWidth, 0 }, { nBorderThickness, nHeight }, Gui.AMBER),
        {
            key = 'TipText1',
            type = 'textBox',
            pos = { nTextMargin, -15 },
            text = '',
            style = 'dosissemibold30',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture1', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin - 7, nTextureStartY + 4 }),
        {
            key = 'TipText2',
            type = 'textBox',
            pos = { nTextMargin, nTextStartY - nTextHeight },
            text = '',
            style = 'dosissemibold26',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture2', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin, nTextureStartY - nTextureHeight }),
        {
            key = 'TipText3',
            type = 'textBox',
            pos = { nTextMargin, nTextStartY - (nTextHeight * 2) },
            text = '',
            style = 'dosissemibold26',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture3', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin, nTextureStartY - (nTextureHeight * 2) }),
        {
            key = 'TipText4',
            type = 'textBox',
            pos = { nTextMargin, nTextStartY - (nTextHeight * 3) },
            text = '',
            style = 'dosissemibold26',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture4', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin, nTextureStartY - (nTextureHeight * 3) }),
        {
            key = 'TipText5',
            type = 'textBox',
            pos = { nTextMargin, nTextStartY - (nTextHeight * 4) },
            text = '',
            style = 'dosissemibold26',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture5', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin, nTextureStartY - (nTextureHeight * 4) }),
       {
            key = 'TipText6',
            type = 'textBox',
            pos = { nTextMargin, nTextStartY - (nTextHeight * 5) },
            text = '',
            style = 'dosissemibold26',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture6', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin, nTextureStartY - (nTextureHeight * 5) }),
        {
            key = 'TipText7',
            type = 'textBox',
            pos = { nTextMargin, nTextStartY - (nTextHeight * 6) },
            text = '',
            style = 'dosissemibold26',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture7', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin, nTextureStartY - (nTextureHeight * 6) }),
        {
            key = 'TipText8',
            type = 'textBox',
            pos = { nTextMargin, nTextStartY - (nTextHeight * 7) },
            text = '',
            style = 'dosissemibold26',
            rect = { 0, 100, 1000, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h4('TipTexture8', 'uiTexture', 'ui_icon_health', 'UI/Inspector', Gui.AMBER, true, { nTextureMargin, nTextureStartY - (nTextureHeight * 7) }),
    },
}
