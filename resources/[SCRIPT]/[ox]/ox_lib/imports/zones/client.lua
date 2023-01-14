local glm = require 'glm'

---@class CZone
---@field id number
---@field coords vector3
---@field distance number
---@field remove fun()
---@field contains fun(self: CZone, coords?: vector3): boolean
---@field onEnter fun(self: CZone)?
---@field onExit fun(self: CZone)?
---@field inside fun(self: CZone)?
---@field [string] any

---@type { [number]: CZone }
Zones = {}

local function nextFreePoint(points, b, len)
    for i = 1, len do
        local n = (i + b) % len

        n = n ~= 0 and n or len

        if points[n] then
            return n
        end
    end
end

local function getTriangles(polygon)
    local triangles = {}

    if polygon:isConvex() then
        for i = 2, #polygon - 1 do
            triangles[#triangles + 1] = mat(polygon[1], polygon[i], polygon[i + 1])
        end
        return triangles
    end

    local points = {}

    for i = 1, #polygon do
        points[i] = polygon[i]
    end

    local a, b, c = 1, 2, 3
    local len = #points

    while len - #triangles > 2 do
        if polygon:containsSegment(glm.segment.getPoint(polygon[a], polygon[c], 0.01), glm.segment.getPoint(polygon[a], polygon[c], 0.99)) then
            triangles[#triangles + 1] = mat(polygon[a], polygon[b], polygon[c])
            points[b] = false

            b = c
            c = nextFreePoint(points, b, len)
        else
            a = b
            b = c
            c = nextFreePoint(points, b, len)
        end
    end

    return triangles
end

local insideZones = {}
local enteringZones = {}
local exitingZones = {}
local enteringSize = 0
local exitingSize = 0
local tick
local glm_polygon_contains = glm.polygon.contains

local function removeZone(self)
    Zones[self.id] = nil
    insideZones[self.id] = nil
    enteringZones[self.id] = nil
    exitingZones[self.id] = nil
end

CreateThread(function()
    while true do
        local coords = GetEntityCoords(cache.ped)
        cache.coords = coords

        for _, zone in pairs(Zones) do
            zone.distance = #(zone.coords - coords)
            local radius, contains = zone.radius

            if radius then
                contains = zone.distance < radius
            else
                contains = glm_polygon_contains(zone.polygon, coords, zone.thickness / 4)
            end

            if contains then
                if not zone.insideZone then
                    zone.insideZone = true

                    if zone.onEnter then
                        enteringSize += 1
                        enteringZones[enteringSize] = zone
                    end

                    if zone.inside or zone.debug then
                        insideZones[zone.id] = zone
                    end
                end
            else
                if zone.insideZone then
                    zone.insideZone = false
                    insideZones[zone.id] = nil

                    if zone.onExit then
                        exitingSize += 1
                        exitingZones[exitingSize] = zone
                    end
                end

                if zone.debug then
                    insideZones[zone.id] = zone
                end
            end
        end

        if exitingSize > 0 then
            table.sort(exitingZones, function(a, b)
                return a.distance > b.distance
            end)

            for i = 1, exitingSize do
                exitingZones[i]:onExit()
            end

            exitingSize = 0
            table.wipe(exitingZones)
        end

        if enteringSize > 0 then
            table.sort(enteringZones, function(a, b)
                return a.distance < b.distance
            end)

            for i = 1, enteringSize do
                enteringZones[i]:onEnter()
            end

            enteringSize = 0
            table.wipe(enteringZones)
        end

        if not tick then
            if next(insideZones) then
                tick = SetInterval(function()
                    for _, zone in pairs(insideZones) do
                        if zone.debug then
                            zone:debug()

                            if zone.inside and zone.insideZone then
                                zone:inside()
                            end
                        else
                            zone:inside()
                        end
                    end
                end)
            end
        elseif not next(insideZones) then
            tick = ClearInterval(tick)
        end

        Wait(300)
    end
end)

local DrawLine = DrawLine
local DrawPoly = DrawPoly

local function debugPoly(self)
    for i = 1, #self.triangles do
        local triangle = self.triangles[i]
        DrawPoly(triangle[1].x, triangle[1].y, triangle[1].z, triangle[2].x, triangle[2].y, triangle[2].z, triangle[3].x
            ,
            triangle[3].y, triangle[3].z, 255, 42, 24, 100)
        DrawPoly(triangle[2].x, triangle[2].y, triangle[2].z, triangle[1].x, triangle[1].y, triangle[1].z, triangle[3].x
            ,
            triangle[3].y, triangle[3].z, 255, 42, 24, 100)
    end
    for i = 1, #self.polygon do
        local thickness = vec(0, 0, self.thickness / 2)
        local a = self.polygon[i] + thickness
        local b = self.polygon[i] - thickness
        local c = (self.polygon[i + 1] or self.polygon[1]) + thickness
        local d = (self.polygon[i + 1] or self.polygon[1]) - thickness
        DrawLine(a.x, a.y, a.z, b.x, b.y, b.z, 255, 42, 24, 225)
        DrawLine(a.x, a.y, a.z, c.x, c.y, c.z, 255, 42, 24, 225)
        DrawLine(b.x, b.y, b.z, d.x, d.y, d.z, 255, 42, 24, 225)
        DrawPoly(a.x, a.y, a.z, b.x, b.y, b.z, c.x, c.y, c.z, 255, 42, 24, 100)
        DrawPoly(c.x, c.y, c.z, b.x, b.y, b.z, a.x, a.y, a.z, 255, 42, 24, 100)
        DrawPoly(b.x, b.y, b.z, c.x, c.y, c.z, d.x, d.y, d.z, 255, 42, 24, 100)
        DrawPoly(d.x, d.y, d.z, c.x, c.y, c.z, b.x, b.y, b.z, 255, 42, 24, 100)
    end
end

local function debugSphere(self)
    DrawMarker(28, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, self.radius, self.radius, self.radius, 255, 42, 24, 100, false, false, 0, false, false, false, false)
end

local function contains(self, coords)
    return glm_polygon_contains(self.polygon, coords, self.thickness / 4)
end

local function insideSphere(self, coords)
    return #(self.coords - coords) < self.radius
end

local function convertToVector(coords)
    local _type = type(coords)

    if _type ~= 'vector3' then
        if _type == 'table' or _type == 'vector4' then
            return vec3(coords[1] or coords.x, coords[2] or coords.y, coords[3] or coords.z)
        end

        error(("expected type 'vector3' or 'table' (received %s)"):format(_type))
    end

    return coords
end

lib.zones = {
    ---@return CZone
    poly = function(data)
        data.id = #Zones + 1
        data.thickness = data.thickness or 4

        local pointN = #data.points
        local points = table.create(pointN, 0)

        for i = 1, pointN do
            points[i] = convertToVector(data.points[i])
        end

        data.polygon = glm.polygon.new(points)
        data.coords = data.polygon:centroid()
        data.remove = removeZone
        data.contains = contains

        if data.debug then
            data.triangles = getTriangles(data.polygon)
            data.debug = debugPoly
        end

        Zones[data.id] = data
        return data
    end,

    ---@return CZone
    box = function(data)
        data.id = #Zones + 1
        data.coords = convertToVector(data.coords)
        data.size = data.size and convertToVector(data.size) / 2 or vec3(2)
        data.thickness = data.size.z * 2 or 4
        data.rotation = quat(data.rotation or 0, vec3(0, 0, 1))
        data.polygon = (data.rotation * glm.polygon.new({
            vec3(data.size.x, data.size.y, 0),
            vec3(-data.size.x, data.size.y, 0),
            vec3(-data.size.x, -data.size.y, 0),
            vec3(data.size.x, -data.size.y, 0),
        }) + data.coords)
        data.remove = removeZone
        data.contains = contains

        if data.debug then
            data.triangles = { mat(data.polygon[1], data.polygon[2], data.polygon[3]), mat(data.polygon[1], data.polygon[3], data.polygon[4]) }
            data.debug = debugPoly
        end

        Zones[data.id] = data
        return data
    end,

    ---@return CZone
    sphere = function(data)
        data.id = #Zones + 1
        data.coords = convertToVector(data.coords)
        data.radius = (data.radius or 2) + 0.0
        data.remove = removeZone
        data.contains = insideSphere

        if data.debug then
            data.debug = debugSphere
        end

        Zones[data.id] = data
        return data
    end,
}

return lib.zones
