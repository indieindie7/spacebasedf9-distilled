local LH=require('UI.LH')
local px,tex,tx=LH.px,LH.tex,LH.tx
local function _h1(a0,a1,a2,a3) return {key=a0,type=a1,pos=a2,configKey=a3} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
return
{
    posInfo =
        {
        alignX = 'center',
        alignY = 'center',
        offsetX = 0,
        offsetY = 0,
        scale = { 1, 1 },
    },
    tElements =
    {
        px('Background',{ -777, 641 },{ 2568, 1444 },{ 0, 0, 0, 0.83 },false),
        tex('Logo','logo','UI/StartMenu',{ -1920/2, 1152/2 + 50 },Gui.WHITE,{ 1.5, 1.5 },false),
        _h1('SliderMusic', 'slider', { 25, 100 }, "music_volume"),
        tx('MusicText',{ -825, 110 },"MUSIC VOLUME",'dosissemibold35',{ 0, 70, 800, 0 },Gui.White,'R','C'),
        _h1('SliderSFX', 'slider', { 25, 30 }, "sfx_volume"),
        tx('SFXText',{ -825, 40 },"SFX VOLUME",'dosissemibold35',{ 0, 70, 800, 0 },Gui.White,'R','C'),
        _h1('CheckboxAutoSave', 'checkbox', { 15, -108 }, "autosave"),
        tx('AutoSaveText',{ -825, -108 },"AUTOSAVE",'dosissemibold35',{ 0, 70, 800, 0 },Gui.White,'R','C'),
        _h1('HardwareMouseCheckbox', 'checkbox', { 15, -180 }, "use_os_mouse"),
        tx('HardwareMouseText',{ -825, -180 },"USE OS MOUSE CURSOR",'dosissemibold35',{ 0, 70, 800, 0 },Gui.White,'R','C'),
        _h1('FullscreenCheckbox', 'checkbox', { 15, -252 }, "launch_fullscreen"),
        tx('FullscreenText',{ -825, -252 },"FULLSCREEN",'dosissemibold35',{ 0, 70, 800, 0 },Gui.White,'R','C'),
        _h1('ColorblindCheckbox', 'checkbox', { 15, -324 }, "colorblind"),
        tx('ColorblindText',{ -825, -324 },"COLORBLIND MODE (Requires restart)",'dosissemibold35',{ 0, 70, 800, 0 },Gui.White,'R','C'),
        tx('HeaderText',{ -5, 200 },"SETTINGS",'orbitronWhite',{ 0, 70, 800, 0 },Gui.White,'C','C'),
    },
}
