local LuaGrid = require('LuaGrid')
kDEBUG_MODE_NONE = 0
kDEBUG_MODE_CHAR = 1
kDEBUG_MODE_ROOM = 2
kDEBUG_MODE_PROP = 3
kDEBUG_MODE_LIGHT = 4
kDEBUG_MODE_LAST = kDEBUG_MODE_LIGHT
local DebugInfoManager = {}
DebugInfoManager.kDEBUG_PAGE_STATS = 0
DebugInfoManager.kDEBUG_PAGE_MORALE_NEEDS = 1
DebugInfoManager.kDEBUG_PAGE_AFFINITY = 2
DebugInfoManager.kDEBUG_PAGE_DECISION = 3
DebugInfoManager.kDEBUG_PAGE_TASK = 4
DebugInfoManager.kDEBUG_PAGE_LAST = DebugInfoManager.kDEBUG_PAGE_TASK
DebugInfoManager.kDEBUG_PAGE_FIRST = DebugInfoManager.kDEBUG_PAGE_STATS
DebugInfoManager.drawSelectedDebug = false
DebugInfoManager.nDebugMode = kDEBUG_MODE_NONE
DebugInfoManager.nDebugInfoPage = DebugInfoManager.kDEBUG_PAGE_STATS
DebugInfoManager.tDebugInfoBoxes = {}
DebugInfoManager.profilerName='DebugInfoManager'
local ObjectList = nil
function DebugInfoManager.cycleInfoPage()
    DebugInfoManager.nDebugInfoPage = DebugInfoManager.nDebugInfoPage + 1
    if DebugInfoManager.nDebugInfoPage > DebugInfoManager.kDEBUG_PAGE_LAST then
        DebugInfoManager.nDebugInfoPage = DebugInfoManager.kDEBUG_PAGE_FIRST
    end
end
function DebugInfoManager.init()
    ObjectList = require('ObjectList')
    DebugInfoManager.debugColorGrid = LuaGrid.new()
    DebugInfoManager.debugColorGrid:initDiamondGrid(g_World.width, g_World.height, g_World.tileWidth, g_World.tileHeight)
    DebugInfoManager.debugColorGrid:fill(0)
    DebugInfoManager.debugTexture = nil
end
function DebugInfoManager.onTick( dt )
    if not #DebugInfoManager.tDebugInfoBoxes then
        return
    end
    for _,box in pairs(DebugInfoManager.tDebugInfoBoxes) do
        box:refresh()
    end
end
return DebugInfoManager
