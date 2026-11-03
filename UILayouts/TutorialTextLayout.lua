local LH=require('UI.LH')
local px,tex,tx=LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local nTutorialX = 0
local nTutorialY = -720
local nTutorialTextXOffset = 480
local nTutorialTextYOffset = 45
local nTutorialHeight = 96
local nTutorialOpacity = 0.65
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
    tElements =
    {
        tex('TutorialTextBGFadeTop','grad64','UI/Shared',{ nTutorialX, nTutorialY },{0, 0, 0, nTutorialOpacity},{ 2568/64, 1 },true),
        px('TutorialTextBG',{ nTutorialX, nTutorialY-64 },{ 2568, nTutorialHeight },{0, 0, 0, nTutorialOpacity},true),
        tex('TutorialTextBGFadeBottom','grad64','UI/Shared',{ nTutorialX, nTutorialY-64-nTutorialHeight-64 },{0, 0, 0, nTutorialOpacity},{ 2568/64, -1 },true),
		tx('TutorialText',{ nTutorialX+nTutorialTextXOffset, nTutorialY+nTutorialTextYOffset },'Hi, this is a training message. Press the BLUH key to frobnabulate the wizard. Use the foot pedal to scroll through Z-levels and the dwarf toe to rectify all breakfast cereals. Sure, another sentence to test text overflow.','dosissemibold42',{ 0, 300, 1500, 0 },Gui.AMBER,'R','C',true),
        tex('TutorialBlip','ui_hud_speed0','UI/HUD',{ 1790, -170 },Gui.RED,{2, 2},true),
	},
}
