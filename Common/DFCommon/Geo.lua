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
function Geo:getPoint(pointIndex)
    local container, index = self:_getContainer(pointIndex)
    return unpack(container[index])
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
function Geo:triangulate()
    self.tData.tVertices = {}
    self.tData.tIndices = {}
    self.tData.tDefaultIndexRange = { self:_triangulateGeometry(0, self.tData.tDefaultGeometry) }
    self.tData.tFrameIndexRanges = {}
    for frame, tGeometry in pairs(self.tData.tFrameGeometry) do
        self.tData.tFrameIndexRanges[frame] = { self:_triangulateGeometry(frame, tGeometry) }
    end
end
function Geo:_triangulateGeometry(frame, tGeometry)
    local rangeStart = #self.tData.tIndices + 1
    self.tTempIndexMap = {}
    for polyIndex, tPolygon in ipairs(tGeometry.tPolygons) do
        local tIndices = {}
        local tWindings = {}
        local tPolygonMonotoneEdges = {}
        local tVisitedIndices = {}
        local tPrev = {}
        local tNext = {}
        local exteriorArea = 0
        local exteriorCount = #tPolygon.tExteriorPoints
        local last = { frame, polyIndex, 0, exteriorCount }
        local prev = last
        local prevU, prevV = self:getPoint(prev)
        for point, value in ipairs(tPolygon.tExteriorPoints) do
            local u, v = unpack(value)
            local vertex
            if point ~= exteriorCount then
                vertex = { frame, polyIndex, 0, point }
            else
                vertex = last
            end
            tNext[prev] = vertex
            tPrev[vertex] = prev
            table.insert(tIndices, vertex)
            exteriorArea = exteriorArea + (u - prevU) * (v + prevV)
            prevU, prevV = u, v
            prev = vertex
        end
        tWindings[0] = exteriorArea > 0
        if tPolygon.tNegativePolygons then
            for negativeIndex, tNegativePolygon in ipairs(tPolygon.tNegativePolygons) do
                local interiorArea = 0
                local negativeCount = #tNegativePolygon
                last = { frame, polyIndex, negativeIndex, negativeCount }
                prev = last
                prevU, prevV = self:getPoint(prev)
                for point, value in ipairs(tNegativePolygon) do
                    local u, v = unpack(value)
                    local vertex
                    if point ~= negativeCount then
                        vertex = { frame, polyIndex, negativeIndex, point }
                    else
                        vertex = last
                    end
                    tNext[prev] = vertex
                    tPrev[vertex] = prev
                    table.insert(tIndices, vertex)
                    interiorArea = interiorArea + (u - prevU) * (v + prevV)
                    prevU, prevV = u, v
                    prev = vertex
                end
                tWindings[negativeIndex] = interiorArea < 0
            end
        end
        function less(edge, u, v)
            local e0 = edge
            local e1 = tNext[edge]
            local u0, v0 = self:getPoint(e0)
            local u1, v1 = self:getPoint(e1)
            if v0 == v1 then
                return math.min(u0, u1) < u
            else
                local eu = u0 + (u1 - u0) * (v - v0) / (v1 - v0)
                return eu < u
            end
        end
        self:_sortPoints(tIndices)
        local edgeList = {}
        for i, index in ipairs(tIndices) do
            local u, v = self:getPoint(index)
            local edgeCursor = 0
            local edgeLess = true
            local edgeLength = #edgeList
            while edgeLess and edgeCursor <= edgeLength do
                edgeCursor = edgeCursor + 1
                local edge = edgeList[edgeCursor]
                if edge then
                    edgeLess = less(edge, u, v)
                end
            end
            local a = edgeList[edgeCursor - 1]
            local b = edgeList[edgeCursor]
            local c = tPrev[index]
            local d = index
            local cBelow = self:_pointBelow(c, index)
            local dBelow = self:_pointBelow(tNext[d], index)
            local dLeft = less(d, self:getPoint(c))
            if dLeft then
                c, d = d, c
                cBelow, dBelow = dBelow, cBelow
            end
            local negativeIndex = index[3]
            local bWoundCCW = tWindings[negativeIndex]
            if cBelow ~= dBelow then
                if not cBelow then
                    c, d = d, c
                end
                if self:_pointsEqual(c, a) then
                    edgeList[edgeCursor - 1] = d
                elseif self:_pointsEqual(c, b) then
                    edgeList[edgeCursor] = d
                else
                    table.insert(edgeList, edgeCursor, d)
                end
            elseif cBelow then
                while self:_pointsEqual(c, a) or self:_pointsEqual(d, a) do
                    edgeCursor = edgeCursor - 1
                    table.remove(edgeList, edgeCursor)
                    a = edgeList[edgeCursor - 1]
                end
                while self:_pointsEqual(c, b) or self:_pointsEqual(d, b) do
                    table.remove(edgeList, edgeCursor)
                    b = edgeList[edgeCursor]
                end
                if a and b and dLeft == bWoundCCW then
                    local aEnd = tNext[a]
                    local aAbove
                    if self:_pointBelow(a, aEnd) then
                        aAbove = aEnd
                    else
                        aAbove = a
                    end
                    local bEnd = tNext[b]
                    local bAbove
                    if self:_pointBelow(b, bEnd) then
                        bAbove = bEnd
                    else
                        bAbove = b
                    end
                    local target = nil
                    local j = i + 1
                    while not target and j < #tIndices do
                        local candidate = tIndices[j]
                        if self:_pointsEqual(aAbove, candidate) then
                            target = aAbove
                        elseif self:_pointsEqual(bAbove, candidate) then
                            target = bAbove
                        else
                            local cu, cv = self:getPoint(candidate)
                            if less(a, cu, cv) and not less(b, cu, cv) then
                                target = candidate
                            end
                        end
                        j = j + 1
                    end
                    if target then
                        tVisitedIndices[target] = true
                        table.insert(tPolygonMonotoneEdges, { index, target })
                    end
                end
            else
                if not tVisitedIndices[index] and a and b and dLeft ~= bWoundCCW then
                    local aEnd = tNext[a]
                    local aBelow
                    if self:_pointBelow(a, aEnd) then
                        aBelow = a
                    else
                        aBelow = aEnd
                    end
                    local bEnd = tNext[b]
                    local bBelow
                    if self:_pointBelow(b, bEnd) then
                        bBelow = b
                    else
                        bBelow = bEnd
                    end
                    local target = nil
                    local j = i - 1
                    while not target and j > 0 do
                        local candidate = tIndices[j]
                        if self:_pointsEqual(aBelow, candidate) then
                            target = aBelow
                        elseif self:_pointsEqual(bBelow, candidate) then
                            target = bBelow
                        else
                            local cu, cv = self:getPoint(candidate)
                            if less(a, cu, cv) and not less(b, cu, cv) then
                                target = candidate
                            end
                        end
                        j = j - 1
                    end
                    if target then
                        table.insert(tPolygonMonotoneEdges, { index, target })
                    end
                end
                if not self:_pointsEqual(d, a) and not self:_pointsEqual(d, b) then
                    table.insert(edgeList, edgeCursor, d)
                end
                if not self:_pointsEqual(c, a) and not self:_pointsEqual(c, b) then
                    table.insert(edgeList, edgeCursor, c)
                end
            end
        end
        self:_findMonotone(tGeometry, tIndices, tNext, tPrev, tWindings, tPolygonMonotoneEdges)
    end
    self.tTempIndexMap = nil
    return rangeStart, #self.tData.tIndices
end
function Geo:_sortPoints(tPoints)
    table.sort(tPoints, function(a, b) return self:_pointBelow(a, b) end)
end
function Geo:_pointBelow(a, b)
    local au, av = self:getPoint(a)
    local bu, bv = self:getPoint(b)
    if av == bv then
        return au < bu
    end
    return av < bv
end
function Geo:_findMonotone(tGeometry, tIndices, tNext, tPrev, tWindings, tExtraEdges)
    local tEdgeMap = {}
    for _, edgePair in ipairs(tExtraEdges) do
        local source, target = unpack(edgePair)
        if not tEdgeMap[source] then
            tEdgeMap[source] = {}
        end
        table.insert(tEdgeMap[source], target)
        if not tEdgeMap[target] then
            tEdgeMap[target] = {}
        end
        table.insert(tEdgeMap[target], source)
    end
    local tVisitedEdges = {}
    for _, edge in ipairs(tIndices) do
        if not tVisitedEdges[edge] then
            local windingDir
            if tWindings[edge[3]] then
                windingDir = 1
            else
                windingDir = -1
            end
            function windingNeighbor(point)
                if windingDir > 0 then
                    return tNext[point]
                else
                    return tPrev[point]
                end
            end
            local edgeCursor = windingNeighbor(edge)
            local prevCursor = edge
            tVisitedEdges[edge] = true
            local tMonotoneVertices = { edge }
            while not self:_pointsEqual(edgeCursor, edge) and #tMonotoneVertices < #tIndices do
                table.insert(tMonotoneVertices, edgeCursor)
                tBranches = tEdgeMap[edgeCursor]
                local branchTarget = nil
                if tBranches then
                    local bWindUp = self:_pointBelow(prevCursor, edgeCursor)
                    local u0, v0 = self:getPoint(edgeCursor)
                    local u1, v1 = self:getPoint(prevCursor)
                    local du, dv = u1 - u0, v1 - v0
                    local length = math.sqrt(du * du + dv * dv)
                    du, dv = du / length, dv / length
                    function getTheta(target)
                        local bu, bv = self:getPoint(target)
                        local bdu, bdv = bu - u0, bv - v0
                        local bLength = math.sqrt(bdu * bdu + bdv * bdv)
                        bdu, bdv = bdu / bLength, bdv / bLength
                        local dot = du * bdu + dv * bdv
                        local theta = math.acos(dot)
                        local cross = du * bdv - dv * bdu
                        if (cross * windingDir < 0) ~= (windingDir < 0) then
                            theta = 2 * math.pi - theta
                        end
                        return theta
                    end
                    local bestTheta = getTheta(windingNeighbor(edgeCursor))
                    for _, branch in ipairs(tBranches) do
                        if not self:_pointsEqual(branch, edgeCursor) and not self:_pointsEqual(branch, prevCursor) then
                            local theta = getTheta(branch)
                            if theta < bestTheta then
                                branchTarget = branch
                                bestTheta = theta
                            end
                        end
                    end
                end
                prevCursor = edgeCursor
                if branchTarget then
                    local sourceWinding = tWindings[edgeCursor[3]]
                    local targetWinding = tWindings[branchTarget[3]]
                    edgeCursor = branchTarget
                    if sourceWinding ~= targetWinding then
                        windingDir = -windingDir
                    end
                else
                    tVisitedEdges[edgeCursor] = true
                    edgeCursor = windingNeighbor(edgeCursor)
                end
            end
            if #tMonotoneVertices > #tIndices then
                print("Degenerate tesselation loop detected!")
            end
            self:_triangulateMonotone(tGeometry, tMonotoneVertices)
        end
    end
end
function Geo:_triangulateMonotone(tGeometry, tVertices)
    local tPrev = {}
    local tNext = {}
    local prevVertex = tVertices[#tVertices]
    for _, vertex in ipairs(tVertices) do
        tNext[prevVertex] = vertex
        tPrev[vertex] = prevVertex
        prevVertex = vertex
    end
    self:_sortPoints(tVertices)
    local tStack = { tVertices[1], tVertices[2] }
    local index = 3
    for index = 3, #tVertices do
        local vertex = tVertices[index]
        local vBottom, vTop = tStack[1], tStack[#tStack]
        local bottomAdjacent = tPrev[vertex] == vBottom or tNext[vertex] == vBottom
        local topAdjacent = tPrev[vertex] == vTop or tNext[vertex] == vTop
        if bottomAdjacent and not topAdjacent then
            for i = 1, #tStack - 1 do
                self:_addTriangle(tGeometry, vertex, tStack[i], tStack[i + 1])
            end
            tStack = { vTop, vertex }
        elseif not bottomAdjacent and topAdjacent then
            function cross(p0, p1, p2)
                local u0, v0 = self:getPoint(p0)
                local u1, v1 = self:getPoint(p1)
                local u2, v2 = self:getPoint(p2)
                local au, av = u1 - u0, v1 - v0
                local bu, bv = u2 - u0, v2 - v0
                return au * bv - av * bu
            end
            function matchesWinding(p0, p1, p2)
                local triCross = cross(p1, p0, p2)
                local bWindUp = self:_pointBelow(tPrev[p2], p2)
                return (triCross > 0) == bWindUp
            end
            local i = #tStack
            while i > 1 and matchesWinding(tStack[i - 1], tStack[i], vertex) do
                self:_addTriangle(tGeometry, tStack[i - 1], tStack[i], vertex)
                table.remove(tStack, i)
                i = i - 1
            end
            table.insert(tStack, vertex)
        elseif bottomAdjacent and topAdjacent then
            for i = 1, #tStack - 1 do
                self:_addTriangle(tGeometry, vertex, tStack[i], tStack[i + 1])
            end
        end
    end
end
function Geo:_addTriangle(tGeometry, p0, p1, p2)
    local i0, i1, i2 = self.tTempIndexMap[p0], self.tTempIndexMap[p1], self.tTempIndexMap[p2]
    function makeVertex(point)
        local u0, v0, u1, v1 = unpack(tGeometry.tRect)
        local u, v = self:getPoint(point)
        local tu, tv = (u - u0) / (u1 - u0), (v - v0) / (v1 - v0)
        return { { u, v, 0 }, { tu, 1 - tv } }
    end
    if not i0 then
        table.insert(self.tData.tVertices, makeVertex(p0))
        i0 = #self.tData.tVertices
        self.tTempIndexMap[p0] = i0
    end
    if not i1 then
        table.insert(self.tData.tVertices, makeVertex(p1))
        i1 = #self.tData.tVertices
        self.tTempIndexMap[p1] = i1
    end
    if not i2 then
        table.insert(self.tData.tVertices, makeVertex(p2))
        i2 = #self.tData.tVertices
        self.tTempIndexMap[p2] = i2
    end
    table.insert(self.tData.tIndices, i0)
    table.insert(self.tData.tIndices, i1)
    table.insert(self.tData.tIndices, i2)
end
function Geo:_pointsEqual(lhs, rhs)
    return lhs and rhs and lhs[1] == rhs[1] and lhs[2] == rhs[2] and lhs[3] == rhs[3] and lhs[4] == rhs[4]
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
