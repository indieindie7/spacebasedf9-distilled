local function _h1(a0,a1) return {key=a0,hidden=a1} end
local function _h2(a0,a1) return {key=a0,color=a1} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 330, 81
local nTextHeight = nButtonHeight + 20
local nButtonStartY = -123
local nIconX, nIconStartY = 10, -125
local nLabelX, nLabelStartY = 105, -133
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -169
local nIconScale = .6
local numButtons = 2
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
            scale = { nButtonWidth, -nButtonStartY + (nButtonHeight * numButtons) },
            color = Gui.SIDEBAR_BG,
        },
        {
            key = 'DoneButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h2('DoneButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('DoneButton', AMBER),
            },
            onHoverOn =
            {
                _h2('DoneButton', CONSTRUCT_CONFIRM),
                _h2('DoneLabel', { 0, 0, 0 }),
                _h2('DoneHotkey', { 0, 0, 0 }),
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
                _h2('DoneButton', Gui.BLACK),
                _h2('DoneLabel', CONSTRUCT_CONFIRM),
                _h2('DoneHotkey', CONSTRUCT_CONFIRM),
                _h2('CostBackground', { 0, 0, 0 }),
                _h2('CostBackgroundEndCap', { 0, 0, 0 }),
                _h2('CostVerticalRule', CONSTRUCT_CONFIRM),
                _h2('CostIconMatter', CONSTRUCT_CONFIRM),
                _h2('CostText', CONSTRUCT_CONFIRM),
            },
        },
        {
            key = 'MineButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h2('MineButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('MineButton', AMBER),
            },
            onHoverOn =
            {
                _h2('MineButton', Gui.AMBER),
                _h2('MineLabel', { 0, 0, 0 }),
                _h2('MineIcon', { 0, 0, 0 }),
                _h2('MineHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('MineButton', Gui.BLACK),
                _h2('MineLabel', Gui.AMBER),
                _h2('MineIcon', Gui.AMBER),
                _h2('MineHotkey', Gui.AMBER),
            },
        },
        {
            key = 'EraseButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY - nButtonHeight },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h2('EraseButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('EraseButton', AMBER),
            },
            onHoverOn =
            {
                _h2('EraseButton', Gui.AMBER),
                _h2('EraseLabel', { 0, 0, 0 }),
                _h2('EraseIcon', { 0, 0, 0 }),
                _h2('EraseHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('EraseButton', Gui.BLACK),
                _h2('EraseLabel', Gui.AMBER),
                _h2('EraseIcon', Gui.AMBER),
                _h2('EraseHotkey', Gui.AMBER),
            },
        },
        {
            key = 'MineIcon',
            type = 'uiTexture',
            textureName = 'ui_iconIso_mine',
            sSpritesheetPath = 'UI/Shared',
            pos = { nIconX, nIconStartY },
            color = Gui.AMBER,
            scale = { nIconScale, nIconScale }
        },
        {
            key = 'EraseIcon',
            type = 'uiTexture',
            textureName = 'ui_iconIso_erase',
            sSpritesheetPath = 'UI/Shared',
            pos = { nIconX, nIconStartY - nButtonHeight },
            color = Gui.AMBER,
            scale = { nIconScale, nIconScale }
        },
        {
            key = 'MenuSublabel',
            type = 'textBox',
            pos = { 40, -85 },
            linecode = "HUDHUD010TEXT",
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.GREY,
        },
        {
            key = 'DoneLabel',
            type = 'textBox',
            pos = { nLabelX, -10 },
            linecode = 'HUDHUD019TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'MineLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY },
            linecode = 'HUDHUD008TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'EraseLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - nButtonHeight },
            linecode = 'HUDHUD011TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'DoneHotkey',
            type = 'textBox',
            pos = { nHotkeyX, -46 },
            text = 'ESC',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = CONSTRUCT_CONFIRM
        },
        {
            key = 'MineHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY },
            text = 'M',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'EraseHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - nButtonHeight },
            text = 'E',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'SelectionHighlight',
            type = 'onePixel',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = SELECTION_AMBER,
            hidden = true,
        },
        {
            key = 'CostBackground',
            type = 'onePixel',
            pos = { nButtonWidth, 0 },
            scale = { nBGWidth, nButtonHeight },
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'CostBackgroundEndCap',
            type = 'uiTexture',
            textureName = 'ui_confirm_endcap',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth + nBGWidth - 1, 0 },
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'CostVerticalRule',
            type = 'uiTexture',
            textureName = 'ui_confirm_verticalrule',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth, -4 },
            color = { 0, 0, 0 },
        },
        {
            key = 'CostIconMatter',
            type = 'uiTexture',
            textureName = 'ui_confirm_iconmatter',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth + 10, -10 },
            color = { 0, 0, 0 },
        },
        {
            key = 'CostText',
            type = 'textBox',
            pos = { nButtonWidth + 34, -4 },
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
            pos = { 0, nButtonStartY - numButtons*nButtonHeight },
            scale = { 1.28, 1.28 },
            color = Gui.SIDEBAR_BG,
        },
    },
}
