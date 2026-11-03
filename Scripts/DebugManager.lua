local DFInput = require("DFCommon.Input")
local DFFile = require("DFCommon.File")
local DFUtil = require('DFCommon.Util')
local DFGraphics = require("DFCommon.Graphics")
local DataCache = require("DFCommon.DataCache")
local Renderer = require('Renderer')
local ScreenManager = require('UI.ScreenManager')
local DebugManager = {}
DebugManager.bIsInitialized = false
DebugManager.tDebugOptions = { }
DebugManager.tDebugKeyBindings = { }
function DebugManager:initialize()
    if DebugManager.bIsInitialized then
        return
    end
    DebugManager.bIsInitialized = true
	DebugManager:addDebugOption( "Toggle Frame Stats", { "Profiling" }, 260, Renderer.toggleDebugDrawStats )
	DebugManager:addDebugOption( "Toggle Profiler", { "Profiling" }, 261, Renderer.toggleDebugDrawProfileReport )
	DebugManager:addDebugOption( "Toggle GPU Profiler", { "Profiling", "Graphics" }, 268, Renderer.toggleDebugDrawGpuProfileReport )
	DebugManager:addDebugOption( "Start object leak tracking", { "Profiling" }, nil, DebugManager.startObjectLeakTracking )
    DebugManager:addDebugOption( "Report object leaks", { "Profiling" }, nil, DebugManager.reportObjectLeaks )
    DebugManager:addDebugOption( "Lua IO debug", { "Profiling" }, nil, DebugManager.toggleLuaIoDebug )
	DebugManager:addDebugOption( "Debug Draw Mode", { "Graphics" }, "g", Renderer.debugDrawModeSet, Renderer.debugDrawModeGet, Renderer.debugDrawModeOptions )
	DebugManager:addDebugOption( "Debug Draw Rigs", { "Graphics" }, "I", Renderer.toggleDebugDrawRigs)
	DebugManager:addDebugOption( "Debug Draw Rooms", { "Graphics" }, "R", Renderer.cycleDebugDrawRooms)
	DebugManager:addDebugOption( "Debug Draw Pathing", { "Graphics" }, "P", Renderer.toggleDebugDrawPathing)
	DebugManager:addDebugOption( "Debug Draw Jobs", { "Graphics" }, "J", function() require('Utility.ActivityOption').cycleDebugDraw() end)
    if MOAIEnvironment.osBrand == "Windows" then
        DebugManager:addDebugOption( "Capture GPU Frame", { "Graphics", "Profiling" }, 269, DebugManager.captureGpuFrame )
        DebugManager:addDebugOption( "Capture full GPU Frame", { "Graphics", "Profiling" }, 270, DebugManager.captureFullGpuFrame )
    end
	DebugManager:addDebugOption( "Reload Shaders", { "Graphics" }, nil, DFGraphics.reloadAllShaders )
    local bSetToWarning = true
    for key, value in pairs( g_tTraceOutput ) do
        local realkey = _G[key]
        TT_ENABLED[realkey] = value
        if key == "TT_System" then
            bSetToWarning = not value
        end
    end
    if bSetToWarning then
        MOAILogMgr:setLogLevel( MOAILogMgr.LOG_WARNING )
    end
end
function DebugManager:onPointer(pointer, bDoubleTap)
	local bHandled = false
	return bHandled
end
function DebugManager:onKeyboard(key, down)
	if down then
        local tDbgOption = DebugManager.tDebugKeyBindings[key]
        DebugManager:executeDebugOptions(tDbgOption)
	end
end
function DebugManager:executeDebugOptions(tDbgOption)
    if tDbgOption ~= nil then
        if tDbgOption.callbackGet ~= nil then
            local val = tDbgOption.callbackGet()
            if tDbgOption.callbackOptions ~= nil then
                local minIdx = 10000
                local minVal = nil
                local bFound = false
                local tOptions = tDbgOption.callbackOptions()
                for i,value in pairs(tOptions) do
                    if bFound and val == nil then
                        val = value
                    end
                    if value == val and not bFound then
                        val = nil
                        bFound = true
                    end
                    if i < minIdx then
                        minIdx = i
                        minVal = value
                    end
                end
                if val == nil then
                    val = minVal
                end
            else
                val = not val
            end
            tDbgOption.callbackSet(val)
        else
            tDbgOption.callbackSet()
        end
    end
end
function DebugManager:getKeycode( hotKey )
    local keycode = hotKey
    local sKey = nil
    if hotKey ~= nil and type(hotKey) == "string" then
        sKey = hotKey
        keycode = string.byte(hotKey)
    end
    return keycode, sKey
end
function DebugManager:addDebugOption( sName, tCategories, hotKey, callbackSet, callbackGet, callbackOptions )
    assert(sName)
    assert(callbackSet)
    DebugManager:initialize()
    local keycode, sKey = DebugManager:getKeycode( hotKey )
    local tDbgOption = {}
    tDbgOption.sName = sName
    tDbgOption.tCategories = tCategories
    tDbgOption.sHotKey = sKey
    tDbgOption.hotKey = keycode
    tDbgOption.callbackGet = callbackGet
    tDbgOption.callbackSet = callbackSet
    tDbgOption.callbackOptions = callbackOptions
    table.insert(DebugManager.tDebugOptions, tDbgOption)
    if tDbgOption.hotKey ~= nil then
        if DebugManager.tDebugKeyBindings[tDbgOption.hotKey] ~= nil then
            local tPrevKey = DebugManager.tDebugKeyBindings[tDbgOption.hotKey]
            Trace(TT_Warning, string.format("Redefining debug key '%s'", tPrevKey))
        end
        DebugManager.tDebugKeyBindings[tDbgOption.hotKey] = tDbgOption
    end
    DebugManager.tCategoryCache= nil
    DebugManager.tOptionCache = nil
end
function DebugManager.toggleDebugMenu()
end
function DebugManager.startObjectLeakTracking()
    DebugManager.toggleDebugMenu()
    MOAISim.setLeakTrackingEnabled(true)
end
function DebugManager.reportObjectLeaks()
    DebugManager.toggleDebugMenu()
    MOAISim.reportLeaks(true, false)
end
function DebugManager.toggleLuaIoDebug()
    DataCache.tFlags.DebugIO = not DataCache.tFlags.DebugIO
end
function DebugManager.captureGpuFrame()
    local rDebugMenu = ScreenManager:getScreen("DebugMenu")
    if rDebugMenu ~= nil then
        ScreenManager:removeScreen(rDebugMenu)
    end
    Trace("Capturing GPU frame (w/o events)...")
    MOAIRenderMgr.captureGpuFrame( false )
end
function DebugManager.captureFullGpuFrame()
    local rDebugMenu = ScreenManager:getScreen("DebugMenu")
    if rDebugMenu ~= nil then
        ScreenManager:removeScreen(rDebugMenu)
    end
    Trace("Capturing GPU frame (w/ events)...")
    MOAIRenderMgr.captureGpuFrame( true )
end
return DebugManager
