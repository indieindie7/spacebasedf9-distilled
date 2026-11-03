local function _h1(a0,a1) return {key=a0,hidden=a1} end
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
        {
            key = 'OnButton',
            type = 'onePixelButton',
            pos = { buttonX, buttonY },
            scale = { buttonWidth, buttonHeight },
            color = { 0, 0, 0, 0 },
            onHoverOn =
            {
                {
                    key = 'OnLabel',
                    color = Gui.BLACK,
                },
				_h1('OnButtonTexture', true),
				_h1('OnButtonTexturePressed', false),
            },
            onHoverOff =
            {
                {
                    key = 'OnLabel',
                    color = Gui.AMBER,
                },
				_h1('OnButtonTexture', false),
				_h1('OnButtonTexturePressed', true),
            },
        },
		{
			key = 'OnButtonTexture',
			type = 'uiTexture',
            textureName = 'buttontoggle2_left',
            sSpritesheetPath = 'UI/Shared',
			pos = { buttonX, buttonY },
			scale = { 1, 1 },
			color = Gui.AMBER,
		},
		{
			key = 'OnButtonTexturePressed',
			type = 'uiTexture',
            textureName = 'buttontoggle2_left_pressed',
            sSpritesheetPath = 'UI/Shared',
			pos = { buttonX, buttonY },
			scale = { 1, 1 },
			color = Gui.AMBER,
			hidden = true,
		},
        {
            key = 'OnLabel',
            type = 'textBox',
            pos = { buttonX + 40, labelY },
			linecode = 'PROPSX042TEXT',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.CENTER_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'OffButton',
            type = 'onePixelButton',
            pos = { buttonX + buttonWidth + buttonSpacing, buttonY },
            scale = { buttonWidth, buttonHeight },
            color = { 0, 0, 0, 0 },
            onHoverOn =
            {
                {
                    key = 'OffLabel',
                    color = Gui.BLACK,
                },
				_h1('OffButtonTexture', true),
				_h1('OffButtonTexturePressed', false),
            },
            onHoverOff =
            {
                {
                    key = 'OffLabel',
                    color = Gui.AMBER,
                },
				_h1('OffButtonTexture', false),
				_h1('OffButtonTexturePressed', true),
            },
        },
 		{
			key = 'OffButtonTexture',
			type = 'uiTexture',
            textureName = 'buttontoggle2_right',
            sSpritesheetPath = 'UI/Shared',
			pos = { buttonX + buttonWidth + buttonSpacing, buttonY },
			scale = { 1, 1 },
			color = Gui.AMBER,
		},
		{
			key = 'OffButtonTexturePressed',
			type = 'uiTexture',
            textureName = 'buttontoggle2_right_pressed',
            sSpritesheetPath = 'UI/Shared',
			pos = { buttonX + buttonWidth + buttonSpacing, buttonY },
			scale = { 1, 1 },
			color = Gui.AMBER,
			hidden = true,
		},
       {
            key = 'OffLabel',
            type = 'textBox',
            pos = { buttonX + buttonWidth + buttonSpacing + 50, labelY },
			linecode = 'PROPSX043TEXT',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.CENTER_JUSTIFY,
            color = Gui.AMBER,
        },
    },
}
