-- Copyright (C) 2018  The Dota IMBA Development Team
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

CUSTOM_GAME_TYPE = "IMBA"

GAME_VERSION = "7.15"
CustomNetTables:SetTableValue("game_options", "game_version", {value = GAME_VERSION})
CustomNetTables:SetTableValue("game_options", "gamemode", {1})

-- Picking screen constants
PICKING_SCREEN_OVER = false
CAPTAINS_MODE_CAPTAIN_TIME = 20		-- how long players have to claim the captain chair
CAPTAINS_MODE_PICK_BAN_TIME = 30	-- how long you have to do each pick/ban
CAPTAINS_MODE_HERO_PICK_TIME = 30	-- time to choose which hero you're going to play
CAPTAINS_MODE_RESERVE_TIME = 130	-- total bonus time that can be used throughout any selection

-- IMBA constants
IMBA_REINCARNATION_TIME = 3.0
IMBA_MAX_RESPAWN_TIME = 50.0		-- Maximum respawn time, does not include bonus reaper scythe duration
IMBA_RESPAWN_TIME_PCT = 50			-- Percentage of the respawn time from vanilla respawn time

RUNE_SPAWN_TIME = 120				-- How long in seconds should we wait between rune spawns?
BOUNTY_RUNE_SPAWN_TIME = 300
if IsInToolsMode() then
	BOTS_ENABLED = false
else
	BOTS_ENABLED = false
end

-- Barebones constants
AUTO_LAUNCH_DELAY = 5.0
STRATEGY_TIME = 0.0					-- How long should strategy time last?
SHOWCASE_TIME = 0.0					-- How long should showcase time last?
AP_BAN_TIME = 10.0
if IsInToolsMode() or GetMapName() == "imba_demo" then
	AP_BAN_TIME = 0.0
	SHOWCASE_TIME = 0.0
end
AP_GAME_TIME = 60.0
if GetMapName() == MapOverthrow() or GetMapName() == "imba_demo" then
	PRE_GAME_TIME = 10.0 + AP_GAME_TIME
else
	PRE_GAME_TIME = 90 + AP_GAME_TIME	-- How long after people select their heroes should the horn blow and the game start?
end
TREE_REGROW_TIME = 180.0				-- How long should it take individual trees to respawn after being cut down/destroyed?
POST_GAME_TIME = 600.0					-- How long should we let people look at the scoreboard before closing the server automatically?
CAMERA_DISTANCE_OVERRIDE = -1
GOLD_PER_TICK = 1

USE_AUTOMATIC_PLAYERS_PER_TEAM = false		-- Should we set the number of players to 10 / MAX_NUMBER_OF_TEAMS?
UNIVERSAL_SHOP_MODE = false 				-- Should the main shop contain Secret Shop items as well as regular items
if IsInToolsMode() then
	UNIVERSAL_SHOP_MODE = true
end
USE_STANDARD_HERO_GOLD_BOUNTY = false

MINIMAP_ICON_SIZE = 1						-- What icon size should we use for our heroes?
MINIMAP_CREEP_ICON_SIZE = 1					-- What icon size should we use for creeps?
MINIMAP_RUNE_ICON_SIZE = 1					-- What icon size should we use for runes?

-- TODO: Set back to true and fix it
CUSTOM_BUYBACK_COST_ENABLED = false			-- Should we use a custom buyback cost setting?
CUSTOM_BUYBACK_COOLDOWN_ENABLED = true		-- Should we use a custom buyback time?
BUYBACK_ENABLED = true						-- Should we allow people to buyback when they die?

USE_NONSTANDARD_HERO_GOLD_BOUNTY = false	-- Should heroes follow their own gold bounty rules instead of the default DOTA ones?
USE_NONSTANDARD_HERO_XP_BOUNTY = true		-- Should heroes follow their own XP bounty rules instead of the default DOTA ones?

ENABLE_TOWER_BACKDOOR_PROTECTION = true		-- Should we enable backdoor protection for our towers?
REMOVE_ILLUSIONS_ON_DEATH = false			-- Should we remove all illusions if the main hero dies?
DISABLE_GOLD_SOUNDS = false					-- Should we disable the gold sound when players get gold?

ENABLE_FIRST_BLOOD = true					-- Should we enable first blood for the first kill in this game?
HIDE_KILL_BANNERS = false					-- Should we hide the kill banners that show when a player is killed?
LOSE_GOLD_ON_DEATH = true					-- Should we have players lose the normal amount of dota gold on death?
FORCE_PICKED_HERO = "npc_dota_hero_dummy_dummy"		-- What hero should we force all players to spawn as? (e.g. "npc_dota_hero_axe").  Use nil to allow players to pick their own hero.

MAXIMUM_ATTACK_SPEED = 1000					-- What should we use for the maximum attack speed?
MINIMUM_ATTACK_SPEED = 0					-- What should we use for the minimum attack speed?

-------------------------------------------------------------------------------------------------
-- IMBA: gameplay globals
-------------------------------------------------------------------------------------------------

BUYBACK_COOLDOWN_ENABLED = true												-- Is the buyback cooldown enabled?

BUYBACK_BASE_COST = 100														-- Base cost to buyback
BUYBACK_COST_PER_LEVEL = 1.25												-- Level-based buyback cost
BUYBACK_COST_PER_LEVEL_AFTER_25 = 20										-- Level-based buyback cost growth after level 25
BUYBACK_COST_PER_SECOND = 0.25												-- Time-based buyback cost

BUYBACK_COOLDOWN_MAXIMUM = 180												-- Maximum buyback cooldown

BUYBACK_RESPAWN_PENALTY	= 15												-- Increased respawn time when dying after a buyback

ABANDON_TIME = 180															-- Time for a player to be considered as having abandoned the game (in seconds)
FULL_ABANDON_TIME = 15														-- Time for a team to be considered as having abandoned the game (in seconds)

GAME_ROSHAN_KILLS = 0														-- Tracks amount of Roshan kills
ROSHAN_RESPAWN_TIME_MIN = 3
ROSHAN_RESPAWN_TIME_MAX = 6													-- Roshan respawn timer (in minutes)
AEGIS_DURATION = 300														-- Aegis expiration timer (in seconds)
IMBA_ROSHAN_GOLD_KILL_MIN = 150
IMBA_ROSHAN_GOLD_KILL_MAX = 400
IMBA_ROSHAN_GOLD_ASSIST = 150

IMBA_DAMAGE_EFFECTS_DISTANCE_CUTOFF = 2500									-- Range at which most on-damage effects no longer trigger

-------------------------------------------------------------------------------------------------
-- IMBA: map-based settings
-------------------------------------------------------------------------------------------------

MAX_NUMBER_OF_TEAMS = 2														-- How many potential teams can be in this game mode?
IMBA_PLAYERS_ON_GAME = 10													-- Number of players in the game
USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS = false									-- Should we use custom team colors to color the players/minimap?

PLAYER_COLORS = {}															-- Stores individual player colors
PLAYER_COLORS[0] = { 67, 133, 255 }
PLAYER_COLORS[1]  = { 170, 255, 195 }
PLAYER_COLORS[2] = { 130, 0, 150 }
PLAYER_COLORS[3] = { 255, 234, 0 }
PLAYER_COLORS[4] = { 255, 153, 0 }
PLAYER_COLORS[5] = { 190, 255, 0 }
PLAYER_COLORS[6] = { 255, 0, 0 }
PLAYER_COLORS[7] = { 0, 128, 128 }
PLAYER_COLORS[8] = { 255, 250, 200 }
PLAYER_COLORS[9] = { 49, 49, 49 }

TEAM_COLORS = {}															-- If USE_CUSTOM_TEAM_COLORS is set, use these colors.
TEAM_COLORS[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }							-- Teal
TEAM_COLORS[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }							-- Yellow

CUSTOM_TEAM_PLAYER_COUNT = {}
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 5
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 5

if GetMapName() == Map1v1() then
	IMBA_PLAYERS_ON_GAME = 2
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 1
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 1
	IMBA_1V1_SCORE = 3
	PRE_GAME_TIME = 30.0 + AP_GAME_TIME
elseif string.find(GetMapName(), "10v10") then
	IMBA_PLAYERS_ON_GAME = 20
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 10
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 10

	PLAYER_COLORS[10] = { 255, 0, 255 }
	PLAYER_COLORS[11]  = { 128, 128, 0 }
	PLAYER_COLORS[12] = { 100, 255, 255 }
	PLAYER_COLORS[13] = { 0, 190, 0 }
	PLAYER_COLORS[14] = { 170, 110, 40 }
	PLAYER_COLORS[15] = { 0, 0, 128 }
	PLAYER_COLORS[16] = { 230, 190, 255 }
	PLAYER_COLORS[17] = { 128, 0, 0 }
	PLAYER_COLORS[18] = { 144, 144, 144 }
	PLAYER_COLORS[19] = { 254, 254, 254 }
	PLAYER_COLORS[20] = { 166, 166, 166 }
	PLAYER_COLORS[21] = { 255, 89, 255 }
	PLAYER_COLORS[22] = { 203, 255, 89 }
	PLAYER_COLORS[23] = { 108, 167, 255 }
end

-------------------------------------------------------------------------------------------------
-- IMBA: game mode globals
-------------------------------------------------------------------------------------------------
GAME_WINNER_TEAM = 0														-- Tracks game winner
GG_TEAM = {}
GG_TEAM[2] = 0
GG_TEAM[3] = 0

IMBA_FRANTIC_RESPAWN_REDUCTION_PCT = 16
IMBA_BASE_FRANTIC_VALUE = 25
IMBA_SUPER_FRANTIC_VALUE = 40 -- Do not exceed 40% EVER, causing many broken spells to be used permanently
CustomNetTables:SetTableValue("game_options", "frantic", {frantic = IMBA_BASE_FRANTIC_VALUE, super_frantic = IMBA_SUPER_FRANTIC_VALUE})

IMBA_FRANTIC_VALUE = IMBA_BASE_FRANTIC_VALUE

IMBA_PICK_MODE_ALL_PICK = true												-- Activates All Pick mode when true
IMBA_PICK_MODE_ALL_RANDOM = false											-- Activates All Random mode when true
IMBA_PICK_MODE_ALL_RANDOM_SAME_HERO = false									-- Activates All Random Same Hero mode when true
IMBA_ALL_RANDOM_HERO_SELECTION_TIME = 5.0									-- Time we need to wait before the game starts when all heroes are randomed

-- Global Gold earning, values are doubled with Hyper for non-custom maps
local global_gold = 250
CUSTOM_GOLD_BONUS = {} -- 1 = Normal, 2 = Hyper
CUSTOM_GOLD_BONUS[Map1v1()] = global_gold
CUSTOM_GOLD_BONUS["imba_5v5"] = global_gold
CUSTOM_GOLD_BONUS[MapRanked5v5()] = global_gold
CUSTOM_GOLD_BONUS[MapRanked10v10()] = global_gold
CUSTOM_GOLD_BONUS["imba_10v10"] = global_gold
CUSTOM_GOLD_BONUS[MapTournament()] = global_gold
CUSTOM_GOLD_BONUS[MapOverthrow()] = global_gold
CUSTOM_GOLD_BONUS[MapDiretide()] = global_gold
CUSTOM_GOLD_BONUS["imba_demo"] = global_gold

-- Global XP earning, values are doubled with Hyper for non-custom maps (right now this is not used anymore, but i'll keep it there just in case)
local global_xp = 300
CUSTOM_XP_BONUS = {} -- 1 = Normal, 2 = Hyper
CUSTOM_XP_BONUS[Map1v1()] = global_xp
CUSTOM_XP_BONUS["imba_5v5"] = global_xp
CUSTOM_XP_BONUS[MapRanked5v5()] = global_xp
CUSTOM_XP_BONUS[MapRanked10v10()] = global_xp
CUSTOM_XP_BONUS["imba_10v10"] = global_xp
CUSTOM_XP_BONUS[MapTournament()] = global_xp
CUSTOM_XP_BONUS[MapOverthrow()] = global_xp
CUSTOM_XP_BONUS[MapDiretide()] = global_xp
CUSTOM_XP_BONUS["imba_demo"] = global_xp

-- Hero base level, values are doubled with Hyper for non-custom maps
HERO_STARTING_LEVEL = {} -- 1 = Normal, 2 = Hyper
HERO_STARTING_LEVEL[Map1v1()] = 1
HERO_STARTING_LEVEL["imba_5v5"] = 5
HERO_STARTING_LEVEL[MapRanked5v5()] = 5
HERO_STARTING_LEVEL[MapRanked10v10()] = 5
HERO_STARTING_LEVEL["imba_10v10"] = 5
HERO_STARTING_LEVEL[MapTournament()] = 5
HERO_STARTING_LEVEL[MapOverthrow()] = 5
HERO_STARTING_LEVEL[MapDiretide()] = 5
HERO_STARTING_LEVEL["imba_demo"] = 1

MAX_LEVEL = {}
MAX_LEVEL[Map1v1()] = 42
MAX_LEVEL["imba_5v5"] = 42
MAX_LEVEL[MapRanked5v5()] = 42
MAX_LEVEL[MapRanked10v10()] = 42
MAX_LEVEL["imba_10v10"] = 42
MAX_LEVEL[MapTournament()] = 42
MAX_LEVEL[MapOverthrow()] = 42
MAX_LEVEL[MapDiretide()] = 42
MAX_LEVEL["imba_demo"] = 42

HERO_INITIAL_GOLD = {}
HERO_INITIAL_GOLD[Map1v1()] = 1400
HERO_INITIAL_GOLD["imba_5v5"] = 1400
HERO_INITIAL_GOLD[MapRanked5v5()] = 1400
HERO_INITIAL_GOLD[MapRanked10v10()] = 1400
HERO_INITIAL_GOLD["imba_10v10"] = 2500
HERO_INITIAL_GOLD[MapTournament()] = 1400
HERO_INITIAL_GOLD[MapOverthrow()] = 2500
HERO_INITIAL_GOLD[MapDiretide()] = 2500
HERO_INITIAL_GOLD["imba_demo"] = 99999

GOLD_TICK_TIME = {}
GOLD_TICK_TIME[Map1v1()] = 0.6
GOLD_TICK_TIME["imba_5v5"] = 0.6
GOLD_TICK_TIME[MapRanked5v5()] = 0.6
GOLD_TICK_TIME[MapRanked10v10()] = 0.4
GOLD_TICK_TIME["imba_10v10"] = 0.4
GOLD_TICK_TIME[MapTournament()] = 0.6
GOLD_TICK_TIME[MapOverthrow()] = 0.4
GOLD_TICK_TIME[MapDiretide()] = 0.4
GOLD_TICK_TIME["imba_demo"] = 0.4

BANNED_ITEMS = {}
BANNED_ITEMS[Map1v1()] = {
	"item_bottle",
	"item_infused_raindrop",
	"item_soul_ring",
	"item_tome_of_knowledge",
}

BANNED_ITEMS[MapDiretide()] = {
	"item_recipe_imba_jarnbjorn",
	"item_imba_jarnbjorn",
}

TOWER_ABILITIES = {}
TOWER_ABILITIES["tower1"] = {
	"imba_tower_tenacity",
	"imba_tower_thorns"
}
TOWER_ABILITIES["tower2"] = {
	"imba_tower_tenacity",
	"imba_tower_thorns",
	"imba_tower_regeneration"
}
TOWER_ABILITIES["tower3"] = {
	"imba_tower_tenacity",
	"imba_tower_thorns",
	"imba_tower_regeneration",
	"imba_tower_toughness",
}
TOWER_ABILITIES["tower4"] = {
	"imba_tower_tenacity",
	"imba_tower_thorns",
	"imba_tower_regeneration",
	"imba_tower_toughness",
	"imba_tower_splash_fire"
}

-- Update game mode net tables
CustomNetTables:SetTableValue("game_options", "all_pick", {IMBA_PICK_MODE_ALL_PICK})
CustomNetTables:SetTableValue("game_options", "all_random", {IMBA_PICK_MODE_ALL_RANDOM})
CustomNetTables:SetTableValue("game_options", "all_random_same_hero", {IMBA_PICK_MODE_ALL_RANDOM_SAME_HERO})
CustomNetTables:SetTableValue("game_options", "gold_tick", {GOLD_TICK_TIME[GetMapName()]})
CustomNetTables:SetTableValue("game_options", "max_level", {MAX_LEVEL[GetMapName()]})

USE_CUSTOM_HERO_LEVELS = true	-- Should we allow heroes to have custom levels?

-- Vanilla xp increase per level
local vanilla_xp = {}
vanilla_xp[1]	= 0
vanilla_xp[2]	= 200
vanilla_xp[3]	= 400
vanilla_xp[4]	= 480
vanilla_xp[5]	= 580
vanilla_xp[6]	= 600
vanilla_xp[7]	= 640
vanilla_xp[8]	= 660
vanilla_xp[9]	= 680
vanilla_xp[10]	= 800
vanilla_xp[11]	= 820
vanilla_xp[12]	= 840
vanilla_xp[13]	= 900
vanilla_xp[14]	= 1225
vanilla_xp[15]	= 1250
vanilla_xp[16]	= 1275
vanilla_xp[17]	= 1300
vanilla_xp[18]	= 1325
vanilla_xp[19]	= 1500
vanilla_xp[20]	= 1590
vanilla_xp[21]	= 1600
vanilla_xp[22]	= 1850
vanilla_xp[23]	= 2100
vanilla_xp[24]	= 2350
vanilla_xp[25]	= 2600

XP_PER_LEVEL_TABLE = {}			-- XP per level table (only active if custom hero levels are enabled)
XP_PER_LEVEL_TABLE[1] = 0
for i = 2, 25 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i - 1] + vanilla_xp[i]
end

-- Was using GetRespawnTime() but Meepo respawn time is always 3, so let's use static values instead...
RESPAWN_TIME_VANILLA = {}
RESPAWN_TIME_VANILLA[1] = 6
RESPAWN_TIME_VANILLA[2] = 8
RESPAWN_TIME_VANILLA[3] = 10
RESPAWN_TIME_VANILLA[4] = 14
RESPAWN_TIME_VANILLA[5] = 16
RESPAWN_TIME_VANILLA[6] = 26
RESPAWN_TIME_VANILLA[7] = 28
RESPAWN_TIME_VANILLA[8] = 30
RESPAWN_TIME_VANILLA[9] = 32
RESPAWN_TIME_VANILLA[10] = 34
RESPAWN_TIME_VANILLA[11] = 36
RESPAWN_TIME_VANILLA[12] = 44
RESPAWN_TIME_VANILLA[13] = 46
RESPAWN_TIME_VANILLA[14] = 48
RESPAWN_TIME_VANILLA[15] = 50
RESPAWN_TIME_VANILLA[16] = 52
RESPAWN_TIME_VANILLA[17] = 54
RESPAWN_TIME_VANILLA[18] = 65
RESPAWN_TIME_VANILLA[19] = 70
RESPAWN_TIME_VANILLA[20] = 75
RESPAWN_TIME_VANILLA[21] = 80
RESPAWN_TIME_VANILLA[22] = 85
RESPAWN_TIME_VANILLA[23] = 90
RESPAWN_TIME_VANILLA[24] = 95
RESPAWN_TIME_VANILLA[25] = 100

-- XP AWARDED per level table (how much bounty heroes are worth beyond level 25)
HERO_XP_BOUNTY_PER_LEVEL = {}
HERO_XP_BOUNTY_PER_LEVEL[1] = 100

for i = 2, 500 do
	HERO_XP_BOUNTY_PER_LEVEL[i] = HERO_XP_BOUNTY_PER_LEVEL[i-1] + 40
end

USE_MEME_SOUNDS = true														-- Should we use meme/fun sounds on abilities occasionally?
MEME_SOUNDS_CHANCE = 50

-------------------------------------------------------------------------------------------------
-- IMBA: Keyvalue tables
-------------------------------------------------------------------------------------------------

PURGE_BUFF_LIST = LoadKeyValues("scripts/npc/KV/purge_buffs_list.kv")
DISPELLABLE_DEBUFF_LIST = LoadKeyValues("scripts/npc/KV/dispellable_debuffs_list.kv")

PLAYER_TEAM = {}

IMBA_INVISIBLE_MODIFIERS = {
	"modifier_imba_moonlight_shadow_invis",
	"modifier_item_imba_shadow_blade_invis",
	"modifier_imba_vendetta",
	"modifier_nyx_assassin_burrow",
	"modifier_item_imba_silver_edge_invis",
	"modifier_item_glimmer_cape_fade",
	"modifier_weaver_shukuchi",
	"modifier_treant_natures_guise_invis",
	"modifier_templar_assassin_meld",
	"modifier_imba_skeleton_walk_dummy",
	"modifier_invoker_ghost_walk_self",
	"modifier_rune_invis",
	"modifier_imba_skeleton_walk_invis",
	"modifier_imba_riki_invisibility",
	"modifier_imba_shadow_walk_buff_invis",
	"modifier_imba_invisibility_rune",
	"modifier_imba_blur_smoke",
	"modifier_windrunner_windrun_invis"
}

IMBA_REINCARNATION_MODIFIERS = {
--	"modifier_imba_reincarnation",
	"modifier_item_imba_aegis",
}

IGNORE_FOUNTAIN_UNITS = {
	"ent_dota_promo",
	"ent_dota_halloffame",
	"npc_dota_elder_titan_ancestral_spirit",
	"npc_dummy_unit",
	"npc_dota_hero_dummy_dummy",
	"npc_donator_companion",
	"npc_dota_wisp_spirit",
	"npc_dota_mutation_golem"
}

RESTRICT_FOUNTAIN_UNITS = {
	"npc_dota_unit_tombstone1",
	"npc_dota_unit_tombstone2",
	"npc_dota_unit_tombstone3",
	"npc_dota_unit_tombstone4",
	"npc_dota_unit_undying_zombie",
	"npc_dota_unit_undying_zombie_torso",
	"npc_imba_ember_spirit_remnant",
	"npc_imba_dota_stormspirit_remnant",
	"npc_dota_earth_spirit_stone",
	"npc_dota_tusk_frozen_sigil1",
	"npc_dota_tusk_frozen_sigil2",
	"npc_dota_tusk_frozen_sigil3",
	"npc_dota_tusk_frozen_sigil4",
	"imba_witch_doctor_death_ward",
	"npc_imba_techies_proximity_mine",
	"npc_imba_techies_proximity_mine_big_boom",
	"npc_imba_techies_stasis_trap",
	"npc_dota_zeus_cloud",
	"npc_dota_observer_wards",
	"npc_dota_sentry_wards",
	"npc_imba_venomancer_plague_ward",
	"npc_imba_venomancer_scourge_ward",
	"npc_dota_weaver_swarm",
}

MORPHLING_RESTRICTED_MODIFIERS = {
	"modifier_imba_riki_invisibility",
	"modifier_imba_ebb_and_flow_thinker",
	"modifier_imba_ebb_and_flow_tide_low",
	"modifier_imba_ebb_and_flow_tide_red",
	"modifier_imba_ebb_and_flow_tide_flood",
	"modifier_imba_ebb_and_flow_tide_high",
	"modifier_imba_ebb_and_flow_tide_wave",
	"modifier_imba_ebb_and_flow_tsunami",
	"modifier_imba_tidebringer",
	"modifier_imba_tidebringer_sword_particle",
	"modifier_imba_tidebringer_manual",
	"modifier_imba_tidebringer_slow",
	"modifier_imba_tidebringer_cleave_hit_target",
}

STATUS_RESISTANCE_IGNORE_MODIFIERS = {
	""
}

UNIT_EQUIPMENT = {}
UNIT_EQUIPMENT["models/heroes/crystal_maiden/crystal_maiden.vmdl"] = {
	"models/heroes/crystal_maiden/crystal_maiden_staff.vmdl",
	"models/heroes/crystal_maiden/crystal_maiden_cuffs.vmdl",
	"models/heroes/crystal_maiden/crystal_maiden_cape.vmdl",
	"models/heroes/crystal_maiden/head_item.vmdl",
	"models/heroes/crystal_maiden/crystal_maiden_shoulders.vmdl",
}
UNIT_EQUIPMENT["models/heroes/crystal_maiden/crystal_maiden_arcana.vmdl"] = {
	"models/heroes/crystal_maiden/crystal_maiden_staff.vmdl",
	"models/heroes/crystal_maiden/crystal_maiden_cuffs.vmdl",
	"models/heroes/crystal_maiden/crystal_maiden_arcana_back.vmdl",
	"models/heroes/crystal_maiden/head_item.vmdl",
	"models/heroes/crystal_maiden/crystal_maiden_shoulders.vmdl",
}
UNIT_EQUIPMENT["models/heroes/shredder/shredder.vmdl"] = {
	"models/heroes/shredder/shredder_armor.vmdl",
	"models/heroes/shredder/shredder_blade.vmdl",
	"models/heroes/shredder/shredder_body.vmdl",
	"models/heroes/shredder/shredder_chainsaw.vmdl",
	"models/heroes/shredder/shredder_driver_hat.vmdl",
	"models/heroes/shredder/shredder_hook.vmdl",
	"models/heroes/shredder/shredder_shoulders.vmdl",
}
UNIT_EQUIPMENT["models/items/pudge/arcana/pudge_arcana_base.vmdl"] = {
	"models/items/pudge/blackdeath_offhand/blackdeath_offhand.vmdl",
	"models/items/pudge/blackdeath_head_s3/blackdeath_head_s3.vmdl",
	"models/items/pudge/immortal_arm/immortal_arm.vmdl",
	"models/items/pudge/scorching_talon/scorching_talon.vmdl",
	"models/items/pudge/doomsday_ripper_belt/doomsday_ripper_belt.vmdl",
	"models/items/pudge/pudge_deep_sea_abomination_arms/pudge_deep_sea_abomination_arms.vmdl",
	"models/items/pudge/arcana/pudge_arcana_back.vmdl",
}
UNIT_EQUIPMENT["models/heroes/huskar/huskar.vmdl"] = {
	"models/items/huskar/searing_dominator/searing_dominator.vmdl",
	"models/heroes/huskar/huskar_bracer.vmdl",
	"models/heroes/huskar/huskar_dagger.vmdl",
	"models/heroes/huskar/huskar_shoulder.vmdl",
	"models/heroes/huskar/huskar_spear.vmdl",
}
UNIT_EQUIPMENT["models/heroes/rubick/rubick.vmdl"] = {
	"models/items/rubick/force_staff/force_staff.vmdl",
	"models/items/rubick/kuroky_rubick_back/kuroky_rubick_back.vmdl",
	"models/items/rubick/kuroky_rubick_shoulders/kuroky_rubick_shoulders.vmdl",
	"models/items/rubick/kuroky_rubick_weapon/kuroky_rubick_weapon.vmdl",
	"models/items/rubick/rubick_kuroky_head/rubick_kuroky_head.vmdl",
}
UNIT_EQUIPMENT["models/heroes/enchantress/enchantress.vmdl"] = {
	"models/items/enchantress/rainbow_spear/mesh/rainbow_spear_model.vmdl",
	"models/items/enchantress/anuxi_summer_head/anuxi_summer_head.vmdl",
	"models/items/enchantress/amberlight_belt/amberlight_belt.vmdl",
	"models/items/enchantress/anuxi_summer_shoulder/anuxi_summer_shoulder.vmdl",
	"models/items/enchantress/anuxi_wildkin_arm/anuxi_wildkin_arm.vmdl",
}
UNIT_EQUIPMENT["models/heroes/bristleback/bristleback_back.vmdl"] = {
	"models/heroes/phoenix/phoenix_wings.vmdl",
	"models/heroes/phoenix/phoenix_bird_head.vmdl",
}
UNIT_EQUIPMENT["models/heroes/bristleback/bristleback.vmdl"] = {
	"models/heroes/bristleback/bristleback_back.vmdl",
	"models/heroes/bristleback/bristleback_bracer.vmdl",
	"models/heroes/bristleback/bristleback_head.vmdl",
	"models/heroes/bristleback/bristleback_necklace.vmdl",
	"models/heroes/bristleback/bristleback_weapon.vmdl",
--	"models/heroes/bristleback/bristleback_offhand_weapon.vmdl",
}
UNIT_EQUIPMENT["models/items/rubick/rubick_arcana/rubick_arcana_base.vmdl"] = {
	"models/items/rubick/rubick_arcana/rubick_arcana_back.vmdl",
	"models/heroes/rubick/rubick_head.vmdl",
	"models/heroes/rubick/rubick_staff.vmdl",
	"models/heroes/rubick/shoulder.vmdl",
}
UNIT_EQUIPMENT["models/heroes/juggernaut/juggernaut_arcana.vmdl"] = {
	"models/items/juggernaut/arcana/juggernaut_arcana_mask.vmdl",
	"models/items/juggernaut/jugg_ti8/jugg_ti8_sword.vmdl",
	"models/heroes/juggernaut/jugg_cape.vmdl",
	"models/heroes/juggernaut/juggernaut_pants.vmdl",
}

IMBA_DISABLED_SKULL_BASHER = {
	"npc_dota_hero_faceless_void",
	"npc_dota_hero_slardar",
	"npc_dota_hero_spirit_breaker"
}

IMBA_ABILITIES_IGNORE_CDR = {
	"imba_venomancer_plague_ward"
}

IMBA_MODIFIER_IGNORE_FRANTIC = {
	"modifier_legion_commander_duel"
}

IMBA_DISARM_IMMUNITY = {
	"modifier_disarmed",
	"modifier_item_imba_triumvirate_proc_debuff",
	"modifier_item_imba_sange_kaya_proc",
	"modifier_item_imba_sange_yasha_disarm",
	"modifier_item_imba_heavens_halberd_active_disarm",
	"modifier_item_imba_sange_disarm",
	"modifier_imba_angelic_alliance_debuff",
	"modifier_imba_overpower_disarm",
	"modifier_imba_silencer_last_word_debuff",
	"modifier_imba_hurl_through_hell_disarm",
	"modifier_imba_frost_armor_freeze",
	"modifier_dismember_disarm",
	"modifier_imba_decrepify",

--	"modifier_imba_faceless_void_time_lock_stun",
--	"modifier_bashed",
}

IMBA_FIRST_BLOOD = false

-- files requirements
if GetMapName() == MapOverthrow() then
	require("components/settings/settings_imbathrow")
end

-- IMBA override vanilla systems
USE_TEAM_COURIER = true -- Should we use vanilla couriers?
IMBA_RUNE_SYSTEM = false -- Should we use custom runes script spawner?
IMBA_COMBAT_EVENTS = false -- Should we use custom combat events notifications?
IMBA_GOLD_SYSTEM = false -- Should we use custom gold system?
IMBA_PICK_SCREEN = false -- Should we use custom pick screen?
IMBA_GREEVILING = false -- Should we use fancy greevil creeps?

IMBA_DIRETIDE = false -- Should we enable diretide?

if IMBA_PICK_SCREEN == false then
	PRE_GAME_TIME = 60.0

	if not IsInToolsMode() then
		STRATEGY_TIME = 10.0
	end
end

if GetMapName() == MapDiretide() then
	IMBA_DIRETIDE = true
end

IMBA_DIRETIDE_EASTER_EGG = false

if IMBA_DIRETIDE == true then
	IMBA_DIRETIDE_EASTER_EGG = false
	require("components/diretide/diretide")
end

SAME_HERO_SELECTION = IMBA_PICK_SCREEN
if GetMapName() == "imba_1v1" then
	SAME_HERO_SELECTION = true
end