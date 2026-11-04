local m = {}
local DFUtil = require("DFCommon.Util")
local UIElement = require('UI.UIElement')
local DFInput = require('DFCommon.Input')
local TemplateButton = require('UI.TemplateButton')
local Base = require('Base')
local sUILayoutFileName = 'UILayouts/GoalEntryLayout'
function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())
    function Ob:init()
        self:setRenderLayer('UIScrollLayerRight')
        Ob.Parent.init(self,self:getRenderLayerName())
		self.rButton = TemplateButton.new()
        self.rButton:setRenderLayer(self:getRenderLayerName())
        self.rButton:setLayoutFile(sUILayoutFileName)
		self.rButton:setButtonName('Button')
        self:addElement(self.rButton)
		self.nProgressBarWidth = self.rButton:getExtraTemplateInfo('nProgressBarWidth')
		self.nProgressBarHeight = self.rButton:getExtraTemplateInfo('nProgressBarHeight')
        self.rName = self.rButton:getTemplateElement('GoalName')
        self.rDesc = self.rButton:getTemplateElement('GoalDescription')
        self.rIcon = self.rButton:getTemplateElement('GoalIcon')
        self.rProgressBar = self.rButton:getTemplateElement('ProgressBar')
        self.rProgressLabel = self.rButton:getTemplateElement('ProgressLabel')
        self:_calcDimsFromElements()
		self.tGoal = nil
    end
    function Ob:setGoal(tGoal)
		if not tGoal then
			return
		end
		self.tGoal = tGoal
		self.rName:setString(g_LM.line(tGoal.sName))
		local sDesc = g_LM.line(tGoal.sDesc)
		sDesc = sDesc:gsub('/TARGET/', tGoal.nTarget)
		self.rDesc:setString(sDesc)
		local sSpriteSheetName = 'UI/JobRoster'
		local rIconSheet = require('DFCommon.Graphics').loadSpriteSheet(sSpriteSheetName)
		local bComplete = tGoal.nProgress >= tGoal.nTarget or Base.tS.tGoals[tGoal.sID]
		if bComplete then
			self.rIcon:setIndex(rIconSheet.names['ui_jobs_icon_checkCircle'])
		else
			self.rIcon:setIndex(rIconSheet.names['ui_jobs_iconHelp'])
		end
		local sProgress
        if bComplete then
            sProgress = g_LM.line('GOALSS009TEXT')
		elseif tGoal.nTarget == 1 then
			sProgress = ''
        else
            sProgress = string.format('%s / %s', tGoal.nProgress, tGoal.nTarget)
        end
		self.rProgressLabel:setString(sProgress)
		local w = (tGoal.nProgress / tGoal.nTarget) * self.nProgressBarWidth
		if bComplete then
			w = self.nProgressBarWidth
		end
		self.rProgressBar:setScl(w, self.nProgressBarHeight)
    end
	return Ob
end
m.new = DFUtil.constructor(m)
return m
