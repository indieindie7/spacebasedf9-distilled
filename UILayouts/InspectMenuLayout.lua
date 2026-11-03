local function _h1(a0,a1) return {key=a0,color=a1} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local nButtonWidth, nButtonHeight  = 418, 98
local nLabelX, nLabelStartY = 105, -228
local nHotkeyX, nHotkeyStartY = nButtonWidth - 52, -270
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
    tElements =
    {
        {
            key = 'LargeBar',
            type = 'onePixel',
            pos = { 0, 0 },
            scale = { nButtonWidth, 'g_GuiManager.getUIViewportSizeY()' },
            color = Gui.SIDEBAR_BG,
            bDoRolloverCheck = true,
        },
        {
            key = 'BackButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h1('BackButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h1('BackButton', AMBER),
            },
            onHoverOn =
            {
                _h1('BackButton', Gui.AMBER),
                _h1('BackLabel', { 0, 0, 0 }),
                _h1('BackHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h1('BackButton', Gui.BLACK),
                _h1('BackLabel', Gui.AMBER),
                _h1('BackHotkey', Gui.AMBER),
            },
        },
        {
            key = 'MenuSublabel',
            type = 'textBox',
            pos = { 40, -106 },
            linecode = "HUDHUD020TEXT",
            style = 'dosissemibold22',
            rect = { 0, 100, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BackLabel',
            type = 'textBox',
            pos = { nLabelX, -20 },
            linecode = 'HUDHUD009TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BackHotkey',
            type = 'textBox',
            pos = { nHotkeyX, -60 },
            text = 'ESC',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
    },
}
