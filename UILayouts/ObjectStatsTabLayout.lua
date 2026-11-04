local LH=require('UI.LH')
local lc,tex,tx=LH.lc,LH.tex,LH.tx
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 418, 98
local nStatLabelMargin, nStatTextMargin  = 35, 210
local nStatsStartY = 0
local nLineSize = 40
return
{
    posInfo = LH.pos('left', 'top', 0, -6),
    tExtraInfo =
    {
        tCallbacks =
        {
            onSelected = {},
            onDeselected = {},
        },
		nLineSize = nLineSize,
    },
    tElements =
    {
        {
            key = 'BuilderButton',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'BuilderButton', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'BuilderButton', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        {
            key = 'MaintainerButton',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 4 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'MaintainerButton', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'MaintainerButton', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        tex('PowerIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - 4 },Gui.AMBER),
        lc('PowerLabel',{ nStatLabelMargin, nStatsStartY },"INSPEC164TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('PowerText',{ nStatLabelMargin + 155, nStatsStartY - 2 },"0",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('BuildTimeIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - nLineSize - 4 },Gui.AMBER),
        lc('BuildTimeLabel',{ nStatLabelMargin, nStatsStartY - nLineSize },"INSPEC110TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('BuildTimeText',{ nStatLabelMargin + 120, nStatsStartY - nLineSize - 2 },"1",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('BuilderIcon','ui_icon_friend','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - (nLineSize * 2) - 2 },Gui.AMBER),
        lc('BuilderLabel',{ nStatLabelMargin, nStatsStartY - (nLineSize * 2) },"INSPEC111TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('BuilderText',{ nStatLabelMargin + 95, nStatsStartY - (nLineSize * 2) - 2 },"1",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('MaintainTimeIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - (nLineSize * 3) - 4 },Gui.AMBER),
        lc('MaintainTimeLabel',{ nStatLabelMargin, nStatsStartY  - (nLineSize * 3) - 2},"INSPEC112TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('MaintainTimeText',{ nStatLabelMargin + 230, nStatsStartY - (nLineSize * 3) - 2 },"1",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('MaintainerIcon','ui_icon_friend','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - (nLineSize * 4) - 2 },Gui.AMBER),
        lc('MaintainerLabel',{ nStatLabelMargin, nStatsStartY  - (nLineSize * 4) },"INSPEC113TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('MaintainerText',{ nStatLabelMargin + 210, nStatsStartY - (nLineSize * 4) - 2 },"1",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('ContentsIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - nLineSize * 5 - 6 },Gui.AMBER),
        lc('ContentsLabel',{ nStatLabelMargin, nStatsStartY - nLineSize * 5 },"INSPEC114TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('ContentsText1',{ nStatLabelMargin, nStatsStartY - (nLineSize * 6) - 2 },"1",'dosissemibold24',{ 0, 300, 400, 0 },Gui.AMBER),
        {
            key = 'ContentsButton1',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 6 - 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'ContentsButton1', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'ContentsButton1', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        tx('ContentsText2',{ nStatLabelMargin, nStatsStartY - (nLineSize * 7) - 2 },"1",'dosissemibold24',{ 0, 300, 400, 0 },Gui.AMBER),
        {
            key = 'ContentsButton2',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 6 - 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'ContentsButton2', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'ContentsButton2', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
        tx('ContentsText3',{ nStatLabelMargin, nStatsStartY - (nLineSize * 8) - 2 },"1",'dosissemibold24',{ 0, 300, 400, 0 },Gui.AMBER),
        {
            key = 'ContentsButton3',
            type = 'onePixelButton',
            pos = { 0, nStatsStartY - nLineSize * 6 - 2 },
            scale = { nButtonWidth, nLineSize },
            color = Gui.AMBER_OPAQUE_DIM,
            hidden = false,
            onHoverOn =
            {
				{ key = 'ContentsButton3', color = Gui.AMBER_OPAQUE, },
			},
            onHoverOff =
            {
				{ key = 'ContentsButton3', color = Gui.AMBER_OPAQUE_DIM, },
			},
		},
    },
}
