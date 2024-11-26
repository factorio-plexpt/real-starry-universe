local Mercury = require("asteroid_definitions.mercury")
local Venus = require("asteroid_definitions.venus")
local Earth = require("asteroid_definitions.earth")
local Luna = require("asteroid_definitions.luna")
local Mars = require("asteroid_definitions.mars")
local Phobos = require("asteroid_definitions.phobos")
local Deimos = require("asteroid_definitions.deimos")
local AsteroidBeltInner = require("asteroid_definitions.asteroid-belt-inner")
local Ceres = require("asteroid_definitions.ceres")
local Vesta = require("asteroid_definitions.vesta")
local Pallas = require("asteroid_definitions.pallas")
local Hygiea = require("asteroid_definitions.hygiea")
local Jupiter = require("asteroid_definitions.jupiter")
local Saturn = require("asteroid_definitions.saturn")
local Uranus = require("asteroid_definitions.uranus")
local Neptune = require("asteroid_definitions.neptune")
local Pluto = require("asteroid_definitions.pluto")
local AsteroidBeltOuter = require("asteroid_definitions.asteroid-belt-outer")
local MakeMake = require("asteroid_definitions.makemake")
local Eris = require("asteroid_definitions.eris")
local Haumea = require("asteroid_definitions.haumea")
local GongGong = require("asteroid_definitions.gonggong")
local DefinitionsUtil = require("asteroid_definitions.definitions_util")
-- Return all asteroid definitions for the solar system.

-- Planets are sorted by the distance from the star they orbit.
-- For instance, Earth is labelled under 3 - meaning that it's the third planet that orbits the Sun.
-- Nil is currently representing planets which don't exist yet, such as the outer asteroid belt. These nils are defined in their respective asteroid definitions file.
local Planets = {
	[1] = Mercury,
	[2] = Venus,
	[3] = Earth,
	[4] = Mars,
	[5] = AsteroidBeltInner,
	[6] = Jupiter,
	[7] = Saturn,
	[8] = Uranus,
	[9] = Neptune,
	[10] = AsteroidBeltOuter
}

-- Moons are sorted by the planet they orbit.
-- For instance, Luna is labelled under 3,1 - meaning that it's the first moon of the third planet, Earth.
-- Nil is currently representing moons which don't exist yet, such as the moons of Mars.
-- Empty tables represent planets with no moons, such as mercury.
local Moons = {
	[1] = {}, -- Mercury
	[2] = {}, -- Venus
	[3] = { -- Earth
		[1] = Luna
	},
	[4] = { -- Mars
		[1] = Phobos,
		[2] = Deimos
	},
	[5] = { -- Inner Asteroid Belt
		[1] = Ceres,
		[2] = Vesta,
		[3] = Pallas,
		[4] = Hygiea
	},
	[6] = { -- Jupiter
		[1] = nil,
		[2] = nil,
		[3] = nil,
		[4] = nil
	},
	[7] = { -- Saturn
		[1] = nil,
		[2] = nil,
		[3] = nil
	},
	[8] = { -- Uranus
		[1] = nil,
		[2] = nil,
		[3] = nil,
		[4] = nil,
		[5] = nil
	},
	[9] = { -- Neptune
		[1] = nil
	},
	[10] = { -- Outer Asteroid Belt
		[1] = Pluto,
		[2] = MakeMake,
		[3] = Eris,
		[4] = Haumea,
		[5] = GongGong
	}
}

-- Use the Planet + Moon definition function to create the solar system.
local SolarSystem = DefinitionsUtil.StarSystem(Planets, Moons)

return SolarSystem
