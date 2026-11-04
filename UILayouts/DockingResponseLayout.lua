local LH=require('UI.LH')
local lc,px,tex,tx=LH.lc,LH.px,LH.tex,LH.tx
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
return
{
    posInfo =
        {
        alignX = 'center',
        alignY = 'center',
        offsetX = -510,
        offsetY = 405,
        scale = { .85, .85 },
    },
    tElements =
    {
        px('Background',{ 0, 0 },{ 1028, 810 },{ 0, 0, 0 }),
        tex('UpperLeftCorner','ui_boxCorner_3px','UI/Shared',{ 0, 2 },Gui.AMBER,{ 3, 3 }),
        tex('UpperRightCorner','ui_boxCorner_3px','UI/Shared',{ 1034, 2 },Gui.AMBER,{ -3, 3 }),
        tex('BottomLeftCorner','ui_boxCorner_3px','UI/Shared',{ 0, -814 },Gui.AMBER,{ 3, -3 }),
        tex('BottomRightCorner','ui_boxCorner_3px','UI/Shared',{ 1034, -814 },Gui.AMBER,{ -3, -3 }),
        px('TopBorder',{ 6, 0 },{ 1020, 6 },Gui.AMBER),
        px('BottomBorder',{ 6, -806 },{ 1020, 6 },Gui.AMBER),
        px('LeftBorder',{ 0, -6 },{ 6, 800 },Gui.AMBER),
        px('RightBorder',{ 1026, -6 },{ 6, 800 },Gui.AMBER),
        px('PictureBigBG',{ 12, -60 },{ 1010, 152 },Gui.AMBER),
        px('PictureBG',{ 40, -42 },{ 148, 20 },Gui.AMBER),
        tex('PictureBGImage','Background_01','UI/Portraits',{ 44, -46 },nil,{ 1.15, 1.15 }),
        tex('Picture','Chicken_female_White_01','UI/Portraits',{ 44, -46 },nil,{ 1.15, 1.15 }),
        px('InnerBorder',{ 12, -588 },{ 1008, 6 },Gui.AMBER),
        tex('StripesTop','ui_dialog_docking_stripesTop','UI/DialogBox',{ 12, -14 },Gui.AMBER,{ 1.56, 1.56 }),
        tex('StripesBottom','ui_dialog_docking_stripesBottom','UI/DialogBox',{ 10, -788 },Gui.AMBER,{ 1.56, 1.56 }),
        {
            key = 'AcceptButton',
            type = 'onePixelButton',
            pos = { 36, -622 },
            scale = { 960, 134 },
            layerOverride = 'UIForeground',
            color = Gui.BROWN,
            onPressed =
            {
                {
                    key = 'AcceptButton',
                    color = BRIGHT_AMBER,
                },
            },
            onReleased =
            {
                {
                    key = 'AcceptButton',
                    color = AMBER,
                },
            },
            onHoverOn =
            {
                {
                    key = 'AcceptButton',
                    color = AMBER,
                },
                {
                    key = 'AcceptLabel',
                    color = { 0, 0, 0 },
                },
                {
                    key = 'DockingIcon',
                    color = { 0, 0, 0 },
                },
                {
                    key = 'AcceptHotkey',
                    color = { 0, 0, 0 },
                },
            },
            onHoverOff =
            {
                {
                    key = 'AcceptButton',
                    color = Gui.BROWN,
                },
                {
                    key = 'AcceptLabel',
                    color = Gui.AMBER,
                },
                {
                    key = 'DockingIcon',
                    color = Gui.AMBER,
                },
                {
                    key = 'AcceptHotkey',
                    color = Gui.AMBER,
                },
            },
        },
        {
            key = 'AcceptLabel',
            type = 'textBox',
            pos = { 164, -613 },
            linecode = 'HUDHUD021TEXT',
            style = 'dosismedium44',
            rect = { 0, 200, 1000, 0 },
            scale = { 0.76, 0.76 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.CENTER_JUSTIFY,
            color = Gui.AMBER,
        },
        tex('DockingIcon','ui_iconIso_dock','UI/Shared',{ 54, -638 },Gui.AMBER,{ 0.8, 0.8 }),
        tx('AcceptHotkey',{ 965, -708 },'C','dosissemibold30',{ 0, 100, 100, 0 },Gui.AMBER),
        lc('Title',{ 220, -88 },"DOCKUI001TEXT",'dosismedium32',{ 0, 100, 500, 0 },{ 0, 0, 0 }),
        lc('DockerName',{ 220, -128 },"DOCKUI002TEXT",'dosismedium44',{ 0, 100, 800, 0 },{ 0, 0, 0 }),
        lc('DockMessage',{ 220, -240 },"DOCKUI003TEXT",'dosismedium32',{ 0, 400, 760, 0 },Gui.AMBER),
        {
            key = 'DockSideSystemMessage',
            type = 'textBox',
            pos = { 40, -250 },
            linecode = "DOCKUI004TEXT",
            style = 'smallSystemFont',
            rect = { 0, 400, 760, 0 },
            scale = { 0.9, 0.9 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.6 },
        },
    },
}
