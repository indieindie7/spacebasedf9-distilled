local function _h1(a0,a1) return {key=a0,hidden=a1} end
local function _h2(a0,a1) return {key=a0,color=a1} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CANCEL = Gui.RED
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 430, 81
local nButtonStartY = 278
local nIconX, nIconStartY = 20, -280
local nLabelX, nLabelStartY =  105, -288
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -330
local nIconScale = .6
local numButtons = 7
local nCancelIconStartY = -82
local nCancelLabelStartY = -90
local nCancelHotkeyY = -130
local nBGWidth = 160
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
        onShowMatterCost =
        {
            _h1('CostBackground', false),
            _h1('CostBackgroundEndCap', false),
            _h1('CostVerticalRule', false),
            _h1('CostIconMatter', false),
            _h1('CostText', false),
        },
        onHideMatterCost =
        {
            _h1('CostBackground', true),
            _h1('CostBackgroundEndCap', true),
            _h1('CostVerticalRule', true),
            _h1('CostIconMatter', true),
            _h1('CostText', true),
        },
    },
    tElements =
    {
        {
            key = 'LargeBar',
            type = 'onePixel',
            pos = { 0, 0 },
            scale = { nButtonWidth, (nButtonStartY + 7*nButtonHeight) },
            color = Gui.SIDEBAR_BG,
        },
        {
            key = 'BackButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h2('BackButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('BackButton', AMBER),
            },
            onHoverOn =
            {
                _h2('BackButton', Gui.AMBER),
                _h2('BackLabel', { 0, 0, 0 }),
                _h2('BackHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('BackButton', Gui.BLACK),
                _h2('BackLabel', Gui.AMBER),
                _h2('BackHotkey', Gui.AMBER),
            },
        },
        {
            key = 'BackLabel',
            type = 'textBox',
            pos = { nLabelX, -10 },
            linecode = 'HUDHUD009TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BackHotkey',
            type = 'textBox',
            pos = { nHotkeyX - 4, -50 },
            text = 'ESC',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'MenuSublabel',
            type = 'textBox',
            pos = { 40, -244 },
            linecode = "HUDHUD026TEXT",
            style = 'dosissemibold22',
            rect = { 0, 100, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.GREY,
        },
        {
            key = 'CancelButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('CancelButton', CONSTRUCT_CANCEL),
                _h2('CancelIcon', { 0, 0, 0 }),
                _h2('CancelLabel', { 0, 0, 0 }),
                _h2('CancelHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('CancelButton', Gui.BLACK),
                _h2('CancelIcon', CONSTRUCT_CANCEL),
                _h2('CancelLabel', CONSTRUCT_CANCEL),
                _h2('CancelHotkey', CONSTRUCT_CANCEL),
            },
        },
        {
            key = 'ConfirmButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight * 2 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h2('ConfirmButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('ConfirmButton', AMBER),
            },
            onHoverOn =
            {
                _h2('ConfirmButton', CONSTRUCT_CONFIRM),
                _h2('ConfirmLabel', { 0, 0, 0 }),
                _h2('ConfirmIcon', { 0, 0, 0 }),
                _h2('ConfirmHotkey', { 0, 0, 0 }),
                _h2('CostBackground', CONSTRUCT_CONFIRM),
                _h2('CostBackgroundEndCap', CONSTRUCT_CONFIRM),
                _h2('CostVerticalRule', { 0, 0, 0 }),
                _h2('CostIconMatter', { 0, 0, 0 }),
                _h2('CostText', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('ConfirmButton', Gui.BLACK),
                _h2('ConfirmLabel', CONSTRUCT_CONFIRM),
                _h2('ConfirmIcon', CONSTRUCT_CONFIRM),
                _h2('ConfirmHotkey', CONSTRUCT_CONFIRM),
                _h2('CostBackground', { 0, 0, 0 }),
                _h2('CostBackgroundEndCap', { 0, 0, 0 }),
                _h2('CostVerticalRule', CONSTRUCT_CONFIRM),
                _h2('CostIconMatter', CONSTRUCT_CONFIRM),
                _h2('CostText', CONSTRUCT_CONFIRM),
            },
        },
        {
            key = 'CancelIcon',
            type = 'uiTexture',
            textureName = 'ui_iconIso_decline',
            sSpritesheetPath = 'UI/Shared',
            pos = { nIconX, nCancelIconStartY },
            color = CONSTRUCT_CANCEL,
            scale = { nIconScale, nIconScale }
        },
        {
            key = 'ConfirmIcon',
            type = 'uiTexture',
            textureName = 'ui_iconIso_confirm',
            sSpritesheetPath = 'UI/Shared',
            pos = { nIconX, nCancelIconStartY - nButtonHeight },
            color = CONSTRUCT_CONFIRM,
            scale = { nIconScale, nIconScale }
        },
        {
            key = 'CancelLabel',
            type = 'textBox',
            pos = { nLabelX, nCancelLabelStartY },
            linecode = 'HUDHUD034TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = CONSTRUCT_CANCEL,
        },
        {
            key = 'ConfirmLabel',
            type = 'textBox',
            pos = { nLabelX, nCancelLabelStartY - nButtonHeight },
            linecode = 'HUDHUD019TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'CancelHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nCancelHotkeyY },
            text = 'X',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = CONSTRUCT_CANCEL,
        },
        {
            key = 'ConfirmHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nCancelHotkeyY - nButtonHeight },
            text = 'C',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = CONSTRUCT_CONFIRM
        },
        {
            key = 'NoFundsLabel',
			hidden = true,
            type = 'textBox',
            pos = { nButtonWidth + 30, -810 },
			linecode = 'BUILDM016TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.RED,
        },
        {
            key = 'CostBackground',
            type = 'onePixel',
            pos = { nButtonWidth, -nButtonHeight * 2 },
            scale = { nBGWidth, nButtonHeight },
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'CostBackgroundEndCap',
            type = 'uiTexture',
            textureName = 'ui_confirm_endcap',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth + nBGWidth - 1, -nButtonHeight * 2 },
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'CostVerticalRule',
            type = 'uiTexture',
            textureName = 'ui_confirm_verticalrule',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth, -(nButtonHeight * 2) - 4 },
            color = { 0, 0, 0 },
        },
        {
            key = 'CostIconMatter',
            type = 'uiTexture',
            textureName = 'ui_confirm_iconmatter',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth + 10, -(nButtonHeight * 2) - 10 },
            color = { 0, 0, 0 },
        },
        {
            key = 'CostText',
            type = 'textBox',
            pos = { nButtonWidth + 34, -(nButtonHeight * 2) - 4 },
            text = "-450 Build\n+75 Demolish\n+36 Undo",
            style = 'dosissemibold18',
            rect = { 0, 100, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
        },
        {
            key = 'SidebarBottomEndcapExpanded',
            type = 'uiTexture',
            textureName = 'ui_hud_anglebottom',
            sSpritesheetPath = 'UI/HUD',
            pos = { 0, -(nButtonStartY + 7*nButtonHeight) + 1 },
            scale = { 1.68, 1.68 },
            color = Gui.SIDEBAR_BG,
        },
    }
}
