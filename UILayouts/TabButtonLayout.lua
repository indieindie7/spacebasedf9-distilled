local LH=require('UI.LH')
local lc,tex,v=LH.lc,LH.tex,LH.v
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local nButtonWidth, nButtonHeight  = 418, 98
return
{
    posInfo =
    {
        alignX = 'left',
        alignY = 'top',
    },
    tExtraInfo =
    {
        tCallbacks =
        {
        },
    },
    tElements =
    {
        {
            key = 'ActiveTabTexture',
            type = 'uiTexture',
            textureName = 'ui_tabTopActive',
            sSpritesheetPath = 'UI/Shared',
            color = Gui.AMBER,
            onHoverOn =
            {
                {
                    key = 'TabText',
                    color = Gui.BLACK,
                },
                v('ActiveTabTexture',false),
                v('InactiveTabTexture',true),
            },
            onHoverOff =
            {
                {
                    key = 'TabText',
                    color = Gui.AMBER,
                },
                v('ActiveTabTexture',true),
                v('InactiveTabTexture',false),
            },
            onSelectedOn =
            {
                {
                    key = 'TabText',
                    color = Gui.BLACK,
                },
                v('ActiveTabTexture',false),
                v('InactiveTabTexture',true),
            },
            onSelectedOff =
            {
                {
                    key = 'TabText',
                    color = Gui.AMBER,
                },
                v('ActiveTabTexture',true),
                v('InactiveTabTexture',false),
            },
        },
        tex('InactiveTabTexture','ui_tabTopInactive','UI/Shared',nil,Gui.AMBER),
        lc('TabText',{32,-8},'RSCHUI005TEXT','dosissemibold30',{ 0, 300, 200, 0 },Gui.BLACK),
    },
}
