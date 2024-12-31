local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions") -- The original asteroid spawn definitions from Space Age. Should be replaced as soon as possible to allow custom spawn definitions.
-- local asteroid_util = require("asteroid_definitions.asteroid_util") -- New asteroid spawn definitions for when there's new definitions. It isn't ready yet.
local planet_catalogue_gleba = require("__space-age__.prototypes.planet.procession-catalogue-gleba")
local rotation_util = require("data.rotation_util")

local planet_map_gen = require("data.planet-map-gen")
local day = 24 * hour

local placeholder_png = "__real-starry-universe__/graphics/planet.png"

local planets = {
    {
        type = "space-location", -- This may need to be changed to "planet".
        name = "sol", -- Similar to how the moon is called luna, the sun is called sol. This is actually more commonly used than luna as the word solar is derived from the word sol.
        object_properties = {
            type = "star", -- This object is a star.
            parent_object = nil, -- The object this star orbits.
        },
        icon = "__core__/graphics/icons/starmap-star.png", -- This should eventually be replaced with a proper image.
        icon_size = 512,
        starmap_icon = "__core__/graphics/icons/starmap-star.png",
        starmap_icon_size = 512,
        gravity_pull = 21.7, -- The surface gravity of the sun, equal to 217 m/s. This shouldn't be 217, because 217 km/s is too fast for the average player's space platform or 2.17, because 2.17 doesn't add much challenge.
        distance = 0, -- The sun is 0 distance away from the sun, so this should be 0.
        orientation = 0 / 360, -- Orinetation doesn't matter for the sun.
        magnitude = 5, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        prerequisite = "planet-discovery-mercury",
    },
    {
        type = "planet",
        name = "mercury", -- 水星
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/mercury.png",
        icon_size = 512,
        gravity_pull = 3.7, -- 水星表面重力 (相对值)
        distance = 5.8, -- 距离星系中心 以15为一个AU，约 0.39 AU
        orientation = 40 / 360, -- 与星系中心角度
        magnitude = 0.383, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.mercury(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Mercury (水星)
            ["day-night-cycle"] = 58.7 * day, -- 水星昼夜周期：58.7个地球日
            ["magnetic-field"] = 1, -- 极弱的磁场
            ["solar-power"] = 500, -- 接收太阳能最多
            pressure = 0, -- 无明显大气压
            gravity = 3.7, -- 重力较小
        },
        prerequisite = "planet-discovery-venus",
    },
    {
        type = "planet",
        name = "venus", -- 金星
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/venus.png",
        icon_size = 512,
        gravity_pull = 8.87,
        distance = 10.8, -- 0.72 AU
        orientation = 80 / 360,
        magnitude = 0.949, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.venus(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Venus (金星)
            ["day-night-cycle"] = 243 * day, -- 金星昼夜周期：243个地球日
            ["magnetic-field"] = 1, -- 几乎无磁场
            ["solar-power"] = 90, -- 高温和厚大气层影响太阳能
            pressure = 920000, -- 极高的大气压（单位：Pa）
            gravity = 8.87, -- 类似于地球的重力
        },
        prerequisite = "planet-discovery-earth",
    },
    {
        type = "planet",
        name = "earth", -- 地球
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/earth.png",
        icon_size = 1024,
        gravity_pull = 9.8,
        distance = 15, -- 1 AU
        orientation = 120 / 360,
        magnitude = 1, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.earth(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Earth (地球)
            ["day-night-cycle"] = 1 * day, -- 地球昼夜周期：1个地球日
            ["magnetic-field"] = 100, -- 强磁场保护
            ["solar-power"] = 100, -- 标准太阳能基准
            pressure = 1000, -- 1个大气压
            gravity = 9.8, -- 地球重力
        },
        --lightning_properties = 闪电控制
    },
    {
        type = "planet",
        name = "luna",
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "earth", -- The object this moon orbits.
        },
        icon = "__real-starry-universe__/graphics/luna.png",
        icon_size = 512,
        gravity_pull = 1.62, -- 月球的重力
        distance = 1, -- New distance from earth instead of the sun.
        orientation = 180 / 360, -- New orientation relative to earth instead of the sun.
        magnitude = 0.273, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.luna(), -- 使用月球专属生成方法
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Luna (月球)
            ["day-night-cycle"] = 30 * day, -- 月球昼夜周期：27.3个地球日
            ["magnetic-field"] = 1, -- 极弱磁场
            ["solar-power"] = 136, -- 太阳能较高
            pressure = 0, -- 无大气
            gravity = 1.62, -- 重力远小于地球
        },
        prerequisite = "planet-discovery-earth",
    },
    {
        type = "planet",
        name = "mars",
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/mars.png",
        icon_size = 512,
        gravity_pull = 3.71,
        distance = 22.8, -- 1.52 AU
        orientation = 160 / 360,
        magnitude = 0.532, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.mars(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Mars (火星)
            ["day-night-cycle"] = 1.03 * day, -- 火星昼夜周期：接近地球
            ["magnetic-field"] = 1, -- 几乎无磁场
            ["solar-power"] = 43, -- 较远离太阳，太阳能效率低
            pressure = 6, -- 极低的大气压（单位：Pa）
            gravity = 3.71, -- 重力较低
        },
        prerequisite = "planet-discovery-earth",
    },
    {
        type = "planet",
        name = "phobos", -- Phobos, the first moon of mars.
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "mars", -- The object this moon orbits.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.0057, -- This is in m/s, convert as necessary.
        distance = 1, -- New distance from mars instead of the sun.
        orientation = 180 / 360, -- New orientation relative to mars instead of the sun.
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false. all moon need this.
        map_gen_settings = planet_map_gen.phobos(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Phobos
            ["day-night-cycle"] = 0.32 * day, -- Day night cycle of phobos.
            ["magnetic-field"] = 0, -- Phobos has no significant magnetic field.
            ["solar-power"] = 43.07 , -- Aproximate solar power recieved on phobos. Consistent with the solar power recieved on mars, so likely correct(ish).
            pressure = 0, -- Phobos is an asteroid-like moon and has no atmosphere.
            gravity = 0.01, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-mars",
    },
    {
        type = "planet",
        name = "deimos", -- Deimos, the second moon of mars.
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "mars", -- The object this moon orbits.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.003, -- This is in m/s, convert as necessary.
        distance = 2, -- New distance from mars instead of the sun.
        orientation = 180 / 360, -- New orientation relative to mars instead of the sun.
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.deimos(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Deimos
            ["day-night-cycle"] = 0.31 * day, -- Day night cycle of deimos.
            ["magnetic-field"] = 0, -- Deimos has no significant magnetic field.
            ["solar-power"] = 43.04, -- Aproximate solar power recieved on deimos. Consistent with the solar power recieved on mars, so likely correct(ish).
            pressure = 0, -- Deimos is an asteroid-like moon and has no atmosphere.
            gravity = 0.003, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-mars",
    },
    {
        type = "space-location", -- You should be able to land on asteroids in the asteroid belt. but must go to ceres
        name = "asteroid-belt-inner",
        object_properties = {
            type = "asteroid-belt", -- This object is an asteroid belt.
            parent_object = "sol", -- The object this asteroid belt orbits.
        },
        icon = "__real-starry-universe__/graphics/asteroid-belt-inner.png",
        icon_size = 512,
        gravity_pull = 0.01, -- Aproximate surface gravity for a specific asteroid (which will right now represnent all asteroids)
        distance = 27, -- 2.7 AU (centre of the inner asteroid belt)
        orientation = 185 / 360,
        magnitude = 1,
        map_gen_settings = planet_map_gen.asteroid_belt_1(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Inner Asteroid Belt (Between Mars and Jupiter)
            ["day-night-cycle"] = 0.37  * day, -- Aproximate day-night cycle for a specific asteroid (which will right now represnent all asteroids)
            ["magnetic-field"] = 0, -- Asteroids tend to have a very, very weak magnetic field. This is aproximated by 0 here.
            ["solar-power"] = 13.717, -- Percentage of solar power compared to that on earth? Seems to fit with the data of jupiter and mars, being about in between.
            pressure = 0, -- The pressure in the inner asteroid belt is 0, as there is no atmosphere to sustain (air) pressure, and no large enough objects to sustain an atmosphere.
            gravity = 0.01, -- Aproximate surface gravity for a specific asteroid (which will right now represnent all asteroids)
        },
        prerequisite = "planet-discovery-mars",
    },
    {
        type = "planet",
        name = "ceres", -- 谷神星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "inner-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/ceres.png",
        icon_size = 512,
        gravity_pull = 0.028,
        distance = 27, -- 2.77 AU
        orientation = 200 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.ceres(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Ceres (谷神星)
            ["day-night-cycle"] = 0.37  * day, -- 谷神星昼夜周期：约9小时
            ["magnetic-field"] = 0, -- 谷神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.028, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-inner",
    },

    {
        type = "planet",
        name = "vesta", -- 灶神星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "inner-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/vesta.png",
        icon_size = 512,
        gravity_pull = 0.025,
        distance = 27, -- 2.36 AU
        orientation = 260 / 360,
        magnitude = 0.2, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.vesta(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Vesta (灶神星)
            ["day-night-cycle"] = 0.37  * day, -- 灶神星昼夜周期：约5.3小时
            ["magnetic-field"] = 0, -- 灶神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.025, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-inner",
    },

    {
        type = "planet",
        name = "pallas", -- 智神星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "inner-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/pallas.png",
        icon_size = 512,
        gravity_pull = 0.020,
        distance = 27, -- 2.77 AU
        orientation = 300 / 360,
        magnitude = 0.2, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.pallas(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Pallas (智神星)
            ["day-night-cycle"] = 0.37  * day, -- 智神星昼夜周期：约7.8小时
            ["magnetic-field"] = 0, -- 智神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.020, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-inner",
    },
    {
        type = "planet",
        name = "hygiea", -- 健神星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "inner-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/hygiea.png",
        icon_size = 512,
        gravity_pull = 0.005,
        distance = 27, -- 3.14 AU
        orientation = 355 / 360,
        magnitude = 0.2, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.hygiea(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Hygiea (健神星)
            ["day-night-cycle"] = 0.37 * day, -- 健神星昼夜周期：约13小时
            ["magnetic-field"] = 0, -- 健神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.005, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-inner",
    },
    {
        type = "planet",
        name = "jupiter", -- 木星
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/jupiter.png",
        icon_size = 512,
        gravity_pull = 24.79,
        distance = 77.8 / 2, -- 5.2 AU
        orientation = 240 / 360,
        magnitude = 11.209, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.jupiter(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Jupiter (木星)
            ["day-night-cycle"] = 0.41 * day, -- 木星昼夜周期：10小时
            ["magnetic-field"] = 20000, -- 极强磁场
            ["solar-power"] = 3.7, -- 距太阳远，太阳能效率非常低
            pressure = 200000000, -- 压力极高（单位：Pa）
            gravity = 24.79, -- 极高重力
        },
        prerequisite = "planet-discovery-asteroid-belt-inner",
    },
    {
        type = "planet",
        name = "io", -- Io
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "jupiter", -- Io orbits jupiter.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 1.796502844, -- This is in m/s, convert as necessary.
        distance = 1,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.io(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Io
            ["day-night-cycle"] = 1.75 * day, -- Length of a day on io, aproximately 1.75 earth days.
            ["magnetic-field"] = 0, -- Io doesn't have a significant magnetic field.
            ["solar-power"] = 3.69735907899, -- Solar power on io, similar to that of jupiter - so hopefully accurate
            pressure = 0, -- Io doesn't have an atmosphere
            gravity = 1.796502844, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-jupiter",
    },
    {
        type = "planet",
        name = "europa", -- 木卫二
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "jupiter", -- Europa orbits jupiter.
        },
        icon = placeholder_png,
        --icon = "__real-starry-universe__/graphics/europa.png",
        icon_size = 512,
        gravity_pull = 0.134,
        distance = 2, -- 0.67 AU (relative to Jupiter)
        orientation = 180 / 360,
        magnitude = 0.3, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.europa(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Europa (木卫二)
            ["day-night-cycle"] = 0.37 * day, -- 木卫二昼夜周期：约3.5天
            ["magnetic-field"] = 0, -- 木卫二几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.134, -- 重力较低
        },
        prerequisite = "planet-discovery-jupiter",
    },
    {
        type = "planet",
        name = "ganymede", -- 木卫三
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "jupiter", -- Ganymede orbits jupiter.
        },
        icon = placeholder_png,
        --icon = "__real-starry-universe__/graphics/ganymede.png",
        icon_size = 512,
        gravity_pull = 0.146,
        distance = 3, -- 1.07 AU (relative to Jupiter)
        orientation = 180 / 360,
        magnitude = 0.42, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.ganymede(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Ganymede (木卫三)
            ["day-night-cycle"] = 0.37 * day, -- 木卫三昼夜周期：约7.15天
            ["magnetic-field"] = 0, -- 木卫三几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.146, -- 重力较低
        },
        prerequisite = "planet-discovery-jupiter",
    },
    {
        type = "planet",
        name = "callisto", -- Callisto
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "jupiter", -- Callisto orbits jupiter.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 1.235, -- This is in m/s, convert as necessary.
        distance = 4,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.callisto(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Callisto
            ["day-night-cycle"] = 16.7 * day, -- Length of a day on callisto, aproximately 16.7 earth days.
            ["magnetic-field"] = 0, -- Callisto doesn't have a significant magnetic field.
            ["solar-power"] = 3.69396135946, -- Solar power on callisto, similar to that of jupiter - so hopefully accurate
            pressure = 0, -- Callisto doesn't have an atmosphere
            gravity = 1.235, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-jupiter",
    },
    {
        type = "planet",
        name = "saturn", -- 土星
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/saturn.png",
        icon_size = 512,
        gravity_pull = 10.44,
        distance = 143.3 / 3, -- 9.58 AU
        orientation = 280 / 360,
        magnitude = 9.449, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.saturn(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Saturn (土星)
            ["day-night-cycle"] = 0.45 * day, -- 土星昼夜周期：10.7小时
            ["magnetic-field"] = 580, -- 中等磁场
            ["solar-power"] = 1.1, -- 远离太阳，效率极低
            pressure = 100000000, -- 大气压极高（单位：Pa）
            gravity = 10.44, -- 类似木星的重力
        },
        prerequisite = "planet-discovery-jupiter",
    },
    {
        type = "planet",
        name = "mimas", -- Mimas
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Mimas orbits saturn.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.064, -- This is in m/s, convert as necessary.
        distance = 1,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.mimas(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Mimas
            ["day-night-cycle"] = 0.9375 * day, -- Length of a day on mimas, aproximately 0.9375 earth days.
            ["magnetic-field"] = 0, -- Mimas doesn't have a significant magnetic field.
            ["solar-power"] = 1.09561205118, -- Solar power on mimas, similar to that of saturn - so hopefully accurate
            pressure = 0, -- Mimas doesn't have an atmosphere
            gravity = 0.064, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "enceladus", -- 土卫二
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Enceladus orbits saturn.
        },
        icon = placeholder_png,
        --icon = "__real-starry-universe__/graphics/enceladus.png",
        icon_size = 512,
        gravity_pull = 0.011,
        distance = 2, -- 1.51 AU (relative to Saturn)
        orientation = 180 / 360,
        magnitude = 0.2, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.enceladus(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Enceladus (土卫二)
            ["day-night-cycle"] = 0.37  * day, -- 土卫二昼夜周期：约1.4天
            ["magnetic-field"] = 0, -- 土卫二几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.011, -- 重力极低
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "tethys", -- Tethys
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Tethys orbits saturn.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.145, -- This is in m/s, convert as necessary.
        distance = 3,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.tethys(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Tethys
            ["day-night-cycle"] = 1.888 * day, -- Length of a day on tethys, aproximately 1.888 earth days.
            ["magnetic-field"] = 0, -- Tethys doesn't have a significant magnetic field.
            ["solar-power"] = 1.09577261991, -- Solar power on tethys, similar to that of saturn - so hopefully accurate
            pressure = 0, -- Tethys doesn't have an atmosphere
            gravity = 0.145, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "dione", -- Dione
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Dione orbits saturn.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.212, -- This is in m/s, convert as necessary.
        distance = 4,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.dione(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Dione
            ["day-night-cycle"] = 0.212 * day, -- Length of a day on dione, aproximately 0.212 earth days.
            ["magnetic-field"] = 0, -- Dione doesn't have a significant magnetic field.
            ["solar-power"] = 1.09588733347, -- Solar power on dione, similar to that of saturn - so hopefully accurate
            pressure = 0, -- Dione doesn't have an atmosphere
            gravity = 0.212, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "rhea", -- Rhea
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Rhea orbits saturn.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.26, -- This is in m/s, convert as necessary.
        distance = 5,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.rhea(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Rhea
            ["day-night-cycle"] = 4.518212 * day, -- Length of a day on rhea, aproximately 4.518212 earth days.
            ["magnetic-field"] = 0, -- Rhea doesn't have a significant magnetic field.
            ["solar-power"] = 1.09609386328, -- Solar power on rhea, similar to that of saturn - so hopefully accurate
            pressure = 0, -- Rhea doesn't have an atmosphere
            gravity = 0.26, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "titan", -- 土卫六
        icon = placeholder_png,
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Titan orbits saturn.
        },
        --icon = "__real-starry-universe__/graphics/titan.png",
        icon_size = 512,
        gravity_pull = 0.14,
        distance = 6, -- 1.22 AU (relative to Saturn)
        orientation = 180 / 360,
        magnitude = 0.4, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.titan(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
           -- Titan (土卫六)
           ["day-night-cycle"] = 0.37  * day, -- 土卫六昼夜周期：约15.9天
           ["magnetic-field"] = 0, -- 土卫六几乎没有磁场
           ["solar-power"] = 3.7, -- 太阳能效率非常低
           pressure = 146700, -- 大气压极高（单位：Pa）
           gravity = 0.14, -- 重力较低
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "hyperion", -- Hyperion
        icon = placeholder_png,
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Hyperion orbits saturn.
        },
        --icon = "__real-starry-universe__/graphics/hyperion.png",
        icon_size = 512,
        gravity_pull = 0.02, -- This is in m/s, convert as necessary. Average surface gravity across the whole unround moon.
        distance = 7,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.hyperion(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
           -- Hyperion
           ["day-night-cycle"] = 13 * day, -- Length of a day on hyperion, aproximately 13 earth days.
           ["magnetic-field"] = 0, -- Hyperion doesn't have a significant magnetic field.
           ["solar-power"] = 1.1, -- Solar power on hyperion, similar to that of saturn - so hopefully accurate
           pressure = 0, -- Hyperion doesn't have an atmosphere. (How could it, not being gravitationally rounded?)
           gravity = 0.02, -- This is in m/s, convert as necessary. Average surface gravity across the whole unround moon.
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "iapetus", -- Iapetus
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "saturn", -- Iapetus orbits saturn.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.223, -- This is in m/s, convert as necessary.
        distance = 8,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.iapetus(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Iapetus
            ["day-night-cycle"] = 79.3215 * day, -- Length of a day on iapetus, aproximately 79.3215 earth days.
            ["magnetic-field"] = 0, -- Iapetus doesn't have a significant magnetic field.
            ["solar-power"] = 1.10028291447, -- Solar power on iapetus, similar to that of saturn - so hopefully accurate
            pressure = 0, -- Iapetus doesn't have an atmosphere
            gravity = 0.223, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-saturn",
     },
    {
        type = "planet",
        name = "uranus", -- 天王星
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/uranus.png",
        icon_size = 512,
        gravity_pull = 8.87,
        distance = 287.7 / 4.5, -- 19.22 AU
        orientation = 320 / 360,
        magnitude = 4.007, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.uranus(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Uranus (天王星)
            ["day-night-cycle"] = 0.72 * day, -- 天王星昼夜周期：17小时
            ["magnetic-field"] = 50, -- 弱磁场
            ["solar-power"] = 0.3, -- 距太阳非常远
            pressure = 80000000, -- 大气压较高（单位：Pa）
            gravity = 8.69, -- 类似地球的重力
        },
        prerequisite = "planet-discovery-saturn",
    },
    {
        type = "planet",
        name = "ariel", -- Ariel
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "uranus", -- Ariel orbits Uranus.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.246, -- This is in m/s, convert as necessary.
        distance = 1,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.ariel(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Ariel
            ["day-night-cycle"] = 2.52 * day, -- Length of a day on ariel, aproximately 2.52 earth days.
            ["magnetic-field"] = 0, -- Ariel doesn't have a significant magnetic field.
            ["solar-power"] = 0.27155015219, -- Solar power on ariel, similar to that of uranus - so hopefully accurate
            pressure = 0, -- Ariel doesn't have an atmosphere
            gravity = 0.246, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-uranus",
    },
    {
        type = "planet",
        name = "umbriel", -- Umbriel
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "uranus", -- Umbriel orbits Uranus.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.195, -- This is in m/s, convert as necessary.
        distance = 2,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.umbriel(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Umbriel
            ["day-night-cycle"] = 4.1 * day, -- Length of a day on umbriel, aproximately 4.1 earth days.
            ["magnetic-field"] = 0, -- Umbriel doesn't have a significant magnetic field.
            ["solar-power"] = 0.27156430335, -- Solar power on umbriel, similar to that of uranus - so hopefully accurate
            pressure = 0, -- Umbriel doesn't have an atmosphere
            gravity = 0.195, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-uranus",
    },
    {
        type = "planet",
        name = "titania", -- Titania
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "uranus", -- Titania orbits Uranus.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.371, -- This is in m/s, convert as necessary.
        distance = 3,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.titania(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Titania
            ["day-night-cycle"] = 8.7 * day, -- Length of a day on titania, aproximately 8.7 earth days.
            ["magnetic-field"] = 0, -- Titania doesn't have a significant magnetic field.
            ["solar-power"] = 0.27159260899, -- Solar power on titania, similar to that of uranus - so hopefully accurate
            pressure = 0, -- Titania doesn't have an atmosphere
            gravity = 0.371, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-uranus",
    },
    {
        type = "planet",
        name = "oberon", -- Oberon
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "uranus", -- Oberon orbits Uranus.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.358, -- This is in m/s, convert as necessary.
        distance = 4,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.oberon(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Oberon
            ["day-night-cycle"] = 13.46 * day, -- Length of a day on oberon, aproximately 13.46 earth days.
            ["magnetic-field"] = 0, -- Oberon doesn't have a significant magnetic field.
            ["solar-power"] = 0.27161808784, -- Solar power on oberon, similar to that of uranus - so hopefully accurate
            pressure = 0, -- Oberon doesn't have an atmosphere
            gravity = 0.358, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-uranus",
    },
    {
        type = "planet",
        name = "miranda", -- Miranda
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "uranus", -- Miranda orbits Uranus.
        },
        icon = placeholder_png,
        icon_size = 512,
        gravity_pull = 0.076, -- This is in m/s, convert as necessary.
        distance = 5,
        orientation = 180 / 360,
        magnitude = 0.22, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.miranda(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Miranda
            ["day-night-cycle"] = 1.41 * day, -- Length of a day on miranda, aproximately 1.41 earth days.
            ["magnetic-field"] = 0, -- Miranda doesn't have a significant magnetic field.
            ["solar-power"] = 0.27154166202, -- Solar power on miranda, similar to that of uranus - so hopefully accurate
            pressure = 0, -- Miranda doesn't have an atmosphere
            gravity = 0.076, -- This is in m/s, convert as necessary.
        },
        prerequisite = "planet-discovery-uranus",
    },
    {
        type = "planet",
        name = "neptune", -- 海王星
        object_properties = {
            type = "planet", -- This object is a planet.
            parent_object = "sol", -- The object this planet orbits.
        },
        icon = "__real-starry-universe__/graphics/neptune.png",
        icon_size = 512,
        gravity_pull = 11.15,
        distance = 450.3 / 5, -- 30.05 AU
        orientation = 355 / 360,
        magnitude = 3.883, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        map_gen_settings = planet_map_gen.neptune(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Neptune (海王星)
            ["day-night-cycle"] = 0.67 * day, -- 海王星昼夜周期：16小时
            ["magnetic-field"] = 25, -- 与地球相似的磁场
            ["solar-power"] = 0.1, -- 极低的太阳能
            pressure = 90000000, -- 高大气压（单位：Pa）
            gravity = 11.15, -- 稍高于地球的重力
        },
        prerequisite = "planet-discovery-uranus",
    },
    {
        type = "planet",
        name = "triton", -- 海卫一
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "neptune", -- Triton orbits Neptune.
        },
        icon = placeholder_png,
        --icon = "__real-starry-universe__/graphics/triton.png",
        icon_size = 512,
        gravity_pull = 0.079,
        distance = 1, -- 3.54 AU (relative to Neptune)
        orientation = 180 / 360,
        magnitude = 0.24, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.triton(),
        surface_properties = {
            -- Triton (海卫一)
            ["day-night-cycle"] = 0.37  * day, -- 海卫一昼夜周期：约14.1小时
            ["magnetic-field"] = 0, -- 海卫一几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 1400, -- 大气压较低（单位：Pa）
            gravity = 0.079, -- 重力极低
        },
        prerequisite = "planet-discovery-neptune",
    },
    {
        type = "planet",
        name = "pluto", -- Pluto (冥王星)
        object_properties = {
            type = "dwarf-planet", -- This object is a dwarf planet.
            parent_object = "sol", -- The object this dwarf planet orbits.
        },
        icon = "__real-starry-universe__/graphics/pluto.png",
        icon_size = 512,
        gravity_pull = 0.62,
        distance = 120, -- 39.52 AU
        orientation = 290 / 360,
        magnitude = 0.3,
        map_gen_settings = planet_map_gen.pluto(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Pluto (冥王星)
            ["day-night-cycle"] = 6.39 * day, -- 冥王星昼夜周期：6.39个地球日
            ["magnetic-field"] = 0, -- 无磁场
            ["solar-power"] = 0.05, -- 几乎没有太阳能
            pressure = 0.1, -- 极其稀薄的大气压
            gravity = 0.62, -- 极低重力
        },
        prerequisite = "planet-discovery-neptune",
    },
    {
        type = "planet",
        name = "charon", -- 冥卫一
        object_properties = {
            type = "moon", -- This object is a moon.
            parent_object = "pluto", -- The object this moon orbits.
        },
        icon = placeholder_png,
        --icon = "__real-starry-universe__/graphics/charon.png",
        icon_size = 512,
        gravity_pull = 0.028,
        distance = 1, -- 39.5 AU (relative to Pluto)
        orientation = 180 / 360,
        magnitude = 0.15, -- The sizes of planets shown on star maps. 1 is the size of Earth (12,742km).  11.2 is the size of Jupiter (139,820).
        draw_orbit = false, -- It does not draw the orbit around the Sun if false.
        map_gen_settings = planet_map_gen.charon(),
        surface_properties = {
            -- Charon (冥卫一)
            ["day-night-cycle"] = 0.37 * day, -- 冥卫一昼夜周期：约153小时
            ["magnetic-field"] = 0, -- 冥卫一几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.028, -- 重力极低
        },
        prerequisite = "planet-discovery-pluto",
    },
    {
        type = "space-location", -- You should be able to land on asteroids in the asteroid belt. but must land on one of it like pluto.
        name = "asteroid-belt-outer",
        object_properties = {
            type = "asteroid-belt", -- This object is an asteroid belt.
            parent_object = "sol", -- The object this asteroid belt orbits.
        },
        icon = "__real-starry-universe__/graphics/asteroid-belt-outer.png",
        icon_size = 512,
        gravity_pull = 0.01, -- Aproximate surface gravity for asteroids in the outer asteroid belt (also known as kuiper belt)
        distance = 120, -- 40 AU (centre of the outer asteroid belt)
        orientation = 359 / 360,
        magnitude = 0.4,
        map_gen_settings = planet_map_gen.asteroid_belt_1(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Outer Asteroid Belt (Between Neptune and Solar System Edge)
            ["day-night-cycle"] = 0.28 * day, -- Aproximate day-night cycle for asteroids in the outer asteroid belt (also known as kuiper belt)
            ["magnetic-field"] = 0, -- Asteroids tend to have a very, very weak magnetic field. This is aproximated by 0 here.
            ["solar-power"] = 0.86, -- Percentage of solar power compared to that on earth? Seems to fit with the data of pluto, being around the same.
            pressure = 0, -- The pressure in the inner asteroid belt is 0, as there is no atmosphere to sustain (air) pressure, and no large enough objects to sustain an atmosphere.
            gravity = 0.01, -- Aproximate surface gravity for asteroids in the outer asteroid belt (also known as kuiper belt)
        },
        prerequisite = "planet-discovery-neptune",
    },
    {
        type = "planet",
        name = "makemake", -- 鸟神星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "outer-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/makemake.png",
        icon_size = 1024,
        gravity_pull = 0.05,
        distance = 120, -- 45.79 AU
        orientation = 220 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.makemake(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Makemake (鸟神星)
            ["day-night-cycle"] = 0.37 * day, -- 鸟神星昼夜周期：约22.5小时
            ["magnetic-field"] = 0, -- 鸟神星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.05, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-outer",
    },
    {
        type = "planet",
        name = "haumea", -- 妊神星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "outer-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/haumea.png",
        icon_size = 1024,
        gravity_pull = 0.04,
        distance = 120, -- 43.34 AU
        orientation = 150 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.haumea(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Haumea (妊神星)
            ["day-night-cycle"] = 0.37 * day, -- 妊神星昼夜周期：约3.9小时
            ["magnetic-field"] = 0, -- 妊神星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.04, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-outer",
    },
    {
        type = "planet",
        name = "eris", -- 阋神星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "outer-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/eris.png",
        icon_size = 1024,
        gravity_pull = 0.08,
        distance = 120, -- 67.78 AU
        orientation = 80 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.eris(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Eris (阋神星)
            ["day-night-cycle"] = 0.37 * day, -- 阋神星昼夜周期：约15.8小时
            ["magnetic-field"] = 0, -- 阋神星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.08, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-outer",
    },
    {
        type = "planet",
        name = "gonggong", -- 共工星
        object_properties = {
            type = "asteroid", -- This object is an asteroid.
            parent_object = "sol", -- The object this asteroid orbits.
            belt = "outer-asteroid-belt", -- The asteroid belt this asteroid is in.
        },
        icon = "__real-starry-universe__/graphics/gonggong.png",
        icon_size = 1024,
        gravity_pull = 0.06,
        distance = 120, -- 67.5 AU
        orientation = 10 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.gonggong(),
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
        surface_properties = {
            -- Gonggong (共工星)
            ["day-night-cycle"] = 0.37 * day, -- 共工星昼夜周期：约25小时
            ["magnetic-field"] = 0, -- 共工星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.06, -- 重力极低
        },
        prerequisite = "planet-discovery-asteroid-belt-outer",
    },

}

for i, Planet in pairs(planets) do
    if Planet.object_properties then
        local properties = Planet.object_properties
        if properties.type == "planet" or properties.type == "dwarf-planet" then
            local CurvingFactor = 10 / 360
            local Moons = {}
            for j, Object in pairs(planets) do
                if Object.object_properties.type == "moon" and Object.object_properties.parent_object == Planet.name then
                    table.insert(Moons, j, Object)
                end
            end
    
            for j, Moon in pairs(Moons) do
                Moon.orientation = Moon.orientation + ( CurvingFactor * ( Moon.distance - 1 ) )
                if Moon.orientation > 1 then
                    Moon.orientation = Moon.orientation % 1 -- Label orientation cannot be greater than 1.
                end
            end
        elseif properties.type == "moon" then
        end
        
        if not Planet.label_orientation then
            Planet.label_orientation = ( 270 / 360 + Planet.orientation )
            if Planet.label_orientation > 1 then
                Planet.label_orientation = Planet.label_orientation % 1 -- Label orientation cannot be greater than 1.
            end
        end

        local ParentObject = nil
        
        if Planet.object_properties.parent_object ~= nil then
            for _,Object in pairs(planets) do
                if Planet.object_properties.parent_object == Object.name then
                    ParentObject = Object
                    break
                end
            end
        end
        if ParentObject ~= nil then
            rotation_util.Unrelate(Planet, ParentObject)
        elseif Planet.distance ~= 0 then
            log("ParentObject of object \"" .. Planet.name .. "\" is nil! Intended parent object was \"" .. Planet.object_properties.parent_object .. "\". Is this correct?")
        end

        if ParentObject and ParentObject.distance ~= 0 and not Planet.draw_orbit then
            Planet.draw_orbit = false
        end

    end

    if not Planet.orientation then
        --need parent's orientation -- Not nessecary, this is already relative to the parent object (if any) and even then, only a default.
        log("Planet \"" .. Planet.name .. "\" has no orientation property! It's been replaced with 270 / 360.")
        Planet.orientation = 270 / 360
    end

    -- Check if the planet has an icon but does not have a starmap_icon
    if Planet.icon and not Planet.starmap_icon then
        -- Set the starmap_icon to be the same as the planet's icon
        Planet.starmap_icon = Planet.icon
        -- Set the starmap_icon_size to be the same as the planet's icon_size
        Planet.starmap_icon_size = Planet.icon_size
    end

    if not Planet.subgroup then
        Planet.subgroup = "planets"
    end

    -- Solar power in space is based purely on distance and the units in which we measure it.
    if not Planet.solar_power_in_space then
        local distance = Planet.distance -- Distance in map coordinates between the sun and the planet.
        local distance_au = distance / 15 -- Distance in AU between the sun and the planet.

        if distance_au == 0 then -- Check if the distance is equal to 0 and apply a small change so that the solar power is not infinity.
            distance_au = 0.04623
        end

        local solar_power_on_earth = 1380 -- Solar power as measured in orbit around earth (watts per meter squared)

        local solar_power_in_space_unscaled = solar_power_on_earth / (distance_au * distance_au) -- Solar power as measured in orbit around the planet (watts per meter squared)
        local solar_power_in_space = ( solar_power_in_space_unscaled / solar_power_on_earth ) * 100 -- Solar power as measured in orbit around the planet (percentage of that on earth)
        Planet.solar_power_in_space = solar_power_in_space -- Set planet property to the local variable.
    end

    Planet.mod = "rsu"

end

data:extend(planets)

--https://lua-api.factorio.com/latest/prototypes/SpaceConnectionPrototype.html
local space_connections = {
    {
        type = "space-connection",
        name = "sol-mercury", -- The sun to mercury.
        subgroup = "planet-connections",
        from = "sol",
        to = "mercury",
        order = "0[sol]-a[mercury]",
        length = 510100, -- A safe distance from the sun subtracted from the orbital distance of mercury in units of 100 kilometers.
        space_effects = {
            background_color = { r = 0.2, g = 0.1, b = 0.3 },
            particle_color = { r = 0.6, g = 0.4, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "mercury-venus", -- 水星到金星
        subgroup = "planet-connections",
        from = "mercury",
        to = "venus",
        order = "a[mercury]-b[venus]",
        length = 869585.66, -- Average distance between mercury and venus in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.2, g = 0.1, b = 0.3 },
            particle_color = { r = 0.6, g = 0.4, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "venus-earth", -- 金星到地球
        subgroup = "planet-connections",
        from = "venus",
        to = "earth",
        order = "b[venus]-c[earth]",
        length = 1305758.64, -- Average distance between venus and earth in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.medium_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.2, b = 0.4 },
            particle_color = { r = 0.4, g = 0.7, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "nauvis-earth", -- nauvis到地球
        subgroup = "planet-connections",
        from = "nauvis",
        to = "earth",
        order = "b[venus]-c[earth]",
        length = 5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.medium_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.2, b = 0.4 },
            particle_color = { r = 0.4, g = 0.7, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "earth-luna",
        subgroup = "planet-connections",
        from = "earth",
        to = "luna",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "z[a]",
        length = 3843.99, -- Average distance between earth and luna in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.8, g = 0.8, b = 0.9 },
            particle_color = { r = 0.9, g = 0.9, b = 1.0 }
        }
    },
    {
        type = "space-connection",
        name = "earth-mars", -- 地球到火星
        subgroup = "planet-connections",
        from = "earth",
        to = "mars",
        order = "c[earth]-d[mars]",
        length = 1928802.33, -- Average distance between earth and mars in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.large_asteroids),
        space_effects = {
            background_color = { r = 0.1, g = 0.3, b = 0.2 },
            particle_color = { r = 0.5, g = 0.2, b = 0.4 }
        }
    },
    {
        type = "space-connection",
        name = "mars-phobos", -- Mars to Phobos
        subgroup = "planet-connections",
        from = "mars",
        to = "phobos",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "d[mars]-e[phobos]",
        length = 93.76, -- Average distance between mars and phobos in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.belt_asteroids),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.1 },
            particle_color = { r = 0.6, g = 0.5, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "phobos-deimos", -- Phobos to Deimos
        subgroup = "planet-connections",
        from = "phobos",
        to = "deimos",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "e[phobos]-f[deimos]",
        length = 180.06, -- Average distance between phobos and deimos in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.belt_asteroids),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.1 },
            particle_color = { r = 0.6, g = 0.5, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "mars-asteroid-belt-inner", -- Mars to the inner asteroid belt
        subgroup = "planet-connections",
        from = "mars",
        to = "asteroid-belt-inner",
        order = "d[mars]-e[asteroid-belt-inner]",
        length = 3283879.68, -- Average distance between mars and the center of the inner asteroid belt in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.belt_asteroids),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.1 },
            particle_color = { r = 0.6, g = 0.5, b = 0.2 }
        }
    },

    {
        type = "space-connection",
        name = "asteroid-belt-inner-ceres", -- 小行星带内侧到谷神星
        subgroup = "planet-connections",
        from = "asteroid-belt-inner",
        to = "ceres",
        order = "d[asteroid-belt-inner]-e[ceres]",
        length = 3.0, -- 小行星带内侧到谷神星的距离，比例单位
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.1, g = 0.1, b = 0.2 },
            particle_color = { r = 0.8, g = 0.6, b = 0.4 }
        }
    },

    {
        type = "space-connection",
        name = "ceres-vesta", -- 谷神星到灶神星
        subgroup = "planet-connections",
        from = "ceres",
        to = "vesta",
        order = "e[ceres]-f[vesta]",
        length = 2.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.1, g = 0.2, b = 0.3 },
            particle_color = { r = 0.7, g = 0.8, b = 0.5 }
        }
    },

    {
        type = "space-connection",
        name = "vesta-pallas", -- 灶神星到智神星
        subgroup = "planet-connections",
        from = "vesta",
        to = "pallas",
        order = "f[vesta]-g[pallas]",
        length = 2.8,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.2, g = 0.2, b = 0.3 },
            particle_color = { r = 0.6, g = 0.7, b = 0.6 }
        }
    },

    {
        type = "space-connection",
        name = "pallas-hygiea", -- 智神星到健神星
        subgroup = "planet-connections",
        from = "pallas",
        to = "hygiea",
        order = "g[pallas]-h[hygiea]",
        length = 3.2,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.2, g = 0.3, b = 0.4 },
            particle_color = { r = 0.5, g = 0.6, b = 0.7 }
        }
    },

    {
        type = "space-connection",
        name = "asteroid-belt-inner-jupiter", -- The inner asteroid belt to jupiter.
        subgroup = "planet-connections",
        from = "asteroid-belt-inner",
        to = "jupiter",
        order = "e[asteroid-belt-inner]-f[jupiter]",
        length = 6216252.06, -- Average distance between the center of the inner asteroid belt and jupiter in units of 100 kilometers.
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.belt_asteroids),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.1 },
            particle_color = { r = 0.6, g = 0.5, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "jupiter-io", -- Jupiter to Io.
        subgroup = "planet-connections",
        from = "jupiter",
        to = "io",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "f[jupiter]-g[io]",
        length = 4218,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.4, b = 0.3 },
            particle_color = { r = 0.5, g = 0.2, b = 0.7 }
        }
     },
     {
        type = "space-connection",
        name = "io-europa", -- Io to Europa.
        subgroup = "planet-connections",
        from = "io",
        to = "europa",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "p[io]-q[europa]",
        length = 2493,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.3, g = 0.2, b = 0.5 },
            particle_color = { r = 0.6, g = 0.5, b = 0.4 }
        }
    },
    {
        type = "space-connection",
        name = "europa-ganymede", -- Europa to Ganymede
        subgroup = "planet-connections",
        from = "europa",
        to = "ganymede",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "p[europa]-s[ganymede]",
        length = 3993,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.5, g = 0.4, b = 0.7 },
            particle_color = { r = 0.4, g = 0.3, b = 0.6 }
        }
     },
     {
        type = "space-connection",
        name = "ganymede-callisto", -- Ganymede to Callisto.
        subgroup = "planet-connections",
        from = "ganymede",
        to = "callisto",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "f[ganymede]-g[callisto]",
        length = 8123,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.4, b = 0.3 },
            particle_color = { r = 0.5, g = 0.2, b = 0.7 }
        }
    },
    {
        type = "space-connection",
        name = "jupiter-saturn", -- 木星到土星
        subgroup = "planet-connections",
        from = "jupiter",
        to = "saturn",
        order = "f[jupiter]-g[saturn]",
        length = 6510700,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.4, b = 0.3 },
            particle_color = { r = 0.5, g = 0.2, b = 0.7 }
        }
    },
    {
        type = "space-connection",
        name = "saturn-mimas", -- Saturn to Mimas.
        subgroup = "planet-connections",
        from = "saturn",
        to = "mimas",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "g[saturn]-h[mimas]",
        length = 1855.4,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
        }
    },
    {
        type = "space-connection",
        name = "mimas-enceladus", -- Mimas to Enceladus
        subgroup = "planet-connections",
        from = "mimas",
        to = "enceladus",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "n[mimas]-o[enceladus]",
        length = 525,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.2, g = 0.2, b = 0.4 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "enceladus-tethys", -- Enceladus to Tethys.
        subgroup = "planet-connections",
        from = "enceladus",
        to = "tethys",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "g[enceladus]-h[tethys]",
        length = 566.3,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "tethys-dione", -- Tethys to Dione.
        subgroup = "planet-connections",
        from = "tethys",
        to = "dione",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "g[tethys]-h[dione]",
        length = 827.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "dione-rhea", -- Dione to Rhea.
        subgroup = "planet-connections",
        from = "dione",
        to = "rhea",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "g[dione]-h[rhea]",
        length = 1496.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "rhea-titan", -- Rhea to Titan.
        subgroup = "planet-connections",
        from = "rhea",
        to = "titan",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "g[rhea]-h[titan]",
        length = 6948,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "titan-hyperion", -- Titan to Hyperion.
        subgroup = "planet-connections",
        from = "titan",
        to = "hyperion",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "n[titan]-r[hyperion]",
        length = 2790.1,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.6 },
            particle_color = { r = 0.5, g = 0.4, b = 0.5 }
        }
    },
    {
        type = "space-connection",
        name = "hyperion-iapetus", -- Hyperion to Iapetus.
        subgroup = "planet-connections",
        from = "hyperion",
        to = "iapetus",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "n[hyperion]-r[iapetus]",
        length = 20599.60,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.6 },
            particle_color = { r = 0.5, g = 0.4, b = 0.5 }
        }
    },
    {
        type = "space-connection",
        name = "saturn-uranus", -- 土星到天王星
        subgroup = "planet-connections",
        from = "saturn",
        to = "uranus",
        order = "g[saturn]-h[uranus]",
        length = 14415900,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "uranus-ariel", -- Uranus to Ariel.
        subgroup = "planet-connections",
        from = "uranus",
        to = "ariel",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "h[uranus]-i[ariel]",
        length = 1909,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "ariel-umbriel", -- Ariel to Umbriel.
        subgroup = "planet-connections",
        from = "ariel",
        to = "umbriel",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "h[ariel]-i[umbriel]",
        length = 751,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "umbriel-titania", -- Umbriel to Titania.
        subgroup = "planet-connections",
        from = "umbriel",
        to = "titania",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "h[umbriel]-i[titania]",
        length = 1703,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "titania-oberon", -- Titania to Oberon.
        subgroup = "planet-connections",
        from = "titania",
        to = "oberon",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "h[titania]-i[oberon]",
        length = 1472,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "oberon-miranda", -- Oberon to Miranda.
        subgroup = "planet-connections",
        from = "oberon",
        to = "miranda",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "h[oberon]-i[miranda]",
        length = 4536,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.3, g = 0.5, b = 0.2 },
            particle_color = { r = 0.7, g = 0.6, b = 0.3 }
        }
    },
    {
        type = "space-connection",
        name = "uranus-neptune", -- 天王星到海王星
        subgroup = "planet-connections",
        from = "uranus",
        to = "neptune",
        order = "h[uranus]-i[neptune]",
        length = 16333100,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.3, b = 0.5 },
            particle_color = { r = 0.3, g = 0.5, b = 0.7 }
        }
    },
    {
        type = "space-connection",
        name = "neptune-triton", -- 海王星到海卫一
        subgroup = "planet-connections",
        from = "neptune",
        to = "triton",
        moon = true, -- The lengths of connections involving moons should not be scaled down as much.
        order = "t[neptune]-u[triton]",
        length = 3548,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.6, g = 0.5, b = 0.8 },
            particle_color = { r = 0.3, g = 0.2, b = 0.7 }
        }
    },
    {
        type = "space-connection",
        name = "neptune-asteroid-belt-outer",
        subgroup = "planet-connections",
        from = "neptune",
        to = "asteroid-belt-outer",
        order = "i[neptune]-j[asteroid-belt-outer]",
        length = 300,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.7, g = 0.4, b = 0.9 },
            particle_color = { r = 0.5, g = 0.6, b = 0.8 }
        }
    },
    {
        type = "space-connection",
        name = "asteroid-belt-outer-pluto",
        subgroup = "planet-connections",
        from = "asteroid-belt-outer",
        to = "pluto",
        order = "j[asteroid-belt-outer]-k[pluto]",
        length = 300,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        space_effects = {
            background_color = { r = 0.7, g = 0.4, b = 0.9 },
            particle_color = { r = 0.5, g = 0.6, b = 0.8 }
        }
    },

    {
        type = "space-connection",
        name = "makemake-pluto", -- 鸟神星到冥王星
        subgroup = "planet-connections",
        from = "makemake",
        to = "pluto",
        order = "i[makemake]-j[pluto]",
        length = 4.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.1, g = 0.1, b = 0.3 },
            particle_color = { r = 0.8, g = 0.6, b = 0.2 }
        }
    },

    {
        type = "space-connection",
        name = "haumea-pluto", -- 妊神星到冥王星
        subgroup = "planet-connections",
        from = "haumea",
        to = "pluto",
        order = "k[haumea]-j[pluto]",
        length = 4.2,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.2, g = 0.1, b = 0.4 },
            particle_color = { r = 0.7, g = 0.5, b = 0.3 }
        }
    },

    {
        type = "space-connection",
        name = "eris-pluto", -- 阋神星到冥王星
        subgroup = "planet-connections",
        from = "eris",
        to = "pluto",
        order = "l[eris]-j[pluto]",
        length = 5.0,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.3, g = 0.1, b = 0.5 },
            particle_color = { r = 0.6, g = 0.4, b = 0.4 }
        }
    },

    {
        type = "space-connection",
        name = "gonggong-eris", -- 共工星到阋神星
        subgroup = "planet-connections",
        from = "gonggong",
        to = "eris",
        order = "m[gonggong]-l[eris]",
        length = 3.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.2, g = 0.2, b = 0.5 },
            particle_color = { r = 0.7, g = 0.6, b = 0.4 }
        }
    },
    {
        type = "space-connection",
        name = "pluto-charon", -- 冥王星到冥卫一
        subgroup = "planet-connections",
        from = "pluto",
        to = "charon",
        order = "j[pluto]-v[charon]",
        length = 1.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.7, g = 0.6, b = 0.9 },
            particle_color = { r = 0.2, g = 0.1, b = 0.8 }
        }
    },
    {
        type = "space-connection",
        name = "gonggong-pluto", -- 共工星到冥王星
        subgroup = "planet-connections",
        from = "gonggong",
        to = "pluto",
        order = "m[gonggong]-j[pluto]",
        length = 5.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        space_effects = {
            background_color = { r = 0.3, g = 0.2, b = 0.6 },
            particle_color = { r = 0.6, g = 0.5, b = 0.5 }
        }
    },
}

local MoonScaleFactor = 100 -- Scale each moon space connection down by this factor.
local ScaleFactor = 10000 -- Scale each non-moon space connection down by this factor.

for i, SpaceConnection in pairs(space_connections) do
    SpaceConnection.length = SpaceConnection.length * 100 -- Multiply each space connection length by 100 as the lengths in each space connection as defined above are in kilometers times 100.

    if SpaceConnection.moon then
        SpaceConnection.length = SpaceConnection.length / MoonScaleFactor -- Divide each length by the Moon Scale Factor.
    else
        SpaceConnection.length = SpaceConnection.length / ScaleFactor -- Divide each length by the Scale Factor.
    end

    if math.ceil(SpaceConnection.length) ~= SpaceConnection.length then
        SpaceConnection.length = math.ceil(SpaceConnection.length) -- Round up to the nearest integer.
    end

    if SpaceConnection.length < 100 then
        SpaceConnection.length = 100 -- Set the length to 100 if the length is less than 100. In my testing, anything less than 100 breaks at speeds reached in the base game.
    end

    if SpaceConnection.icons == nil and SpaceConnection.icon == nil then

        -- Try to reconstruct the icons for space connections. Example:
        -- icons = {
        --     {
        --       icon = "__space-age__/graphics/icons/planet-route.png"
        --     },
        --     {
        --       icon = "__space-age__/graphics/icons/aquilo.png",
        --       icon_size = 64,
        --       scale = 0.33300000000000001,
        --       shift = {
        --         -6,
        --         -6
        --       }
        --     },
        --     {
        --       icon = "__space-age__/graphics/icons/solar-system-edge.png",
        --       icon_size = 64,
        --       scale = 0.33300000000000001,
        --       shift = {
        --         6,
        --         6
        --       }
        --     }
        --   },

        SpaceConnection.icons = {
            {
                icon = "__space-age__/graphics/icons/planet-route.png"
            }
        }
        local From = {}
        local To = {}
        for _,Planet in pairs(planets) do
            if Planet.name == SpaceConnection.from then
                From = Planet
            end
            if Planet.name == SpaceConnection.to then
                To = Planet
            end
        end

        if From.icon ~= nil then
            local IconSize = From.icon_size or 64
            table.insert(SpaceConnection.icons, {
                icon = From.icon,
                icon_size = IconSize,
                scale = 1 / ( IconSize / (64 * 0.33300000000000001) ),
                shift = {
                    -6,
                    -6
                }
            })
        end
        if To.icon ~= nil then
            local IconSize = To.icon_size or 64
            table.insert(SpaceConnection.icons, {
                icon = To.icon,
                icon_size = IconSize,
                scale = 1 / ( IconSize / (64 * 0.33300000000000001) ),
                shift = {
                    6,
                    6
                }
            })
        end
    end

    space_connections[i] = SpaceConnection -- Set the new space connection to the modified one.
end

data:extend(space_connections)

-- 定义灵石矿种类
local kuang = {
    { "iron-ore" },
    { "copper-ore" },
    { "stone" },
    { "coal" },
    { "uranium-ore" },
    { "crude-oil" }
}


-- 循环为每个星球添加自动放置控制和设置
for _, planet in ipairs(planets) do
    local planet_name = planet[1]
    -- 为每个星球添加自动放置控制


    if data.raw.planet[planet_name] then


        for _, item in ipairs(kuang) do
            local autoplace_control_name = item[1]
            -- 为每个星球添加自动放置控制
            data.raw.planet[planet_name].map_gen_settings.autoplace_controls[autoplace_control_name] = {
                order = "a[" .. autoplace_control_name .. "]",
                frequency = 1,
                size = 1,
                richness = 1,
                distribution = "uniform",
                starting_area_size = 1,
                starting_area_order = "a[ore]",
                has_starting_area = false
            }
            -- 为每个星球添加自动放置设置
            data.raw.planet[planet_name].map_gen_settings.autoplace_settings.entity.settings[autoplace_control_name] = {
                name = autoplace_control_name,
                minimum_required = 0,
                maximum = 10
            }
        end
    end
end
