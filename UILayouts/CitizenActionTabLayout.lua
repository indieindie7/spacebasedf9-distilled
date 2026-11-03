local function _h1(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,scale=a5,color=a6} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local nButtonWidth, nButtonHeight  = 418, 90
local buttonX = 50
return
{
    posInfo =
    {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 20,
    },
    tExtraInfo =
    {
    },
    tElements =
    {
        {
            key = 'BedLabel',
            type = 'textBox',
            pos = { 20, -35 },
            linecode = 'INSPEC159TEXT',
            style = 'dosismedium32',
            rect = { 0, 300, 150, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('SecurityArrowL1', 'uiTexture', 'button_alert_flag', 'UI/Shared', { 30, -108 }, {1, 1}, Gui.AMBER_OPAQUE),
        _h1('SecurityArrowL2', 'uiTexture', 'button_alert_flag', 'UI/Shared', { 50, -108 }, {1, 1}, Gui.AMBER_OPAQUE),
        _h1('SecurityArrowL3', 'uiTexture', 'button_alert_flag', 'UI/Shared', { 70, -108 }, {1, 1}, Gui.AMBER_OPAQUE),
        _h1('SecurityArrowR1', 'uiTexture', 'button_alert_flag', 'UI/Shared', { 350, -108 }, {-1, 1}, Gui.AMBER_OPAQUE),
        _h1('SecurityArrowR2', 'uiTexture', 'button_alert_flag', 'UI/Shared', { 370, -108 }, {-1, 1}, Gui.AMBER_OPAQUE),
        _h1('SecurityArrowR3', 'uiTexture', 'button_alert_flag', 'UI/Shared', { 390, -108 }, {-1, 1}, Gui.AMBER_OPAQUE),
        {
            key = 'SecurityLabel',
            type = 'textBox',
            pos = { 0, -100 },
            linecode = 'INSPEC196TEXT',
            style = 'dosismedium32',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
			hidden = false,
        },
        {
            key = 'SecurityWarningLabel',
            type = 'textBox',
            pos = { 0, -145 },
            linecode = 'INSPEC197TEXT',
            style = 'dosissemibold20',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.RED,
			hidden = false,
        },
        {
            key = 'BrigLabel',
            type = 'textBox',
            pos = { 20, -350 },
            linecode = 'INSPEC188TEXT',
            style = 'dosismedium32',
            rect = { 0, 300, 150, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
    },
}
