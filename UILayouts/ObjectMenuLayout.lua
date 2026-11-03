local function _h1(a0,a1) return {key=a0,hidden=a1} end
local function _h2(a0,a1) return {key=a0,color=a1} end
local function _h3(a0) return {playSfx=a0} end
local function _h4(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,color=a5,scale=a6} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BLACK = { Gui.BLACK[1], Gui.BLACK[2], Gui.BLACK[3], 1 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local CONSTRUCT_CANCEL = Gui.RED
local CONSTRUCT_CONFIRM = Gui.GREEN
local nButtonWidth, nButtonHeight  = 330, 78
local nButtonStartY = 278
local nIconX, nIconStartY = 20, -280
local nLabelX, nLabelStartY =  105, -288
local nHotkeyX, nHotkeyStartY = nButtonWidth - 112, -330
local nIconScale = .6
local numButtons = 12
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
            scale = { nButtonWidth, nButtonStartY + (numButtons * nButtonHeight) },
            color = Gui.SIDEBAR_BG,
        },
        {
            key = 'BackButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
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
                _h2('BackButton', AMBER),
                _h2('BackLabel', { 0, 0, 0 }),
                _h2('BackHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('BackButton', BLACK),
                _h2('BackLabel', Gui.AMBER),
                _h2('BackHotkey', Gui.AMBER),
            },
        },
        {
            key = 'CancelButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonHeight },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onHoverOn =
            {
                _h2('CancelButton', CONSTRUCT_CANCEL),
                _h2('CancelIcon', { 0, 0, 0 }),
                _h2('CancelLabel', { 0, 0, 0 }),
                _h2('CancelHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('CancelButton', BLACK),
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
            color = BLACK,
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
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('ConfirmButton', BLACK),
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
            key = 'AllButton',
            type = 'onePixelButton',
            pos = { 0, -nButtonStartY },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('AllButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('AllButton', AMBER),
            },
            onHoverOn =
            {
                _h2('AllButton', AMBER),
                _h2('AllLabel', { 0, 0, 0 }),
                _h2('AllIcon', { 0, 0, 0 }),
                _h2('AllHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('AllButton', BLACK),
                _h2('AllLabel', Gui.AMBER),
                _h2('AllIcon', Gui.AMBER),
                _h2('AllHotkey', Gui.AMBER),
            },
        },
        {
            key = 'AirlockButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('AirlockButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('AirlockButton', AMBER),
            },
            onHoverOn =
            {
                _h2('AirlockButton', AMBER),
                _h2('AirlockLabel', { 0, 0, 0 }),
                _h2('AirlockIcon', { 0, 0, 0 }),
                _h2('AirlockHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('AirlockButton', BLACK),
                _h2('AirlockLabel', Gui.AMBER),
                _h2('AirlockIcon', Gui.AMBER),
                _h2('AirlockHotkey', Gui.AMBER),
            },
        },
        {
            key = 'ReactorButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 2*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('ReactorButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('ReactorButton', AMBER),
            },
            onHoverOn =
            {
                _h2('ReactorButton', AMBER),
                _h2('ReactorLabel', { 0, 0, 0 }),
                _h2('ReactorIcon', { 0, 0, 0 }),
                _h2('ReactorHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('ReactorButton', BLACK),
                _h2('ReactorLabel', Gui.AMBER),
                _h2('ReactorIcon', Gui.AMBER),
                _h2('ReactorHotkey', Gui.AMBER),
            },
        },
        {
            key = 'GardenButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 3*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('GardenButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('GardenButton', AMBER),
            },
            onHoverOn =
            {
                _h2('GardenButton', AMBER),
                _h2('GardenLabel', { 0, 0, 0 }),
                _h2('GardenIcon', { 0, 0, 0 }),
                _h2('GardenHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('GardenButton', BLACK),
                _h2('GardenLabel', Gui.AMBER),
                _h2('GardenIcon', Gui.AMBER),
                _h2('GardenHotkey', Gui.AMBER),
            },
        },
        {
            key = 'LifeSupportButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 4*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('LifeSupportButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('LifeSupportButton', AMBER),
            },
            onHoverOn =
            {
                _h2('LifeSupportButton', AMBER),
                _h2('LifeSupportLabel', { 0, 0, 0 }),
                _h2('LifeSupportIcon', { 0, 0, 0 }),
                _h2('LifeSupportHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('LifeSupportButton', BLACK),
                _h2('LifeSupportLabel', Gui.AMBER),
                _h2('LifeSupportIcon', Gui.AMBER),
                _h2('LifeSupportHotkey', Gui.AMBER),
            },
        },
        {
            key = 'PubButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 5*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('PubButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('PubButton', AMBER),
            },
            onHoverOn =
            {
                _h2('PubButton', AMBER),
                _h2('PubLabel', { 0, 0, 0 }),
                _h2('PubIcon', { 0, 0, 0 }),
                _h2('PubHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('PubButton', BLACK),
                _h2('PubLabel', Gui.AMBER),
                _h2('PubIcon', Gui.AMBER),
                _h2('PubHotkey', Gui.AMBER),
            },
        },
        {
            key = 'RefineryButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 6*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('RefineryButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('RefineryButton', AMBER),
            },
            onHoverOn =
            {
                _h2('RefineryButton', AMBER),
                _h2('RefineryLabel', { 0, 0, 0 }),
                _h2('RefineryIcon', { 0, 0, 0 }),
                _h2('RefineryHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('RefineryButton', BLACK),
                _h2('RefineryLabel', Gui.AMBER),
                _h2('RefineryIcon', Gui.AMBER),
                _h2('RefineryHotkey', Gui.AMBER),
            },
        },
        {
            key = 'ResidenceButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 7*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('ResidenceButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('ResidenceButton', AMBER),
            },
            onHoverOn =
            {
                _h2('ResidenceButton', AMBER),
                _h2('ResidenceLabel', { 0, 0, 0 }),
                _h2('ResidenceIcon', { 0, 0, 0 }),
                _h2('ResidenceHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('ResidenceButton', BLACK),
                _h2('ResidenceLabel', Gui.AMBER),
                _h2('ResidenceIcon', Gui.AMBER),
                _h2('ResidenceHotkey', Gui.AMBER),
            },
        },
        {
            key = 'FitnessButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 8*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('FitnessButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('FitnessButton', AMBER),
            },
            onHoverOn =
            {
                _h2('FitnessButton', AMBER),
                _h2('FitnessLabel', { 0, 0, 0 }),
                _h2('FitnessIcon', { 0, 0, 0 }),
                _h2('FitnessHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('FitnessButton', BLACK),
                _h2('FitnessLabel', Gui.AMBER),
                _h2('FitnessIcon', Gui.AMBER),
                _h2('FitnessHotkey', Gui.AMBER),
            },
        },
        {
            key = 'ResearchButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 9*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('ResearchButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('ResearchButton', AMBER),
            },
            onHoverOn =
            {
                _h2('ResearchButton', AMBER),
                _h2('ResearchLabel', { 0, 0, 0 }),
                _h2('ResearchIcon', { 0, 0, 0 }),
                _h2('ResearchHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('ResearchButton', BLACK),
                _h2('ResearchLabel', Gui.AMBER),
                _h2('ResearchIcon', Gui.AMBER),
                _h2('ResearchHotkey', Gui.AMBER),
            },
        },
        {
            key = 'InfirmaryButton',
            type = 'onePixelButton',
            pos = { 0, -(nButtonStartY + 10*nButtonHeight) },
            scale = { nButtonWidth, nButtonHeight },
            color = BLACK,
            onPressed =
            {
                _h2('InfirmaryButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h2('InfirmaryButton', AMBER),
            },
            onHoverOn =
            {
                _h2('InfirmaryButton', AMBER),
                _h2('InfirmaryLabel', { 0, 0, 0 }),
                _h2('InfirmaryIcon', { 0, 0, 0 }),
                _h2('InfirmaryHotkey', { 0, 0, 0 }),
                _h3('hilight'),
            },
            onHoverOff =
            {
                _h2('InfirmaryButton', BLACK),
                _h2('InfirmaryLabel', Gui.AMBER),
                _h2('InfirmaryIcon', Gui.AMBER),
                _h2('InfirmaryHotkey', Gui.AMBER),
            },
        },
        _h4('CancelIcon', 'uiTexture', 'ui_iconIso_decline', 'UI/Shared', { nIconX, nCancelIconStartY }, CONSTRUCT_CANCEL, { nIconScale, nIconScale }),
        _h4('ConfirmIcon', 'uiTexture', 'ui_iconIso_confirm', 'UI/Shared', { nIconX, nCancelIconStartY - nButtonHeight }, CONSTRUCT_CONFIRM, { nIconScale, nIconScale }),
        _h4('AllIcon', 'uiTexture', 'ui_iconIso_object', 'UI/Shared', { nIconX, nIconStartY }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('AirlockIcon', 'uiTexture', 'ui_iconIso_airlock', 'UI/Shared', { nIconX, nIconStartY - nButtonHeight }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('ReactorIcon', 'uiTexture', 'ui_iconIso_reactor', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 2) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('GardenIcon', 'uiTexture', 'ui_iconIso_garden', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 3) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('LifeSupportIcon', 'uiTexture', 'ui_iconIso_lifesupport', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 4) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('PubIcon', 'uiTexture', 'ui_iconIso_pub', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 5) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('RefineryIcon', 'uiTexture', 'ui_iconIso_refineryAlt', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 6) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('ResidenceIcon', 'uiTexture', 'ui_iconIso_residence', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 7) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('FitnessIcon', 'uiTexture', 'ui_iconIso_fitness', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 8) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('ResearchIcon', 'uiTexture', 'ui_iconIso_research', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 9) }, Gui.AMBER, { nIconScale, nIconScale}),
        _h4('InfirmaryIcon', 'uiTexture', 'ui_iconIso_infirmary', 'UI/Shared', { nIconX, nIconStartY - (nButtonHeight * 10) }, Gui.AMBER, { nIconScale, nIconScale}),
        {
            key = 'MenuSublabel',
            type = 'textBox',
            pos = { 40, -244 },
            linecode = "HUDHUD024TEXT",
            style = 'dosissemibold22',
            rect = { 0, 100, 400, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.GREY,
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
            key = 'AllLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY },
            linecode = 'ZONEUI058TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'AirlockLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - nButtonHeight },
            linecode = 'ZONEUI036TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ReactorLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 2) },
            linecode = 'ZONEUI003TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'GardenLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 3) },
            linecode = 'ZONEUI069TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'LifeSupportLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 4) },
            linecode = 'ZONEUI001TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'PubLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 5) },
            linecode = 'ZONEUI046TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'RefineryLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 6) },
            linecode = 'ZONEUI037TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ResidenceLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 7) },
            linecode = 'ZONEUI042TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'FitnessLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 8) },
            linecode = 'ZONEUI109TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ResearchLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 9) },
            linecode = 'ZONEUI126TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'InfirmaryLabel',
            type = 'textBox',
            pos = { nLabelX, nLabelStartY - (nButtonHeight * 10) },
            linecode = 'ZONEUI049TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, nButtonWidth, 0 },
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
            key = 'AllHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY },
            text = 'Z',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'AirlockHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - nButtonHeight },
            text = 'A',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ReactorHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 2) },
            text = 'T',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'GardenHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 3) },
            text = 'G',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'LifeSupportHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 4) },
            text = 'S',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'PubHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 5) },
            text = 'B',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'RefineryHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 6) },
            text = 'F',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ResidenceHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 7) },
            text = 'R',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'FitnessHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 8) },
            text = 'N',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'ResearchHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 9) },
            text = 'H',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'InfirmaryHotkey',
            type = 'textBox',
            pos = { nHotkeyX, nHotkeyStartY - (nButtonHeight * 10) },
            text = 'I',
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
            pos = { 0, -(nButtonStartY + numButtons*nButtonHeight) + 1 },
            scale = { 1.28, 1.28 },
            color = Gui.SIDEBAR_BG,
        },
    },
}
