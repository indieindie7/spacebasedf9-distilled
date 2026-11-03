local m = {
}
function m._getSaveDir()
    local saveDir = MOAIEnvironment.documentDirectory .. "/Saves/"
     MOAIFileSystem.affirmPath(saveDir)
    return saveDir
end
return m
