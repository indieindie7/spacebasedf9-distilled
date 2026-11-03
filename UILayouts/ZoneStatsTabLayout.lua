local LH=require('UI.LH')
local lc,px,tex,tx=LH.lc,LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local nInspectorWidth = 418
local nStatLabelMargin = 35
local nStatsStartY = 0
local nLineSize = 40
return
{
    posInfo =
        {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = -6,
    },
    tExtraInfo =
    {
        tCallbacks =
        {
            onSelected =
            {
				{ key = 'SurfaceAreaIcon', hidden = false, },
				{ key = 'SurfaceAreaLabel', hidden = false, },
				{ key = 'SurfaceAreaText', hidden = false, },
				{ key = 'OxygenIcon', hidden = false, },
				{ key = 'OxygenLabel', hidden = false, },
				{ key = 'OxygenText', hidden = false, },
				{ key = 'OccupantsIcon', hidden = false, },
				{ key = 'OccupantsLabel', hidden = false, },
				{ key = 'OccupantsText', hidden = false, },
				{ key = 'RoomContentsIcon', hidden = false, },
				{ key = 'RoomContentsLabel', hidden = false, },
				{ key = 'RoomContentsText', hidden = false, },
				{ key = 'PowerDrawIcon', hidden = false, },
				{ key = 'PowerDrawLabel', hidden = false, },
				{ key = 'PowerDrawText', hidden = false, },
            },
            onDeselected =
            {
				{ key = 'SurfaceAreaIcon', hidden = true, },
				{ key = 'SurfaceAreaLabel', hidden = true, },
				{ key = 'SurfaceAreaText', hidden = true, },
				{ key = 'OxygenIcon', hidden = true, },
				{ key = 'OxygenLabel', hidden = true, },
				{ key = 'OxygenText', hidden = true, },
				{ key = 'OccupantsIcon', hidden = true, },
				{ key = 'OccupantsLabel', hidden = true, },
				{ key = 'OccupantsText', hidden = true, },
				{ key = 'RoomContentsIcon', hidden = true, },
				{ key = 'RoomContentsLabel', hidden = true, },
				{ key = 'RoomContentsText', hidden = true, },
				{ key = 'PowerDrawIcon', hidden = true, },
				{ key = 'PowerDrawLabel', hidden = true, },
				{ key = 'PowerDrawText', hidden = true, },
            },
        },
    },
    tElements =
    {
        px('OxygenBG',{ 0, nStatsStartY - nLineSize },{ nInspectorWidth, nLineSize },Gui.AMBER_OPAQUE_DIM),
        px('RoomContentsBG',{ 0, nStatsStartY - nLineSize * 3 },{ nInspectorWidth, nLineSize },Gui.AMBER_OPAQUE_DIM),
        tex('SurfaceAreaIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - 5 },Gui.AMBER),
        lc('SurfaceAreaLabel',{ nStatLabelMargin, nStatsStartY },"INSPEC055TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('SurfaceAreaText',{ nStatLabelMargin + 150, nStatsStartY - 2 },"1",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('OxygenIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, nStatsStartY - nLineSize - 5 },Gui.AMBER),
		lc('OxygenLabel',{ nStatLabelMargin, nStatsStartY - nLineSize },"INSPEC062TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('OxygenText',{ nStatLabelMargin + 150, nStatsStartY - nLineSize - 2 },"1",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('PowerDrawIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, (nStatsStartY - nLineSize * 2) - 5 },Gui.AMBER),
        lc('PowerDrawLabel',{ nStatLabelMargin, nStatsStartY - nLineSize * 2 },"INSPEC163TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('PowerDrawText',{ nStatLabelMargin + 215, (nStatsStartY - nLineSize * 2) - 2 },"0",'dosissemibold24',{ 0, 800, 500, 0 },Gui.AMBER),
        tex('OccupantsIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, (nStatsStartY - nLineSize * 3) - 5 },Gui.AMBER),
		lc('OccupantsLabel',{ nStatLabelMargin, nStatsStartY - nLineSize * 3 },"INSPEC060TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('OccupantsText',{ nStatLabelMargin + 210, (nStatsStartY - nLineSize * 3) - 2 },"1",'dosissemibold24',{ 0, 300, 500, 0 },Gui.AMBER),
        tex('RoomContentsIcon','ui_icon_bulletpoint','UI/Inspector',{ nStatLabelMargin - 30, (nStatsStartY - nLineSize * 4) - 5 },Gui.AMBER),
        lc('RoomContentsLabel',{ nStatLabelMargin, nStatsStartY - nLineSize * 4 },"INSPEC056TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('RoomContentsText',{ nStatLabelMargin + 30, nStatsStartY - nLineSize * 5 - 2 },"1",'dosissemibold24',{ 0, 800, 500, 0 },Gui.AMBER),
    },
}
