local RotationUtil = require("data.rotation_util")

local day = 24 * hour

local function merge_prerequisites(technology_to_merge_into, technology_to_merge_from)
    for _, prerequisite_to_merge in pairs(technology_to_merge_from.prerequisites) do
        local contains_prerequisite = false
        for _, prerequisite_to_test in pairs(technology_to_merge_into.prerequisites) do
            if prerequisite_to_test == prerequisite_to_merge then
                contains_prerequisite = true
                break
            end
        end
        if not contains_prerequisite then
            table.insert(technology_to_merge_into.prerequisites, prerequisite_to_merge)
        end
    end
end

if mods["maraxsis"] then -- Check if the mod exists, just in case. Plus it's a clean way to distinglish code for different mod compatibilities.
    local maraxsis = data.raw["planet"]["maraxsis"]
    local maraxsis_trench = data.raw["planet"]["maraxsis-trench"]
    local maraxsis_discovery = data.raw["technology"]["planet-discovery-maraxsis"]
    local neptune = data.raw["planet"]["neptune"]
    local neptune_discovery = data.raw["technology"]["planet-discovery-neptune"]

    for _, space_connection in pairs(data.raw["space-connection"]) do -- Change all space-connections to reference maraxsis instead of neptune and remove any space-connections that were already referencing maraxsis.
        if not space_connection then goto continue end
        if space_connection.from == maraxsis.name or space_connection.to == maraxsis.name then
            data.raw[space_connection.type][space_connection.name] = nil -- Nilify the space-connection if it already involves maraxsis.
            goto continue -- If the space-connection is Nilified, why continue through the loop? Instead, continue to the next iteration of the loop!
        end
        if space_connection.from == neptune.name then
            space_connection.from = maraxsis.name -- This space-connection starts at neptune. Let's make that maraxis instead.
        end
        if space_connection.to == neptune.name then
            space_connection.to = maraxsis.name -- This space-connection end at neptune. Let's make that maraxis instead.
        end
        ::continue::
    end

    -- Move maraxsis to neptune's location.
    maraxsis.distance = neptune.distance
    maraxsis.orientation = neptune.orientation
    maraxsis.magnitude = neptune.magnitude

    maraxsis_trench.distance = ( maraxsis.magnitude * - 0.75 )
    maraxsis_trench.orientation = ( 270 / 360 )

    RotationUtil.Unrelate(maraxsis_trench, maraxsis) -- Convert the location of the maraxsis trench back into it's original coordinate system.

    -- Solar power in space around maraxsis should be equal to that of neptune.
    maraxsis.solar_power_in_space = neptune.solar_power_in_space
    maraxsis_trench.solar_power_in_space = neptune.solar_power_in_space

    maraxsis.surface_properties["solar-power"] = neptune.surface_properties["solar-power"] -- May need to be changed to account for the water of maraxsis.
    maraxsis.surface_properties["day-night-cycle"] = neptune.surface_properties["day-night-cycle"] -- May need to be removed.
    maraxsis.surface_properties["gravity"] = neptune.surface_properties["gravity"] -- May need to be removed.
    maraxsis_trench.surface_properties["day-night-cycle"] = neptune.surface_properties["day-night-cycle"] -- May need to be removed.
    maraxsis_trench.surface_properties["gravity"] = neptune.surface_properties["gravity"] -- May need to be removed.
    
    maraxsis.map_gen_settings.autoplace_controls = nil

    maraxsis.draw_orbit = neptune.draw_orbit

    maraxsis.asteroid_spawn_definitions = neptune.asteroid_spawn_definitions
    maraxsis_trench.asteroid_spawn_definitions = neptune.asteroid_spawn_definitions

    if neptune.localised_name then
        maraxsis.localised_name = neptune.localised_name
    else
        maraxsis.localised_name = {"space-location-name.neptune"}
    end

    if neptune_discovery.localised_name then
        maraxsis_discovery.localised_name = neptune_discovery.localised_name
    else
        maraxsis_discovery.localised_name = {"technology-name.planet-discovery-neptune"}
    end

    if neptune.localised_description then
        maraxsis.localised_description = neptune.localised_description
    else
        maraxsis.localised_description = {"space-location-description.neptune"}
    end

    if neptune_discovery.localised_description then
        maraxsis_discovery.localised_description = neptune_discovery.localised_description
    else
        maraxsis_discovery.localised_description = {"technology-description.planet-discovery-neptune"}
    end

    maraxsis_discovery.unit = table.deepcopy(neptune_discovery.unit)

    merge_prerequisites(maraxsis_discovery, neptune_discovery)

    data.raw[neptune.type][neptune.name] = nil -- Shouldn't crash the game, but a likely cause if it does.
    data.raw[neptune_discovery.type][neptune_discovery.name] = nil -- Shouldn't crash the game, but a likely cause if it does.
end
