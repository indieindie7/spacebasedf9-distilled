local function _h1(a0,a1,a2,a3,a4) return {sName=a0,sNameLC=a1,sDescLC=a2,checkFn=a3,nTarget=a4} end
local GameRules = require('GameRules')
local Base = require('Base')
local EnvObject = require('EnvObjects.EnvObject')
local EnvObjectData = require('EnvObjects.EnvObjectData')
local Room = require('Room')
local ResearchData = require('ResearchData')
local CharacterManager = require('CharacterManager')
local Character = require('CharacterConstants')
local InventoryData = require('InventoryData')
local EventController = require('EventController')
local Malady = require('Malady')
local GoalData = {}
GoalData.TARGET_CITIZENS = 50
GoalData.TARGET_MATTER = 50000
GoalData.TARGET_HOSTILES_KILLED = 50
GoalData.TARGET_BASE_TILES = 3000
GoalData.TARGET_ENVOBJECT_TYPES = 34
GoalData.TARGET_MEALS = 1000
GoalData.TARGET_CURES = 10
GoalData.TARGET_TECHS = 13
GoalData.TARGET_HAPPY_CITIZENS = 30
GoalData.TARGET_BREACH_SHIPS = 5
GoalData.TARGET_POSSESSIONS = 30
GoalData.TARGET_RAIDERS_CONVERTED = 10
GoalData.TARGET_HOSTILES_ASPHYXIATED = 10
GoalData.TARGET_HOSTILE_TURRET_KILLS = 20
GoalData.TARGET_BODIES = 100
GoalData.TARGET_HOSTILE_MONSTER_KILLS = 10
function GoalData.citizens()
	local _,nCitizens = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	return nCitizens >= GoalData.TARGET_CITIZENS, nCitizens
end
function GoalData.matter()
	return GameRules.nMatter >= GoalData.TARGET_MATTER, GameRules.nMatter
end
function GoalData.builtEverything()
	local nTotalTypes,nTypesBuilt = 0,0
	for sObj,tObjData in pairs(EnvObjectData.tObjects) do
		if tObjData.showInObjectMenu ~= false then
			nTotalTypes = nTotalTypes + 1
			local tObjects,nObjects = EnvObject.getObjectsOfType(sObj, true)
			if nObjects > 0 then
				nTypesBuilt = nTypesBuilt + 1
			end
		end
	end
	return nTypesBuilt >= nTotalTypes, nTypesBuilt
end
function GoalData.hostilesKilled()
	return Base.tS.tStats.nHostilesKilled >= GoalData.TARGET_HOSTILES_KILLED, Base.tS.tStats.nHostilesKilled
end
function GoalData.baseTiles()
	local nTiles = Room.getNumOwnedTiles()
	return nTiles >= GoalData.TARGET_BASE_TILES, nTiles
end
function GoalData.mealsServed()
	return Base.tS.tStats.nMealsServed >= GoalData.TARGET_MEALS, Base.tS.tStats.nMealsServed
end
function GoalData.curesResearched()
	return Base.tS.tStats.nCuresResearched >= GoalData.TARGET_CURES, Base.tS.tStats.nCuresResearched
end
function GoalData.allTechs()
	local nTotalTechs,nTechsResearched = 0,0
	for sProject,tProjectData in pairs(ResearchData) do
		if not tProjectData.bDiscoverOnly then
			nTotalTechs = nTotalTechs + 1
			if Base.hasCompletedResearch(sProject) then
				nTechsResearched = nTechsResearched + 1
			end
		end
	end
	return nTechsResearched >= nTotalTechs, nTechsResearched
end
function GoalData.happyCitizens()
	local tCitizens = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	local nHappyCitizens = 0
	local nHappyThreshold = 90
	for _,rChar in pairs(tCitizens) do
		if rChar.tStats.nMorale > nHappyThreshold then
			nHappyCitizens = nHappyCitizens + 1
		end
	end
	return nHappyCitizens >= GoalData.TARGET_HAPPY_CITIZENS, nHappyCitizens
end
function GoalData.breachShipsDestroyed()
	return Base.tS.tStats.nBreachShipsDestroyed >= GoalData.TARGET_BREACH_SHIPS, Base.tS.tStats.nBreachShipsDestroyed
end
function GoalData.allPossessions()
	local nTotalItems,nItemsCollected = 0,0
	local tItems = {}
	for sItemType,tItemData in pairs(InventoryData.tTemplates) do
		if tItemData.bStuff and tItemData.bDisplayable then
			nTotalItems = nTotalItems + 1
			tItems[sItemType] = nTotalItems
		end
	end
	for id,rRoom in pairs(Room.tRooms) do
		if rRoom:playerOwned() then
			for rProp,_ in pairs(rRoom.tProps) do
				if rProp.tInventory then
					for sItem,tInvData in pairs(rProp.tInventory) do
						if tItems[tInvData.sTemplate] then
							tItems[tInvData.sTemplate] = nil
							nItemsCollected = nItemsCollected + 1
						end
					end
				end
			end
		end
	end
	return nItemsCollected >= nTotalItems, nItemsCollected
end
function GoalData.raidersConverted()
	return Base.tS.tStats.nRaidersConverted >= GoalData.TARGET_RAIDERS_CONVERTED, Base.tS.tStats.nRaidersConverted
end
function GoalData.hostilesAsphyxiated()
	return Base.tS.tStats.nHostilesAsphyxiated >= GoalData.TARGET_HOSTILES_ASPHYXIATED, Base.tS.tStats.nHostilesAsphyxiated
end
function GoalData.hostilesKilledByTurrets()
	return Base.tS.tStats.nHostilesKilledByTurret >= GoalData.TARGET_HOSTILE_TURRET_KILLS, Base.tS.tStats.nHostilesKilledByTurret
end
function GoalData.bodiesRefined()
	return Base.tS.tStats.nCorpsesRecycled >= GoalData.TARGET_BODIES, Base.tS.tStats.nCorpsesRecycled
end
function GoalData.finalSiege()
	if not EventController.tS.bRanMegaEvent then
		return false, 0
	end
	if GameRules.elapsedTime < EventController.tS.nMegaEventStartTime + 120 then
		return false, 0
	end
	local tCitizens = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	local bFriendlySurvivor = false
	for _,rChar in pairs(tCitizens) do
		if not Malady.isIncapacitated(rChar) and not rChar:isDead() then
			if rChar.rCurrentRoom and not rChar.rCurrentRoom:isDangerous() then
				bFriendlySurvivor = true
				break
			end
		end
	end
	if not bFriendlySurvivor then
		return false, 0
	end
	local tHostiles = CharacterManager.getHostileCharacters(tCitizens[1])
	for _,rChar in pairs(tHostiles) do
		if not Malady.isIncapacitated(rChar) or not rChar:isDead() then
			return false, 0
		end
	end
	return true, 1
end
GoalData.tGoals =
{
    _h1('Citizens', 'GOALSS001TEXT', 'GOALSS002TEXT', GoalData.citizens, GoalData.TARGET_CITIZENS),
	_h1('Matter', 'GOALSS003TEXT', 'GOALSS004TEXT', GoalData.matter, GoalData.TARGET_MATTER),
	_h1('BuiltEverything', 'GOALSS005TEXT', 'GOALSS006TEXT', GoalData.builtEverything, GoalData.TARGET_ENVOBJECT_TYPES),
	_h1('HostilesKilled', 'GOALSS007TEXT', 'GOALSS008TEXT', GoalData.hostilesKilled, GoalData.TARGET_HOSTILES_KILLED),
	_h1('BaseTiles', 'GOALSS010TEXT', 'GOALSS011TEXT', GoalData.baseTiles, GoalData.TARGET_BASE_TILES),
	_h1('MealsServed', 'GOALSS017TEXT', 'GOALSS018TEXT', GoalData.mealsServed, GoalData.TARGET_MEALS),
	_h1('CuresResearched', 'GOALSS015TEXT', 'GOALSS016TEXT', GoalData.curesResearched, GoalData.TARGET_CURES),
	_h1('AllTechs', 'GOALSS019TEXT', 'GOALSS020TEXT', GoalData.allTechs, GoalData.TARGET_TECHS),
	_h1('HappyCitizens', 'GOALSS021TEXT', 'GOALSS022TEXT', GoalData.happyCitizens, GoalData.TARGET_HAPPY_CITIZENS),
	_h1('BreachShipsDestroyed', 'GOALSS023TEXT', 'GOALSS024TEXT', GoalData.breachShipsDestroyed, GoalData.TARGET_BREACH_SHIPS),
	_h1('AllPossessions', 'GOALSS025TEXT', 'GOALSS026TEXT', GoalData.allPossessions, GoalData.TARGET_POSSESSIONS),
	_h1('RaidersConverted', 'GOALSS027TEXT', 'GOALSS028TEXT', GoalData.raidersConverted, GoalData.TARGET_RAIDERS_CONVERTED),
	_h1('HostilesAsphyxiated', 'GOALSS029TEXT', 'GOALSS030TEXT', GoalData.hostilesAsphyxiated, GoalData.TARGET_HOSTILES_ASPHYXIATED),
	_h1('HostilesKilledByTurrets', 'GOALSS035TEXT', 'GOALSS036TEXT', GoalData.hostilesKilledByTurrets, GoalData.TARGET_HOSTILE_TURRET_KILLS),
	_h1('BodiesRefined', 'GOALSS031TEXT', 'GOALSS032TEXT', GoalData.bodiesRefined, GoalData.TARGET_BODIES),
	_h1('FinalSiege', 'GOALSS037TEXT', 'GOALSS038TEXT', GoalData.finalSiege, 1),
}
return GoalData
