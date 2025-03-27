local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local scriptsPath = path .."scripts/"
local nutellaman111_weaponsExposed = require(scriptsPath.."weapons")  

-- Helper functions
local SQUAD_ID = "nutellaman111_sandSquad"

local game_savedata = GAME_savedata("nutellaman111", SQUAD_ID, "Achievements")

local function isRealMission()
	local mission = GetCurrentMission()

	return true
		and mission ~= nil
		and mission ~= Mission_Test
		and Board
		and Board:IsMissionBoard()
end

local function isNotRealMission()
	return not isRealMission()
end

local function isGame()
	return Game ~= nil
end

local function setAchievementFailed(achievementId, failed)
	game_savedata[achievementId.."_failed"] = failed
end

local function getAchievementFailed(achievementId)
	return game_savedata[achievementId.."_failed"]
end



-------------- Achievement: no crumbs left -------------------------------

local NO_CRUMBS_LEFT = "nutellaman111_NoCrumbsLeft"
setAchievementFailed(NO_CRUMBS_LEFT, false)

local crumbs = modApi.achievements:addExt{
	id = NO_CRUMBS_LEFT,
	name = "No Crumbs Left",
	tooltip = "For an entire mission, end all your turns with 0 enemies on the board",
	--textDiffComplete = "$highscore kills",
	image = path.."img/achievements/nutellaman111_crumbs.png",
	squad = SQUAD_ID,
}

function crumbs:isFailed()
	return getAchievementFailed(NO_CRUMBS_LEFT)
end

function crumbs:getTextProgress()
	if isRealMission() then
		local pawnList = extract_table(Board:GetPawns(TEAM_ENEMY))

		local count = 0
		for _, pawnId in ipairs(pawnList) do
			local pawn = Board:GetPawn(pawnId)
			if(pawn:GetSpace().x>-1) then --make sure the enemy isnt burrowed
				count = count+1
			end
		end

		return count .. " enemies on the board (" .. (count > 0 and "bad" or "good!") .. ")"
	end
end

local function crumbs_nextTurn(mission)
	if isRealMission() and Game:GetTeamTurn() == TEAM_PLAYER then

		local pawnList = extract_table(Board:GetPawns(TEAM_ENEMY))

		local fail = false
		for _, pawnId in ipairs(pawnList) do
			local pawn = Board:GetPawn(pawnId)
			if(pawn:GetSpace().x>-1) then --make sure the enemy isnt burrowed
				setAchievementFailed(NO_CRUMBS_LEFT, true)
				break
			end
		end

	end
end

local function crumbs_missionStart(mission)
	if isRealMission() then
		setAchievementFailed(NO_CRUMBS_LEFT, false)
	end
end


local function crumbs_missionEnd(mission)
	if isRealMission() then
		if not getAchievementFailed(NO_CRUMBS_LEFT) then
			crumbs:completeWithHighscore()
		end
		setAchievementFailed(NO_CRUMBS_LEFT, false)
	end
end

-------------- Achievement: footlong -------------------------------

local FOOTLONG = "nutellaman111_Footlong"
local footlong = modApi.achievements:addExt{
	id = FOOTLONG,
	name = "Footlong",
	tooltip = "Target 3 enemies with one use of 'Sandwich'",
	textDiffComplete = "$highscore enemies targeted",
	image = path.."img/achievements/nutellaman111_footlong.png",
	squad = SQUAD_ID,
}


local function footlong_finalEffect(mission,pawn,weaponId,p1,p2,p3)
	if isRealMission() then
		if weaponId:find("^nutellaman111_sand") ~= nil then

			local gaps = 0
			if(weaponId == "nutellaman111_sand_B" or weaponId == "nutellaman111_sand_AB") then
				gaps = 1
			end

			local effect, targetArea, enemiesCount = nutellaman111_weaponsExposed.sandCalc(p1, gaps, 0)

			if enemiesCount >= 3 then 
				footlong:completeWithHighscore(enemiesCount)
			end
		end
	end
end


-------------- Achievement: diabetes -------------------------------

local DIABETES = "nutellaman111_Diabetes"
local diabetes_kills = 0
local diabetes = modApi.achievements:addExt{
	id = DIABETES,
	name = "Diabetes",
	tooltip = "Kill 2 enemies with one use of Nutella Jar's 'Lure'",
	textDiffComplete = "$highscore enemies killed",
	image = path.."img/achievements/nutellaman111_diabetes.png",
	squad = SQUAD_ID,
}

local function diabetes_kill(mission, pawn)
	if isRealMission() and pawn:IsEnemy() then
		diabetes_kills = diabetes_kills + 1
	end
end

local function diabetes_start(mission, pawn, weaponId, p1, p2)
	if isRealMission() and weaponId:find("^nutellaman111_lure") ~= nil then
		diabetes_kills = 0
	end
end

local function diabetes_resolved(mission, pawn, weaponId, p1, p2)
	if isRealMission() and weaponId:find("^nutellaman111_lure") ~= nil then
		if (diabetes_kills >= 2) then
			diabetes:completeWithHighscore(diabetes_kills)
		end
	end
end


------------------------------ events subscroption stuff -------------------------

local eventHandlers = {
	--no crumbs left
	{ event = modApi.events.onMissionStart, handler = crumbs_missionStart },
	{ event = modApi.events.onMissionEnd, handler = crumbs_missionEnd },

	--footlong
	{ event = modapiext.events.onSkillStart, handler = footlong_finalEffect },

	--diabetes
	{ event = modapiext.events.onPawnKilled, handler = diabetes_kill },
	{ event = AttackEvents.onAllyAttackStart, handler = diabetes_start },
	{ event = AttackEvents.onAllyAttackResolved, handler = diabetes_resolved },
}

local function handleSubscriptions(squadId, action)
	if squadId == SQUAD_ID then
		for _, e in ipairs(eventHandlers) do
			e.event[action](e.event, e.handler)
		end
	end
end

-- Squad entered game event
modApi.events.onSquadEnteredGame:subscribe(function(squadId)
	handleSubscriptions(squadId, "subscribe")
end)

-- Squad exited game event
modApi.events.onSquadExitedGame:subscribe(function(squadId)
	handleSubscriptions(squadId, "unsubscribe")
end)


--next turn detector that possibly breaks other stuff in the game?
--Mission.original_IsEnvironmentEffect = Mission.IsEnvironmentEffect
function Mission.IsEnvironmentEffect(...)
	crumbs_nextTurn()
	return true
    --return Mission.original_IsEnvironmentEffect(...)  -- Call the original function
end
