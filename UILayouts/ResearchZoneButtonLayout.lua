local function _h1(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,scale=a5,color=a6} end
local Gui = require('UI.Gui')
local nButtonX = 16
local nZoneNameX = 48
local nProjectNameX = 450
local nTextY = 6
local nZoneButtonWidth,nZoneButtonHeight = 370, 64
local nProjectButtonWidth = 450
return
{
    posInfo =
    {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
    },
    tElements =
    {
        _h1('ZoneNameBubbleLeft', 'uiTexture', 'ui_circlefilled', 'UI/Shared', { nButtonX, 0 }, {1, 1}, Gui.AMBER),
        _h1('ZoneNameBubbleMid', 'uiTexture', 'ui_circlestraightfilled', 'UI/Shared', { nButtonX + 32, 0 }, {(nZoneButtonWidth / 32), 1}, Gui.AMBER),
        _h1('ProjectNameBubbleLeft', 'uiTexture', 'ui_circleinverse_inset_inv', 'UI/Shared', { nButtonX + 32 + nZoneButtonWidth, 0 }, {1, 1}, Gui.BLACK),
        _h1('ZoneNameBubbleRight', 'uiTexture', 'ui_circleinverse_inset', 'UI/Shared', { nButtonX + 32 + nZoneButtonWidth, 0 }, {1, 1}, Gui.AMBER),
    	{
            key = 'ZoneName',
            type = 'textBox',
            pos = { nZoneNameX, -nTextY },
            text = "Zone Name",
            style = 'dosissemibold35',
            rect = { 0, 100, 600, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.BLACK,
		},
        _h1('ProjectNameBubbleMid', 'uiTexture', 'ui_circlestraight', 'UI/Shared', { nProjectButtonWidth, 0 }, {(nProjectButtonWidth - 32) / 32, 1}, Gui.AMBER),
        _h1('ProjectNameBubbleMidHole', 'uiTexture', 'ui_circlestraight_inv', 'UI/Shared', { nButtonX + nZoneButtonWidth + 64, 0 }, {(nProjectButtonWidth - 32) / 32, 1}, Gui.BLACK),
        _h1('ProjectNameBubbleRightHole', 'uiTexture', 'ui_circlefilled', 'UI/Shared', { nButtonX + nZoneButtonWidth + 64 + nProjectButtonWidth, 0 }, {-1, 1}, Gui.BLACK),
        _h1('ProjectNameBubbleRight', 'uiTexture', 'ui_circleempty', 'UI/Shared', { nButtonX + nZoneButtonWidth + 64 + nProjectButtonWidth, 0 }, {-1, 1}, Gui.AMBER),
		{
            key = 'ProjectName',
            type = 'textBox',
            pos = { nProjectNameX, -nTextY },
            text = "Project Name",
            style = 'dosissemibold35',
            rect = { 0, 100, 600, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
		},
        {
            key = 'Button',
            type = 'onePixelButton',
            pos = { 64, 0 },
            scale = { 825, 50 },
            color = Gui.RED,
            hidden = true,
            onHoverOn =
            {
                { key = 'Button', color = Gui.GREEN, },
                { key = 'ProjectNameBubbleLeft', color = Gui.BROWN, },
                { key = 'ProjectNameBubbleMidHole', color = Gui.BROWN, },
                { key = 'ProjectNameBubbleRightHole', color = Gui.BROWN, },
                { key = 'ProjectName', color = Gui.BLACK, },
                { playSfx = 'hilight', },
            },
            onHoverOff =
            {
                { key = 'Button', color = Gui.RED, },
                { key = 'ProjectNameBubbleLeft', color = Gui.BLACK, },
                { key = 'ProjectNameBubbleMidHole', color = Gui.BLACK, },
                { key = 'ProjectNameBubbleRightHole', color = Gui.BLACK, },
                { key = 'ProjectName', color = Gui.AMBER, },
            },
			onSelectedOn =
			{
                { key = 'Button', color = Gui.AMBER, },
			},
			onSelectedOff =
			{
                { key = 'Button', color = Gui.RED, },
			},
			onDisabledOn =
			{
				{ key = 'Button', color = Gui.AMBER_OPAQUE, },
			},
			onDisabledOff =
			{
				{ key = 'Button', color = Gui.RED, },
			},
        },
    },
}
