/datum/spawn_pool/spaceruin_loot
	id = SPAWN_POOL_SPACERUIN_LOOT
	available_points = 1000

/obj/effect/spawner/random/pool/spaceloot
	record_spawn = TRUE
	spawn_pool_id = SPAWN_POOL_SPACERUIN_LOOT

/obj/effect/spawner/random/pool/spaceloot/all_tiers
	loot = list(
		/obj/effect/spawner/random/pool/spaceloot/tier1 = 1,
		/obj/effect/spawner/random/pool/spaceloot/tier2 = 2,
		/obj/effect/spawner/random/pool/spaceloot/tier3 = 4,
	)

/obj/effect/spawner/random/pool/spaceloot/tier1
	point_value = 100
	loot = list(
		/obj/item/mod/control/pre_equipped/traitor,
		// etc...
	)

/obj/effect/spawner/random/pool/spaceloot/tier2
	point_value = 20
	loot = list(
		/obj/item/storage/box/syndie_kit/stechkin,
		// etc...
	)

/obj/effect/spawner/random/pool/spaceloot/tier3
	point_value = 5
	loot = list(
		/obj/item/soap/syndie,
		// etc...
	)

/obj/effect/spawner/random/pool/spaceloot/dvorak_core_table
	guaranteed = TRUE
	point_value = 200
	loot = list(
		/obj/item/rcd/combat,
		/obj/item/gun/medbeam,
		/obj/item/gun/energy/wormhole_projector,
		/obj/item/storage/box/syndie_kit/oops_all_extraction_flares
	)

/obj/effect/spawner/random/pool/spaceloot/dvorak_emp_loot
	guaranteed = TRUE
	point_value = 150
	loot = list(
		/obj/item/grenade/empgrenade = 8,
		/obj/item/gun/energy/ionrifle/carbine = 1,
		/obj/item/gun/energy/ionrifle = 1)
