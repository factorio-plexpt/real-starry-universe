local RotationUtil = {}

-- Change coordinate systems from that of the first paramater to that of the second. Expects a "space-location" or "planet" Prototype for each paramater, with the first paramater's distance and orientation being relative to that of the second.
local function Unrelate(Planet, ParentObject)
    if ParentObject.distance == 0 then
        return -- This causes errors down the line, so just ignore that you ever called the function. The intended behavior of the function in this case is to do nothing anyway.
    end
    local AB = ParentObject.distance
    local BC = Planet.distance + ParentObject.magnitude
    local AB_BC = Planet.orientation

    local AB_BC_Radians = AB_BC * 2 * math.pi

    local AC = math.sqrt(AB^2 + BC^2 - 2 * AB * BC * math.cos(AB_BC_Radians))

    local COS_AB_AC_Radians = (AB^2 + AC^2 - BC^2) / (2 * AB * AC)
    COS_AB_AC_Radians = math.max(-1, math.min(1, COS_AB_AC_Radians))
    local AB_AC_Radians = math.acos(COS_AB_AC_Radians)

    local AB_AC = AB_AC_Radians / (2 * math.pi)

    Planet.orientation = AB_AC + ParentObject.orientation
    Planet.distance = AC
    if Planet.orientation > 1 then
        Planet.orientation = Planet.orientation % 1 -- Orientation cannot be greater than 1.
    end
end

RotationUtil.Unrelate = Unrelate

-- Change coordinate systems from that of the first and second paramaters to one relative to the second. Expects a "space-location" or "planet" Prototype for each paramater, with both paramaters in the same coordinate system.
local function Relate(Planet, ParentObject)
    if Planet.distance == 0 then
        error("Paramater 1 of function relate contains a zeroed distance! This would cause glitches, so I'll crash instead to make sure that intended behavior is followed.")
    end
    local AB = ParentObject.distance
    local AC = Planet.distance
    local AB_AC = math.abs(Planet.orientation - ParentObject.orientation)

    local AB_AC_Radians = AB_AC * 2 * math.pi

    local BC = math.sqrt(AB^2 + AC^2 - 2 * AB * AC * math.cos(AB_AC_Radians))

    local SIN_AB_AC = math.sqrt(1 - math.cos(AB_AC_Radians)^2)
    local SIN_AB_BC_Radians = (BC * SIN_AB_AC) / AC

    SIN_AB_BC_Radians = math.max(-1, math.min(1, SIN_AB_BC_Radians))

    local AB_BC_Radians = math.asin(SIN_AB_BC_Radians)

    local AB_BC = AB_BC_Radians / (2 * math.pi)

    Planet.orientation = AB_BC
    Planet.distance = BC - ParentObject.magnitude
    if Planet.orientation > 1 then
        Planet.orientation = Planet.orientation % 1 -- Orientation cannot be greater than 1.
    end
end

RotationUtil.Relate = Relate

return RotationUtil
