local LodManager = {} LodManager.tLodProfiles = { ["very_low"] = { tSceneLods = { "ambient_low", "gameplay_low", }, tShaderLods = {
tFlagOverrides = { ["g_bGradientLighting"] = false, ["g_bRimLighting"] = false, }, }, }, ["low"] = { tSceneLods = { "ambient_low",
"gameplay_medium", }, tShaderLods = { tFlagOverrides = { ["g_bRimLighting"] = false, }, }, }, ["medium"] = { tSceneLods = {
"ambient_medium", "gameplay_medium", }, tShaderLods = { tFlagOverrides = { ["g_bRimLighting"] = false, }, }, }, ["high"] = { tSceneLods = {
"ambient_medium", "gameplay_high", }, }, ["very_high"] = { tSceneLods = { "ambient_high", "gameplay_high", }, }, }
LodManager.tAcceptedSceneLods = {} function LodManager.acceptExplicitSceneLod(sLodName) sLodName = sLodName or "default"
if LodManager.tAcceptedSceneLods[sLodName] == true then return true end return false end
function LodManager.acceptSceneLod(sLodName, sLodType) sLodName = sLodName or "default" if LodManager.acceptExplicitSceneLod(sLodName) then
return true end sLodType = sLodType or "explicit" if sLodType ~= "explicit" and sLodName ~= "default" then
local idxSeperator = string.find(sLodName, "_") if idxSeperator ~= nil then local sGroupName = string.sub(sLodName, 1, idxSeperator)
local lodNameLength = #sLodName local sCurType = string.sub(sLodName, idxSeperator + 1, lodNameLength) if sLodType == "include_higher" then
if sCurType == "low" then if LodManager.acceptExplicitSceneLod(sGroupName .. "medium") then return true end
if LodManager.acceptExplicitSceneLod(sGroupName .. "high") then return true end elseif sCurType == "medium" then
if LodManager.acceptExplicitSceneLod(sGroupName .. "high") then return true end end elseif sLodType == "include_lower" then
if sCurType == "high" then if LodManager.acceptExplicitSceneLod(sGroupName .. "medium") then return true end
if LodManager.acceptExplicitSceneLod(sGroupName .. "low") then return true end elseif sCurType == "medium" then
if LodManager.acceptExplicitSceneLod(sGroupName .. "low") then return true end end end end end return false end return LodManager
