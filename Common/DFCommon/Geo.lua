local Geo = {}
Geo.vertexFormat = MOAIVertexFormat.new()
Geo.vertexFormat:declareCoord(1, MOAIVertexFormat.GL_FLOAT, 3)
Geo.vertexFormat:declareUV(2, MOAIVertexFormat.GL_FLOAT, 2)
Geo.vertexFormat:declareColor(3, MOAIVertexFormat.GL_UNSIGNED_BYTE)
local DFSchema = require('DFCommon.DFSchema')
Geo.rGeometrySchema = DFSchema.object(
    {
        tRect = DFSchema.rect(nil, "The world-space size of the geometry (needed to compute UVs when generating vertex buffers)"),
        tPolygons = DFSchema.array(
            DFSchema.object(
                {
                    tExteriorPoints = DFSchema.array(
                        DFSchema.vec2(nil, "A point in the exterior profile of the polygon."),
                        "A list of points comprising the exterior profile of the polygon."
                    ),
                    tNegativePolygons = DFSchema.array(
                        DFSchema.array(
                            DFSchema.vec2(nil, "A point in the profile of the negative-space polygon."),
                            "An array of points comprising interior profile of a negative-space polygon."
                        ),
                        "A list of polygons that comprise the negative \"interior\" space of this polygon."
                    ),
                },
                "A polygon definition."
            ),
            "A list of polygons comprising this geometry object."
        ),
    },
    "A geometry definition."
)
Geo.rSchema = DFSchema.object(
    {
        tDefaultGeometry = Geo.rGeometrySchema,
        tFrameGeometry = DFSchema.table(Geo.rGeometrySchema, "A table of frame-specific geometry overrides."),
        tVertices = DFSchema.array(
            DFSchema.object(
                {
                    [1] = DFSchema.vec3(nil, "The model-space coordinate for this vertex"),
                    [2] = DFSchema.vec2(nil, "The uv coordinate for this vertex"),
                },
                "A vertex definition"
            ),
            "A list of unpacked vertices referenced by tIndices for the geometry's triangulation."
        ),
        tIndices = DFSchema.array(
            DFSchema.number(nil, "An index into tVertices"),
            "An unpacked list of indices into tVertices that comprise the triangulation for the geometry."
        ),
        tDefaultIndexRange = DFSchema.vec2(nil, "The range of indices in tIndices for the default geometry."),
        tFrameIndexRanges = DFSchema.table(
            DFSchema.vec2(nil, "The range of indices in tIndices for this frame's geometry."),
            "A table of ranges in tIndices for frame overrides"
        ),
    },
    "A geometry object definition."
)
function Geo.load(sDataPath)
	local rGeo = Geo.new( dofile(sDataPath) )
	return rGeo
end
function Geo.new(tData)
    local self = {}
    setmetatable(self, { __index = Geo })
    self.tData = tData
    if not self.tData.tDefaultGeometry then
        self.tData.tDefaultGeometry = {
            tRect = { 0, 0, 512, 512 },
            tPolygons = {},
        }
    end
    if not self.tData.tFrameGeometry then
        self.tData.tFrameGeometry = {}
    end
    return self
end
function Geo:createBuffers()
    local vb = MOAIVertexBuffer.new()
    vb:setFormat(Geo.vertexFormat)
    vb:reserveVerts(#self.tData.tVertices)
    for _, vertex in ipairs(self.tData.tVertices) do
        local loc, uv = unpack(vertex)
        vb:writeFloat(unpack(loc))
        vb:writeFloat(unpack(uv))
        vb:writeColor32(1, 1, 1, 1)
    end
    vb:bless()
    local ib = MOAIIndexBuffer.new()
    ib:reserve(#self.tData.tIndices)
    for i, index in ipairs(self.tData.tIndices) do
        ib:setIndex(i, index)
    end
    return vb, ib
end
function Geo:getGeometry(frame)
    if self.tData.tFrameGeometry then
        local tGeometry = self.tData.tFrameGeometry[frame]
        if tGeometry then
            return tGeometry
        end
    end
    return self.tData.tDefaultGeometry
end
function Geo:getIndexRange(frame)
    if self.tData.tFrameIndexRanges then
        local tRange = self.tData.tFrameIndexRanges[frame]
        if tRange then
            return unpack(tRange)
        end
    end
    return unpack(self.tData.tDefaultIndexRange)
end
function Geo:polygon(pointIndex)
    local container, index = self:_getContainer(pointIndex)
    return container
end
function Geo:closestPoint(frame, u, v)
    local closestPolygon = nil
    local closestNegativePoly = nil
    local closestPoint = nil
    local closestPointDistSq = nil
    local tGeometry = self:getGeometry(frame)
    for polyIndex, tPolygon in ipairs(tGeometry.tPolygons) do
        for pointIndex, point in ipairs(tPolygon.tExteriorPoints) do
            local du, dv = point[1] - u, point[2] - v
            local distSq = du * du + dv * dv
            if closestPointDistSq == nil or distSq < closestPointDistSq then
                closestPolygon = polyIndex
                closestNegativePoly = 0
                closestPoint = pointIndex
                closestPointDistSq = distSq
            end
        end
        if tPolygon.tNegativePolygons then
            for negativeIndex, tNegativePolygon in ipairs(tPolygon.tNegativePolygons) do
                for pointIndex, point in ipairs(tNegativePolygon) do
                    local du, dv = point[1] - u, point[2] - v
                    local distSq = du * du + dv * dv
                    if closestPointDistSq == nil or distSq < closestPointDistSq then
                        closestPolygon = polyIndex
                        closestNegativePoly = negativeIndex
                        closestPoint = pointIndex
                        closestPointDistSq = distSq
                    end
                end
            end
        end
    end
    if closestPolygon == nil then
        return
    end
    return { frame, closestPolygon, closestNegativePoly, closestPoint }, closestPointDistSq
end
function Geo:closestSegment(frame, u, v)
    local closestPolygon = nil
    local closestNegativePoly = nil
    local closestSegment = nil
    local closestPointDistSq = nil
    local tGeometry = self:getGeometry(frame)
    for polyIndex, tPolygon in ipairs(tGeometry.tPolygons) do
        local exteriorCount = #tPolygon.tExteriorPoints
        if exteriorCount ~= 0 then
            local prevPoint = tPolygon.tExteriorPoints[exteriorCount]
            for pointIndex, point in ipairs(tPolygon.tExteriorPoints) do
                local distSq = self:_segmentDistSq(u, v, prevPoint[1], prevPoint[2], point[1], point[2])
                if closestPointDistSq == nil or distSq < closestPointDistSq then
                    closestPolygon = polyIndex
                    closestNegativePoly = 0
                    closestSegment = pointIndex - 1
                    if closestSegment == 0 then
                        closestSegment = exteriorCount
                    end
                    closestPointDistSq = distSq
                end
                prevPoint = point
            end
        end
        if tPolygon.tNegativePolygons then
            for negativeIndex, tNegativePolygon in ipairs(tPolygon.tNegativePolygons) do
                local negativeCount = #tNegativePolygon
                if negativeCount ~= 0 then
                    local prevPoint = tNegativePolygon[negativeCount]
                    for pointIndex, point in ipairs(tNegativePolygon) do
                        local distSq = self:_segmentDistSq(u, v, prevPoint[1], prevPoint[2], point[1], point[2])
                        if closestPointDistSq == nil or distSq < closestPointDistSq then
                            closestPolygon = polyIndex
                            closestNegativePoly = negativeIndex
                            closestSegment = pointIndex - 1
                            if closestSegment == 0 then
                                closestSegment = negativeCount
                            end
                            closestPointDistSq = distSq
                        end
                        prevPoint = point
                    end
                end
            end
        end
    end
    if closestPolygon == nil then
        return
    end
    return { frame, closestPolygon, closestNegativePoly, closestSegment }, closestPointDistSq
end
function Geo:_getContainer(pointIndex)
    local frame, polyIndex, negativeIndex, point = unpack(pointIndex)
    local tGeometry = self:getGeometry(frame)
    local tPoly = tGeometry.tPolygons[polyIndex]
    if negativeIndex == 0 then
        return tPoly.tExteriorPoints, point
    else
        return tPoly.tNegativePolygons[negativeIndex], point
    end
end
function Geo:_segmentDistSq(u, v, u0, v0, u1, v1)
    local du, dv = u - u0, v - v0
    local vu, vv = u1 - u0, v1 - v0
    local t = (du * vu + dv * vv) / (vu * vu + vv * vv)
    t = math.max(0, math.min(t, 1))
    local u2, v2 = u0 + vu * t, v0 + vv * t
    local vu2, vv2 = u - u2, v - v2
    return vu2 * vu2 + vv2 * vv2
end
return Geo
