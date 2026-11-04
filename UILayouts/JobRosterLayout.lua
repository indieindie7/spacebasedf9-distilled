local LH=require('UI.LH')
local btn,c,hv,lc,px,tex,tx,v=LH.btn,LH.c,LH.hv,LH.lc,LH.px,LH.tex,LH.tx,LH.v
local function _h1(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
local Gui = require('UI.Gui')
local CharacterConstants = require('CharacterConstants')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local HIGHLIGHT_COLOR = { 0.1, 0.1, 0.1, 0.75 }
local nBGWidth = 1800
local nButtonWidth, nButtonHeight  = 286, 98
local nIconX, nIconStartY = 10, -12
local nLabelX, nLabelStartY = 105, -20
local nHotkeyX, nHotkeyStartY = nButtonWidth - 110, -68
local nTopLabelY = -206
local nTopLabelTextY = -154
local nTopBarHeight = 5
local nHighlightY = -110
local nJobColX = 10
local nNameColX = 106
local nSortTextureSize = 44
local nJobColScale = 128
local nJob1ColX = 554
local nJob2ColX = nJob1ColX + nJobColScale
local nJob3ColX = nJob1ColX + nJobColScale * 2
local nJob4ColX = nJob1ColX + nJobColScale * 3
local nJob5ColX = nJob1ColX + nJobColScale * 4
local nJob6ColX = nJob1ColX + nJobColScale * 5
local nJob7ColX = nJob1ColX + nJobColScale * 6
local nJob8ColX = nJob1ColX + nJobColScale * 7
local nJob9ColX = nJob1ColX + nJobColScale * 8
local nJobDivScl = 40
local nJobLabelDivScl = 24
local nJobCatLabelRectSize = nJobDivScl * 2 + nSortTextureSize
local nJobLabelRectSize = nJobLabelDivScl * 2 + nSortTextureSize
local nJobTextureXOffset = math.floor(nJobDivScl / 2) + 16
local nJobTextureYOffset = nTopLabelTextY + 36
local nJobNumXOffset = math.floor(nJobDivScl / 2) + 58
local nJobNumYOffset = nTopLabelTextY + 40
local nSortHighlightScaleY = 90
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
    },
    tElements =
    {
        _h1('LargeBar', 'onePixel', { 0, 0 }, { nBGWidth, 'g_GuiManager.getUIViewportSizeY()' }, Gui.SIDEBAR_BG),
        tex('BGFade','grad64_left','UI/Shared',{ nBGWidth, 0 },Gui.SIDEBAR_BG,{ 1, 'g_GuiManager.getUIViewportSizeY()' },false),
        {
            key = 'ScrollPane',
            type = 'scrollPane',
            pos = { 10, -250 },
            rect = { 0, 0, 1715, '(g_GuiManager.getUIViewportSizeY() - 280)' },
        },
        btn('BackButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'BackButton',{ 0, 0, 0 },'BackLabel','BackHotkey',true),hv(Gui.BLACK,'BackButton',Gui.AMBER,'BackLabel','BackHotkey'),BRIGHT_AMBER,AMBER),
        lc('BackLabel',{ 96, -20 },'HUDHUD035TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        tx('BackHotkey',{ nHotkeyX, -60 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        lc('RosterLabel',{ 380, -20 },'HUDHUD047TEXT','dosismedium44',{ 0, 400, 500, 0 },Gui.AMBER),
        btn('JobSortButton',{ nJobColX, nHighlightY },{ nJobLabelDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,hv(HIGHLIGHT_COLOR,'JobSortHighlight',true),{ c('JobSortHighlight',Gui.BLACK), }),
        _h1('JobSortHighlight', 'onePixel', { nJobColX, nHighlightY }, { nJobLabelDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, Gui.BLACK),
        lc('JobLabel',{ nJobColX, nTopLabelTextY },'HUDHUD032TEXT','dosissemibold26',{ 0, 100, nJobLabelRectSize, 0 },Gui.AMBER,'C'),
        _h1('JobLabelDivLf', 'onePixel', { nJobColX, nTopLabelY }, { nJobLabelDivScl, nTopBarHeight }, Gui.GREY),
        px('jobSortDivMid',{ nJobColX + nJobLabelDivScl, nTopLabelY },{ 45, nTopBarHeight },Gui.GREY,true),
        tex('jobSortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJobColX + nJobLabelDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('jobSortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJobColX + nJobLabelDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('JobLabelDivRt', 'onePixel', { nJobColX + nJobLabelDivScl + nSortTextureSize, nTopLabelY }, { nJobLabelDivScl, nTopBarHeight }, Gui.GREY),
        btn('NameSortButton',{ nNameColX, nHighlightY },{ 432 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('NameSortHighlight',false), },{ v('NameSortHighlight',true), }),
        {
            key = 'NameSortHighlight',
            type = 'onePixel',
            hidden = true,
            pos = { nNameColX, nHighlightY },
            pos = { nNameColX, nHighlightY },
            scale = { 402 + nSortTextureSize, nSortHighlightScaleY },
            color = HIGHLIGHT_COLOR,
        },
        lc('NameLabel',{ nNameColX + 20, nTopLabelTextY },'HUDHUD033TEXT','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('NameLabelDivLf', 'onePixel', { nNameColX, nTopLabelY }, { 38, nTopBarHeight }, Gui.GREY),
        px('nameSortDivMid',{ nNameColX + 36, nTopLabelY },{ 45, nTopBarHeight },Gui.GREY,true),
        tex('nameSortDown','ui_jobs_catsortDown','UI/JobRoster',{ nNameColX + 36,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('nameSortUp','ui_jobs_catsortUp','UI/JobRoster',{ nNameColX + 36,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('NameLabelDivRt', 'onePixel', { nNameColX + 81, nTopLabelY }, { 364, nTopBarHeight }, Gui.GREY),
        btn('Job1SortButton',{ nJob1ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job1SortHighlight',false), },{ v('Job1SortHighlight',true), }),
        px('Job1SortHighlight',{ nJob1ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job1Label',{ nJob1ColX, nTopLabelTextY },'DUTIES003TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job1Texture',CharacterConstants.JOB_ICONS[CharacterConstants.BUILDER],'UI/JobRoster',{ nJob1ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job1Num',{ nJob1ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job1LabelDivLf', 'onePixel', { nJob1ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job1SortDivMid',{ nJob1ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job1SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob1ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job1SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob1ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job1LabelDivRt', 'onePixel', { nJob1ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        btn('Job2SortButton',{ nJob2ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job2SortHighlight',false), },{ v('Job2SortHighlight',true), }),
        px('Job2SortHighlight',{ nJob2ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job2Label',{ nJob2ColX, nTopLabelTextY },'DUTIES005TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job2Texture',CharacterConstants.JOB_ICONS[CharacterConstants.TECHNICIAN],'UI/JobRoster',{ nJob2ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job2Num',{ nJob2ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job2LabelDivLf', 'onePixel', { nJob2ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job2SortDivMid',{ nJob2ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job2SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob2ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job2SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob2ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job2LabelDivRt', 'onePixel', { nJob2ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        btn('Job3SortButton',{ nJob3ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job3SortHighlight',false), },{ v('Job3SortHighlight',true), }),
        px('Job3SortHighlight',{ nJob3ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job3Label',{ nJob3ColX, nTopLabelTextY },'DUTIES007TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job3Texture',CharacterConstants.JOB_ICONS[CharacterConstants.MINER],'UI/JobRoster',{ nJob3ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job3Num',{ nJob3ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job3LabelDivLf', 'onePixel', { nJob3ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job3SortDivMid',{ nJob3ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job3SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob3ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job3SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob3ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job3LabelDivRt', 'onePixel', { nJob3ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        btn('Job4SortButton',{ nJob4ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job4SortHighlight',false), },{ v('Job4SortHighlight',true), }),
        px('Job4SortHighlight',{ nJob4ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job4Label',{ nJob4ColX, nTopLabelTextY },'DUTIES009TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job4Texture',CharacterConstants.JOB_ICONS[CharacterConstants.EMERGENCY],'UI/JobRoster',{ nJob4ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job4Num',{ nJob4ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job4LabelDivLf', 'onePixel', { nJob4ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job4SortDivMid',{ nJob4ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job4SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob4ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job4SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob4ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job4LabelDivRt', 'onePixel', { nJob4ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        btn('Job5SortButton',{ nJob5ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job5SortHighlight',false), },{ v('Job5SortHighlight',true), }),
        px('Job5SortHighlight',{ nJob5ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job5Label',{ nJob5ColX, nTopLabelTextY },'DUTIES013TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job5Texture',CharacterConstants.JOB_ICONS[CharacterConstants.BARTENDER],'UI/JobRoster',{ nJob5ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job5Num',{ nJob5ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job5LabelDivLf', 'onePixel', { nJob5ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job5SortDivMid',{ nJob5ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job5SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob5ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job5SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob5ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job5LabelDivRt', 'onePixel', { nJob5ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        btn('Job6SortButton',{ nJob6ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job6SortHighlight',false), },{ v('Job6SortHighlight',true), }),
        px('Job6SortHighlight',{ nJob6ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job6Label',{ nJob6ColX, nTopLabelTextY },'DUTIES016TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job6Texture',CharacterConstants.JOB_ICONS[CharacterConstants.BOTANIST],'UI/JobRoster',{ nJob6ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job6Num',{ nJob6ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job6LabelDivLf', 'onePixel', { nJob6ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job6SortDivMid',{ nJob6ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job6SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob6ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job6SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob6ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job6LabelDivRt', 'onePixel', { nJob6ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        btn('Job7SortButton',{ nJob7ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job7SortHighlight',false), },{ v('Job7SortHighlight',true), }),
        px('Job7SortHighlight',{ nJob7ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job7Label',{ nJob7ColX, nTopLabelTextY },'DUTIES018TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job7Texture',CharacterConstants.JOB_ICONS[CharacterConstants.SCIENTIST],'UI/JobRoster',{ nJob7ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job7Num',{ nJob7ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job7LabelDivLf', 'onePixel', { nJob7ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job7SortDivMid',{ nJob7ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job7SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob7ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job7SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob7ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job7LabelDivRt', 'onePixel', { nJob7ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        btn('Job8SortButton',{ nJob8ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },Gui.BLACK,{ v('Job8SortHighlight',false), },{ v('Job8SortHighlight',true), }),
        px('Job8SortHighlight',{ nJob8ColX, nHighlightY },{ nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },HIGHLIGHT_COLOR,true),
        lc('job8Label',{ nJob8ColX, nTopLabelTextY },'DUTIES020TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job8Texture',CharacterConstants.JOB_ICONS[CharacterConstants.DOCTOR],'UI/JobRoster',{ nJob8ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job8Num',{ nJob8ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job8LabelDivLf', 'onePixel', { nJob8ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        px('job8SortDivMid',{ nJob8ColX + nJobDivScl, nTopLabelY },{ nSortTextureSize, nTopBarHeight },Gui.GREY,true),
        tex('job8SortDown','ui_jobs_catsortDown','UI/JobRoster',{ nJob8ColX + nJobDivScl,nTopLabelY + 6  },Gui.GREY,{ 1, 1 },false),
        tex('job8SortUp','ui_jobs_catsortUp','UI/JobRoster',{ nJob8ColX + nJobDivScl, nTopLabelY + 6  },Gui.GREY,{ 1, 1 },true),
        _h1('Job8LabelDivRt', 'onePixel', { nJob8ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h1('Job9SortButton', 'onePixelButton', { nJob9ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, Gui.BLACK),
        lc('job9Label',{ nJob9ColX, nTopLabelTextY },'DUTIES001TEXT','dosissemibold26',{ 0, 100, nJobCatLabelRectSize, 0 },Gui.AMBER,'C'),
        tex('Job9Texture',CharacterConstants.JOB_ICONS[CharacterConstants.UNEMPLOYED],'UI/JobRoster',{ nJob9ColX + nJobTextureXOffset, nJobTextureYOffset },Gui.AMBER,{ 1, 1 }),
        tx('job9Num',{ nJob9ColX + nJobNumXOffset, nJobNumYOffset },'10','dosissemibold26',{ 0, 100, 100, 0 },Gui.AMBER),
        _h1('Job9LabelDivLf', 'onePixel', { nJob9ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h1('Job9LabelDivMid', 'onePixel', { nJob9ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY),
        _h1('Job9LabelDivRt', 'onePixel', { nJob9ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
    },
}
