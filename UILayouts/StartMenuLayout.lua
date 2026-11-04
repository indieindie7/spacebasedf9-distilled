local LH=require('UI.LH')
local lc,px,tex=LH.lc,LH.px,LH.tex
local Gui = require('UI.Gui')
local PAUSESCREEN_BG = { 0, 0, 0, 0.3 }
local nMenuItemsX = 100
local nMOTDX = -900
local nLineStartY = 120
local nLineHeight = 80
return
{
    posInfo =
        {
        alignX = 'center',
        alignY = 'center',
        offsetX = 0,
        offsetY = 0,
        scale = { 1, 1 },
    },
	tExtraInfo =
	{
		nMOTDX = nMOTDX,
	},
    tElements =
    {
        px('Background',{ -777, 641 },{ 2568, 1444 },PAUSESCREEN_BG,false),
        tex('TextBGFadeTop','grad64','UI/Shared',{ -1920/2 - 64, 239 },{0, 0, 0, 0.6},{ 2568/64, 1 }),
        px('MOTDTextBackground',{ -1920/2 - 64, 175 },{ 2568, 625 },{0, 0, 0, 0.6},false),
        tex('TextBGFadeBottom','grad64','UI/Shared',{ -1920/2 - 64, -514 },{0, 0, 0, 0.6},{ 2568/64, -1 }),
        tex('Logo','logo','UI/StartMenu',{ -1920/2, 1152/2 + 50 },Gui.WHITE,{ 1.5, 1.5 },false),
        lc('MOTDTitle',{ nMOTDX, 150 },'UIMISC022TEXT','dosissemibold38',{ 0, 50, 705, 0 },Gui.AMBER),
        lc('WebsiteText',{ -400, 260 },"UIMISC016TEXT",'dosismedium32',{ 0, 70, 800, 0 },Gui.AMBER,'C','C'),
        {
            key = 'ButtonWebsite',
            type = 'onePixelButton',
            pos = { -400, 260 },
            scale = { 800, 70 },
            color = Gui.WHITE,
            hidden=true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'WebsiteText', color = Gui.BRIGHT_AMBER, },
            },
            onHoverOff =
            {
                { key = 'WebsiteText', color = Gui.AMBER, },
            },
        },
        {
            key = 'ButtonResume',
            type = 'onePixelButton',
            pos = { 280, nLineStartY },
            scale = { 630, 70 },
            color = Gui.RED,
            hidden=true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'ButtonResumeText', color = Gui.BRIGHT_AMBER, },
            },
            onHoverOff =
            {
                { key = 'ButtonResumeText', color = Gui.AMBER, },
            },
        },
        {
            key = 'ButtonNewGame',
            type = 'onePixelButton',
            pos = { 280, nLineStartY - nLineHeight },
            scale = { 630, 70 },
            color = Gui.RED,
            hidden=true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'ButtonNewGameText', color = Gui.BRIGHT_AMBER, },
            },
            onHoverOff =
            {
                { key = 'ButtonNewGameText', color = Gui.AMBER, },
            },
        },
        {
            key = 'ButtonQuit',
            type = 'onePixelButton',
            pos = { 280, nLineStartY - nLineHeight*2 },
            scale = { 630, 70 },
            color = Gui.RED,
            hidden=true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'ButtonQuitText', color = Gui.BRIGHT_AMBER, },
            },
            onHoverOff =
            {
                { key = 'ButtonQuitText', color = Gui.AMBER, },
            },
        },
        lc('ButtonResumeText',{ nMenuItemsX, nLineStartY },'UIMISC023TEXT','orbitronWhite',{ 0, 70, 800, 0 },Gui.AMBER,'R','C'),
        lc('ButtonNewGameText',{ nMenuItemsX, nLineStartY - nLineHeight },'UIMISC024TEXT','orbitronWhite',{ 0, 70, 800, 0 },Gui.AMBER,'R','C'),
        lc('ButtonQuitText',{ nMenuItemsX, nLineStartY - nLineHeight*2 },'UIMISC027TEXT','orbitronWhite',{ 0, 70, 800, 0 },Gui.AMBER,'R','C'),
    },
}
