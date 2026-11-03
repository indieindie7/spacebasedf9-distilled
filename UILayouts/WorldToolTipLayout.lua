local LH=require('UI.LH')
local px,tex,tx,v=LH.px,LH.tex,LH.tx,LH.v
local function _h1(a0,a1) return {key=a0,pos=a1} end
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
            v('TipTexture1',false),
        },
        texture1HideOverride =
        {
            _h1('TipText1', { nTextMargin, nTextStartY + 3 }),
            v('TipTexture1',true),
        },
        texture2ShowOverride =
        {
            _h1('TipText2', { nTextWithTextureMargin, nTextStartY - nTextHeight }),
            v('TipTexture2',false),
        },
        texture2HideOverride =
        {
            _h1('TipText2', { nTextMargin, nTextStartY - nTextHeight }),
            v('TipTexture2',true),
        },
        texture3ShowOverride =
        {
            _h1('TipText3', { nTextWithTextureMargin, nTextStartY - (nTextHeight * 2) }),
            v('TipTexture3',false),
        },
        texture3HideOverride =
        {
            _h1('TipText3', { nTextMargin, nTextStartY - (nTextHeight * 2) }),
            v('TipTexture3',true),
        },
        texture4ShowOverride =
        {
            _h1('TipText4', { nTextWithTextureMargin, nTextStartY - (nTextHeight * 3) }),
            v('TipTexture4',false),
        },
        texture4HideOverride =
        {
            _h1('TipText4', { nTextMargin, nTextStartY - (nTextHeight * 3) }),
            v('TipTexture4',true),
        },
        texture5ShowOverride =
        {
            _h1('TipText5', { nTextWithTextureMargin, nTextStartY - (nTextHeight * 4) }),
            v('TipTexture5',false),
        },
        texture5HideOverride =
        {
            _h1('TipText5', { nTextMargin, nTextStartY - (nTextHeight * 4) }),
            v('TipTexture5',true),
        },
    },
    tElements =
    {
        px('Background',{ 0, 0 },{ nWidth, nHeight },{ 0, 0, 0 }),
        px('TopBorder',{ 0, 0 },{ nWidth, nBorderThickness },Gui.AMBER),
        px('BottomBorder',{ 0, -(nHeight - nBorderThickness) },{ nWidth, nBorderThickness },Gui.AMBER),
        px('LeftBorder',{ 0, 0 },{ nBorderThickness, nHeight },Gui.AMBER),
        px('RightBorder',{ nWidth, 0 },{ nBorderThickness, nHeight },Gui.AMBER),
        tx('TipText1',{ nTextMargin, -15 },'','dosissemibold30',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture1','ui_icon_health','UI/Inspector',{ nTextureMargin - 7, nTextureStartY + 4 },Gui.AMBER,nil,true),
        tx('TipText2',{ nTextMargin, nTextStartY - nTextHeight },'','dosissemibold26',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture2','ui_icon_health','UI/Inspector',{ nTextureMargin, nTextureStartY - nTextureHeight },Gui.AMBER,nil,true),
        tx('TipText3',{ nTextMargin, nTextStartY - (nTextHeight * 2) },'','dosissemibold26',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture3','ui_icon_health','UI/Inspector',{ nTextureMargin, nTextureStartY - (nTextureHeight * 2) },Gui.AMBER,nil,true),
        tx('TipText4',{ nTextMargin, nTextStartY - (nTextHeight * 3) },'','dosissemibold26',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture4','ui_icon_health','UI/Inspector',{ nTextureMargin, nTextureStartY - (nTextureHeight * 3) },Gui.AMBER,nil,true),
        tx('TipText5',{ nTextMargin, nTextStartY - (nTextHeight * 4) },'','dosissemibold26',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture5','ui_icon_health','UI/Inspector',{ nTextureMargin, nTextureStartY - (nTextureHeight * 4) },Gui.AMBER,nil,true),
       tx('TipText6',{ nTextMargin, nTextStartY - (nTextHeight * 5) },'','dosissemibold26',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture6','ui_icon_health','UI/Inspector',{ nTextureMargin, nTextureStartY - (nTextureHeight * 5) },Gui.AMBER,nil,true),
        tx('TipText7',{ nTextMargin, nTextStartY - (nTextHeight * 6) },'','dosissemibold26',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture7','ui_icon_health','UI/Inspector',{ nTextureMargin, nTextureStartY - (nTextureHeight * 6) },Gui.AMBER,nil,true),
        tx('TipText8',{ nTextMargin, nTextStartY - (nTextHeight * 7) },'','dosissemibold26',{ 0, 100, 1000, 0 },Gui.AMBER),
        tex('TipTexture8','ui_icon_health','UI/Inspector',{ nTextureMargin, nTextureStartY - (nTextureHeight * 7) },Gui.AMBER,nil,true),
    },
}
