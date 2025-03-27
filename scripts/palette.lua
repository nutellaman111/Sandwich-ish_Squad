


local mod = modApi:getCurrentMod()

local palette = {
	ID = mod.id,
	Name = "Candy House",
	Image = "units/player/nutellaman111_mixer_ns.png",
	PlateHighlight = {217,74,74 },
	PlateLight     = {161,109,116},
	PlateMid       = {122,72,78},
	PlateDark      = {66,35,35},
	PlateOutline   = {49,25,25},
	PlateShadow    = {132,86,56 },
	BodyColor      = {198,149,97},
	BodyHighlight  = {217,190,143},
	}

modApi:addPalette(palette)
