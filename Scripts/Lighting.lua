local Lighting = {} local World=require('World') local Room=require('Room') local Zone=require('Zones.Zone')
local ObjectList=require('ObjectList') local DFMath=require('DFCommon.Math') local DFUtil=require('DFCommon.Util')
local GridUtil=require('GridUtil') local LuaGrid=require('LuaGrid') local Profile = require('Profile')
local kCOLOR_DARKNESS = { 0.3, 0.3, 0.3} local kCOLOR_DARKNESS_EMERGENCY = { 0.1, 0.1, 0.1} local kWALL_BASE_COLOR = { 0.1, 0.1, 0.1 }
Lighting.bEnable = true local RoomLight = {} function RoomLight.new() local obj = {} obj.tileX = 0 obj.tileY = 0
obj.tColor = {0.0, 0.0, 0.0} obj.nTileRadius = 2 obj.id = Lighting.nextRoomLightId Lighting.nextRoomLightId = Lighting.nextRoomLightId + 1
return obj end function Lighting.init() print("Lighting:init()") Lighting.IsDirty = true Lighting.LightMapEmergency = LuaGrid.new()
Lighting.LightMapEmergency:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight) Lighting.LightMapEmergency:fill(0)
Lighting.LightMapEmergency:fillColor(kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3], 1.0) Lighting.LightMap = LuaGrid.new()
Lighting.LightMap:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight) Lighting.LightMap:fill(0)
Lighting.LightMap:fillColor(kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3], 1.0) Lighting.LightDataMap = LuaGrid.new()
Lighting.LightDataMap:initDiamondGrid(World.width, World.height, World.tileWidth, World.tileHeight) Lighting.LightDataMap:fill(0)
Lighting.LightDataMap:fillColor(1.0, 0.0, 0.0, 1.0) Lighting.nextRoomLightId = 1 local xMin, yMin = GridUtil.CalculateIsoToSquare(0, 0)
local xMax, yMax = GridUtil.IsoToSquare(World.width, World.height) Lighting.LightPixelBuffer = MOAIImage.new()
Lighting.LightPixelBuffer:init( 2*World.width, 2*World.height )
Lighting.LightPixelBuffer:fillRect(0, 0, 2*World.width, 2*World.height, kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3], 1.0)
Lighting.LightPixelBufferEmergency = MOAIImage.new() Lighting.LightPixelBufferEmergency:init( 2*World.width, 2*World.height )
Lighting.LightPixelBufferEmergency:fillRect(0, 0, 2*World.width, 2*World.height, kCOLOR_DARKNESS_EMERGENCY[1], kCOLOR_DARKNESS_EMERGENCY[2], kCOLOR_DARKNESS_EMERGENCY[3], 1.0)
Lighting.LightTexture = MOAITexture.new() Lighting.LightTexture:setFilter( MOAITexture.GL_LINEAR, MOAITexture.GL_LINEAR )
Lighting.LightTexture:load(Lighting.LightPixelBuffer) Lighting.LightTextureEmergency = MOAITexture.new()
Lighting.LightTextureEmergency:setFilter( MOAITexture.GL_LINEAR, MOAITexture.GL_LINEAR )
Lighting.LightTextureEmergency:load(Lighting.LightPixelBufferEmergency) local rMaterial = require("Renderer").getGlobalMaterial("wallLight")
rMaterial:setShaderValue( "g_samLightMapColors", MOAIMaterial.VALUETYPE_TEXTURE, Lighting.LightTexture)
rMaterial:setShaderValue( "g_samEmergencyColors", MOAIMaterial.VALUETYPE_TEXTURE, Lighting.LightTextureEmergency)
World.layers.worldFloor.prop:setColorGrid(Lighting.LightDataMap:getMOAIGrid()) local rMaterial = World.layers.worldFloor.prop:getMaterial()
rMaterial:setShaderValue( "g_samLightMapColors", MOAIMaterial.VALUETYPE_TEXTURE, Lighting.LightTexture)
rMaterial:setShaderValue( "g_samEmergencyColors", MOAIMaterial.VALUETYPE_TEXTURE, Lighting.LightTextureEmergency) end
function Lighting.onTick(nElapsed) Lighting.updateAll() end function Lighting.setTile(tileX, tileY, zoneValue) Lighting.IsDirty = true
local rRoom = Room.getRoomAtTile(tileX, tileY,1) if rRoom then rRoom.bDirtyLights = true end end
function Lighting.updateEmergencyForRoom(rRoom) Lighting.IsDirty = true if rRoom then
if Room.LIGHTING_SCHEME_OFF == rRoom.nLightingScheme then Lighting.setRoomTileLightInfo(rRoom, 1.0, 0.0, 1.0)
elseif Room.LIGHTING_SCHEME_NORMAL == rRoom.nLightingScheme then Lighting.setRoomTileLightInfo(rRoom, 1.0, 0.0, 0.0)
elseif Room.LIGHTING_SCHEME_DIM == rRoom.nLightingScheme then Lighting.setRoomTileLightInfo(rRoom, 0, 0.0, 0.9)
elseif Room.LIGHTING_SCHEME_VACUUM == rRoom.nLightingScheme then rRoom.tEmergencyColor = { 0.3, 0.5, 0.6 }
rRoom.bDirtyEmergencyLights = true elseif Room.LIGHTING_SCHEME_LOWPOWER == rRoom.nLightingScheme then
Lighting.setRoomTileLightInfo(rRoom, 0, 0.0, 0.5) else rRoom.tEmergencyColor = { 1.0, 0.1, 0.1 } rRoom.bDirtyEmergencyLights = true end end
end function Lighting.setWallLightUVs(tx, ty, rProp, bIgnoreLighting) local tDetails = World._getWallTileDetails(tx, ty)
local pxX = 1.0 / (World.width * 2.0) local pxY = 1.0 / (World.height * 2.0) local direction = World.directions.SW local floorOffsetX = 0
local floorOffsetY = 0 local tileDir = tDetails.direction if tileDir and tileDir >= 0 then direction = World.wallLightDirections[tileDir]
end if direction == World.directions.SW then floorOffsetY = -2 end
local floorLightX,floorLightY = World._getAdjacentTile(tx + floorOffsetX, ty + floorOffsetY, direction)
floorLightX = DFMath.clamp(floorLightX, 1, World.width) floorLightY = DFMath.clamp(floorLightY, 1, World.height)
rProp.facingFloor = {x=floorLightX, y=floorLightY} rProp.direction = direction if not bIgnoreLighting then
local uvX,uvY = GridUtil.IsoToSquare(floorLightX,floorLightY) local uvW = 0 local uvH = 0 if direction == World.directions.SW then uvX = uvX
uvY = uvY uvH = -1 elseif direction == World.directions.SE then uvX = uvX uvY = uvY uvW = 1 end uvX = uvX * pxX uvY = uvY * pxY
uvW = uvW * pxX uvH = uvW * pxY rProp:setSecondaryUV(uvX, uvY, uvW, uvH) end rProp.bShouldDarken = (direction ~= World.directions.SE)
rProp.nDarknessMult = (rProp.bShouldDarken and 0.8) or 1 rProp.bIgnoreLighting = bIgnoreLighting end
function Lighting.setRoomHighlight(rRoom, nHighlightPercent) if rRoom.nHighlightPercent ~= nHighlightPercent then
rRoom.nHighlightPercent = nHighlightPercent if rRoom.tTileLightInfo then
Lighting.setRoomTileLightInfo(rRoom, rRoom.tTileLightInfo[1], rRoom.tTileLightInfo[2], rRoom.tTileLightInfo[3]) end end end
function Lighting.setRoomTileLightInfo(rRoom, nNormalPercent, nEmergencyPercent, nDarknessPercent) if not rRoom.tTileLightInfo then
rRoom.tTileLightInfo = { nNormalPercent, nEmergencyPercent, nDarknessPercent } else rRoom.tTileLightInfo[1] = nNormalPercent
rRoom.tTileLightInfo[2] = nEmergencyPercent rRoom.tTileLightInfo[3] = nDarknessPercent end Profile.enterScope("setRoomTileLightInfo")
if rRoom.tTiles then local tZoneDef = rRoom:getZoneDef()
local tAmbientLight = tZoneDef.tAmbientLightColor or {kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3]}
local vertexDarknessPercent = (1.0 - nDarknessPercent) + 0.5 * (rRoom.nHighlightPercent or 0.0)
rRoom.tEmergencyColor = rRoom.tEmergencyColor or {0.0, 0.0, 0.0} local nDarknessTint = 1.0 - vertexDarknessPercent * 0.5;
local ambR = DFMath.lerp(tAmbientLight[1], rRoom.tEmergencyColor[1], nEmergencyPercent) * vertexDarknessPercent
local ambG = DFMath.lerp(tAmbientLight[2], rRoom.tEmergencyColor[2], nEmergencyPercent) * vertexDarknessPercent
local ambB = DFMath.lerp(tAmbientLight[3], rRoom.tEmergencyColor[3], nEmergencyPercent) * vertexDarknessPercent
if not rRoom.tCurrentAmbientLightColor then rRoom.tCurrentAmbientLightColor = {} end if not rRoom.tPropLightColor then
if tZoneDef.tPropLightColor then rRoom.tPropLightColor = DFUtil.deepCopy(tZoneDef.tPropLightColor) else rRoom.tPropLightColor = {} end end
rRoom.tCurrentAmbientLightColor[1] = ambR rRoom.tCurrentAmbientLightColor[2] = ambG rRoom.tCurrentAmbientLightColor[3] = ambB
rRoom.tPropLightColor[1] = math.min(1.0, ambR + 0.3) rRoom.tPropLightColor[2] = math.min(1.0, ambG + 0.3)
rRoom.tPropLightColor[3] = math.min(1.0, ambB + 0.3) if rRoom.tProps then local propR = rRoom.tPropLightColor[1]
local propG = rRoom.tPropLightColor[2] local propB = rRoom.tPropLightColor[3] for rProp,_ in pairs(rRoom.tProps) do
rProp:setBaseColor(propR, propG, propB) end end
local texturedDarknessPercent = 0.5 * (1.0 - nDarknessPercent) + 0.5 * (rRoom.nHighlightPercent or 0.0)
texturedDarknessPercent=math.max(math.min(1.0,texturedDarknessPercent),0)
Lighting.LightDataMap:getMOAIGrid():fillTileColorsPreserveAlpha(nNormalPercent, nEmergencyPercent, texturedDarknessPercent, rRoom.tTiles)
if rRoom.tWalls then for addr,rWallLoc in pairs(rRoom.tWalls) do local tDetails = World.tWalls[addr]
if tDetails and tDetails.nRoomID == rRoom.id then local tProps = tDetails.tProps for _,rProp in pairs(tProps) do
rProp:setColor(nNormalPercent, nEmergencyPercent, rProp.nDarknessMult * texturedDarknessPercent, 1.0) end end end end end
Profile.leaveScope("setRoomTileLightInfo") end function Lighting.setAlphaForTile(tx,ty,alpha) local gr = Lighting.LightDataMap:getMOAIGrid()
local r,g,b = gr:getTileColor(tx,ty) gr:setTileColor(tx,ty,r,g,b,alpha) end function Lighting.getLightColorForWorld(wx, wy)
local tileX, tileY = g_World._getTileFromWorld(wx,wy) return Lighting.getLightColorForTile(tileX, tileY) end if Lighting.bEnable then
function Lighting.getLightColorForTile(tileX, tileY) local lightColor = {kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3]}
local r,g,b,a = Lighting.LightMap:getTileColor(tileX, tileY) if r then local rRoom = Room.getRoomAtTile(tileX, tileY,1) if rRoom then
if rRoom.nLightingScheme ~= Room.LIGHTING_SCHEME_NORMAL then r,g,b,a = Lighting.LightMapEmergency:getTileColor(tileX, tileY) end end
lightColor[1] = r lightColor[2] = g lightColor[3] = b end return lightColor end function Lighting.getAmbientLightColorForTile(tileX, tileY)
local rRoom = Room.getRoomAtTile(tileX, tileY,1) local lightColor = {kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3]}
if rRoom and rRoom.tCurrentAmbientLightColor then lightColor[1] = rRoom.tCurrentAmbientLightColor[1]
lightColor[2] = rRoom.tCurrentAmbientLightColor[2] lightColor[3] = rRoom.tCurrentAmbientLightColor[3] end return lightColor end else
function Lighting.getLightColorForTile(tileX, tileY) return {1.0, 1.0, 1.0} end function Lighting.getAmbientLightColorForTile(tileX, tileY)
return {1.0, 1.0, 1.0, 1.0} end end function Lighting.updateAll() Profile.enterScope("Lighting.updateAll()") if Lighting.IsDirty then
if Room.tRooms and #Room.tRooms > 0 then Profile.enterScope("_updateCeilingLights") Lighting._updateCeilingLights()
Profile.leaveScope("_updateCeilingLights") Lighting._updateDoorLights() Lighting.IsDirty = false Profile.enterScope("LightTexture:load")
Lighting.LightTexture:load(Lighting.LightPixelBuffer) Lighting.LightTextureEmergency:load(Lighting.LightPixelBufferEmergency)
Profile.leaveScope("LightTexture:load") end end Profile.leaveScope("Lighting.updateAll()") end function Lighting._updateCeilingLights()
local kForceRebuild = false for id,rRoom in pairs(Room.tRooms) do if kForceRebuild or rRoom.bDirtyLights or nil == rRoom.bDirtyLights then
Lighting._placeLightsForRoom(rRoom) Lighting._placeEmergencyLightsForRoom(rRoom) end
if kForceRebuild or rRoom.bDirtyEmergencyLights or nil == rRoom.bDirtyEmergencyLights then Lighting._placeEmergencyLightsForRoom(rRoom) end
end for id,rRoom in pairs(Room.tRooms) do if kForceRebuild or rRoom.bDirtyLights or nil == rRoom.bDirtyLights then
for addr,coord in pairs(rRoom.tWalls) do local sqX,sqY = GridUtil.IsoToSquare(coord.x, coord.y)
Lighting.LightMap:setTileColor(sqX, sqY, kWALL_BASE_COLOR[1], kWALL_BASE_COLOR[2], kWALL_BASE_COLOR[3], 1.0)
Lighting.LightPixelBuffer:setRGBA(sqX, sqY, kWALL_BASE_COLOR[1], kWALL_BASE_COLOR[2], kWALL_BASE_COLOR[3], 1.0) end end
if kForceRebuild or rRoom.bDirtyEmergencyLights or nil == rRoom.bDirtyEmergencyLights then for addr,coord in pairs(rRoom.tWalls) do
local sqX,sqY = GridUtil.IsoToSquare(coord.x, coord.y)
Lighting.LightMapEmergency:setTileColor(sqX, sqY, kWALL_BASE_COLOR[1], kWALL_BASE_COLOR[2], kWALL_BASE_COLOR[3], 1.0)
Lighting.LightPixelBufferEmergency:setRGBA(sqX, sqY, kWALL_BASE_COLOR[1], kWALL_BASE_COLOR[2], kWALL_BASE_COLOR[3], 1.0) end end
rRoom.bDirtyLights = false rRoom.bDirtyEmergencyLights = false end end function Lighting._updateDoorLights()
for id,rRoom in pairs(Room.tRooms) do for addr,tDoorLoc in pairs(rRoom.tDoors) do
local rDoor = ObjectList.getDoorAtTile(tDoorLoc.x, tDoorLoc.y) if rDoor then local floorX,floorY = rDoor:getTileInFrontOf() local tLight
if rRoom then tLight = rRoom.tPropLightColor else tLight = Lighting.getLightColorForTile(floorX, floorY) end
rDoor:setBaseColor(unpack(tLight)) end end end end function Lighting._placeEmergencyLightsForRoom(rRoom) rRoom.tLights = {}
local sqTop = 99999 local sqLeft = 99999 local sqRight = -99999 local sqBottom = -99999 local numLightsInRoom = 0
local zoneId = rRoom:getZoneName() local tZoneDef = Zone[zoneId]
local tAmbientLight = tZoneDef.tAmbientLightColor or {kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3]}
local tColor = {tAmbientLight[1] * 0.2, tAmbientLight[2] * 0.2, tAmbientLight[3] * 0.2} for addr,coord in pairs(rRoom.tTiles) do
local sqX, sqY = GridUtil.IsoToSquare(coord.x, coord.y) if sqX < sqLeft then sqLeft = sqX end if sqX > sqRight then sqRight = sqX end
if sqY < sqTop then sqTop = sqY end if sqY > sqBottom then sqBottom = sqY end
Lighting.LightMapEmergency:setTileColor(coord.x, coord.y, tColor[1], tColor[2], tColor[3], 1.0)
Lighting.LightPixelBufferEmergency:setRGBA(sqX, sqY, tColor[1], tColor[2], tColor[3], 1.0) end local tLightDef = {}
tLightDef.nLightTileGapX = 4 tLightDef.nLightTileGapY = 3 tLightDef.nLightRadius = 2 tLightDef.nLightTileGapOffsetY = 0
tLightDef.tLightColor = rRoom.tEmergencyColor local nLightTileGapX = tLightDef.nLightTileGapX or 6
local nLightTileGapY = tLightDef.nLightTileGapY or 6 local nLightTileGapOffsetX = tLightDef.nLightTileGapOffsetX or 0
local nLightTileGapOffsetY = tLightDef.nLightTileGapOffsetY or 0 for addr,coord in pairs(rRoom.tTiles) do local tileX = coord.x
local tileY = coord.y local sqX, sqY = GridUtil.IsoToSquare(tileX, tileY) local roomSqX = sqX - sqLeft local roomSqY = sqY - sqTop
if (roomSqX + nLightTileGapOffsetX) % nLightTileGapX == 0 and (roomSqY + nLightTileGapOffsetY) % nLightTileGapY == 0 then
Lighting._attemptAddCeilingLight(tileX, tileY, rRoom, tLightDef, Lighting.LightMapEmergency, Lighting.LightPixelBufferEmergency) end end end
function Lighting._placeLightsForRoom(rRoom) rRoom.tLights = {} local sqTop = 99999 local sqLeft = 99999 local sqRight = -99999
local sqBottom = -99999 local numLightsInRoom = 0 local zoneId = rRoom:getZoneName() local tZoneDef = Zone[zoneId]
local tLightDefs = tZoneDef.tRoomLights
local tAmbientLight = tZoneDef.tAmbientLightColor or {kCOLOR_DARKNESS[1], kCOLOR_DARKNESS[2], kCOLOR_DARKNESS[3]}
for addr,coord in pairs(rRoom.tTiles) do local sqX, sqY = GridUtil.IsoToSquare(coord.x, coord.y) if sqX < sqLeft then sqLeft = sqX end
if sqX > sqRight then sqRight = sqX end if sqY < sqTop then sqTop = sqY end if sqY > sqBottom then sqBottom = sqY end
Lighting.LightMap:setTileColor(coord.x, coord.y, tAmbientLight[1], tAmbientLight[2], tAmbientLight[3], 1.0)
Lighting.LightPixelBuffer:setRGBA(sqX, sqY, tAmbientLight[1], tAmbientLight[2], tAmbientLight[3], 1.0) end if not rRoom.tTileLightInfo then
local nNormalLightPercent = 1.0 local nEmergencyPercent = 0.0 local nDarknessPercent = 0.0
rRoom.tTileLightInfo = {nNormalLightPercent, nEmergencyPercent, nDarknessPercent} end
Lighting.setRoomTileLightInfo(rRoom, unpack(rRoom.tTileLightInfo)) if tLightDefs and #tLightDefs > 0 then
for addr,coord in pairs(rRoom.tTiles) do local tileX = coord.x local tileY = coord.y local sqX, sqY = GridUtil.IsoToSquare(tileX, tileY)
local roomSqX = sqX - sqLeft local roomSqY = sqY - sqTop for idx,tLightDef in ipairs(tLightDefs) do
local nLightTileGapX = tLightDef.nLightTileGapX or 6 local nLightTileGapY = tLightDef.nLightTileGapY or 6
local nLightTileGapOffsetX = tLightDef.nLightTileGapOffsetX or 0 local nLightTileGapOffsetY = tLightDef.nLightTileGapOffsetY or 0
if (roomSqX + nLightTileGapOffsetX) % nLightTileGapX == 0 and (roomSqY + nLightTileGapOffsetY) % nLightTileGapY == 0 then
Lighting._attemptAddCeilingLight(tileX, tileY, rRoom, tLightDef) end end end end end
function Lighting._attemptAddCeilingLight(tileX, tileY, rRoom, tLightDef, rLightMap, rPixelBuffer)
rLightMap = rLightMap or Lighting.LightMap rPixelBuffer = rPixelBuffer or Lighting.LightPixelBuffer
local tLightColor = tLightDef.tLightColor or {0.5, 0.5, 0.5} local nLightRadius = tLightDef.nLightRadius or 4 local tLight = RoomLight.new()
tLight.tileX = tileX tLight.tileY = tileY tLight.tColor = tLightColor table.insert(rRoom.tLights, tLight) local r = tLightColor[1]
local g = tLightColor[2] local b = tLightColor[3] local nLightPercentMin = 0.0 local nLightPercentMax = 1.0 - kCOLOR_DARKNESS[1]
local tTiles = GridUtil.GetTilesForIsoCircle(tileX, tileY, nLightRadius) local testString = "" for idx,tile in pairs(tTiles) do
local tx = tile.x local ty = tile.y local rRoom = Room.getRoomAtTile(tx, ty,1) if rRoom and rRoom.id == rRoom.id then
local nLightDist = GridUtil.GetTileDistance(tx, ty, tileX, tileY) if nLightDist <= nLightRadius then
local bLineOfSight = GridUtil.CheckLineOfSight(tx, ty, tileX, tileY, true) if bLineOfSight then
local nLightPct = DFMath.lerp(nLightPercentMin, nLightPercentMax, 1.0 - (nLightDist / (nLightRadius)))
Lighting._addLightColorToTile(tx, ty, rLightMap, rPixelBuffer, r * nLightPct, g * nLightPct, b * nLightPct) end end end end end
function Lighting._addLightColorToTile(tileX, tileY, lightMap, lightPixelBuffer, lightR, lightG, lightB)
local r,g,b,a = lightMap:getTileColor(tileX, tileY) r = r + lightR g = g + lightG b = b + lightB r = math.min(r, 1.0) g = math.min(g, 1.0)
b = math.min(b, 1.0) lightMap:setTileColor(tileX, tileY, r, g, b, a) local gridX, gridY = GridUtil.IsoToSquare(tileX, tileY)
lightPixelBuffer:setRGBA(gridX, gridY, r, g, b, a) end function Lighting.getClosestLightToTileInRoom(tileX, tileY, rRoom)
local nShortestDistance = 9999 local tClosestLight = nil for idx,tLight in ipairs(rRoom.tLights) do local dx = tLight.tileX - tileX
local dy = tLight.tileY - tileY local distance = math.sqrt((dx*dx)+(dy*dy)) if distance < nShortestDistance then tClosestLight = tLight
nShortestDistance = distance end end return tClosestLight end return Lighting
