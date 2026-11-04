local LH=require('UI.LH')
local btn,c,hh,hv,px,tex,tx,v=LH.btn,LH.c,LH.hh,LH.hv,LH.px,LH.tex,LH.tx,LH.v
local function _h1(a0,a1) return {key=a0,pos=a1} end
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
    posInfo = LH.pos('left', 'top', 0, 0),
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
        btn('Job1Button',{ nJobColStart, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob1BG',false), },{ v('ActiveJob1BG',true), }),
        btn('Job2Button',{ nJobColStart + nJobBlockScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob2BG',false), },{ v('ActiveJob2BG',true), }),
        btn('Job3Button',{ nJobColStart + (nJobBlockScale * 2) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob3BG',false), },{ v('ActiveJob3BG',true), }),
        btn('Job4Button',{ nJobColStart + (nJobBlockScale * 3) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob4BG',false), },{ v('ActiveJob4BG',true), }),
        btn('Job5Button',{ nJobColStart + (nJobBlockScale * 4) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob5BG',false), },{ v('ActiveJob5BG',true), }),
        btn('Job6Button',{ nJobColStart + (nJobBlockScale * 5) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob6BG',false), },{ v('ActiveJob6BG',true), }),
        btn('Job7Button',{ nJobColStart + (nJobBlockScale * 6) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob7BG',false), },{ v('ActiveJob7BG',true), }),
        btn('Job8Button',{ nJobColStart + (nJobBlockScale * 7) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,{ v('ActiveJob8BG',false), },{ v('ActiveJob8BG',true), }),
        btn('UnassignedJobButton',{ nJobColStart + (nJobBlockScale * 8) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },Gui.BLACK,hh(false,'UnassignedJobBG','UnassignedJobBGBracket'),hh(true,'UnassignedJobBG','UnassignedJobBGBracket')),
        px('ActiveJob1BG',{ nJobColStart, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('ActiveJob2BG',{ nJobColStart + nJobBlockScale + 4, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('ActiveJob3BG',{ nJobColStart + (nJobBlockScale * 2) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('ActiveJob4BG',{ nJobColStart + (nJobBlockScale * 3) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('ActiveJob5BG',{ nJobColStart + (nJobBlockScale * 4) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('ActiveJob6BG',{ nJobColStart + (nJobBlockScale * 5) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('ActiveJob7BG',{ nJobColStart + (nJobBlockScale * 6) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('ActiveJob8BG',{ nJobColStart + (nJobBlockScale * 7) + nBorderScale, 0 },{ nJobBlockScale, nBorderHeight },{ 1, 0, 0 },true),
        px('UnassignedJobBG',{ nJobColStart + (nJobBlockScale * 8) + nBorderScale, 0 },{ nUnassignedJobBGScale, nBorderHeight },Gui.AMBER,true),
        tex('UnassignedJobBGBracket','ui_circlefilled','UI/Shared',{ nJobColStart + (nJobBlockScale * 8) + nBorderScale + nUnassignedJobBGScale + 32, 0  },Gui.AMBER,{ -1, 1 },true),
        tex('LeftBracket','ui_circleempty','UI/Shared',{ 0, 0  },Gui.GREY,{ 1, 1 }),
        px('TopBorder',{ 32, 0 },{ nHorizBorderXScale, nHorizBorderYScale },Gui.GREY),
        px('BottomBorder',{ 32, -61 },{ nHorizBorderXScale, nHorizBorderYScale },Gui.GREY),
        tex('JobTexture','ui_jobs_iconJobBuilder','UI/JobRoster',{ 30, -14 },Gui.GREY,{ 1, 1 }),
        tex('NameLeftBracket','ui_circlefilled','UI/Shared',{ 90, 0 },Gui.AMBER,{ 1, 1 }),
        px('NameBG',{ nNameBGLocX, 0 },{ nNameBGScaleX, nNameBGScaleY },Gui.AMBER),
        {
            key = 'NameButton',
            type = 'onePixelButton',
            pos = { nNameBGLocX, 0 },
            scale = { nNameBGScaleX, nNameBGScaleY },
            color = { 1, 0, 0 },
            hidden = true,
            clickWhileHidden=true,
            onHoverOn =
            hv(Gui.AMBER_OPAQUE,'NameBG','NameLeftBracket','NameRightBracket',Gui.AMBER,'NameLabel'),
            onHoverOff =
            hv(Gui.AMBER,'NameBG','NameLeftBracket','NameRightBracket',{ 0, 0, 0 },'NameLabel'),
        },
        tex('NameRightBracket','ui_circleinverse','UI/Shared',{ nJobColStart, 0 },Gui.AMBER,{ 1, 1 }),
        tx('NameLabel',{ 130, -6 },"Christopher di Remo",'dosissemibold35',{ 0, 100, 600, 0 },{ 0, 0, 0 }),
        px('Column1',{ nJobColStart + nJobBlockScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        px('Column2',{ nJobColStart + (nJobBlockScale * 2) + nBorderScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        px('Column3',{ nJobColStart + (nJobBlockScale * 3) + nBorderScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        px('Column4',{ nJobColStart + (nJobBlockScale * 4) + nBorderScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        px('Column5',{ nJobColStart + (nJobBlockScale * 5) + nBorderScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        px('Column6',{ nJobColStart + (nJobBlockScale * 6) + nBorderScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        px('Column7',{ nJobColStart + (nJobBlockScale * 7) + nBorderScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        px('Column8',{ nJobColStart + (nJobBlockScale * 8) + nBorderScale, 0 },{ nBorderScale, nBorderHeight },Gui.GREY),
        tex('RightBracket','ui_circleempty','UI/Shared',{ nJobColStart + (nJobBlockScale * 9) + nBorderScale, 0 },Gui.GREY,{ -1, 1 }),
        tex('SelectedCheckmark','ui_jobs_icon_checkCircle','UI/JobRoster',{ nJobColStart + nJobBlockScale + nJobCheckmarkOffsetX, nJobCheckmarkOffsetY },Gui.GREY,{ 1, 1 }),
        tex('Job1AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX, -12 },Gui.BLACK,{ 1, 1 }),
        tex('Job1Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX, -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job2AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + nJobBlockScale, -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job2Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + nJobBlockScale, -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job3AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*2), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job3Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*2), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job4AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*3), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job4Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*3), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job5AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*4), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job5Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*4), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job6AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*5), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job6Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*5), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job7AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*6), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job7Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*6), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job8AffBG','ui_dialogicon_blackBG','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*7), -12 },Gui.AMBER,{ 1, 1 }),
        tex('Job8Aff','ui_dialogicon_meh','UI/Emoticons',{ nJobColStart + nAffinityIconOffsetX + (nJobBlockScale*7), -12 },Gui.AMBER,{ 1, 1 }),
         tex('Job1SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
         tex('Job2SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + nJobBlockScale + nBorderScale  + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
         tex('Job3SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + (nJobBlockScale * 2) + nBorderScale + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
         tex('Job4SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + (nJobBlockScale * 3) + nBorderScale + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
        tex('Job5SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + (nJobBlockScale * 4) + nBorderScale + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
        tex('Job6SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + (nJobBlockScale * 5) + nBorderScale + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
        tex('Job7SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + (nJobBlockScale * 6) + nBorderScale + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
        tex('Job8SkillLevel','ui_jobs_skillrank5','UI/JobRoster',{ nJobColStart + (nJobBlockScale * 7) + nBorderScale + nSkillLevelIconOffsetX, 0  },Gui.AMBER,{ 1, 1 }),
},
}
