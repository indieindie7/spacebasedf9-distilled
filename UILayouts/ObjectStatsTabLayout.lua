local function _h1(a0,a1,a2,a3,a4,a5) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,color=a5} end
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
local nStatLabelMargin, nStatTextMargin  = 35, 210
local nStatsStartY = 0
local nLineSize = 40
local nInspectorWidth = 418
return
{
    posInfo =
        {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = -6,
    },
    tExtraInfo =
    {
        tCallbacks =
        {
            onSelected = {},
            onDeselected = {},
        },
		nLineSize = nLineSize,
    },
    tElements =
    {
        {
            key = 'BuilderButton',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'BuilderButton', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'BuilderButton', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        {
            key = 'MaintainerButton',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 4 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'MaintainerButton', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'MaintainerButton', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        _h1('PowerIcon', 'uiTexture', 'ui_icon_bulletpoint', 'UI/Inspector', { nStatLabelMargin - 30, nStatsStartY - 4 }, Gui.AMBER),
        {
            key = 'PowerLabel',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY },
            linecode = "INSPEC164TEXT",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'PowerText',
            type = 'textBox',
            pos = { nStatLabelMargin + 155, nStatsStartY - 2 },
            text = "0",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('BuildTimeIcon', 'uiTexture', 'ui_icon_bulletpoint', 'UI/Inspector', { nStatLabelMargin - 30, nStatsStartY - nLineSize - 4 }, Gui.AMBER),
        {
            key = 'BuildTimeLabel',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY - nLineSize },
            linecode = "INSPEC110TEXT",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BuildTimeText',
            type = 'textBox',
            pos = { nStatLabelMargin + 120, nStatsStartY - nLineSize - 2 },
            text = "1",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('BuilderIcon', 'uiTexture', 'ui_icon_friend', 'UI/Inspector', { nStatLabelMargin - 30, nStatsStartY - (nLineSize * 2) - 2 }, Gui.AMBER),
        {
            key = 'BuilderLabel',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY - (nLineSize * 2) },
            linecode = "INSPEC111TEXT",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BuilderText',
            type = 'textBox',
            pos = { nStatLabelMargin + 95, nStatsStartY - (nLineSize * 2) - 2 },
            text = "1",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('MaintainTimeIcon', 'uiTexture', 'ui_icon_bulletpoint', 'UI/Inspector', { nStatLabelMargin - 30, nStatsStartY - (nLineSize * 3) - 4 }, Gui.AMBER),
        {
            key = 'MaintainTimeLabel',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY  - (nLineSize * 3) - 2},
            linecode = "INSPEC112TEXT",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'MaintainTimeText',
            type = 'textBox',
            pos = { nStatLabelMargin + 230, nStatsStartY - (nLineSize * 3) - 2 },
            text = "1",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('MaintainerIcon', 'uiTexture', 'ui_icon_friend', 'UI/Inspector', { nStatLabelMargin - 30, nStatsStartY - (nLineSize * 4) - 2 }, Gui.AMBER),
        {
            key = 'MaintainerLabel',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY  - (nLineSize * 4) },
            linecode = "INSPEC113TEXT",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'MaintainerText',
            type = 'textBox',
            pos = { nStatLabelMargin + 210, nStatsStartY - (nLineSize * 4) - 2 },
            text = "1",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('ContentsIcon', 'uiTexture', 'ui_icon_bulletpoint', 'UI/Inspector', { nStatLabelMargin - 30, nStatsStartY - nLineSize * 5 - 6 }, Gui.AMBER),
        {
            key = 'ContentsLabel',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY - nLineSize * 5 },
            linecode = "INSPEC114TEXT",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ContentsText1',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY - (nLineSize * 6) - 2 },
            text = "1",
            style = 'dosissemibold24',
            rect = { 0, 300, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ContentsButton1',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 6 - 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'ContentsButton1', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'ContentsButton1', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        {
            key = 'ContentsText2',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY - (nLineSize * 7) - 2 },
            text = "1",
            style = 'dosissemibold24',
            rect = { 0, 300, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ContentsButton2',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 6 - 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'ContentsButton2', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'ContentsButton2', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        {
            key = 'ContentsText3',
            type = 'textBox',
            pos = { nStatLabelMargin, nStatsStartY - (nLineSize * 8) - 2 },
            text = "1",
            style = 'dosissemibold24',
            rect = { 0, 300, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ContentsButton3',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 6 - 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'ContentsButton3', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'ContentsButton3', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
    },
}
