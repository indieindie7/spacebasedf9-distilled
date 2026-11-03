local DFFile = require('DFCommon.File')
local DataCache = require('DFCommon.DataCache')
local DFUtil = require('DFCommon.Util')
local LinecodeManager = {}
LinecodeManager.tFlags = {
	DebugOverrides = false,
}
function LinecodeManager.line( sLinecode, tReplacements )
    if not LinecodeManager.tData then
        Print(TT_Error, 'Linecode manager uninitialized.')
        return "UNINIT LINECODEMGR: " ..sLinecode
    elseif not sLinecode then
        return ""
    elseif LinecodeManager.tData[sLinecode] and LinecodeManager.tData[sLinecode].sLine then
        local sString = LinecodeManager.tData[sLinecode].sLine
        if tReplacements then
            for k,v in pairs(tReplacements) do
                sString = string.gsub( sString, '/'..k..'/', v )
            end
        end
        return sString
    else
        return "INVALID LINECODE: " ..sLinecode
    end
end
function LinecodeManager.randomLine(tLineCodes, tReplacements)
	return LinecodeManager.line(DFUtil.arrayRandom(tLineCodes), tReplacements)
end
function LinecodeManager.getTags( sLinecode )
	if sLinecode and LinecodeManager.tData[sLinecode].tTags then
		return LinecodeManager.tData[sLinecode].tTags
	end
end
function LinecodeManager.initialize( sLinecodeFile )
    LinecodeManager.tData = DataCache.getData( "linecode", DFFile.getDataPath( sLinecodeFile ) )
    return LinecodeManager
end
return LinecodeManager
