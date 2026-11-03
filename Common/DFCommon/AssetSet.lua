local DFGraphics = require('DFCommon.Graphics')
local DFParticles = require('DFCommon.Particles')
local DFFile = require('DFCommon.File')
local DFUtil = require('DFCommon.Util')
local DFDataCache = require('DFCommon.DataCache')

local AssetSet = {}

-- CONSTRUCTOR --
function AssetSet.new( )
	
	-- PRE-CONSTRUCTOR --
    local self = DFUtil.deepCopy( AssetSet )	
    
	self.tLoadedTextures = {}
	self.tLoadedSpriteSheets = {}
	self.tLoadedParticles = {}
    
    return self
end

-- PUBLIC FUNCTIONS --
function AssetSet:unload()
	
	-- ToDo: Make it possible to unload a asset-set that is being loaded
	assert(self:isLoaded())
		
	for sFilename, _ in pairs(self.tLoadedTextures) do
		DFGraphics.unloadTexture( sFilename )
	end
	self.tLoadedTextures = {}
	
	for sFilename, _ in pairs(self.tLoadedSpriteSheets) do
		DFGraphics.unloadSpriteSheet( sFilename )
	end
	self.tLoadedSpriteSheets = {}
    
	for sFilename, _ in pairs(self.tLoadedParticles) do
		DFParticles.unloadParticleData( sFilename )
	end
	self.tLoadedParticles = {}
end


function AssetSet:preloadTexture( sFilename )
	
	if self.tLoadedTextures[sFilename] == nil then
		self.tLoadedTextures[sFilename] = DFGraphics.loadTexture( sFilename, true )
	end
	return self.tLoadedTextures[sFilename]
end



function AssetSet:isLoaded()

	for _, rTexture in pairs(self.tLoadedTextures) do
		if not rTexture:isLoaded() then
			return false
		end
	end
	
	for _, rSpriteSheet in pairs(self.tLoadedSpriteSheets) do
		if not rSpriteSheet.texture:isLoaded() then
			return false
		end
	end
	
	return true
end



return AssetSet