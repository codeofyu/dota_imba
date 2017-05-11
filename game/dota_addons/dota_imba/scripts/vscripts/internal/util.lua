function DebugPrint(...)
	--local spew = Convars:GetInt('barebones_spew') or -1
	--if spew == -1 and BAREBONES_DEBUG_SPEW then
	--spew = 1
	--end

	--if spew == 1 then
	--print(...)
	--end
end

function DebugPrintTable(...)
	--local spew = Convars:GetInt('barebones_spew') or -1
	--if spew == -1 and BAREBONES_DEBUG_SPEW then
	--spew = 1
	--end

	--if spew == 1 then
	--PrintTable(...)
	--end
end

function PrintTable(t, indent, done)
	--print ( string.format ('PrintTable type %s', type(keys)) )
	if type(t) ~= "table" then return end

	done = done or {}
	done[t] = true
	indent = indent or 0

	local l = {}
	for k, v in pairs(t) do
	table.insert(l, k)
	end

	table.sort(l)
	for k, v in ipairs(l) do
	-- Ignore FDesc
	if v ~= 'FDesc' then
		local value = t[v]

		if type(value) == "table" and not done[value] then
		done [value] = true
		print(string.rep ("\t", indent)..tostring(v)..":")
		PrintTable (value, indent + 2, done)
		elseif type(value) == "userdata" and not done[value] then
		done [value] = true
		print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
		PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
		else
		if t.FDesc and t.FDesc[v] then
			print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
		else
			print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
		end
		end
	end
	end
end

-- Colors
COLOR_NONE = '\x06'
COLOR_GRAY = '\x06'
COLOR_GREY = '\x06'
COLOR_GREEN = '\x0C'
COLOR_DPURPLE = '\x0D'
COLOR_SPINK = '\x0E'
COLOR_DYELLOW = '\x10'
COLOR_PINK = '\x11'
COLOR_RED = '\x12'
COLOR_LGREEN = '\x15'
COLOR_BLUE = '\x16'
COLOR_DGREEN = '\x18'
COLOR_SBLUE = '\x19'
COLOR_PURPLE = '\x1A'
COLOR_ORANGE = '\x1B'
COLOR_LRED = '\x1C'
COLOR_GOLD = '\x1D'

-- Returns a random value from a non-array table
function RandomFromTable(table)
	local array = {}
	local n = 0
	for _,v in pairs(table) do
		array[#array+1] = v
		n = n + 1
	end

	if n == 0 then return nil end

	return array[RandomInt(1,n)]
end

-- Turns an entindex string into a table and returns a table of handles.
-- Separator can only be a space (" ") or a comma (",").
function StringToTableEnt(string, separator)
	local gmatch_sign

	if separator == " " then
		gmatch_sign = "%S+"
	elseif separator == "," then
		gmatch_sign = "([^,]+)"
	end

	local return_table = {}
	for str in string.gmatch(string, gmatch_sign) do 		
		local handle = EntIndexToHScript(tonumber(str))
		table.insert(return_table, handle)
	end	

	return return_table
end

-- Turns a table of entity handles into entindex string separated by commas.
function TableToStringCommaEnt(table)	
	local string = ""
	local first_value = true

	for _,handle in pairs(table) do
		if first_value then
			string = string..tostring(handle:entindex())	
			first_value = false
		else
			string = string..","
			string = string..tostring(handle:entindex())	
		end		
	end

	return string
end

-------------------------------------------------------------------------------------------------
-- IMBA: custom utility functions
-------------------------------------------------------------------------------------------------

-- Returns the killstreak/deathstreak bonus gold for this hero
function GetKillstreakGold( hero )
	local base_bounty = HERO_KILL_GOLD_BASE + hero:GetLevel() * HERO_KILL_GOLD_PER_LEVEL
	local gold = ( hero.kill_streak_count ^ KILLSTREAK_EXP_FACTOR ) * HERO_KILL_GOLD_PER_KILLSTREAK - hero.death_streak_count * HERO_KILL_GOLD_PER_DEATHSTREAK
	
	-- Limits to maximum and minimum kill/deathstreak values
	gold = math.max(gold, (-1) * base_bounty * HERO_KILL_GOLD_DEATHSTREAK_CAP / 100 )
	gold = math.min(gold, base_bounty * ( HERO_KILL_GOLD_KILLSTREAK_CAP - 100 ) / 100)

	return gold
end

-- Picks a legal non-ultimate ability in Random OMG mode
function GetRandomNormalAbility()

	local ability = RandomFromTable(RANDOM_OMG_ABILITIES)
	
	return ability.ability_name, ability.owner_hero
end

-- Picks a legal ultimate ability in Random OMG mode
function GetRandomUltimateAbility()

	local ability = RandomFromTable(RANDOM_OMG_ULTIMATES)

	return ability.ability_name, ability.owner_hero
end

-- Picks a random tower ability of level in the interval [level - 1, level]
function GetRandomTowerAbility(tier)

	local ability

	if tier == 1 then		
			ability = RandomFromTable(TOWER_ABILITIES.tier_one)		
		
	elseif tier == 2 then		
			ability = RandomFromTable(TOWER_ABILITIES.tier_two)			
		
	elseif tier == 3 then		
			ability = RandomFromTable(TOWER_ABILITIES.tier_three)					
	
	elseif tier == 4 then		
			ability = RandomFromTable(TOWER_ABILITIES.active)		
	end

	return ability.ability_name
end

-- Returns the upgrade cost to a specific tower ability
function GetTowerAbilityUpgradeCost(ability_name, level)

	if level == 1 then
		return TOWER_ABILITIES[ability_name].cost1
	elseif level == 2 then
		return TOWER_ABILITIES[ability_name].cost2
	end
end

-- Grants a given hero an appropriate amount of Random OMG abilities
function ApplyAllRandomOmgAbilities( hero )

	-- If there's no valid hero, do nothing
	if not hero then
		return nil
	end

	-- Check if the high level power-up ability is present
	local ability_powerup = hero:FindAbilityByName("imba_unlimited_level_powerup")
	local powerup_stacks
	if ability_powerup then
		powerup_stacks = hero:GetModifierStackCount("modifier_imba_unlimited_level_powerup", hero)
		hero:RemoveModifierByName("modifier_imba_unlimited_level_powerup")
		ability_powerup = true
	end

	-- Remove default abilities
	for i = 0, 15 do
		local old_ability = hero:GetAbilityByIndex(i)
		if old_ability then
			hero:RemoveAbility(old_ability:GetAbilityName())
		end
	end

	-- Creates the table to store ability information for that hero
	if not hero.random_omg_abilities then
		hero.random_omg_abilities = {}
	end

	-- Initialize the precache list if necessary
	if not PRECACHED_HERO_LIST then
		PRECACHED_HERO_LIST = {}
	end

	-- Add new regular abilities
	local i = 1
	while i <= IMBA_RANDOM_OMG_NORMAL_ABILITY_COUNT do

		-- Randoms an ability from the list of legal random omg abilities
		local randomed_ability
		local ability_owner
		randomed_ability, ability_owner = GetRandomNormalAbility()

		-- Checks for duplicate abilities
		if not hero:FindAbilityByName(randomed_ability) then

			-- Add the ability
			hero:AddAbility(randomed_ability)

			-- Check if this hero has been precached before
			local is_precached = false
			for j = 1, #PRECACHED_HERO_LIST do
				if PRECACHED_HERO_LIST[j] == ability_owner then
					is_precached = true
				end
			end

			-- If not, do so and add it to the precached heroes list
			if not is_precached then
				PrecacheUnitWithQueue(ability_owner)
				table.insert(PRECACHED_HERO_LIST, ability_owner)
			end

			-- Store it for later reference
			hero.random_omg_abilities[i] = randomed_ability
			i = i + 1
		end
	end

	-- Add new ultimate abilities
	while i <= ( IMBA_RANDOM_OMG_NORMAL_ABILITY_COUNT + IMBA_RANDOM_OMG_ULTIMATE_ABILITY_COUNT ) do

		-- Randoms an ability from the list of legal random omg ultimates
		local randomed_ultimate
		local ultimate_owner
		randomed_ultimate, ultimate_owner = GetRandomUltimateAbility()

		-- Checks for duplicate abilities
		if not hero:FindAbilityByName(randomed_ultimate) then

			-- Add the ultimate
			hero:AddAbility(randomed_ultimate)

			-- Check if this hero has been precached before
			local is_precached = false
			for j = 1, #PRECACHED_HERO_LIST do
				if PRECACHED_HERO_LIST[j] == ultimate_owner then
					is_precached = true
				end
			end

			-- If not, do so and add it to the precached heroes list
			if not is_precached then
				PrecacheUnitByNameAsync(ultimate_owner, function(...) end)
				table.insert(PRECACHED_HERO_LIST, ultimate_owner)
			end

			-- Store it for later reference
			hero.random_omg_abilities[i] = randomed_ultimate
			i = i + 1
		end
	end

	-- Apply high level powerup ability, if previously existing
	if ability_powerup then
		hero:AddAbility("imba_unlimited_level_powerup")
		ability_powerup = hero:FindAbilityByName("imba_unlimited_level_powerup")
		ability_powerup:SetLevel(1)
		AddStacks(ability_powerup, hero, hero, "modifier_imba_unlimited_level_powerup", powerup_stacks, true)
	end

end

-- Randoms a hero not in the forbidden Random OMG hero pool
function PickValidHeroRandomOMG()

	local valid_heroes = {
		"npc_dota_hero_abaddon",
		"npc_dota_hero_alchemist",
		"npc_dota_hero_ancient_apparition",
		"npc_dota_hero_antimage",
		"npc_dota_hero_axe",
		"npc_dota_hero_bane",
		"npc_dota_hero_bounty_hunter",
		"npc_dota_hero_centaur",
		"npc_dota_hero_chaos_knight",
		"npc_dota_hero_crystal_maiden",
		"npc_dota_hero_dazzle",
		"npc_dota_hero_dragon_knight",
		"npc_dota_hero_drow_ranger",
		"npc_dota_hero_earthshaker",
		"npc_dota_hero_jakiro",
		"npc_dota_hero_juggernaut",
		"npc_dota_hero_kunkka",
		"npc_dota_hero_lich",
		"npc_dota_hero_lina",
		"npc_dota_hero_lion",
		"npc_dota_hero_luna",
		"npc_dota_hero_medusa",
		"npc_dota_hero_mirana",
		"npc_dota_hero_naga_siren",
		"npc_dota_hero_furion",
		"npc_dota_hero_necrolyte",
		"npc_dota_hero_obsidian_destroyer",
		"npc_dota_hero_omniknight",
		"npc_dota_hero_phantom_assassin",
		"npc_dota_hero_phantom_lancer",
		"npc_dota_hero_phoenix",
		"npc_dota_hero_puck",
		"npc_dota_hero_queenofpain",
		"npc_dota_hero_sand_king",
		"npc_dota_hero_shadow_demon",
		"npc_dota_hero_nevermore",
		"npc_dota_hero_slark",
		"npc_dota_hero_sniper",
		"npc_dota_hero_storm_spirit",
		"npc_dota_hero_sven",
		"npc_dota_hero_templar_assassin",
		"npc_dota_hero_terrorblade",
		"npc_dota_hero_tinker",
		"npc_dota_hero_ursa",
		"npc_dota_hero_vengefulspirit",
		"npc_dota_hero_venomancer",
		"npc_dota_hero_wisp",
		"npc_dota_hero_witch_doctor",
		"npc_dota_hero_zuus"
	}

	return valid_heroes[RandomInt(1, #valid_heroes)]
end

-- Checks if a hero is a valid pick in Random OMG
function IsValidPickRandomOMG( hero )

	local hero_name = hero:GetName()

	local valid_heroes = {
		"npc_dota_hero_abaddon",
		"npc_dota_hero_alchemist",
		"npc_dota_hero_ancient_apparition",
		"npc_dota_hero_antimage",
		"npc_dota_hero_axe",
		"npc_dota_hero_bane",
		"npc_dota_hero_bounty_hunter",
		"npc_dota_hero_centaur",
		"npc_dota_hero_chaos_knight",
		"npc_dota_hero_crystal_maiden",
		"npc_dota_hero_dazzle",
		"npc_dota_hero_dragon_knight",
		"npc_dota_hero_drow_ranger",
		"npc_dota_hero_earthshaker",
		"npc_dota_hero_jakiro",
		"npc_dota_hero_juggernaut",
		"npc_dota_hero_kunkka",
		"npc_dota_hero_lich",
		"npc_dota_hero_lina",
		"npc_dota_hero_lion",
		"npc_dota_hero_luna",
		"npc_dota_hero_medusa",
		"npc_dota_hero_mirana",
		"npc_dota_hero_naga_siren",
		"npc_dota_hero_furion",
		"npc_dota_hero_necrolyte",
		"npc_dota_hero_obsidian_destroyer",
		"npc_dota_hero_omniknight",
		"npc_dota_hero_phantom_assassin",
		"npc_dota_hero_phantom_lancer",
		"npc_dota_hero_phoenix",
		"npc_dota_hero_puck",
		"npc_dota_hero_queenofpain",
		"npc_dota_hero_sand_king",
		"npc_dota_hero_shadow_demon",
		"npc_dota_hero_nevermore",
		"npc_dota_hero_slark",
		"npc_dota_hero_sniper",
		"npc_dota_hero_storm_spirit",
		"npc_dota_hero_sven",
		"npc_dota_hero_templar_assassin",
		"npc_dota_hero_terrorblade",
		"npc_dota_hero_tinker",
		"npc_dota_hero_ursa",
		"npc_dota_hero_vengefulspirit",
		"npc_dota_hero_venomancer",
		"npc_dota_hero_wisp",
		"npc_dota_hero_witch_doctor",
		"npc_dota_hero_zuus"
	}

	for i = 1, #valid_heroes do
		if valid_heroes[i] == hero_name then
			return true
		end
	end

	return false
end

-- Removes undesired permanent modifiers in Random OMG mode
function RemovePermanentModifiersRandomOMG( hero )
	hero:RemoveModifierByName("modifier_imba_tidebringer_cooldown")
	hero:RemoveModifierByName("modifier_imba_hunter_in_the_night")
	hero:RemoveModifierByName("modifier_imba_dazzle_shallow_grave")
	hero:RemoveModifierByName("modifier_imba_dazzle_nothl_protection")
	hero:RemoveModifierByName("modifier_imba_shallow_grave_passive_cooldown")
	hero:RemoveModifierByName("modifier_imba_shallow_grave_passive_check")
	hero:RemoveModifierByName("modifier_imba_vendetta_damage_stacks")
	hero:RemoveModifierByName("modifier_imba_heartstopper_aura")
	hero:RemoveModifierByName("modifier_imba_antimage_spell_shield_passive")
	hero:RemoveModifierByName("modifier_imba_brilliance_aura")
	hero:RemoveModifierByName("modifier_imba_trueshot_aura_owner_hero")
	hero:RemoveModifierByName("modifier_imba_trueshot_aura_owner_creep")
	hero:RemoveModifierByName("modifier_imba_frost_nova_aura")
	hero:RemoveModifierByName("modifier_imba_moonlight_scepter_aura")
	hero:RemoveModifierByName("modifier_imba_sadist_aura")
	hero:RemoveModifierByName("modifier_imba_impale_aura")
	hero:RemoveModifierByName("modifier_imba_essence_aura")
	hero:RemoveModifierByName("modifier_imba_degen_aura")
	hero:RemoveModifierByName("modifier_imba_flesh_heap_aura")
	hero:RemoveModifierByName("modifier_borrowed_time")
	hero:RemoveModifierByName("attribute_bonus_str")
	hero:RemoveModifierByName("attribute_bonus_agi")
	hero:RemoveModifierByName("attribute_bonus_int")
	hero:RemoveModifierByName("modifier_imba_hook_sharp_stack")
	hero:RemoveModifierByName("modifier_imba_hook_light_stack")
	hero:RemoveModifierByName("modifier_imba_hook_caster")
	hero:RemoveModifierByName("modifier_imba_god_strength")
	hero:RemoveModifierByName("modifier_imba_god_strength_aura")
	hero:RemoveModifierByName("modifier_imba_god_strength_aura_scepter")
	hero:RemoveModifierByName("modifier_imba_warcry_passive_aura")
	hero:RemoveModifierByName("modifier_imba_great_cleave")
	hero:RemoveModifierByName("modifier_imba_blur")
	hero:RemoveModifierByName("modifier_imba_flesh_heap_aura")
	hero:RemoveModifierByName("modifier_imba_flesh_heap_stacks")
	hero:RemoveModifierByName("modifier_medusa_split_shot")
	hero:RemoveModifierByName("modifier_luna_lunar_blessing")
	hero:RemoveModifierByName("modifier_luna_lunar_blessing_aura")
	hero:RemoveModifierByName("modifier_luna_moon_glaive")
	hero:RemoveModifierByName("modifier_dragon_knight_dragon")
	hero:RemoveModifierByName("modifier_dragon_knight_dragon_blood")
	hero:RemoveModifierByName("modifier_zuus_static_field")
	hero:RemoveModifierByName("modifier_witchdoctor_voodoorestoration")
	hero:RemoveModifierByName("modifier_imba_land_mines_caster")
	hero:RemoveModifierByName("modifier_imba_purification_passive")
	hero:RemoveModifierByName("modifier_imba_purification_passive_cooldown")
	hero:RemoveModifierByName("modifier_imba_double_edge_prevent_deny")
	hero:RemoveModifierByName("modifier_imba_vampiric_aura")
	hero:RemoveModifierByName("modifier_imba_reincarnation_detector")
	hero:RemoveModifierByName("modifier_imba_time_walk_damage_counter")
	hero:RemoveModifierByName("modifier_charges")
	hero:RemoveModifierByName("modifier_imba_reincarnation")

	while hero:HasModifier("modifier_imba_flesh_heap_bonus") do
		hero:RemoveModifierByName("modifier_imba_flesh_heap_bonus")
	end
end

-- Precaches an unit, or, if something else is being precached, enters it into the precache queue
function PrecacheUnitWithQueue( unit_name )
	
	Timers:CreateTimer(0, function()

		-- If something else is being precached, wait two seconds
		if UNIT_BEING_PRECACHED then
			return 2

		-- Otherwise, start precaching and block other calls from doing so
		else
			UNIT_BEING_PRECACHED = true
			PrecacheUnitByNameAsync(unit_name, function(...) end)

			-- Release the queue after one second
			Timers:CreateTimer(2, function()
				UNIT_BEING_PRECACHED = false
			end)
		end
	end)
end

-- Initializes heroes' innate abilities
function InitializeInnateAbilities( hero )	

	-- Cycle through all of the heroes' abilities, and upgrade the innates ones
	for i = 0, 15 do		
		local current_ability = hero:GetAbilityByIndex(i)		
		if current_ability and current_ability.IsInnateAbility then
			if current_ability:IsInnateAbility() then
				current_ability:SetLevel(1)
			end
		end
	end
end

-- Upgrades a tower's abilities
function UpgradeTower( tower )

	local abilities = {}

	-- Fetch tower abilities
	for i = 0, 15 do
		local current_ability = tower:GetAbilityByIndex(i)
		if current_ability and current_ability:GetName() ~= "backdoor_protection" and current_ability:GetName() ~= "backdoor_protection_in_base" and current_ability:GetName() ~= "imba_tower_buffs" then
			abilities[#abilities+1] = current_ability
		end
	end

	-- Iterate through abilities to identify the upgradable one
	for i = 1,4 do

		-- If this ability is not maxed, try to upgrade it
		if abilities[i] and abilities[i]:GetLevel() < 3 then

			-- Upgrade ability
			abilities[i]:SetLevel( abilities[i]:GetLevel() + 1 )

			return nil

		-- If this ability is maxed and the last one, then add a new one
		elseif abilities[i] and abilities[i]:GetLevel() == 3 and #abilities == i then

			-- If there are no more abilities on the tree for this tower, do nothing
			if (tower.tower_tier <= 3 and i >= 3) or i >= 4 then
				return nil
			end

			-- Else, add a new ability from this game's ability tree
			local new_ability = false
			if tower.tower_tier == 1 then
				if tower.tower_lane == "safelane" then
					new_ability = TOWER_UPGRADE_TREE["safelane"]["tier_1"][i+1]
				elseif tower.tower_lane == "midlane" then
					new_ability = TOWER_UPGRADE_TREE["midlane"]["tier_1"][i+1]
				elseif tower.tower_lane == "hardlane" then
					new_ability = TOWER_UPGRADE_TREE["hardlane"]["tier_1"][i+1]
				end
			elseif tower.tower_tier == 2 then
				if tower.tower_lane == "safelane" then
					new_ability = TOWER_UPGRADE_TREE["safelane"]["tier_2"][i+1]
				elseif tower.tower_lane == "midlane" then
					new_ability = TOWER_UPGRADE_TREE["midlane"]["tier_2"][i+1]
				elseif tower.tower_lane == "hardlane" then
					new_ability = TOWER_UPGRADE_TREE["hardlane"]["tier_2"][i+1]
				end
			elseif tower.tower_tier == 3 then
				if tower.tower_lane == "safelane" then
					new_ability = TOWER_UPGRADE_TREE["safelane"]["tier_3"][i+1]
				elseif tower.tower_lane == "midlane" then
					new_ability = TOWER_UPGRADE_TREE["midlane"]["tier_3"][i+1]
				elseif tower.tower_lane == "hardlane" then
					new_ability = TOWER_UPGRADE_TREE["hardlane"]["tier_3"][i+1]
				end
			elseif tower.tower_tier == 41 then
				new_ability = TOWER_UPGRADE_TREE["midlane"]["tier_41"][i+1]
			elseif tower.tower_tier == 42 then
				new_ability = TOWER_UPGRADE_TREE["midlane"]["tier_42"][i+1]
			end

			-- Add the new ability
			if new_ability then
				tower:AddAbility(new_ability)
				new_ability = tower:FindAbilityByName(new_ability)
				new_ability:SetLevel(1)
			end

			return nil
		end
	end
end


-- Skeleton king cosmetics
function SkeletonKingWearables( hero )

	-- Cape
	Attachments:AttachProp(hero, "attach_head", "models/heroes/skeleton_king/wraith_king_cape.vmdl", 1.0)

	-- Shoulderpiece
	Attachments:AttachProp(hero, "attach_head", "models/heroes/skeleton_king/wraith_king_shoulder.vmdl", 1.0)

	-- Crown
	Attachments:AttachProp(hero, "attach_head", "models/heroes/skeleton_king/wraith_king_head.vmdl", 1.0)

	-- Gauntlet
	Attachments:AttachProp(hero, "attach_attack1", "models/heroes/skeleton_king/wraith_king_gauntlet.vmdl", 1.0)

	-- Weapon (randomly chosen)
	local random_weapon = {
		"models/items/skeleton_king/spine_splitter/spine_splitter.vmdl",
		"models/items/skeleton_king/regalia_of_the_bonelord_sword/regalia_of_the_bonelord_sword.vmdl",
		"models/items/skeleton_king/weapon_backbone.vmdl",
		"models/items/skeleton_king/the_blood_shard/the_blood_shard.vmdl",
		"models/items/skeleton_king/sk_dragon_jaw/sk_dragon_jaw.vmdl",
		"models/items/skeleton_king/weapon_spine_sword.vmdl",
		"models/items/skeleton_king/shattered_destroyer/shattered_destroyer.vmdl"
	}
	Attachments:AttachProp(hero, "attach_attack1", random_weapon[RandomInt(1, #random_weapon)], 1.0)

	-- Eye particles
	local eye_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/skeletonking_eyes.vpcf", PATTACH_ABSORIGIN, hero)
	ParticleManager:SetParticleControlEnt(eye_pfx, 0, hero, PATTACH_POINT_FOLLOW, "attach_eyeL", hero:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(eye_pfx, 1, hero, PATTACH_POINT_FOLLOW, "attach_eyeR", hero:GetAbsOrigin(), true)
end

-- Randoms an ability of a certain tier for the Ancient
function GetAncientAbility( tier )

	-- Tier 1 abilities
	if tier == 1 then
		local ability_list = {
			"venomancer_poison_nova"
		}

		return ability_list[RandomInt(1, #ability_list)]

	-- Tier 2 abilities
	elseif tier == 2 then
		local ability_list = {
			"abaddon_borrowed_time",
			"nyx_assassin_spiked_carapace",
			"axe_berserkers_call"
		}

		return ability_list[RandomInt(1, #ability_list)]

	-- Tier 3 abilities
	elseif tier == 3 then
		local ability_list = {
			"treant_overgrowth",
			"tidehunter_ravage",
			"magnataur_reverse_polarity"
		}

		return ability_list[RandomInt(1, #ability_list)]
	end
	
	return nil
end


-- Initialize Physics library on this target
function InitializePhysicsParameters(unit)

	if not IsPhysicsUnit(unit) then
		Physics:Unit(unit)
		unit:SetPhysicsVelocityMax(600)
		unit:PreventDI()
	end
end

-- Spawns runes on the map
function SpawnImbaRunes()

	-- Locate the rune spots on the map
	local bounty_rune_spawner_a = Entities:FindAllByName("bounty_rune_location_dire_bot")
	local bounty_rune_spawner_b = Entities:FindAllByName("bounty_rune_location_dire_top")
	local bounty_rune_spawner_c = Entities:FindAllByName("bounty_rune_location_radiant_bot")
	local bounty_rune_spawner_d = Entities:FindAllByName("bounty_rune_location_radiant_top")
	local powerup_rune_spawner_a = Entities:FindAllByName("powerup_rune_location_bot")
	local powerup_rune_spawner_b = Entities:FindAllByName("powerup_rune_location_top")
	local bounty_rune_locations = {
		bounty_rune_spawner_a[1]:GetAbsOrigin(),
		bounty_rune_spawner_b[1]:GetAbsOrigin(),
		bounty_rune_spawner_c[1]:GetAbsOrigin(),
		bounty_rune_spawner_d[1]:GetAbsOrigin()
	}
	local powerup_rune_locations = {
		powerup_rune_spawner_a[1]:GetAbsOrigin(),
		powerup_rune_spawner_b[1]:GetAbsOrigin()
	}

	-- Spawn bounty runes
	local game_time = GameRules:GetDOTATime(false, false)
	for _, bounty_loc in pairs(bounty_rune_locations) do
		local bounty_rune = CreateItem("item_imba_rune_bounty", nil, nil)
		CreateItemOnPositionForLaunch(bounty_loc, bounty_rune)

		-- If these are the 00:00 runes, double their worth
		if game_time < 1 then
			bounty_rune.is_initial_bounty_rune = true
		end
	end

	-- List of powerup rune types
	local powerup_rune_types = {
		"item_imba_rune_double_damage",
		"item_imba_rune_haste",
		"item_imba_rune_regeneration"
	}

	-- Spawn a random powerup rune in a random powerup location
	if game_time > 1 then
		CreateItemOnPositionForLaunch(powerup_rune_locations[RandomInt(1, #powerup_rune_locations)], CreateItem(powerup_rune_types[RandomInt(1, #powerup_rune_types)], nil, nil))
	end
end

-- Spawns runes on the arena map
function SpawnArenaRunes()

	-- Locate the rune spots on the map
	local powerup_rune_spawner = Entities:FindAllByName("powerup_rune_spawner")
	powerup_rune_spawner = powerup_rune_spawner[1]:GetAbsOrigin()

	-- Decide what type of rune to spawn
	if not ARENA_RUNE_COUNTER then
		ARENA_RUNE_COUNTER = 3
	end
	ARENA_RUNE_COUNTER = ARENA_RUNE_COUNTER + 1

	-- Spawn bounty rune
	if ARENA_RUNE_COUNTER < 4 then
	
		local bounty_rune = CreateItem("item_imba_rune_bounty_arena", nil, nil)
		CreateItemOnPositionForLaunch(powerup_rune_spawner, bounty_rune)
		bounty_rune:LaunchLoot(false, 200, 0.4, powerup_rune_spawner + RandomVector(1) * RandomInt(200, 400))

	-- Spawn powerup rune
	else

		-- List of powerup rune types
		local powerup_rune_types = {
			"item_imba_rune_double_damage",
			"item_imba_rune_haste",
			"item_imba_rune_regeneration"
		}

		-- Spawn a random powerup rune
		CreateItemOnPositionForLaunch(powerup_rune_spawner, CreateItem(powerup_rune_types[RandomInt(1, #powerup_rune_types)], nil, nil))
		ARENA_RUNE_COUNTER = 0
	end
end

-- Picks up a bounty rune
function PickupBountyRune(item, unit)

	-- Bounty rune parameters
	local base_bounty = 50
	local bounty_per_minute = 5
	local game_time = GameRules:GetDOTATime(false, false)
	local current_bounty = base_bounty + bounty_per_minute * game_time / 60

	-- If this is the first bounty rune spawn, double the base bounty
	if item.is_initial_bounty_rune then
		current_bounty = current_bounty  * 2
	end

	-- Adjust value for lobby options
	current_bounty = current_bounty * (1 + CUSTOM_GOLD_BONUS * 0.01)

	-- Grant the unit experience
	unit:AddExperience(current_bounty, DOTA_ModifyXP_CreepKill, false, true)

	-- If this is alchemist, increase the gold amount
	if unit:FindAbilityByName("imba_alchemist_goblins_greed") and unit:FindAbilityByName("imba_alchemist_goblins_greed"):GetLevel() > 0 then
		current_bounty = current_bounty * unit:FindAbilityByName("imba_alchemist_goblins_greed"):GetSpecialValueFor("bounty_multiplier")

		-- #7 Talent: Doubles gold from bounty runes
		if unit:HasTalent("special_bonus_imba_alchemist_7") then
			current_bounty = current_bounty * unit:FindTalentValue("special_bonus_imba_alchemist_7")
		end
	end

	-- Grant the unit gold
	unit:ModifyGold(current_bounty, false, DOTA_ModifyGold_CreepKill)

	-- Show the gold gained message to everyone
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD, unit, current_bounty, nil)

	-- Play the gold gained sound
	unit:EmitSound("General.Coins")

	-- Play the bounty rune activation sound to the unit's team
	EmitSoundOnLocationForAllies(unit:GetAbsOrigin(), "Rune.Bounty", unit)
end

-- Picks up a haste rune
function PickupHasteRune(item, unit)

	-- Apply the aura modifier to the owner
	item:ApplyDataDrivenModifier(unit, unit, "modifier_imba_rune_haste_owner", {})

	-- Apply the movement speed increase modifier to the owner
	local duration = item:GetSpecialValueFor("duration")
	unit:AddNewModifier(unit, item, "modifier_imba_haste_rune_speed_limit_break", {duration = duration})

	-- Play the haste rune activation sound to the unit's team
	EmitSoundOnLocationForAllies(unit:GetAbsOrigin(), "Rune.Haste", unit)
end

-- Picks up a double damage rune
function PickupDoubleDamageRune(item, unit)

	-- Apply the aura modifier to the owner
	item:ApplyDataDrivenModifier(unit, unit, "modifier_imba_rune_double_damage_owner", {})

	-- Play the double damage rune activation sound to the unit's team
	EmitSoundOnLocationForAllies(unit:GetAbsOrigin(), "Rune.DD", unit)
end

-- Picks up a regeneration rune
function PickupRegenerationRune(item, unit)

	-- Apply the aura modifier to the owner
	item:ApplyDataDrivenModifier(unit, unit, "modifier_imba_rune_regeneration_owner", {})

	-- Play the double damage rune activation sound to the unit's team
	EmitSoundOnLocationForAllies(unit:GetAbsOrigin(), "Rune.Regen", unit)
end

-- Talents modifier function
function ApplyAllTalentModifiers()
	Timers:CreateTimer(0.1,function()
		local current_hero_list = HeroList:GetAllHeroes()
		for k,v in pairs(current_hero_list) do
			local hero_name = string.match(v:GetName(),"npc_dota_hero_(.*)")
			for i = 1, 8 do
				local talent_name = "special_bonus_imba_"..hero_name.."_"..i
				local modifier_name = "modifier_special_bonus_imba_"..hero_name.."_"..i
				if v:HasTalent(talent_name) and not v:HasModifier(modifier_name) then
					v:AddNewModifier(v,v,modifier_name,{})
				end
			end
		end
		return 0.5
	end)
end

function NetTableM(tablename,keyname,...) 
	local values = {...}                                                                  -- Our user input
	local returnvalues = {}                                                               -- table that will be unpacked for result                                                    
	for k,v in ipairs(values) do  
		local keyname = keyname..v[1]                                                       -- should be 1-8, but probably can be extrapolated later on to be any number
		if IsServer() then
			local netTableKey = netTableCmd(false,tablename,keyname)                              -- Command to grab our key set
			local my_key = createNetTableKey(v)                                               -- key = 250,444,111 as table, stored in key as 1 2 3
			if not netTableKey then                                                           -- No key with requested name exists
				netTableCmd(true,tablename,keyname,my_key)                                          -- create database key with "tablename","myHealth1","1=250,2=444,3=111"
			elseif type(netTableKey) == 'boolean' then                                        -- Our check returned that a key exists but that it is empty, we need to populate it for clients
				netTableCmd(true,tablename,keyname,my_key)                                          -- create database key with "tablename","myHealth1","1=250,2=444,3=111"
			else                                                                              -- Our key exists and we got some values, now we need to check the key against the requested value from other scripts  
				if #v > 1 then
					for i=1,#netTableKey do
						if netTableKey[i] ~= v[i-1] then                                              -- compare each value, does server 1 = our 250? does server 2 = our 444? 
							netTableCmd(true,tablename,keyname,my_key)                                      -- If our key is different from the sent value, rewrite it ONCE and break execution to main loop again
							break
						end
					end
				end
			end      
		end
		local allkeys = netTableCmd(false,tablename,keyname)
		if allkeys and type(allkeys) ~= 'boolean' then
			for i=1,#allkeys do
				table.insert(returnvalues, allkeys[i])    
			end
		else
			for i=1,#v do
				table.insert(returnvalues, 0)
			end
		end
	end
return unpack(returnvalues)
end

function netTableCmd(send,readtable,key,tabletosend)
	if send == false then
		local finalresulttable = {}
		local nettabletemp = CustomNetTables:GetTableValue(readtable,key)
		if not nettabletemp then return false end
		for key,value in pairs(nettabletemp) do
			table.insert(finalresulttable,value)
		end          
		if #finalresulttable > 0 then 
			return finalresulttable
		else
			return true
		end
	else
		CustomNetTables:SetTableValue(readtable, key, tabletosend)
	end
end

function createNetTableKey(v)
	local valuePair = {}
	if #v > 1 then
		for i=2,#v do
			table.insert(valuePair,v[i])                                              -- returns just numbers 2-x from sent value...
		end    
	end
	return valuePair  
end

function getkvValues(tEntity, ...) -- KV Values look hideous in finished code, so this function will parse through all sent KV's for tEntity (typically self)
	local values = {...}
	local data = {}
	for i,v in ipairs(values) do
		table.insert(data,tEntity:GetSpecialValueFor(v))
	end
	return unpack(data)
end

function TalentManager(tEntity, nameScheme, ...)
	local talents = {...}
	local return_values = {}
	for k,v in pairs(talents) do    
		if #v > 1 then
			for i=1,#v do
				table.insert(return_values, tEntity:FindSpecificTalentValue(nameScheme..v[1],v[i]))
			end
		else
			table.insert(return_values, tEntity:FindTalentValue(nameScheme..v[1]))
		end
	end    
return unpack(return_values)
end

function findtarget(source) -- simple list return function for finding a players current target entity
	local t = source:GetCursorTarget()
	local c = source:GetCaster()
	if t and c then return t,c end
end

function findgroundtarget(source) -- simple list return function for finding a players current target entity
	local t = source:GetCursorPosition()
	local c = source:GetCaster()
	if t and c then return t,c end
end

-- Controls comeback gold
function UpdateComebackBonus(points, team)

	-- Calculate both teams' networths
	local team_networth = {}
	team_networth[DOTA_TEAM_GOODGUYS] = 0
	team_networth[DOTA_TEAM_BADGUYS] = 0
	for player_id = 0, 19 do
		if PlayerResource:IsImbaPlayer(player_id) and PlayerResource:GetConnectionState(player_id) <= 2 and (not PlayerResource:GetHasAbandonedDueToLongDisconnect(player_id)) then
			team_networth[PlayerResource:GetTeam(player_id)] = team_networth[PlayerResource:GetTeam(player_id)] + PlayerResource:GetTotalEarnedGold(player_id)
		end
	end

	-- Update teams' score
	if COMEBACK_BOUNTY_SCORE[team] == nil then
		COMEBACK_BOUNTY_SCORE[team] = 0
	end
	
	COMEBACK_BOUNTY_SCORE[team] = COMEBACK_BOUNTY_SCORE[team] + points

	-- If one of the teams is eligible, apply the bonus
	if (COMEBACK_BOUNTY_SCORE[DOTA_TEAM_GOODGUYS] < COMEBACK_BOUNTY_SCORE[DOTA_TEAM_BADGUYS]) and (team_networth[DOTA_TEAM_GOODGUYS] < team_networth[DOTA_TEAM_BADGUYS]) then
		COMEBACK_BOUNTY_BONUS[DOTA_TEAM_GOODGUYS] = (COMEBACK_BOUNTY_SCORE[DOTA_TEAM_BADGUYS] - COMEBACK_BOUNTY_SCORE[DOTA_TEAM_GOODGUYS]) / ( COMEBACK_BOUNTY_SCORE[DOTA_TEAM_GOODGUYS] + 60 - GameRules:GetDOTATime(false, false) / 60 )
	elseif (COMEBACK_BOUNTY_SCORE[DOTA_TEAM_BADGUYS] < COMEBACK_BOUNTY_SCORE[DOTA_TEAM_GOODGUYS]) and (team_networth[DOTA_TEAM_BADGUYS] < team_networth[DOTA_TEAM_GOODGUYS]) then
		COMEBACK_BOUNTY_BONUS[DOTA_TEAM_BADGUYS] = (COMEBACK_BOUNTY_SCORE[DOTA_TEAM_GOODGUYS] - COMEBACK_BOUNTY_SCORE[DOTA_TEAM_BADGUYS]) / ( COMEBACK_BOUNTY_SCORE[DOTA_TEAM_BADGUYS] + 60 - GameRules:GetDOTATime(false, false) / 60 )
	end
end

-- Arena control point logic
function ArenaControlPointThinkRadiant(control_point)

	-- Create the control point particle, if this is the first iteration
	if not control_point.particle then
		control_point.particle = ParticleManager:CreateParticle("particles/customgames/capturepoints/cp_allied_wind.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(control_point.particle, 0, control_point:GetAbsOrigin())
	end

	-- Check how many heroes are near the control point
	local allied_heroes = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, control_point:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
	local enemy_heroes = FindUnitsInRadius(DOTA_TEAM_BADGUYS, control_point:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
	local score_change = #allied_heroes - #enemy_heroes

	-- Calculate the new score
	local old_score = control_point.score
	control_point.score = math.max(math.min(control_point.score + score_change, 20), -20)

	-- If this control point changed disposition, update the UI and particle accordingly
	if old_score >= 0 and control_point.score < 0 then
		CustomGameEventManager:Send_ServerToAllClients("radiant_point_to_dire", {})
		ParticleManager:DestroyParticle(control_point.particle, true)
		control_point.particle = ParticleManager:CreateParticle("particles/customgames/capturepoints/cp_wind_captured.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(control_point.particle, 0, control_point:GetAbsOrigin())
		control_point:EmitSound("Imba.ControlPointTaken")
	elseif old_score < 0 and control_point.score >= 0 then
		CustomGameEventManager:Send_ServerToAllClients("radiant_point_to_radiant", {})
		ParticleManager:DestroyParticle(control_point.particle, true)
		control_point.particle = ParticleManager:CreateParticle("particles/customgames/capturepoints/cp_allied_wind.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(control_point.particle, 0, control_point:GetAbsOrigin())
		control_point:EmitSound("Imba.ControlPointTaken")
	end

	-- Update the progress bar
	CustomNetTables:SetTableValue("arena_capture", "radiant_progress", {control_point.score})
	CustomGameEventManager:Send_ServerToAllClients("radiant_progress_update", {})

	-- Run this function again after a second
	Timers:CreateTimer(1, function()
		ArenaControlPointThinkRadiant(control_point)
	end)
end

function ArenaControlPointThinkDire(control_point)

	-- Create the control point particle, if this is the first iteration
	if not control_point.particle then
		control_point.particle = ParticleManager:CreateParticle("particles/customgames/capturepoints/cp_metal_captured.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(control_point.particle, 0, control_point:GetAbsOrigin())
	end

	-- Check how many heroes are near the control point
	local allied_heroes = FindUnitsInRadius(DOTA_TEAM_BADGUYS, control_point:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
	local enemy_heroes = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, control_point:GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
	local score_change = #allied_heroes - #enemy_heroes

	-- Calculate the new score
	local old_score = control_point.score
	control_point.score = math.max(math.min(control_point.score + score_change, 20), -20)

	-- If this control point changed disposition, update the UI and particle accordingly
	if old_score >= 0 and control_point.score < 0 then
		CustomGameEventManager:Send_ServerToAllClients("dire_point_to_radiant", {})
		ParticleManager:DestroyParticle(control_point.particle, true)
		control_point.particle = ParticleManager:CreateParticle("particles/customgames/capturepoints/cp_allied_metal.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(control_point.particle, 0, control_point:GetAbsOrigin())
		control_point:EmitSound("Imba.ControlPointTaken")
	elseif old_score < 0 and control_point.score >= 0 then
		CustomGameEventManager:Send_ServerToAllClients("dire_point_to_dire", {})
		ParticleManager:DestroyParticle(control_point.particle, true)
		control_point.particle = ParticleManager:CreateParticle("particles/customgames/capturepoints/cp_metal_captured.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(control_point.particle, 0, control_point:GetAbsOrigin())
		control_point:EmitSound("Imba.ControlPointTaken")
	end

	-- Update the progress bar
	CustomNetTables:SetTableValue("arena_capture", "dire_progress", {control_point.score})
	CustomGameEventManager:Send_ServerToAllClients("dire_progress_update", {})

	-- Run this function again after a second
	Timers:CreateTimer(1, function()
		ArenaControlPointThinkDire(control_point)
	end)
end

function ArenaControlPointScoreThink(radiant_cp, dire_cp)

	-- Fetch current scores
	local radiant_score = CustomNetTables:GetTableValue("arena_capture", "radiant_score")
	local dire_score = CustomNetTables:GetTableValue("arena_capture", "dire_score")

	-- Update scores
	if radiant_cp.score >= 0 then
		radiant_score["1"] = radiant_score["1"] + 1
	else
		dire_score["1"] = dire_score["1"] + 1
	end
	if dire_cp.score >= 0 then
		dire_score["1"] = dire_score["1"] + 1
	else
		radiant_score["1"] = radiant_score["1"] + 1
	end

	-- Set new values
	CustomNetTables:SetTableValue("arena_capture", "radiant_score", {radiant_score["1"]})
	CustomNetTables:SetTableValue("arena_capture", "dire_score", {dire_score["1"]})

	-- Update scoreboard
	CustomGameEventManager:Send_ServerToAllClients("radiant_score_update", {})
	CustomGameEventManager:Send_ServerToAllClients("dire_score_update", {})

	-- Check if one of the teams won the game
	if radiant_score["1"] >= KILLS_TO_END_GAME_FOR_TEAM then
		GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
		GAME_WINNER_TEAM = "Radiant"
	elseif dire_score["1"] >= KILLS_TO_END_GAME_FOR_TEAM then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		GAME_WINNER_TEAM = "Dire"
	end

	-- Call this function again after 10 seconds
	Timers:CreateTimer(10, function()
		ArenaControlPointScoreThink(radiant_cp, dire_cp)
	end)
end

-------------------------------------------------------------------------------------------------------
-- Client side daytime tracking system
-------------------------------------------------------------------------------------------------------

function StoreCurrentDayCycle()	
	Timers:CreateTimer(function()		

		-- Get current daytime cycle
		local is_day = GameRules:IsDaytime()		

		-- Set in the table
		CustomNetTables:SetTableValue("gamerules", "isdaytime", {is_day = is_day} )		

	-- Repeat
	return 0.5
	end)	
end

function IsDaytime()
    if CustomNetTables:GetTableValue("gamerules", "isdaytime") then
        if CustomNetTables:GetTableValue("gamerules", "isdaytime").is_day then  
            local is_day = CustomNetTables:GetTableValue("gamerules", "isdaytime").is_day  

            if is_day == 1 then
                return true
            else
                return false
            end
        end
    end

    return true   
end