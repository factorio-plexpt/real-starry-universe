local placeholder_png = "__real-starry-universe__/graphics/planet.png"


local planet_technologies = {}
-- local PlanetTechnologies = {
--     { "sol", "太阳轨道", { "planet-discovery-mercury", "space-platform-thruster" }, true },
--     { "mercury", "水星", { "planet-discovery-venus", "space-platform-thruster" }, false },
--     { "venus", "金星", { "planet-discovery-luna", "space-platform-thruster" }, false },
--     { "earth", "地球", { "space-platform-thruster" }, false },
--     { "luna", "月球", { "planet-discovery-earth", "space-platform-thruster" }, false },
--     { "mars", "火星", { "planet-discovery-luna", "space-platform-thruster" }, false },
--     { "phobos", "火卫一", { "planet-discovery-mars", "space-platform-thruster" }, true },
--     { "deimos", "火卫二", { "planet-discovery-mars", "space-platform-thruster" }, true },
--     { "asteroid-belt-inner", "内小行星带", { "planet-discovery-mars", "space-platform-thruster" }, false },
--     { "jupiter", "木星", { "planet-discovery-asteroid-belt-inner", "space-platform-thruster" }, false },
--     { "saturn", "土星", { "planet-discovery-jupiter", "space-platform-thruster" }, false },
--     { "uranus", "天王星", { "planet-discovery-saturn", "space-platform-thruster" }, false },
--     { "neptune", "海王星", { "planet-discovery-uranus", "space-platform-thruster" }, false },
--     { "pluto", "冥王星", { "planet-discovery-neptune", "space-platform-thruster" }, false },
--     { "asteroid-belt-outer", "柯伊伯带", { "planet-discovery-pluto", "space-platform-thruster" }, false }
-- }

-- Reconstruct the planets array from planet.lua.
local planets = {}

for _, planet in pairs(data.raw["planet"]) do
    if planet.mod == "rsu" then
        table.insert(planets, planet)
    end
end
for _, space_location in pairs(data.raw["space-location"]) do
    if space_location.mod == "rsu" then
        table.insert(planets, space_location)
    end
end

-- Loop through each planet and make a technology.
for _, planet in pairs(planets) do
    if planet then
        if data.raw["technology"]["planet-discovery-" .. planet.name] == nil and data.raw["technology"]["moon-discovery-" .. planet.name] == nil then -- Compatibility check to not duplicate planet or moon discovery technologies.
            local planet_technology = {}
            planet_technology[1] = planet.name
            planet_technology[2] = {"space-platform-thruster"}
            if planet.prerequisite and data.raw["technology"][planet.prerequisite] then
                table.insert(planet_technology[2], planet.prerequisite)
            end
            if planet.icon then
                planet_technology[3] = planet.icon
            else
                planet_technology[3] = placeholder_png
            end

            if planet.icon_size then
                planet_technology[4] = planet.icon_size
            else
                planet_technology[4] = 512
            end

            if planet.moon == true then
                planet_technology[5] = "moon"
            else
                planet_technology[5] = "planet"
            end

            table.insert(planet_technologies, planet_technology)
        end
    end
end

for i, tech in ipairs(planet_technologies) do
    local planet_name = tech[1]
    local prerequisites = tech[2]
    local icon = tech[3]
    local icon_size = tech[4]
    local planet_type = tech[5]

    data:extend({
        {
            type = "technology",
            name = planet_type .. "-discovery-" .. planet_name,
            icon = icon, -- 替换为行星对应的图标路径
            icon_size = icon_size,
            essential = true,
            effects = {
                {
                    type = "unlock-space-location",
                    space_location = planet_name,
                    use_icon_overlay_constant = true
                }
            },
            prerequisites = prerequisites,
            unit = {
                count = 10,
                ingredients = {
                    { "automation-science-pack", 1 },
                },
                time = 60
            },
            localised_name = {"?", {"technology-name.planet-discovery-" .. planet_name}, {"technology-name.planet-discovery-fallback", {"space-location-name." .. planet_name}}},
            localised_description = {"?", {"technology-description.planet-discovery-" .. planet_name}, {"technology-description.planet-discovery-fallback", {"space-location-name." .. planet_name}}}
        }
    })
end
