if data.raw["utility-sprites"] and data.raw["utility-sprites"]["default"] then
    local utility_sprites = data.raw["utility-sprites"]["default"]
    local starmap_star = utility_sprites["starmap_star"] or {
        type = "sprite",
        layers = {
            {
                filename = "__core__/graphics/icons/starmap-star.png",
                size = 512,
                scale = 0.5,
                shift = { 0, 0 },
                draw_as_light = true,
            },
        },
    }
    starmap_star.layers = starmap_star.layers or {}

    local solar_system_sprites = {
        { filename = "__real-starry-universe__/graphics/starmap/Starmap_Solar_System_01.png", size = 4096, scale = 1, shift = { -2048, -2048 } },
        { filename = "__real-starry-universe__/graphics/starmap/Starmap_Solar_System_02.png", size = 4096, scale = 1, shift = { 2048, -2048 } },
        { filename = "__real-starry-universe__/graphics/starmap/Starmap_Solar_System_03.png", size = 4096, scale = 1, shift = { -2048, 2048 } },
        { filename = "__real-starry-universe__/graphics/starmap/Starmap_Solar_System_04.png", size = 4096, scale = 1, shift = { 2048, 2048 } },
        { filename = "__real-starry-universe__/graphics/starmap/Starmap_Solar_System_05.png", size = 2436, scale = 0.93, shift = { 0, 0 } },
        { filename = "__core__/graphics/icons/starmap-star.png", size = 512, scale = 0.5, shift = { 0, 0 } },
    }

    for _, sprite in ipairs(solar_system_sprites) do
        table.insert(starmap_star.layers, sprite)
    end

    utility_sprites["starmap_star"] = starmap_star
end
