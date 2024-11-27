local function change_string(name, value)
    local settingitem = data.raw["string-setting"][name]

    if settingitem then

        settingitem.hidden = true
        settingitem.allowed_values = { value }
        settingitem.default_value = value
        settingitem.forced_value = value
    end
end
local function change_bool(name, value)
    local settingitem = data.raw["bool-setting"][name]

    if settingitem then

        settingitem.hidden = true
        settingitem.allowed_values = { value }
        settingitem.default_value = value
        settingitem.forced_value = value
    end
end

local alien_biomes_settings = {
    ["alien-biomes-include-dirt-aubergine"] = "Enabled",
    ["alien-biomes-include-dirt-beige"] = "Enabled",
    ["alien-biomes-include-dirt-black"] = "Enabled",
    ["alien-biomes-include-dirt-brown"] = "Enabled",
    ["alien-biomes-include-dirt-cream"] = "Enabled",
    ["alien-biomes-include-dirt-dustyrose"] = "Enabled",
    ["alien-biomes-include-dirt-grey"] = "Enabled",
    ["alien-biomes-include-dirt-purple"] = "Enabled",
    ["alien-biomes-include-dirt-red"] = "Enabled",
    ["alien-biomes-include-dirt-tan"] = "Enabled",
    ["alien-biomes-include-dirt-violet"] = "Enabled",
    ["alien-biomes-include-dirt-white"] = "Enabled",
    ["alien-biomes-include-frozen"] = "Enabled",
    ["alien-biomes-include-grass-blue"] = "Enabled",
    ["alien-biomes-include-grass-green"] = "Enabled",
    ["alien-biomes-include-grass-mauve"] = "Enabled",
    ["alien-biomes-include-grass-olive"] = "Enabled",
    ["alien-biomes-include-grass-orange"] = "Enabled",
    ["alien-biomes-include-grass-purple"] = "Enabled",
    ["alien-biomes-include-grass-red"] = "Enabled",
    ["alien-biomes-include-grass-turquoise"] = "Enabled",
    ["alien-biomes-include-grass-violet"] = "Enabled",
    ["alien-biomes-include-grass-yellow"] = "Enabled",
    ["alien-biomes-include-sand-aubergine"] = "Enabled",
    ["alien-biomes-include-sand-beige"] = "Enabled",
    ["alien-biomes-include-sand-black"] = "Enabled",
    ["alien-biomes-include-sand-brown"] = "Enabled",
    ["alien-biomes-include-sand-cream"] = "Enabled",
    ["alien-biomes-include-sand-dustyrose"] = "Enabled",
    ["alien-biomes-include-sand-grey"] = "Enabled",
    ["alien-biomes-include-sand-purple"] = "Enabled",
    ["alien-biomes-include-sand-red"] = "Enabled",
    ["alien-biomes-include-sand-tan"] = "Enabled",
    ["alien-biomes-include-sand-violet"] = "Enabled",
    ["alien-biomes-include-sand-white"] = "Enabled",
    ["alien-biomes-include-volcanic-blue"] = "Enabled",
    ["alien-biomes-include-volcanic-green"] = "Enabled",
    ["alien-biomes-include-volcanic-orange"] = "Enabled",
    ["alien-biomes-include-volcanic-purple"] = "Enabled",

    ["tile-speed-reduction"] = 100,
    ["alien-biomes-include-inland-shallows"] = "Enabled",
    ["alien-biomes-include-coastal-shallows"] = "Enabled",
    --["alien-biomes-disable-vegetation"] = "Disabled",
    --["alien-biomes-include-rivers"] = "Disabled"
}
for name, setting in pairs(alien_biomes_settings) do
    change_string(name, setting)
end
