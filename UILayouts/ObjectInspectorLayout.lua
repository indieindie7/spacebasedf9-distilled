local function _h1(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
local nTabWidth, nTabHeight = 83, 47
local nTabLineHeight = 3
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
		nTabWidth = nTabWidth,
		nTabHeight = nTabHeight,
		nTabLineHeight = nTabLineHeight,
	},
    tElements =
    {
        _h1('EmergencyStatusBG', 'onePixel', { 140, -133 }, { 278, 30 }, { 1, 0, 0 }),
        {
            key = 'EmergencyStatusText',
            type = 'textBox',
            pos = { 140, -131 },
            text = "Sabotaged! (00:30)",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 1, 1, 1 },
        },
        _h1('PictureLargeBG', 'onePixel', { 0, -163 }, { nButtonWidth, 106 }, Gui.AMBER),
        _h1('NameEditBG', 'onePixelButton', { 0, -176 }, { nButtonWidth, 35 }, Gui.AMBER),
        _h1('PictureBG', 'onePixel', { 30, -144 }, { 110, 20 }, Gui.AMBER),
        _h1('ConditionBG', 'onePixel', { 140, -218 }, { 273, 30 }, { 0, 0, 0 }),
        {
            key = 'Picture',
            type = 'uiTexture',
            textureName = 'portrait_generic',
            sSpritesheetPath = 'UI/Portraits',
            pos = { 33, -145 },
            scale = { 0.84, 0.84 },
        },
        {
            key = 'PictureTint',
            type = 'uiTexture',
            textureName = 'portrait_generic',
            sSpritesheetPath = 'UI/Portraits',
            pos = { 33, -145 },
            scale = { 0.84, 0.84 },
        },
        {
            key = 'NameLabel',
            type = 'textBox',
            pos = { 145, -174 },
            text = "Fusion Reactor",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
        },
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
        {
            key = 'NameEditTexture',
            type = 'uiTexture',
            textureName = 'ui_inspector_buttonEdit',
            sSpritesheetPath = 'UI/Inspector',
            pos = { 380, -176 },
            color = Gui.AMBER,
			hidden = true,
        },
        {
            key = 'ConditionLabel',
            type = 'textBox',
            pos = { 145, -216 },
            linecode = "INSPEC054TEXT",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
        },
        {
            key = 'ConditionText',
            type = 'textBox',
            pos = { 245, -216 },
            text = "Good",
            style = 'dosissemibold24',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
        },
        _h1('StatsBG', 'onePixel', { 0, -268 }, { nButtonWidth, 152 }, Gui.AMBER_OPAQUE),
        {
            key = 'DescriptionText',
            type = 'textBox',
            pos = { 20, -280 },
            text = "",
            style = 'dosissemibold26',
            rect = { 0, 300, 380, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
		{
            key = 'DoorStatusLabel',
            type = 'textBox',
            pos = { 16, -354 },
			linecode = "PROPSX055TEXT",
            style = 'dosisregular26',
            rect = { 0, 300, 380, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
		{
            key = 'DoorStatusText',
            type = 'textBox',
            pos = { 150, -354 },
            text = "ERROR",
            style = 'dosissemibold26',
            rect = { 0, 300, 380, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('TabBGSpacer', 'onePixel', { nTabWidth * 1, -420 }, { nTabWidth*4 + 3, nTabHeight }, Gui.AMBER_OPAQUE),
        _h1('TabLineSpacer', 'onePixel', { nTabWidth * 1, -420-nTabHeight }, { nTabWidth*4 + 3, nTabLineHeight }, Gui.AMBER),
        {
            key = 'TabbedPane',
            type = 'tabbedPane',
            pos = { 0, -428 },
            rect = { 0, 0, nButtonWidth-20, 655 },
        },
   },
}
