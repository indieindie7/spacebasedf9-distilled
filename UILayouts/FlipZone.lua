local LH=require('UI.LH')
local hl,tex,tx=LH.hl,LH.tex,LH.tx
local Gui = require('UI.Gui')
local sFlipBorderX = '0'
local sFlipBorderTopY = 30
local sFlipBorderBottomY = sFlipBorderTopY .. ' - 206'
local sFlipLabelX = sFlipBorderX .. ' + 4'
local sFlipHotkeyX = sFlipBorderX .. ' + 176'
local sFlipTextY = sFlipBorderTopY .. ' + 41'
local sFlipArrowsX = sFlipBorderX .. ' + 76'
local sFlipArrowsY = sFlipBorderTopY .. ' - 124'
local sFlipButtonX = sFlipBorderX .. ' + 1'
local sFlipButtonY = sFlipBorderTopY .. ' - 1'
local nFlipButtonW = 193
local nFlipButtonH = 206
return
{
    posInfo =
        {
    },
    tElements =
    {
       {
            key = 'FlipButton',
            type = 'onePixelButton',
            pos = { sFlipButtonX, sFlipButtonY },
            scale = { nFlipButtonW, nFlipButtonH },
            color = {0.2, 0.2, 0.2, 0.01},
            hidden = true,
            onHoverOn =
            {
                {
                    key = 'FlipButton',
                    hidden = false,
                },
                hl(),
            },
            onHoverOff =
            {
                {
                    key = 'FlipButton',
                    hidden = true,
                },
            },
        },
        tx('FlipLabel',{ sFlipLabelX, sFlipTextY },'Flip Object','dosissemibold26',{ 0, 100, 300, 0 },Gui.AMBER),
        tx('FlipHotkey',{ sFlipHotkeyX, sFlipTextY },'F','dosissemibold26',{ 0, 100, 300, 0 },Gui.AMBER),
        tex('FlipZoneTop','ui_flip_border','UI/HUD',{ sFlipBorderX, sFlipBorderTopY },Gui.AMBER,{1.0, 1.0}),
        tex('FlipZoneBottom','ui_flip_border','UI/HUD',{ sFlipBorderX, sFlipBorderBottomY },Gui.AMBER,{1.0, -1.0}),
        tex('FlipZoneArrows','ui_flip_arrows','UI/HUD',{ sFlipArrowsX, sFlipArrowsY },Gui.AMBER,{1.0, -1.0}),
    },
}
