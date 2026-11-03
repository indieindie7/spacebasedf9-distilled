local DFGraphics = require('DFCommon.Graphics')
local DFFile = require('DFCommon.File')
local DFMath = require('DFCommon.Math')
local DFUtil = require('DFCommon.Util')
local Post = {}
Post.kEnabled = true
kBLEND_MULTIPLY = { MOAIProp.GL_DST_COLOR, MOAIProp.GL_ONE_MINUS_SRC_ALPHA }
kBLEND_ADD = { MOAIProp.GL_ONE, MOAIProp.GL_ONE }
kBLEND_ALPHA = { MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA}
kBLEND_PREMULTIPLIED = { MOAIProp.GL_ONE, MOAIProp.GL_ONE_MINUS_SRC_ALPHA}
kNUM_POST_FILTERS = 30
kNUM_POST_BUFFERS = 8
kNUM_POST_HALFBUFFERS = 4
kNUM_POST_QUARTERBUFFERS = 4
kNUM_POST_EIGHTHBUFFERS = 4
kNUM_POST_SCRATCHLAYERS = 4
local kBackgroundLayerOrder = {"Background", "BuildGrid"}
local kSceneLayerOrder = {"WorldFloor", "BuildGrid", "WorldWall"}
function Post:ScenePlusUI()
    if not Post.kEnabled then return end
    print("Post:ScenePlusUI")
    Post:ClearFilters()
    local finalColorBuffer = Post:GetUnusedBuffer()
    local uiBuffer = Post.rRenderer.getFrameBuffer('UI')
    uiBuffer:setWrap(false)
    local uiMaskBuffer = Post.rRenderer.getLayerFrameBuffer('UIEffectMask')
    local uiEffectBuffer = Post:GetUnusedBuffer()
    local uiBackgroundBuffer = Post.rRenderer.getLayerFrameBuffer('UIBackground')
    local uiFilter = Post:GetNextFilter()
    uiFilter:setMaterial("Materials/UIScreen.material")
    uiFilter:setInBuffer(uiBuffer)
    uiFilter:setShaderValue( "g_samEffectMask", MOAIMaterial.VALUETYPE_TEXTURE, uiMaskBuffer)
    uiFilter:setShaderValue( "g_fTime", MOAIMaterial.VALUETYPE_FLOAT, 0.0)
    uiFilter:setOutBuffer(uiEffectBuffer)
    local sceneBuffer = Post:GetUnusedBuffer()
    local backgroundBuffer = Post:GetUnusedBuffer()
    local mixedSceneBuffer = Post:GetUnusedBuffer()
    Post:BlitBackgroundFilter(backgroundBuffer)
    Post:BlitSceneFilter(sceneBuffer)
    Post:BlitFilter(sceneBuffer, finalColorBuffer, kBLEND_ALPHA)
    local rLightLayerBuffer = Post.rRenderer.getLayerFrameBuffer("Light")
    local filter = Post:GetNextFilter()
    filter:setMaterial("Materials/SceneLight.material")
    filter:setInBuffer(sceneBuffer)
    filter:setShaderValue( "g_samLight", MOAIMaterial.VALUETYPE_TEXTURE, rLightLayerBuffer)
    filter:setShaderValue( "g_samBG", MOAIMaterial.VALUETYPE_TEXTURE, backgroundBuffer)
    filter:setShaderValue( "g_fBlurWidth", MOAIMaterial.VALUETYPE_FLOAT, .003)
    filter:setShaderValue( "g_samColorLUT", MOAIMaterial.VALUETYPE_TEXTURE, Post.rSceneColorLUTTexture )
    filter:setOutBuffer(mixedSceneBuffer)
    Post.EnvFilter = filter
    Post:BlitFilter(mixedSceneBuffer, finalColorBuffer)
    local outlineBuffer = Post.rRenderer.getLayerFrameBuffer("WorldOutlines")
    local outlineFilter = Post:OutlineFilter(outlineBuffer, finalColorBuffer)
    Post:BlitFilter(uiEffectBuffer, finalColorBuffer, kBLEND_ADD)
    local kUseFXAA = false
    if kUseFXAA then
        local aaBuffer = Post:GetUnusedBuffer()
        Post:FXAAFilter(finalColorBuffer, aaBuffer)
        Post.rScreen:setInBuffer(aaBuffer)
    else
        Post.rScreen:setInBuffer(finalColorBuffer)
    end
    local totalTime = 0.0
    local fnUpdate = function()
        totalTime = totalTime + 0.016
        if totalTime > 2 * math.pi then
            totalTime = totalTime - 2 * math.pi
        end
        local uiFade = 1.0
        if Post.rRenderer.bHideUI then
            uiFade = 0.0
        end
        uiFilter:setShaderValue( "g_vPixelSize", MOAIMaterial.VALUETYPE_VEC2, Post.pixelSize )
        uiFilter:setShaderValue( "g_fUIFade", MOAIMaterial.VALUETYPE_FLOAT, uiFade)
        Post.EnvFilter:setShaderValue( "g_vPixelSize", MOAIMaterial.VALUETYPE_VEC2, Post.pixelSize )
        outlineFilter:setShaderValue( "g_vPixelSize", MOAIMaterial.VALUETYPE_VEC2, Post.pixelSize )
        outlineFilter:setShaderValue( "g_fTime", MOAIMaterial.VALUETYPE_FLOAT, totalTime)
    end
    Post:SetUpdateCallback(fnUpdate)
end
function Post.SetPostColorLUT( sColorLUT )
    Post.EnvFilter:setShaderValue( "g_samColorLUT", MOAIMaterial.VALUETYPE_TEXTURE, Post.tPostColorLUTs[ sColorLUT ] )
end
function Post.SetSpaceGradient( left, right, top, bottom )
    Post.EnvFilter:setShaderValue( "g_vGradColorLeft", MOAIMaterial.VALUETYPE_VEC4, left )
    Post.EnvFilter:setShaderValue( "g_vGradColorRight", MOAIMaterial.VALUETYPE_VEC4, right )
    Post.EnvFilter:setShaderValue( "g_vGradColorTop", MOAIMaterial.VALUETYPE_VEC4, top )
    Post.EnvFilter:setShaderValue( "g_vGradColorBottom", MOAIMaterial.VALUETYPE_VEC4, bottom )
end
function Post:BasicComp()
    print("Show Basic Comp")
    Post:ClearFilters()
    local finalColorBuffer = Post:GetUnusedBuffer()
    Post:BlitSceneFilter(finalColorBuffer)
    Post.rScreen:setInBuffer(finalColorBuffer)
end
function Post.CreateScreenQuad()
    local Obj = {}
    function Obj:setInBuffer( rInputFrameBuffer )
        self.quad:setTexture ( rInputFrameBuffer )
        DFUtil.removeFromArray(Post.tRenderLayers, self.layer)
        table.insert(Post.tRenderLayers, self.layer)
    end
    local halfScreenX, halfScreenY = Post.rRenderer.getHalfScreenSize()
    Obj.quad = MOAIGfxQuad2D.new ()
    Obj.quad:setRect ( -halfScreenX, -halfScreenY, halfScreenX, halfScreenY)
    Obj.quad:setUVRect ( 0, 0, 1, 1 )
    Obj.layer = Post.rRenderer.getRenderLayer("Post")
    Obj.prop = MOAIProp2D.new ()
    Obj.prop:setDeck ( Obj.quad )
    Obj.prop:setLoc( 0, 0, 1 )
    Obj.layer:insertProp(Obj.prop)
    return Obj
end
function Post.CreateBuffer(w, h)
    local Obj = MOAIFrameBuffer.new ()
    Obj:init (w, h)
    Obj:setClearColor(1, 1, 1, 1)
    Obj:setFilter(MOAITexture.GL_LINEAR, MOAITexture.GL_LINEAR)
    Obj.bInUse = false
    Obj.rViewport = Post.rRenderer.mGameViewport
    function Obj:SetInUse(bInUse)
        if nil == bInUse then bInUse = true end
        self.bInUse = bInUse
    end
    return Obj
end
function Post.CreateScratchLayer()
    local Obj = {}
    function Obj:setOutBuffer(rOutputFrameBuffer)
        DFUtil.removeFromArray(Post.tRenderLayers, self.layer)
        if rOutputFrameBuffer then
            if rOutputFrameBuffer.rViewport then
                self.layer:setViewport(rOutputFrameBuffer.rViewport)
            end
            self.layer:setFrameBuffer(rOutputFrameBuffer)
            table.insert(Post.tRenderLayers, self.layer)
        end
    end
    function Obj:ClearProps()
        self.layer:clear()
        if self.prop then
            self.layer:insertProp(self.prop)
        end
    end
    function Obj:SetInUse(bInUse)
        if nil == bInUse then bInUse = true end
        self.bInUse = bInUse
    end
    function Obj:insertProp(prop)
        self.layer:insertProp(prop)
    end
    function Obj:removeProp(prop)
        self.layer:removeProp(prop)
    end
    function Obj:setCamera(rCamera)
        self.layer:setCamera(rCamera)
    end
    Obj.sLayerType = "ScratchLayer"
    Obj.layer = MOAILayer2D.new ()
    Obj.layer:setDebugName( Obj.sLayerType )
    Obj.layer:setViewport ( Post.rRenderer.rGameViewport )
    Obj.bInUse = false
    return Obj
end
function Post.CreateFilter(rInputFrameBuffer, sMaterial)
    local Obj = Post.CreateScratchLayer()
    Obj.sLayerType = "FilterLayer"
    local halfScreenX, halfScreenY = Post.rRenderer.getHalfScreenSize()
    Obj.quad = MOAIGfxQuad2D.new ()
    Obj.quad:setTexture ( rInputFrameBuffer )
    Obj.quad:setRect ( -halfScreenX, -halfScreenY, halfScreenX, halfScreenY)
    Obj.quad:setUVRect ( 0, 0, 1, 1 )
    if nil == sMaterial then
        sMaterial =  "Materials/Blit.material"
    end
    Obj.color = MOAIColor.new()
    function Obj:getOutBuffer()
        return self.rOutFrameBuffer
    end
    function Obj:setVisible(bVisible)
        self.prop:setVisible(bVisible)
    end
    function Obj:setBlendMode(tModeConstant)
        self.rMaterial:setBlendMode(tModeConstant[1], tModeConstant[2])
    end
    function Obj:setColor(r, g, b, a)
        self.rMaterial:setColor(r, g, b, a)
    end
    function Obj:setMaterial(sMaterial)
        self.layer:setDebugName(Obj.sLayerType .. " - " .. sMaterial)
        if self.rMaterial then
            DFGraphics.unloadMaterial(self.rMaterial)
        end
        self.rMaterial = DFGraphics.loadMaterial( sMaterial )
        self.prop:setMaterial(self.rMaterial)
    end
    function Obj:setShaderValue( sName, type, value )
        self.rMaterial:setShaderValue(sName, type, value)
    end
    function Obj:setInBuffer(rInputFrameBuffer)
        self.quad:setTexture ( rInputFrameBuffer )
    end
    Obj.prop = MOAIProp2D.new ()
    Obj.prop:setDeck ( Obj.quad )
    Obj.prop:setLoc( 0, 0, 1 )
    Obj.layer:insertProp(Obj.prop)
    Obj:setMaterial(sMaterial)
    Obj:setInBuffer(rInputFrameBuffer)
    Obj:setBlendMode(kBLEND_ALPHA)
    return Obj
end
function Post:Init(rRenderer)
    if not Post.kEnabled then return end
    Post.rRenderer = rRenderer
    Post.tRenderLayers = {}
    Post.tFilters = {}
    Post.tBuffers = {}
    Post.tHalfBuffers = {}
    Post.tQuarterBuffers = {}
    Post.tEighthBuffers = {}
    Post.tScratchLayers = {}
    if not Post.kEnabled then return end
    Post.nCurFilter = 1
    Post.rWhiteTexture = DFGraphics.loadTexture( "White", true )
    Post.rBlackTexture = DFGraphics.loadTexture( "Effects/Textures/Black", true )
    Post.rGradientTexture = DFGraphics.loadTexture( "Effects/Textures/Gradient", true )
    Post.rGradientTextureB = DFGraphics.loadTexture( "Effects/Textures/GradientB", true )
    Post.rGradientTextureC = DFGraphics.loadTexture( "Effects/Textures/GradientC", true )
    Post.rGradientTextureD = DFGraphics.loadTexture( "Effects/Textures/GradientD", true )
    Post.rGradientTextureE = DFGraphics.loadTexture( "Effects/Textures/GradientE", true )
    Post.rGradientTextureF = DFGraphics.loadTexture( "Effects/Textures/GradientF", true )
    Post.rFlowTexture = DFGraphics.loadTexture( "Effects/Textures/Flow", true )
    Post.rSceneColorLUTTexture = DFGraphics.loadTexture( "Effects/Textures/LUT/Neutral2D_256", true );
    Post.tPostColorLUTs = {}
    Post.tPostColorLUTs["neutral"] = DFGraphics.loadTexture( "Effects/Textures/LUT/Neutral2D_256", true );
    Post.tPostColorLUTs["warmspace"] = DFGraphics.loadTexture( "Effects/Textures/LUT/WarmSpace2D_256", true );
    Post.tPostColorLUTs["coldspace"] = DFGraphics.loadTexture( "Effects/Textures/LUT/ColdSpace2D_256", true );
    Post.tPostColorLUTs["magentaspace"] = DFGraphics.loadTexture( "Effects/Textures/LUT/MagentaSpace2D_256", true );
    Post.tPostColorLUTs["greenpunch"] = DFGraphics.loadTexture( "Effects/Textures/LUT/GreenPunch2D_256", true );
    Post.rLightSpritesheet = DFGraphics.loadSpriteSheet( "Effects/Lights/Lights")
    DFGraphics.alignSprite(Post.rLightSpritesheet, "bigblob", "left", "bottom")
    for i=1,kNUM_POST_FILTERS do
        local filter = Post.CreateFilter(Post.rRenderer.GameBuffer)
        table.insert(Post.tFilters, filter)
    end
    local screenX = Post.rRenderer.ScreenBufferWidth
    local screenY = Post.rRenderer.ScreenBufferHeight
    for i=1,kNUM_POST_BUFFERS do
        local buffer = Post.CreateBuffer(screenX, screenY)
        buffer.rViewport = Post.rRenderer.rBufferViewport
        table.insert(Post.tBuffers, buffer)
    end
    for i=1,kNUM_POST_HALFBUFFERS do
        local buffer = Post.CreateBuffer(screenX/2, screenY/2)
        buffer.rViewport = Post.rRenderer.rHalfSizeGameViewport
        table.insert(Post.tHalfBuffers, buffer)
    end
    for i=1,kNUM_POST_QUARTERBUFFERS do
        local buffer = Post.CreateBuffer(screenX/4, screenY/4)
        buffer.rViewport = Post.rRenderer.rQuarterSizeGameViewport
        table.insert(Post.tQuarterBuffers, buffer)
    end
    for i=1,kNUM_POST_EIGHTHBUFFERS do
        local buffer = Post.CreateBuffer(screenX/8, screenY/8)
        buffer.rViewport = Post.rRenderer.rEighthSizeGameViewport
        table.insert(Post.tEighthBuffers, buffer)
    end
    for i=1,kNUM_POST_SCRATCHLAYERS do
        local scratchLayer = Post.CreateScratchLayer()
        scratchLayer:setCamera( Post.rRenderer.mGameCamera )
        table.insert(Post.tScratchLayers, scratchLayer)
    end
    Post.rScreen = Post:CreateScreenQuad()
    Post:Reset()
    Post:BasicComp()
    Post.pixelSize = {1.0/screenX, 1.0/screenY}
end
function Post:AddLayers(tRenderLayers)
    local primaryLayer = Post.rRenderer.getRenderLayer("Post")
    table.insert(tRenderLayers, primaryLayer)
    for i in ipairs(Post.tRenderLayers) do
        table.insert(tRenderLayers, Post.tRenderLayers[i])
    end
end
function Post:OnScreenResize(width, height)
    if Post.kEnabled then
        Post.pixelSize = {1.0/width, 1.0/height}
        Post.rScreen.quad:setRect ( -width/2, -height/2, width/2, height/2)
        for i,rFilter in ipairs(Post.tFilters) do
            rFilter.quad:setRect ( -width/2, -height/2, width/2, height/2)
        end
        for i,rBuffer in ipairs(Post.tBuffers) do
            rBuffer:init(width, height)
        end
        for i,rBuffer in ipairs(Post.tHalfBuffers) do
            rBuffer:init(width/2, height/2)
        end
        for i,rBuffer in ipairs(Post.tQuarterBuffers) do
            rBuffer:init(width/4, height/4)
        end
        for i,rBuffer in ipairs(Post.tEighthBuffers) do
            rBuffer:init(width/8, height/8)
        end
    end
end
local function F(nIndex)
    return Post.tFilters[nIndex]
end
local function B(nIndex)
    return Post.tBuffers[nIndex]
end
function Post:ClearFilters()
    local defaultLayer = Post.rRenderer.getLayer("WorldFloor")
    local defaultBuffer = Post.rRenderer.getLayerFrameBuffer("WorldFloor")
    for i,rFilter in ipairs(Post.tFilters) do
        rFilter:setInBuffer(defaultBuffer)
        rFilter:setMaterial("Materials/Blit.material")
        rFilter:setOutBuffer(nil)
        rFilter:setBlendMode(kBLEND_ALPHA)
        rFilter:SetInUse(false)
    end
    for i,rBuffer in ipairs(Post.tBuffers) do
        rBuffer:setClearColor(0, 0, 0, 0)
        rBuffer:SetInUse(false)
    end
    for i,rBuffer in ipairs(Post.tHalfBuffers) do
        rBuffer:setClearColor(0, 0, 0, 0)
        rBuffer:SetInUse(false)
    end
    for i,rBuffer in ipairs(Post.tQuarterBuffers) do
        rBuffer:setClearColor(0, 0, 0, 0)
        rBuffer:SetInUse(false)
    end
    for i,rBuffer in ipairs(Post.tEighthBuffers) do
        rBuffer:setClearColor(0, 0, 0, 0)
        rBuffer:SetInUse(false)
    end
    for i,rScratchLayer in ipairs(Post.tScratchLayers) do
        rScratchLayer:ClearProps()
        rScratchLayer:SetInUse(false)
    end
    Post.fnUpdate = nil
    Post.nCurFilter = 1
    if g_DebugDisplay then
        g_DebugDisplay:SetValue("FIL", (Post.nCurFilter - 1))
    end
end
function Post:ResetDrawColors()
    Post.rRenderer.updateClearColor()
end
function Post:Reset()
    Post:ClearFilters()
    Post:ResetDrawColors()
end
function Post:GetNextFilter()
    local filter = F(Post.nCurFilter)
    Post.nCurFilter = Post.nCurFilter + 1
    filter:SetInUse()
    if g_DebugDisplay then
        g_DebugDisplay:SetValue("FIL", (Post.nCurFilter - 1))
    end
    return filter
end
function Post:GetUnusedBuffer(tBufferList)
    if not tBufferList then tBufferList = Post.tBuffers end
    local out = nil
    for i,rBuffer in ipairs(tBufferList) do
        if not rBuffer.bInUse then
            rBuffer:SetInUse()
            out = rBuffer
            break
        end
    end
    return out
end
function Post:SetUpdateCallback(fnUpdate)
    Post.fnUpdate = fnUpdate
end
function Post:Update()
    if not Post.kEnabled then return end
   if Post.fnUpdate then
       Post.fnUpdate(self)
   end
end
function Post:FXAAFilter(rInBuffer, rOutBuffer)
    local filter = Post:GetNextFilter()
    filter:setInBuffer(rInBuffer)
    filter:setMaterial("Materials/FXAA.material")
    local screenW, screenH = Post.rRenderer.getScreenSize()
    local tInvBuffSize = { 1.0 / screenW, 1.0 / screenH }
    filter:setShaderValue( "g_vTexCoordOffset", MOAIMaterial.VALUETYPE_VEC2, tInvBuffSize )
    filter:setOutBuffer(rOutBuffer)
    return filter
end
function Post:OutlineFilter(rInBuffer, rOutBuffer)
    local filter = Post:GetNextFilter()
    filter:setInBuffer(rInBuffer)
    local outlineColor = { 1.0, 0.7, 0.0, 0.2 }
    local outlineWidth = 2.0
    filter:setMaterial("Materials/Outlines.material")
    filter:setShaderValue( "g_vOutlineColor", MOAIMaterial.VALUETYPE_VEC4, outlineColor )
    filter:setShaderValue( "g_fOutlineWidth", MOAIMaterial.VALUETYPE_FLOAT, outlineWidth)
    filter:setOutBuffer(rOutBuffer)
    filter:setBlendMode(kBLEND_PREMULTIPLIED)
    return filter
end
function Post:BlitFilter(rInBuffer, rOutBuffer, blendMode, tColor, tScale, tOffset)
    local filter = Post:GetNextFilter()
    filter:setInBuffer(rInBuffer)
    if not tColor then tColor = {1,1,1,1} end
    if not tScale then tScale = {1,1} end
    if not tOffset then tOffset = {0,0} end
    filter:setShaderValue( "g_vColor", MOAIMaterial.VALUETYPE_VEC4, tColor)
    filter:setShaderValue( "g_vScale", MOAIMaterial.VALUETYPE_VEC2, tScale)
    filter:setShaderValue( "g_vOffset", MOAIMaterial.VALUETYPE_VEC2, tOffset)
    filter:setOutBuffer(rOutBuffer)
    filter:setBlendMode(kBLEND_PREMULTIPLIED)
    return filter
end
function Post:BlitBackgroundFilter(rOutBuffer)
    for i in ipairs(kBackgroundLayerOrder) do
        local buffer = Post.rRenderer.getLayerFrameBuffer(kBackgroundLayerOrder[i])
        Post:BlitFilter(buffer, rOutBuffer)
    end
end
function Post:BlitSceneFilter(rOutBuffer)
    for i in ipairs(kSceneLayerOrder) do
        local buffer = Post.rRenderer.getLayerFrameBuffer(kSceneLayerOrder[i])
        Post:BlitFilter(buffer, rOutBuffer)
    end
    local buffer = Post.rRenderer.getFrameBuffer("SceneForeground")
    Post:BlitFilter(buffer, rOutBuffer)
end
return Post
