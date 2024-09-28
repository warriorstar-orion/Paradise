/obj/effect/spawner/random/loot_pool/space_ruins/Initialize(mapload)
	loot_pool_manager = SSmapping.space_loot_pool_manager
	return ..()

// Random example spawners, just demonstrations, not actually
// balanced in any way

// Random crap
/obj/effect/spawner/random/loot_pool/space_ruins/generic_tier_3
	point_value = 5
	loot = list(
		/obj/item/camera_film,
		/obj/item/camera,
		/obj/item/caution,
		/obj/item/clothing/head/cone,
		/obj/item/light/bulb,
		/obj/item/light/tube,
		/obj/item/poster/random_contraband,
		/obj/item/poster/random_official,
	)

/obj/effect/spawner/random/loot_pool/space_ruins/abandoned_zoo
	point_value = 10
	unique_picks = TRUE
	loot = list(
		// Since unique_picks = TRUE, only one of each gun
		// will spawn anywhere in space. Once those two items
		// are removed from the pool, any further spawners of this
		// exact type will instead default to the spawners further
		// down the list.
		/obj/item/gun/energy/floragun,
		/obj/item/gun/energy/temperature,

		/obj/effect/spawner/random/loot_pool/space_ruins/generic_tier_3
	)
