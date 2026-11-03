local LH=require('UI.LH')
local hl,tex=LH.hl,LH.tex
local Gui = require('UI.Gui')
local nButtonWidth,nButtonHeight = 31, 31
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
    },
    tElements =
    {
        {
            key = 'CancelButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.RED,
			hidden = true,
            onHoverOn =
            {
				{ key = 'CancelButtonTexture', hidden = true, },
				{ key = 'CancelButtonTexturePressed', hidden = false, },
                hl(),
            },
            onHoverOff =
            {
				{ key = 'CancelButtonTexture', hidden = false, },
				{ key = 'CancelButtonTexturePressed', hidden = true, },
            },
			onDisabledOn =
            {
				{ key = 'CancelButtonTexture', color = Gui.AMBER_OPAQUE },
            },
			onDisabledOff =
            {
				{ key = 'CancelButtonTexture', color = Gui.AMBER },
            },
        },
 		tex('CancelButtonTexture','checkbox_xed','UI/Shared',{ 0, 0 },Gui.AMBER,{ 1, 1 }),
		tex('CancelButtonTexturePressed','checkbox_xed_inverse','UI/Shared',{ 0, 0 },Gui.AMBER,{ 1, 1 },true),
    },
}
