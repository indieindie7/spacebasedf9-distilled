local function _h1(a0,a1) return {key=a0,pos=a1} end
local function _h2(a0,a1) return {key=a0,hidden=a1} end
local function _h3(a0,a1,a2,a3,a4,a5) return {key=a0,type=a1,pos=a2,scale=a3,color=a4,hidden=a5} end
local function _h4(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,textureName=a2,sSpritesheetPath=a3,pos=a4,color=a5,scale=a6} end
local function _h5(a0,a1,a2,a3,a4) return {key=a0,type=a1,pos=a2,scale=a3,color=a4} end
local function _h6(a0,a1) return {key=a0,color=a1} end
local function _h7(a0,a1,a2,a3,a4,a5,a6) return {key=a0,type=a1,pos=a2,textureName=a3,sSpritesheetPath=a4,scale=a5,color=a6} end
local Gui = require('UI.Gui')
local nBorderScale = 4
local nBorderHeight = 60
local nJobBlockScale = 128
local nJobColStart = 538
local nUnassignedJobBGScale = nJobBlockScale - 32
local nJobCheckmarkOffsetX = -22
local nJobCheckmarkOffsetY = 10
local nNameBGScaleX, nNameBGScaleY = 418, 62
local nNameBGLocX = 122
local nSkillLevelIconOffsetX = -32
local nAffinityIconOffsetX = 76
local nHorizBorderXScale = 1636
local nHorizBorderYScale = 2
return
{
    posInfo =
    {
        alignX = 'left',
        alignY = 'top',
    offsetX = 0,
        offsetY = 0,
    },
    tExtraInfo =
    {
        tActiveJobInfo =
        {
            Job1 =
            {
                _h1('SelectedCheckmark', { nJobColStart + nJobBlockScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job2 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 2) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job3 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 3) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job4 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 4) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job5 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 5) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job6 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 6) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job7 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 7) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job8 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 8) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
            Job9 =
            {
                _h1('SelectedCheckmark', { nJobColStart + (nJobBlockScale * 9) + nBorderScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }),
            },
        },
    },
    tElements =
    {
        {
            key = 'Job1Button',
            type = 'onePixelButton',
            pos = { nJobColStart, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob1BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob1BG', true),
            },
        },
        {
            key = 'Job2Button',
            type = 'onePixelButton',
            pos = { nJobColStart + nJobBlockScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob2BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob2BG', true),
            },
        },
        {
            key = 'Job3Button',
            type = 'onePixelButton',
            pos = { nJobColStart + (nJobBlockScale * 2) + nBorderScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob3BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob3BG', true),
            },
        },
        {
            key = 'Job4Button',
            type = 'onePixelButton',
            pos = { nJobColStart + (nJobBlockScale * 3) + nBorderScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob4BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob4BG', true),
            },
        },
        {
            key = 'Job5Button',
            type = 'onePixelButton',
            pos = { nJobColStart + (nJobBlockScale * 4) + nBorderScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob5BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob5BG', true),
            },
        },
        {
            key = 'Job6Button',
            type = 'onePixelButton',
            pos = { nJobColStart + (nJobBlockScale * 5) + nBorderScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob6BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob6BG', true),
            },
        },
        {
            key = 'Job7Button',
            type = 'onePixelButton',
            pos = { nJobColStart + (nJobBlockScale * 6) + nBorderScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob7BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob7BG', true),
            },
        },
        {
            key = 'Job8Button',
            type = 'onePixelButton',
            pos = { nJobColStart + (nJobBlockScale * 7) + nBorderScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('ActiveJob8BG', false),
            },
            onHoverOff =
            {
                _h2('ActiveJob8BG', true),
            },
        },
        {
            key = 'UnassignedJobButton',
            type = 'onePixelButton',
            pos = { nJobColStart + (nJobBlockScale * 8) + nBorderScale, 0 },
            scale = { nJobBlockScale, nBorderHeight },
            color = Gui.BLACK,
            onHoverOn =
            {
                _h2('UnassignedJobBG', false),
                _h2('UnassignedJobBGBracket', false),
            },
            onHoverOff =
            {
                _h2('UnassignedJobBG', true),
                _h2('UnassignedJobBGBracket', true),
            },
        },
        _h3('ActiveJob1BG', 'onePixel', { nJobColStart, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('ActiveJob2BG', 'onePixel', { nJobColStart + nJobBlockScale + 4, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('ActiveJob3BG', 'onePixel', { nJobColStart + (nJobBlockScale * 2) + nBorderScale, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('ActiveJob4BG', 'onePixel', { nJobColStart + (nJobBlockScale * 3) + nBorderScale, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('ActiveJob5BG', 'onePixel', { nJobColStart + (nJobBlockScale * 4) + nBorderScale, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('ActiveJob6BG', 'onePixel', { nJobColStart + (nJobBlockScale * 5) + nBorderScale, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('ActiveJob7BG', 'onePixel', { nJobColStart + (nJobBlockScale * 6) + nBorderScale, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('ActiveJob8BG', 'onePixel', { nJobColStart + (nJobBlockScale * 7) + nBorderScale, 0 }, { nJobBlockScale, nBorderHeight }, { 1, 0, 0 }, true),
        _h3('UnassignedJobBG', 'onePixel', { nJobColStart + (nJobBlockScale * 8) + nBorderScale, 0 }, { nUnassignedJobBGScale, nBorderHeight }, Gui.AMBER, true),
        {
            key = 'UnassignedJobBGBracket',
            type = 'uiTexture',
            textureName = 'ui_circlefilled',
            sSpritesheetPath = 'UI/Shared',
            pos = { nJobColStart + (nJobBlockScale * 8) + nBorderScale + nUnassignedJobBGScale + 32, 0  },
            color = Gui.AMBER,
            scale = { -1, 1 },
            hidden = true,
        },
        _h4('LeftBracket', 'uiTexture', 'ui_circleempty', 'UI/Shared', { 0, 0  }, Gui.GREY, { 1, 1 }),
        _h5('TopBorder', 'onePixel', { 32, 0 }, { nHorizBorderXScale, nHorizBorderYScale }, Gui.GREY),
        _h5('BottomBorder', 'onePixel', { 32, -61 }, { nHorizBorderXScale, nHorizBorderYScale }, Gui.GREY),
        _h4('JobTexture', 'uiTexture', 'ui_jobs_iconJobBuilder', 'UI/JobRoster', { 30, -14 }, Gui.GREY, { 1, 1 }),
        _h4('NameLeftBracket', 'uiTexture', 'ui_circlefilled', 'UI/Shared', { 90, 0 }, Gui.AMBER, { 1, 1 }),
        _h5('NameBG', 'onePixel', { nNameBGLocX, 0 }, { nNameBGScaleX, nNameBGScaleY }, Gui.AMBER),
        {
            key = 'NameButton',
            type = 'onePixelButton',
            pos = { nNameBGLocX, 0 },
            scale = { nNameBGScaleX, nNameBGScaleY },
            color = { 1, 0, 0 },
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            {
                _h6('NameBG', Gui.AMBER_OPAQUE),
                _h6('NameLeftBracket', Gui.AMBER_OPAQUE),
                _h6('NameRightBracket', Gui.AMBER_OPAQUE),
                _h6('NameLabel', Gui.AMBER),
            },
            onHoverOff =
            {
                _h6('NameBG', Gui.AMBER),
                _h6('NameLeftBracket', Gui.AMBER),
                _h6('NameRightBracket', Gui.AMBER),
                _h6('NameLabel', { 0, 0, 0 }),
            },
        },
        _h4('NameRightBracket', 'uiTexture', 'ui_circleinverse', 'UI/Shared', { nJobColStart, 0 }, Gui.AMBER, { 1, 1 }),
        {
            key = 'NameLabel',
            type = 'textBox',
            pos = { 130, -6 },
            text = "Christopher di Remo",
            style = 'dosissemibold35',
            rect = { 0, 100, 600, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { 0, 0, 0 },
        },
        _h5('Column1', 'onePixel', { nJobColStart + nJobBlockScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h5('Column2', 'onePixel', { nJobColStart + (nJobBlockScale * 2) + nBorderScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h5('Column3', 'onePixel', { nJobColStart + (nJobBlockScale * 3) + nBorderScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h5('Column4', 'onePixel', { nJobColStart + (nJobBlockScale * 4) + nBorderScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h5('Column5', 'onePixel', { nJobColStart + (nJobBlockScale * 5) + nBorderScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h5('Column6', 'onePixel', { nJobColStart + (nJobBlockScale * 6) + nBorderScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h5('Column7', 'onePixel', { nJobColStart + (nJobBlockScale * 7) + nBorderScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h5('Column8', 'onePixel', { nJobColStart + (nJobBlockScale * 8) + nBorderScale, 0 }, { nBorderScale, nBorderHeight }, Gui.GREY),
        _h4('RightBracket', 'uiTexture', 'ui_circleempty', 'UI/Shared', { nJobColStart + (nJobBlockScale * 9) + nBorderScale, 0 }, Gui.GREY, { -1, 1 }),
        _h4('SelectedCheckmark', 'uiTexture', 'ui_jobs_icon_checkCircle', 'UI/JobRoster', { nJobColStart + nJobBlockScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY }, Gui.GREY, { 1, 1 }),
        _h7('Job1AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX, -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.BLACK),
        _h7('Job1Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX, -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job2AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + nJobBlockScale, -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job2Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + nJobBlockScale, -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job3AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*2), -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job3Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*2), -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job4AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*3), -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job4Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*3), -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job5AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*4), -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job5Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*4), -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job6AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*5), -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job6Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*5), -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job7AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*6), -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job7Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*6), -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job8AffBG', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*7), -12 }, 'ui_dialogicon_blackBG', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
        _h7('Job8Aff', 'uiTexture', { nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*7), -12 }, 'ui_dialogicon_meh', 'UI/Emoticons', { 1, 1 }, Gui.AMBER),
         _h4('Job1SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
         _h4('Job2SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + nJobBlockScale + nBorderScale  + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
         _h4('Job3SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + (nJobBlockScale * 2) + nBorderScale + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
         _h4('Job4SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + (nJobBlockScale * 3) + nBorderScale + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
        _h4('Job5SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + (nJobBlockScale * 4) + nBorderScale + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
        _h4('Job6SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + (nJobBlockScale * 5) + nBorderScale + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
        _h4('Job7SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + (nJobBlockScale * 6) + nBorderScale + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
        _h4('Job8SkillLevel', 'uiTexture', 'ui_jobs_skillrank5', 'UI/JobRoster', { nJobColStart + (nJobBlockScale * 7) + nBorderScale + nSkillLevelIconOffsetX, 0  }, Gui.AMBER, { 1, 1 }),
},
}
