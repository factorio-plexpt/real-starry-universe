local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions") -- The original asteroid spawn definitions from Space Age. Should be replaced as soon as possible to allow custom spawn definitions.
-- local asteroid_util = require("asteroid_definitions.asteroid_util") -- New asteroid spawn definitions for when there's new definitions. It isn't ready yet.
local planet_catalogue_gleba = require("__space-age__.prototypes.planet.procession-catalogue-gleba")

local planet_map_gen = require("data.planet-map-gen")
local day = 24 * hour

local planets = {
    {
        type = "planet",
        name = "mercury", -- 水星
        icon = "__real-starry-universe__/graphics/mercury.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/mercury.png",
        starmap_icon_size = 512,
        gravity_pull = 3.7, -- 水星表面重力 (相对值)
        distance = 5.8, -- 距离星系中心 以15为一个AU，约 0.39 AU
        orientation = 40 / 360, -- 与星系中心角度
        magnitude = 0.383, -- Mercury (水星)
        map_gen_settings = planet_map_gen.mercury(),
        surface_properties = {
            -- Mercury (水星)
            ["day-night-cycle"] = 58.7 * day, -- 水星昼夜周期：58.7个地球日
            ["magnetic-field"] = 1, -- 极弱的磁场
            ["solar-power"] = 500, -- 接收太阳能最多
            pressure = 0, -- 无明显大气压
            gravity = 3.7, -- 重力较小
        },
    },
    {
        type = "planet",
        name = "venus", -- 金星
        icon = "__real-starry-universe__/graphics/venus.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/venus.png",
        starmap_icon_size = 512,
        gravity_pull = 8.87,
        distance = 10.8, -- 0.72 AU
        orientation = 80 / 360,
        magnitude = 0.949, -- Venus (金星)
        map_gen_settings = planet_map_gen.venus(),
        surface_properties = {
            -- Venus (金星)
            ["day-night-cycle"] = 243 * day, -- 金星昼夜周期：243个地球日
            ["magnetic-field"] = 1, -- 几乎无磁场
            ["solar-power"] = 90, -- 高温和厚大气层影响太阳能
            pressure = 920000, -- 极高的大气压（单位：Pa）
            gravity = 8.87, -- 类似于地球的重力
        },
    },
    {
        type = "planet",
        name = "earth", -- 地球
        icon = "__real-starry-universe__/graphics/earth.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/earth.png",
        starmap_icon_size = 512,
        gravity_pull = 9.8,
        distance = 15, -- 1 AU
        orientation = 120 / 360,
        magnitude = 1,
        map_gen_settings = planet_map_gen.normal(),
        surface_properties = {
            -- Earth (地球)
            ["day-night-cycle"] = 1 * day, -- 地球昼夜周期：1个地球日
            ["magnetic-field"] = 100, -- 强磁场保护
            ["solar-power"] = 100, -- 标准太阳能基准
            pressure = 1000, -- 1个大气压
            gravity = 9.8, -- 地球重力
        },
    },
    {
        type = "planet",
        name = "luna",
        icon = "__real-starry-universe__/graphics/luna.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/luna.png",
        starmap_icon_size = 512,
        gravity_pull = 1.62, -- 月球的重力
        distance = 15.5, -- 距离地球非常近
        orientation = 0.33, -- 地球轨道附近
        magnitude = 0.273, -- Luna (月球)
        map_gen_settings = planet_map_gen.luna(), -- 使用月球专属生成方法
        surface_properties = {
            -- Luna (月球)
            ["day-night-cycle"] = 30 * day, -- 月球昼夜周期：27.3个地球日
            ["magnetic-field"] = 1, -- 极弱磁场
            ["solar-power"] = 136, -- 太阳能较高
            pressure = 0, -- 无大气
            gravity = 1.62, -- 重力远小于地球
        },
    },
    {
        type = "planet",
        name = "mars", 
        icon = "__real-starry-universe__/graphics/mars.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/mars.png",
        starmap_icon_size = 512,
        gravity_pull = 3.71,
        distance = 22.8, -- 1.52 AU
        orientation = 160 / 360,
        magnitude = 0.532, -- Mars (火星)
        map_gen_settings = planet_map_gen.mars(),
        surface_properties = {
            -- Mars (火星)
            ["day-night-cycle"] = 1.03 * day, -- 火星昼夜周期：接近地球
            ["magnetic-field"] = 1, -- 几乎无磁场
            ["solar-power"] = 43, -- 较远离太阳，太阳能效率低
            pressure = 6, -- 极低的大气压（单位：Pa）
            gravity = 3.71, -- 重力较低
        },
    },
    {
        type = "planet",
        name = "phobos", -- Phobos, the first moon of mars.
        icon = "__real-starry-universe__/graphics/blank.png",
        icon_size = 32,
        starmap_icon = "__real-starry-universe__/graphics/blank.png",
        starmap_icon_size = 32,
        gravity_pull = 0.0057, -- This is in m/s, convert as necessary.
        distance = 22.8009401205, -- 0.0000626747 AU, or 9376 km from mars, added to the distance of mars from the sun.
        orientation = 160 / 360, -- The orientation of mars, may need to be changed.
        magnitude = 0.22, -- Not sure what magnitude, so just that of ceres for now.
        map_gen_settings = planet_map_gen.phobos(),
        surface_properties = {
            -- Phobos
            ["day-night-cycle"] = 0.318912037 * day, -- Day night cycle of phobos.
            ["magnetic-field"] = 0, -- Phobos has no significant magnetic field.
            ["solar-power"] = 43.073785011, -- Aproximate solar power recieved on phobos. Consistent with the solar power recieved on mars, so likely correct(ish).
            pressure = 0, -- Phobos is an asteroid-like moon and has no atmosphere.
            gravity = 0.0057, -- This is in m/s, convert as necessary.
        },
    },
    {
        type = "planet",
        name = "deimos", -- Deimos, the second moon of mars.
        icon = "__real-starry-universe__/graphics/blank.png",
        icon_size = 32,
        starmap_icon = "__real-starry-universe__/graphics/blank.png",
        starmap_icon_size = 32,
        gravity_pull = 0.003, -- This is in m/s, convert as necessary.
        distance = 22.8023526271, -- 0.0001568418046 AU, or 23463.2 km from mars, added to the distance of mars from the sun.
        orientation = 160 / 360, -- The orientation of mars, may need to be changed.
        magnitude = 0.22, -- Not sure what magnitude, so just that of ceres for now.
        map_gen_settings = planet_map_gen.deimos(),
        surface_properties = {
            -- Deimos
            ["day-night-cycle"] = 0.3125 * day, -- Day night cycle of deimos.
            ["magnetic-field"] = 0, -- Deimos has no significant magnetic field.
            ["solar-power"] = 43.046800236, -- Aproximate solar power recieved on deimos. Consistent with the solar power recieved on mars, so likely correct(ish).
            pressure = 0, -- Deimos is an asteroid-like moon and has no atmosphere.
            gravity = 0.003, -- This is in m/s, convert as necessary.
        },
    }
    {
        type = "space-location", -- You should be able to land on asteroids in the asteroid belt. but must go to ceres
        name = "asteroid-belt-inner",
        -- icon = "__real-starry-universe__/graphics/asteroid-belt-inner.png", -- Currently, there is no image for asteroid-belt-inner.
        icon = "__real-starry-universe__/graphics/jupiter.png", -- As there is no special image yet, the inner asteroid belt is going to use the jupiter icon.
        icon_size = 512,
        -- starmap_icon = "__real-starry-universe__/graphics/asteroid-belt-inner.png", -- Again, there is no image for asteroid-belt-inner.
        starmap_icon = "__real-starry-universe__/graphics/jupiter.png", -- Again, as there is no special image yet, the inner asteroid belt is going to use the jupiter icon.
        starmap_icon_size = 512,
        gravity_pull = 0.0000137200167, -- Aproximate surface gravity for a specific asteroid (which will right now represnent all asteroids)

        distance = 27, -- 2.7 AU (centre of the inner asteroid belt)
        orientation = 185 / 360,
        magnitude = 1,
        map_gen_settings = planet_map_gen.asteroid_belt_1(),
        surface_properties = {
            -- Inner Asteroid Belt (Between Mars and Jupiter)
            ["day-night-cycle"] = 0.37681889586 * day, -- Aproximate day-night cycle for a specific asteroid (which will right now represnent all asteroids)
            ["magnetic-field"] = 0, -- Asteroids tend to have a very, very weak magnetic field. This is aproximated by 0 here.
            ["solar-power"] = 13.717, -- Percentage of solar power compared to that on earth? Seems to fit with the data of jupiter and mars, being about in between.
            pressure = 0, -- The pressure in the inner asteroid belt is 0, as there is no atmosphere to sustain (air) pressure, and no large enough objects to sustain an atmosphere.
            gravity = 0.0000137200167, -- Aproximate surface gravity for a specific asteroid (which will right now represnent all asteroids)
        },
    },
    {
        type = "planet",
        name = "ceres", -- 谷神星
        icon = "__real-starry-universe__/graphics/ceres.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/ceres.png",
        starmap_icon_size = 512,
        gravity_pull = 0.028,
        distance = 27, -- 2.77 AU
        orientation = 200 / 360,
        magnitude = 0.22, -- Ceres (谷神星)
        map_gen_settings = planet_map_gen.ceres(),
        surface_properties = {
            -- Ceres (谷神星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 谷神星昼夜周期：约9小时
            ["magnetic-field"] = 0, -- 谷神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.028, -- 重力极低
        },
    },

    {
        type = "planet",
        name = "vesta", -- 灶神星
        icon = "__real-starry-universe__/graphics/vesta.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/vesta.png",
        starmap_icon_size = 512,
        gravity_pull = 0.025,
        distance = 27, -- 2.36 AU
        orientation = 260 / 360,
        magnitude = 0.2, -- Vesta (灶神星)
        map_gen_settings = planet_map_gen.vesta(),
        surface_properties = {
            -- Vesta (灶神星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 灶神星昼夜周期：约5.3小时
            ["magnetic-field"] = 0, -- 灶神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.025, -- 重力极低
        },
    },

    {
        type = "planet",
        name = "pallas", -- 智神星
        icon = "__real-starry-universe__/graphics/pallas.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/pallas.png",
        starmap_icon_size = 512,
        gravity_pull = 0.020,
        distance = 27, -- 2.77 AU
        orientation = 300 / 360,
        magnitude = 0.2, -- Pallas (智神星)
        map_gen_settings = planet_map_gen.pallas(),
        surface_properties = {
            -- Pallas (智神星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 智神星昼夜周期：约7.8小时
            ["magnetic-field"] = 0, -- 智神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.020, -- 重力极低
        },
    },

    {
        type = "planet",
        name = "hygiea", -- 健神星
        icon = "__real-starry-universe__/graphics/hygiea.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/hygiea.png",
        starmap_icon_size = 512,
        gravity_pull = 0.005,
        distance = 27, -- 3.14 AU
        orientation = 355 / 360,
        magnitude = 0.2, -- Hygiea (健神星)
        map_gen_settings = planet_map_gen.hygiea(),
        surface_properties = {
            -- Hygiea (健神星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 健神星昼夜周期：约13小时
            ["magnetic-field"] = 0, -- 健神星几乎没有磁场
            ["solar-power"] = 13.717, -- 太阳能效率较低
            pressure = 0, -- 大气压为零
            gravity = 0.005, -- 重力极低
        },
    },
    {
        type = "planet",
        name = "jupiter", -- 木星
        icon = "__real-starry-universe__/graphics/jupiter.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/jupiter.png",
        starmap_icon_size = 512,
        gravity_pull = 24.79,
        distance = 77.8 / 2, -- 5.2 AU
        orientation = 240 / 360,
        magnitude = 11.209, -- Jupiter (木星)
        map_gen_settings = planet_map_gen.jupiter(),
        surface_properties = {
            -- Jupiter (木星)
            ["day-night-cycle"] = 0.41 * day, -- 木星昼夜周期：10小时
            ["magnetic-field"] = 20000, -- 极强磁场
            ["solar-power"] = 3.7, -- 距太阳远，太阳能效率非常低
            pressure = 200000000, -- 压力极高（单位：Pa）
            gravity = 24.79, -- 极高重力
        },
    },
    {
        type = "planet",
        name = "saturn", -- 土星
        icon = "__real-starry-universe__/graphics/saturn.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/saturn.png",
        starmap_icon_size = 512,
        gravity_pull = 10.44,
        distance = 143.3 / 3, -- 9.58 AU
        orientation = 280 / 360,
        magnitude = 9.449, -- Saturn (土星)
        map_gen_settings = planet_map_gen.saturn(),
        surface_properties = {
            -- Saturn (土星)
            ["day-night-cycle"] = 0.45 * day, -- 土星昼夜周期：10.7小时
            ["magnetic-field"] = 580, -- 中等磁场
            ["solar-power"] = 1.1, -- 远离太阳，效率极低
            pressure = 100000000, -- 大气压极高（单位：Pa）
            gravity = 10.44, -- 类似木星的重力
        },
    },
    {
        type = "planet",
        name = "uranus", -- 天王星
        icon = "__real-starry-universe__/graphics/uranus.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/uranus.png",
        starmap_icon_size = 512,
        gravity_pull = 8.87,
        distance = 287.7 / 4.5, -- 19.22 AU
        orientation = 320 / 360,
        magnitude = 4.007, -- Uranus (天王星)
        map_gen_settings = planet_map_gen.uranus(),
        surface_properties = {
            -- Uranus (天王星)
            ["day-night-cycle"] = 0.72 * day, -- 天王星昼夜周期：17小时
            ["magnetic-field"] = 50, -- 弱磁场
            ["solar-power"] = 0.3, -- 距太阳非常远
            pressure = 80000000, -- 大气压较高（单位：Pa）
            gravity = 8.69, -- 类似地球的重力
        },
    },
    {
        type = "planet",
        name = "neptune", -- 海王星
        icon = "__real-starry-universe__/graphics/neptune.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/neptune.png",
        starmap_icon_size = 512,
        gravity_pull = 11.15,
        distance = 450.3 / 5, -- 30.05 AU
        orientation = 355 / 360,
        magnitude = 3.883, -- Neptune (海王星)
        map_gen_settings = planet_map_gen.neptune(),
        surface_properties = {
            -- Neptune (海王星)
            ["day-night-cycle"] = 0.67 * day, -- 海王星昼夜周期：16小时
            ["magnetic-field"] = 25, -- 与地球相似的磁场
            ["solar-power"] = 0.1, -- 极低的太阳能
            pressure = 90000000, -- 高大气压（单位：Pa）
            gravity = 11.15, -- 稍高于地球的重力
        },
    },
    {
        type = "planet",
        name = "pluto", -- Pluto (冥王星)
        icon = "__real-starry-universe__/graphics/pluto.png",
        icon_size = 512,
        starmap_icon = "__real-starry-universe__/graphics/pluto.png",
        starmap_icon_size = 512,
        gravity_pull = 0.62,
        distance = 120, -- 39.52 AU
        orientation = 290 / 360,
        magnitude = 0.3,
        map_gen_settings = planet_map_gen.pluto(),
        surface_properties = {
            -- Pluto (冥王星)
            ["day-night-cycle"] = 6.39 * day, -- 冥王星昼夜周期：6.39个地球日
            ["magnetic-field"] = 0, -- 无磁场
            ["solar-power"] = 0.05, -- 几乎没有太阳能
            pressure = 0.1, -- 极其稀薄的大气压
            gravity = 0.62, -- 极低重力
        },
    },
    {
        type = "space-location", -- You should be able to land on asteroids in the asteroid belt. but must land on one of it like pluto.
        name = "asteroid-belt-outer",
        -- icon = "__real-starry-universe__/graphics/asteroid-belt-outer.png", -- Currently, there is no image for asteroid-belt-outer.
        icon = "__real-starry-universe__/graphics/asteroid-belt-outer.png", -- As there is no special image yet, the inner asteroid belt is going to use the pluto icon.
        icon_size = 1024,
        -- starmap_icon = "__real-starry-universe__/graphics/asteroid-belt-outer.png", -- Again, there is no image for asteroid-belt-outer.
        starmap_icon = "__real-starry-universe__/graphics/asteroid-belt-outer.png", -- Again, as there is no special image yet, the inner asteroid belt is going to use the pluto icon.
        starmap_icon_size = 1024,
        gravity_pull = 0.0000517472925, -- Aproximate surface gravity for asteroids in the outer asteroid belt (also known as kuiper belt)
        distance = 120, -- 40 AU (centre of the outer asteroid belt)
        orientation = 359 / 360,
        magnitude = 0.4,
        map_gen_settings = planet_map_gen.asteroid_belt_1(),
        surface_properties = {
            -- Outer Asteroid Belt (Between Neptune and Solar System Edge)
            ["day-night-cycle"] = 0.28449826615 * day, -- Aproximate day-night cycle for asteroids in the outer asteroid belt (also known as kuiper belt)
            ["magnetic-field"] = 0, -- Asteroids tend to have a very, very weak magnetic field. This is aproximated by 0 here.
            ["solar-power"] = 0.8625, -- Percentage of solar power compared to that on earth? Seems to fit with the data of pluto, being around the same.
            pressure = 0, -- The pressure in the inner asteroid belt is 0, as there is no atmosphere to sustain (air) pressure, and no large enough objects to sustain an atmosphere.
            gravity = 0.0000517472925, -- Aproximate surface gravity for asteroids in the outer asteroid belt (also known as kuiper belt)
        },
    },

    {
        type = "planet",
        name = "makemake", -- 鸟神星
        icon = "__real-starry-universe__/graphics/makemake.png",
        icon_size = 1024,
        starmap_icon = "__real-starry-universe__/graphics/makemake.png",
        starmap_icon_size = 1024,
        gravity_pull = 0.05,
        distance = 120, -- 45.79 AU
        orientation = 220 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.makemake(),
        surface_properties = {
            -- Makemake (鸟神星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 鸟神星昼夜周期：约22.5小时
            ["magnetic-field"] = 0, -- 鸟神星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.05, -- 重力极低
        },
    },

    {
        type = "planet",
        name = "haumea", -- 妊神星
        icon = "__real-starry-universe__/graphics/haumea.png",
        icon_size = 1024,
        starmap_icon = "__real-starry-universe__/graphics/haumea.png",
        starmap_icon_size = 1024,
        gravity_pull = 0.04,
        distance = 120, -- 43.34 AU
        orientation = 150 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.haumea(),
        surface_properties = {
            -- Haumea (妊神星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 妊神星昼夜周期：约3.9小时
            ["magnetic-field"] = 0, -- 妊神星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.04, -- 重力极低
        },
    },
    {
        type = "planet",
        name = "eris", -- 阋神星
        icon = "__real-starry-universe__/graphics/eris.png",
        icon_size = 1024,
        starmap_icon = "__real-starry-universe__/graphics/eris.png",
        starmap_icon_size = 1024,
        gravity_pull = 0.08,
        distance = 120, -- 67.78 AU
        orientation = 80 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.eris(),
        surface_properties = {
            -- Eris (阋神星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 阋神星昼夜周期：约15.8小时
            ["magnetic-field"] = 0, -- 阋神星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.08, -- 重力极低
        },
    },
    {
        type = "planet",
        name = "gonggong", -- 共工星
        icon = "__real-starry-universe__/graphics/gonggong.png",
        icon_size = 1024,
        starmap_icon = "__real-starry-universe__/graphics/gonggong.png",
        starmap_icon_size = 1024,
        gravity_pull = 0.06,
        distance = 120, -- 67.5 AU
        orientation = 10 / 360,
        magnitude = 0.25,
        map_gen_settings = planet_map_gen.gonggong(),
        surface_properties = {
            -- Gonggong (共工星)
            ["day-night-cycle"] = 0.37681889586 * day, -- 共工星昼夜周期：约25小时
            ["magnetic-field"] = 0, -- 共工星几乎没有磁场
            ["solar-power"] = 3.7, -- 太阳能效率非常低
            pressure = 0, -- 大气压为零
            gravity = 0.06, -- 重力极低
        },
    },

}

data:extend(planets)

--https://lua-api.factorio.com/latest/prototypes/SpaceConnectionPrototype.html
local space_connections = {
    {
        type = "space-connection",
        name = "mercury-venus", -- 水星到金星
        subgroup = "planet-connections",
        from = "mercury",
        to = "venus",
        order = "a[mercury]-b[venus]",
        length = 5.0, -- 水星到金星的距离，比例单位
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
        length = 4.2,
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
        length = 4.2,
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
        order = "z[a]",
        length = 15, -- 非常近的距离
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
        length = 7.6,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.large_asteroids),
        space_effects = {
            background_color = { r = 0.1, g = 0.3, b = 0.2 },
            particle_color = { r = 0.5, g = 0.2, b = 0.4 }
        }
    },
    {
        type = "space-connection",
        name = "mars-asteroid-belt-inner", -- Mars to the inner asteroid belt
        subgroup = "planet-connections",
        from = "mars",
        to = "asteroid-belt-inner",
        order = "d[mars]-e[asteroid-belt-inner]",
        length = 55.0,
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
        length = 55.0,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.aquilo_solar_system_edge),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.belt_asteroids),
        space_effects = {
            background_color = { r = 0.4, g = 0.3, b = 0.1 },
            particle_color = { r = 0.6, g = 0.5, b = 0.2 }
        }
    },
    {
        type = "space-connection",
        name = "jupiter-saturn", -- 木星到土星
        subgroup = "planet-connections",
        from = "jupiter",
        to = "saturn",
        order = "f[jupiter]-g[saturn]",
        length = 65.5,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.4, b = 0.3 },
            particle_color = { r = 0.5, g = 0.2, b = 0.7 }
        }
    },
    {
        type = "space-connection",
        name = "saturn-uranus", -- 土星到天王星
        subgroup = "planet-connections",
        from = "saturn",
        to = "uranus",
        order = "g[saturn]-h[uranus]",
        length = 144.0,
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
        length = 162.6,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
        --asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.giant_asteroids),
        space_effects = {
            background_color = { r = 0.2, g = 0.3, b = 0.5 },
            particle_color = { r = 0.3, g = 0.5, b = 0.7 }
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

for i, v in ipairs(space_connections) do
    v.length = v.length * 100
end

data:extend(space_connections)

local planets = {
    { "mercury", "水星", { "planet-discovery-venus", "space-platform-thruster" } },
    { "venus", "金星", { "planet-discovery-luna", "space-platform-thruster" } },
    { "earth", "地球", { "space-platform-thruster" } },
    { "luna", "月球", { "planet-discovery-earth", "space-platform-thruster" } },
    { "mars", "火星", { "planet-discovery-luna", "space-platform-thruster" } },
    { "asteroid-belt-inner", "内小行星带", { "planet-discovery-mars", "space-platform-thruster" } },
    { "jupiter", "木星", { "planet-discovery-asteroid-belt-inner", "space-platform-thruster" } },
    { "saturn", "土星", { "planet-discovery-jupiter", "space-platform-thruster" } },
    { "uranus", "天王星", { "planet-discovery-saturn", "space-platform-thruster" } },
    { "neptune", "海王星", { "planet-discovery-uranus", "space-platform-thruster" } },
    { "pluto", "冥王星", { "planet-discovery-neptune", "space-platform-thruster" } },
    { "asteroid-belt-outer", "柯伊伯带", { "planet-discovery-pluto", "space-platform-thruster" } }
}

for i, planet in ipairs(planets) do
    local planet_name = planet[1]
    local planet_description = planet[2]
    local prerequisites = planet[3]

    data:extend({
        {
            type = "technology",
            name = "planet-discovery-" .. planet_name,
            icon = "__real-starry-universe__/graphics/" .. planet_name .. ".png", -- 替换为行星对应的图标路径
            icon_size = 512,
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
            }
        }
    })
end


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
