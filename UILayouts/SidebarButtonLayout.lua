local LH=require('UI.LH')
local btn,c,hl,hv,lc,tex=LH.btn,LH.c,LH.hl,LH.hv,LH.lc,LH.tex
local Gui = require('UI.Gui')
local nIconX, nIconStartY = 10, -12
local nLabelX, nLabelStartY = 94, -10
local nButtonWidth, nButtonHeight  = 330, 81
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
    },
    tElements =
    {
        btn('SidebarButton',{ 0, 0 },{ nButtonWidth, nButtonHeight },Gui.BLACK,hv(Gui.AMBER,'SidebarButton',{ 0, 0, 0 },'SidebarLabel','SidebarIcon','SidebarHotkey',true),hv(Gui.BLACK,'SidebarButton',Gui.AMBER,'SidebarLabel','SidebarIcon','SidebarHotkey')),
        tex('SidebarIcon','ui_iconIso_erase','UI/Shared',{ nIconX, nIconStartY },Gui.AMBER),
        lc('SidebarLabel',{ nLabelX, nLabelStartY },'HUDHUD037TEXT','dosisregular40',{ 0, 300, 280, 0 },Gui.AMBER),
   },
}
