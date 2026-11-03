local function _h1(a0,a1) return {key=a0,color=a1} end
local function _h2(a0,a1,a2,a3,a4,a5,a6,a7) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,scale=a5,color=a6,hidden=a7} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.1 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
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
                _h1('DutyButton', Gui.AMBER),
                _h1('DutyButtonLabelBG', Gui.AMBER),
                _h1('ButtonLabel', {0,0,0}),
                _h1('ButtonDescription', {0,0,0}),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                {
                    key = 'StarBG',
                    hidden = true
                },
                _h1('DutyButton', Gui.AMBER),
                _h1('DutyButtonLabelBG', Gui.AMBER_OPAQUE),
                _h1('ButtonLabel', Gui.AMBER),
                _h1('ButtonDescription', Gui.AMBER),
            },
        },
        {
            key = 'StarBG',
            type = 'onePixel',
            pos = { 224, -41 },
            scale = { 130, 59 },
            color = { 0, 0, 0 },
            hidden = true,
        },
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
        _h2('DutyIcon', 'uiTexture', 'ui_jobs_iconJobBarkeep', 'UI/JobRoster', { 23, -55 }, { 1, 1 }, Gui.AMBER, false),
        _h2('SkillIcon', 'uiTexture', 'ui_icon_friend', 'UI/Inspector', { 345, -55 }, { 1.25, 1.25 }, { 0, 0, 0}, false),
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
        _h2('StarsIcon', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { 185, -40 }, { 1, 1 }, Gui.AMBER, false),
        _h2('AffIcon', 'uiTexture', 'ui_dialogicon_meh', 'UI/Emoticons', { 290, -52 }, { 1, 1 }, Gui.AMBER, false),
    },
}
