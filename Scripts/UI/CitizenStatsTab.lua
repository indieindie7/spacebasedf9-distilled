local m = {}
local DFUtil = require("DFCommon.Util")
local DFInput = require('DFCommon.Input')
local Character = require('CharacterConstants')
local Topics = require('Topics')
local UIElement = require('UI.UIElement')
local Malady = require('Malady')
local sUILayoutFileName = 'UILayouts/CitizenStatsTabLayout'
local FRIENDS_LIST_MAX_LENGTH = 4
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    Ob.rCitizen = nil
    Ob.bDoRolloverCheck = true
    function Ob:init()
        self:processUIInfo(sUILayoutFileName)
        Ob.Parent.init(self)
        self.rJoinDateText = self:getTemplateElement('JoinDateText')
        self.rIllnessText = self:getTemplateElement('IllnessText')
        self.rInjuryText = self:getTemplateElement('InjuryText')
        self.rInventoryText = self:getTemplateElement('InventoryText')
		self.rHobbyText = self:getTemplateElement('HobbyText')
        self.rFoodText = self:getTemplateElement('FoodText')
        self.rBandText = self:getTemplateElement('BandText')
        self.rStuffText = self:getTemplateElement('StuffText')
        self.rFriendsText = self:getTemplateElement('FriendsText')
        self.rEnemiesText = self:getTemplateElement('EnemiesText')
        self.rHostileKillsText = self:getTemplateElement('HostileKillsText')
        self.rFlavorText1Text = self:getTemplateElement('FlavorText1Text')
		self.rIllnessButton = self:getTemplateElement('IllnessButton')
        self.rIllnessButton:addPressedCallback(self.onIllnessButtonPressed, self)
    end
    function Ob:onTick(dt)
        if not self.rCitizen then
			return
		end
		self.rIllnessButton:setEnabled(false)
		if self.bHostileMode then
			if self.rCitizen.tStats and self.rCitizen.tStats.tHistory and self.rCitizen.tStats.tHistory.nTotalKills then
				self.rHostileKillsText:setString(tostring(self.rCitizen.tStats.tHistory.nTotalKills))
			else
				self.rHostileKillsText:setString("0")
			end
			if not self.rCitizen.tFlavorStats then
				self.rCitizen.tFlavorStats = {}
			end
			if not self.rCitizen.tFlavorStats.sNumBasesAttacked then
				self.rCitizen.tFlavorStats.sNumBasesAttacked = tostring(math.random(1, 100))
			end
			self.rFlavorText1Text:setString(self.rCitizen.tFlavorStats.sNumBasesAttacked)
			return
		end
		local faveHobby = self.rCitizen:getFavorite('Activities')
		if faveHobby then
			self.rHobbyText:setString(Topics.tTopics[faveHobby].name)
		end
		local faveFood = self.rCitizen:getFavorite('Foods')
		if faveFood then
			self.rFoodText:setString(Topics.tTopics[faveFood].name)
		end
		local faveBand = self.rCitizen:getFavorite('Bands')
		if faveBand then
			self.rBandText:setString(Topics.tTopics[faveBand].name)
		end
		local tFriendsData = self.rCitizen:getPeopleOfAffinity(Character.FRIEND_AFFINITY, true)
		local sFriendString = g_LM.line('INSPEC082TEXT')
		if #tFriendsData > 0 then
			local tFriends = {}
			for i,tFriendData in ipairs(tFriendsData) do
				if i <= FRIENDS_LIST_MAX_LENGTH then
					table.insert(tFriends, tFriendData.sName)
				end
			end
			sFriendString = table.concat(tFriends, ', ')
		end
		self.rFriendsText:setString(sFriendString)
		local tEnemiesData = self.rCitizen:getPeopleOfAffinity(Character.ENEMY_AFFINITY, false)
		local sEnemyString = g_LM.line('INSPEC082TEXT')
		if #tEnemiesData > 0 then
			local tEnemies = {}
			for i,tEnemyData in ipairs(tEnemiesData) do
				if i <= FRIENDS_LIST_MAX_LENGTH then
					table.insert(tEnemies, tEnemyData.sName)
				end
			end
			sEnemyString = table.concat(tEnemies, ', ')
		end
		self.rEnemiesText:setString(sEnemyString)
		if self.rInventoryText then
			self.rInventoryText:setString(self.rCitizen:getInventoryString())
		end
		if self.rJoinDateText then
			if self.rCitizen.tStats.nJoinTime then
				local GameRules = require('GameRules')
				local sJoinDate = GameRules.getStardateTotalDays(self.rCitizen.tStats.nJoinTime) .. "." .. GameRules.getStardateHour(self.rCitizen.tStats.nJoinTime)
				self.rJoinDateText:setString(sJoinDate)
			else
				self.rJoinDateText:setString('???')
			end
		end
		local tIllnesses = self.rCitizen:getIllnesses()
		local tInjuries = self.rCitizen:getInjuries()
		local tIllnessNames, tInjuryNames = {}, {}
		for sID,_ in pairs(tIllnesses) do
			table.insert(tIllnessNames, Malady.getFriendlyName(sID))
		end
		for sID,_ in pairs(tInjuries) do
			table.insert(tInjuryNames, Malady.getFriendlyName(sID))
		end
		local sIllness, sInjury
		if #tIllnessNames > 0 then
			sIllness = table.concat(tIllnessNames, ', ')
			self.rIllnessButton:setEnabled(true)
		else
			sIllness = g_LM.line('INSPEC146TEXT')
		end
		self.rIllnessText:setString(sIllness)
		if #tInjuryNames > 0 then
			sInjury = table.concat(tInjuryNames, ', ')
		else
			sInjury = g_LM.line('INSPEC146TEXT')
		end
		self.rInjuryText:setString(sInjury)
        local tTags = self.rCitizen:getSortedTagAffinities()
        local tTagStrings = {}
        for i=1,5 do
            if tTags[i].nAff >= Character.FRIEND_AFFINITY then
                local sString = g_LM.line(tTags[i].sLC)
                sString = sString:gsub("^%l", string.upper)
                table.insert(tTagStrings, sString)
            end
        end
        self.rStuffText:setString(table.concat(tTagStrings, ', '))
	end
    function Ob:setCitizen(rCitizen)
        self.rCitizen = rCitizen
    end
	function Ob:onIllnessButtonPressed(rButton, eventType)
		local _,nIllnesses = self.rCitizen:getIllnesses()
		if nIllnesses > 0 then
			local rSideBar = g_GuiManager.getSideBar()
			rSideBar:openSubmenu(rSideBar.rResearchMenu)
			rSideBar.rResearchMenu:setTechMode(false)
		end
	end
    function Ob:onSelected(bSelected)
        if bSelected then
            self:setHostileMode(self.bHostileMode)
        end
    end
    return Ob
end
m.new = DFUtil.constructor(m)
return m
