local function _h1(a0,a1) return {key=a0,hidden=a1} end
local function _h2(a0,a1) return {key=a0,color=a1} end
local function _h3(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,color=a5,scale=a6} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CANCEL = Gui.RED
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 330, 81
local nTextHeight = nButtonHeight + 20
local nButtonStartY = -204
local nIconX, nIconStartY = 10, -206
local nCancelIconStartY = -2
local nLabelX, nLabelStartY = 105, -214
local nCancelLabelStartY = -10
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -250
local nCancelHotkeyY = -46
local nIconScale = .6
local numButtons = 7
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
            key = 'CancelButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = CONSTRUCT_CANCEL,
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
            pos = { 0, -nButtonHeight },
            scale = { nButtonWidth, nButtonHeight },
            color = CONSTRUCT_CONFIRM,
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
            key = 'AreaButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h2('AreaButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('AreaButton', AMBER),
            },
            onHoverOn =
            {
                _h2('AreaButton', Gui.AMBER),
                _h2('AreaLabel', { 0, 0, 0 }),
                _h2('AreaIcon', { 0, 0, 0 }),
                _h2('AreaHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('AreaButton', Gui.BLACK),
                _h2('AreaLabel', Gui.AMBER),
                _h2('AreaIcon', Gui.AMBER),
                _h2('AreaHotkey', Gui.AMBER),
            },
        },
        {
            key = 'WallButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY - nButtonHeight },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h2('WallButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('WallButton', AMBER),
            },
            onHoverOn =
            {
                _h2('WallButton', Gui.AMBER),
                _h2('WallLabel', { 0, 0, 0 }),
                _h2('WallIcon', { 0, 0, 0 }),
                _h2('WallHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('WallButton', Gui.BLACK),
                _h2('WallLabel', Gui.AMBER),
                _h2('WallIcon', Gui.AMBER),
                _h2('WallHotkey', Gui.AMBER),
            },
        },
        {
            key = 'FloorButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY - (nButtonHeight*2) },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            color = Gui.BLACK,
            onPressed =
            {
                _h2('FloorButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('FloorButton', AMBER),
            },
            onHoverOn =
            {
                _h2('FloorButton', Gui.AMBER),
                _h2('FloorLabel', { 0, 0, 0 }),
                _h2('FloorIcon', { 0, 0, 0 }),
                _h2('FloorHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('FloorButton', Gui.BLACK),
                _h2('FloorLabel', Gui.AMBER),
                _h2('FloorIcon', Gui.AMBER),
                _h2('FloorHotkey', Gui.AMBER),
            },
        },
        {
            key = 'ObjectButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY - (nButtonHeight*3) },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            color = Gui.BLACK,
            onPressed =
            {
                _h2('ObjectButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('ObjectButton', AMBER),
            },
            onHoverOn =
            {
                _h2('ObjectButton', Gui.AMBER),
                _h2('ObjectLabel', { 0, 0, 0 }),
                _h2('ObjectIcon', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('ObjectButton', Gui.BLACK),
                _h2('ObjectLabel', Gui.AMBER),
                _h2('ObjectIcon', Gui.AMBER),
            },
        },
        {
            key = 'DemolishButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY - (nButtonHeight*4) },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            color = Gui.BLACK,
            onPressed =
            {
                _h2('DemolishButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('DemolishButton', AMBER),
            },
            onHoverOn =
            {
                _h2('DemolishButton', Gui.AMBER),
                _h2('DemolishLabel', { 0, 0, 0 }),
                _h2('DemolishIcon', { 0, 0, 0 }),
                _h2('DemolishHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('DemolishButton', Gui.BLACK),
                _h2('DemolishLabel', Gui.AMBER),
                _h2('DemolishIcon', Gui.AMBER),
                _h2('DemolishHotkey', Gui.AMBER),
            },
        },
        {
            key = 'VaporizeButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY - (nButtonHeight*5) },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
            color = Gui.BLACK,
            onPressed =
            {
                _h2('VaporizeButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('VaporizeButton', AMBER),
            },
            onHoverOn =
            {
                _h2('VaporizeButton', Gui.AMBER),
                _h2('VaporizeLabel', { 0, 0, 0 }),
                _h2('VaporizeIcon', { 0, 0, 0 }),
                _h2('VaporizeHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h2('VaporizeButton', Gui.BLACK),
                _h2('VaporizeLabel', Gui.AMBER),
                _h2('VaporizeIcon', Gui.AMBER),
                _h2('VaporizeHotkey', Gui.AMBER),
            },
        },
        {
            key = 'EraseButton',
            type = 'onePixelButton',
            pos = { 0, nButtonStartY - (nButtonHeight * 6) },
            scale = { nButtonWidth, nButtonHeight },
            color = AMBER,
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
        _h3('CancelIcon', 'uiTexture', 'ui_iconIso_decline', 'UI/Shared', { nIconX, nCancelIconStartY }, CONSTRUCT_CANCEL, { nIconScale, nIconScale }),
        _h3('ConfirmIcon', 'uiTexture', 'ui_iconIso_confirm', 'UI/Shared', { nIconX, nCancelIconStartY - nButtonHeight }, CONSTRUCT_CONFIRM, { nIconScale, nIconScale }),
        _h3('AreaIcon', 'uiTexture', 'ui_iconIso_room', 'UI/Shared', { nIconX, nIconStartY }, Gui.AMBER, { nIconScale, nIconScale }),
        _h3('WallIcon', 'uiTexture', 'ui_iconIso_Wall', 'UI/Shared', { nIconX, nIconStartY - nButtonHeight }, Gui.AMBER, { nIconScale, nIconScale }),
        _h3('FloorIcon', 'uiTexture', 'ui_iconIso_floor', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 2) }, Gui.AMBER, { nIconScale, nIconScale }),
        {
            key = 'ObjectIcon',
            type = 'uiTexture',
            textureName = 'ui_iconIso_object',
            sSpritesheetPath = 'UI/Shared',
            pos = { nIconX, nIconStartY - (nButtonHeight * 3) },
            scale = {nIconScale, nIconScale},
            color = Gui.AMBER,
        },
        _h3('DemolishIcon', 'uiTexture', 'ui_iconIso_demolish', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 4) }, Gui.AMBER, { nIconScale, nIconScale }),
        _h3('VaporizeIcon', 'uiTexture', 'ui_iconIso_demolish', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 5) }, Gui.AMBER, { nIconScale, nIconScale }),
        _h3('EraseIcon', 'uiTexture', 'ui_iconIso_erase', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 6) }, Gui.AMBER, { nIconScale, nIconScale }),
        {
            key = 'MenuSublabel',
            type = 'textBox',
            pos = { 40, -166 },
            linecode = "HUDHUD012TEXT",
            style = 'dosissemibold22',
            rect = { 0, 100, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.GREY,
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
            key = 'AreaLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY },
            linecode = 'HUDHUD013TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nTextHeight, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'WallLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - nButtonHeight },
            linecode = 'HUDHUD014TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nTextHeight, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'FloorLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 2) },
            linecode = 'HUDHUD027TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nTextHeight, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ObjectLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 3) },
            linecode = 'HUDHUD023TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nTextHeight, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'DemolishLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 4) },
            linecode = 'HUDHUD017TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'VaporizeLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 5) },
            linecode = 'HUDHUD045TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'EraseLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 6) },
            linecode = 'HUDHUD011TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
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
            key = 'AreaHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY },
            text = 'R',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'WallHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - nButtonHeight },
            text = 'W',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'FloorHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 2) },
            text = 'F',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ObjectHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 3) },
            text = 'B',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'DemolishHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 4) },
            text = 'D',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'VaporizeHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 5) },
            text = 'V',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'EraseHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 6) },
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
        },
        {
            key = 'CostBackground',
            type = 'onePixel',
            pos = { nButtonWidth, -nButtonHeight },
            scale = { nBGWidth, nButtonHeight },
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'CostBackgroundEndCap',
            type = 'uiTexture',
            textureName = 'ui_confirm_endcap',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth + nBGWidth - 1, -nButtonHeight },
            color = CONSTRUCT_CONFIRM,
        },
        {
            key = 'CostVerticalRule',
            type = 'uiTexture',
            textureName = 'ui_confirm_verticalrule',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth, -nButtonHeight - 4 },
            color = { 0, 0, 0 },
        },
        {
            key = 'CostIconMatter',
            type = 'uiTexture',
            textureName = 'ui_confirm_iconmatter',
            sSpritesheetPath = 'UI/Shared',
            pos = { nButtonWidth + 10, -nButtonHeight - 10 },
            color = { 0, 0, 0 },
        },
        {
            key = 'CostText',
            type = 'textBox',
            pos = { nButtonWidth + 34, -nButtonHeight - 4 },
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
            pos = { 0, nButtonStartY - (nButtonHeight * numButtons) },
            scale = { 1.28, 1.28 },
            color = Gui.SIDEBAR_BG,
        },
    },
}
