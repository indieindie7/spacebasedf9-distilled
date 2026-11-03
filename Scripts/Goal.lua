local GameRules = require('GameRules')
local Base = require('Base')
local GoalData = require('GoalData')
local Goal = { profilerName='Goals' }
Goal.tickIndex = 1
Goal.tGoalProgress = {}
function Goal.init()
	Goal.nTicks = 0
end
function Goal.onTick(dt)
	Goal.tickIndex = Goal.tickIndex + 1
	if Goal.tickIndex > #GoalData.tGoals then
		Goal.tickIndex = 1
	end
	local tGoal = GoalData.tGoals[Goal.tickIndex]
	assert(tGoal ~= nil)
	if not Base.tS.tGoals then return end
	while tGoal and Base.tS.tGoals[tGoal.sName] == true do
		Goal.tickIndex = Goal.tickIndex+1
		tGoal = GoalData.tGoals[Goal.tickIndex]
	end
	if not tGoal then
		return
	end
	assert(tGoal.checkFn ~= nil)
	local bCompleted,nProgress = tGoal.checkFn()
	if bCompleted then
		Base.tS.tGoals[tGoal.sName] = true
		if Goal.nTicks > #GoalData.tGoals then
			local sGoalName = g_LM.line(tGoal.sNameLC)
			Base.eventOccurred(Base.EVENTS.GoalCompleted, {sGoal=sGoalName})
		end
	end
	Goal.tGoalProgress[tGoal.sName] = nProgress
	if Goal.nTicks <= #GoalData.tGoals then
		Goal.nTicks = Goal.nTicks + 1
	end
end
return Goal
