return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['cola'] = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Mastercard',
		stack = false,
		weight = 10,
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["ak47"] = {
		label = "Poudre de AK-47",
		weight = 1,
		stack = true,
		close = true,
	},

	["ak47_head"] = {
		label = "Tête de AK-47",
		weight = 1,
		stack = true,
		close = true,
	},

	["ak47_seed"] = {
		label = "Graine de AK-47",
		weight = 1,
		stack = true,
		close = true,
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["amnesia"] = {
		label = "Poudre d'Amnésia",
		weight = 1,
		stack = true,
		close = true,
	},

	["amnesia_head"] = {
		label = "Tête d'Amnésia",
		weight = 1,
		stack = true,
		close = true,
	},

	["amnesia_seed"] = {
		label = "Graine d'Amnésia",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["blueberry"] = {
		label = "Poudre de BlueBerry",
		weight = 1,
		stack = true,
		close = true,
	},

	["blueberry_head"] = {
		label = "Tête de BlueBerry",
		weight = 1,
		stack = true,
		close = true,
	},

	["blueberry_seed"] = {
		label = "Graine de BlueBerry",
		weight = 1,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fertilizer"] = {
		label = "Fertilisant pour cannabis",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["g13"] = {
		label = "Poudre de G13",
		weight = 1,
		stack = true,
		close = true,
	},

	["g13_head"] = {
		label = "Tête de G13",
		weight = 1,
		stack = true,
		close = true,
	},

	["g13_seed"] = {
		label = "Graine de G13",
		weight = 1,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["godgift"] = {
		label = "Poudre de God's Gift",
		weight = 1,
		stack = true,
		close = true,
	},

	["godgift_head"] = {
		label = "Tête de God's Gift",
		weight = 1,
		stack = true,
		close = true,
	},

	["godgift_seed"] = {
		label = "Graine de God's Gift",
		weight = 1,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["haze"] = {
		label = "Poudre de Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["haze_head"] = {
		label = "Tête de Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["haze_seed"] = {
		label = "Graine de Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_ak47"] = {
		label = "Joint de AK-47",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_amnesia"] = {
		label = "Joint d'Amnésia",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_blueberry"] = {
		label = "Joint de BlueBerry",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_deadinside"] = {
		label = "Joint de Dead Inside",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_g13"] = {
		label = "Joint de G13",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_godgift"] = {
		label = "Joint de God's Gift",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_gohome"] = {
		label = "Joint de Go To Home",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_haze"] = {
		label = "Joint de Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_imspeed"] = {
		label = "Joint de Im Speed",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_lemonhaze"] = {
		label = "Joint de Lemon Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_pollen"] = {
		label = "Joint de Pollen",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_skunk"] = {
		label = "Joint de Skunk",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_travel"] = {
		label = "Joint de Travel The World",
		weight = 1,
		stack = true,
		close = true,
	},

	["joint_whitewidow"] = {
		label = "Joint de White Widow",
		weight = 1,
		stack = true,
		close = true,
	},

	["lemonhaze"] = {
		label = "Poudre de Lemon Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["lemonhaze_head"] = {
		label = "Tête de Lemon Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["lemonhaze_seed"] = {
		label = "Graine de Lemon Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Medikit",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["pollen"] = {
		label = "Pollen de cannabis",
		weight = 1,
		stack = true,
		close = true,
	},

	["skunk"] = {
		label = "Poudre de Skunk",
		weight = 1,
		stack = true,
		close = true,
	},

	["skunk_head"] = {
		label = "Tête de Skunk",
		weight = 1,
		stack = true,
		close = true,
	},

	["skunk_seed"] = {
		label = "Graine de Skunk",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_seed"] = {
		label = "Graine de Weed",
		weight = 1,
		stack = true,
		close = true,
	},

	["whitewidow"] = {
		label = "Poudre de White Widow",
		weight = 1,
		stack = true,
		close = true,
	},

	["whitewidow_head"] = {
		label = "Tête de White Widow",
		weight = 1,
		stack = true,
		close = true,
	},

	["whitewidow_seed"] = {
		label = "Graine de White Widow",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},
}