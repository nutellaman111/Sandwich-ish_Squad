-----------------------------textures-------------------------------------

local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local mechPath = path .."img/units/player/"
local effectsPath = path .."img/effects/"
local weaponsPath = path .."img/weapons/"
local achievementsPath = path .."img/achievements/"

local mechFiles = {
    "nutellaman111_bread_a.png",
    "nutellaman111_bread_b.png",
    "nutellaman111_bread_bw.png",
    "nutellaman111_bread_h.png",
    "nutellaman111_bread_ns.png",
    "nutellaman111_bread_w.png",
    "nutellaman111_jar_a.png",
    "nutellaman111_jar_d.png",
    "nutellaman111_jar_h.png",
    "nutellaman111_jar_ns.png",
    "nutellaman111_jar_w.png",
    "nutellaman111_launcher_a.png",
    "nutellaman111_launcher_b.png",
    "nutellaman111_launcher_bw.png",
    "nutellaman111_launcher_h.png",
    "nutellaman111_launcher_ns.png",
    "nutellaman111_launcher_w.png",
    "nutellaman111_mixer_a.png",
    "nutellaman111_mixer_b.png",
    "nutellaman111_mixer_bw.png",
    "nutellaman111_mixer_h.png",
    "nutellaman111_mixer_ns.png",
    "nutellaman111_mixer_w.png",
    "nutellaman111_mixer_w.png",
    "testnutellaman111_jar_w.png",
    "testnutellaman111_jar_a.png",
}
local projectileFiles = {
    "nutellaman111_shotup_jar.png",
    "shotup_nutellaman111_lureB.png",
    "nutellaman111_shotup_mix.png"
}
local weaponsFiles = {
    "nutellaman111_dispatch.png",
    "nutellaman111_lure.png",
    "nutellaman111_mix.png",
    "nutellaman111_sandwich.png"
}
for _, file in ipairs(mechFiles) do
    modApi:appendAsset("img/units/player/".. file, mechPath .. file)
end
for _, file in ipairs(projectileFiles) do
    modApi:appendAsset("img/effects/".. file, effectsPath .. file)
end
for _, file in ipairs(weaponsFiles) do
    modApi:appendAsset("img/weapons/".. file, weaponsPath .. file)
end

local a=ANIMS

--nutellaman111_jar--
local nutellaman111_jarBase = a.MechUnit:new{PosX = -33, PosY = -20}
a.nutellaman111_jar_ns = nutellaman111_jarBase:new{Image="units/player/nutellaman111_jar_ns.png"}
a.nutellaman111_jar = nutellaman111_jarBase:new{Image="units/player/nutellaman111_jar_a.png", NumFrames = 3, Frames = {0}}
a.nutellaman111_jara = nutellaman111_jarBase:new{Image="units/player/nutellaman111_jar_a.png", NumFrames = 3, Frames = {0, 0, 1, 2}}
a.nutellaman111_jarw = nutellaman111_jarBase:new{Image="units/player/nutellaman111_jar_w.png", PosX = -31, PosY = -7}
a.nutellaman111_jard = nutellaman111_jarBase:new{Image="units/player/nutellaman111_jar_d.png", NumFrames = 8, Frames = {0, 1, 2, 3, 4, 5, 6, 7}, Loop = false, Time = 0.14}

a.testnutellaman_jar_ns = a.nutellaman111_jar_ns
a.testnutellaman111_jar = a.nutellaman111_jar
a.testnutellaman111_jara = a.nutellaman111_jara:new{Image="units/player/testnutellaman111_jar_a.png"}
a.testnutellaman111_jarw = a.nutellaman111_jarw:new{Image="units/player/testnutellaman111_jar_w.png"}
a.testnutellaman111_jard = a.nutellaman111_jard

--nutellaman111_bread--
local nutellaman111_breadBase = a.MechUnit:new{PosX = -13, PosY = -5}
a.nutellaman111_bread_ns = nutellaman111_breadBase:new{Image="units/player/nutellaman111_bread_ns.png"}
a.nutellaman111_bread = nutellaman111_breadBase:new{Image="units/player/nutellaman111_bread_a.png", NumFrames = 4, Frames = {0}}
a.nutellaman111_breada = nutellaman111_breadBase:new{Image="units/player/nutellaman111_bread_a.png", NumFrames = 4, Frames = {0, 1, 2, 3}}
a.nutellaman111_breadw = nutellaman111_breadBase:new{Image="units/player/nutellaman111_bread_w.png", PosY = 6}
a.nutellaman111_bread_broken = nutellaman111_breadBase:new{Image="units/player/nutellaman111_bread_b.png", NumFrames = 2, Frames = {0, 0, 1, 1}, PosX = -22, PosY = -2}
a.nutellaman111_breadw_broken = nutellaman111_breadBase:new{Image="units/player/nutellaman111_bread_bw.png", NumFrames = 4, Frames = {0, 1, 2, 3}, PosX = -22, PosY = 5, Lengths = {0.25, 0.25, 0.25, INT_MAX}}

--nutellaman111_launcher--
local nutellaman111_launcherBase = a.MechUnit:new{PosX = -16, PosY = -8}
a.nutellaman111_launcher_ns = nutellaman111_launcherBase:new{Image="units/player/nutellaman111_launcher_ns.png", PosX = 8, PosY = 0}
a.nutellaman111_launcher = nutellaman111_launcherBase:new{Image="units/player/nutellaman111_launcher_a.png", NumFrames = 2, Frames = {0}}
a.nutellaman111_launchera = nutellaman111_launcherBase:new{Image="units/player/nutellaman111_launcher_a.png", NumFrames = 2, Frames = {0, 0, 1, 1}}
a.nutellaman111_launcherw = nutellaman111_launcherBase:new{Image="units/player/nutellaman111_launcher_w.png", PosY = 3, posX = -18}
a.nutellaman111_launcher_broken = nutellaman111_launcherBase:new{Image="units/player/nutellaman111_launcher_b.png"}
a.nutellaman111_launcherw_broken = nutellaman111_launcherBase:new{Image="units/player/nutellaman111_launcher_bw.png", PosY = 3, posX = -18}

 --nutellaman111_mixer--
local nutellaman111_mixerBase = a.MechUnit:new{PosX = -16, PosY = -6}
a.nutellaman111_mixer_ns = nutellaman111_mixerBase:new{Image="units/player/nutellaman111_mixer_ns.png", posX = 0, posY = 0}
a.nutellaman111_mixer_h = nutellaman111_mixerBase:new{Image="units/player/nutellaman111_mixer_h.png", posX = 0, posY = 0}
a.nutellaman111_mixer = nutellaman111_mixerBase:new{Image="units/player/nutellaman111_mixer_a.png", NumFrames = 4, Frames = {0}}
a.nutellaman111_mixera = nutellaman111_mixerBase:new{Image="units/player/nutellaman111_mixer_a.png", NumFrames = 4, Frames = {0, 1, 2, 3}}
a.nutellaman111_mixerw = nutellaman111_mixerBase:new{Image="units/player/nutellaman111_mixer_w.png", posY = -20, PosY = 8}
a.nutellaman111_mixer_broken = nutellaman111_mixerBase:new{Image="units/player/nutellaman111_mixer_b.png"}
a.nutellaman111_mixerw_broken = nutellaman111_mixerBase:new{Image="units/player/nutellaman111_mixer_w.png",posY = -20, PosY = 8}

--[[
a.MyMech --still () used for ice
a.MyMecha --alive - animated (a)
a.MyMechw --water (_w)
a.MyMech_broken --broken (_broken)
a.MyMechw_broken --broken water (_w_broken)
a.MyMech_ns --squad locked (_ns) no shadow]] 