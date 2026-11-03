local function _h1(a0,a1) return {names=a0,layer=a1} end
local World = require('WorldConstants')
local DFGraphics = require('DFCommon.Graphics')
local Delegate = require('DFMoai.Delegate')
local DFMath = require('DFCommon.Math')
local DFUtil = require('DFCommon.Util')
local Renderer = require('Renderer')
local Zone = require('Zones.Zone')
local ObjectList = require('ObjectList')
local Asteroid = require('Asteroid')
local MiscUtil = require('MiscUtil')
local Environment = require('Environment.Environment')
local GridUtil = require('GridUtil')
local LuaGrid = require('LuaGrid')
local Base = nil
local Gui = require('UI.Gui')
local Room = nil
local Turret = nil
local Fire = nil
local Character = nil
local EnvObject = nil
local WorldObject = nil
local Oxygen = nil
local Lighting = nil
local CommandObject = nil
local Door = nil
local GameRules = nil
local Pathfinder = nil
local GlobalObjects = nil
local SAVE_TYPES={ObjectList.ROOM, ObjectList.ENVOBJECT, ObjectList.CHARACTER, ObjectList.RESERVATION}
World.pathGrid=nil
World.roomGrid=nil
World.cursorTiles = {}
World.dragValid = true
World.dragCost = 0
World.dirtyVisualTiles = {}
World.props = {}
World.tilesToExplore={}
World.tileDetails={}
World.tileHealth={}
World.lifeSupportTiles = 0
World.gardenTiles = 0
World.floorDecals = {}
World.wallDecals = {}
World.doorSpriteName = 'base01'
World.fogRoofSpriteName = 'rooftest'
World.layers = {
        space = {
            layer='Space',
            spritePath = 'Environments/Tiles/Space',
            gridIndexer=false,
        },
        buildGrid = {
            layer = 'BuildGrid',
            spritePath = 'UI/Cursor',
            gridIndexer=true,
            offsetZ=15,
        },
        worldFloor = {
            layer='WorldFloor',
            spritePath = 'Environments/Tiles/Floor',
            gridIndexer=true,
            priority=0,
            useWorldLightShader=true,
        },
        worldFloorDecal = {
            layer='WorldFloor',
            spritePath = 'Environments/Tiles/Floor',
            gridIndexer=true,
            useWorldLightShader=false,
            offsetZ=5,
        },
        worldWall = {
            layer='WorldWall',
            spritePath = 'Environments/Tiles/Wall',
        },
        worldCeiling = {
            layer='WorldCeiling',
            spritePath = 'Environments/Tiles/Wall',
        },
        cursor = {
            layer='Cursor',
            spritePath = 'UI/Cursor',
            gridIndexer=true,
            offsetZ=25,
        },
    }
World.analysisPropLayer='WorldAnalysis'
World.analysisSpritePath='Environments/Tiles/Floor'
World.background = {
        spritePath = 'Backgrounds/Backgrounds',
        spriteNames = { 'nebula01' },
        layer = 'Background',
}
function World.getOppositeDirection(d)
    if d == World.directions.SAME then
        return World.directions.SAME
    elseif d == World.directions.NW then
        return World.directions.SE
    elseif d == World.directions.NE then
        return World.directions.SW
    elseif d == World.directions.SW then
        return World.directions.NE
    elseif d == World.directions.SE then
        return World.directions.NW
    elseif d == World.directions.W then
        return World.directions.E
    elseif d == World.directions.E then
        return World.directions.W
    elseif d == World.directions.N then
        return World.directions.S
    elseif d == World.directions.S then
        return World.directions.N
    else
        assert(false)
    end
end
function World.getPerpindicularDirection(d)
    if d == World.directions.SAME then
        return World.directions.SAME
    elseif d == World.directions.NW then
        return World.directions.NE
    elseif d == World.directions.NE then
        return World.directions.NW
    elseif d == World.directions.SW then
        return World.directions.SE
    elseif d == World.directions.SE then
        return World.directions.SW
    elseif d == World.directions.W then
        return World.directions.N
    elseif d == World.directions.E then
        return World.directions.S
    elseif d == World.directions.N then
        return World.directions.W
    elseif d == World.directions.S then
        return World.directions.E
    else
        assert(false)
    end
end
function World.getCardinalOrOrdinalDirectionToVector(x,y)
    if x==0 and y==0 then return World.directions.SAME end
    local sourceLength = math.sqrt(x*x+y*y)
    local similarity, direction
    local vecs = World.directionVectors
    local nTests = #vecs
    for i=2,nTests do
        local x0,y0 = vecs[i][1],vecs[i][2]
        if x0 ~= 0 or y0 ~= 0 then
            local currentSimilarity = (x*x0+y*y0) / ( sourceLength * (math.sqrt(x0*x0+y0*y0)))
            if not similarity or currentSimilarity < similarity then
                similarity = currentSimilarity
                direction = i
            end
        end
    end
    return direction and World.oppositeDirections[direction]
end
local tSpaceNames = {
    "The Void",
    "Cold, Empty Space",
    "Blackness",
    "Nothing",
    "The Abyss",
    "Everything & Nothing",
    "The Infinite",
    "Outer Space",
    "Space",
    "The Final Frontier",
    "Naught",
    "Nobody Can Hear You Scream Here",
    "The Universe",
    "Emptiness",
    "Darkness",
}
World.visualTiles = {
    wall_error = _h1({ 'wall_block_temp' }, World.layers.worldWall),
    space = _h1({ 'stars_test', }, World.layers.space),
    cursor = _h1({ 'ISO_build_YES', }, World.layers.cursor),
    cursor_dragbox = _h1({ 'ISO_build_YES', }, World.layers.cursor),
    cursor_dragbox_invalid = _h1({ 'ISO_build_NO', }, World.layers.cursor),
    cursor_door = _h1({ 'build_door', }, World.layers.cursor),
    build_grid_square = _h1({ 'ISO_build_grid', }, World.layers.buildGrid),
    build_grid_square_bright = _h1({ 'ISO_build_grid_bright', }, World.layers.buildGrid),
    build_grid_square_bright_xaxis = _h1({ 'ISO_build_grid_bright_xaxis', }, World.layers.buildGrid),
    build_grid_square_bright_yaxis = _h1({ 'ISO_build_grid_bright_yaxis', }, World.layers.buildGrid),
}
local _X_OFFSET   = { 0,    0, 1, 0, 1, 0, 1, 0,-1 }
local _Y_OFFSET   = { 0,    1, 1,-1,-1, 2, 0,-2, 0 }
local _NEED_XLEFT = { 0,    1, 1, 1, 1, 0, 0, 0, 0 }
function World._getAdjacentTile(x,y,d)
    local xLeft = - (y % 2)
    return (x + xLeft * _NEED_XLEFT[d] + _X_OFFSET[d]), (y + _Y_OFFSET[d]),1
end
local _getAdjacentTile = World._getAdjacentTile
function World.getBounds()
    local w,h = .5*World.width*World.tileWidth,.5*World.height*World.tileHeightH
    return -w,-h,w,h
end
function World.isInBounds(wx,wy)
    if not wx or not wy then return false end
    local x0,y0,x1,y1 = World.getBounds()
    return wx>=x0 and wx<=x1 and wy>=y0 and wy<=y1
end
function World._isInBounds(tx,ty,bNotSafe)
    if not tx or not ty then return false end
    local x0,y0,x1,y1 = World.getTileBounds(bNotSafe)
    return tx>=x0 and tx<=x1 and ty>=y0 and ty<=y1
end
function World.clampToBounds(wx,wy,bNotSafe)
    local x0,y0,x1,y1=World.getBounds()
    if not bNotSafe then
        local offset = World.CHARACTER_SAFETY_TOLERANCE * World.tileWidth
        x0,y0,x1,y1 = x0+offset,y0+offset,x1-offset,y1-offset
    end
    return DFMath.clamp(wx or 0, x0, x1), DFMath.clamp(wy or 0, y0, y1)
end
function World.getTileBounds(bNotSafe)
    local x0,y0,x1,y1 = 1,1,World.width,World.height
    if not bNotSafe then x0,y0,x1,y1 = x0+World.CHARACTER_SAFETY_TOLERANCE,y0+World.CHARACTER_SAFETY_TOLERANCE,x1-World.CHARACTER_SAFETY_TOLERANCE,y1-World.CHARACTER_SAFETY_TOLERANCE end
    return x0,y0,x1,y1
end
function World.clampTileToBounds(tx,ty,bNotSafe)
    local x0,y0,x1,y1 = World.getTileBounds(bNotSafe)
    return DFMath.clamp(tx, x0, x1), DFMath.clamp(ty, y0, y1)
end
function World._createGrid(layerName, spritePath, bUseWorldLightShader, nOffsetZ)
    local grid = LuaGrid.new()
    grid:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight)
    local spriteSheet = Renderer.loadSpriteSheet(spritePath, false, false, true)
    local prop = MOAIProp.new()
    prop:setDeck(spriteSheet)
    if bUseWorldLightShader then
        prop:setGrid(grid:getMOAIGrid(), true)
        local rMaterial = Renderer.getGlobalMaterial("worldLight")
        prop:setMaterial(rMaterial)
    else
        prop:setGrid(grid:getMOAIGrid())
    end
    prop:setLoc(-World.width*World.tileWidth*.5, -World.height*World.tileHeightH*.5, nOffsetZ or 0)
    Renderer.getRenderLayer(layerName):insertProp(prop)
    return grid, spriteSheet, prop
end
function World.getWorldRenderLayer()
    return Renderer.getRenderLayer('WorldFloor')
end
function World._zoneAtAddr(addr)
    local tileX,tileY = World.pathGrid:cellAddrToCoord(addr)
    local tileVal = World.pathGrid:getTileValue(tileX,tileY)
    return Zone.tOrderedZoneList[tileVal - World.logicalTiles.ZONE_LIST_START + 1]
end
function World._zoneValue(tileVal)
    return Zone.tOrderedZoneList[tileVal - World.logicalTiles.ZONE_LIST_START + 1]
end
function World._setZoneAtAddr(addr, zoneName)
    local tileX, tileY = World.pathGrid:cellAddrToCoord(addr)
    if not World.countsAsFloor(World.pathGrid:getTileValue(tileX,tileY)) then
        Print(TT_Warning,'Attempt to set non-floor to zone',zoneName)
    else
        World._setTile(tileX, tileY, World.logicalTiles[zoneName])
    end
end
function World.init(width, height, tileWidth, tileHeight)
    Room = require('Room')
    Turret = require('EnvObjects.Turret')
    Base = require('Base')
    Character = require('Character')
    Fire = require('Fire')
    EnvObject = require('EnvObjects.EnvObject')
    WorldObject = require('WorldObjects.WorldObject')
    Oxygen = require('Oxygen')
    Lighting = require('Lighting')
    CommandObject = require('Utility.CommandObject')
    GameRules = require('GameRules')
    Pathfinder = require('Pathfinder')
    Door = require('EnvObjects.Door')
    GlobalObjects = require('Utility.GlobalObjects')
    World.dTileChanged = Delegate.new()
    World.tWallAddrToBlob={}
    World.tDirtyWallTiles={}
    Zone.initZoneData()
    ObjectList.init()
    EnvObject.globalInit()
    WorldObject.globalInit()
    Room.reset()
	Turret.reset()
    CommandObject.staticInit()
    Oxygen.reset()
    Fire.reset()
    Door.reset()
    require('Projectile').reset()
    GlobalObjects.reset()
    for idx,val in ipairs(Zone.tOrderedZoneList) do
        World.logicalTiles[val] = World.logicalTiles.ZONE_LIST_START - 1 + idx
        World.logicalTiles.ZONE_LIST_END = World.logicalTiles.ZONE_LIST_START - 1 + idx
    end
    World.tileHealth = {}
    World.floorDecals = {}
    World.wallDecals = {}
    World.width = width
    World.height = height
    World.tileWidth = tileWidth
    World.tileHeight = tileHeight
    World.tileHeight2 = 2*tileHeight
    World.tileHeightH = .5*tileHeight
    World.cursorTiles = {}
    World.dirtyVisualTiles = { dirtyList = {} }
	World.tilesToExplore = {}
    World.tWalls = {}
    World.tAsteroids = {}
    World.layers[1] = World.layers.space
    World.layers[2] = World.layers.worldFloor
    World.layers[3] = World.layers.worldFloorDecal
    World.layers[4] = World.layers.buildGrid
    World.layers[5] = World.layers.worldWall
    World.layers[6] = World.layers.worldCeiling
    World.layers[7] = World.layers.cursor
    World.pathGrid = LuaGrid.new()
    World.pathGrid:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight)
    World.roomGrid = LuaGrid.new()
    World.roomGrid:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight)
    for i,layer in ipairs(World.layers) do
        if layer.gridIndexer then
            layer.grid, layer.spriteSheet, layer.prop = World._createGrid(layer.layer, layer.spritePath, layer.useWorldLightShader, layer.offsetZ)
            if layer.priority ~= nil then
                layer.prop:setPriority(layer.priority)
            end
        else
            layer.grid = LuaGrid.new()
            layer.grid:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight)
            layer.spriteSheet = Renderer.loadSpriteSheet(layer.spritePath, false, false, false)
            layer.props = {}
            layer.renderLayer = Renderer.getRenderLayer(layer.layer)
            layer.originX,layer.originY = -World.width*World.tileWidth*.5, -World.height*World.tileHeightH*.5
        end
    end
    World.oxygenGrid = LuaGrid.new('DFOxygenGrid')
    World.oxygenGrid:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight)
    World.oxygenGrid:getMOAIGrid():setVisualizationColors(Gui.RED[1],Gui.RED[2],Gui.RED[3],Gui.GREEN[1],Gui.GREEN[2],Gui.GREEN[3])
    World.oxygenGrid:fill(0)
    Pathfinder.staticInit()
    World.analysisGrid, World.analysisSpriteSheet, World.analysisProp = World._createGrid(World.analysisPropLayer, World.analysisSpritePath)
    Renderer.getRenderLayer(World.analysisPropLayer):removeProp(World.analysisProp)
    World.analysisGrid:fill(World.analysisSpriteSheet.names['oxy_debug'])
    World.fireGrid = LuaGrid.new()
    World.fireGrid:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight)
    for tile,data in pairs(World.visualTiles) do
        data.indexes = {}
        for i,name in ipairs(data.names) do
            table.insert(data.indexes, data.layer.spriteSheet.names[name])
        end
        data.index = data.indexes[1]
    end
    World.layers.space.grid:fill(World.visualTiles.space.index)
    local pathFlags = 0
    World.pathGrid:fill(World.logicalTiles.SPACE)
    GridUtil.PopulateTileLookup()
end
function World.setAnalysisPropEnabled(bEnabled,rGrid)
    if bEnabled then
        World.analysisProp:setColorGrid(rGrid:getMOAIGrid())
        World.rCurrentColorGrid = rGrid
        rGrid:setDebugColorsEnabled(true)
        Renderer.getRenderLayer(World.analysisPropLayer):insertProp(World.analysisProp)
    else
        World.analysisProp:setColorGrid(nil)
        if World.rCurrentColorGrid then
            World.rCurrentColorGrid:setDebugColorsEnabled(false)
            World.rCurrentColorGrid = nil
        end
        Renderer.getRenderLayer(World.analysisPropLayer):removeProp(World.analysisProp)
    end
end
function World.shutdown()
    World.bSuspendFixupVisuals = true
    CommandObject.shutdown()
    EnvObject.globalShutdown()
    WorldObject.globalShutdown()
    Environment.shutdown()
    local tObj = ObjectList.tObjList
    World.setAnalysisPropEnabled(false)
    World.pathGrid = nil
    World.fireGrid = nil
    World.roomGrid = nil
    World.oxygenGrid = nil
    World.tileHealth = nil
    local rLightLayer = Renderer.getRenderLayer('Light')
    for i,layer in ipairs(World.layers) do
        if layer.prop then
            Renderer.getRenderLayer(layer.layer):removeProp(layer.prop)
            layer.prop = nil
        end
        if layer.props then
            for _,v in pairs(layer.props) do
                for _,rProp in pairs(v) do
                    layer.renderLayer:removeProp(rProp)
                    rLightLayer:removeProp(rProp)
                end
            end
            layer.props = nil
        end
        layer.grid = nil
        DFGraphics.unloadSpriteSheet(layer.spriteSheet)
    end
    World.cursorTiles = {}
    World.dirtyVisualTiles = {}
    World.bSuspendFixupVisuals = false
end
function World.saveOtherTypes(saveData, worldXOff,worldYOff)
    for _,objType in ipairs(ObjectList.tSaveTypes) do
        saveData[objType] = {}
        local tTags = ObjectList.getTagsOfType(objType)
        for _,objData in pairs(tTags) do
            local tag = objData.tag
            local tData = ObjectList.getSaveTable(objType,tag,worldXOff,worldYOff)
            if tData then
                assert(tData._ObjectList_ObjectMarker.objType == objType)
                table.insert(saveData[objType], tData)
            end
        end
    end
    saveData.fire = require('Fire').getSaveTable(worldXOff,worldYOff)
    saveData.commandObject = CommandObject.getSaveTable(worldXOff,worldYOff)
    if not worldXOff then
        saveData.environment = Environment.getSaveTable()
    end
    saveData.oxygenGrid = World.oxygenGrid:getSaveData()
    for _,objType in ipairs(ObjectList.tSaveTypes) do
        for i,v in ipairs(saveData[objType]) do
            assert(not v._ObjectList_ObjectMarker or v._ObjectList_ObjectMarker.objType == objType)
        end
    end
end
function World.getSaveData()
    local saveData = {
		tilesToExplore={},
    }
    saveData.tileHealth = World.tileHealth
    saveData.floorDecals = World.floorDecals
    saveData.pathGrid = World.pathGrid:getSaveData()
    World.saveOtherTypes(saveData)
	for k,v in pairs(World.tilesToExplore) do
		table.insert(saveData.tilesToExplore, {k=k,x=v.x,y=v.y})
	end
    return saveData
end
function World._updatePathGridDbgColor(tx,ty,bUnpathable)
    if not World.bPathGridVisualize then return end
    local addr = World.pathGrid:getCellAddr(tx,ty)
    local tTag = Pathfinder.tTaggedTiles[addr]
    local bSoftUnpathable = false
    if tTag and tTag.tTagSpec.fnSoftLock and tTag.tTagSpec.fnSoftLock(tTag.tTagSpec,tTag.tAdditionalData) then
        bSoftUnpathable=true
    end
    local bReserved = ObjectList.getReservationAt(tx,ty) ~= nil
    local color = {0,0,0,0}
    if bUnpathable then color = {1,0,0,1}
    elseif bSoftUnpathable then color = {1,0,1,1}
    elseif tTag then color = {0,1,0,1}
    elseif bReserved then color = {0,0,1,1} end
	World.pathGrid:setTileColor(tx,ty,unpack(color))
end
function World.loadModule(nSavegameVersion, saveData, worldXOff, worldYOff, nNewTeamFactionBehavior)
    World.bLoadingGame=true
    World.bLoadingModule=true
    World.bSuspendFixupVisuals = true
	worldXOff,worldYOff = worldXOff-saveData.worldMinX,worldYOff-saveData.worldMinY
    if not saveData.pathGrid.rGrid then
        saveData.pathGrid = LuaGrid.fromSaveData(saveData.pathGrid, false, {nDefaultVal=World.logicalTiles.SPACE})
    end
    if not saveData.oxygenGrid.rGrid then
        saveData.oxygenGrid = LuaGrid.fromSaveData(saveData.oxygenGrid, false, {nDefaultVal=0,sGridClass='DFOxygenGrid'})
    end
    local nTeam = Character.TEAM_ID_PLAYER
    if nNewTeamFactionBehavior then
        nTeam = Base.createNewTeamID(nNewTeamFactionBehavior)
    end
    World.tileHealth = saveData.tileHealth or {}
	for x=saveData.minX,saveData.maxX do
		for y=saveData.minY,saveData.maxY do
			local tileVal = saveData.pathGrid:getTileValue(x,y)
            local srcAddr = World.pathGrid:getCellAddr(x,y)
			local wx,wy = World._getWorldFromTile(x,y)
			local newTileX,newTileY = World._getTileFromWorld(wx+worldXOff,wy+worldYOff)
            if tileVal > World.logicalTiles.SPACE then
			    World._setTile(newTileX,newTileY,tileVal,true,false)
                local rChar = ObjectList.getObjAtTile(newTileX,newTileY,ObjectList.CHARACTER)
                if rChar and rChar:spacewalking() then
                    rChar:setElevatedSpacewalk(true)
                end
                World.oxygenGrid:setTileValue(newTileX,newTileY, saveData.oxygenGrid:getTileValue(x,y))
                if saveData.oxygenGrid:checkTileFlag(x,y, DFOxygenGrid.TILE_OCCLUDE) then
                    World.oxygenGrid:setTileFlag(newTileX,newTileY, DFOxygenGrid.TILE_OCCLUDE)
                end
                if saveData.oxygenGrid:checkTileFlag(x,y, DFOxygenGrid.TILE_INDOORS) then
                    World.oxygenGrid:setTileFlag(newTileX,newTileY, DFOxygenGrid.TILE_INDOORS)
                end
                World.oxygenGrid:setOxygen(newTileX,newTileY, saveData.oxygenGrid:getOxygen(x,y))
			    World._dirtyTile(newTileX,newTileY,true)
                if saveData.floorDecals and saveData.floorDecals[srcAddr] then
                    local t = saveData.floorDecals[srcAddr]
                    World.setFloorDecal(newTileX,newTileY,t.sDecal,t.tColor)
                end
            end
		end
	end
    World.loadOtherTypes(nSavegameVersion, saveData, worldXOff, worldYOff, nTeam)
    if not nTeam or nTeam == Character.TEAM_ID_PLAYER then
        CommandObject.fromSaveTable(saveData.commandObject, worldXOff, worldYOff, true)
    end
    World.bSuspendFixupVisuals = false
    World.bLoadingGame=true
    World.bLoadingModule=true
    return nTeam
end
function World.loadOtherTypes(nSavegameVersion, saveData, worldXOff, worldYOff, nTeam)
    for i=1,#SAVE_TYPES do
        for _,objType in ipairs(ObjectList.tSaveTypes) do
            if objType == SAVE_TYPES[i] and saveData[objType] then
                for _,t in ipairs(saveData[objType]) do
                    if t._ObjectList_ObjectMarker then
                        assertdev(t._ObjectList_ObjectMarker.objType == objType)
                    end
                    local obj = ObjectList.loadFromSaveTable(objType,t,worldXOff,worldYOff,nTeam)
                    if obj and nSavegameVersion < 7 and objType == ObjectList.CHARACTER then
                        obj:generateStartingStuff()
                    end
                end
            end
        end
    end
    if not worldXOff then
        Environment.fromSaveTable(saveData.environment)
    end
    Fire.fromSaveTable(saveData.fire, worldXOff,worldYOff, nTeam)
    require('CharacterManager').updateOwnedCharacters()
end
function World.setPathGridVisualize(bVis)
    if bVis == World.bPathGridVisualize then
        return
    end
    World.bPathGridVisualize = bVis
    World.setAnalysisPropEnabled(bVis,World.pathGrid)
    if bVis then
        for x=1,World.width do
            for y=1,World.height do
                World._updatePathGridDbgColor(x,y,World.pathGrid:checkTileFlag(x,y,MOAIGridSpace.TILE_HIDE))
            end
        end
    end
end
function World.loadSaveData(nSavegameVersion, saveData)
    World.bSuspendFixupVisuals = true
    World.bLoadingGame=true
    World.tileHealth = saveData.tileHealth or {}
    print('a')
    World.roomGrid:fill(0)
    World.pathGrid = LuaGrid.fromSaveData(saveData.pathGrid, false, {nDefaultVal=World.logicalTiles.SPACE})
    local tTiles = World.pathGrid.tTiles
    for addr,_ in pairs(tTiles) do
        if not World._isInBounds(World.pathGrid:cellAddrToCoord(addr)) then
            tTiles[addr] = nil
        end
    end
    World.oxygenGrid = LuaGrid.fromSaveData(saveData.oxygenGrid, false, {nDefaultVal=0,sGridClass='DFOxygenGrid'})
    World.oxygenGrid:getMOAIGrid():setVisualizationColors(Oxygen.COLOR_LOW[1],Oxygen.COLOR_LOW[2],Oxygen.COLOR_LOW[3],Oxygen.COLOR_HIGH[1],Oxygen.COLOR_HIGH[2],Oxygen.COLOR_HIGH[3])
    World.oxygenGrid:getMOAIGrid():clearGenerators()
    Pathfinder.staticInit()
    for x=1,World.width do
        for y=1,World.height do
            World._dirtyTile(x,y,true)
        end
    end
    print('b')
    World.loadOtherTypes(nSavegameVersion, saveData)
    print('c')
	World.tilesToExplore = {}
	if saveData.tilesToExplore then
		for _,v in ipairs(saveData.tilesToExplore) do
			World.tilesToExplore[v.k] = {x=v.x,y=v.y}
		end
	end
    print('d')
    World.bSuspendFixupVisuals = false
    World.bLoadingGame=false
    World.fixupVisuals()
        CommandObject.fromSaveTable(saveData.commandObject, nil,nil, true)
    if saveData.floorDecals then
        for addr,t in pairs(saveData.floorDecals) do
            World.setFloorDecal(t.tx,t.ty,t.sDecal,t.tColor)
        end
    end
    print('f')
end
function World.updateSavegame(nSavegameVersion, saveData)
    Character.updateSavegame(nSavegameVersion, saveData[ObjectList.CHARACTER])
end
function World.getHackySortingZ(x,y,skipTileJustification)
    if not skipTileJustification then
        x,y = World.getTileJustifiedWorldPos(x,y)
    end
    local z = -y-World.height*World.tileHeightH*.5
    return z
end
function World.onTick(dt)
    for tileAddr,tHealthDetails in pairs(World.tileHealth) do
        if tHealthDetails.nHitPoints > 0 and tHealthDetails.nHitPoints < World.TILE_STARTING_HIT_POINTS then
            tHealthDetails.nHitPoints = math.min(tHealthDetails.nHitPoints + (World.TILE_HEAL_OVER_TIME * dt), World.TILE_STARTING_HIT_POINTS)
            local nHitPointPct = tHealthDetails.nHitPoints / World.TILE_STARTING_HIT_POINTS
            tHealthDetails.nHealth = math.floor(nHitPointPct * World.TILE_DAMAGE_HEALTHY)
        end
        World.updateHealthVisuals(tileAddr, tHealthDetails)
    end
    World.fixupVisuals()
end
function World.updateHealthVisuals(tileAddr, tHealthDetails)
    if tHealthDetails.nHitPoints <= 0 or tHealthDetails.nHitPoints >= World.TILE_STARTING_HIT_POINTS then
        if World.floorDecals[tileAddr] then
            local tx,ty = World.pathGrid:cellAddrToCoord(tileAddr)
            World.setFloorDecal(tx,ty,nil)
        end
        if World.wallDecals[tileAddr] then
            local tx,ty = World.pathGrid:cellAddrToCoord(tileAddr)
            World.setWallDecal(tx,ty,nil)
        end
        World.tileHealth[tileAddr] = nil
    else
        local tx,ty = World.pathGrid:cellAddrToCoord(tileAddr)
        if World.countsAsFloor(World._getTileValue(tx,ty)) then
            local tDecal = World.floorDecals[tileAddr]
            if tDecal then
                local pct = 1-math.max(math.min(tHealthDetails.nHitPoints / World.TILE_STARTING_HIT_POINTS,1),0)
                World.layers.worldFloorDecal.grid:setTileColor(tDecal.tx, tDecal.ty, pct,pct,pct,pct)
            else
                World.setFloorDecal(tx,ty, "char03")
            end
        else
            local tDecal = World.wallDecals[tileAddr]
            if tDecal then
                local rDecal = tDecal.tPropTable and tDecal.tPropTable['decal']
                if rDecal then
                    local pct = 1-math.max(math.min(tHealthDetails.nHitPoints / World.TILE_STARTING_HIT_POINTS,1),0)
                    rDecal:setColor(pct,pct,pct,pct)
                end
            else
                World.setWallDecal(tx,ty, "Damage")
            end
        end
    end
end
function World.setFloorDecal(tx,ty,sDecal,tColor)
    local addr = World.pathGrid:getCellAddr(tx,ty)
    if not sDecal then
        World.floorDecals[addr] = nil
        World.layers.worldFloorDecal.grid:setTileValue(tx,ty,0)
    else
        local tDecal = {}
        tDecal.tx = tx
        tDecal.ty = ty
        tDecal.sDecal=sDecal
        tDecal.tColor = tColor or {1.0, 1.0, 1.0, 1.0}
        World.floorDecals[addr] = tDecal
        local nSplat = World.layers.worldFloorDecal.spriteSheet.names[sDecal]
        World.layers.worldFloorDecal.grid:setTileValue(tx, ty, nSplat)
        World.layers.worldFloorDecal.grid:setTileColor(tx, ty, unpack(tDecal.tColor))
    end
end
function World.setWallDecal(tx,ty,sDecal)
    local tProp = World._getGridProp(World.layers.worldWall, tx, ty)
    if tProp and tProp.top then
        local addr = World.pathGrid:getCellAddr(tx,ty)
        if not sDecal then
            local oldProp = tProp.decal
            if oldProp then
                World._removeWallProp(World.layers.worldWall, tProp, "decal")
            end
            tProp.decal = nil
            World.wallDecals[addr] = nil
        else
            local dir = World._getWallDirection(tx,ty)
            local sDirection = ""
            if dir == World.wallDirections.NESW or dir == World.wallDirections.NWSE then
                sDirection = "Straight01"
            elseif dir == World.wallDirections.V then
                sDirection = "Corner_outer01"
            elseif dir == World.wallDirections.GREATERTHAN then
                sDirection = "Corner_rb"
            elseif dir == World.wallDirections.LESSTHAN then
                sDirection = "Corner_lb"
            else
                sDirection = "Corner_inner01"
            end
            sDecal = sDecal .. "_" .. sDirection .. "_top"
            local top = tProp.top
            local topLocX,topLocY,topLocZ = top:getLoc()
            local tDetails = World._getWallTileDetails(tx, ty)
            local nSplat = World.layers.worldWall.spriteSheet.names[sDecal]
            World.wallDecals[addr] = {tx=tx,ty=ty,tPropTable=tProp}
            World._addWallSpriteToTable(World.layers.worldWall, tProp, tx, ty, 'decal', nSplat, tDetails.bFlip)
        end
    end
end
function World.getTargetLoc(wx,wy,vx,vy,mag,bThroughCorners,bAllowSpace)
	local otx,oty = World._getTileFromWorld(wx,wy)
	local twx,twy = wx+vx*mag,wy+vy*mag
    local ttx,tty = World._getTileFromWorld(twx,twy)
    local destTileValue = World._getTileValue(ttx, tty)
    if World._areTilesAdjacent(otx,oty,ttx,tty,bThroughCorners,true) then
        if World._isPathable(ttx,tty, not bAllowSpace) then
            return twx,twy
        end
    end
    local newTX,newTY = World._getBestOpenNeighbor(wx,wy,vx,vy,bThroughCorners,bAllowSpace)
    if newTX then
        return World._getWorldFromTile(newTX,newTY)
    else
        return wx,wy
    end
end
function World.isPathable(wx,wy,bDisallowSpace)
    local tx,ty = World._getTileFromWorld(wx,wy)
    return World._isPathable(tx,ty,bDisallowSpace)
end
function World._isPathable(tx,ty,bDisallowSpace)
    return not World._isPathBlocked(tx,ty,not bDisallowSpace)
end
function World._isPathBlocked(tx,ty,bAllowSpace)
    if Pathfinder.pathSoftBlocked(tx,ty) then return true end
    local tv = World._getTileValue(tx,ty)
    if tv == World.logicalTiles.SPACE or tv == World.logicalTiles.WALL_DESTROYED then return not bAllowSpace end
    return World.pathGrid:checkTileFlag(tx,ty, MOAIGridSpace.TILE_HIDE)
end
function World._getBestOpenNeighbor(wx,wy,vx,vy,bThroughCorners,bAllowSpace)
    local tx,ty = World._getTileFromWorld(wx,wy)
    if tx < 1 or ty < 1 or tx > World.width or ty > World.height then
        return nil
    end
    local tOptions = {}
    for i=2,((bThroughCorners and 9) or 5) do
        local dp = DFMath.dot(vx,vy, World.directionVectors[i][1], World.directionVectors[i][2])
        if dp > 0.1 then
            table.insert(tOptions, {dir=i, dp=dp, vx=vx,vy=vy})
        end
    end
    if #tOptions > 0 then
        table.sort(tOptions, function(a,b)
            return a.dp > b.dp
        end)
        for i=1,#tOptions do
            local atx,aty = _getAdjacentTile(tx,ty, tOptions[i].dir)
            if World._isPathable(atx,aty,not bAllowSpace) then return atx,aty end
        end
    end
end
function World.areWorldCoordsAdjacent(wx0,wy0,wx1,wy1,bThroughCorners,bOrEqual)
    local tileX0, tileY0 = World._getTileFromWorld(wx0,wy0)
    local tileX1, tileY1 = World._getTileFromWorld(wx1,wy1)
    return World._areTilesAdjacent(tileX0,tileY0,tileX1,tileY1,bThroughCorners,bOrEqual)
end
function World._areTilesAdjacent(tileX0,tileY0,tileX1,tileY1,bThroughCorners,bOrEqual)
    if bOrEqual and tileX0 == tileX1 and tileY0 == tileY1 then return true end
    for i=2,((bThroughCorners and 9) or 5) do
        local x,y = _getAdjacentTile(tileX0,tileY0,i)
        if x == tileX1 and y == tileY1 then
            return true
        end
    end
    return false
end
function World.isAdjacentToFn(tileX, tileY, testFn, bThroughCorners, bIncludeSame)
    for i=((bIncludeSame and 1) or 2),((bThroughCorners and 9) or 5) do
        local x,y = _getAdjacentTile(tileX,tileY,i)
        if testFn(x,y) then return x,y,i end
    end
    return false
end
function World._cheatOxygen(tx,ty)
    local totalOxygen, totalCount = 0,0
    for i=2,5 do
        local atx,aty = _getAdjacentTile(tx,ty,i)
        local o2, bOcclude, bIndoors = World.oxygenGrid:getOxygen(atx,aty)
        if bIndoors and not bOcclude then
            totalOxygen = totalOxygen+o2
            totalCount = totalCount+1
        end
    end
    local newO2 = (totalCount > 0 and totalOxygen/totalCount) or 0
    World.oxygenGrid:setOxygen(tx,ty,newO2)
end
function World._demolishTile(tileX,tileY)
    local bDemolishedTile = false
    local tileValue = World._getTileValue(tileX, tileY)
    local objAtTile = ObjectList.getObjAtTile(tileX,tileY,ObjectList.ENVOBJECT)
    if objAtTile then
        objAtTile:remove()
        bDemolishedTile = true
    elseif World.countsAsWall(tileValue) then
        World._setTile(tileX, tileY, World.logicalTiles.ZONE_LIST_START,true)
        bDemolishedTile = true
    else
        bDemolishedTile = Asteroid.vaporizeTile(tileX,tileY,tileValue,false)
    end
    if bDemolishedTile then
        World._cheatOxygen(tileX,tileY)
        local room = Room.getRoomAtTile(tileX,tileY,1)
        if room then
            room:tileVaporized(tileX,tileY,1)
        end
        local tileAddr = World.pathGrid:getCellAddr(tileX, tileY)
        World.tileHealth[tileAddr] = nil
    end
    return bDemolishedTile
end
function World._getEnvObjectOnWall(tileX, tileY)
    local nOffsetX = 1
    local nOffsetY = -1
    local tDetails = World._getWallTileDetails(tileX, tileY)
    if tDetails and tDetails.bFlip then
        nOffsetX = -1
    end
    local objAtTile = ObjectList.getObjAtTile(tileX+nOffsetX,tileY+nOffsetY,ObjectList.ENVOBJECT)
    if objAtTile then
        local objWallTileX, objWallTileY = objAtTile:getWallTile()
        if objWallTileX == tileX and objWallTileY == tileY then
            return objAtTile
        end
    end
    return nil
end
function World._vaporizeTile(tileX,tileY)
    local bVaporizedTile = false
    local objAtTile = ObjectList.getObjAtTile(tileX,tileY,ObjectList.ENVOBJECT)
    if objAtTile then
        objAtTile:vaporize()
        bVaporizedTile = true
    end
    local tileValue = World._getTileValue(tileX, tileY)
    if World.countsAsWall(tileValue) or World.countsAsFloor(tileValue) then
        if World.countsAsWall(tileValue) then
            local rObjOnWall = World._getEnvObjectOnWall(tileX, tileY)
            if rObjOnWall then
                rObjOnWall:vaporize()
            end
            World.setWallDecal(tileX, tileY, nil)
        elseif World.countsAsFloor(tileValue) then
            World.setFloorDecal(tileX, tileY, nil)
        end
        World._setTile(tileX, tileY, World.logicalTiles.SPACE,true)
        bVaporizedTile = true
    else
        bVaporizedTile = Asteroid.vaporizeTile(tileX,tileY,tileValue,true)
    end
    if bVaporizedTile then
        World._cheatOxygen(tileX,tileY)
        local room = Room.tRooms[World.roomGrid:getTileValue(tileX, tileY)]
        if room then
            local wx,wy = World._getWorldFromTile(tileX,tileY)
            room:tileVaporized(wx,wy,tileX,tileY)
        end
        local tileAddr = World.pathGrid:getCellAddr(tileX, tileY)
        World.tileHealth[tileAddr] = nil
    end
    return bVaporizedTile
end
function World.isAdjacentToTile(tileX, tileY, tx2, ty2, bThroughCorners, bIncludeSame)
    local testFn = function(tx,ty) return tx2 == tx and ty2 == ty end
    return World.isAdjacentToFn(tileX,tileY, testFn, bThroughCorners, bIncludeSame)
end
function World.isAdjacentToWall(tileX, tileY, bThroughCorners, bIncludeSame)
    local testFn = function(tx,ty) return World.countsAsWall(World._getTileValue(tx,ty)) end
    return World.isAdjacentToFn(tileX,tileY, testFn, bThroughCorners, bIncludeSame)
end
function World.isAdjacentToObj(tileX, tileY, bThroughCorners, obj, bIncludeSame)
    local fn = function(tx,ty)
        return ObjectList.isTagAtTile(tx,ty,obj.tag)
    end
    return World.isAdjacentToFn(tileX,tileY, fn, bThroughCorners, bIncludeSame)
end
function World.isAdjacentToSpace(tileX, tileY,bThroughCorners, bIncludeSame)
    local testFn = function(tx,ty) return World._getTileValue(tx,ty) == World.logicalTiles.SPACE end
    return World.isAdjacentToFn(tileX,tileY, testFn, bThroughCorners, bIncludeSame)
end
function World.isDestroyedWallAdjacentToSpace(tileX, tileY)
    local tileValue = World._getTileValue(tileX, tileY)
    return tileValue == World.logicalTiles.WALL_DESTROYED and World.isAdjacentToSpace(tileX, tileY, true)
end
function World.isDestroyedWallAdjacentToSpaceFromWorld(wx, wy)
    local tileX, tileY = World._getTileFromWorld(wx,wy)
    return World.isDestroyedWallAdjacentToSpace(tileX, tileY)
end
function World.getTileValueFromWorld(wx, wy)
    local tileX, tileY = World._getTileFromWorld(wx,wy)
    local tileValue = World._getTileValue(tileX, tileY)
    return tileValue
end
function World.clearPropReservation(worldX, worldY, propName, roomID)
    local tx,ty = World._getTileFromWorld(worldX,worldY)
    return World._clearPropReservation(tx,ty,propName,roomID)
end
function World._clearPropReservation(tx, ty, propName, roomID)
    if not roomID then roomID = nil end
    local tag = ObjectList.getTagAtTile(tx,ty,ObjectList.RESERVATION)
    if tag then
        local x,y = World.pathGrid:cellAddrToCoord(tag.addr)
        if x == tx and y == ty and (not tag.roomID or roomID == tag.roomID) then
            ObjectList.removeObject(tag)
        end
    else
        if not World.bLoadingGame and not World.bLoadingModule then
            Print(TT_Warning, 'Incorrect reservation clear.')
        end
    end
end
function World.makePropReservation(worldX, worldY, propName,bFlipX,bFlipY,roomID)
    ObjectList.addObject(ObjectList.RESERVATION, propName, {}, nil, false, false, worldX, worldY, bFlipX, bFlipY)
end
function _flipsToRearDirection(bFlipX,bFlipY)
            if bFlipX then
				if bFlipY then
					return World.directions.SE
                else
                    return World.directions.NE
				end
            else
				if bFlipY then
					return World.directions.SW
                else
                    return World.directions.NW
				end
            end
end
function World._findPropFit(tx,ty,propName,bForceFlipX,bForceFlipY,bReturnTileLists,bAllowRezone)
    local bSuccess
    local tData = EnvObject.getObjectData(propName)
    local bTestOnce = true
    if tData.againstWall or tData.width ~= tData.height or tData.door then
        bTestOnce = false
    end
    if bForceFlipX == nil then
        if not EnvObject.canFlipX(propName) then
            bForceFlipX = false
        end
    end
    if bForceFlipY == nil then
        if not EnvObject.canFlipY(propName) then
            bForceFlipY = false
        end
    end
    if tData.autoFlip then
        bForceFlipX,bForceFlipY = nil,nil
    else
        if bForceFlipX == nil then
            bForceFlipX = false
        end
    end
    assertdev(not bForceFlipX or EnvObject.canFlipX(propName))
    assertdev(not bForceFlipY or EnvObject.canFlipY(propName))
    local tValidTiles,tInvalidTiles = nil,nil
    local tValidTilesSaved,tInvalidTilesSaved = nil,nil
    local txFirstFail,tyFirstFail=nil,nil
    if bReturnTileLists then
        tValidTiles,tInvalidTiles = {},{}
    end
    local rCursorWall = nil
    local rTileWall = nil
    local bTileAsteroid = false
    if tData.againstWall then
        local wx,wy = World._getWorldFromTile(tx,ty)
        rCursorWall = g_GuiManager._getTargetAt(wx,wy,'wall')
        local potentialWallVal = World._getTileValue(tx,ty)
        if potentialWallVal == World.logicalTiles.WALL then
            rTileWall = World.tWalls[World.pathGrid:getCellAddr(tx,ty)]
            if rTileWall then
                rTileWall.tx,rTileWall.ty = tx,ty
            end
        elseif Asteroid.isAsteroid(potentialWallVal) then
            bTileAsteroid = true
        end
    end
    for i=1,4 do
        local txTest,tyTest = tx,ty
        local bFlipX,bFlipY
        if i == 1 then
            bFlipX,bFlipY = false,false
        elseif i == 2 then
            bFlipX,bFlipY = false,true
        elseif i == 3 then
            bFlipX,bFlipY = true,false
        else
            bFlipX,bFlipY = true,true
        end
        local bWalled = false
        if rCursorWall then
            local awayFromWallDir
            if rCursorWall.bFlip then
                awayFromWallDir = (bFlipY and g_World.directions.NE) or g_World.directions.SW
            else
                awayFromWallDir= (bFlipY and g_World.directions.NW) or g_World.directions.SE
            end
            local propDir = _flipsToRearDirection(bFlipX,bFlipY)
            if World.oppositeDirections[propDir] == awayFromWallDir then
                txTest,tyTest = g_World._getAdjacentTile(rCursorWall.tx,rCursorWall.ty,awayFromWallDir)
                bWalled = true
            end
        end
        if rTileWall and not bWalled then
            local awayFromWallDir
            if rTileWall.bFlip then
                awayFromWallDir = (bFlipY and g_World.directions.NE) or g_World.directions.SW
            else
                awayFromWallDir = (bFlipY and g_World.directions.NW) or g_World.directions.SE
            end
            local propDir = _flipsToRearDirection(bFlipX,bFlipY)
            if World.oppositeDirections[propDir] == awayFromWallDir then
                txTest,tyTest = g_World._getAdjacentTile(rTileWall.tx,rTileWall.ty,awayFromWallDir)
            end
        end
        if bTileAsteroid and not bWalled then
            if bFlipX then
                txTest,tyTest = g_World._getAdjacentTile(tx,ty,g_World.directions.SW)
            else
                txTest,tyTest = g_World._getAdjacentTile(tx,ty,g_World.directions.SE)
            end
        end
        if (bFlipX == bForceFlipX or bForceFlipX == nil) and (bFlipY == bForceFlipY or bForceFlipY == nil) then
            bSuccess = World._checkPropFit(txTest, tyTest, propName, bFlipX, bFlipY, bAllowRezone, tValidTiles,tInvalidTiles)
            if bSuccess then return true,txTest,tyTest,bFlipX,bFlipY,tValidTiles,tInvalidTiles end
            if not txFirstFail then
                txFirstFail,tyFirstFail = txTest,tyTest
            end
            if bReturnTileLists then
                if not tValidTilesSaved then
                    tValidTilesSaved,tInvalidTilesSaved = tValidTiles,tInvalidTiles
                end
                tValidTiles,tInvalidTiles = {},{}
            end
            if bTestOnce then break end
        end
    end
    return false,txFirstFail,tyFirstFail,bForceFlipX,bForceFlipY, tValidTilesSaved, tInvalidTilesSaved
end
function World._checkPropFit(tileX, tileY, propName, bFlipX, bFlipY, bAllowRezone, tValidTiles,tInvalidTiles)
    local affectedTiles,bAgainstWall = World._getPropFootprint(tileX, tileY, propName, true,bFlipX, bFlipY)
    local tData = EnvObject.getObjectData(propName)
    if tData.againstWall and not bAgainstWall then
        if tValidTiles then
            local sWallDir = (bFlipX and (bFlipY and 'SE' or 'NE')) or (bFlipY and 'SW' or 'NW')
            local txWall,tyWall = _getAdjacentTile(tileX,tileY,World.directions[sWallDir])
            local wallTileAddr = World.pathGrid:getCellAddr(txWall,tyWall)
            tInvalidTiles[wallTileAddr] = {x=txWall,y=tyWall,addr=wallTileAddr}
        else
            return false
        end
    end
    if tData.door then
        local lastDir = nil
        for i,tile in ipairs(affectedTiles) do
            local wallDir = World._getWallDirection(World.pathGrid:cellAddrToCoord(tile))
            local sNeededDir = bFlipX and World.wallDirections.NWSE or World.wallDirections.NESW
            local bValid = wallDir == sNeededDir and (not lastDir or lastDir == wallDir)
            if tValidTiles then
                local txDoor,tyDoor = World.pathGrid:cellAddrToCoord(tile)
                if bValid then tValidTiles[tile] = {x=txDoor,y=tyDoor,addr=tile}
                else tInvalidTiles[tile] = {x=txDoor,y=tyDoor,addr=tile} end
            elseif not bValid then
                return false
            end
            lastDir = wallDir
        end
    end
    local affectedTilesNoMargin = {}
    if tData.margin and tData.margin > 0 then
        affectedTilesNoMargin = World._getPropFootprint(tileX, tileY, propName, false,bFlipX)
    end
    for i,tile in ipairs(affectedTiles) do
        local tx,ty = World.pathGrid:cellAddrToCoord(tile)
        local tileValue = World._getTileValue(tx,ty)
        local bValid = true
        if tileValue == World.logicalTiles.DOOR or (not tData.door and not World._isPathable(tx,ty)) then
            bValid = false
        end
		if tData.bCanBuildInSpace and tileValue == World.logicalTiles.SPACE then
			bValid = true
		end
        local objAtTile = ObjectList.getObjAtTile(tx,ty,ObjectList.ENVOBJECT)
        local resAtTile = ObjectList.getReservationAt(tx,ty)
        local tOccupyingObjData
        if objAtTile then
			tOccupyingObjData = objAtTile.tData
		elseif resAtTile then
			tOccupyingObjData = EnvObject.getObjectData(resAtTile.objSubtype)
		end
        if tOccupyingObjData then
            if tOccupyingObjData.bBlocksPathing then
                bValid = false
            elseif tData.margin and tData.margin > 0 then
                local bInsideObjectNoMargin = false
                for _,noMarginTile in pairs(affectedTilesNoMargin) do
                    if noMarginTile == tile then
                        bInsideObjectNoMargin = true
                        break
                    end
                end
                bValid = not bInsideObjectNoMargin
            else
                bValid = false
            end
        end
        if bValid then
            local rRoom = Room.getRoomAtTile(tx,ty,1)
            if rRoom and rRoom:getVisibility() == g_World.VISIBILITY_HIDDEN  then
                bValid = false
            elseif tData.zoneName and not EnvObject.allowObjInRoom(tData,rRoom) then
                bValid = false
				if rRoom and not bValid and bAllowRezone and rRoom:getZoneName() == 'PLAIN' then
					bValid = true
				end
            end
        end
        if tValidTiles then
            if tInvalidTiles[tile] then
            elseif bValid then
                tValidTiles[tile] = {x=tx,y=ty,addr=tile}
            else
                tInvalidTiles[tile] = {x=tx,y=ty,addr=tile}
            end
        elseif not bValid then
            return false
        end
    end
    if tValidTiles then
        return not next(tInvalidTiles)
    else
        return true
    end
end
function World.removeWall(tileAddr,tPropList)
    if not tPropList then
        World.tWalls[tileAddr] = nil
    else
        local tWallProps = World.tWalls[tileAddr]
        if tWallProps then
            for k,v in pairs(tPropList) do
                if tWallProps[k] == v then
                    tWallProps[k] = nil
                end
            end
            if not next(tWallProps) then
                World.tWalls[tileAddr] = nil
            end
        end
    end
end
function World.addWall(tileAddr, tDetails)
    assertdev(tDetails and tDetails.tProps)
    World.tWalls[tileAddr] = tDetails
end
function World.removeAsteroid(tileAddr)
	World.tAsteroids[tileAddr] = nil
end
function World.addAsteroid(tileAddr, prop)
	World.tAsteroids[tileAddr] = prop
end
function World.updateCutaway(bShowSpace)
	local wallLayer = Renderer.getRenderLayer('WorldWall')
    for addr, tWall in pairs(Room.tWallsByAddr) do
        local bShow = not GameRules.cutawayMode
        local tDetails = World.tWalls[addr]
        local propTable = tDetails and tDetails.tProps
        if propTable then
            local id = tWall.tDirs[6] or tWall.tDirs[3] or tWall.tDirs[2]
            local r = id and Room.tRooms[id]
            if bShowSpace then
                if r then
                    bShow = bShow or (r:getVisibility() == World.VISIBILITY_HIDDEN)
                end
            else
                bShow = bShow or (not r or (r:getVisibility() == World.VISIBILITY_HIDDEN))
            end
            if propTable.top then
                if bShow then
                    wallLayer:insertProp(propTable.top)
                else
                    wallLayer:removeProp(propTable.top)
                end
                propTable.top:setVisible(bShow)
                propTable.top.bVisible = bShow
            end
            if propTable.decal then
                if bShow then
                    wallLayer:insertProp(propTable.decal)
                else
                    wallLayer:removeProp(propTable.decal)
                end
                propTable.decal:setVisible(bShow)
                propTable.decal.bVisible = bShow
            end
        end
    end
	for addr,prop in pairs(World.tAsteroids) do
		local wx, wy = World._getWorldFromAddr(addr)
		local tx, ty = World._getTileFromWorld(wx, wy)
		local nTileValue = World._getTileValue(tx, ty)
		local sSpriteName = Asteroid.getSpriteName(nTileValue)
		local index = World.layers.worldWall.spriteSheet.names[sSpriteName]
		prop:setIndex(index)
	end
end
function World._buildTile(tileX,tileY,param)
    local tileAddr = World.pathGrid:getCellAddr(tileX, tileY)
    local tileValue = World._getTileValue(tileX, tileY)
    local bSuccess = true
    World.tileHealth[tileAddr] = nil
    if param == CommandObject.BUILD_PARAM_VAPORIZE then
        bSuccess = World._vaporizeTile(tileX,tileY)
    elseif param == CommandObject.BUILD_PARAM_DEMOLISH then
        bSuccess = World._demolishTile(tileX,tileY)
    elseif param then
        World._setTile(tileX, tileY, param)
    else
        bSuccess = false
    end
    CommandObject._invalidateCommandTile(tileAddr)
    return bSuccess
end
function testWallPlacementIntersectsProp(sPropName,wallAddr,wtx,wty,ptx,pty,bFlipX,bFlipY)
    local tPropData = EnvObject.getObjectData(sPropName)
    if tPropData and tPropData.margin and tPropData.margin > 0 and MiscUtil.isoDist(wtx,wty,ptx,pty) <= (tPropData.margin + math.max(tPropData.width,tPropData.height)) then
        local tFootprint = World._getPropFootprint(ptx,pty, sPropName, true, bFlipX, bFlipY,true)
        if tFootprint[wallAddr] then
            return true
        end
    elseif tPropData.againstWall then
        if ptx == wtx and pty == wty then
            return true
        end
    end
    return false
end
function World.canBuildWall(tx, ty)
    local tile = World._getTileValue(tx, ty)
    if tile == World.logicalTiles.WALL_DESTROYED then return true end
    if tile ~= World.logicalTiles.SPACE and not World.countsAsFloor(tile) then
        return false
    end
    if ObjectList.pathBlockedByObject(tx,ty) then
        return false
    end
    if ObjectList.getDoorAtTile(tx,ty) then
        return false
    end
    local rRoom = Room.getRoomAtTile(tx,ty,1)
    if rRoom then
        local addr = World.pathGrid:getCellAddr(tx, ty)
        for rProp,_ in pairs(rRoom.tProps) do
            local ptx,pty = rProp:getTileLoc()
            if testWallPlacementIntersectsProp(rProp.sName,addr,tx,ty,ptx,pty,rProp.bFlipX,rProp.bFlipY) then
                return false
            end
        end
        for _,coord in pairs(rRoom.tDoors) do
            local rDoor = ObjectList.getDoorAtTile(coord.x,coord.y)
            if rDoor and rDoor:isInFrontOfDoor(addr) then
                return false
            end
        end
        for _,tData in pairs(rRoom.tPropPlacements) do
            if testWallPlacementIntersectsProp(tData.sName,addr,tx,ty,tData.tx,tData.ty,tData.bFlipX,tData.bFlipY) then
                return false
            end
        end
    end
    return true
end
function World.countsAsWall(tile)
    return (tile == World.logicalTiles.WALL or tile == World.logicalTiles.WALL_DESTROYED)
end
function World.countsAsFloor(tile)
    return (tile >= World.logicalTiles.ZONE_LIST_START and tile <= World.logicalTiles.ZONE_LIST_END)
end
function World._getGridProp(layer, x,y)
    return layer.props[(y-1)*World.width+x]
end
function World._createWallProp(layer, x, y, side, bFlip, bIgnoreLighting, bTop)
    local prop =  MOAIProp.new()
    prop:setDeck(layer.spriteSheet)
    local wx,wy = layer.grid:getTileLoc(x,y,MOAIGridSpace.TILE_LEFT_TOP)
    local rRenderLayer = layer.renderLayer
    wx,wy = wx+layer.originX, wy+layer.originY
	if bFlip then
		prop:setScl(-1, 1)
		wx = wx + 128
		wy = wy + 0
	end
    local wz = World.getHackySortingZ(wx, wy+World.tileHeightH);
    Lighting.setWallLightUVs(x, y, prop, bIgnoreLighting)
    if not bIgnoreLighting then
        local rMaterial = require("Renderer").getGlobalMaterial("wallLight")
        prop:setMaterial(rMaterial)
    end
    rRenderLayer:insertProp(prop)
    prop:setLoc(wx,wy, wz)
    prop.bWall,prop.tx,prop.ty,prop.bFlip,prop.bTop = true,x,y,bFlip,bTop
    return prop
end
function World._removeWallProp(layer, propTable, side)
    assert(propTable[side])
    layer.renderLayer:removeProp(propTable[side])
    if propTable[side..'Light'] then
        Renderer.getRenderLayer('Light'):removeProp(propTable[side..'Light'])
        propTable[side..'Light'] = nil
    end
    propTable[side] = nil
end
function World._addWallSpriteToTable(rLayer, tTable, tx,ty, sSlotId, nIndex, bFlip, bIgnoreLighting, sPropType)
    if nIndex and nIndex ~= 0 then
		local wx,wy = rLayer.grid:getTileLoc(tx,ty,MOAIGridSpace.TILE_LEFT_TOP)
		wx,wy = wx+rLayer.originX, wy+rLayer.originY
		local wz = 0
		if not tTable[sSlotId] then
			tTable[sSlotId] = World._createWallProp(rLayer, tx, ty, sSlotId, bFlip, bIgnoreLighting, sSlotId == "top")
		elseif bFlip then
			tTable[sSlotId]:setScl(-1, 1)
			wx = wx + 128
			wz = World.getHackySortingZ(wx,wy+World.tileHeightH)
			tTable[sSlotId]:setLoc(wx, wy, wz)
		else
			tTable[sSlotId]:setScl(1, 1)
			wz = World.getHackySortingZ(wx,wy+World.tileHeightH)
			tTable[sSlotId]:setLoc(wx, wy, wz)
		end
		tTable[sSlotId]:setIndex(nIndex)
        if sPropType == "asteroid" then
            tTable[sSlotId]:setVisible(true)
        elseif sSlotId == "top" or sSlotId == "decal" then
            local bShow = not GameRules.cutawayMode
            if World._getVisibility(tx, ty,1) ~= World.VISIBILITY_HIDDEN then
                tTable[sSlotId]:setVisible(bShow)
                tTable[sSlotId].bVisible = bShow
            end
        end
    elseif tTable[sSlotId] then
		World._removeWallProp(rLayer, tTable, sSlotId)
    end
end
function World._getWallPropTable(layer, x, y, nTopIndex, nBottomIndex, bFlip, bIgnoreLighting, tExistingTable, sPropType)
    if not sPropType then sPropType = "unknown" end
    local propTable = tExistingTable or {}
    World._addWallSpriteToTable(layer, propTable, x,y, 'bottom', nBottomIndex, bFlip, bIgnoreLighting, sPropType)
    World._addWallSpriteToTable(layer, propTable, x,y, 'top', nTopIndex, bFlip, bIgnoreLighting, sPropType)
	return propTable
end
function World._setGridTile(layer, x, y, nTopIndex, nBottomIndex, bFlip, sPropType)
	layer.grid:setTileValue(x,y,nTopIndex)
    local propTable = nil
    if layer == World.layers.worldWall or layer == World.layers.worldCeiling then
	    local idx = (y-1)*World.width+x
        if not layer.props[idx] then layer.props[idx] = {} end
        if layer == World.layers.worldWall then
            propTable = World._getWallPropTable(layer, x, y, nTopIndex, nBottomIndex, bFlip, false, layer.props[idx], sPropType)
        else
            World._addWallSpriteToTable(layer, layer.props[idx], x,y, 'ceiling', nTopIndex, bFlip)
        end
	end
    if nTopIndex ~= 0 then
        if layer == World.layers.worldFloor then
            World._setGridTile(World.layers.worldWall, x, y, 0, 0, 0)
            if World._getVisibility(x,y,1) ~= World.VISIBILITY_HIDDEN then
                World._setGridTile(World.layers.worldCeiling, x, y, 0)
            end
        elseif layer == World.layers.worldWall then
            World._setGridTile(World.layers.worldFloor, x, y, 0)
            if World._getVisibility(x,y,1) ~= World.VISIBILITY_HIDDEN then
                World._setGridTile(World.layers.worldCeiling, x, y, 0)
            end
        elseif layer == World.layers.worldCeiling then
        end
    end
    return propTable
end
function World._setGridLocColor(tx, ty, worldColor, bFlip)
    local tileColor = {worldColor[1], worldColor[2], worldColor[3], worldColor[4]}
    local tLitTileColor = {worldColor[1], worldColor[2], worldColor[3], worldColor[4]}
    local tLightColor = Lighting.getAmbientLightColorForTile(tx, ty)
    for k,v in ipairs(tLightColor) do
        tLitTileColor[k] = v * tLightColor[k]
    end
    World.layers.worldFloor.grid:setTileColor(tx, ty, unpack(tLitTileColor))
end
function World._updateOxygenFlags(tx,ty,logicalValue)
    logicalValue = logicalValue or World._getTileValue(tx,ty)
    if World._shouldObstructOxygen(tx,ty,logicalValue) then
        World.oxygenGrid:setTileFlag(tx,ty,DFOxygenGrid.TILE_OCCLUDE)
    else
        World.oxygenGrid:clearTileFlag(tx,ty,DFOxygenGrid.TILE_OCCLUDE)
    end
    if logicalValue == World.logicalTiles.SPACE then
        World.oxygenGrid:clearTileFlag(tx,ty,DFOxygenGrid.TILE_INDOORS)
    else
        World.oxygenGrid:setTileFlag(tx,ty,DFOxygenGrid.TILE_INDOORS)
    end
end
function _floodWallBlob(tx,ty,tBlobData,tScratch)
	local addr = World.pathGrid:getCellAddr(tx,ty)
    if tScratch[addr] then return tBlobData end
    tScratch[addr] = true
    if tBlobData.tWallAddrs[addr] then return tBlobData end
    if World.tWallAddrToBlob[addr] then
        local tTargetBlob = World.tWallAddrToBlob[addr]
        for id,_ in pairs(tBlobData.tRooms) do
            if Room.tRooms[id] then
                Room.tRooms[id].tWallBlobs[tBlobData] = nil
                Room.tRooms[id].tWallBlobs[tTargetBlob] = true
                tTargetBlob.tRooms[id] = true
            end
        end
        for addr,_ in pairs(tBlobData.tWallAddrs) do
            tTargetBlob.tWallAddrs[addr] = true
            World.tWallAddrToBlob[addr] = tTargetBlob
        end
        tBlobData.tWallAddrs = {}
        return tTargetBlob
    end
    if Room.tWallsByAddr[addr] then
        for i=2,9 do
            local id = Room.tWallsByAddr[addr].tDirs[i]
            if id then
                Room.tRooms[id].tWallBlobs[tBlobData] = true
                tBlobData.tRooms[id] = true
            end
        end
    else
        World.tWallAddrToBlob[addr] = tBlobData
        tBlobData.tWallAddrs[addr] = true
        for i=2,5 do
            local atx,aty = _getAdjacentTile(tx,ty,i)
            local logicalValue = World._getTileValue(atx,aty)
            if logicalValue == World.logicalTiles.WALL then
                tBlobData = _floodWallBlob(atx,aty,tBlobData,tScratch)
            end
        end
    end
    return tBlobData
end
function World.fixupVisuals()
    if World.bSuspendFixupVisuals then
        return
    end
    Room.updateDirty()
    for addr,coord in pairs(World.tDirtyWallTiles) do
        if not World.tWallAddrToBlob[addr] and not Room.tWallsByAddr[addr] then
            local logicalValue = World._getTileValue(coord.x,coord.y)
            if logicalValue == World.logicalTiles.WALL then
                local tNewBlob = { tRooms={}, tWallAddrs={} }
                _floodWallBlob(coord.x,coord.y,tNewBlob,{})
            end
        end
    end
    World.tDirtyWallTiles = {}
    local numTilesDirty = #World.dirtyVisualTiles
    for i,tile in ipairs(World.dirtyVisualTiles) do
        local tx,ty = tile.x,tile.y
        local logicalValue = World._getTileValue(tx, ty)
		local tileAddr = World.pathGrid:getCellAddr(tx,ty)
        if logicalValue == World.logicalTiles.SPACE then
            World._setGridTile(World.layers.worldFloor,tx,ty,0)
            World._setGridTile(World.layers.worldWall,tx,ty,0, 0, 0)
            Lighting.setTile(tx, ty, 0)
            World._setGridTile(World.layers.space,tx,ty,World.visualTiles.space.index)
            World._setGridTile(World.layers.worldCeiling,tx,ty, 0)
        else
			local bFlip = false
            local asteroidSprite = Asteroid.getSpriteName(logicalValue)
            if World._getVisibility(tx,ty,1) == World.VISIBILITY_HIDDEN then
                local sSpriteName = World.fogRoofSpriteName
                local idx = World.layers.worldCeiling.spriteSheet.names[sSpriteName]
                assert(idx and idx > 0)
                World._setGridTile(World.layers.worldCeiling,tx,ty, idx)
            else
                World._setGridTile(World.layers.worldCeiling,tx,ty, 0)
            end
            if asteroidSprite then
                local propTable = World._setGridTile(World.layers.worldWall,tx,ty,World.layers.worldWall.spriteSheet.names[asteroidSprite], nil, false, "asteroid")
				World.addAsteroid(tileAddr, propTable.top)
            elseif logicalValue == World.logicalTiles.WALL then
                local tDetails = World._getWallTileDetails(tx, ty)
                if tDetails.topIdx then
			        bFlip = tDetails.bFlip
                    local wallPropTable = World._setGridTile(World.layers.worldWall, tx, ty, tDetails.topIdx, tDetails.bottomIdx, tDetails.bFlip)
                        tDetails.tProps = wallPropTable
			            World.addWall(tileAddr, tDetails)
                        for sKey,rProp in pairs(wallPropTable) do
                            Lighting.setWallLightUVs(tx, ty, rProp)
                        end
                else
                    World.removeWall(tileAddr)
                end
            elseif logicalValue == World.logicalTiles.WALL_DESTROYED then
                World.removeWall(tileAddr)
                local tDetails = World._getWallTileDetails(tx, ty)
                local wallPropTable = World._setGridTile(World.layers.worldWall, tx, ty, 0, tDetails.damageIdx, tDetails.bFlip)
            elseif logicalValue == World.logicalTiles.DOOR then
                local idx = World.layers.worldFloor.spriteSheet.names[World.doorSpriteName]
                World._setGridTile(World.layers.worldFloor,tx,ty, idx)
            else
                local sSpriteName = Room.getSpriteAtTile(tx,ty,1,logicalValue)
                if sSpriteName then
                    local rLayer = World.layers.worldFloor
                    local idx = rLayer.spriteSheet.names[sSpriteName]
                    assert(idx and idx > 0)
                    World._setGridTile(rLayer,tx,ty, idx)
                    Lighting.setTile(tx, ty, logicalValue)
                else
                    World._setTile(tx, ty, World.logicalTiles.SPACE)
                end
            end
        end
    end
    Lighting.updateAll()
    local numColorsDirty = #World.dirtyVisualTiles
    for i,tile in ipairs(World.dirtyVisualTiles) do
        local tx,ty = tile.x,tile.y
        local logicalValue = World._getTileValue(tx, ty)
        if logicalValue ~= World.logicalTiles.SPACE then
            local bFlip = false
            if logicalValue == World.logicalTiles.WALL then
                local tDetails = World._getWallTileDetails(tx, ty)
				bFlip = tDetails.bFlip
            end
            World._updateTileColor(tx,ty,nil,logicalValue, bFlip)
        end
    end
    World.dirtyVisualTiles = { dirtyList = {} }
end
function World._updateTileColor(tx,ty,addr,value, bFlip)
    World._setGridLocColor(tx, ty, World.rightFacingColor, bFlip)
end
function World.getWallDirection(wx,wy)
    local tileX, tileY = World._getTileFromWorld(wx,wy)
    return World._getWallDirection(tileX,tileY)
end
function World._getWallDirection(tileX,tileY)
    local tileValue = World._getTileValue(tileX, tileY)
    if tileValue ~= World.logicalTiles.WALL and tileValue ~= World.logicalTiles.DOOR then
        return World.wallDirections.INVALID
    end
    local tileNW = World._getTileValue(_getAdjacentTile(tileX,tileY,2))
    local tileNE = World._getTileValue(_getAdjacentTile(tileX,tileY,3))
    local tileSW = World._getTileValue(_getAdjacentTile(tileX,tileY,4))
    local tileSE = World._getTileValue(_getAdjacentTile(tileX,tileY,5))
    tileNW = tileNW == World.logicalTiles.WALL or tileNW == World.logicalTiles.DOOR
    tileNE = tileNE == World.logicalTiles.WALL or tileNE == World.logicalTiles.DOOR
    tileSW = tileSW == World.logicalTiles.WALL or tileSW == World.logicalTiles.DOOR
    tileSE = tileSE == World.logicalTiles.WALL or tileSE == World.logicalTiles.DOOR
    if (tileNW or tileSE) and not tileSW and not tileNE then
        return World.wallDirections.NWSE
    end
    if (tileNE or tileSW) and not tileSE and not tileNW then
        return World.wallDirections.NESW
    end
    if tileNW and tileSW and not tileNE and not tileSE then
        return World.wallDirections.GREATERTHAN
    end
    if tileNE and tileSE and not tileSW and not tileNW then
        return World.wallDirections.LESSTHAN
    end
    if tileNE and tileNW and tileSE and tileSW then
        return World.wallDirections.X
    end
    if tileNW and tileNE then
        return World.wallDirections.V
    end
    if tileSW and tileSE then
        return World.wallDirections.CARAT
    end
    return World.wallDirections.PILLAR
end
local WALL_SHAPES = {
	['1010'] = {'NESW', 'SE', 'Straight'},
	['0101'] = {'NWSE', 'SW', 'Straight', true},
	['0110'] = {'CARAT', 'S', 'CornerS'},
	['1100'] = {'LESSTHAN', 'W', 'CornerE'},
	['1001'] = {'V', 'S', 'CornerN'},
	['0011'] = {'GREATERTHAN', 'E', 'CornerW'},
	['1101'] = {'T_NE', 'SW', 'TNE'},
	['1110'] = {'T_SE', 'S', 'TSE'},
	['0111'] = {'T_SW', 'S', 'TSW'},
	['1011'] = {'T_NW', 'SE', 'TNW'},
	['1111'] = {'X', 'S', 'Cross'},
	['0000'] = {'PILLAR', 'S', 'Column'},
}
function World._getWallTileDetails(tileX, tileY)
	local tAdj = {}
	local nConstruction = CommandObject.getConstructionAtTile(tileX, tileY)
	for i=1,9 do
		local x,y = _getAdjacentTile(tileX,tileY,i)
		tAdj[i] = CommandObject.getConstructionAtTile(x, y)
		if not tAdj[i] then
			tAdj[i] = World._getTileValue(x, y)
		end
	end
	local function isWall(dir)
		local val = tAdj[World.directions[dir]]
		return val == World.logicalTiles.WALL or World.isDoor(val)
	end
	local function zoneVal(dir)
        if nConstruction == World.logicalTiles.WALL then
			return Zone.CONSTRUCTION
		end
		local val = tAdj[World.directions[dir]]
		return Zone[World._zoneValue(val)] or Zone.EXTERIOR
	end
    local top = World.visualTiles.wall_error.names
	local bottom = World.visualTiles.wall_error.names
	local zone = 'PLAIN'
	local dir = World.wallDirections.INVALID
	local bFlip = false
	local fallBack = World.layers.worldWall.spriteSheet.names['Wall_Error']
	local sMask = (isWall('NE') and '1' or '0') .. (isWall('SE') and '1' or '0') .. (isWall('SW') and '1' or '0') .. (isWall('NW') and '1' or '0')
	local tShape = WALL_SHAPES[sMask]
	if not tShape then
		if sMask:sub(1, 1) == '1' or sMask:sub(3, 3) == '1' then
			tShape = WALL_SHAPES['1010']
		else
			tShape = WALL_SHAPES['0101']
		end
	end
	dir = World.wallDirections[tShape[1]]
	zone = zoneVal(tShape[2])
	top = zone['wall' .. tShape[3] .. 'Top']
	bottom = zone['wall' .. tShape[3] .. 'Bottom']
	bFlip = tShape[4] or false
	local addr = World.pathGrid:getCellAddr(tileX, tileY)
	local function pickTile(tWeights)
		local sTile = MiscUtil.weightedRandom(tWeights, addr)
		local nIdx = World.layers.worldWall.spriteSheet.names[sTile]
		if not nIdx then
			print('World._getWallTileDetails: '..sTile..' not found')
			return fallBack
		end
		return nIdx
	end
	local topTile = pickTile(top)
	local bottomTile = pickTile(bottom)
    local tDetails = {}
    tDetails.topIdx = topTile
    tDetails.bottomIdx = bottomTile
    tDetails.damageIdx = World.layers.worldWall.spriteSheet.names["Base_Straight_destroyed"]
    tDetails.bFlip = bFlip
    tDetails.direction = dir
    tDetails.zone = zone
    local facingDir = World.wallLightDirections[tDetails.direction]
    local adjx,adjy = _getAdjacentTile(tileX,tileY,facingDir)
    local rRoom = Room.getRoomAtTile(adjx,adjy,1)
    tDetails.facingDir = facingDir
    tDetails.nRoomID = rRoom and rRoom.id
	return tDetails
end
function World.getTileHealth(tx, ty)
    local tileAddr = World.pathGrid:getCellAddr(tx, ty)
    return World.tileHealth[tileAddr]
end
function World.damageTile(tx, ty, tw, tDamage, bDamageContents)
    local tileValue = World._getTileValue(tx, ty)
    local bIsFloor = World.countsAsFloor(tileValue)
    local bIsWall = World.logicalTiles.WALL == tileValue
    local tileAddr = World.pathGrid:getCellAddr(tx, ty)
    local tHealthDetails = World.tileHealth[tileAddr]
    if not tHealthDetails then
        tHealthDetails = {
            nHealth = World.TILE_DAMAGE_HEALTHY,
            nHitPoints = World.TILE_STARTING_HIT_POINTS,
            nDamageReduction = 0,
            nDamageType = Character.DAMAGE_TYPE.None,
            tDamageTypes = {}
        }
        World.tileHealth[tileAddr] = tHealthDetails
    end
    local nDamageReduction = tHealthDetails.nDamageReduction or 0
    local nDamage = math.max(tDamage.nDamage * (1 - nDamageReduction), 0)
    local nDamageType = tDamage.nDamageType or Character.DAMAGE_TYPE.Laser
    if not tHealthDetails.tDamageTypes then tHealthDetails.tDamageTypes = {} end
    tHealthDetails[nDamageType] = true
    tHealthDetails.nHitPoints = math.max(tHealthDetails.nHitPoints - nDamage, 0)
    local nHitPointPct = tHealthDetails.nHitPoints / World.TILE_STARTING_HIT_POINTS
    tHealthDetails.nHealth = math.floor(nHitPointPct * World.TILE_DAMAGE_HEALTHY)
    local nResult = nil
    if tHealthDetails.nHitPoints > 0 then
        if bIsFloor then
            World.setFloorDecal(tx, ty, "char03")
        elseif bIsWall then
            World.setWallDecal(tx, ty, "Damage")
        end
        World.updateHealthVisuals(tileAddr, tHealthDetails)
    else
        local rRoom = Room.getRoomAtTile(tx,ty,1)
        if rRoom then rRoom.bPotentiallyCombatBreached = true end
        if bIsFloor then
            World._vaporizeTile(tx, ty)
            nResult = World.logicalTiles.SPACE
        elseif bIsWall then
            World.setWallDecal(tx, ty, nil)
            World._setTile(tx, ty, World.logicalTiles.WALL_DESTROYED)
            nResult = World.logicalTiles.WALL_DESTROYED
            local rObjOnWall = World._getEnvObjectOnWall(tx, ty)
            if rObjOnWall then
                rObjOnWall:vaporize()
            end
        end
        Fire.extinguishTile(tx, ty)
    end
    if bDamageContents then
        local rEO = ObjectList.getObjAtTile(tx,ty,ObjectList.ENVOBJECT)
        if rEO then
            rEO:takeDamage(nil, tDamage)
        end
        local rChar = ObjectList.getObjAtTile(tx,ty,ObjectList.CHARACTER)
        if rChar then
            rChar:takeDamage(nil, tDamage)
        end
    end
    return nResult
end
function World._getWorldFromAddr(addr)
    return World._getWorldFromTile(World.pathGrid:cellAddrToCoord(addr))
end
function World.getPropMinY(wx,wy,propName,bFlipX)
    local tx, ty = World._getTileFromWorld(wx,wy)
    local tTiles = World._getPropFootprint(tx,ty,propName,false,bFlipX)
    local minTileX,minTileY = 0,100000
    for i,tile in ipairs(tTiles) do
        local x,y = World.pathGrid:cellAddrToCoord(tile)
        if y < minTileY then
            minTileX = x
            minTileY = y
        end
    end
    local worldX, worldY = World._getWorldFromTile(minTileX,minTileY,1,MOAIGridSpace.TILE_LEFT_TOP)
    return worldX,worldY
end
function World._getPropFootprint(tileX, tileY, propName, bBuffer, bFlipX, bFlipY,bIndexByAddr)
    local o = EnvObject.getObjectData(propName)
    if not o then
        local addr = World.pathGrid:getCellAddr(tileX, tileY)
        if bIndexByAddr then
            return {[addr]=1}
        else
            return {World.pathGrid:getCellAddr(tileX, tileY)}
        end
    end
    local bAgainstWall = o.againstWall
    if (not o.width or o.width == 1) and (not o.height or o.height == 1) then
        local t = {}
		local nBuffer
		if bBuffer then
			nBuffer = o.margin
		end
        if bAgainstWall then
			local function isAgainstWall(dir)
				local tv = World._getTileValue(_getAdjacentTile(tileX,tileY,dir))
                return tv == World.logicalTiles.WALL or Asteroid.isAsteroid(tv)
			end
            if bFlipX then
                if bFlipY then
					bAgainstWall = isAgainstWall(World.directions.SE)
                else
                    bAgainstWall = isAgainstWall(World.directions.NE)
                end
            else
                if bFlipY then
					bAgainstWall = isAgainstWall(World.directions.SW)
                else
                    bAgainstWall = isAgainstWall(World.directions.NW)
                end
            end
        end
        if not nBuffer or nBuffer == 0 then
            if bIndexByAddr then
                t[World.pathGrid:getCellAddr(tileX, tileY)]=1
            else
                table.insert(t,World.pathGrid:getCellAddr(tileX, tileY))
            end
        elseif nBuffer == 1 then
            for i=1,9 do
                if not o.againstWall or
                        (bFlipX and bFlipY and i ~= World.directions.S and i ~= World.directions.SE and i ~= World.directions.E) or
                        (not bFlipX and bFlipY and i ~= World.directions.S and i ~= World.directions.SW and i ~= World.directions.W) or
                        (bFlipX and not bFlipY and i ~= World.directions.N and i ~= World.directions.NE and i ~= World.directions.E) or
                        (not bFlipX and not bFlipY and i ~= World.directions.N and i ~= World.directions.NW and i ~= World.directions.W) then
                    if bIndexByAddr then
                        t[World.pathGrid:getCellAddr(_getAdjacentTile(tileX,tileY,i))]=1
                    else
                        table.insert(t,World.pathGrid:getCellAddr(_getAdjacentTile(tileX,tileY,i)))
                    end
                end
            end
		else
        	return World._getDiamondPropFootprint(tileX, tileY, propName, bBuffer,bFlipX, bFlipY,bIndexByAddr)
        end
        return t, bAgainstWall
    else
        return World._getDiamondPropFootprint(tileX, tileY, propName, bBuffer,bFlipX, bFlipY,bIndexByAddr)
    end
end
function World._getDiamondPropFootprint(tileX, tileY, propName, bBuffer, bFlipX, bFlipY,bIndexByAddr)
    local o = EnvObject.getObjectData(propName)
    local w,h = o.width,o.height
    if bFlipX and bFlipY then
    elseif bFlipX or bFlipY then
        w=o.height
        h=o.width
    end
	local nBuffer = nil
	if bBuffer then
		nBuffer = o.margin
	end
    if nBuffer then
        if o.againstWall then
            if bFlipX then
                w=w+nBuffer
                h=h+2*nBuffer
                tileX = tileX-nBuffer
            else
                w=w+2*nBuffer
                h=h+nBuffer
            end
        else
            w=w+2*nBuffer
            h=h+2*nBuffer
            tileX = tileX-nBuffer
        end
    end
    local tAddresses = {}
    local tLocs = {}
    local bAgainstWall = o.againstWall
    local startX = tileX
    local startY = tileY
    for i=1,w do
        local curX,curY = startX,startY
        for j=1,h do
            if bAgainstWall and not bFlipX and i == 1 then
                local tv = World._getTileValue(_getAdjacentTile(curX,curY,World.directions.NW))
                bAgainstWall = tv == World.logicalTiles.WALL or Asteroid.isAsteroid(tv)
            elseif bAgainstWall and bFlipX and j == 1 then
                local tv = World._getTileValue(_getAdjacentTile(curX,curY,World.directions.NE))
                bAgainstWall = tv == World.logicalTiles.WALL or Asteroid.isAsteroid(tv)
            end
            table.insert(tLocs, {curX,curY})
            local addr = World.pathGrid:getCellAddr(curX, curY)
            assert(not tAddresses[addr])
            tAddresses[addr] = 1
            if curY % 2 == 0 then
                curX = curX+1
            end
            curY = curY-1
        end
        if startY % 2 == 0 then
            startX = startX+1
        end
        startY = startY+1
    end
    if bIndexByAddr then
        return tAddresses, bAgainstWall
    end
    local t = {}
    for addr,_ in pairs(tAddresses) do
        table.insert(t,addr)
    end
    return t,bAgainstWall
end
function World.isDoor(value)
    return value == World.logicalTiles.DOOR
end
function World._shouldObstructPathing(tx,ty,tileValue)
    if not World.countsAsFloor(tileValue) and tileValue ~= World.logicalTiles.DOOR
            and tileValue ~= World.logicalTiles.SPACE then
        return true
    end
    return (ObjectList.pathBlockedByObject(tx,ty) and true)
end
function World._shouldObstructOxygen(tx,ty,tileValue)
    if tileValue == World.logicalTiles.WALL or Asteroid.isAsteroid(tileValue) then
        return true
    end
    return (ObjectList.oxygenBlockedByObject(tx,ty) and true)
end
function World._setTile(tileX, tileY, value, skipVis)
    assert(value ~= 0)
    assert(value > 0)
    local bBlocksPathing = World._shouldObstructPathing(tileX,tileY,value)
    local prevTile = World.pathGrid:getTileValue(tileX, tileY)
    local bBlockedPathing = World.pathGrid:checkTileFlag(tileX, tileY,MOAIGridSpace.TILE_HIDE)
    if (prevTile == value and bBlocksPathing == bBlockedPathing) or
       tileX < 0 or tileY < 0 or tileX > World.width or tileY > World.height then
        return
    end
    local oldZone = Zone.tOrderedZoneList[prevTile - World.logicalTiles.ZONE_LIST_START + 1]
    local newZone = Zone.tOrderedZoneList[value - World.logicalTiles.ZONE_LIST_START + 1]
    local tileAddr = World.pathGrid:getCellAddr(tileX, tileY)
	if World.tWalls[tileAddr] and value ~= World.logicalTiles.WALL then
		World.removeWall(tileAddr)
	end
	if World.tAsteroids[tileAddr] and (value <= World.logicalTiles.ASTEROID_VALUE_START or value >= World.logicalTiles.ASTEROID_VALUE_END) then
		World.removeAsteroid(tileAddr)
	end
    World.pathGrid:setTileValue(tileX, tileY, value)
    if bBlocksPathing then
        World.pathGrid:setTileFlag(tileX,tileY,MOAIGridSpace.TILE_HIDE)
    else
        World.pathGrid:clearTileFlag(tileX,tileY,MOAIGridSpace.TILE_HIDE)
    end
    World._updatePathGridDbgColor(tileX, tileY, World.pathGrid:checkTileFlag(tileX,tileY,MOAIGridSpace.TILE_HIDE))
        World._updateOxygenFlags(tileX,tileY,value)
        World.dTileChanged:dispatch(tileX,tileY,tileAddr,value, prevTile % MOAIGridSpace.TILE_FLAGS_MASK)
        local bDirtyWallBlobs=false
        if value == World.logicalTiles.WALL then
            World.tDirtyWallTiles[tileAddr] = {x=tileX,y=tileY}
        elseif prevTile == World.logicalTiles.WALL then
            bDirtyWallBlobs=true
            local tOldBlob = World.tWallAddrToBlob[tileAddr]
            if tOldBlob then
                World._deleteWallBlob(tOldBlob)
            end
        end
        for i=1,9 do
            local x,y = _getAdjacentTile(tileX,tileY,i)
            World._dirtyTile(x,y,bDirtyWallBlobs)
        end
end
function World._deleteWallBlob(tBlob)
    for addr,_ in pairs(tBlob.tWallAddrs) do
        World.tWallAddrToBlob[addr] = nil
    end
    for id,_ in pairs(tBlob.tRooms) do
        if Room.tRooms[id] then
            Room.tRooms[id][tBlob] = nil
        end
    end
end
function World._dirtyTile(tileX, tileY, bDirtyWallBlobs)
    local tileAddr = World.pathGrid:getCellAddr(tileX, tileY)
    if World.dirtyVisualTiles.dirtyList[tileAddr] == nil then
        World.dirtyVisualTiles.dirtyList[tileAddr] = true
        table.insert(World.dirtyVisualTiles, { x = tileX, y = tileY })
    end
    if bDirtyWallBlobs then
        World.tDirtyWallTiles[tileAddr] = {x=tileX,y=tileY}
    end
end
function World._getTileValue(tileX, tileY, tw)
    if tw and tw ~= 1 then return World.logicalTiles.SPACE end
    return World.pathGrid:getTileValue(tileX, tileY)
end
function World._getTileFromCursor(cursorX, cursorY)
    local wx,wy = Renderer.getWorldFromCursor(cursorX, cursorY)
    return World._getTileFromWorld(wx,wy)
end
function World._getTileFromWorld(worldX, worldY, worldZ, nLevel)
    if World.layers.worldFloor.prop and worldX and worldY then
        local gridX, gridY = World.layers.worldFloor.prop:getLoc()
        local tx,ty = World.layers.worldFloor.grid:locToCoord(worldX - gridX, worldY - gridY - 16)
        return tx,ty,(nLevel or 1)
    else
        return 1,1,(nLevel or 1)
    end
end
function World.getTileJustifiedWorldPos(wx,wy, justification)
    local tx,ty,tw = World._getTileFromWorld(wx,wy)
    return World._getWorldFromTile(tx,ty, tw, justification)
end
function World._getWorldFromTile(tileX, tileY, tileW, justification)
    local modelX, modelY = World.layers.worldFloor.grid:getTileLoc(tileX, tileY, justification or MOAIGridSpace.TILE_CENTER)
    local gridX, gridY = World.layers.worldFloor.prop:getLoc()
    return gridX + modelX, gridY + modelY
end
function World.getVisibility(wx,wy,nLevel)
    local tx,ty,tw = World._getTileFromWorld(wx,wy,0,nLevel)
    if tx then
        return World._getVisibility(tx,ty,tw)
    end
    return World.VISIBILITY_FULL
end
function World._getVisibility(tx,ty,tw)
    local rRoom, tRooms = Room.getRoomAtTile(tx,ty,tw,true)
    if tRooms then
        local nWorst = World.VISIBILITY_FULL
        for id,rAdjRoom in pairs(tRooms) do
            local nVis = rAdjRoom:getVisibility()
            if nVis < nWorst then nWorst = nVis end
        end
        return nWorst
    elseif rRoom then
        return rRoom:getVisibility()
    end
    return World.VISIBILITY_FULL
end
function World.playExplosion( wx, wy )
    local rSprite = require('AnimatedSprite').new(Renderer.getRenderLayer("WorldWall"), nil, "explode01_", {tSizeRange={1.65,1.95} })
    rSprite:setLoc(wx,wy+40,0)
    rSprite:play(true, 0)
    require('SoundManager').playSfx3D( "wallexplode", wx, wy, 0)
end
return World
