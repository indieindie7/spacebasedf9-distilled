local GameRules = require('GameRules')
local CharacterManager = require('CharacterManager')
local Character = require('CharacterConstants')
local ObjectList = require('ObjectList')
local EnvObject = require('EnvObjects.EnvObject')
local CommandObject = require('Utility.CommandObject')
local Room = require('Room')
local Door = require('EnvObjects.Door')
local Character = require('Character')
local DFUtil=require('DFCommon.Util')
local HydroPlant=require('EnvObjects.HydroPlant')
local Base=require('Base')
local Malady=require('Malady')
local InventoryData=require('InventoryData')
local HintChecks = {}
HintChecks.log = false
HintChecks.LOW_MATTER_WARNING = 500
HintChecks.ACCIDENT_TIMEOUT = 20
HintChecks.DERELICT_WARN_DELAY = 20
HintChecks.REC_PLANTS_PER_BOTANIST = 6
function HintChecks.waitingAtBeacon()
    if g_ERBeacon and g_ERBeacon:timeWaited() > 30 then
        return true
    end
end
function HintChecks.dontPutNormalDoorsOnAnAirlock()
    if HintChecks.noFunctioningAirlocks() then
	    for _,room in pairs(Room.tRooms) do
		    if room.zoneName == 'AIRLOCK' then
                if room.zoneObj.bBadDoor then
                    return true
                end
            end
        end
    end
end
function HintChecks.youCanForceOpenADoor()
    if HintChecks.noFunctioningAirlocks() and not HintChecks.dontPutNormalDoorsOnAnAirlock() then
	    for _,room in pairs(Room.tRooms) do
		    if room.zoneName == 'AIRLOCK' then
                local zo = room.zoneObj
                if zo and zo.rSpaceDoor and not zo.rSpaceDoor.bDestroyed and zo.rSpaceDoor.bValidAirlock and zo.rSpaceDoor.doorState == Door.doorStates.LOCKED then
                    return true
                end
            end
        end
    end
end
function HintChecks.notEnoughTechnicians()
	local techs = CharacterManager.tJobCount[Character.TECHNICIAN]
    if EnvObject.nDamagedObjects > techs/6 and EnvObject.nTotalDecay > techs * .5 then
		return true
    end
	return false
end
function HintChecks.lowMatter()
	return GameRules.nMatter < HintChecks.LOW_MATTER_WARNING
end
function HintChecks.pendingConstruction()
	for addr,cmdObj in pairs(CommandObject.tCommands) do
		if cmdObj.param ~= -1 and (cmdObj.commandAction == CommandObject.COMMAND_BUILD_TILE or cmdObj.commandAction == CommandObject.COMMAND_VAPORIZE) then
			return true
		end
	end
	for _,rRoom in pairs(Room.tRooms) do
		if not rRoom.bDestroyed then
			for addr,rProp in pairs(rRoom.tPropPlacements) do
				return true
			end
			for rProp,_ in pairs(rRoom.tProps) do
				if rProp.bSlatedForVaporize then
					return true
				end
			end
		end
	end
	return false
end
function HintChecks.noBuilders()
	CharacterManager.updateOwnedCharacters()
	if CharacterManager.tJobCount[Character.BUILDER] ~= 0 then
		return false
	end
	return HintChecks.pendingConstruction()
end
function HintChecks.noMiners()
	local miners = CharacterManager.tJobCount[Character.MINER]
	for addr,cmdObj in pairs(CommandObject.tCommands) do
		if cmdObj.param ~= -1 and cmdObj.commandAction == CommandObject.COMMAND_MINE and miners == 0 then
			return true
		end
	end
	return false
end
function HintChecks.minersNoMining()
	if CharacterManager.tJobCount[Character.MINER] == 0 then
		return false
	end
	local tRefineries,nRefineries = EnvObject.getObjectsOfFunctionality('Shelving', true)
	if nRefineries == 0 then
		return false
	end
	for addr,cmdObj in pairs(CommandObject.tCommands) do
		if cmdObj.param ~= -1 and cmdObj.commandAction == CommandObject.COMMAND_MINE then
			return false
		end
	end
	return true
end
function HintChecks.noRefineries()
	if CharacterManager.tJobCount[Character.MINER] == 0 then
		return false
	end
	local hasRock = false
	local tChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	for _,char in pairs(tChars) do
		if char:getInventoryCountByTemplate(InventoryData.MINE_PICKUP_NAME) > 0 then
			hasRock = true
			break
		end
	end
	if not hasRock then
		return false
	end
	local hasRefinery = false
	local tRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
	for room,_ in pairs(tRooms) do
		if room.zoneName == 'REFINERY' then
			hasRefinery = true
			break
		end
	end
	return not hasRefinery
end
function HintChecks.lowOxygen()
	if HintChecks.noRooms() then
		return false
	end
    CharacterManager.updateOwnedCharacters()
	local tChars = CharacterManager.getOwnedCharacters()
    local nSadDudes = 0
    if #tChars == 1 then
        return tChars[1].nAverageOxygen <= Character.MORALE_LOW_OXYGEN_THRESHOLD
    else
        for _, char in pairs(tChars) do
            if char.nAverageOxygen < Character.MORALE_LOW_OXYGEN_THRESHOLD then nSadDudes = nSadDudes + 1 end
        end
        return nSadDudes >= (#tChars/2)
    end
end
function HintChecks.roomsButNoOxygen()
	if HintChecks.noEnclosedRooms() then
		return false
	end
	local nRecyclers = EnvObject.getNumberOfObjects('OxygenRecycler', true)
	local nLvl2Recyclers = EnvObject.getNumberOfObjects('OxygenRecyclerLevel2', true)
	return (nRecyclers + nLvl2Recyclers) == 0
end
function HintChecks.notEnoughBeds()
	local tFloorSleepers = CharacterManager.getOwnedCharactersWithTask('SleepOnFloor')
	if #tFloorSleepers == 0 then
		return false
	end
	local beds = EnvObject.getNumberOfObjects('Bed')
	local chars = CharacterManager.getOwnedCharacters()
	return beds < DFUtil.tableSize(chars)
end
function HintChecks.noFunctioningAirlocks()
	if HintChecks.noRooms() and not HintChecks.roomsButNoOxygen() then
		return false
	elseif not GameRules.bHasHadEnclosedRooms then
		return false
	end
	for _,room in pairs(Room.tRooms) do
		if room.zoneName == 'AIRLOCK' and room.zoneObj.bFunctional then
			return false
		end
	end
	return true
end
function HintChecks.noRooms()
	return DFUtil.tableSize(Room.tRooms) == 0
end
function HintChecks.noEnclosedRooms()
	local nBreachedRooms = 0
	for _,room in pairs(Room.tRooms) do
		if room:isBreached() then
			nBreachedRooms = nBreachedRooms + 1
		end
	end
	if not GameRules.bHasHadEnclosedRooms and nBreachedRooms < DFUtil.tableSize(Room.tRooms) then
		GameRules.bHasHadEnclosedRooms = true
	end
	return nBreachedRooms == DFUtil.tableSize(Room.tRooms)
end
function HintChecks.noBuilding()
	if not HintChecks.noRooms() then
		return false
	end
	for addr,cmdObj in pairs(CommandObject.tCommands) do
		if cmdObj.commandAction == CommandObject.COMMAND_BUILD_TILE then
			return false
		end
	end
	return true
end
function HintChecks.everyoneDead()
	CharacterManager.updateOwnedCharacters()
	local tChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	return #tChars == 0
end
function HintChecks.pubAtCapacity()
	local tRooms = Room.getSafeRoomsOfTeam(Character.TEAM_ID_PLAYER)
	for room,idx in pairs(tRooms) do
		if room.zoneName == 'PUB' and room.zoneObj:getCapacity() > 0 and room.zoneObj:atCapacity() then
			return true
		end
	end
	return false
end
function HintChecks.pubButNoBar()
	local tRooms = Room.getSafeRoomsOfTeam(Character.TEAM_ID_PLAYER)
	for room,idx in pairs(tRooms) do
		if room.zoneName == 'PUB' then
			if not room.zoneObj:hasBar() then
				return true
			end
		end
	end
	return false
end
function HintChecks.failedDutyAccident()
	if GameRules.nLastDutyAccident == 0 then
		return false
	end
	return GameRules.nLastDutyAccident + HintChecks.ACCIDENT_TIMEOUT > GameRules.elapsedTime
end
function HintChecks.derelictNoBeacon()
	if GameRules.nLastNewShip == 0 then
		return false
	end
	return not g_ERBeacon.tx and GameRules.nLastNewShip + HintChecks.DERELICT_WARN_DELAY > GameRules.elapsedTime
end
function HintChecks.beaconNoSecurity()
	return g_ERBeacon.tx and CharacterManager.tJobCount[Character.EMERGENCY] == 0
end
function HintChecks.fireNoExtinguisher()
	local tFireStompers = CharacterManager.getOwnedCharactersWithTask('ExtinguishFireBareHanded')
	if #tFireStompers == 0 then
		return false
	end
	for _,char in pairs(tFireStompers) do
        local rRoom = char:getRoom()
		if rRoom and rRoom ~= Room.getSpaceRoom() and not rRoom:hasObjectOfType('FirePanel') then
			return true
		end
	end
	return false
end
function HintChecks.roomButNeverZoned()
	if GameRules.bHasZoned or HintChecks.noEnclosedRooms() then
		return false
	end
	local nZonedRooms = 0
	local tRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
	for room,_ in pairs(tRooms) do
		if room.zoneName ~= 'PLAIN' then
			nZonedRooms = nZonedRooms + 1
			if not GameRules.bHasZoned then
				GameRules.bHasZoned = true
			end
		end
	end
	return nZonedRooms == 0
end
function HintChecks.getNumSeededPlants()
	local tPlants = EnvObject.getObjectsOfType('HydroPlant', true)
	local nSeeded = 0
	for _,plant in pairs(tPlants) do
		if plant.bSeeded then
			nSeeded = nSeeded + 1
		end
	end
	return nSeeded
end
function HintChecks.starvingNoMatter()
	local tStarvers = CharacterManager.getOwnedCharactersWithTask('Starve')
	if #tStarvers == 0 then
		return false
	end
	local tReplicators = EnvObject.getObjectsOfType('FoodReplicator', true)
	for _,rReplicator in pairs(tReplicators) do
		local bCanBuy, sReason = rReplicator:canBuyFood()
		if not bCanBuy and sReason == 'insufficient matter' then
			return true
		end
	end
	return false
end
function HintChecks.starvingNoFood()
	local nReplicators = EnvObject.getNumberOfObjects('FoodReplicator', true)
	if nReplicators > 0 then
		return false
	end
	local nHydroPlants = EnvObject.getNumberOfObjects('HydroPlant', true)
	if nHydroPlants > 0 and HintChecks.getNumSeededPlants() > 0 then
		return false
	end
    CharacterManager.updateOwnedCharacters()
	local tChars = CharacterManager.getOwnedCharacters()
	for _,char in pairs(tChars) do
		if char.tStatus.nStarveTime > 0 then
			return true
		end
	end
	return false
end
function HintChecks.gardenNoBotanist()
	local nHydroPlants = EnvObject.getNumberOfObjects('HydroPlant', true)
	if nHydroPlants == 0 then
		return false
	end
	if CharacterManager.tJobCount[Character.BOTANIST] == 0 then
		return true
	end
	return false
end
function HintChecks.notEnoughBotanists()
	local nHydroPlants = EnvObject.getNumberOfObjects('HydroPlant', true)
	if nHydroPlants == 0 then
		return false
	end
	local nBotanists = CharacterManager.tJobCount[Character.BOTANIST]
	local tPlants = EnvObject.getObjectsOfType('HydroPlant', true)
	for _,plant in pairs(tPlants) do
		if plant.bSeeded and plant.nPlantHealth <= HydroPlant.DEAD_PLANT_HEALTH then
			if nBotanists == 0 or nBotanists / nHydroPlants < HintChecks.REC_PLANTS_PER_BOTANIST then
				return true
			end
		end
	end
	return false
end
function HintChecks.haveFoodPrepObjects()
	local nBotanists = CharacterManager.tJobCount[Character.BOTANIST]
	local nBartenders = CharacterManager.tJobCount[Character.BARTENDER]
	local nStoves = EnvObject.getNumberOfObjects('Stove', true)
	local nFridges = EnvObject.getNumberOfObjects('Fridge', true)
	return nBotanists > 0 and nBartenders > 0 and nStoves > 0 and nFridges > 0
end
function HintChecks.noFoodPathable()
	local tStarvers = CharacterManager.getOwnedCharactersWithTask('Starve')
	return not HintChecks.starvingNoFood() and not HintChecks.starvingNoMatter() and #tStarvers > 0
end
function HintChecks.cropsNoFoodPrep()
	local nHydroPlants = EnvObject.getNumberOfObjects('HydroPlant', true)
	if nHydroPlants == 0 then
		return false
	end
	local tPlants = EnvObject.getObjectsOfType('HydroPlant', true)
	local nRipePlants = 0
	for _,plant in pairs(tPlants) do
		if plant.nPlantAge == plant.rPlantData.nLifeTime then
			nRipePlants = nRipePlants + 1
		end
	end
	return nRipePlants > 0 and not HintChecks.haveFoodPrepObjects()
end
function HintChecks.mealNoTables()
	local nTables = EnvObject.getNumberOfObjects('StandingTable', true)
	return nTables == 0 and HintChecks.haveFoodPrepObjects()
end
function HintChecks.activeResearch()
	local tRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
	for room,_ in pairs(tRooms) do
		if room.zoneName == 'RESEARCH' then
			if room.zoneObj.sCurrentResearch then
				return true
			end
		end
	end
	return false
end
function HintChecks.researchReadyNoResearch()
	local nScientists = CharacterManager.tJobCount[Character.SCIENTIST]
	if nScientists == 0 then
		return false
	end
	local nDesks = EnvObject.getNumberOfObjects('ResearchDesk', true)
	if nDesks == 0 then
		return false
	end
	local _,nProjects = Base.getAvailableResearch()
	return nProjects > 0 and not HintChecks.activeResearch()
end
function HintChecks.researchNoDesks()
	local nScientists = CharacterManager.tJobCount[Character.SCIENTIST]
	if nScientists == 0 then
		return false
	end
	local nDesks = EnvObject.getNumberOfObjects('ResearchDesk', true)
	return HintChecks.activeResearch() and nDesks == 0
end
function HintChecks.researchNoScientists()
	local nScientists = CharacterManager.tJobCount[Character.SCIENTIST]
	return HintChecks.activeResearch() and nScientists == 0
end
function HintChecks.unclaimedResearchDatacubes()
	local tCubes = EnvObject.getObjectsOfType('ResearchDatacube', true, true)
	for _,cube in pairs(tCubes) do
		if not cube:slatedForTeardown(true) and cube.rRoom and cube.rRoom.nLastVisibility == g_World.VISIBILITY_FULL then
			return true
		end
	end
	return false
end
function HintChecks.claimedResearchDatacubesNoScientists()
	local nScientists = CharacterManager.tJobCount[Character.SCIENTIST]
	if nScientists > 0 then
		return false
	end
	local tCubes = EnvObject.getObjectsOfType('ResearchDatacube', true, true)
	for _,cube in pairs(tCubes) do
		if not cube:slatedForTeardown(true) then
			return true
		end
	end
	return false
end
function HintChecks.claimedResearchDatacubesNoDesks()
	local nDesks = EnvObject.getNumberOfObjects('ResearchDesk', true)
	if nDesks > 0 then
		return false
	end
	local tCubes = EnvObject.getObjectsOfType('ResearchDatacube', true, true)
	for _,cube in pairs(tCubes) do
		if not cube:slatedForTeardown(true) then
			return true
		end
	end
	return false
end
function HintChecks.haveCorpse()
    return EnvObject.getNumberOfObjects('Corpse') > 0
end
function HintChecks.corpseNoRefinery()
    if not HintChecks.haveCorpse() then
        return false
    end
	local nRefineries = EnvObject.getNumberOfObjects('RefineryDropoff')
    nRefineries = nRefineries + EnvObject.getNumberOfObjects('RefineryDropoffLevel2')
    return nRefineries == 0
end
function HintChecks.haveDoctor()
    if CharacterManager.tJobCount[Character.DOCTOR] == 0 then
        return false
    end
    local tChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
    local nDoctors = 0
	for _,rChar in pairs(tChars) do
        if rChar:getJob() == Character.DOCTOR and not Malady.isIncapacitated(rChar) then
            return true
        end
    end
    return false
end
function HintChecks.corpseNoDoctor()
    if HintChecks.haveDoctor() then
        return false
    end
    return HintChecks.haveCorpse()
end
function HintChecks.patientNoDoctor()
    if HintChecks.haveDoctor() then
        return false
    end
    local tPatients = CharacterManager.getOwnedCharactersWithTask('CheckInToHospital')
    return #tPatients > 0
end
function HintChecks.illnessNoDoctor()
    if HintChecks.haveDoctor() then
        return false
    end
	local tChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	for _,rChar in pairs(tChars) do
        for sName,tMalady in pairs(rChar.tStatus.tMaladies) do
            if tMalady.bSymptomatic then
                return true
            end
        end
    end
    return false
end
function HintChecks.illnessNoCureResearched()
	local tChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	for _,rChar in pairs(tChars) do
        for sName,tMalady in pairs(rChar.tStatus.tMaladies) do
            if tMalady.bDiagnosed and not Malady.hasDiscoveredCure(sName) then
                return true
            end
        end
    end
    return false
end
function HintChecks.citizenIncapacitatedNoDoctor()
    if HintChecks.haveDoctor() then
        return false
    end
	local tChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	for _,rChar in pairs(tChars) do
        if Malady.isIncapacitated(rChar) then
            return true
        end
    end
    return false
end
function HintChecks.noPower()
	local tRooms,nRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
	if nRooms == 0 then
		return false
	end
	for rRoom,_ in pairs(tRooms) do
		if rRoom:hasPower() then
			return false
		end
	end
	return true
end
function HintChecks.lowPower()
	local tRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
	if HintChecks.noPower() then
		return false
	end
	for rRoom,_ in pairs(tRooms) do
		if not rRoom:hasFullPower() then
			return true
		end
	end
	return false
end
function HintChecks.airlockNoLocker()
	local tAirlocks,nAirlocks = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER, false, 'AIRLOCK')
	if nAirlocks == 0 then
		return false
	end
	for rRoom,_ in pairs(tAirlocks) do
		local bHasLocker = false
		for rProp,_ in pairs(rRoom.tProps) do
			if rProp.sName == 'AirlockLocker' and not rProp.bSlatedForVaporize then
				bHasLocker = true
			end
		end
		if not bHasLocker then
			return true
		end
	end
	return false
end
function HintChecks.citizenLowDutyAffinity()
	local tChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	for _,rChar in pairs(tChars) do
		if rChar:getJobAffinity(rChar.tStats.nJob) <= -8 then
			return true, {CITIZEN = rChar.tStats.sName}
		end
	end
	return false
end
function HintChecks.unassignedResidences()
	local tBeds,nBeds = EnvObject.getObjectsOfType('Bed', true)
	if nBeds == 0 then
		return false
	end
	local tChars,nChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	if nBeds <= nChars then
		return false
	end
	for _,rBed in pairs(tBeds) do
		if rBed:getOwner() == nil then
			return true
		end
	end
	return false
end
function HintChecks.noShelving()
	local tChars,nChars = CharacterManager.getTeamCharacters(Character.TEAM_ID_PLAYER)
	local nStuffInWorld = 0
	for _,rChar in pairs(tChars) do
		nStuffInWorld = nStuffInWorld + rChar:getNumOwnedStuff()
	end
	if nStuffInWorld <= 8 then
		return false
	end
	local tShelves,nShelves = EnvObject.getObjectsOfFunctionality('Shelving', true)
	if nShelves == 0 then
		return true
	end
	local nCapacity = 0
	for _,rShelf in pairs(tShelves) do
		if rShelf.tData.tDisplaySlots then
			nCapacity = nCapacity + #rShelf.tData.tDisplaySlots
		end
	end
	Base.nCurrentStuff = nStuffInWorld
	Base.nCurrentShelvingCapacity = nCapacity
	return nStuffInWorld > nCapacity
end
function HintChecks.powerHoliday()
	return g_PowerHoliday and HintChecks.lowPower()
end
function HintChecks.incapacitatedTroublemaker()
	local tChars = CharacterManager.getCharacters()
	for _,rChar in pairs(tChars) do
		if rChar:hasUtilityStatus(Character.STATUS_RAMPAGE) and Malady.isIncapacitated(rChar) and not rChar.tStatus.tAssignedToBrig then
			return true
		end
	end
	return false
end
return HintChecks
