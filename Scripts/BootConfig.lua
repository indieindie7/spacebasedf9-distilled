local DFFile = require('DFCommon.File')
local DFUtil = require('DFCommon.Util')
local DFSaveLoad = require('DFCommon.SaveLoad')
local m = {}
local kCONFIG_FILENAME = "bootconfig.cfg"
local kDEFAULT_CONFIG =
{
    window_resolution_w = 1280,
    window_resolution_h = 720,
    show_blood = true,
    crash_reporting = true,
    autosave = true,
    use_compressed_textures = false,
    launch_fullscreen = true,
    use_os_mouse = true,
    posteffects = true,
    colorblind = false,
	normal_speed_on_alerts = true,
    pop_cap = 50,
    dev_mode = false,
    auto_start = false,
    low_ui = false,
    show_hints = true,
    disable_hostiles = false,
    disable_hostile_events = false,
    disable_docking = false,
    disable_meteors = false,
}
local kDEPRECATED_VALUES =
{
}
function m.init()
    local obj = {}
    if DFSpace.isDev() or MOAIEnvironment.osBrand == "Linux" then
        kDEFAULT_CONFIG.launch_fullscreen = false
    end
    if MOAIEnvironment.osBrand == "OSX" then
        kDEFAULT_CONFIG.use_compressed_textures = true
    end
    function obj:load()
        local tData = self:_loadConfig()
        if not tData then
            tData = kDEFAULT_CONFIG
        end
        self:_saveConfig(tData)
        m.tData = tData
    end
    function obj:_loadConfig()
        local sPath = DFSaveLoad._getSaveDir() .. kCONFIG_FILENAME
	print("loading config from file: " .. sPath)
        local dataBuffer = MOAIDataBuffer.new()
        dataBuffer:load( sPath )
        local jsonTable = dataBuffer:getString()
        local tData = MOAIJsonParser.decode( jsonTable )
        if tData then
            for k,v in pairs(kDEFAULT_CONFIG) do
                if nil == tData[k] then
                    tData[k] = v
                end
            end
            for k,v in pairs(kDEPRECATED_VALUES) do
                if tData[k] then
                    tData[k] = nil
                end
            end
        end
        return tData
    end
    function obj:_saveConfig(tData)
        local sPath = DFSaveLoad._getSaveDir() .. kCONFIG_FILENAME
        local jsonTable = MOAIJsonParser.encode( tData )
        local dataBuffer = MOAIDataBuffer.new()
        jsonTable = jsonTable:gsub(',', ',\n')
        jsonTable = jsonTable:gsub('{', '{\n ')
        jsonTable = jsonTable:gsub('}', '\n}')
        dataBuffer:setString( jsonTable )
        dataBuffer:save( sPath, false )
    end
    function obj:getConfigValue(sKey)
        return m.tData[sKey]
    end
    function obj:setConfigValue(sKey, newValue)
        m.tData[sKey] = newValue
        self:_saveConfig(m.tData)
    end
    obj:load()
    return obj
end
return m
