local function _h1(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,scale=a5,color=a6} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local nButtonWidth, nButtonHeight  = 104, 81
local nButtonWidthExpanded = 286
local nButtonStartY = -204
local nIconX, nIconStartY = 10, 0
local nLabelX, nLabelStartY = 105, -10
local nHotkeyX, nHotkeyStartY = nButtonWidth - 104, -50
local nHotkeyExpandedX = nButtonWidthExpanded - 112
local nIconScale = 0.6
local nNumButtons = 7
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
            key = 'SmallBarButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { 104, nButtonHeight * nNumButtons },
            color = Gui.SIDEBAR_BG,
        },
        {
            key = 'LargeBarButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidthExpanded, nButtonHeight * nNumButtons },
            color = Gui.SIDEBAR_BG,
        },
        {
            key = 'SmallBarHighlight',
            type = 'onePixel',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.AMBER,
        },
        {
            key = 'InspectButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'InspectButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'InspectButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'InspectButton', color=Gui.AMBER, },
                { key = 'InspectLabel', color = { 0, 0, 0 }, },
                { key = 'InspectIcon', color = { 0, 0, 0 }, },
                { key = 'InspectHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'InspectButton', color = Gui.BLACK, },
                { key = 'InspectLabel', color = Gui.AMBER, },
                { key = 'InspectIcon', color = Gui.AMBER, },
                { key = 'InspectHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('InspectIcon', 'uiTexture', 'ui_iconIso_inspect', 'UI/Shared', { nIconX, nIconStartY }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'AssignButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'AssignButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'AssignButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'AssignButton',  color=Gui.AMBER, },
                { key = 'AssignLabel', color = { 0, 0, 0 }, },
                { key = 'AssignIcon', color = { 0, 0, 0 }, },
                { key = 'AssignHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'AssignButton', color = Gui.BLACK, },
                { key = 'AssignLabel', color = Gui.AMBER, },
                { key = 'AssignIcon', color = Gui.AMBER, },
                { key = 'AssignHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('AssignIcon', 'uiTexture', 'ui_iconIso_assign', 'UI/Shared', { nIconX, nIconStartY - nButtonHeight }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'ResearchButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight * 2 },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'ResearchButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'ResearchButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'ResearchButton',  color=Gui.AMBER, },
                { key = 'ResearchLabel', color = { 0, 0, 0 }, },
                { key = 'ResearchIcon', color = { 0, 0, 0 }, },
                { key = 'ResearchHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'ResearchButton', color = Gui.BLACK, },
                { key = 'ResearchLabel', color = Gui.AMBER, },
                { key = 'ResearchIcon', color = Gui.AMBER, },
                { key = 'ResearchHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('ResearchIcon', 'uiTexture', 'ui_iconIso_research', 'UI/Shared', { nIconX, nIconStartY - nButtonHeight*2 }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'GoalButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 3) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'GoalButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'GoalButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'GoalButton', color = Gui.AMBER, },
                { key = 'GoalLabel', color = { 0, 0, 0 }, },
                { key = 'GoalIcon', color = { 0, 0, 0 }, },
                { key = 'GoalHotkey', color = { 0, 0, 0 }, },
                { key = 'GoalHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'GoalButton', color = Gui.BLACK, },
                { key = 'GoalLabel', color = Gui.AMBER, },
                { key = 'GoalIcon', color = Gui.AMBER, },
                { key = 'GoalHotkey', color = Gui.AMBER, },
                { key = 'GoalHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('GoalIcon', 'uiTexture', 'ui_iconIso_confirm', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 3) }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'ConstructButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 4) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'ConstructButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'ConstructButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'ConstructButton',  color=Gui.AMBER, },
                { key = 'ConstructLabel', color = { 0, 0, 0 }, },
                { key = 'ConstructIcon', color = { 0, 0, 0 }, },
                { key = 'ConstructHotkey', color = { 0, 0, 0 }, },
                { key = 'ConstructHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'ConstructButton', color = Gui.BLACK, },
                { key = 'ConstructLabel', color = Gui.AMBER, },
                { key = 'ConstructIcon', color = Gui.AMBER, },
                { key = 'ConstructHotkey', color = Gui.AMBER, },
                { key = 'ConstructHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('ConstructIcon', 'uiTexture', 'ui_iconIso_construct', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 4) }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'MineButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 5) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'MineButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'MineButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'MineButton',  color=Gui.AMBER, },
                { key = 'MineLabel', color = { 0, 0, 0 }, },
                { key = 'MineIcon', color = { 0, 0, 0 }, },
                { key = 'MineHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'MineButton', color = Gui.BLACK, },
                { key = 'MineLabel', color = Gui.AMBER, },
                { key = 'MineIcon', color = Gui.AMBER, },
                { key = 'MineHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('MineIcon', 'uiTexture', 'ui_iconIso_mine', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 5) }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'BeaconButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 6) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'BeaconButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'BeaconButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'BeaconButton',  color=Gui.AMBER, },
                { key = 'BeaconLabel', color = { 0, 0, 0 }, },
                { key = 'BeaconIcon', color = { 0, 0, 0 }, },
                { key = 'BeaconHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'BeaconButton', color = Gui.BLACK, },
                { key = 'BeaconLabel', color = Gui.AMBER, },
                { key = 'BeaconIcon', color = Gui.AMBER, },
                { key = 'BeaconHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('BeaconIcon', 'uiTexture', 'ui_iconIso_beacon', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 6) }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'DisasterButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonHeight * 7) },
            scale = { nButtonWidthExpanded, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                { key = 'DisasterButton', color = BRIGHT_AMBER, },
            },
            onReleased =
            {
                { key = 'DisasterButton', color = AMBER, },
            },
            onHoverOn =
            {
                { key = 'DisasterButton',  color=Gui.AMBER, },
                { key = 'DisasterLabel', color = { 0, 0, 0 }, },
                { key = 'DisasterIcon', color = { 0, 0, 0 }, },
                { key = 'DisasterHotkeyExpanded', color = { 0, 0, 0 }, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'DisasterButton', color = Gui.BLACK, },
                { key = 'DisasterLabel', color = Gui.AMBER, },
                { key = 'DisasterIcon', color = Gui.AMBER, },
                { key = 'DisasterHotkeyExpanded', color = Gui.AMBER, },
            },
        },
        _h1('DisasterIcon', 'uiTexture', 'icon_wall_neon_pizza', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 7) }, {nIconScale, nIconScale}, Gui.AMBER),
        {
            key = 'InspectLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY },
            linecode = 'HUDHUD005TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'AssignLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - nButtonHeight },
            linecode = 'HUDHUD006TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ResearchLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - nButtonHeight * 2 },
            linecode = 'HUDHUD046TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'GoalLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - nButtonHeight * 3 },
            linecode = 'HUDHUD052TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ConstructLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 4) },
            linecode = 'HUDHUD007TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 280, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'MineLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 5) },
            linecode = 'HUDHUD008TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BeaconLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 6) },
            linecode = 'HUDHUD025TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'DisasterLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 7) },
            linecode = 'HUDHUD062TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'InspectHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY },
            text = 'I',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'InspectHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY },
            text = 'I',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'AssignHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - nButtonHeight },
            text = 'R',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'AssignHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY - nButtonHeight },
            text = 'R',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ResearchHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - nButtonHeight * 2 },
            text = 'E',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ResearchHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY - nButtonHeight * 2 },
            text = 'E',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'GoalHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - nButtonHeight * 3 },
            text = 'G',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'GoalHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY - nButtonHeight * 3 },
            text = 'G',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ConstructHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 4) },
            text = 'C',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ConstructHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY - (nButtonHeight * 4) },
            text = 'C',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'MineHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 5) },
            text = 'M',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'MineHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY - (nButtonHeight * 5) },
            text = 'M',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BeaconHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 6) },
            text = 'B',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BeaconHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY - (nButtonHeight * 6) },
            text = 'B',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'DisasterHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 7) },
            text = 'Z',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'DisasterHotkeyExpanded',
            type = 'textBox',
            pos = { nHotkeyExpandedX, nHotkeyStartY - (nButtonHeight * 7) },
            text = 'Z',
            style = 'dosissemibold20',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('SidebarBottomEndcap', 'uiTexture', 'ui_hud_anglebottom', 'UI/HUD', { -152, -(nButtonHeight * nNumButtons) }, { 1, 1 }, Gui.SIDEBAR_BG),
        _h1('SidebarBottomEndcapExpanded', 'uiTexture', 'ui_hud_anglebottom', 'UI/HUD', { 0, -(nButtonHeight * nNumButtons) }, { 1.12, 1.12 }, Gui.SIDEBAR_BG),
    },
}
