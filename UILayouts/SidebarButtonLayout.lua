local function _h1(a0,a1) return {key=a0,color=a1} end
local Gui = require('UI.Gui')
local nIconX, nIconStartY = 10, -12
local nLabelX, nLabelStartY = 94, -10
local nButtonWidth, nButtonHeight  = 330, 81
return
{
    posInfo =
    {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
    },
    tExtraInfo =
    {
    },
    tElements =
    {
        {
            key = 'SidebarButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h1('SidebarButton', Gui.AMBER),
                _h1('SidebarLabel', { 0, 0, 0 }),
                _h1('SidebarIcon', { 0, 0, 0 }),
                _h1('SidebarHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h1('SidebarButton', Gui.BLACK),
                _h1('SidebarLabel', Gui.AMBER),
                _h1('SidebarIcon', Gui.AMBER),
                _h1('SidebarHotkey', Gui.AMBER),
            },
        },
        {
            key = 'SidebarIcon',
            type = 'uiTexture',
            textureName = 'ui_iconIso_erase',
            sSpritesheetPath = 'UI/Shared',
            pos = { nIconX, nIconStartY },
            color = Gui.AMBER,
        },
        {
            key = 'SidebarLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY },
            linecode = 'HUDHUD037TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
   },
}
