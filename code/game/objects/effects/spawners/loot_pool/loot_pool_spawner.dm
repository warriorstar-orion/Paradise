/obj/effect/spawner/random/loot_pool
	late_initialize_spawn = TRUE

	var/point_value = INFINITY
	/// Whether non-spawner items should be removed from the shared loot pool after spawning.
	var/unique_picks = FALSE
	var/datum/loot_pool_manager/loot_pool_manager

/obj/effect/spawner/random/loot_pool/Initialize(mapload)
	. = ..()
	if(loot_pool_manager && unique_picks)
		loot_pool_manager.unique_spawners[type] = loot.Copy()

/obj/effect/spawner/random/loot_pool/generate_loot_list()
	if(unique_picks)
		var/list/unique_loot = loot_pool_manager.unique_spawners[type]
		return unique_loot.Copy()

	return ..()

/obj/effect/spawner/random/loot_pool/make_item(spawn_loc, type_path_to_make)
	if(!ispath(type_path_to_make, /obj/effect))
		if(loot_pool_manager.consume(point_value))
			. = ..()

			if(unique_picks)
				// We may have multiple instances of a given type
				// so just remove the first instance we find
				var/list/unique_spawners = loot_pool_manager.unique_spawners[type]
				unique_spawners.Remove(type_path_to_make)
	else
		return ..()

