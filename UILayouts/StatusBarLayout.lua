local LH=require('UI.LH')
local hh,lc,px,tex,tx,v=LH.hh,LH.lc,LH.px,LH.tex,LH.tx,LH.v
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
    tElements =
    {
        tex('MatterIcon','ui_hud_iconMatter','UI/HUD',{ 620, -70 },Gui.AMBER,{ 1.4, 1.4 }),
        lc('MatterLabel',{ 730, -52 },'HUDHUD002TEXT','dosissemibold26',{ 0, 100, 100, 0 },Gui.GREY),
        tx('MatterText',{ 730, -70 },'1','dosisregular70',{ 0, 300, 200, 0 },Gui.AMBER),
        tex('CapacityIcon','ui_hud_iconPeople','UI/HUD',{ 900, -70 },Gui.AMBER,{ 1.4, 1.4 }),
        lc('CapacityLabel',{ 960, -50 },'HUDHUD003TEXT','dosissemibold26',{ 0, 200, 600, 0 },Gui.GREY),
        tx('CapacityText',{ 960, -74 },'2','dosisregular70',{ 0, 300, 400, 0 },Gui.AMBER),
        px('DividerLine',{ 620, -192 },{ 490, 4 },Gui.AMBER),
        tx('StardateText',{ 620, -214 },'2','dosissemibold30',{ 0, 100, 300, 0 },Gui.AMBER),
        {
            key = 'PauseButton',
            type = 'onePixelButton',
            pos = { 900, -214 },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('PauseInactiveTexture',true),
                v('PauseActiveTexture',false),
            },
            onHoverOff =
            hh(false,'PauseInactiveTexture',true,'PauseActiveTexture'),
        },
        tex('PauseInactiveTexture','ui_hud_speed0','UI/HUD',{ 900, -214 },Gui.AMBER,{1.4, 1.4}),
        tex('PauseActiveTexture','ui_hud_speed0_active','UI/HUD',{ 900, -214 },Gui.AMBER,{1.4, 1.4},true),
        {
            key = 'Speed1Button',
            type = 'onePixelButton',
            pos = { 956, -214 },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('Speed1InactiveTexture',true),
                v('Speed1ActiveTexture',false),
            },
            onHoverOff =
            hh(false,'Speed1InactiveTexture',true,'Speed1ActiveTexture'),
        },
        tex('Speed1InactiveTexture','ui_hud_speed1','UI/HUD',{ 956, -214 },Gui.AMBER,{1.4, 1.4}),
        tex('Speed1ActiveTexture','ui_hud_speed1_active','UI/HUD',{ 956, -214 },Gui.AMBER,{1.4, 1.4},true),
        {
            key = 'Speed2Button',
            type = 'onePixelButton',
            pos = { 1012, -214 },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('Speed2InactiveTexture',true),
                v('Speed2ActiveTexture',false),
            },
            onHoverOff =
            hh(false,'Speed2InactiveTexture',true,'Speed2ActiveTexture'),
        },
        tex('Speed2InactiveTexture','ui_hud_speed2','UI/HUD',{ 1012, -214 },Gui.AMBER,{1.4, 1.4}),
        tex('Speed2ActiveTexture','ui_hud_speed2_active','UI/HUD',{ 1012, -214 },Gui.AMBER,{1.4, 1.4},true),
        {
            key = 'Speed3Button',
            type = 'onePixelButton',
            pos = { 1068, -214 },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('Speed3InactiveTexture',true),
                v('Speed3ActiveTexture',false),
            },
            onHoverOff =
            hh(false,'Speed3InactiveTexture',true,'Speed3ActiveTexture'),
        },
        tex('Speed3InactiveTexture','ui_hud_speed3','UI/HUD',{ 1068, -214 },Gui.AMBER,{1.4, 1.4}),
        tex('Speed3ActiveTexture','ui_hud_speed3_active','UI/HUD',{ 1068, -214 },Gui.AMBER,{1.4, 1.4},true),
        {
            key = 'ZoomoutButton',
            type = 'onePixelButton',
            pos = { nZoomoutButtonX, sBottomIconY },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('ZoomoutTexture',true),
                v('ZoomoutActiveTexture',false),
            },
            onHoverOff =
            hh(false,'ZoomoutTexture',true,'ZoomoutActiveTexture'),
        },
        tex('ZoomoutTexture','ui_hud_button_zoomout','UI/HUD',{ nZoomoutButtonX, sBottomIconY },Gui.AMBER,{1, 1}),
        tex('ZoomoutActiveTexture','ui_hud_button_zoomout_active','UI/HUD',{ nZoomoutButtonX, sBottomIconY },Gui.AMBER,{1, 1},true),
       {
            key = 'ZoominButton',
            type = 'onePixelButton',
            pos = { nZoominButtonX, sBottomIconY },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('ZoominTexture',true),
                v('ZoominActiveTexture',false),
            },
            onHoverOff =
            hh(false,'ZoominTexture',true,'ZoominActiveTexture'),
        },
        tex('ZoominTexture','ui_hud_button_zoomin','UI/HUD',{ nZoominButtonX, sBottomIconY },Gui.AMBER,{1, 1}),
        tex('ZoominActiveTexture','ui_hud_button_zoomin_active','UI/HUD',{ nZoominButtonX, sBottomIconY },Gui.AMBER,{1, 1},true),
        px('BottomButtonDividerLine',{ nZoomoutButtonX - 76, '-g_GuiManager.getUIViewportSizeY() + 40'  },{ 4, 54 },Gui.AMBER),
       {
            key = 'WallButton',
            type = 'onePixelButton',
            pos = { nWallButtonX, sBottomIconY },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('WallTexture',true),
                v('WallActiveTexture',false),
            },
            onHoverOff =
            hh(false,'WallTexture',true,'WallActiveTexture'),
        },
        tex('WallTexture','ui_hud_buttonvis_walls','UI/HUD',{ nWallButtonX, sBottomIconY },Gui.AMBER,{1, 1}),
        tex('WallActiveTexture','ui_hud_buttonvis_walls_active','UI/HUD',{ nWallButtonX, sBottomIconY },Gui.AMBER,{1, 1},true),
        tx('WallHotkey',{ nWallButtonX + 50, sBottomIconY..' - 30' },'K','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER),
       {
            key = 'OxygenButton',
            type = 'onePixelButton',
            pos = { nOxygenButtonX, sBottomIconY },
            scale = { 40, 40 },
            color = {1, 0, 0},
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                v('OxygenTexture',true),
                v('OxygenActiveTexture',false),
            },
            onHoverOff =
            hh(false,'OxygenTexture',true,'OxygenActiveTexture'),
        },
        tex('OxygenTexture','ui_hud_buttonvis_o2','UI/HUD',{ nOxygenButtonX, sBottomIconY },Gui.AMBER,{1, 1}),
        tex('OxygenActiveTexture','ui_hud_buttonvis_o2_active','UI/HUD',{ nOxygenButtonX, sBottomIconY },Gui.AMBER,{1, 1},true),
        tx('OxygenHotkey',{ nOxygenButtonX + 50, sBottomIconY..' - 30' },'O','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER),
    },
}
