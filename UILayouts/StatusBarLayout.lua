local function _h1(a0,a1) return {key=a0,pos=a1} end
local function _h2(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,scale=a5,color=a6} end
local function _h3(a0,a1) return {key=a0,hidden=a1} end
local function _h4(a0,a1,a2,a3,a4,a5,a6,a7) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,scale=a5,color=a6,hidden=a7} end
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
local nFlipButtonW = 193
local nFlipButtonH = 206
local nAlertExpandedOffsetX = -480
return
{
    posInfo =
        {
        alignX = 'right',
        alignY = 'top',
        offsetX = -1150,
        offsetY = 36,
        scale = { 1, 1 },
    },
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
        _h2('MatterIcon', 'uiTexture', 'ui_hud_iconMatter', 'UI/HUD', { 620, -70 }, { 1.4, 1.4 }, Gui.AMBER),
        {
            key = 'MatterLabel',
            type = 'textBox',
            pos = { 730, -52 },
            linecode = 'HUDHUD002TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.GREY,
        },
        {
            key = 'MatterText',
            type = 'textBox',
            pos = { 730, -70 },
            text = '1',
            style = 'dosisregular70',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h2('CapacityIcon', 'uiTexture', 'ui_hud_iconPeople', 'UI/HUD', { 900, -70 }, { 1.4, 1.4 }, Gui.AMBER),
        {
            key = 'CapacityLabel',
            type = 'textBox',
            pos = { 960, -50 },
            linecode = 'HUDHUD003TEXT',
            style = 'dosissemibold26',
            rect = { 0, 200, 600, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.GREY,
        },
        {
            key = 'CapacityText',
            type = 'textBox',
            pos = { 960, -74 },
            text = '2',
            style = 'dosisregular70',
            rect = { 0, 300, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'DividerLine',
            type = 'onePixel',
            pos = { 620, -192 },
            scale = { 490, 4 },
            color = Gui.AMBER,
        },
        {
            key = 'StardateText',
            type = 'textBox',
            pos = { 620, -214 },
            text = '2',
            style = 'dosissemibold30',
            rect = { 0, 100, 300, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
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
                _h3('PauseInactiveTexture', true),
                _h3('PauseActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('PauseInactiveTexture', false),
                _h3('PauseActiveTexture', true),
            },
        },
        _h2('PauseInactiveTexture', 'uiTexture', 'ui_hud_speed0', 'UI/HUD', { 900, -214 }, {1.4, 1.4}, Gui.AMBER),
        _h4('PauseActiveTexture', 'uiTexture', 'ui_hud_speed0_active', 'UI/HUD', { 900, -214 }, {1.4, 1.4}, Gui.AMBER, true),
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
                _h3('Speed1InactiveTexture', true),
                _h3('Speed1ActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('Speed1InactiveTexture', false),
                _h3('Speed1ActiveTexture', true),
            },
        },
        _h2('Speed1InactiveTexture', 'uiTexture', 'ui_hud_speed1', 'UI/HUD', { 956, -214 }, {1.4, 1.4}, Gui.AMBER),
        _h4('Speed1ActiveTexture', 'uiTexture', 'ui_hud_speed1_active', 'UI/HUD', { 956, -214 }, {1.4, 1.4}, Gui.AMBER, true),
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
                _h3('Speed2InactiveTexture', true),
                _h3('Speed2ActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('Speed2InactiveTexture', false),
                _h3('Speed2ActiveTexture', true),
            },
        },
        _h2('Speed2InactiveTexture', 'uiTexture', 'ui_hud_speed2', 'UI/HUD', { 1012, -214 }, {1.4, 1.4}, Gui.AMBER),
        _h4('Speed2ActiveTexture', 'uiTexture', 'ui_hud_speed2_active', 'UI/HUD', { 1012, -214 }, {1.4, 1.4}, Gui.AMBER, true),
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
                _h3('Speed3InactiveTexture', true),
                _h3('Speed3ActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('Speed3InactiveTexture', false),
                _h3('Speed3ActiveTexture', true),
            },
        },
        _h2('Speed3InactiveTexture', 'uiTexture', 'ui_hud_speed3', 'UI/HUD', { 1068, -214 }, {1.4, 1.4}, Gui.AMBER),
        _h4('Speed3ActiveTexture', 'uiTexture', 'ui_hud_speed3_active', 'UI/HUD', { 1068, -214 }, {1.4, 1.4}, Gui.AMBER, true),
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
                _h3('ZoomoutTexture', true),
                _h3('ZoomoutActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('ZoomoutTexture', false),
                _h3('ZoomoutActiveTexture', true),
            },
        },
        _h2('ZoomoutTexture', 'uiTexture', 'ui_hud_button_zoomout', 'UI/HUD', { nZoomoutButtonX, sBottomIconY }, {1, 1}, Gui.AMBER),
        _h4('ZoomoutActiveTexture', 'uiTexture', 'ui_hud_button_zoomout_active', 'UI/HUD', { nZoomoutButtonX, sBottomIconY }, {1, 1}, Gui.AMBER, true),
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
                _h3('ZoominTexture', true),
                _h3('ZoominActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('ZoominTexture', false),
                _h3('ZoominActiveTexture', true),
            },
        },
        _h2('ZoominTexture', 'uiTexture', 'ui_hud_button_zoomin', 'UI/HUD', { nZoominButtonX, sBottomIconY }, {1, 1}, Gui.AMBER),
        _h4('ZoominActiveTexture', 'uiTexture', 'ui_hud_button_zoomin_active', 'UI/HUD', { nZoominButtonX, sBottomIconY }, {1, 1}, Gui.AMBER, true),
        {
            key = 'BottomButtonDividerLine',
            type = 'onePixel',
            pos = { nZoomoutButtonX - 76, '-g_GuiManager.getUIViewportSizeY() + 40'  },
            scale = { 4, 54 },
            color = Gui.AMBER,
        },
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
                _h3('WallTexture', true),
                _h3('WallActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('WallTexture', false),
                _h3('WallActiveTexture', true),
            },
        },
        _h2('WallTexture', 'uiTexture', 'ui_hud_buttonvis_walls', 'UI/HUD', { nWallButtonX, sBottomIconY }, {1, 1}, Gui.AMBER),
        _h4('WallActiveTexture', 'uiTexture', 'ui_hud_buttonvis_walls_active', 'UI/HUD', { nWallButtonX, sBottomIconY }, {1, 1}, Gui.AMBER, true),
        {
            key = 'WallHotkey',
            type = 'textBox',
            pos = { nWallButtonX + 50, sBottomIconY..' - 30' },
            text = 'K',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
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
                _h3('OxygenTexture', true),
                _h3('OxygenActiveTexture', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('OxygenTexture', false),
                _h3('OxygenActiveTexture', true),
            },
        },
        _h2('OxygenTexture', 'uiTexture', 'ui_hud_buttonvis_o2', 'UI/HUD', { nOxygenButtonX, sBottomIconY }, {1, 1}, Gui.AMBER),
        _h4('OxygenActiveTexture', 'uiTexture', 'ui_hud_buttonvis_o2_active', 'UI/HUD', { nOxygenButtonX, sBottomIconY }, {1, 1}, Gui.AMBER, true),
        {
            key = 'OxygenHotkey',
            type = 'textBox',
            pos = { nOxygenButtonX + 50, sBottomIconY..' - 30' },
            text = 'O',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
    },
}
