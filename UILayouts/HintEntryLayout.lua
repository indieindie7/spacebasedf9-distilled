local Gui = require('UI.Gui') local tLayout = { posInfo = { alignY = 'top', offsetX = 0, offsetY = 0, scale = { 1, 1 }, }, tElements = { {
key = 'Button', type = 'onePixelButton', pos = { 0, 0 }, scale = { 570, 70 }, color = Gui.HINTLOG_BG, }, { key = 'HintText',
type = 'textBox', pos = { 10, -10 }, text = "Log goes here.  Let's make sure the length is correct.", style = 'dosissemibold22',
rect = { 0, 300, 450, 0 }, hAlign = MOAITextBox.LEFT_JUSTIFY, vAlign = MOAITextBox.LEFT_JUSTIFY, color = { 0, 0, 0 }, }, }, } return tLayout
