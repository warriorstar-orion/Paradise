#define SPACE_LOOT_SPAWN_POOL "space_loot_spawn_pool"

/datum/spawn_pool/spaceloot
	id = SPACE_LOOT_SPAWN_POOL
	available_points = 500

/obj/effect/spawner/random/pool/spaceloot
	spawn_pool_id = SPACE_LOOT_SPAWN_POOL

/obj/effect/spawner/random/pool/spaceloot/dvorak_core_table
	point_value = 100
	guaranteed = TRUE
	loot = list(
		/obj/item/rcd/combat,
		/obj/item/gun/medbeam,
		/obj/item/gun/energy/wormhole_projector,
		/obj/item/storage/box/syndie_kit/oops_all_extraction_flares,
	)

/obj/effect/spawner/random/pool/spaceloot/dvorak_emp_loot
	point_value = 100
	guaranteed = TRUE
	loot = list(
		/obj/item/grenade/empgrenade = 8,
		/obj/item/gun/energy/ionrifle/carbine = 1,
		/obj/item/gun/energy/ionrifle = 1,
	)

/obj/effect/spawner/random/pool/spaceloot/dvorak_displaycase
	point_value = 100
	guaranteed = TRUE
	spawn_inside = /obj/structure/displaycase/dvoraks_treat
	loot = list(
		/obj/item/remote_ai_upload = 8,

		list(
			/obj/item/assembly/signaler/anomaly/pyro,
			/obj/item/assembly/signaler/anomaly/cryo,
			/obj/item/assembly/signaler/anomaly/grav,
			/obj/item/assembly/signaler/anomaly/flux,
			/obj/item/assembly/signaler/anomaly/bluespace,
			/obj/item/assembly/signaler/anomaly/vortex,
		) = 4,

		list(
			/obj/item/organ/internal/cyberimp/brain/sensory_enhancer,
			/obj/item/organ/internal/cyberimp/brain/hackerman_deck,
			/obj/item/storage/lockbox/experimental_weapon
		) = 1
	)

#undef SPACE_LOOT_SPAWN_POOL
