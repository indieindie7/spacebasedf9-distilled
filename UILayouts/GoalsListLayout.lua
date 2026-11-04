local LH=require('UI.LH')
local lc,px,tx=LH.lc,LH.px,LH.tx
local Gui = require('UI.Gui')
local nButtonWidth, nButtonHeight  = 286, 98
local nHotkeyX, nHotkeyStartY = nButtonWidth - 110, -68
local nScrollAreaTopMargin = 160
local nSortButton1X = 1106
local nSortButton2X = nSortButton1X + 190
local nSortButtonY = -80
return
{
    posInfo = LH.pos('left', 'top', 0, 0, {1,1}),
    tElements =
    {
        px('LargeBar',{ 0, 0 },{ 'g_GuiManager.getUIViewportSizeX()', 'g_GuiManager.getUIViewportSizeY()' },Gui.SIDEBAR_BG),
        {
            key = 'GoalScrollPane',
            type = 'scrollPane',
            pos = { 550, -nScrollAreaTopMargin },
            rect = { 0, 0, 970, '(g_GuiManager.getUIViewportSizeY() - 192)' },
            scissorLayerName='UIScrollLayerRight',
        },
        {
            key = 'BackButton',
            type = 'onePixelButton',
            pos = { 0, 0 },
            scale = { nButtonWidth, nButtonHeight },
            color = Gui.AMBER,
            hidden = true,
            onPressed =
            {
                { key = 'BackButton', color = Gui.AMBER, },
            },
            onReleased =
            {
                { key = 'BackButton', color = Gui.AMBER, },
            },
            onHoverOn =
            {
                { key = 'BackButton', hidden = false, },
                { key = 'BackLabel', color = Gui.BLACK },
                { key = 'BackHotkey', color = Gui.BLACK },
            },
            onHoverOff =
            {
                { key = 'BackButton', hidden = true, },
                { key = 'BackLabel', color = Gui.AMBER, },
                { key = 'BackHotkey', color = Gui.AMBER, },
            },
        },
        lc('BackLabel',{ 96, -20 },'HUDHUD035TEXT','dosisregular40',{ 0, 300, 200, 0 },Gui.AMBER),
        tx('BackHotkey',{ nHotkeyX, -60 },'ESC','dosissemibold22',{ 0, 100, 100, 0 },Gui.AMBER,'R'),
        lc('GoalLabel',{ 380, -20 },'HUDHUD052TEXT','dosismedium44',{ 0, 300, 400, 0 },Gui.AMBER),
        lc('SortLabel',{ nSortButton1X - 75, nSortButtonY + 6 },'GOALSS014TEXT','dosismedium32',{ 0, 300, 400, 0 },Gui.AMBER),
		{
			key = 'SortCompletedButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/ActionButtonLayout',
            replacements = {
                ActionLabel={linecode='GOALSS012TEXT',
							 pos={0+0-10,0-5}
				},
				ActionButtonTexture={textureName='buttontoggle2_left'},
				ActionButtonTexturePressed={textureName='buttontoggle2_left_pressed'},
            },
            buttonName='ActionButton',
            pos = { nSortButton1X, nSortButtonY },
		},
		{
			key = 'SortUncompletedButton',
            type = 'templateButton',
            layoutFile = 'UILayouts/ActionButtonLayout',
            replacements = {
                ActionLabel={linecode='GOALSS013TEXT'},
				ActionButtonTexture={textureName='buttontoggle2_right'},
				ActionButtonTexturePressed={textureName='buttontoggle2_right_pressed'},
            },
            buttonName='ActionButton',
            pos = { nSortButton2X, nSortButtonY },
		},
    },
}
