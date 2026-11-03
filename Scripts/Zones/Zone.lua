local function _h1(a0,a1,a2,a3) return {tLightColor=a0,nLightTileGapX=a1,nLightTileGapY=a2,nLightRadius=a3} end
local DFGraphics = require('DFCommon.Graphics')
local DFMath = require('DFCommon.Math')
local DFUtil = require('DFCommon.Util')
local Class=require('Class')
local ObjectList=require('ObjectList')
local Character=require('CharacterConstants')
local Zone = Class.create()
Zone.spriteSheetPath='Environments/Tiles/Floor'
local WALLS={CornerNTop='Corner_outer01_top',CornerNBottom='Corner_outer01_bottom',CornerETop='Corner_lb_top',CornerEBottom='Corner_lb_bottom',CornerSTop='Corner_inner01_top',CornerSBottom='Corner_inner01_bottom',CornerWTop='Corner_rb_top',CornerWBottom='Corner_rb_bottom',TNETop='Corner_T_NE_top',TNEBottom='Corner_T_NE_bottom',TSETop='Corner_T_SE_top',TSEBottom='Corner_T_SE_bottom',TSWTop='Corner_T_SW_top',TSWBottom='Corner_T_SW_bottom',TNWTop='Corner_T_NW_top',TNWBottom='Corner_T_NW_bottom',CrossTop='Corner_cross_top',CrossBottom='Corner_cross_bottom'}
local function fill(P,col,t)
 for k,v in pairs(WALLS) do t['wall'..k]=t['wall'..k] or {[P..'_'..v]=1} end
 t.wallColumnTop=t.wallColumnTop or {[P..'_Corner_'..col..'_top']=1}
 t.wallColumnBottom=t.wallColumnBottom or {[P..'_Corner_'..col..'_bottom']=1}
 return t
end
Zone.PLAIN =
fill('Base','cross',
{
    name='Unzoned',
    floorNames={ 'base01', },
    description="ZONEUI006TEXT",
	wallStraightTop = {Base_Straight01_top=15, Base_Straight02_top=1, Base_Straight03_top=30, Base_Straight04_top=2},
	wallStraightBottom = {Base_Straight01_bottom=5, Base_Straight02_bottom=2, Base_Straight03_bottom=1},
    tAmbientLightColor = { 0.6*0.6, 0.55*0.6, 0.45*0.6 },
    tRoomLights =
    {
        _h1({1.0 * 0.5, 0.6 * 0.5, 0.3 * 0.5}, 4, 4, 2),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickunzoned',
    portrait = 'Zone_Unzoned'
})
Zone.GARDEN =
fill('Garden','outer01',
{
    name='Garden',
    description="ZONEUI070TEXT",
    floorNames={ 'garden01', 'garden02', },
    associatedJob=Character.BOTANIST,
    wallStraightTop = { Garden_Straight01_top=1, Garden_Straight02_top=10, Garden_Straight03_top=2 },
    wallStraightBottom = {Garden_Straight01_bottom=5,Garden_Straight02_bottom=5,Garden_Straight03_bottom=1},
    tAmbientLightColor = {0.5, 0.5, 0.5 },
    tRoomLights =
    {
        _h1({0.5, 1, 0.8}, 3, 3, 3),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickbar',
    portrait = 'Zone_Garden',
})
Zone.INFIRMARY =
fill('Infirmary','outer01',
{
    name='Infirmary',
    description="ZONEUI048TEXT",
    floorNames={ 'infirmary01', },
    associatedJob=Character.DOCTOR,
    wallStraightTop = { Infirmary_Straight02_top=10, Infirmary_Straight01_top=3,Infirmary_Straight03_top=5, },
    wallStraightBottom = {Infirmary_Straight01_bottom=10,},
    tAmbientLightColor = { 0.65, 0.65, 0.65 },
    tRoomLights =
    {
        _h1({0.25, 0.25, 0.25 }, 5, 5, 4),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickbar',
    class='Zones.HospitalZone',
    portrait = 'Zone_Infirmary',
})
Zone.LIFESUPPORT =
fill('LifeSupport','cross',
{
    name='Life Support',
    description="ZONEUI002TEXT",
    floorNames={ 'lifesupport01','lifesupport02', },
    associatedJob=Character.TECHNICIAN,
	wallStraightTop = {LifeSupport_Straight01_top=40, LifeSupport_Straight02_top=1, LifeSupport_Straight03_top=2},
	wallStraightBottom = {LifeSupport_Straight01_bottom=1},
	wallCornerNBottom = {LifeSupport_Corner_outerr01_bottom=1},
	wallColumnBottom = {LifeSupport_Corner_outerr01_bottom=1},
    tAmbientLightColor = {0.2, 0.3, 0.6 },
    tRoomLights =
    {
        _h1({0.5, 0.5, 0.8}, 4, 4, 4),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clicklifesupport',
    portrait = 'Zone_LifeSupport',
})
Zone.RESIDENCE =
fill('Residence','cross',
{
    name='Residential Zone',
    description="ZONEUI043TEXT",
    floorNames={ 'Residence', },
	wallStraightTop = {Residence_Straight01_top=1, Residence_Straight02_top=10, Residence_Straight03_top=1},
    wallStraightBottom = {Residence_Straight01_bottom=1},
    tAmbientLightColor = { 0.52, 0.485, 0.41 },
    tRoomLights =
    {
        _h1({1.0, 0.6, 0.3}, 4, 5, 3),
    },
    class = 'Zones.BedZone',
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickresidence',
    portrait = 'Zone_Residence',
})
Zone.PUB =
fill('Pub','outer01',
{
    name='Pub',
    description="ZONEUI047TEXT",
    floorNames={ 'Bar', },
    associatedJob=Character.BARTENDER,
	wallStraightTop = {Pub_Straight01_top=1},
	wallStraightBottom = {Pub_Straight01_bottom=1},
    tAmbientLightColor = { 0.8, 0.5, 1.0  },
    tRoomLights =
    {
        _h1({0.4, 0.0, 1.0 }, 4, 4, 2),
    },
    sLightSpriteName = 'directionalcast',
    class='Zones.Pub',
    clickSound = 'clickbar',
    portrait = 'Zone_Pub',
})
Zone.POWER =
fill('Reactor','cross',
{
    name='Power Reactor',
    description="ZONEUI004TEXT",
    floorNames={ 'reactor02', 'reactor01', },
    associatedJob=Character.TECHNICIAN,
	wallStraightTop = {Reactor_Straight01_top=3, Reactor_Straight02_top=1},
	wallStraightBottom = {Reactor_Straight01_bottom=5, Reactor_Straight02_bottom=2},
    tAmbientLightColor = { 0.5, 0.2, 0.2 },
    tRoomLights =
    {
        _h1({1.0, 0.0, 0.0}, 4, 4, 2.5),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickreactor',
    portrait = 'Zone_Power',
})
Zone.AIRLOCK =
fill('Airlock','cross',
{
    name='Airlock',
    description="ZONEUI038TEXT",
    floorNames={ 'airlock02','airlock01', },
	wallStraightTop = {Airlock_Straight01_top=1, Airlock_Straight02_top=1, Airlock_Straight03_top=4, Airlock_Straight04_top=1},
	wallStraightBottom = {Airlock_Straight01_bottom=1, Airlock_Straight02_bottom=1},
    tAmbientLightColor = { 0.3, 0.5, 0.6 },
    tRoomLights =
    {
        _h1({0.1, 0.5, 0.2}, 4, 4, 2),
    },
    sLightSpriteName = 'directionalcast',
    class='Zones.Airlock',
    clickSound = 'clickairlock',
    portrait = 'Zone_Airlock',
})
Zone.REFINERY =
fill('Refinery','cross',
{
    name='Refinery',
    description="ZONEUI039TEXT",
    floorNames={ 'refinery01' },
    associatedJob=Character.MINER,
	wallStraightTop = {Refinery_Straight01_top=1},
	wallStraightBottom = {Refinery_Straight01_bottom=1},
    tAmbientLightColor = { .47/2, .44/2, .53/2 },
    tRoomLights =
    {
        _h1({ 1.0, 0.7, 0.4}, 5, 5, 3),
	},
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickrefinery',
    portrait = 'Zone_Refinery',
})
Zone.EXTERIOR =
fill('Exterior','cross',
{
    name='External',
    floorNames={ 'base01', },
	wallStraightTop = {Exterior_Straight01_top=4, Exterior_Straight02_top=15},
	wallStraightBottom = {Exterior_Straight01_bottom=5},
    tRoomLights =
    {
        _h1({0.8, 1.0, 0.2}, 3, 3, 3),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickunzoned',
})
Zone.CONSTRUCTION =
fill('Wireframe','cross',
{
    name='Construction',
    floorNames={ 'base01', },
	wallStraightTop = {Wireframe_Straight01_top=1},
	wallStraightBottom = {Wireframe_Straight01_bottom=1},
    tRoomLights =
    {
        _h1({0.8, 1.0, 0.2}, 3, 3, 3),
    },
})
Zone.FITNESS =
fill('Fitness','outer01',
{
    name='Fitness',
    description="ZONEUI110TEXT",
    floorNames={ 'airlock01', 'airlock02', },
    wallStraightTop = { Fitness_Straight01_top=10, Fitness_Straight02_top=1, },
    wallStraightBottom = {Fitness_Straight01_bottom=10,Fitness_Straight02_bottom=1,},
    tAmbientLightColor = { 0.6, 0.6, 0.6 },
    tRoomLights =
    {
        _h1({1.0, 1.0, 1.0}, 4, 4, 2),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickbar',
    class='Zones.FitnessZone',
    portrait = 'Zone_Fitness',
})
Zone.RESEARCH =
fill('Research','outer01',
{
    name='Research Lab',
    description="ZONEUI127TEXT",
    floorNames={ 'airlock01','airlock02', },
    associatedJob=Character.SCIENTIST,
    wallStraightTop = { Research_Straight02_top=2, Research_Straight01_top=1, },
    wallStraightBottom = {Research_Straight01_bottom=10,},
    tAmbientLightColor = { 0.3, 0.5, 0.6 },
    tRoomLights =
    {
        _h1({0.1*2, 0.5*2, 0.2*2}, 4, 4, 3),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickbar',
    class='Zones.ResearchZone',
    portrait = 'Zone_Research',
})
Zone.BRIG =
fill('Brig','outer01',
{
    name='Brig',
    description="ZONEUI146TEXT",
    floorNames={ 'brig01','brig02', 'brig02','brig02','brig02','brig02','brig02','brig02', 'brig03', },
    wallStraightTop = { Brig_Straight02_top=1, Brig_Straight01_top=2, },
    wallStraightBottom = {Brig_Straight01_bottom=5, Brig_Straight02_bottom=1},
    wallCornerNBottom = {Research_Corner_outer01_bottom=1},
    wallCornerEBottom = {Research_Corner_lb_bottom=1},
    tAmbientLightColor = { 0.4, 0.45, 0.5 },
    tRoomLights =
    {
        _h1({0.7, 0.5, 0.5}, 4, 4, 1),
    },
    sLightSpriteName = 'directionalcast',
    clickSound = 'clickbar',
    portrait = 'Zone_Unzoned',
    class='Zones.BrigZone',
})
Zone.tOrderedZoneList=
{
    'PLAIN','GARDEN','INFIRMARY','LIFESUPPORT','RESIDENCE','PUB','POWER',
	'AIRLOCK','REFINERY','FITNESS','RESEARCH','BRIG',
}
Zone.tZoneTypeLCs=
{
	PLAIN = 'ZONEUI005TEXT',
	GARDEN = 'ZONEUI069TEXT',
	INFIRMARY = 'ZONEUI049TEXT',
	LIFESUPPORT = 'ZONEUI001TEXT',
	RESIDENCE = 'ZONEUI042TEXT',
	PUB = 'ZONEUI046TEXT',
	POWER = 'ZONEUI003TEXT',
	AIRLOCK = 'ZONEUI036TEXT',
	REFINERY = 'ZONEUI037TEXT',
	FITNESS = 'ZONEUI109TEXT',
	RESEARCH = 'ZONEUI126TEXT',
	BRIG = 'ZONEUI142TEXT',
}
function Zone.getZoneDataForIdx(idx)
    local zoneData = Zone[ Zone.tOrderedZoneList[idx] ]
    return zoneData
end
function Zone.getUniqueZoneName(zoneName)
	if zoneName == 'POWER' then
		return Zone.getReactorName()
	elseif zoneName == 'LIFESUPPORT' then
		return Zone.getLifeSupportName()
	elseif zoneName == 'AIRLOCK' then
		return Zone.getAirlockName()
	elseif zoneName == 'RESIDENCE' then
		return Zone.getResidenceName()
	elseif zoneName == 'REFINERY' then
		return Zone.getRefineryName()
	elseif zoneName == 'PUB' then
		return Zone.getPubName()
    elseif zoneName == 'GARDEN' then
        return Zone.getGardenName()
    elseif zoneName == 'FITNESS' then
        return Zone.getFitnessName()
    elseif zoneName == 'RESEARCH' then
        return Zone.getResearchName()
    elseif zoneName == 'INFIRMARY' then
        return Zone.getInfirmaryName()
    elseif zoneName == 'BRIG' then
        return Zone.getBrigName()
	else
		return g_LM.line('ZONEUI108TEXT')
	end
end
function Zone.getBrigName()
	local name = g_LM.line('ZONEUI145TEXT')
	return name .. ' ' .. tostring(math.random(1, 99))
end
local greekLetters = { 'ZONEUI018TEXT', 'ZONEUI019TEXT', 'ZONEUI020TEXT', 'ZONEUI021TEXT', 'ZONEUI022TEXT', 'ZONEUI023TEXT', 'ZONEUI024TEXT', 'ZONEUI025TEXT', 'ZONEUI026TEXT', 'ZONEUI027TEXT', 'ZONEUI028TEXT', 'ZONEUI029TEXT', 'ZONEUI030TEXT', 'ZONEUI031TEXT', 'ZONEUI032TEXT', 'ZONEUI033TEXT' }
Zone.greekLetters = greekLetters
function Zone.getReactorName()
	local name = g_LM.line( 'ZONEUI034TEXT' )
	local letterCode = greekLetters[math.random( 1, #greekLetters-1 )]
	name = name .. ' ' .. g_LM.line( letterCode )
	return name
end
function Zone.getResearchName()
	local name = g_LM.line( 'ZONEUI128TEXT' )
	local letterCode = greekLetters[math.random( 1, #greekLetters-1 )]
	name = name .. ' ' .. g_LM.line( letterCode )
	return name
end
local constellations = { 'ZONEUI130TEXT', 'ZONEUI131TEXT', 'ZONEUI132TEXT', 'ZONEUI133TEXT', 'ZONEUI134TEXT', 'ZONEUI135TEXT', 'ZONEUI136TEXT', 'ZONEUI137TEXT', 'ZONEUI138TEXT', 'ZONEUI139TEXT', 'ZONEUI140TEXT', }
function Zone.getInfirmaryName()
	local name = g_LM.line( 'ZONEUI129TEXT' )
	local letterCode = constellations[math.random( 1, #constellations-1 )]
	name = name .. ' ' .. g_LM.line( letterCode )
	return name
end
function Zone.getLifeSupportName()
	local name = g_LM.line( 'ZONEUI035TEXT' )
	if math.random() < 0.01 then
		name = name .. ' 0451'
	else
		name = name .. ' ' .. math.random(0, 99)
		local letters = 'ABCDEFGHJKLMNPQRSTUVWXYZ'
		local letterIndex = math.random(1, #letters-1)
		name = name .. string.sub(letters, letterIndex, letterIndex)
	end
	return name
end
function Zone.getAirlockName()
	local name = g_LM.line( 'ZONEUI041TEXT' )
	local alpha = 'ABCDEFGHJKLMNPQRSTUVWXYZ'
	local idx = math.random(1, #alpha-1)
	name = name .. ' ' .. string.sub(alpha, idx, idx)
	return name
end
function Zone.getResidenceName()
	local name = g_LM.line('ZONEUI141TEXT')
	name = name .. ' ' .. tostring( math.random(1, 99))
	if math.random() < 0.5 then
		local lower = 'abcdefghjkmnpqrstuvwxyz'
		local idx = math.random(1, #lower-1)
		name = name .. string.sub(lower, idx, idx)
	end
	return name
end
function Zone.getRefineryName()
	local name = g_LM.line( 'ZONEUI068TEXT' ) .. ' '
	name = name .. tostring(math.random(10)-1)
	name = name .. tostring(math.random(10)-1)
	name = name .. tostring(math.random(10)-1)
	name = name .. tostring(math.random(10)-1)
	return name
end
local colors = { 'ZONEUI073TEXT', 'ZONEUI074TEXT', 'ZONEUI075TEXT', 'ZONEUI076TEXT', 'ZONEUI077TEXT', 'ZONEUI078TEXT', 'ZONEUI079TEXT', 'ZONEUI080TEXT', 'ZONEUI081TEXT', 'ZONEUI082TEXT', 'ZONEUI083TEXT', 'ZONEUI084TEXT', }
function Zone.getGardenName()
	return g_LM.line('ZONEUI085TEXT') .. ' ' .. g_LM.randomLine(colors)
end
local tMythologicalFigures = { 'ZONEUI114TEXT', 'ZONEUI115TEXT', 'ZONEUI116TEXT', 'ZONEUI117TEXT', 'ZONEUI118TEXT', 'ZONEUI119TEXT', 'ZONEUI120TEXT', 'ZONEUI121TEXT', 'ZONEUI122TEXT', 'ZONEUI123TEXT', 'ZONEUI124TEXT', 'ZONEUI125TEXT',}
function Zone.getFitnessName()
	return g_LM.line('ZONEUI113TEXT') .. ' ' .. g_LM.randomLine(tMythologicalFigures)
end
local tPubAdjectives = { 'ZONEUI087TEXT', 'ZONEUI088TEXT', 'ZONEUI089TEXT', 'ZONEUI090TEXT', 'ZONEUI091TEXT', 'ZONEUI092TEXT', 'ZONEUI093TEXT', 'ZONEUI094TEXT', 'ZONEUI095TEXT', 'ZONEUI096TEXT', 'ZONEUI097TEXT', }
local tPubNouns = { 'ZONEUI098TEXT', 'ZONEUI099TEXT', 'ZONEUI100TEXT', 'ZONEUI101TEXT', 'ZONEUI102TEXT', 'ZONEUI103TEXT', 'ZONEUI104TEXT', 'ZONEUI105TEXT', 'ZONEUI106TEXT', 'ZONEUI107TEXT', }
function Zone.getPubName()
	local name = g_LM.line('ZONEUI086TEXT') .. ' '
	name = name .. g_LM.randomLine(tPubAdjectives) .. ' '
	name = name .. g_LM.randomLine(tPubNouns)
	return name
end
function Zone.initZoneData()
    local EnvObjectData = require('EnvObjects.EnvObjectData')
    Zone.spriteSheet = DFGraphics.loadSpriteSheet(Zone.spriteSheetPath, false, false, true)
    for i,v in ipairs(Zone.tOrderedZoneList) do
        local tZoneData = Zone[v]
        tZoneData.indexes={}
        tZoneData.tValidObjectTypes = {}
        for _,spriteName in ipairs(tZoneData.floorNames) do
            table.insert(tZoneData.indexes,Zone.spriteSheet.names[spriteName])
        end
    end
    for k,v in pairs(EnvObjectData.tObjects) do
        if v.zoneName then
            table.insert(Zone[v.zoneName].tValidObjectTypes, k)
        end
    end
end
function Zone:init(rRoom)
    self.rRoom = rRoom
    self.sZoneName = rRoom:getZoneName()
	self.tThingsPowered = {}
    self.tOrderedThingsPowered = {}
end
function Zone:getRoom()
    return self.rRoom
end
function Zone:preTileUpdate()
end
function Zone:postTileUpdate()
end
function Zone:isFunctionalAirlock()
    return self.sZoneName == 'AIRLOCK' and self.bFunctional
end
function Zone:isCharAssigned()
    return false
end
function Zone:remove()
    self.bRemoved = true
    self.bDestroyed = true
end
function Zone:getActivityOptions(rChar, tObjects)
end
function Zone:getPowerOutput()
	local tPowerProducers = {}
	local nTotalPowerOutput = 0
	local tProps = self.rRoom:getProps()
	local EnvObject = require('EnvObjects.EnvObject')
	for rProp,_ in pairs(tProps) do
        local nOutput = rProp:getPowerOutput()
        if nOutput > 0 then
            nTotalPowerOutput = nTotalPowerOutput + nOutput
			tPowerProducers[rProp] = nOutput
        end
	end
    local tExtra = g_SpaceRoom:getExtraGeneratorsForRoom(self.rRoom.id)
	for _,rProp in ipairs(tExtra) do
        local nOutput = rProp:getPowerOutput()
        if nOutput > 0 then
            nTotalPowerOutput = nTotalPowerOutput + nOutput
			tPowerProducers[rProp] = nOutput
        end
	end
	local x,y = self.rRoom:getCenterTile()
	return nTotalPowerOutput, tPowerProducers
end
function Zone:isPowering(rRoomOrObj)
    return self.tThingsPowered[rRoomOrObj] ~= nil
end
function Zone:powerUnrequest(rRoomOrObj)
    if self.tThingsPowered[rRoomOrObj] then
        self.tThingsPowered[rRoomOrObj] = nil
        rRoomOrObj.rPowerRoom = nil
        for i = 1, #self.tOrderedThingsPowered do
		    if rRoomOrObj == self.tOrderedThingsPowered[i] then
			    table.remove(self.tOrderedThingsPowered, i)
			    break
		    end
	    end
    end
end
function Zone:onTick()
    for rObj,tData in pairs(self.tThingsPowered) do
        if rObj.bDestroyed then
            self:powerUnrequest(rObj)
        end
    end
end
function Zone:getAssociatedJob()
    local zoneDef = Zone[self.sZoneName]
    return zoneDef.associatedJob
end
function Zone:powerRequest(rRoomOrObj, nAmount, bNoPartial)
	local x,y = self.rRoom:getCenterTile()
	local cx,cy = rRoomOrObj:getTileLoc()
	local nDist = DFMath.distance2D(x, y, cx, cy)
    local tPowerUser
    if self.tThingsPowered[rRoomOrObj] then
        tPowerUser = self.tThingsPowered[rRoomOrObj]
    else
        tPowerUser = {}
        self.tThingsPowered[rRoomOrObj] = tPowerUser
        table.insert(self.tOrderedThingsPowered, rRoomOrObj)
    end
    rRoomOrObj.rPowerRoom = self.rRoom
    tPowerUser.nDist = nDist
    tPowerUser.nTiebreaker = cx * 1000 + cy
    tPowerUser.nPowerRequested = nAmount
	local f = function(x,y)
        if self.tThingsPowered[x].nDist == self.tThingsPowered[y].nDist then
            return self.tThingsPowered[x].nTiebreaker < self.tThingsPowered[y].nTiebreaker
        end
        return self.tThingsPowered[x].nDist < self.tThingsPowered[y].nDist
    end
	table.sort(self.tOrderedThingsPowered, f)
	local nTotalPowerOutput = self:getPowerOutput()
	local i = 1
	while i <= #self.tOrderedThingsPowered and nTotalPowerOutput > 0 do
        local rObj = self.tOrderedThingsPowered[i]
		local tPowerUser = self.tThingsPowered[rObj]
		nTotalPowerOutput = nTotalPowerOutput - tPowerUser.nPowerRequested
		if rObj == rRoomOrObj then
			if nTotalPowerOutput >= 0 then
                tPowerUser.nPowerGranted = nAmount
				return nAmount
			else
                if bNoPartial then
                    self:powerUnrequest(rObj)
                    tPowerUser.nPowerGranted = 0
                    return 0
                else
                    tPowerUser.nPowerGranted = nAmount + nTotalPowerOutput
				    return nAmount + nTotalPowerOutput
                end
			end
		end
		i = i + 1
	end
    if bNoPartial then
        self:powerUnrequest(rRoomOrObj)
    end
    tPowerUser.nPowerGranted = 0
	return 0
end
return Zone
