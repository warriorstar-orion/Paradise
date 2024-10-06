/// Loot pool manager keeps track of the available points
/// for a given pool, as well as any spawners that need to
/// keep track globally of the number of any specific item
/// that they spawn.
/datum/spawn_pool_manager
	var/available_points = 0
	var/list/known_spawners = list()
	var/list/unique_spawners = list()

/datum/spawn_pool_manager/proc/can_afford(points)
	if(available_points >= points)
		return TRUE

	return FALSE

/datum/spawn_pool_manager/proc/consume(points)
	available_points -= points

/datum/spawn_pool_manager/proc/process_spawners()
	while(length(known_spawners))
		if(available_points <= 0)
			break

		var/obj/effect/spawner/random/pool/spawner = pick_n_take(known_spawners)
		if(spawner.point_value != INFINITY && available_points < spawner.point_value)
			qdel(spawner)
			continue

		spawner.spawn_loot()
		qdel(spawner)

	log_chat_debug("ending spawner process with [available_points] pts and [length(known_spawners)] spawners")
	QDEL_LIST_CONTENTS(known_spawners)

/datum/spawn_pool_manager/lavaland
	available_points = 3000
