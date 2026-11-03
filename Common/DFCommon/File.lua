local m = {}
m.BASE_DIR = ""
m.PLAT_DIR = ""
local _platDir
if MOAIEnvironment.osBrand == "iOS" or MOAIEnvironment.osBrand == "Android" then
	_platDir = ''
elseif MOAIEnvironment.osBrand == "OSX" then
	_platDir = 'OSX/'
elseif MOAIEnvironment.osBrand == "Windows" then
	_platDir = 'Win/'
elseif MOAIEnvironment.osBrand == "Linux" then
	_platDir = 'Linux/'
else
	print(string.format("Unknown OS %s; using Win!", MOAIEnvironment.osBrand))
	_platDir = 'Win/'
end
m.PLAT_DIR = m.BASE_DIR .. _platDir
_platDir = nil
function m.getSuffix(filePath)
    return string.match(filePath, "%.(%a+)$")
end
function m.stripSuffix(filePath)
    return string.gsub(filePath, "%.%a+$", "")
end
function m.stripFileName(filePath)
    return (string.find(filePath, "/", -1) and filePath) or (string.match(filePath, "^(.+/)[^/]+$") or "")
end
function m.getDataPath(fn)
    return string.format("%sData/%s", m.BASE_DIR, fn)
end
function m.getAssetPath(fn)
    return string.format("%sMunged/%s", m.PLAT_DIR, fn)
end
function m.getSpritePath(fn)
	return m.getAssetPath(fn)
end
function m.getFontPath(fn)
    return string.format("%sData/Fonts/%s", m.BASE_DIR, fn)
end
return m
