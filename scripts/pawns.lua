

local path = GetParentPath(...)
require(path.."palette")

local mod = mod_loader.mods[modApi.currentMod]
local imageOffset = modApi:getPaletteImageOffset(mod.id)
----------------------------------utils--------------------------------------------------

-- Deep copy function
function deepcopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = deepcopy(v)  -- Recursively copy tables
        else
            copy[k] = v
        end
    end
    return copy
end


--------------------------------nutella jar------------------------------------------------


nutellaman111_jar = Pawn:new{
    Name = "Nutella Jar",
    Class = "Prime",
    Health = 1,
    MoveSpeed = 3,
    Massive = true,
    Image = "nutellaman111_jar",
    Range = 1;
    ImageOffset = imageOffset,
    SkillList = {"nutellaman111_lure"},
	SoundLocation = "/mech/prime/bottlecap_mech/",
    DefaultTeam = TEAM_PLAYER,
    ImpactMaterial = IMPACT_METAL,
    TempUnit = true,
    Corpse = false -- Only keep the final value
}


nutellaman111_jarX = deepcopy(nutellaman111_jar)
--nutellaman111_jarX.MoveSpeed = 4
nutellaman111_jarX.SkillList = {"nutellaman111_lureX"}

tipnutellaman111_jar = deepcopy(nutellaman111_jar)
tipnutellaman111_jar.TempUnit = false

testnutellaman111_jar = deepcopy(nutellaman111_jar)
testnutellaman111_jar.MoveSpeed = 99
testnutellaman111_jar.TempUnit = fail
testnutellaman111_jar.SkillList = {"testnutellaman_control"}
testnutellaman111_jar.Name = "Test Jar"
testnutellaman111_jar.Image = "testnutellaman111_jar",


AddPawn("nutellaman111_jar")
AddPawn("nutellaman111_jarX")
AddPawn("tipnutellaman111_jar")
AddPawn("testnutellaman111_jar")

------------------------------------------nutellaman111_bread---------------------------------------------

nutellaman111_bread = Pawn:new{
    Name = "Bread",
    Class = "Prime",
    Image = "nutellaman111_bread",
    Health = 2,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    ImageOffset = imageOffset,
    SkillList = {"nutellaman111_sand"},
	SoundLocation = "/enemy/beetle_1/",
    DefaultTeam = TEAM_PLAYER,
    ImpactMaterial = IMPACT_METAL,
}
AddPawn("nutellaman111_bread")

----------------------------------------------------nutellaman111_mixer---------------------------------

nutellaman111_mixer = Pawn:new{
    Name = "Electric Mixer",
    Class = "Ranged",
    Image = "nutellaman111_mixer",
    Health = 3,
    MoveSpeed = 3,
    Massive = true,
    Corpse = true,
    ImageOffset = imageOffset,
    SkillList = {"nutellaman111_mix"},
	SoundLocation = "/mech/prime/smoke_mech/",
    DefaultTeam = TEAM_PLAYER,
    ImpactMaterial = IMPACT_METAL,
}
AddPawn("nutellaman111_mixer")


-------------------------------------jar nutellaman111_launcher--------------------------------------------

nutellaman111_launcher = Pawn:new{
    Name = "Nutellapult",
    Class = "Science",
    Image = "nutellaman111_launcher",
    Health = 3,
    MoveSpeed = 3,
    Massive = true,
    Corpse = true,
    ImageOffset = imageOffset,
    SkillList = {"nutellaman111_dispatch"},
	SoundLocation = "/mech/brute/tank/",
    DefaultTeam = TEAM_PLAYER,
    ImpactMaterial = IMPACT_METAL
}
AddPawn("nutellaman111_launcher")

