local LH=require('UI.LH')
local lc,tex=LH.lc,LH.tex
local Gui = require('UI.Gui')
local nControlButtonX, nControlButtonY = 0,0
local nControlButtonWidth, nControlButtonHeight = 205, 37
local labelX, labelY = 0, nControlButtonY - 5
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
            key = 'ActionButton',
            type = 'onePixelButton',
            pos = { nControlButtonX, nControlButtonY },
            scale = { nControlButtonWidth, nControlButtonHeight },
            color = Gui.RED,
			hidden = true,
            onHoverOn =
            {
                { key = 'ActionLabel', color = Gui.BLACK, },
				{ key = 'ActionButtonTexture', hidden = true, },
				{ key = 'ActionButtonTexturePressed', hidden = false, },
            },
            onHoverOff =
            {
                { key = 'ActionLabel', color = Gui.AMBER, },
				{ key = 'ActionButtonTexture', hidden = false, },
				{ key = 'ActionButtonTexturePressed', hidden = true, },
            },
			onSelectedOn =
			{
				{ key = 'ActionLabel', color = Gui.BLACK, },
				{ key = 'ActionButtonTexture', hidden = true, },
				{ key = 'ActionButtonTexturePressed', hidden = false, },
			},
            onSelectedOff =
            {
                { key = 'ActionLabel', color = Gui.AMBER, },
				{ key = 'ActionButtonTexture', hidden = false, },
				{ key = 'ActionButtonTexturePressed', hidden = true, },
            },
			onDisabledOn =
            {
                { key = 'ActionLabel', color = Gui.AMBER_OPAQUE, },
				{ key = 'ActionButtonTexture', color = Gui.AMBER_OPAQUE },
            },
			onDisabledOff =
            {
                { key = 'ActionLabel', color = Gui.AMBER, },
				{ key = 'ActionButtonTexture', color = Gui.AMBER },
            },
        },
 		tex('ActionButtonTexture','buttonbig','UI/Shared',{ nControlButtonX, nControlButtonY },Gui.AMBER,{ 1, 1 }),
		tex('ActionButtonTexturePressed','buttonbig_pressed','UI/Shared',{ nControlButtonX, nControlButtonY },Gui.AMBER,{ 1, 1 },true),
        lc('ActionLabel',{ nControlButtonX + labelX, labelY },'ZONEUI072TEXT','dosissemibold20',{ 0, 100, nControlButtonWidth, 0 },Gui.AMBER,'C'),
    },
}
