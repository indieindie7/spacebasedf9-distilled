local m = {}

--- Root directory of the game distribution.
--- Includes trailing slash (if necessary).
--- This will most likely never change; we prefer to set the cwd consistently
--- if at all possible.
m.BASE_DIR = ""

--- Directory containing platform-specific data
--- Includes trailing slash (if necessary).
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
    -- there must be a better regex that avoids this first check for strings ending in "/".
    return (string.find(filePath, "/", -1) and filePath) or (string.match(filePath, "^(.+/)[^/]+$") or "")
end



-- Return path platform-agnostic data file
function m.getDataPath(fn)
    return string.format("%sData/%s", m.BASE_DIR, fn)
end

-- Return path platform-optimized data file
function m.getAssetPath(fn)
    return string.format("%sMunged/%s", m.PLAT_DIR, fn)
end

function m.getAudioPath(fn)
    return string.format("%sAudio/%s", m.PLAT_DIR, fn)
end


--
-- Deprecated -- don't add more of these if you can just use m.BASE_DIR
--

function m.getSpritePath(fn)
	return m.getAssetPath(fn)
end

-- MTF NOTE/TODO: deprecated.
-- Returns a path in the Data directory, incorrect for munged fonts.
function m.getFontPath(fn)
    return string.format("%sData/Fonts/%s", m.BASE_DIR, fn)
end

return m
