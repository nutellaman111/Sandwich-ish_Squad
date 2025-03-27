
local nutellaman111_weaponsExposed = {}

--------------------------------mix---------------------------------


nutellaman111_mix = ArtilleryDefault:new{  
	Class = "Ranged",
	Name = "Remote mix",
	Description = "Launch a projectile that pushes adjacent units clockwise",
	Icon = "weapons/nutellaman111_mix.png",
	Rarity = 1,
	Explosion = "",
	LaunchSound = "/weapons/shrapnel",
	ImpactSound = "/weapons/ranged_crack",
	PathSize = 1,
	Damage = 0,
	DamageToEnemies = 0,
	DamageToAll = 0,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = "effects/nutellaman111_shotup_mix.png",
	Upgrades = 2,
	UpgradeCost = {2, 3},
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	--UpgradeList = { "Dash",  "+2 Damage"  },
	Dash = true,
	DamageCenter = 0,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,2),
		Mountain = Point(2,0),
		Friendly = Point(3,1)
	}
}

nutellaman111_mix_A = nutellaman111_mix:new{
	DamageToAll = 1,
	Damage = 1,
	UpgradeDescription = "Projectile Deals +1 damage to adjacent tiles"
}
Weapon_Texts.nutellaman111_mix_Upgrade1 = "+1 Damage"

nutellaman111_mix_B = nutellaman111_mix:new{
	DamageToEnemies = 1,
	TipDamageCustom = "0 (1 to enemies)",
	UpgradeDescription = "Projectile Deals +1 damage to adjacent enemies"
}
Weapon_Texts.nutellaman111_mix_Upgrade2 = "+1 Enemy Damage"

nutellaman111_mix_AB = nutellaman111_mix:new{
	DamageToAll = 1,
	DamageToEnemies = 1,
	TipDamageCustom = "1 (2 to enemies)"
}


function nutellaman111_mix:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	local damage = SpaceDamage(p2,0)
	
	ret:AddArtillery(damage, self.Projectile)
		
	for dir = 0, 3 do

		local loc = p2 + DIR_VECTORS[dir]

		damage = SpaceDamage(loc, 
			self.DamageToAll + (Board:IsPawnTeam(loc, TEAM_ENEMY) and self.DamageToEnemies or 0))	
		damage.iPush = (dir + 1)%4
		damage.sAnimation = "airpush_"..(dir + 1)%4

		ret:AddDamage(damage)
	end

	return ret
end

--------------------------------nutella jar lure---------------------------------

nutellaman111_lure = Skill:new{  
	Class = "Unique",
	Name = "Lure",
	Description = "Launch a chunk of nutella that lures a target 1 tile closer",
	Icon = "weapons/nutellaman111_lure.png",
	UpShot = "effects/shotup_nutellaman111_lureB.png", --"effects/shotdown_rock.png",
	Rarity = 0,
	Explosion = "",
	LaunchSound = "/weapons/gravwell",
	Range = 1, -- Tooltip?
	PathSize = 1,
	Damage = 0,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	--UpgradeList = { "Dash",  "+2 Damage"  },
	TipImage = {
		Unit = Point(1,2),
		Target = Point(3,2),
		Enemy = Point(3,2),
		CustomPawn = "tipnutellaman111_jar",
	}
}


nutellaman111_lureX = nutellaman111_lure:new{
	Range = 2,
	TipImage = {
		Unit = Point(1,2),
		Target = Point(4,2),
		Enemy = Point(4,2),
		CustomPawn = "tipnutellaman111_jar",
	}
}

function nutellaman111_lure:GetTargetArea(p1)
	local ret = PointList()
	
	for dir = DIR_START, DIR_END do	
		for i = 2, self.Range+1 do
			local tile = p1 + DIR_VECTORS[dir] * i
			if Board:IsValid(tile) then
				ret:push_back(tile)
			end
		end
	end
	return ret
end

function nutellaman111_lure:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	
	for dir = DIR_START, DIR_END do	
		for i = 2, self.Range+1 do
			local tile = p1 + DIR_VECTORS[dir] * i
			if Board:IsValid(tile) and p2 ~= tile then
				ret:push_back(tile)
			end
		end
	end
	return ret
end


function nutellaman111_lure:GetSkillEffect(p1,p2)
    local ret = SkillEffect()
    local damage = SpaceDamage(p2, self.Damage, GetDirection(p1 - p2))
	ret:AddArtillery(damage, self.UpShot)
	if Board:IsTipImage() then
		ret:AddDelay(2)
		end
	return ret
end

-----------------------------------test jar move unit---------------------------------

testnutellaman_control = Science_TC_Control:new{
	MoveDistance = 99, 
    Upgrades = 0,
	UpgradeCost = {},
    Name = "Move Unit",
    Class = "Unique",
    Rarity = 0,
	Description = "Move units to test another mech",
    TipImage = {
		Unit = Point(2,3),
		Target = Point(1,1),
		Enemy = Point(1,1),
		Second_Click = Point(3,1),
        CustomPawn = "testnutellaman111_jar"
	},
}
function testnutellaman_control:GetTargetArea(point)
    local ret = PointList()
	
	local board_size = Board:GetSize()
	for i = 0, board_size.x - 1 do
		for j = 0, board_size.y - 1  do
            local curr = Point(i,j)
            if self:IsControllable(curr) then
                ret:push_back(curr)
            end		
        end
	end
	
	return ret
end

--------------------------------dispatch a nutella jar---------------------------------

nutellaman111_dispatch = Deployable:new{
	Class = "Science",
	Icon = "weapons/nutellaman111_dispatch.png",
	Name = "Nutella Dispatch",
	Description = "Deploy a massive nutella jar that can lure nearby targets closer, dies after 1 turn",
	Rarity = 3,
	Deployed = "nutellaman111_jar",
	Projectile = "effects/nutellaman111_shotup_jar.png",
	--Projectile = "effects/shotup_shieldtank.png",
	Cost = "med",
	Limited = 0,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeCost = { 1, 3},
	version = "",
	Acid = false,
	--UpgradeList = { "+2 Health", "+2 Damage" },
	LaunchSound = "/weapons/deploy_tank",
	ImpactSound = "/impact/dynamic/rock",
	TipImage = {
		Unit = Point(1,3),
		Target = Point(3,3),
		Second_Origin = Point(3,3),
		Enemy = Point(3,1),
		Second_Target = Point(3,1)
	}
}

nutellaman111_dispatch_A = nutellaman111_dispatch:new{
	Deployed = "nutellaman111_jarX",
	UpgradeDescription = "Nutella Jar has +1 lure range",
	TipImage = {
		Unit = Point(1,3),
		Target = Point(3,3),
		Second_Origin = Point(3,3),
		Enemy = Point(3,0),
		Second_Target = Point(3,0)
	}
}
Weapon_Texts.nutellaman111_dispatch_Upgrade1 = "Lure +1 range"

nutellaman111_dispatch_B = nutellaman111_dispatch:new{
	Acid = true,
	UpgradeDescription = "Nutella Jar applies acid behind itself upon landing"
}
Weapon_Texts.nutellaman111_dispatch_Upgrade2 = "Acid Landing"

nutellaman111_dispatch_AB = nutellaman111_dispatch_A:new{
	Acid = true
}


function nutellaman111_dispatch:GetSkillEffect(p1, p2)	
	local ret = SkillEffect()	
	local damage = SpaceDamage(p2,0)
	damage.sPawn = Board:IsTipImage() and "tipnutellaman111_jar" or self.Deployed
	ret:AddArtillery(damage,self.Projectile)

	if self.Acid == true then
		local direction = GetDirection(p2-p1)
		for _, dirOffset in ipairs({2}) do --allows applying acid in more than one direction, 2 is behind
			local damage2 = SpaceDamage(p2 + DIR_VECTORS[(direction + dirOffset) % 4],  0)
			damage2.iAcid = EFFECT_CREATE		
			damage2.sAnimation = "ExploAcid1"
			damage2.sSound = "/impact/generic/acid_canister"

			ret:AddDamage(damage2)
		end
	end

	return ret
end		

function nutellaman111_dispatch:GetTargetArea(point)
	local ret = PointList()
	
	for dir = DIR_START, DIR_END do
		for i = 2, self.ArtillerySize do
			local curr = Point(point + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then
				break
			end
			
			if not Board:IsBlocked(curr,PATH_MASSIVE) then
				ret:push_back(curr)
			end

		end
	end
	
	return ret
end



--------------------------------sandwich---------------------------------

nutellaman111_sand = Skill:new{  
	Class = "Prime",
	Icon = "weapons/nutellaman111_sandwich.png",
	Name = "Sandwich",
	Description = "Damage units sandwiched between you and allies (allies immune).",
	Rarity = 3,
	Explosion = "",
	LaunchSound = "/weapons/prism_beam",
	Range = 1, -- Tooltip?
	PathSize = 1,
	Damage = 3,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 0,
	--UpgradeList = { "Dash",  "+2 Damage"  },
	TipImage = StandardTips.Melee,
	Upgrades = 2,
	Gaps = 0,
	UpgradeCost = { 2, 2},
	TipImage = {
		Unit = Point(3,3),
		Target = Point(3,2),
		Enemy = Point(2,3),
		Friendly = Point(1,3),
		Enemy1 = Point(3,2),
		Enemy2 = Point(3,1),
		Friendly1 = Point(3,0)
	}
	 
}


nutellaman111_sand_A = nutellaman111_sand:new{
	Damage = 4,
	UpgradeName = "+1 Damage",
	UpgradeDescription = "Deals +1 damage to all affected tiles."
}
Weapon_Texts.nutellaman111_sand_Upgrade1 = "+1 Damage"


nutellaman111_sand_B = nutellaman111_sand:new{
	Gaps = 1,
	UpgradeDescription = "Each sandwich can have one empty tile.",
	TipImage = {
		Unit = Point(3,3),
		Target = Point(3,2),
		Friendly = Point(1,3),
		Enemy = Point(3,2),
		Friendly1 = Point(3,0)
	}
}
Weapon_Texts.nutellaman111_sand_Upgrade2 = "Air Sandwich"

nutellaman111_sand_AB = nutellaman111_sand_B:new{
	Damage = 4
}


function nutellaman111_sand:GetTargetArea(p)

	local effect, targetArea, enemiesCount = nutellaman111_weaponsExposed.sandCalc(p, self.Gaps, self.Damage)

	return targetArea
end

function nutellaman111_sand:GetSkillEffect(p1, p2)

	local effect, targetArea, enemiesCount = nutellaman111_weaponsExposed.sandCalc(p1, self.Gaps, self.Damage)
	return effect

end

function nutellaman111_weaponsExposed.sandCalc(p, myGaps, myDamage)

	local effect = SkillEffect()
	local targetArea = PointList()
	local enemiesCount = 0

	for dir = DIR_START, DIR_END do

		local gapsRemaining = myGaps or 0

		local dirVector = DIR_VECTORS[dir];
		local current = p;
		local target = p;
		local distance = 0


		-- P = self
		-- E = enemy
		-- A = ally
		-- | = current

		-- |
		-- PEEAE000
		-- 01234567 distance


		while Board:IsValid(current) and 
			(Board:IsPawnSpace(current) or ((gapsRemaining > 0) and not Board:IsBlocked(current, PATH_FLYER))) do
			if not Board:IsPawnSpace(current) then
				gapsRemaining = gapsRemaining - 1
			end
			current = current + dirVector
			distance = distance + 1
		end
 
		--      |
		-- PEEAE000
		-- 01234567 distance

		current = current - dirVector
		distance = distance - 1

		--  current = last pawn (or self)		
		--     |
		-- PEEAE000
		-- 01234567 distance
		

		while (not Board:IsPawnTeam(current, TEAM_PLAYER)) and (current ~= p) do
			current = current - dirVector
			distance = distance - 1
		end

		local target = current
		local targetDistance = distance

		--  target (could be P) = last ally
		--    |
		-- PEEAE000
		-- 01234567 distance

		if (targetDistance > 1) then
			while (true) do
				
				-- ||||
				-- PEEAE000
				-- 01234567 distance

				--find animation direction
				local animationDirection = -1
				if(distance < targetDistance / 2) then
					animationDirection = dir
				elseif(distance > targetDistance / 2) then
					animationDirection = (dir + 2)%4
				end

				--animate if the direction isnt neutral
				if (animationDirection ~= -1) then
					local fakePunchTarget = current + DIR_VECTORS[animationDirection]
					local fake_punch = SpaceDamage(fakePunchTarget,0)
					effect:AddMelee(current,fake_punch, NO_DELAY)
				end
				
				--apply damage (not to self and target tho)
				if ((current ~= target) and (current ~= p)) then
					targetArea:push_back(current)
					if not Board:IsPawnTeam(current, TEAM_PLAYER) then
						effect:AddDamage(SpaceDamage(current,myDamage))

						if(Board:IsPawnTeam(current, TEAM_ENEMY)) then
							enemiesCount = enemiesCount + 1
						end
					end
				end

				if(current == p) then
					break
				end

				current = current - dirVector
				distance = distance - 1
			end
		end	

	end

	return effect, targetArea, enemiesCount
end

return nutellaman111_weaponsExposed