local function _h1(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
local function _h2(a0,a1,a2,a3,a4,a5,a6,a7) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,color=a5,scale=a6,hidden=a7} end
local function _h3(a0,a1) return {key=a0,color=a1} end
local function _h4(a0,a1,a2,a3,a4,a5) return {key=a0,type=a1,pos=a2,scale=a3,color=a4,hidden=a5} end
local function _h5(a0,a1) return {key=a0,hidden=a1} end
local function _h6(a0,a1,a2,a3,a4,a5) return {key=a0,type=a1,hidden=a2,pos=a3,scale=a4,color=a5} end
local function _h7(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,color=a5,scale=a6} end
local Gui = require('UI.Gui')
local CharacterConstants = require('CharacterConstants')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local HIGHLIGHT_COLOR = { 0.1, 0.1, 0.1, 0.75 }
local nBGWidth = 1800
local nButtonWidth, nButtonHeight  = 286, 98
local nButtonStartY = -204
local nIconX, nIconStartY = 10, -12
local nLabelX, nLabelStartY = 105, -20
local nHotkeyX, nHotkeyStartY = nButtonWidth - 110, -68
local nIconScale = .6
local nTopLabelY = -206
local nTopLabelTextY = -154
local nTopBarHeight = 5
local nHighlightY = -110
local nBorderScale = 2
local nJobColX = 10
local nNameColX = 106
local nSortTextureSize = 44
local nJobColScale = 128
local nJobBlockScale = 162
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
        _h2('BGFade', 'uiTexture', 'grad64_left', 'UI/Shared', { nBGWidth, 0 }, Gui.SIDEBAR_BG, { 1, 'g_GuiManager.getUIViewportSizeY()' }, false),
        {
            key = 'ScrollPane',
            type = 'scrollPane',
            pos = { 10, -250 },
            rect = { 0, 0, 1715, '(g_GuiManager.getUIViewportSizeY() - 280)' },
        },
        {
            key = 'BackButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.BLACK,
            onPressed =
            {
                _h3('BackButton', BRIGHT_AMBER),
            },
            onReleased =
            {
                _h3('BackButton', AMBER),
            },
            onHoverOn =
            {
                _h3('BackButton', Gui.AMBER),
                _h3('BackLabel', { 0, 0, 0 }),
                _h3('BackHotkey', { 0, 0, 0 }),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('BackButton', Gui.BLACK),
                _h3('BackLabel', Gui.AMBER),
                _h3('BackHotkey', Gui.AMBER),
            },
        },
        {
            key = 'BackLabel',
            type = 'textBox',
            pos = { 96, -20 },
            linecode = 'HUDHUD035TEXT',
            style = 'dosisregular40',
            rect = { 0, 300, 200, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'BackHotkey',
            type = 'textBox',
            pos = { nHotkeyX, -60 },
            text = 'ESC',
            style = 'dosissemibold22',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.RIGHT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'RosterLabel',
            type = 'textBox',
            pos = { 380, -20 },
            linecode = 'HUDHUD047TEXT',
            style = 'dosismedium44',
            rect = { 0, 400, 500, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        {
            key = 'JobSortButton',
            type = 'onePixelButton',
            pos = { nJobColX, nHighlightY },
            scale = { nJobLabelDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h3('JobSortHighlight', HIGHLIGHT_COLOR),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h3('JobSortHighlight', Gui.BLACK),
            },
        },
        _h1('JobSortHighlight', 'onePixel', { nJobColX, nHighlightY }, { nJobLabelDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, Gui.BLACK),
        {
            key = 'JobLabel',
            type = 'textBox',
            pos = { nJobColX, nTopLabelTextY },
            linecode = 'HUDHUD032TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('JobLabelDivLf', 'onePixel', { nJobColX, nTopLabelY }, { nJobLabelDivScl, nTopBarHeight }, Gui.GREY),
        _h4('jobSortDivMid', 'onePixel', { nJobColX + nJobLabelDivScl, nTopLabelY }, { 45, nTopBarHeight }, Gui.GREY, true),
        _h2('jobSortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJobColX + nJobLabelDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('jobSortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJobColX + nJobLabelDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('JobLabelDivRt', 'onePixel', { nJobColX + nJobLabelDivScl + nSortTextureSize, nTopLabelY }, { nJobLabelDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'NameSortButton',
            type = 'onePixelButton',
            pos = { nNameColX, nHighlightY },
            scale = { 432 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('NameSortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('NameSortHighlight', true),
            },
        },
        {
            key = 'NameSortHighlight',
            type = 'onePixel',
            hidden = true,
            pos = { nNameColX, nHighlightY },
            pos = { nNameColX, nHighlightY },
            scale = { 402 + nSortTextureSize, nSortHighlightScaleY },
            color = HIGHLIGHT_COLOR,
        },
        {
            key = 'NameLabel',
            type = 'textBox',
            pos = { nNameColX + 20, nTopLabelTextY },
            linecode = 'HUDHUD033TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('NameLabelDivLf', 'onePixel', { nNameColX, nTopLabelY }, { 38, nTopBarHeight }, Gui.GREY),
        _h4('nameSortDivMid', 'onePixel', { nNameColX + 36, nTopLabelY }, { 45, nTopBarHeight }, Gui.GREY, true),
        _h2('nameSortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nNameColX + 36,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('nameSortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nNameColX + 36,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('NameLabelDivRt', 'onePixel', { nNameColX + 81, nTopLabelY }, { 364, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job1SortButton',
            type = 'onePixelButton',
            pos = { nJob1ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job1SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job1SortHighlight', true),
            },
        },
        _h6('Job1SortHighlight', 'onePixel', true, { nJob1ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job1Label',
            type = 'textBox',
            pos = { nJob1ColX, nTopLabelTextY },
            linecode = 'DUTIES003TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job1Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.BUILDER], 'UI/JobRoster', { nJob1ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job1Num',
            type = 'textBox',
            pos = { nJob1ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job1LabelDivLf', 'onePixel', { nJob1ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job1SortDivMid', 'onePixel', { nJob1ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job1SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob1ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job1SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob1ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job1LabelDivRt', 'onePixel', { nJob1ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job2SortButton',
            type = 'onePixelButton',
            pos = { nJob2ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job2SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job2SortHighlight', true),
            },
        },
        _h6('Job2SortHighlight', 'onePixel', true, { nJob2ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job2Label',
            type = 'textBox',
            pos = { nJob2ColX, nTopLabelTextY },
            linecode = 'DUTIES005TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job2Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.TECHNICIAN], 'UI/JobRoster', { nJob2ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job2Num',
            type = 'textBox',
            pos = { nJob2ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job2LabelDivLf', 'onePixel', { nJob2ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job2SortDivMid', 'onePixel', { nJob2ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job2SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob2ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job2SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob2ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job2LabelDivRt', 'onePixel', { nJob2ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job3SortButton',
            type = 'onePixelButton',
            pos = { nJob3ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job3SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job3SortHighlight', true),
            },
        },
        _h6('Job3SortHighlight', 'onePixel', true, { nJob3ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job3Label',
            type = 'textBox',
            pos = { nJob3ColX, nTopLabelTextY },
            linecode = 'DUTIES007TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job3Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.MINER], 'UI/JobRoster', { nJob3ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job3Num',
            type = 'textBox',
            pos = { nJob3ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job3LabelDivLf', 'onePixel', { nJob3ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job3SortDivMid', 'onePixel', { nJob3ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job3SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob3ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job3SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob3ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job3LabelDivRt', 'onePixel', { nJob3ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job4SortButton',
            type = 'onePixelButton',
            pos = { nJob4ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job4SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job4SortHighlight', true),
            },
        },
        _h6('Job4SortHighlight', 'onePixel', true, { nJob4ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job4Label',
            type = 'textBox',
            pos = { nJob4ColX, nTopLabelTextY },
            linecode = 'DUTIES009TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job4Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.EMERGENCY], 'UI/JobRoster', { nJob4ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job4Num',
            type = 'textBox',
            pos = { nJob4ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job4LabelDivLf', 'onePixel', { nJob4ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job4SortDivMid', 'onePixel', { nJob4ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job4SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob4ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job4SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob4ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job4LabelDivRt', 'onePixel', { nJob4ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job5SortButton',
            type = 'onePixelButton',
            pos = { nJob5ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job5SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job5SortHighlight', true),
            },
        },
        _h6('Job5SortHighlight', 'onePixel', true, { nJob5ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job5Label',
            type = 'textBox',
            pos = { nJob5ColX, nTopLabelTextY },
            linecode = 'DUTIES013TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job5Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.BARTENDER], 'UI/JobRoster', { nJob5ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job5Num',
            type = 'textBox',
            pos = { nJob5ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job5LabelDivLf', 'onePixel', { nJob5ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job5SortDivMid', 'onePixel', { nJob5ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job5SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob5ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job5SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob5ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job5LabelDivRt', 'onePixel', { nJob5ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job6SortButton',
            type = 'onePixelButton',
            pos = { nJob6ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job6SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job6SortHighlight', true),
            },
        },
        _h6('Job6SortHighlight', 'onePixel', true, { nJob6ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job6Label',
            type = 'textBox',
            pos = { nJob6ColX, nTopLabelTextY },
            linecode = 'DUTIES016TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job6Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.BOTANIST], 'UI/JobRoster', { nJob6ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job6Num',
            type = 'textBox',
            pos = { nJob6ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job6LabelDivLf', 'onePixel', { nJob6ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job6SortDivMid', 'onePixel', { nJob6ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job6SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob6ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job6SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob6ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job6LabelDivRt', 'onePixel', { nJob6ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job7SortButton',
            type = 'onePixelButton',
            pos = { nJob7ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job7SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job7SortHighlight', true),
            },
        },
        _h6('Job7SortHighlight', 'onePixel', true, { nJob7ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job7Label',
            type = 'textBox',
            pos = { nJob7ColX, nTopLabelTextY },
            linecode = 'DUTIES018TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job7Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.SCIENTIST], 'UI/JobRoster', { nJob7ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job7Num',
            type = 'textBox',
            pos = { nJob7ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job7LabelDivLf', 'onePixel', { nJob7ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job7SortDivMid', 'onePixel', { nJob7ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job7SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob7ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job7SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob7ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job7LabelDivRt', 'onePixel', { nJob7ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        {
            key = 'Job8SortButton',
            type = 'onePixelButton',
            pos = { nJob8ColX, nHighlightY },
            scale = { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h5('Job8SortHighlight', false),
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                _h5('Job8SortHighlight', true),
            },
        },
        _h6('Job8SortHighlight', 'onePixel', true, { nJob8ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, HIGHLIGHT_COLOR),
        {
            key = 'job8Label',
            type = 'textBox',
            pos = { nJob8ColX, nTopLabelTextY },
            linecode = 'DUTIES020TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job8Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.DOCTOR], 'UI/JobRoster', { nJob8ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job8Num',
            type = 'textBox',
            pos = { nJob8ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job8LabelDivLf', 'onePixel', { nJob8ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h4('job8SortDivMid', 'onePixel', { nJob8ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY, true),
        _h2('job8SortDown', 'uiTexture', 'ui_jobs_catsortDown', 'UI/JobRoster', { nJob8ColX + nJobDivScl,nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, false),
        _h2('job8SortUp', 'uiTexture', 'ui_jobs_catsortUp', 'UI/JobRoster', { nJob8ColX + nJobDivScl, nTopLabelY + 6  }, Gui.GREY, { 1, 1 }, true),
        _h1('Job8LabelDivRt', 'onePixel', { nJob8ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h1('Job9SortButton', 'onePixelButton', { nJob9ColX, nHighlightY }, { nJobDivScl * 2 + nSortTextureSize, nSortHighlightScaleY }, Gui.BLACK),
        {
            key = 'job9Label',
            type = 'textBox',
            pos = { nJob9ColX, nTopLabelTextY },
            linecode = 'DUTIES001TEXT',
            style = 'dosissemibold26',
            rect = { 0, 100, nJobCatLabelRectSize, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h7('Job9Texture', 'uiTexture', CharacterConstants.JOB_ICONS[CharacterConstants.UNEMPLOYED], 'UI/JobRoster', { nJob9ColX + nJobTextureXOffset, nJobTextureYOffset }, Gui.AMBER, { 1, 1 }),
        {
            key = 'job9Num',
            type = 'textBox',
            pos = { nJob9ColX + nJobNumXOffset, nJobNumYOffset },
            text = '10',
            style = 'dosissemibold26',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        _h1('Job9LabelDivLf', 'onePixel', { nJob9ColX, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
        _h1('Job9LabelDivMid', 'onePixel', { nJob9ColX + nJobDivScl, nTopLabelY }, { nSortTextureSize, nTopBarHeight }, Gui.GREY),
        _h1('Job9LabelDivRt', 'onePixel', { nJob9ColX + nJobDivScl + nSortTextureSize, nTopLabelY }, { nJobDivScl, nTopBarHeight }, Gui.GREY),
    },
}
