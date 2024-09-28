/// Loot pool manager keeps track of the available points
/// for a given pool, as well as any spawners that need to
/// keep track globally of the number of any specific item
/// that they spawn.
/datum/loot_pool_manager
	var/available_points
	var/list/unique_spawners = list()

/datum/loot_pool_manager/New()
	// hardcoded for space atm
	available_points = rand(
		GLOB.configuration.ruins.space_loot_pool_min,
		GLOB.configuration.ruins.space_loot_pool_max)

/datum/loot_pool_manager/proc/consume(points)
	if(available_points < points)
		return FALSE

	available_points -= points
	return TRUE
