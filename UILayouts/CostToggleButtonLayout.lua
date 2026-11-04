local LH=require('UI.LH')
local lc,tex,tx=LH.lc,LH.tex,LH.tx
local Gui = require('UI.Gui')
local nButtonX, nButtonY = 0, 0
local nButtonWidth, nButtonHeight  = 160, 37
local nCostWidth, nCostHeight = 200, 33
local nCostWidthSelected = 220
local nTextY = 33
return
{
    posInfo = LH.pos('left', 'top', 0, 0),
    tExtraInfo =
    {
    },
    tElements =
    {
        {
            key = 'CostButton',
            type = 'onePixelButton',
            pos = { nButtonX, nButtonY },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.RED,
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'ButtonLabel', color = Gui.BLACK, },
                { key = 'ButtonTexture', hidden = true },
                { key = 'ButtonTexturePressed', hidden = false },
				{ key = 'CostButton', color = Gui.GREEN, },
            },
            onHoverOff =
            {
                { key = 'ButtonLabel', color = Gui.AMBER, },
                { key = 'ButtonTexture', hidden = false },
                { key = 'ButtonTexturePressed', hidden = true },
				{ key = 'CostButton', color = Gui.RED, },
            },
			onSelectedOn =
			{
                { key = 'ButtonLabel', color = Gui.BLACK, },
                { key = 'ButtonTexture', hidden = true },
                { key = 'ButtonTexturePressed', hidden = false },
				{ key = 'CheckBoxTexture', hidden = true, },
				{ key = 'CheckBoxTexturePressed', hidden = false, },
				{ key = 'CostBox', color = Gui.GREEN, scale = { nCostWidthSelected, nCostHeight }, },
				{ key = 'CostBoxEndTexture', color = Gui.GREEN, pos = { nButtonX + nButtonWidth + nCostWidthSelected, nButtonY - 2 }, },
				{ key = 'CostLabel', color = Gui.BLACK, },
				{ key = 'CostIcon', color = Gui.BLACK, },
				{ key = 'CostText', color = Gui.BLACK, },
			},
			onSelectedOff =
			{
                { key = 'ButtonLabel', color = Gui.AMBER, },
                { key = 'ButtonTexture', hidden = false },
                { key = 'ButtonTexturePressed', hidden = true },
				{ key = 'CheckBoxTexture', hidden = false, },
				{ key = 'CheckBoxTexturePressed', hidden = true, },
				{ key = 'CostBox', color = Gui.BLACK, scale = { nCostWidth, nCostHeight }, },
				{ key = 'CostBoxEndTexture', color = Gui.BLACK, pos = { nButtonX + nButtonWidth + nCostWidth, nButtonY - 2 }, },
				{ key = 'CostLabel', color = Gui.AMBER, },
				{ key = 'CostIcon', color = Gui.AMBER, },
				{ key = 'CostText', color = Gui.AMBER, },
			},
			onDisabledOn =
			{
				{ key = 'ButtonLabel', color = Gui.AMBER_OPAQUE, },
                { key = 'ButtonTexture', color = Gui.AMBER_OPAQUE },
				{ key = 'CheckBoxTexture', color = Gui.AMBER_OPAQUE, },
				{ key = 'CostBox', color = Gui.AMBER_OPAQUE, },
				{ key = 'CostBoxEndTexture', color = Gui.AMBER_OPAQUE },
				{ key = 'CostLabel', color = Gui.BLACK, },
				{ key = 'CostIcon', color = Gui.BLACK, },
				{ key = 'CostText', color = Gui.BLACK, },
			},
			onDisabledOff =
			{
				{ key = 'ButtonLabel', color = Gui.AMBER, },
                { key = 'ButtonTexture', color = Gui.AMBER },
				{ key = 'CheckBoxTexture', color = Gui.AMBER, },
				{ key = 'CostBox', color = Gui.BLACK, },
				{ key = 'CostBoxEndTexture', color = Gui.BLACK },
				{ key = 'CostLabel', color = Gui.AMBER, },
				{ key = 'CostIcon', color = Gui.AMBER, },
				{ key = 'CostText', color = Gui.AMBER, },
			},
        },
		tex('ButtonTexture','button_medium','UI/Shared',{ nButtonX, nButtonY },Gui.AMBER,{ 1, 1 }),
		tex('ButtonTexturePressed','button_medium_pressed','UI/Shared',{ nButtonX, nButtonY },Gui.AMBER,{ 1, 1 },true),
		tex('CheckBoxTexture','checkbox_empty','UI/Shared',{ nButtonX + 5, nButtonY - 5 },Gui.AMBER,{ 0.85, 0.85 }),
		tex('CheckBoxTexturePressed','checkbox_checked_inverse','UI/Shared',{ nButtonX + 5, nButtonY - 5 },Gui.AMBER,{ 0.85, 0.85 },true),
        lc('ButtonLabel',{ nButtonX + 19, nButtonY + nTextY },'INSPEC086TEXT','dosissemibold22',{ 0, 100, 150, 0 },Gui.AMBER,'C','C'),
		{
            key = 'CostBox',
            type = 'onePixelButton',
            pos = { nButtonX + nButtonWidth, nButtonY - 2 },
            scale = { nCostWidth, nCostHeight },
            color = Gui.BLACK,
		},
		tex('CostBoxEndTexture','button_cost_flag','UI/Shared',{ nButtonX + nButtonWidth + nCostWidth - 1, nButtonY - 2 },Gui.BLACK,{ 1, 1 }),
        lc('CostLabel',{ nButtonX + nButtonWidth + 4, nButtonY + nTextY },'INSPEC118TEXT','dosissemibold22',{ 0, 100, 175, 0 },Gui.AMBER,'L','C'),
		tex('CostIcon','ui_confirm_iconmatter','UI/Shared',{ nButtonX + nButtonWidth + 112, nButtonY - 10 },Gui.AMBER,{ 1, 1 }),
		tx('CostText',{ nButtonX + nButtonWidth + 102, nButtonY + nTextY },'11400','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'C','C'),
    },
}
