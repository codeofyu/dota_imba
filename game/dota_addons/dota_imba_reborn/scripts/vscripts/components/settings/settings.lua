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

-- Picking screen constants
PICKING_SCREEN_OVER = false
AP_GAME_TIME = 60.0					-- How long should we let people select their hero?
CAPTAINS_MODE_CAPTAIN_TIME = 20		-- how long players have to claim the captain chair
CAPTAINS_MODE_PICK_BAN_TIME = 30	-- how long you have to do each pick/ban
CAPTAINS_MODE_HERO_PICK_TIME = 30	-- time to choose which hero you're going to play
CAPTAINS_MODE_RESERVE_TIME = 130	-- total bonus time that can be used throughout any selection

-- IMBA constants
USE_TEAM_COURIER = true
IMBA_REINCARNATION_TIME = 3.0
RUNE_SPAWN_TIME = 120					-- How long in seconds should we wait between rune spawns?
BOUNTY_RUNE_SPAWN_TIME = 300

-- Barebones constants
AUTO_LAUNCH_DELAY = 5.0					-- How long should we wait for the host to setup the game, after all players have loaded in?
STRATEGY_TIME = 0.0						-- How long should strategy time last?
SHOWCASE_TIME = 0.0						-- How long should showcase time last?
PRE_GAME_TIME = 90 + AP_GAME_TIME		-- How long after people select their heroes should the horn blow and the game start?
if GetMapName() == "cavern" then
PRE_GAME_TIME = 45 + AP_GAME_TIME		-- How long after people select their heroes should the horn blow and the game start?
end
TREE_REGROW_TIME = 180.0				-- How long should it take individual trees to respawn after being cut down/destroyed?
POST_GAME_TIME = 600.0					-- How long should we let people look at the scoreboard before closing the server automatically?
CAMERA_DISTANCE_OVERRIDE = -1
GOLD_PER_TICK = 1

ENABLE_HERO_RESPAWN = true
USE_AUTOMATIC_PLAYERS_PER_TEAM = false	-- Should we set the number of players to 10 / MAX_NUMBER_OF_TEAMS?
UNIVERSAL_SHOP_MODE = false				-- Should the main shop contain Secret Shop items as well as regular items
if IsInToolsMode() then
	UNIVERSAL_SHOP_MODE = true
end
USE_STANDARD_HERO_GOLD_BOUNTY = false

MINIMAP_ICON_SIZE = 1						-- What icon size should we use for our heroes?
MINIMAP_CREEP_ICON_SIZE = 1					-- What icon size should we use for creeps?
MINIMAP_RUNE_ICON_SIZE = 1					-- What icon size should we use for runes?

CUSTOM_BUYBACK_COST_ENABLED = true			-- Should we use a custom buyback cost setting?
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

BUYBACK_COOLDOWN_MAXIMUM = 90												-- Maximum buyback cooldown

ABANDON_TIME = 180															-- Time for a player to be considered as having abandoned the game (in seconds)
FULL_ABANDON_TIME = 15														-- Time for a team to be considered as having abandoned the game (in seconds)

GAME_ROSHAN_KILLS = 0														-- Tracks amount of Roshan kills
ROSHAN_RESPAWN_TIME = RandomInt(2, 4) * 60									-- Roshan respawn timer (in seconds)
AEGIS_DURATION = 300														-- Aegis expiration timer (in seconds)

IMBA_DAMAGE_EFFECTS_DISTANCE_CUTOFF = 2500									-- Range at which most on-damage effects no longer trigger

COMEBACK_BOUNTY_SCORE = {}													-- Extra comeback gold based on hero and tower kills
COMEBACK_BOUNTY_SCORE[DOTA_TEAM_GOODGUYS] = 0
COMEBACK_BOUNTY_SCORE[DOTA_TEAM_BADGUYS] = 0
COMEBACK_BOUNTY_BONUS = {}													-- Extra comeback gold based on hero and tower kills
COMEBACK_BOUNTY_BONUS[DOTA_TEAM_GOODGUYS] = 0
COMEBACK_BOUNTY_BONUS[DOTA_TEAM_BADGUYS] = 0

COMEBACK_EXP_BONUS = 100

-- Hero respawn time per leve
-- Formula: (42/srqt(50)) * (-1*(50-sqrt(lvl))+50)

HERO_RESPAWN_TIME_PER_LEVEL = {}
HERO_RESPAWN_TIME_PER_LEVEL[1] = 5
HERO_RESPAWN_TIME_PER_LEVEL[2] = 10
HERO_RESPAWN_TIME_PER_LEVEL[3] = 13
HERO_RESPAWN_TIME_PER_LEVEL[4] = 15
HERO_RESPAWN_TIME_PER_LEVEL[5] = 18
HERO_RESPAWN_TIME_PER_LEVEL[6] = 20
HERO_RESPAWN_TIME_PER_LEVEL[7] = 22
HERO_RESPAWN_TIME_PER_LEVEL[8] = 24
HERO_RESPAWN_TIME_PER_LEVEL[9] = 25
HERO_RESPAWN_TIME_PER_LEVEL[10] = 27
HERO_RESPAWN_TIME_PER_LEVEL[11] = 29
HERO_RESPAWN_TIME_PER_LEVEL[12] = 30
HERO_RESPAWN_TIME_PER_LEVEL[13] = 32
HERO_RESPAWN_TIME_PER_LEVEL[14] = 33
HERO_RESPAWN_TIME_PER_LEVEL[15] = 34
HERO_RESPAWN_TIME_PER_LEVEL[16] = 35
HERO_RESPAWN_TIME_PER_LEVEL[17] = 37
HERO_RESPAWN_TIME_PER_LEVEL[18] = 38
HERO_RESPAWN_TIME_PER_LEVEL[19] = 39
HERO_RESPAWN_TIME_PER_LEVEL[20] = 40
HERO_RESPAWN_TIME_PER_LEVEL[21] = 41
HERO_RESPAWN_TIME_PER_LEVEL[22] = 42
HERO_RESPAWN_TIME_PER_LEVEL[23] = 43
HERO_RESPAWN_TIME_PER_LEVEL[24] = 44
HERO_RESPAWN_TIME_PER_LEVEL[25] = 45
HERO_RESPAWN_TIME_PER_LEVEL[26] = 46
HERO_RESPAWN_TIME_PER_LEVEL[27] = 47
HERO_RESPAWN_TIME_PER_LEVEL[28] = 48
HERO_RESPAWN_TIME_PER_LEVEL[29] = 49
HERO_RESPAWN_TIME_PER_LEVEL[30] = 50
HERO_RESPAWN_TIME_PER_LEVEL[31] = 51
HERO_RESPAWN_TIME_PER_LEVEL[32] = 52
HERO_RESPAWN_TIME_PER_LEVEL[33] = 53
HERO_RESPAWN_TIME_PER_LEVEL[34] = 54
HERO_RESPAWN_TIME_PER_LEVEL[35] = 55
HERO_RESPAWN_TIME_PER_LEVEL[36] = 55
HERO_RESPAWN_TIME_PER_LEVEL[37] = 56
HERO_RESPAWN_TIME_PER_LEVEL[38] = 57
HERO_RESPAWN_TIME_PER_LEVEL[39] = 58
HERO_RESPAWN_TIME_PER_LEVEL[40] = 59
HERO_RESPAWN_TIME_PER_LEVEL[41] = 60
HERO_RESPAWN_TIME_PER_LEVEL[42] = 60

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
elseif GetMapName() == "imba_12v12" then
	IMBA_PLAYERS_ON_GAME = 24
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 12
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 12
elseif GetMapName() == "cavern" then
	IMBA_PLAYERS_ON_GAME = 24
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 3
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 3
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_1]  = 3
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_2]  = 3
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_3]  = 3
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_4]  = 3
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_5]  = 3
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_6]  = 3
end

-------------------------------------------------------------------------------------------------
-- IMBA: game mode globals
-------------------------------------------------------------------------------------------------
GAME_WINNER_TEAM = 0														-- Tracks game winner
GG_TEAM = {}
GG_TEAM[2] = 0
GG_TEAM[3] = 0

if IsMutationMap() then
	IMBA_FRANTIC_MODE_ON = true
else
	IMBA_FRANTIC_MODE_ON = false
end

_G.IMBA_FRANTIC_VALUE = 25

IMBA_PICK_MODE_ALL_PICK = true												-- Activates All Pick mode when true
IMBA_PICK_MODE_ALL_RANDOM = false											-- Activates All Random mode when true
IMBA_PICK_MODE_ALL_RANDOM_SAME_HERO = false									-- Activates All Random Same Hero mode when true
IMBA_ALL_RANDOM_HERO_SELECTION_TIME = 5.0									-- Time we need to wait before the game starts when all heroes are randomed

-- Global Gold earning, values are doubled with Hyper for non-custom maps
CUSTOM_GOLD_BONUS = {} -- 1 = Normal, 2 = Hyper
CUSTOM_GOLD_BONUS[Map1v1()] = 350
CUSTOM_GOLD_BONUS[MapRanked5v5()] = 350
CUSTOM_GOLD_BONUS[MapRanked10v10()] = 350
CUSTOM_GOLD_BONUS[MapTournament()] = 350
CUSTOM_GOLD_BONUS[MapMutation5v5] = 350
CUSTOM_GOLD_BONUS[MapMutation10v10()] = 350
CUSTOM_GOLD_BONUS["cavern"] = 100

-- Global XP earning, values are doubled with Hyper for non-custom maps (right now this is not used anymore, but i'll keep it there just in case)
CUSTOM_XP_BONUS = {} -- 1 = Normal, 2 = Hyper
CUSTOM_XP_BONUS[Map1v1()] = 200
CUSTOM_XP_BONUS[MapRanked5v5()] = 200
CUSTOM_XP_BONUS[MapRanked10v10()] = 200
CUSTOM_XP_BONUS[MapTournament()] = 200
CUSTOM_XP_BONUS[MapMutation5v5] = 200
CUSTOM_XP_BONUS[MapMutation10v10()] = 200
CUSTOM_XP_BONUS["cavern"] = 100

-- Hero base level, values are doubled with Hyper for non-custom maps
HERO_STARTING_LEVEL = {} -- 1 = Normal, 2 = Hyper
HERO_STARTING_LEVEL[Map1v1()] = 1
HERO_STARTING_LEVEL[MapRanked5v5()] = 3
HERO_STARTING_LEVEL[MapRanked10v10()] = 3
HERO_STARTING_LEVEL[MapTournament()] = 3
HERO_STARTING_LEVEL[MapMutation5v5] = 5
HERO_STARTING_LEVEL[MapMutation10v10()] = 5

MAX_LEVEL = {}
MAX_LEVEL[Map1v1()] = 42
MAX_LEVEL[MapRanked5v5()] = 42
MAX_LEVEL[MapRanked10v10()] = 42
MAX_LEVEL[MapTournament()] = 42
MAX_LEVEL[MapMutation5v5] = 42
MAX_LEVEL[MapMutation10v10()] = 42
MAX_LEVEL["cavern"] = 42

HERO_INITIAL_GOLD = {}
HERO_INITIAL_GOLD[Map1v1()] = 1400
HERO_INITIAL_GOLD[MapRanked5v5()] = 1400
HERO_INITIAL_GOLD[MapRanked10v10()] = 1400
HERO_INITIAL_GOLD[MapTournament()] = 1400
HERO_INITIAL_GOLD[MapMutation5v5] = 2500
HERO_INITIAL_GOLD[MapMutation10v10()] = 2500
HERO_INITIAL_GOLD["cavern"] = 1400

GOLD_TICK_TIME = {}
GOLD_TICK_TIME[Map1v1()] = 0.6
GOLD_TICK_TIME[MapRanked5v5()] = 0.6
GOLD_TICK_TIME[MapRanked10v10()] = 0.4
GOLD_TICK_TIME[MapTournament()] = 0.6
GOLD_TICK_TIME[MapMutation5v5] = 0.6
GOLD_TICK_TIME[MapMutation10v10()] = 0.4
GOLD_TICK_TIME["cavern"] = 9999.0

BANNED_ITEMS = {}
BANNED_ITEMS[Map1v1()] = {
	"item_imba_bottle",
	"item_infused_raindrop",
	"item_soul_ring",
	"item_tome_of_knowledge",
}
BANNED_ITEMS[MapRanked5v5()] = {
	"item_cavern_dynamite",
}
BANNED_ITEMS[MapRanked10v10()] = {
	"item_cavern_dynamite",
}
BANNED_ITEMS[MapTournament()] = {
	"item_cavern_dynamite",
}
BANNED_ITEMS[MapMutation5v5] = {
	"item_cavern_dynamite",
}
BANNED_ITEMS[MapMutation10v10()] = {
	"item_cavern_dynamite",
}
BANNED_ITEMS["imba_frantic_5v5"] = {
	"item_cavern_dynamite",
}
BANNED_ITEMS["cavern"] = {
	"item_imba_aegis",
	"item_imba_bottle",
	"item_imba_hand_of_midas",
	"item_recipe_imba_hand_of_midas",
	"item_imba_heart",
	"item_helm_of_the_dominator",
	"item_smoke_of_deceit",
	"item_tome_of_knowledge",
	"item_tpscroll",
	"item_imba_blink",
	"item_imba_blink_boots",
}

TOWER_ABILITIES = {}
TOWER_ABILITIES["tower1"] = {
	"imba_tower_healing_tower",
	"imba_tower_tenacity",
}
TOWER_ABILITIES["tower2"] = {
	"imba_tower_healing_tower",
	"imba_tower_regeneration",
	"imba_tower_tenacity",
	"imba_tower_toughness",
}
TOWER_ABILITIES["tower3"] = {
	"imba_tower_healing_tower",
	"imba_tower_regeneration",
	"imba_tower_tenacity",
	"imba_tower_toughness",
}
TOWER_ABILITIES["tower4"] = {
	"imba_tower_healing_tower",
	"imba_tower_regeneration",
	"imba_tower_tenacity",
	"imba_tower_toughness",
}


-- Update game mode net tables
CustomNetTables:SetTableValue("game_options", "all_pick", {IMBA_PICK_MODE_ALL_PICK})
CustomNetTables:SetTableValue("game_options", "all_random", {IMBA_PICK_MODE_ALL_RANDOM})
CustomNetTables:SetTableValue("game_options", "all_random_same_hero", {IMBA_PICK_MODE_ALL_RANDOM_SAME_HERO})
CustomNetTables:SetTableValue("game_options", "frantic_mode", {IMBA_FRANTIC_MODE_ON})
CustomNetTables:SetTableValue("game_options", "gold_tick", {GOLD_TICK_TIME[GetMapName()]})
CustomNetTables:SetTableValue("game_options", "max_level", {MAX_LEVEL[GetMapName()]})

USE_CUSTOM_HERO_LEVELS = true	-- Should we allow heroes to have custom levels?
XP_PER_LEVEL_TABLE = {}			-- XP per level table (only active if custom hero levels are enabled)

-- Vanilla
XP_PER_LEVEL_TABLE[1] =		0		-- +0
XP_PER_LEVEL_TABLE[2] =		200		-- +200
XP_PER_LEVEL_TABLE[3] =		600		-- +400
XP_PER_LEVEL_TABLE[4] =		1080	-- +480
XP_PER_LEVEL_TABLE[5] =		1680	-- +600
XP_PER_LEVEL_TABLE[6] =		2300	-- +620
XP_PER_LEVEL_TABLE[7] =		2940	-- +640
XP_PER_LEVEL_TABLE[8] =		3600	-- +660
XP_PER_LEVEL_TABLE[9] =		4280	-- +680
XP_PER_LEVEL_TABLE[10] =	5080	-- +800
XP_PER_LEVEL_TABLE[11] =	5900	-- +820
XP_PER_LEVEL_TABLE[12] =	6740	-- +840
XP_PER_LEVEL_TABLE[13] =	7640	-- +900
XP_PER_LEVEL_TABLE[14] =	8865	-- +1225
XP_PER_LEVEL_TABLE[15] =	10115	-- +1250
XP_PER_LEVEL_TABLE[16] =	11390	-- +1275
XP_PER_LEVEL_TABLE[17] =	12690	-- +1300
XP_PER_LEVEL_TABLE[18] =	14015	-- +1325
XP_PER_LEVEL_TABLE[19] =	15415	-- +1400
XP_PER_LEVEL_TABLE[20] =	16905	-- +1490
XP_PER_LEVEL_TABLE[21] =	18405	-- +1500
XP_PER_LEVEL_TABLE[22] =	20155	-- +1750
XP_PER_LEVEL_TABLE[23] =	22155	-- +2000
XP_PER_LEVEL_TABLE[24] =	24405	-- +2250
XP_PER_LEVEL_TABLE[25] =	26905	-- +2500

-- XP AWARDED per level table (how much bounty heroes are worth beyond level 25)
HERO_XP_BOUNTY_PER_LEVEL = {}
HERO_XP_BOUNTY_PER_LEVEL[1] = 125
HERO_XP_BOUNTY_PER_LEVEL[2] = 170
HERO_XP_BOUNTY_PER_LEVEL[3] = 215
HERO_XP_BOUNTY_PER_LEVEL[4] = 260
HERO_XP_BOUNTY_PER_LEVEL[5] = 305
HERO_XP_BOUNTY_PER_LEVEL[6] = 350
HERO_XP_BOUNTY_PER_LEVEL[7] = 395

for i = 8, 500 do
	HERO_XP_BOUNTY_PER_LEVEL[i] = HERO_XP_BOUNTY_PER_LEVEL[i-1] + 135
end

USE_MEME_SOUNDS = true														-- Should we use meme/fun sounds on abilities occasionally?

-------------------------------------------------------------------------------------------------
-- IMBA: Keyvalue tables
-------------------------------------------------------------------------------------------------

PURGE_BUFF_LIST = LoadKeyValues("scripts/npc/KV/purge_buffs_list.kv")
DISPELLABLE_DEBUFF_LIST = LoadKeyValues("scripts/npc/KV/dispellable_debuffs_list.kv")

PLAYER_TEAM = {}

DONATOR_COLOR = {}
DONATOR_COLOR[1] = {160, 20, 20}
DONATOR_COLOR[2] = {100, 20, 20}
DONATOR_COLOR[3] = {0, 102, 255}
DONATOR_COLOR[4] = {240, 50, 50}
DONATOR_COLOR[5] = {218, 165, 32}
DONATOR_COLOR[6] = {45, 200, 45}
DONATOR_COLOR[7] = {47, 91, 151}
DONATOR_COLOR[8] = {153, 51, 153}
DONATOR_COLOR[9] = {255, 135, 42}

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
}

IMBA_REINCARNATION_MODIFIERS = {
	"modifier_imba_reincarnation",
	"modifier_item_imba_aegis",
}

IGNORE_FOUNTAIN_UNITS = {
	"npc_dota_elder_titan_ancestral_spirit",
	"npc_dummy_unit",
	"npc_dota_hero_dummy_dummy",
	"npc_imba_donator_companion",
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

SHARED_NODRAW_MODIFIERS = {
	"modifier_item_shadow_amulet_fade",
	"modifier_monkey_king_tree_dance_hidden",
	"modifier_monkey_king_transform",
	"modifier_pangolier_gyroshell",
	"modifier_smoke_of_deceit",
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

IMBA_DISABLED_SKULL_BASHER = {
	"npc_dota_hero_faceless_void",
	"npc_dota_hero_slardar",
	"npc_dota_hero_spirit_breaker",
	"npc_dota_hero_troll_warlord",
}

IMBA_WEATHER_EFFECT = {}
IMBA_WEATHER_EFFECT[1] = "particles/rain_fx/econ_snow.vpcf"

require('components/settings/settings_donator')
if string.find(GetMapName(), "10v10") then
	require('components/settings/settings_10v10')
end