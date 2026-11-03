local LH=require('UI.LH')
local btn,tex,tx=LH.btn,LH.tex,LH.tx
local function _h1(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
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
        tex('PictureBGImage','Background_01','UI/Portraits',{ 33, -145 },nil,{ 0.84, 0.84 }),
        tex('Picture','portrait_generic','UI/Portraits',{ 33, -145 },nil,{ 0.84, 0.84 }),
        tex('PictureFacialHair','NoHair','UI/Portraits',{ 33, -145 },nil,{ 0.84, 0.84 }),
        tex('PictureHair','NoHair','UI/Portraits',{ 33, -145 },nil,{ 0.84, 0.84 }),
        {
            key = 'CamCenterButton',
            type = 'onePixelButton',
            pos = { 30, -144 },
            scale = { 110, 124 },
            color = { 1, 0, 0 },
            hidden = true,
            clickWhileHidden = true,
        },
        tx('NameLabel',{ 150, -174 },"Joan Q. Citizen",'dosissemibold26',{ 0, 300, 500, 0 },{ 0, 0, 0 }),
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
        tex('NameEditTexture','ui_inspector_buttonEdit','UI/Inspector',{ 380, -176 },Gui.AMBER,nil,true),
        tx('TitleLabel',{ 150, -216 },"Expert Technician",'dosisregular26',{ 0, 300, 500, 0 },{ 0, 0, 0 }),
        _h1('StatsBG', 'onePixel', { 0, -268 }, { nButtonWidth, 152 }, Gui.AMBER_OPAQUE),
        btn('HealthStatButton',{ 0, nTextStartY },{ nButtonWidth, nLineHeight },Gui.AMBER_OPAQUE,{ { key = 'HealthStatButton', color = Gui.AMBER_DIM } },{ { key = 'HealthStatButton', color = Gui.AMBER_OPAQUE } }),
        btn('MoraleButton',{ 0, nTextStartY - nLineHeight },{ nButtonWidth, nLineHeight },Gui.AMBER_OPAQUE,{ { key = 'MoraleButton', color = Gui.AMBER_DIM } },{ { key = 'MoraleButton', color = Gui.AMBER_OPAQUE } }),
        btn('RoomButton',{ 0, nTextStartY - nLineHeight*2 },{ nButtonWidth, nLineHeight },Gui.AMBER_OPAQUE,{ { key = 'RoomButton', color = Gui.AMBER_DIM } },{ { key = 'RoomButton', color = Gui.AMBER_OPAQUE } }),
        btn('ActivityButton',{ 0, nTextStartY - nLineHeight*3 },{ nButtonWidth, nLineHeight },Gui.AMBER_OPAQUE,{ { key = 'ActivityButton', color = Gui.AMBER_DIM } },{ { key = 'ActivityButton', color = Gui.AMBER_OPAQUE } }),
        tex('HealthIcon','ui_icon_health','UI/Inspector',{ nLabelX - 30, nTextStartY - 4 },Gui.AMBER),
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
        tx('HealthText',{ 140, nTextStartY },"Healthy",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('MoraleIcon','ui_icon_morale','UI/Inspector',{ nLabelX - 30, nTextStartY - nLineHeight - 4 },Gui.AMBER),
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
        tx('MoraleText',{ 114, nTextStartY - nLineHeight },"Happy",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('DeathIcon','ui_icon_enemy','UI/Inspector',{ nLabelX - 30, nTextStartY - nLineHeight - 4 },Gui.RED),
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
        tx('DeathText',{ 200, nTextStartY - nLineHeight },"UNKNOWN",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('LocationIcon','ui_icon_location','UI/Inspector',{ nLabelX - 30, nTextStartY - (nLineHeight*2) - 4 },Gui.AMBER),
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
        tx('LocationText',{ 132, nTextStartY - (nLineHeight*2) },"Sector C Test Labs",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('ActivityIcon','ui_icon_bulletpoint','UI/Inspector',{ nLabelX - 30, nTextStartY - (nLineHeight*3) - 4 },Gui.AMBER),
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
        tx('ActivityText',{ 120, nTextStartY - (nLineHeight*3) },"Eating lunch",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
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
