/obj/effect/spawner/random/pool
	var/point_value = INFINITY
	/// Whether non-spawner items should be removed from the shared loot pool after spawning.
	var/unique_picks = FALSE
	var/datum/spawn_pool_manager/spawn_pool_manager

/obj/effect/spawner/random/pool/Initialize(mapload)
	if(initialized)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	initialized = TRUE

	if(!spawn_pool_manager)
		stack_trace("No spawn pool manager provided to [src]([type])")
		return INITIALIZE_HINT_QDEL

	spawn_pool_manager.known_spawners |= src
	if(spawn_pool_manager && unique_picks && !(type in spawn_pool_manager.unique_spawners))
		spawn_pool_manager.unique_spawners[type] = loot.Copy()

/obj/effect/spawner/random/pool/generate_loot_list()
	if(unique_picks)
		var/list/unique_loot = spawn_pool_manager.unique_spawners[type]
		return unique_loot.Copy()

	return ..()

/obj/effect/spawner/random/pool/check_safe(type_path_to_make)
	if(!..())
		return FALSE

	log_chat_debug("type_path=[type_path_to_make] point_value=[point_value] available=[spawn_pool_manager.available_points]")
	if(ispath(type_path_to_make, /obj/effect/spawner/random/pool))
		return TRUE

	if(!spawn_pool_manager.can_afford(point_value))
		return FALSE

	spawn_pool_manager.consume(point_value)
	if(unique_picks)
		// We may have multiple instances of a given type
		// so just remove the first instance we find
		var/list/unique_spawners = spawn_pool_manager.unique_spawners[type]
		unique_spawners.Remove(type_path_to_make)

	return TRUE
