local description = "mood description"


local mod = {
    id = "nutellaman111_sandSquadMod",
    name = "Sandwich-ish Squad",
    version = "1.0",
    modApiVersion = "2.9.2",
    gameVersion = "1.2.88",
    icon = "img/mod_icon.png",
    description = description,
}

local libs = {
	"achievementExt",
	"artilleryArc",
	"astar",
	"attackEvents",
	"blockDeathByDeployment",
	"boardEvents",
	"effectBurst",
	"effectPreview",
	"globals",
	"personalSavedata",
	"switch",
	"trait",
	"tutorialTips",
	"weaponArmed",
	"weaponPreview",
	"worldConstants",
}

function mod:init()
    self.libs = {}
	for _, libId in ipairs(libs) do
		self.libs[libId] = require(self.scriptPath.."libs/"..libId)
	end

    self.libs.modApiExt = modapiext

	
    require(self.scriptPath.."palette")
    require(self.scriptPath.."textures")
    require(self.scriptPath.."pawns")
    require(self.scriptPath.."weapons")
    require(self.scriptPath.."myhooks")
    require(self.scriptPath.."achievements")
end



function mod:load(options, version)
    --
    modApi:addSquad(
    {
   	 "Sandwich-ish squad",   	 -- title
   	 "nutellaman111_bread",    			 -- mech #1
   	 "nutellaman111_mixer",    			 -- mech #3
   	 "nutellaman111_launcher",			 -- mech #2
   	 id="nutellaman111_sandSquad"
    },
    "Sandwich-ish Squad",
    "Reposition vek to form delicious death sandwiches",
    self.resourcePath.."img/squad_icon.png"
    )

end





return mod
