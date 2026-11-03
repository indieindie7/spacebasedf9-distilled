-- Copyright (c) 2012 Double Fine Productions
local DFDebugger = require('DFMoai.Debugger')
local DFGraphics = require('DFCommon.Graphics')
local DFUtil = require("DFCommon.Util")
local DFScriptSystem = require('DFCommon.ScriptSystem')
local Renderer = require('Renderer')
local GameRules = require('GameRules')
local DataCache = require("DFCommon.DataCache")
local DFMath = require('DFCommon.Math')
local DFFile = require('DFCommon.File')
local LinecodeManager = require('LinecodeManager')
local ScreenManager = require('UI.ScreenManager')
local Hint = require('Hint')
local GameConfig = require('GameConfig')
local Point = require('Point')
g_World = nil
g_GameRules = GameRules
g_GuiManager=nil
g_mainThread = nil
local jit = require("jit")
print("jit status: " .. tostring(jit.status()))
local function _initGarbageCollector()
end
local function _initSimulation()
	MOAISim.clearLoopFlags()
	MOAISim.setLoopFlags(MOAISim.LOOP_FLAGS_FIXED)
	MOAISim.setCpuBudget(1)
end
local function _initGame(windowWidth, windowHeight)
    if MOAIEnvironment.osBrand ~= "OSX" then
    end
    DFSpace.enableConstraintAspectRatio(g_nMinAspectRatio, g_nMaxAspectRatio)
    DataCache.createCache("particles", 20)
    DataCache.createCache("material", 10)
    DataCache.createCache("shader", 10)
    DataCache.createCache("font", 10)
    DataCache.createCache("anim", 200)
    DataCache.createCache("rig", 50)
    DataCache.createCache("texparams", 50)
    math.randomseed(os.time())
    for i=1,50 do math.random() end
    g_nPopulationCap = g_Config:getConfigValue("pop_cap")
    if g_Config:getConfigValue('dev_mode') then
        DFSpace.isDev = function() return true end
    end
    local Post = require("PostFX.Post")
    Post.kEnabled = Post.kEnabled and g_Config:getConfigValue("posteffects")
    require('ObjectList').init()
    g_Gui = require('UI.Gui')
    g_Gui.init()
    local gameViewport, uiViewport = DFGraphics.createWindow( "Spacebase DF9", windowWidth, windowHeight, true )
    Renderer.initializeRenderer(gameViewport, uiViewport)
    GameRules.init()
    local GameScreen = require('GameScreen')
    ScreenManager:initialize(g_Config:getConfigValue("launch_fullscreen"))
    ScreenManager:pushScreen(GameScreen.new())
    Renderer.getGameplayCamera():setScl(8,8)
    local startThread = MOAICoroutine.new()
    startThread:setName("StartThread")
    startThread:run(
        function()
            g_GuiManager.setCursorVisible(false)
            g_GuiManager.setIsInStartupScreen(true)
            g_GuiManager.fadeInCentered("2HB",1)
            DFUtil.sleep(3)
            print('StartThread a')
			DFGraphics.blockOnAsyncTextureLoad()
            print('StartThread b')
            coroutine.yield()
            coroutine.yield()
            g_GuiManager.fadeOutFullScreen()
            g_GuiManager.fadeInCentered("LegalScreen", 1.5)
            DFUtil.sleep(0.1)
            g_GuiManager.setCursorVisible(true)
            g_GuiManager.setIsInStartupScreen(false)
            print('StartThread c')
			DFGraphics.blockOnAsyncTextureLoad()
            print('StartThread d')
            g_GuiManager.fadeOutFullScreen()
            g_GuiManager.showNewBaseScreen()
        end
        )
end
function main()
	_initGarbageCollector()
    local sPath = DFFile.getDataPath('build.string')
	local file = io.open(sPath)
	assert(file)
	local data = file:read('*all')
	file:close()
	data = data:gsub('\n', '')
    print('LAUNCHING SPACEBASE BUILD: '..data)
    MOAIEnvironment.appVersion = data
    DataCache.createCache("linecode", 100)
    g_LM = LinecodeManager.initialize('Dialog/Linecodes/MainGame_enUS.lua')
	_initSimulation()
    local resW = tonumber(g_Config:getConfigValue("window_resolution_w"))
    local resH = tonumber(g_Config:getConfigValue("window_resolution_h"))
	_initGame(resW, resH)
    local lastTime = MOAISim.getDeviceTime()
    local MAX_FRAME_TIME = 1/10
    g_mainThread = MOAICoroutine.new()
    g_mainThread:setName("MainLoop")
    g_mainThread:run(function()
        TT_ENABLED[TT_Cache] = true
        while true do
            local currentTime = MOAISim.getDeviceTime()
            local deltaTime = currentTime - lastTime
            deltaTime = math.min(deltaTime, MAX_FRAME_TIME)
            lastTime = currentTime
            GameRules.onTick(deltaTime)
            ScreenManager:onTick(deltaTime)
            g_GuiManager.onTick(deltaTime)
            coroutine.yield()
        end
    end)
end
main()
