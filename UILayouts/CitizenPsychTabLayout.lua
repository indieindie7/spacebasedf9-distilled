local LH=require('UI.LH')
local lc,px,tex,tx=LH.lc,LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local nStatLabelMargin, nStatTextMargin  = 35, 65
local nInspectorWidth = 418
local nIndentX = 30
local nHeadingHeight = 34
local nIconOffsetY = -4
local nSameLineTextOffsetY = -6
local nSelfEsteemY = 10
local nRoomSatisfactionY = -30
local nJobSatisfactionY = -70
local nPersonalityY = -110
local nGraphY = -205
local nGraphLabelWidth = 85
local nGraphLabelY = -630
return
{
    posInfo =
	{
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = -24,
    },
    tExtraInfo =
    {
        tHostileMode =
        {
            { key = 'PersonalityIcon', hidden = true, },
            { key = 'PersonalityLabel', hidden = true, },
            { key = 'PersonalityText', hidden = true, },
            { key = 'SelfEsteemIcon', hidden = true, },
            { key = 'SelfEsteemLabel', hidden = true, },
            { key = 'SelfEsteemText', hidden = true, },
            { key = 'RoomSatisfactionIcon', hidden = true, },
            { key = 'RoomSatisfactionLabel', hidden = true, },
            { key = 'RoomSatisfactionText', hidden = true, },
            { key = 'JobSatisfactionIcon', hidden = true, },
            { key = 'JobSatisfactionLabel', hidden = true, },
            { key = 'JobSatisfactionText', hidden = true, },
        },
        tCitizenMode =
        {
            { key = 'PersonalityIcon', hidden = false, },
            { key = 'PersonalityLabel', hidden = false, },
            { key = 'PersonalityText', hidden = false, },
            { key = 'SelfEsteemIcon', hidden = false, },
            { key = 'SelfEsteemLabel', hidden = false, },
            { key = 'SelfEsteemText', hidden = false, },
            { key = 'RoomSatisfactionIcon', hidden = false, },
            { key = 'RoomSatisfactionLabel', hidden = false, },
            { key = 'RoomSatisfactionText', hidden = false, },
            { key = 'JobSatisfactionIcon', hidden = false, },
            { key = 'JobSatisfactionLabel', hidden = false, },
            { key = 'JobSatisfactionText', hidden = false, },
        },
        tCallbacks =
        {
            onSelected =
            {
                { key = 'PersonalityIcon', hidden = false, },
                { key = 'PersonalityLabel', hidden = false, },
                { key = 'PersonalityText', hidden = false, },
				{ key = 'SelfEsteemIcon', hidden = false, },
				{ key = 'SelfEsteemLabel', hidden = false, },
				{ key = 'SelfEsteemText', hidden = false, },
				{ key = 'RoomSatisfactionIcon', hidden = false, },
				{ key = 'RoomSatisfactionLabel', hidden = false, },
				{ key = 'RoomSatisfactionText', hidden = false, },
				{ key = 'JobSatisfactionIcon', hidden = false, },
				{ key = 'JobSatisfactionLabel', hidden = false, },
				{ key = 'JobSatisfactionText', hidden = false, },
            },
            onDeselected =
            {
                { key = 'PersonalityIcon', hidden = true, },
                { key = 'PersonalityLabel', hidden = true, },
                { key = 'PersonalityText', hidden = true, },
				{ key = 'SelfEsteemIcon', hidden = true, },
				{ key = 'SelfEsteemLabel', hidden = true, },
				{ key = 'SelfEsteemText', hidden = true, },
				{ key = 'RoomSatisfactionIcon', hidden = true, },
				{ key = 'RoomSatisfactionLabel', hidden = true, },
				{ key = 'RoomSatisfactionText', hidden = true, },
				{ key = 'JobSatisfactionIcon', hidden = true, },
				{ key = 'JobSatisfactionLabel', hidden = true, },
				{ key = 'JobSatisfactionText', hidden = true, },
            },
        },
    },
    tElements =
    {
        px('RoomSatBG',{ 0, nRoomSatisfactionY },{ nInspectorWidth, nHeadingHeight + 4 },Gui.AMBER_OPAQUE_DIM),
        px('NeedsBG',{ 0, nPersonalityY },{ nInspectorWidth, nHeadingHeight*2.75 },Gui.AMBER_OPAQUE_DIM),
        px('GraphLabelBG',{ nInspectorWidth-nGraphLabelWidth+10, nGraphY-nHeadingHeight-2 },{ nGraphLabelWidth-10, nInspectorWidth-25 },Gui.AMBER_OPAQUE_DIM),
		tex('SelfEsteemIcon','ui_icon_self_esteem','UI/Inspector',{ nStatLabelMargin - nIndentX, nSelfEsteemY + nIconOffsetY },Gui.AMBER),
		lc('SelfEsteemLabel',{ nStatLabelMargin, nSelfEsteemY },"INSPEC125TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('SelfEsteemText',{ nStatTextMargin + 112, nSelfEsteemY + nSameLineTextOffsetY },"YAaaaayy",'dosissemibold20',{ 0, 300, 600, 0 },Gui.AMBER),
		tex('RoomSatisfactionIcon','ui_icon_room_satisfaction','UI/Inspector',{ nStatLabelMargin - nIndentX, nRoomSatisfactionY + nIconOffsetY },Gui.AMBER),
		lc('RoomSatisfactionLabel',{ nStatLabelMargin, nRoomSatisfactionY },"INSPEC126TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('RoomSatisfactionText',{ nStatTextMargin + 246, nRoomSatisfactionY + nSameLineTextOffsetY },"WOOOoooo",'dosissemibold20',{ 0, 300, 600, 0 },Gui.AMBER),
		tex('JobSatisfactionIcon','ui_icon_room_satisfaction','UI/Inspector',{ nStatLabelMargin - nIndentX, nJobSatisfactionY + nIconOffsetY },Gui.AMBER),
		lc('JobSatisfactionLabel',{ nStatLabelMargin, nJobSatisfactionY },"INSPEC158TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('JobSatisfactionText',{ nStatTextMargin + 155, nJobSatisfactionY + nSameLineTextOffsetY },"WOOOoooo",'dosissemibold20',{ 0, 300, 600, 0 },Gui.AMBER),
        tex('PersonalityIcon','ui_icon_psych','UI/Inspector',{ nStatLabelMargin - nIndentX, nPersonalityY + nIconOffsetY },Gui.AMBER),
		lc('PersonalityLabel',{ nStatLabelMargin, nPersonalityY },"INSPEC076TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
        tx('PersonalityText',{ nStatLabelMargin + 30, nPersonalityY - nHeadingHeight },"This is a test\nThis will work?\nYep It does\nOne more line",'dosissemibold20',{ 0, 300, 360, 0 },Gui.AMBER),
        tex('GraphIcon','ui_icon_needs','UI/Inspector',{ nStatLabelMargin - nIndentX, nGraphY + nIconOffsetY },Gui.AMBER),
		lc('GraphHeadLabel',{ nStatLabelMargin, nGraphY },"INSPEC173TEXT",'dosissemibold26',{ 0, 300, 500, 0 },Gui.AMBER),
		tx('GraphTopLabel',{ 0, nGraphY-30 },'SATISFIED','dosissemibold48',{ 0, 300, nInspectorWidth - 80, 0 },Gui.AMBER_OPAQUE,'C'),
		tx('GraphBottomLabel',{ 0, nGraphLabelY+60 },'UNSATISFIED','dosissemibold48',{ 0, 300, nInspectorWidth - 80, 0 },Gui.AMBER_OPAQUE,'C'),
		tx('GraphLabelMorale',{ -nGraphLabelWidth, nGraphY - 25 },'Morale','dosissemibold22',{ 0, 300, 500, 0 },Gui.WHITE),
		tx('GraphLabelDuty',{ -nGraphLabelWidth, nGraphY },'Duty','dosissemibold22',{ 0, 300, 500, 0 },Gui.WHITE),
		tx('GraphLabelEnergy',{ -nGraphLabelWidth, nGraphY + 25 },'Energy','dosissemibold22',{ 0, 300, 500, 0 },Gui.WHITE),
		tx('GraphLabelSocial',{ -nGraphLabelWidth, nGraphY + 50 },'Social','dosissemibold22',{ 0, 300, 500, 0 },Gui.WHITE),
		tx('GraphLabelAmusement',{ -nGraphLabelWidth, nGraphY + 75 },'Fun','dosissemibold22',{ 0, 300, 500, 0 },Gui.WHITE),
		tx('GraphLabelHunger',{ -nGraphLabelWidth, nGraphY + 100 },'Hunger','dosissemibold22',{ 0, 300, 500, 0 },Gui.WHITE),
		tx('GraphLabelStuff',{ -nGraphLabelWidth, nGraphY + 125 },'Stuff','dosissemibold22',{ 0, 300, 500, 0 },Gui.WHITE),
		tx('GraphLabelX1',{ 322, nGraphLabelY },'-0h','dosissemibold22',{ 0, 300, 500, 0 },Gui.AMBER),
		tx('GraphLabelX2',{ 162, nGraphLabelY },'-8h','dosissemibold22',{ 0, 300, 500, 0 },Gui.AMBER),
		tx('GraphLabelX3',{ 0, nGraphLabelY },'-16h','dosissemibold22',{ 0, 300, 500, 0 },Gui.AMBER),
    },
}
