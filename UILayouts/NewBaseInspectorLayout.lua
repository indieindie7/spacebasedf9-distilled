local LH=require('UI.LH')
local lc,px,tex,tx=LH.lc,LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }
local WIDTH = 550
local defaultTextStyle = 'dosissemibold28'
local textX = 1125
local boxX = 1100
return
{
    posInfo =
        {
        alignX = 'right',
        alignY = 'top',
        offsetX = -1770,
        offsetY = 0,
        scale = { 1, 1 },
    },
    tExtraInfo =
    {
        tAccordionInfo =
        {
            ObjectStatsTab = { nInitX = 0, nInitY = -598, nFinalX = 0, nFinalY = -598 },
        },
    },
    tElements =
    {
        px('BlackBG',{ boxX, -215 },{ WIDTH, 'g_GuiManager.getUIViewportSizeY()' },{ 0, 0, 0, 0.75 }),
        px('HeaderBG',{ boxX, -215 },{ WIDTH, 151 },Gui.AMBER),
        tex('ZoomedMap','galaxy_zoom01','UI/NewGame',{ boxX, 0 },Gui.AMBER),
        lc('LabelName',{ textX, -225 },"NEWBAS007TEXT",'dosisregular52',{ 0, 300, WIDTH - 50, 0 },{ 0, 0, 0 }),
        lc('LabelAge',{ textX, -300 },"NEWBAS008TEXT",defaultTextStyle,{ 0, 300, 500, 0 },{ 0, 0, 0 }),
        px('StatsBG',{ boxX, -352 },{ WIDTH, 195 },Gui.AMBER_OPAQUE),
        tx('LabelDensity',{ textX, -375 },"Stellar Density",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        lc('LabelDistance',{ textX, -415 },"NEWBAS010TEXT",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        lc('LabelThreat',{ textX, -455 },"NEWBAS015TEXT",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        lc('LabelInterference',{ textX, -495 },"NEWBAS016TEXT",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        tx('TextDensity',{ textX + 165, -375 },"Stellar Density",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        lc('TextDistance',{ textX + 225, -415 },"NEWBAS010TEXT",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        lc('TextThreat',{ textX + 155, -455 },"NEWBAS015TEXT",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        lc('TextInterference',{ textX + 248, -495 },"NEWBAS016TEXT",defaultTextStyle,{ 0, 300, 500, 0 },Gui.AMBER),
        tex('FolderTop','ui_inspector_folderTop','UI/Inspector',{ boxX, -547 },Gui.AMBER_OPAQUE,{ 1.315, 1.56 }),
        tex('FolderHeader','ui_inspector_folderActive','UI/Inspector',{ boxX, -547 },Gui.AMBER,{ 1.315, 1.56 }),
        lc('LabelFolder',{ textX + 10, -545 },"NEWBAS013TEXT",'dosisregular52',{ 0, 300, 250, 0 },Gui.BLACK),
        px('FolderFooterBG',{ boxX, -610 },{ WIDTH, 15 },Gui.AMBER),
        lc('LabelHelpText',{ textX, -650 },"NEWBAS014TEXT",defaultTextStyle,{ 0, 900, 500, 0 },Gui.AMBER),
    },
}
