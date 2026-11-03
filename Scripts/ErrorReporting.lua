local DFUtil=require('DFCommon.Util')
local ErrorReporting = {}
ErrorReporting.bEnabled = false
ErrorReporting.bUserLocalServer = false
ErrorReporting.LOCAL_URL = "http://localhost:8089/error"
ErrorReporting.PROD_URL = "http://dfp-space.appspot.com/error"
ErrorReporting.URL = ErrorReporting.PROD_URL
if ErrorReporting.bUserLocalServer then
    ErrorReporting.URL = ErrorReporting.LOCAL_URL
end
function ErrorReporting.init()
    if ErrorReporting.bEnabled then
        local function onError(message)
            if not g_Config:getConfigValue("crash_reporting") then return end
            MOAISim.setTraceback(function(message) end)
            local errorLogBuffer = MOAIDataBuffer.new()
            errorLogBuffer:base64Encode(message)
            local stackTrace = tostring(debug.traceback())
            local abbrevStackLen = math.min(#stackTrace, 384)
            local abbrevStackTrace = string.sub(stackTrace, 0, abbrevStackLen)
            local stackBuffer = MOAIDataBuffer.new()
            stackBuffer:base64Encode(abbrevStackTrace)
            local errorVars = {}
            errorVars.buildId = MOAIEnvironment.appVersion
            local sExtraLogString = ""
            if MOAIEnvironment.appVersion then
                sExtraLogString = sExtraLogString .. "appVersion: "..MOAIEnvironment.appVersion.." "
            end
            if MOAIEnvironment.appBuild then
                sExtraLogString = sExtraLogString .. "appBuild: "..MOAIEnvironment.appBuild.." "
            end
            if MOAIEnvironment.devBrand then
                sExtraLogString = sExtraLogString .. "devBrand: "..MOAIEnvironment.devBrand.." "
            end
            if MOAIEnvironment.devName then
                sExtraLogString = sExtraLogString .. "devName: "..MOAIEnvironment.devName.." "
            end
            if MOAIEnvironment.devManufacturer then
                sExtraLogString = sExtraLogString .. "devManufacturer: "..MOAIEnvironment.devManufacturer.." "
            end
            if MOAIEnvironment.devModel then
                sExtraLogString = sExtraLogString .. "devModel: "..MOAIEnvironment.devModel.." "
            end
            if MOAIEnvironment.osVersion then
                sExtraLogString = sExtraLogString .. "osVersion: "..MOAIEnvironment.osVersion.." "
            end
            errorVars.log = message.." "..sExtraLogString
            errorVars.stack = abbrevStackTrace
            errorVars.type = "lua"
            local errorUrl = ErrorReporting.URL .. "?"
            errorUrl = errorUrl .. "&buildId=" .. errorVars.buildId
            errorUrl = errorUrl .. "&log=" .. errorVars.log
            errorUrl = errorUrl .. "&stack=" .. errorVars.stack
            errorUrl = errorUrl .. "&type=" .. errorVars.type
            local errorVarsString = MOAIJsonParser.encode(errorVars)
            local errorBuffer = MOAIDataBuffer.new()
            errorBuffer:base64Encode(errorVarsString)
            print("errorVarsString:\n\n" .. errorVarsString .. "\n\n")
            local httpTask = MOAIHttpTask.new()
            print("new task!")
            local errorBufferString = errorBuffer:getString()
            print("fully encoded buffer: " .. errorBufferString)
            httpTask:httpPost(ErrorReporting.URL, errorBufferString, nil, nil, true)
            print("posting nowwwww")
            DFUtil.timedCallback(4, MOAIAction.ACTIONTYPE_UI, nil, function() MOAISim.crash() end)
        end
        MOAISim.setTraceback(onError)
    end
end
return ErrorReporting
