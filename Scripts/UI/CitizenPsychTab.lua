local m = {}
local DFUtil = require("DFCommon.Util")
local DFInput = require('DFCommon.Input')
local Character = require('CharacterConstants')
local UIElement = require('UI.UIElement')
local Needs = require('Utility.Needs')
local PsychGraph = require('UI.PsychGraph')
local sUILayoutFileName = 'UILayouts/CitizenPsychTabLayout'
local tGraphLabels = {
	Morale = 'GraphLabelMorale',
	Duty = 'GraphLabelDuty',
	Energy = 'GraphLabelEnergy',
	Social = 'GraphLabelSocial',
	Amusement = 'GraphLabelAmusement',
	Hunger = 'GraphLabelHunger',
	Stuff = 'GraphLabelStuff',
}
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    Ob.rCitizen = nil
    Ob.bDoRolloverCheck = true
    function Ob:init()
        self:processUIInfo(sUILayoutFileName)
        Ob.Parent.init(self)
		self.rPsychGraph = PsychGraph.new()
        self.rSelfEsteemText = self:getTemplateElement('SelfEsteemText')
        self.rRoomSatisfactionText = self:getTemplateElement('RoomSatisfactionText')
        self.rJobSatisfactionText = self:getTemplateElement('JobSatisfactionText')
        self.rPersonalityText = self:getTemplateElement('PersonalityText')
		self.tGraphLabels = {}
		for sNeed,sLabel in pairs(tGraphLabels) do
			self.tGraphLabels[sNeed] = self:getTemplateElement(sLabel)
		end
		self.rHalfGraphX = self:getTemplateElement('GraphLabelX2')
		self.rEndGraphX = self:getTemplateElement('GraphLabelX3')
    end
    function Ob:onTick(dt)
        if not self.rCitizen then
			return
		end
		if self.bHostileMode then
			return
		end
		self.rPsychGraph:onTick(dt)
		self.rSelfEsteemText:setString(self:_getSelfEsteemString())
		self.rRoomSatisfactionText:setString(self:_getRoomString())
		self.rJobSatisfactionText:setString(self:_getJobSatString())
		self.rPersonalityText:setString(self:_getPersonalityString())
		if not self.rPsychGraph then
			return
		end
		local tLabels = {}
		for sNeed,tLabelPos in pairs(self.rPsychGraph.tLabels) do
			table.insert(tLabels, {sNeed=sNeed, x=tLabelPos.x, y=tLabelPos.y})
		end
		local f = function(x,y) return x.y > y.y end
		table.sort(tLabels, f)
		local nLabelHeight = 20
		for i,tLabelInfo in pairs(tLabels) do
			local rLabel = self.tGraphLabels[tLabelInfo.sNeed]
			local tColor
			if tLabelInfo.sNeed == 'Morale' then
				tColor = self.rPsychGraph.moraleGraphColor
			elseif tLabelInfo.sNeed == 'Stuff' then
				tColor = self.rPsychGraph.stuffGraphColor
			else
				tColor = Needs.tNeedList[tLabelInfo.sNeed].graphColor
			end
			rLabel:setColor(unpack(tColor))
			local x,y = tLabelInfo.x, tLabelInfo.y
			if i > 1 and y > tLabels[i-1].y - nLabelHeight then
				y = tLabels[i-1].y - nLabelHeight
				tLabelInfo.y = y
			end
			y = y + self.rPsychGraph.graphHeight + 100
			rLabel:setLoc(x, y)
		end
		local nEndGraphTime = (Character.GRAPH_TICK_RATE * Character.GRAPH_MAX_ENTRIES) / 60
		self.rEndGraphX:setString('-'..nEndGraphTime..'h')
		self.rHalfGraphX:setString('-'..(nEndGraphTime/2)..'h')
    end
    function Ob:setCitizen(rCitizen)
        self.rCitizen = rCitizen
    end
    function Ob:setHostileMode(bSet)
        self.bHostileMode = bSet
        if bSet then
            local tOverrides = self:getExtraTemplateInfo('tHostileMode')
            if tOverrides then
                self:applyTemplateInfos(tOverrides)
            end
        else
            local tOverrides = self:getExtraTemplateInfo('tCitizenMode')
            if tOverrides then
                self:applyTemplateInfos(tOverrides)
            end
        end
    end
    function Ob:show(n)
        local n2 = Ob.Parent.show(self,n)
		self.rPsychGraph.bVisible = true
        return n2
    end
    function Ob:hide()
        Ob.Parent.hide(self)
		self.rPsychGraph.bVisible = false
    end
    function Ob:onSelected(bSelected)
        if bSelected then
            self:setHostileMode(self.bHostileMode)
        end
    end
	function Ob:_getSelfEsteemString()
		local sLC = 'INSPEC132TEXT'
		local nSelfEsteem = self.rCitizen:getAffinity(self.rCitizen.tStats.sUniqueID)
		for _,tLine in ipairs(Character.SELF_ESTEEM_LINE) do
			if nSelfEsteem >= tLine.nMin then
				sLC = tLine.linecode
			end
		end
		return g_LM.line(sLC)
	end
	function Ob:_getRoomString()
		local nRoomSatisfaction = self.rCitizen:getAverageRoomMorale() * 100
		local sLC
        for i, tTextInfo in ipairs(Character.MORALE_UI_TEXT) do
            if nRoomSatisfaction >= tTextInfo.nMinMorale then
                sLC = tTextInfo.linecode
            end
        end
		return g_LM.line(sLC)
	end
	function Ob:_getJobSatString()
		local nJob = self.rCitizen.tStats.nJob
		if nJob == Character.UNEMPLOYED then
			return g_LM.line('INSPEC079TEXT')
		end
		local nAff = self.rCitizen:getJobAffinity(nJob)
		nAff = nAff * 10
		local sLC
        for i,tTextInfo in ipairs(Character.MORALE_UI_TEXT) do
            if nAff >= tTextInfo.nMinMorale then
                sLC = tTextInfo.linecode
            end
        end
		return g_LM.line(sLC)
	end
	function Ob:_getMoraleString()
		return ''
	end
    function Ob:_getNeedsString()
		local s = ''
		local crit = Character.MORALE_NEEDS_LOW
		if self.rCitizen:getNeedValue('Duty') < crit then
			s = s .. g_LM.line('INSPEC071TEXT') .. ', '
		end
		if self.rCitizen:getNeedValue('Social') < crit then
			s = s .. g_LM.line('INSPEC073TEXT') .. ', '
		end
		if self.rCitizen:getNeedValue('Amusement') < crit then
			s = s .. g_LM.line('INSPEC074TEXT') .. ', '
		end
		if self.rCitizen:getNeedValue('Energy') < crit then
			s = s .. g_LM.line('INSPEC072TEXT') .. ', '
		end
		if self.rCitizen:getNeedValue('Hunger') < crit then
			s = s .. g_LM.line('INSPEC085TEXT')
		end
		if s:find(',', -2) then
			s = s:sub(0, -3)
		end
		if s == '' then
			s = g_LM.line('INSPEC075TEXT')
		end
        return s
    end
	function Ob:_getPersonalityString()
		local nTraitThreshold = 0.3
		local nTraitsToShow = 2
		local tTraitsToShow = {}
		local tQuirksToShow = {}
		for k,_ in pairs(Character.PERSONALITY_TRAITS) do
			if string.find(k, 'b') == 1 then
				if self.rCitizen.tStats.tPersonality[k] == true then
					table.insert(tQuirksToShow, Character.QUIRK_LINE[k])
				end
			elseif string.find(k, 'n') == 1 then
				local nValue = self.rCitizen.tStats.tPersonality[k]
				nValue = (nValue - 0.5) * 2
				if nValue > nTraitThreshold or nValue < -nTraitThreshold then
					table.insert(tTraitsToShow, {sTrait=k, val=nValue})
				end
			end
		end
		local f = function(x,y) return math.abs(x.val) > math.abs(y.val) end
		table.sort(tTraitsToShow, f)
		while #tTraitsToShow > nTraitsToShow do
			table.remove(tTraitsToShow, #tTraitsToShow)
		end
		local tItems = {}
		for _,tTrait in pairs(tTraitsToShow) do
			local sAdjLC
			for i,tAdj in ipairs(Character.PERSONALITY_ADJECTIVE_LINE) do
				if math.abs(tTrait.val) >= tAdj.nMin then
					sAdjLC = tAdj.linecode
				end
			end
			local sTraitLC
			if tTrait.val > 0 then
				sTraitLC = Character.PERSONALITY_LINE[tTrait.sTrait].nHigh
			elseif tTrait.val < 0 then
				sTraitLC = Character.PERSONALITY_LINE[tTrait.sTrait].nLow
			end
			table.insert(tItems, g_LM.line(sTraitLC))
		end
		if #tItems == 0 then
			table.insert(tItems, g_LM.line('PERSON025TEXT'))
		end
		for _,sQuirk in pairs(tQuirksToShow) do
			table.insert(tItems, g_LM.line(sQuirk))
		end
		return table.concat(tItems, ', ')
	end
    return Ob
end
function m.new(...)
    local Ob = m.create()
    Ob:init(...)
    return Ob
end
return m
