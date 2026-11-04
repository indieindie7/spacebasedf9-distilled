local LH=require('UI.LH')
local tex,tx=LH.tex,LH.tx
local Gui = require('UI.Gui')
local nButtonX = 16
local nZoneNameX = 48
local nProjectNameX = 450
local nTextY = 6
local nZoneButtonWidth,nZoneButtonHeight = 370, 64
local nProjectButtonWidth = 450
return
{
    posInfo = LH.pos('left', 'top', 0, 0),
    tElements =
    {
        tex('ZoneNameBubbleLeft','ui_circlefilled','UI/Shared',{ nButtonX, 0 },Gui.AMBER,{1, 1}),
        tex('ZoneNameBubbleMid','ui_circlestraightfilled','UI/Shared',{ nButtonX + 32, 0 },Gui.AMBER,{(nZoneButtonWidth / 32), 1}),
        tex('ProjectNameBubbleLeft','ui_circleinverse_inset_inv','UI/Shared',{ nButtonX + 32 + nZoneButtonWidth, 0 },Gui.BLACK,{1, 1}),
        tex('ZoneNameBubbleRight','ui_circleinverse_inset','UI/Shared',{ nButtonX + 32 + nZoneButtonWidth, 0 },Gui.AMBER,{1, 1}),
    	tx('ZoneName',{ nZoneNameX, -nTextY },"Zone Name",'dosissemibold35',{ 0, 100, 600, 0 },Gui.BLACK),
        tex('ProjectNameBubbleMid','ui_circlestraight','UI/Shared',{ nProjectButtonWidth, 0 },Gui.AMBER,{(nProjectButtonWidth - 32) / 32, 1}),
        tex('ProjectNameBubbleMidHole','ui_circlestraight_inv','UI/Shared',{ nButtonX + nZoneButtonWidth + 64, 0 },Gui.BLACK,{(nProjectButtonWidth - 32) / 32, 1}),
        tex('ProjectNameBubbleRightHole','ui_circlefilled','UI/Shared',{ nButtonX + nZoneButtonWidth + 64 + nProjectButtonWidth, 0 },Gui.BLACK,{-1, 1}),
        tex('ProjectNameBubbleRight','ui_circleempty','UI/Shared',{ nButtonX + nZoneButtonWidth + 64 + nProjectButtonWidth, 0 },Gui.AMBER,{-1, 1}),
		tx('ProjectName',{ nProjectNameX, -nTextY },"Project Name",'dosissemibold35',{ 0, 100, 600, 0 },Gui.AMBER),
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
