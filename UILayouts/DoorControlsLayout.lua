local LH=require('UI.LH')
local lc,tex=LH.lc,LH.tex
local Gui = require('UI.Gui')
local buttonWidth, buttonHeight, buttonSpacing = 120, 35, 10
local buttonX, buttonY = 18, -225
local labelY = -191
return
{
    posInfo = LH.pos('left', 'top', 0, -30),
    tElements =
    {
        {
            key = 'NormalButton',
            type = 'onePixelButton',
            pos = { buttonX, buttonY },
            scale = { buttonWidth, buttonHeight },
            color = Gui.BLACK_NO_ALPHA,
			hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'NormalLabel', color = Gui.BLACK, },
                { key = 'NormalButtonTexture', hidden = true, },
                { key = 'NormalButtonTexturePressed', hidden = false, },
            },
            onHoverOff =
            {
                { key = 'NormalLabel', color = Gui.AMBER, },
                { key = 'NormalButtonTexture', hidden = false, },
                { key = 'NormalButtonTexturePressed', hidden = true, },
            },
			onDisabledOn =
            {
				{ key = 'NormalLabel', color = Gui.AMBER_OPAQUE, },
                { key = 'NormalButtonTexture', color = Gui.AMBER_OPAQUE, },
                { key = 'NormalButtonTexturePressed', color = Gui.AMBER_OPAQUE, },
			},
			onDisabledOff =
            {
				{ key = 'NormalLabel', color = Gui.AMBER, },
                { key = 'NormalButtonTexture', color = Gui.AMBER, },
                { key = 'NormalButtonTexturePressed', color = Gui.AMBER, },
			},
        },
		tex('NormalButtonTexture','buttontoggle3_left','UI/Shared',{ buttonX, buttonY },Gui.AMBER,{ 1, 1 }),
		tex('NormalButtonTexturePressed','buttontoggle3_left_pressed','UI/Shared',{ buttonX, buttonY },Gui.AMBER,{ 1, 1 },true),
        lc('NormalLabel',{ 27, labelY },'PROPSX037TEXT','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'C','C'),
        {
            key = 'LockedButton',
            type = 'onePixelButton',
            pos = { buttonX + buttonWidth + buttonSpacing, buttonY },
            scale = { buttonWidth, buttonHeight },
            color = Gui.BLACK_NO_ALPHA,
			hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'LockedLabel', color = Gui.BLACK, },
				{ key = 'LockedButtonTexture', hidden = true, },
				{ key = 'LockedButtonTexturePressed', hidden = false, },
            },
            onHoverOff =
            {
                { key = 'LockedLabel', color = Gui.AMBER, },
				{ key = 'LockedButtonTexture', hidden = false, },
				{ key = 'LockedButtonTexturePressed', hidden = true, },
            },
			onDisabledOn =
            {
				{ key = 'LockedLabel', color = Gui.AMBER_OPAQUE, },
                { key = 'LockedButtonTexture', color = Gui.AMBER_OPAQUE, },
                { key = 'LockedButtonTexturePressed', color = Gui.AMBER_OPAQUE, },
			},
			onDisabledOff =
            {
				{ key = 'LockedLabel', color = Gui.AMBER, },
                { key = 'LockedButtonTexture', color = Gui.AMBER, },
                { key = 'LockedButtonTexturePressed', color = Gui.AMBER, },
			},
        },
		tex('LockedButtonTexture','buttontoggle3_mid','UI/Shared',{ buttonX + buttonWidth, buttonY },Gui.AMBER,{ 1, 1 }),
		tex('LockedButtonTexturePressed','buttontoggle3_mid_pressed','UI/Shared',{ buttonX + buttonWidth, buttonY },Gui.AMBER,{ 1, 1 },true),
        lc('LockedLabel',{ 158, labelY },'PROPSX038TEXT','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'C','C'),
        {
            key = 'ForcedButton',
            type = 'onePixelButton',
            pos = { buttonX + (buttonWidth*2) + (buttonSpacing*2), buttonY },
            scale = { buttonWidth, buttonHeight },
            color = Gui.BLACK_NO_ALPHA,
			hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                { key = 'ForcedLabel', color = Gui.BLACK, },
				{ key = 'ForcedButtonTexture', hidden = true, },
				{ key = 'ForcedButtonTexturePressed', hidden = false, },
            },
            onHoverOff =
            {
                { key = 'ForcedLabel', color = Gui.AMBER, },
				{ key = 'ForcedButtonTexture', hidden = false, },
				{ key = 'ForcedButtonTexturePressed', hidden = true, },
            },
			onDisabledOn =
            {
				{ key = 'ForcedLabel', color = Gui.AMBER_OPAQUE, },
                { key = 'ForcedButtonTexture', color = Gui.AMBER_OPAQUE, },
                { key = 'ForcedButtonTexturePressed', color = Gui.AMBER_OPAQUE, },
			},
			onDisabledOff =
            {
				{ key = 'ForcedLabel', color = Gui.AMBER, },
                { key = 'ForcedButtonTexture', color = Gui.AMBER, },
                { key = 'ForcedButtonTexturePressed', color = Gui.AMBER, },
			},
        },
		tex('ForcedButtonTexture','buttontoggle3_right','UI/Shared',{ buttonX + (buttonWidth*2) + buttonSpacing+4, buttonY },Gui.AMBER,{ 1, 1 }),
		tex('ForcedButtonTexturePressed','buttontoggle3_right_pressed','UI/Shared',{ buttonX + (buttonWidth*2) + buttonSpacing+4, buttonY },Gui.AMBER,{ 1, 1 },true),
        lc('ForcedLabel',{ 290, labelY },'PROPSX039TEXT','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'C','C'),
    },
}
