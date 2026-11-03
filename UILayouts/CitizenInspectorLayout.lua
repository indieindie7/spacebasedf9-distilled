local function _h1(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
local function _h2(a0,a1,a2,a3,a4,a5) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,color=a5} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local nButtonWidth, nButtonHeight  = 418, 90
local nTabWidth, nTabHeight = 83, 47
local nTabLineHeight = 3
local nLabelX, nTextStartY = 40, -276
local nLineHeight = 36
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
		nTabWidth = nTabWidth,
		nTabHeight = nTabHeight,
		nTabLineHeight = nTabLineHeight,
        tHostileMode =
        {
            {
                key = 'StatsBG',
            },
            {
                key = 'FolderTop',
                pos = { 0, -420 },
            },
            {
                key = 'NameEditTexture',
                hidden = true,
            },
        },
        tCitizenMode =
        {
            {
                key = 'StatsBG',
            },
            {
                key = 'FolderTop',
                pos = { 0, -420 },
            },
            {
                key = 'NameEditTexture',
                hidden = false,
            },
        },
    },
    tElements =
    {
        _h1('PictureLargeBG', 'onePixel', { 0, -163 }, { nButtonWidth, 106 }, Gui.AMBER),
        _h1('NameEditBG', 'onePixelButton', { 0, -176 }, { nButtonWidth, 35 }, Gui.AMBER),
        _h1('PictureBG', 'onePixel', { 30, -144 }, { 110, 20 }, Gui.AMBER),
        {
            key = 'PictureBGImage',
            type = 'uiTexture',
            textureName = 'Background_01',
            sSpritesheetPath = 'UI/Portraits',
            pos = { 33, -145 },
            scale = { 0.84, 0.84 },
        },
        {
            key = 'Picture',
            type = 'uiTexture',
            textureName = 'portrait_generic',
            sSpritesheetPath = 'UI/Portraits',
            pos = { 33, -145 },
            scale = { 0.84, 0.84 },
        },
        {
            key = 'PictureFacialHair',
            type = 'uiTexture',
            textureName = 'NoHair',
            sSpritesheetPath = 'UI/Portraits',
            pos = { 33, -145 },
            scale = { 0.84, 0.84 },
        },
        {
            key = 'PictureHair',
            type = 'uiTexture',
            textureName = 'NoHair',
            sSpritesheetPath = 'UI/Portraits',
            pos = { 33, -145 },
            scale = { 0.84, 0.84 },
        },
        {
            key = 'CamCenterButton',
            type = 'onePixelButton',
            pos = { 30, -144 },
            scale = { 110, 124 },
            color = { 1, 0, 0 },
            hidden = true,
            clickWhileHidden = true,
        },
        {
            key = 'NameLabel',
            type = 'textBox',
            pos = { 150, -174 },
            text = "Joan Q. Citizen",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
        },
        {
            key = 'NameEditButton',
            type = 'onePixelButton',
            pos = { 0, -176 },
            scale = { nButtonWidth, 35 },
            color = { 1, 0, 0 },
            hidden = true,
            clickWhileHidden = true,
            onHoverOn =
            {
                { key = 'NameLabel', color = Gui.AMBER, },
                { key = 'NameEditBG', color = Gui.AMBER_OPAQUE, },
				{ key = 'NameEditTexture', hidden = false, },
            },
            onHoverOff =
            {
                { key = 'NameLabel', color = Gui.BLACK, },
                { key = 'NameEditBG', color = Gui.AMBER },
				{ key = 'NameEditTexture', hidden = true, },
            },
            onSelectedOn =
            {
                { key = 'NameLabel', color = Gui.AMBER, },
                { key = 'NameEditBG', color = Gui.BLACK, },
				{ key = 'NameEditTexture', hidden = true, },
            },
            onSelectedOff =
            {
                { key = 'NameLabel', color = Gui.BLACK, },
                { key = 'NameEditBG', color = Gui.AMBER },
				{ key = 'NameEditTexture', hidden = true, },
            },
        },
        {
            key = 'NameEditTexture',
            type = 'uiTexture',
            textureName = 'ui_inspector_buttonEdit',
            sSpritesheetPath = 'UI/Inspector',
            pos = { 380, -176 },
            color = Gui.AMBER,
			hidden = true,
        },
        {
            key = 'TitleLabel',
            type = 'textBox',
            pos = { 150, -216 },
            text = "Expert Technician",
            style = 'dosisregular26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
        },
        _h1('StatsBG', 'onePixel', { 0, -268 }, { nButtonWidth, 152 }, Gui.AMBER_OPAQUE),
        {
            key = 'HealthStatButton',
            type = 'onePixelButton',
            pos = { 0, nTextStartY },
            scale = { nButtonWidth, nLineHeight },
            color = Gui.AMBER_OPAQUE,
            onHoverOn =
            {
                { key = 'HealthStatButton', color = Gui.AMBER_DIM }
            },
            onHoverOff =
            {
                { key = 'HealthStatButton', color = Gui.AMBER_OPAQUE }
            },
        },
        {
            key = 'MoraleButton',
            type = 'onePixelButton',
            pos = { 0, nTextStartY - nLineHeight },
            scale = { nButtonWidth, nLineHeight },
            color = Gui.AMBER_OPAQUE,
            onHoverOn =
            {
                { key = 'MoraleButton', color = Gui.AMBER_DIM }
            },
            onHoverOff =
            {
                { key = 'MoraleButton', color = Gui.AMBER_OPAQUE }
            },
        },
        {
            key = 'RoomButton',
            type = 'onePixelButton',
            pos = { 0, nTextStartY - nLineHeight*2 },
            scale = { nButtonWidth, nLineHeight },
            color = Gui.AMBER_OPAQUE,
            onHoverOn =
            {
                { key = 'RoomButton', color = Gui.AMBER_DIM }
            },
            onHoverOff =
            {
                { key = 'RoomButton', color = Gui.AMBER_OPAQUE }
            },
        },
        {
            key = 'ActivityButton',
            type = 'onePixelButton',
            pos = { 0, nTextStartY - nLineHeight*3 },
            scale = { nButtonWidth, nLineHeight },
            color = Gui.AMBER_OPAQUE,
            onHoverOn =
            {
                { key = 'ActivityButton', color = Gui.AMBER_DIM }
            },
            onHoverOff =
            {
                { key = 'ActivityButton', color = Gui.AMBER_OPAQUE }
            },
        },
        _h2('HealthIcon', 'uiTexture', 'ui_icon_health', 'UI/Inspector', { nLabelX - 30, nTextStartY - 4 }, Gui.AMBER),
        {
            key = 'HealthLabel',
            type = 'textBox',
            pos = { nLabelX, nTextStartY },
            linecode = "INSPEC011TEXT",
            style = 'dosisregular26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
            color = Gui.AMBER,
        },
        {
            key = 'HealthText',
            type = 'textBox',
            pos = { 140, nTextStartY },
            text = "Healthy",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h2('MoraleIcon', 'uiTexture', 'ui_icon_morale', 'UI/Inspector', { nLabelX - 30, nTextStartY - nLineHeight - 4 }, Gui.AMBER),
        {
            key = 'MoraleLabel',
            type = 'textBox',
            pos = { nLabelX, nTextStartY - nLineHeight },
            linecode = "INSPEC012TEXT",
            style = 'dosisregular26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
            color = Gui.AMBER,
        },
        {
            key = 'MoraleText',
            type = 'textBox',
            pos = { 114, nTextStartY - nLineHeight },
            text = "Happy",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h2('DeathIcon', 'uiTexture', 'ui_icon_enemy', 'UI/Inspector', { nLabelX - 30, nTextStartY - nLineHeight - 4 }, Gui.RED),
        {
            key = 'DeathLabel',
            type = 'textBox',
            pos = { nLabelX, nTextStartY - nLineHeight },
            linecode = "INSPEC106TEXT",
            style = 'dosisregular26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
            color = Gui.AMBER,
        },
        {
            key = 'DeathText',
            type = 'textBox',
            pos = { 200, nTextStartY - nLineHeight },
            text = "UNKNOWN",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h2('LocationIcon', 'uiTexture', 'ui_icon_location', 'UI/Inspector', { nLabelX - 30, nTextStartY - (nLineHeight*2) - 4 }, Gui.AMBER),
        {
            key = 'LocationLabel',
            type = 'textBox',
            pos = { nLabelX, nTextStartY - (nLineHeight*2) },
            linecode = "INSPEC013TEXT",
            style = 'dosisregular26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
            color = Gui.AMBER,
        },
        {
            key = 'LocationText',
            type = 'textBox',
            pos = { 132, nTextStartY - (nLineHeight*2) },
            text = "Sector C Test Labs",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h2('ActivityIcon', 'uiTexture', 'ui_icon_bulletpoint', 'UI/Inspector', { nLabelX - 30, nTextStartY - (nLineHeight*3) - 4 }, Gui.AMBER),
        {
            key = 'ActivityLabel',
            type = 'textBox',
            pos = { nLabelX, nTextStartY - (nLineHeight*3) },
            linecode = "INSPEC014TEXT",
            style = 'dosisregular26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
            color = Gui.AMBER,
        },
        {
            key = 'ActivityText',
            type = 'textBox',
            pos = { 120, nTextStartY - (nLineHeight*3) },
            text = "Eating lunch",
            style = 'dosissemibold26',
            rect = { 0, 300, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('TabBGSpacer', 'onePixel', { nTabWidth * 3, -420 }, { nTabWidth*2 + 3, nTabHeight }, Gui.AMBER_OPAQUE),
        _h1('TabLineSpacer', 'onePixel', { nTabWidth * 3, -420-nTabHeight }, { nTabWidth*2 + 3, nTabLineHeight }, Gui.AMBER),
        {
            key = 'TabbedPane',
            type = 'tabbedPane',
            pos = { 0, -428 },
            rect = { 0, 0, nButtonWidth-20, 655 },
        },
   },
}
