local LH=require('UI.LH')
local c,px,tex=LH.c,LH.px,LH.tex
local Gui = require('UI.Gui')
return
{
    posInfo = LH.pos('left', 'top', 0, 0),
	tExtraInfo =
	{
		nMarginY = 12,
	},
    tElements =
    {
        {
            key = 'Button',
            type = 'onePixelButton',
            pos = { 10, -40 },
            scale = { 405, 60 },
            color = Gui.RED,
            hidden = true,
            clickWhileHidden = true,
            onHoverOn =
            {
                {
                    key = 'StarBG',
                    hidden = false
                },
                c('DutyButton',Gui.AMBER),
                c('DutyButtonLabelBG',Gui.AMBER),
                c('ButtonLabel',{0,0,0}),
                c('ButtonDescription',{0,0,0}),
            },
            onHoverOff =
            {
                {
                    key = 'StarBG',
                    hidden = true
                },
                c('DutyButton',Gui.AMBER),
                c('DutyButtonLabelBG',Gui.AMBER_OPAQUE),
                c('ButtonLabel',Gui.AMBER),
                c('ButtonDescription',Gui.AMBER),
            },
        },
        px('StarBG',{ 224, -41 },{ 130, 59 },{ 0, 0, 0 },true),
        {
            key = 'DutyButton',
            type = 'uiTexture',
            textureName = 'ui_inspector_dutybutton',
            sSpritesheetPath = 'UI/Inspector',
            pos = { 10, -40 },
            scale = { 1, 1 },
            color = Gui.AMBER,
            layerOverride = 'UIScrollLayerLeft',
        },
        {
            key = 'DutyButtonLabelBG',
            type = 'uiTexture',
            textureName = 'ui_inspector_dutybuttonlabel',
            sSpritesheetPath = 'UI/Inspector',
            pos = { 60, -42 },
            scale = { 1, 1 },
            color = Gui.AMBER_OPAQUE,
            layerOverride = 'UIScrollLayerLeft',
        },
        {
            key = 'ButtonLabel',
            type = 'textBox',
            pos = { -180, -40 },
            text = "ERROR",
            style = 'dosissemibold30',
            rect = { 0, 100, 400, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
            layerOverride = 'UIScrollLayerLeft',
        },
        {
            key = 'ButtonDescription',
            type = 'textBox',
            pos = { -180, -74 },
            text = "ERROR",
            style = 'dosissemibold16',
            rect = { 0, 300, 400, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
            layerOverride = 'UIScrollLayerLeft',
        },
        {
            key = 'PropDescription',
            type = 'textBox',
            pos = { 366, -54 },
            text = "",
            style = 'dosissemibold30',
            rect = { 0, 300, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
            layerOverride = 'UIScrollLayerLeft',
        },
        tex('DutyIcon','ui_jobs_iconJobBarkeep','UI/JobRoster',{ 23, -55 },Gui.AMBER,{ 1, 1 },false),
        tex('SkillIcon','ui_icon_friend','UI/Inspector',{ 345, -55 },{ 0, 0, 0},{ 1.25, 1.25 },false),
        {
            key = 'NumText',
            type = 'textBox',
            pos = { 137, -48 },
            text = "1",
            style = 'dosissemibold35',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
            layerOverride = 'UIScrollLayerLeft',
        },
        tex('StarsIcon','ui_jobs_skillrank5','UI/JobRoster',{ 185, -40 },Gui.AMBER,{ 1, 1 },false),
        tex('AffIcon','ui_dialogicon_meh','UI/Emoticons',{ 290, -52 },Gui.AMBER,{ 1, 1 },false),
    },
}
