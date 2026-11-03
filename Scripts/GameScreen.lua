local Screen = require('UI.Screen')
local Class = require('Class')
local GameRules=require('GameRules')
local Renderer=require('Renderer')
local Character=require('CharacterConstants')
local SoundManager=require('SoundManager')
local EventController = require('EventController')
local Room = require('Room')
local Profile = require('Profile')
local GameScreen = Class.create(Screen)
GameScreen.bIsOpaque = true
GameScreen.inputMode = INPUTMODE_NORMAL
function GameScreen.beginTextEntry(textBox,focusObj,fnConfirmed,fnCanceled)
    GameScreen.textInputBox = textBox
    GameScreen.textBuffer = textBox:getString()
    GameScreen.textOriginal = GameScreen.textBuffer
    textBox:setString(GameScreen.textBuffer .. '_')
    GameScreen.textFocus = focusObj
    GameScreen.textConfirmedCallback = fnConfirmed
    GameScreen.textCanceledCallback = fnCanceled
end
function GameScreen.inTextEntry()
    return GameScreen.textInputBox ~= nil
end
function GameScreen.handleTextEntryClick(wx,wy)
    if GameScreen.textInputBox then
        if GameScreen.textInputBox:inside(wx,wy) then
        else
            GameScreen.endTextEntry()
        end
        return true
    end
end
function GameScreen.endTextEntry()
    if not GameScreen.textInputBox then return end
    GameScreen.textInputBox:setString(GameScreen.textOriginal)
    GameScreen.textInputBox = nil
    GameScreen.textBuffer = nil
    GameScreen.textFocus = nil
    GameScreen.textConfirmedCallback = nil
    GameScreen.textCanceledCallback = nil
end
function GameScreen:onAddLayers(tRenderLayers)
    Renderer.addRenderLayers(tRenderLayers)
    Renderer.addDebugLayers(tRenderLayers)
end
function GameScreen:init()
    Screen.init(self)
    GameScreen.bFlipProp = false
end
function GameScreen:onHover(x, y)
    GameRules.handleHover(x,y)
end
function GameScreen:inputPointer(touch, bDoubleTap)
    GameRules.inputPointer(touch,bDoubleTap)
end
function GameScreen:onKeyboard(key, bDown)
    if g_GuiManager and g_GuiManager.isInStartupScreen() then
        return true
    end
    if bDown and GameScreen.textInputBox then
		local nCharLimit = 21
        if key == 8 then
            if GameScreen.textBuffer:len() > 0 then
                GameScreen.textBuffer = string.sub(GameScreen.textBuffer, 1, GameScreen.textBuffer:len() - 1)
            else
                return
            end
        elseif key == 27 then
			if GameScreen.textCanceledCallback then
				GameScreen.textCanceledCallback(GameScreen.textFocus,GameScreen.textBuffer)
			end
            GameScreen.endTextEntry()
            return
        elseif key == 13 then
            if GameScreen.textConfirmedCallback then
                GameScreen.textConfirmedCallback(GameScreen.textFocus,GameScreen.textBuffer)
            end
            GameScreen.textOriginal = GameScreen.textBuffer
            GameScreen.endTextEntry()
            return
        elseif key == 256 or key == 257 or key >= 258 then
            return
        elseif GameScreen.textBuffer:len() < nCharLimit then
            GameScreen.textBuffer = GameScreen.textBuffer .. string.char(key)
        end
        GameScreen.textInputBox:setString(GameScreen.textBuffer..'_')
        return
	end
    local bHandled = false
    if g_GuiManager.newBaseActive then
        g_GuiManager.newBase:onKeyboard(key, bDown)
		bHandled = true
    end
    local bShift = MOAIInputMgr.device.keyboard:keyIsDown(MOAIKeyboardSensor.SHIFT)
	local bCtrl = MOAIInputMgr.device.keyboard:keyIsDown(MOAIKeyboardSensor.CONTROL)
    if not bHandled and not bCtrl then
        bHandled = g_GuiManager.onKeyboard(key, bDown)
    end
    local World=require('World')
    if not bHandled and bDown then
        print('dbg key',key)
        if key == 27 then
            if not g_GuiManager:getSelected() and not g_GuiManager.newBaseActive and not g_GuiManager.newSideBar.rSubmenu then
                if not g_GuiManager.startMenuActive then
                    g_GuiManager.showStartMenu()
                else
                    g_GuiManager.startMenu:resume(false)
                end
            end
        elseif key == string.byte("o") then
            GameRules.cycleVisualizer()
        elseif key == string.byte("k") then
            GameRules.cutawayMode = not GameRules.cutawayMode
            World.updateCutaway()
        elseif GameRules.currentMode == GameRules.MODE_PLACE_PROP and key == string.byte("f") then
            GameScreen.bFlipProp = not GameScreen.bFlipProp
        elseif (key == string.byte("+")) or (key == string.byte("="))
            or (key == string.byte("-")) or (key == string.byte("_")) then
            local bBackward = false
            if (key == string.byte("-")) or (key == string.byte("_")) then
                bBackward = true
            end
            local zoomAmount = -GameRules.ZOOM_WHEEL_STEP * 4.0
            if bBackward then
                zoomAmount = -zoomAmount
            end
            GameRules.AddZoom(zoomAmount)
        elseif bShift and ( key == string.byte(']') or key == string.byte('[') ) then
            local sel = g_GuiManager.getSelected()
            local rRoom
            if sel and sel.getProps then
                rRoom = sel
            elseif sel and sel.getRoom then
                rRoom = sel:getRoom()
            end
            if not rRoom then rRoom = g_SpaceRoom end
            local tProps = rRoom:getProps()
            local rPrev
            local rFound
            local bReturnNext=false
         	for rProp,_ in pairs(tProps) do
                if bReturnNext then
                    rFound = rProp
                    break
                end
                if rProp == GameRules.rLastCycledProp then
                    if key == string.byte('[') then
                        if rPrev then
                            rFound = rPrev
                            break
                        end
                    elseif key == string.byte(']') then
                        bReturnNext = true
                    end
                end
                rPrev = rProp
            end
            if not rFound and bReturnNext then
                rFound = next(tProps)
            elseif not rFound then
                rFound = rPrev
            end
            GameRules.rLastCycledProp = rFound
            g_GuiManager.setSelected(rFound)
            if rFound and rFound.getLoc then
                local x, y = rFound:getLoc()
                GameRules._centerCameraOnPoint(x, y)
            end
        elseif key == string.byte(']') then
            GameRules.timeFaster()
        elseif key == string.byte('[') then
            GameRules.timeSlower()
        elseif key == string.byte(".") or key == string.byte(",") then
            if not bShift then
                local CM = require('CharacterManager')
                local tChars
                if DFSpace.isDev() then
                    tChars = CM.getCharacters()
                else
                    tChars = CM.getTeamCharacters(Character.TEAM_ID_PLAYER)
                end
                local inc = 1
                if key == string.byte(",") then
                    inc = -1
                end
                GameRules.selectedCharIndex = GameRules.selectedCharIndex + inc
                if GameRules.selectedCharIndex > #tChars then
                    GameRules.selectedCharIndex = 1
                elseif GameRules.selectedCharIndex < 1 then
                    GameRules.selectedCharIndex = #tChars
                end
                g_GuiManager.setSelected(tChars[GameRules.selectedCharIndex])
            else
                local tRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER,nil,nil,true)
                local inc = 1
                if key == string.byte(",") then
                    inc = -1
                end
                GameRules.selectedRoomIndex = GameRules.selectedRoomIndex + inc
                if GameRules.selectedRoomIndex > #tRooms then
                    GameRules.selectedRoomIndex = 1
                elseif GameRules.selectedRoomIndex < 1 then
                    GameRules.selectedRoomIndex = #tRooms
                end
                local rRoom = tRooms[GameRules.selectedRoomIndex]
                g_GuiManager.setSelected(rRoom)
                if rRoom then
                    local wx,wy = World._getWorldFromTile(rRoom:getCenterTile())
                    GameRules._centerCameraOnPoint(wx, wy)
                end
            end
        elseif key == string.byte('s') and bCtrl then
            if not EventController.tCurrentEventPersistentState then
                if g_GuiManager.newSideBar:isConstructMenuOpen() then
                    g_GameRules.cancelBuild(true)
                    g_GuiManager.newSideBar:closeConstructMenu()
                end
                GameRules.saveGame()
            else
                GameRules.bQueuedSave = true
            end
        elseif key == string.byte('l') and bCtrl then
            GameRules.loadGame()
            GameRules.startLoop()
        elseif key == 32 then
            GameRules.togglePause()
        elseif key == 264 then
            Renderer.toggleUI()
        end
        g_GuiManager.refresh()
    end
end
return GameScreen
