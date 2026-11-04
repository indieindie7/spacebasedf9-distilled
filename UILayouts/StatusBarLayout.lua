local LH=require('UI.LH')
local hh,lc,px,tex,tx,v=LH.hh,LH.lc,LH.px,LH.tex,LH.tx,LH.v
local iconBtn,flat=LH.iconBtn,LH.flat
local function _h1(a0,a1) return {key=a0,pos=a1} end
local Gui = require('UI.Gui')
local sBottomIconY = '-g_GuiManager.getUIViewportSizeY() + 40'
local nZoomoutButtonX = 1072
local nZoominButtonX = 1012
local nWallButtonX = 912
local nOxygenButtonX = 842
local sFlipBorderX = '0'
local sFlipBorderTopY = '-(g_GuiManager.getUIViewportSizeY() - 184)'
local sFlipBorderBottomY = sFlipBorderTopY .. ' - 206'
local sFlipLabelX = sFlipBorderX .. ' + 4'
local sFlipHotkeyX = sFlipBorderX .. ' + 176'
local sFlipTextY = sFlipBorderTopY .. ' + 41'
local sFlipArrowsX = sFlipBorderX .. ' + 76'
local sFlipArrowsY = sFlipBorderTopY .. ' - 124'
local sFlipButtonX = sFlipBorderX .. ' + 1'
local sFlipButtonY = sFlipBorderTopY .. ' - 1'
local nAlertExpandedOffsetX = -480
return
{
    posInfo = LH.pos('right', 'top', -1150, 36, {1,1}),
    tExtraInfo =
    {
        alertsExpandedOverride =
        {
            _h1('ZoomoutButton', { nZoomoutButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('ZoomoutTexture', { nZoomoutButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('ZoomoutActiveTexture', { nZoomoutButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('ZoominButton', { nZoominButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('ZoominTexture', { nZoominButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('ZoominActiveTexture', { nZoominButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('ZoominActiveTexture', { nZoominButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('BottomButtonDividerLine', { nZoomoutButtonX - 76 + nAlertExpandedOffsetX, '-g_GuiManager.getUIViewportSizeY() + 40'  }),
            _h1('WallButton', { nWallButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('WallTexture', { nWallButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('WallActiveTexture', { nWallButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('WallHotkey', { nWallButtonX + 50 + nAlertExpandedOffsetX, sBottomIconY..' - 30' }),
            _h1('OxygenButton', { nOxygenButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('OxygenTexture', { nOxygenButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('OxygenActiveTexture', { nOxygenButtonX + nAlertExpandedOffsetX, sBottomIconY }),
            _h1('OxygenHotkey', { nOxygenButtonX + 50 + nAlertExpandedOffsetX, sBottomIconY..' - 30' }),
        },
        alertsCollapsedOverride =
        {
            _h1('ZoomoutButton', { nZoomoutButtonX, sBottomIconY }),
            _h1('ZoomoutTexture', { nZoomoutButtonX, sBottomIconY }),
            _h1('ZoomoutActiveTexture', { nZoomoutButtonX, sBottomIconY }),
            _h1('ZoominButton', { nZoominButtonX, sBottomIconY }),
            _h1('ZoominTexture', { nZoominButtonX, sBottomIconY }),
            _h1('ZoominActiveTexture', { nZoominButtonX, sBottomIconY }),
            _h1('ZoominActiveTexture', { nZoominButtonX, sBottomIconY }),
            _h1('BottomButtonDividerLine', { nZoomoutButtonX - 76, '-g_GuiManager.getUIViewportSizeY() + 40'  }),
            _h1('WallButton', { nWallButtonX, sBottomIconY }),
            _h1('WallTexture', { nWallButtonX, sBottomIconY }),
            _h1('WallActiveTexture', { nWallButtonX, sBottomIconY }),
            _h1('WallHotkey', { nWallButtonX + 50, sBottomIconY..' - 30' }),
            _h1('OxygenButton', { nOxygenButtonX, sBottomIconY }),
            _h1('OxygenTexture', { nOxygenButtonX, sBottomIconY }),
            _h1('OxygenActiveTexture', { nOxygenButtonX, sBottomIconY }),
            _h1('OxygenHotkey', { nOxygenButtonX + 50, sBottomIconY..' - 30' }),
        },
    },
    tElements = flat
    {
        tex('MatterIcon','ui_hud_iconMatter','UI/HUD',{ 620, -70 },Gui.AMBER,{ 1.4, 1.4 }),
        lc('MatterLabel',{ 730, -52 },'HUDHUD002TEXT','dosissemibold26',{ 0, 100, 100, 0 },Gui.GREY),
        tx('MatterText',{ 730, -70 },'1','dosisregular70',{ 0, 300, 200, 0 },Gui.AMBER),
        tex('CapacityIcon','ui_hud_iconPeople','UI/HUD',{ 900, -70 },Gui.AMBER,{ 1.4, 1.4 }),
        lc('CapacityLabel',{ 960, -50 },'HUDHUD003TEXT','dosissemibold26',{ 0, 200, 600, 0 },Gui.GREY),
        tx('CapacityText',{ 960, -74 },'2','dosisregular70',{ 0, 300, 400, 0 },Gui.AMBER),
        px('DividerLine',{ 620, -192 },{ 490, 4 },Gui.AMBER),
        tx('StardateText',{ 620, -214 },'2','dosissemibold30',{ 0, 100, 300, 0 },Gui.AMBER),
        iconBtn('PauseButton','PauseInactiveTexture','PauseActiveTexture','ui_hud_speed0','ui_hud_speed0_active',{ 900, -214 },{ 40, 40 },Gui.AMBER,{1.4, 1.4}),
        iconBtn('Speed1Button','Speed1InactiveTexture','Speed1ActiveTexture','ui_hud_speed1','ui_hud_speed1_active',{ 956, -214 },{ 40, 40 },Gui.AMBER,{1.4, 1.4}),
        iconBtn('Speed2Button','Speed2InactiveTexture','Speed2ActiveTexture','ui_hud_speed2','ui_hud_speed2_active',{ 1012, -214 },{ 40, 40 },Gui.AMBER,{1.4, 1.4}),
        iconBtn('Speed3Button','Speed3InactiveTexture','Speed3ActiveTexture','ui_hud_speed3','ui_hud_speed3_active',{ 1068, -214 },{ 40, 40 },Gui.AMBER,{1.4, 1.4}),
        iconBtn('ZoomoutButton','ZoomoutTexture','ZoomoutActiveTexture','ui_hud_button_zoomout','ui_hud_button_zoomout_active',{ nZoomoutButtonX, sBottomIconY },{ 40, 40 },Gui.AMBER,{1, 1}),
        iconBtn('ZoominButton','ZoominTexture','ZoominActiveTexture','ui_hud_button_zoomin','ui_hud_button_zoomin_active',{ nZoominButtonX, sBottomIconY },{ 40, 40 },Gui.AMBER,{1, 1}),
        px('BottomButtonDividerLine',{ nZoomoutButtonX - 76, '-g_GuiManager.getUIViewportSizeY() + 40'  },{ 4, 54 },Gui.AMBER),
        iconBtn('WallButton','WallTexture','WallActiveTexture','ui_hud_buttonvis_walls','ui_hud_buttonvis_walls_active',{ nWallButtonX, sBottomIconY },{ 40, 40 },Gui.AMBER,{1, 1}),
        tx('WallHotkey',{ nWallButtonX + 50, sBottomIconY..' - 30' },'K','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER),
        iconBtn('OxygenButton','OxygenTexture','OxygenActiveTexture','ui_hud_buttonvis_o2','ui_hud_buttonvis_o2_active',{ nOxygenButtonX, sBottomIconY },{ 40, 40 },Gui.AMBER,{1, 1}),
        tx('OxygenHotkey',{ nOxygenButtonX + 50, sBottomIconY..' - 30' },'O','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER),
    },
}
