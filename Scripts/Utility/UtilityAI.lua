local DFMath = require('DFCommon.Math')
local DFUtil = require('DFCommon.Util')
local World = require('World')
local Needs = require('Utility.Needs')
local Room = require('Room')
local GlobalObjects = require('Utility.GlobalObjects')
local CommandObject = require('Utility.CommandObject')
local MiscUtil = require('MiscUtil')
local UtilityAI = {
}
function UtilityAI.getNearbyCharacters(rChar)
    return require('CharacterManager').getCharacters()
end
function getOptionTargetName(option)
	if not option.tData then
		return nil
	elseif option.tData.rTarget then
		return option.tData.rTarget.tStats.sUniqueID
	elseif option.tData.rTargetObject then
		return option.tData.rTargetObject.sUniqueName
	end
	return nil
end
function UtilityAI.getBestTask(rChar, nMinPri, bLog, tGathererOverride)
    local tValidOptions={}
    local tAllOptions={}
    local tSatisfiers={}
    local tGatherers = tGathererOverride or rChar.tActivityOptionGatherers
    for gatherName,gatherData in pairs(tGatherers) do
        local tObjects = gatherData.gatherFn(rChar)
        for _, object in ipairs(tObjects) do
            for _,rOption in ipairs((object.getUtilityOptions and object:getUtilityOptions(rChar)) or object.tUtilityOptions) do
                assertdev(rOption.tBlackboard)
                local bSatisfier = false
                local tSatisfies = rOption:getSatisfies()
                for k,v in pairs(tSatisfies) do
                    if not tSatisfiers[k] then tSatisfiers[k] = {} end
                    tSatisfiers[k][rOption] = v
                    bSatisfier = true
                end
                local bValid, sReason = rOption:earlyGates(rChar, (not bSatisfier and nMinPri) or 0)
                local tOptionEntry = {rOption=rOption, bEarlyGatesValid=bValid, sReason=sReason}
                if bValid then
                    tOptionEntry.nMaxScore=rOption:getMaxPotentialScore(rChar)
                    tOptionEntry.nPri=rOption:getPriority(rChar)
                end
                tAllOptions[rOption] = tOptionEntry
                if bValid and not bSatisfier then
                    if bValid then
                        table.insert(tValidOptions, rOption)
                    end
                end
            end
        end
    end
    table.sort(tValidOptions, function(a,b)
        if tAllOptions[a].nPri ~= tAllOptions[b].nPri then
            return tAllOptions[a].nPri > tAllOptions[b].nPri
        end
        return tAllOptions[a].nMaxScore > tAllOptions[b].nMaxScore
    end)
    local nBestPri, nBestScore, tBestOptionData
    for _,rOption in ipairs(tValidOptions) do
        local tOptionEntry = tAllOptions[rOption]
        if nBestPri and nBestPri > tOptionEntry.nPri then
            break
        end
        if nBestScore and nBestScore > tOptionEntry.nMaxScore then
            break
        end
        UtilityAI._fillOutOptionEntry(rChar,tOptionEntry, tAllOptions,tSatisfiers)
        if tOptionEntry.bFullyValid then
            if not nBestPri or (tOptionEntry.nPri >= nBestPri and tOptionEntry.nTotalScore > nBestScore) then
                nBestPri = tOptionEntry.nPri
                nBestScore = tOptionEntry.nTotalScore
                tBestOptionData = tOptionEntry
            end
        end
    end
    local logStr = ''
    if bLog then
        if tBestOptionData then
            logStr = logStr .. UtilityAI._getScoreStr(tBestOptionData) .. '\n'
        end
        for _,rOption in ipairs(tValidOptions) do
            local tOptionData = tAllOptions[rOption]
            if tOptionData ~= tBestOptionData then
                logStr = logStr .. UtilityAI._getScoreStr(tOptionData) .. '\n'
            end
        end
        for rOption,tOptionData in pairs(tAllOptions) do
            if not tOptionData.bEarlyGatesValid then
                if tOptionData.sReason == 'wrong job' then
                else
                    logStr = logStr .. UtilityAI._getScoreStr(tOptionData) .. '\n'
                end
            end
        end
    end
    if tBestOptionData then
        if tBestOptionData.tSatisfiers then
            return tBestOptionData.tSatisfiers[1], nBestScore, logStr
        else
            return tBestOptionData.rOption, nBestScore, logStr
        end
    end
    return nil,nil,logStr
end
function UtilityAI._fillOutOptionEntry(rChar,tOptionEntry,tAllOptions,tSatisfiers,nDepth)
    if not nDepth then nDepth = 1
    else nDepth = nDepth+1 end
    if tOptionEntry.bFullyValid ~= nil then
        return
    end
    assert(tOptionEntry.bEarlyGatesValid ~= nil)
    if tOptionEntry.bEarlyGatesValid == false then
        tOptionEntry.bFullyValid = false
        return
    end
    local tUnsatisfiedPrereqs = tOptionEntry.rOption:getUnsatisfiedPrereqs(rChar)
    local nPrereqScore = 0
    for k,v in pairs(tUnsatisfiedPrereqs) do
        if nDepth == 1 then
            local nBestScore,rBestOption
            if tSatisfiers[k] then
                for rOption,satisfyValue in pairs(tSatisfiers[k]) do
                    if satisfyValue == v then
                        UtilityAI._fillOutOptionEntry(rChar,tAllOptions[rOption],tAllOptions,tSatisfiers,nDepth)
                        if tAllOptions[rOption].nTotalScore then
                            if not nBestScore or tAllOptions[rOption].nTotalScore > nBestScore then
                                nBestScore = tAllOptions[rOption].nTotalScore
                                rBestOption = rOption
                                assert(nBestScore <= 0)
                            end
                        end
                    end
                end
            end
            if not nBestScore then
                tOptionEntry.bPrereqsValid = false
                tOptionEntry.bFullyValid = false
                tOptionEntry.sReason = 'Failed prereq: '..k
                return
            end
            if not tOptionEntry.tSatisfiers then tOptionEntry.tSatisfiers = {} end
            table.insert(tOptionEntry.tSatisfiers, rBestOption)
            nPrereqScore = nPrereqScore+nBestScore
            if rBestOption:overridesPathTest() then
                tOptionEntry.bOverridePathTest = true
            end
            local nOverrideStartWX,nOverrideStartWY,reason = rBestOption:getPathStartOverride(rChar)
            if nOverrideStartWX then
                tOptionEntry.nOverrideStartWX, tOptionEntry.nOverrideStartWY = nOverrideStartWX,nOverrideStartWY
            elseif reason then
                tOptionEntry.bPrereqsValid = false
                tOptionEntry.bFullyValid = false
                tOptionEntry.sReason = 'Prereq: '..k..'; '..reason
                return
            end
        end
    end
    tOptionEntry.bPrereqsValid = true
    tOptionEntry.bFullyValid = UtilityAI._fillInLateGates(rChar,tOptionEntry)
    if not tOptionEntry.bFullyValid then
        return
    end
    tOptionEntry.nTotalScore = tOptionEntry.nRealScore + nPrereqScore
end
function UtilityAI._fillInLateGates(rChar,tOptionEntry)
    if tOptionEntry.bLateGatesValid ~= nil then
        return tOptionEntry.bLateGatesValid
    end
    local bValid, sReason = tOptionEntry.rOption:lateGates(rChar, tOptionEntry.bOverridePathTest, tOptionEntry.nOverrideStartWX, tOptionEntry.nOverrideStartWY)
    tOptionEntry.bLateGatesValid = bValid
    if bValid then
        local nScore = tOptionEntry.rOption:getRealScore(rChar)
        tOptionEntry.nRealScore = nScore
    else
        tOptionEntry.sReason = sReason
    end
    return bValid
end
function UtilityAI._getScoreStr(tOptionData)
    local rOption = tOptionData.rOption
    local scoreStr = rOption.name
    local targetName = getOptionTargetName(rOption)
    if targetName then
        scoreStr = scoreStr .. ' @ ' .. targetName
    end
    if tOptionData.nTotalScore or tOptionData.nMaxScore then
        scoreStr = scoreStr .. ' ('
        local bSnip = false
        for k,v in pairs(rOption.tBlackboard.tAdvertisedNeeds) do
            bSnip = true
            scoreStr = scoreStr .. k .. '='..v..', '
        end
        scoreStr = string.sub(scoreStr, 1, -3) .. ')'
    end
    scoreStr = MiscUtil.padString(scoreStr, #'ExtinguishFireBareHanded' + 15)
    if tOptionData.nTotalScore then
        scoreStr = scoreStr .. ': ' .. string.format('%.3f', tOptionData.nTotalScore ) .. ' total '
    elseif tOptionData.nMaxScore then
        scoreStr = scoreStr .. ': ' .. string.format('%.3f', tOptionData.nMaxScore ) .. ' max   '
    else
        scoreStr = scoreStr .. ': ' .. string.format('%.3f', 0 ) .. ' gated '
    end
    scoreStr = MiscUtil.padString(scoreStr, #scoreStr + 6)
    if tOptionData.sReason then
        scoreStr = scoreStr .. ' reason: ' .. tOptionData.sReason
    end
    return scoreStr
end
return UtilityAI
