#define RIVER_MAX_X 230
#define RIVER_MAX_Y 200

#define RIVER_MIN_X 10
#define RIVER_MIN_Y 20

GLOBAL_LIST_EMPTY(river_waypoint_presets)

/obj/effect/landmark/river_waypoint
	name = "river waypoint"
	/// Whether the turf of this landmark has already been linked to others during river generation.
	var/connected = FALSE
	invisibility = INVISIBILITY_ABSTRACT

/// A straightforward system for making "rivers", paths made up of a specific
/// turf type that are generated in a random path on a z-level.
/datum/river_spawner
	/// The z-level to generate the river on. There is theoretically nothing stopping
	/// this from being used across z-levels, but we're keeping things simple.
	var/target_z
	/// The initial probability that a river tile will spread to adjacent tiles.
	var/spread_prob
	/// The amount reduced from spread_prob on every spread iteration to cause falloff.
	var/spread_prob_loss
	/// The base type that makes up the river.
	var/river_turf_type = /turf/simulated/floor/lava/mapping_lava
	/// The area that the spawner is allowed to spread or detour to.
	var/whitelist_area_type = /area/lavaland/surface/outdoors/unexplored
	/// The type that the spawner is allowed to spread or detour to.
	var/whitelist_turf_type = /turf/simulated/mineral
	/// The turf used when a spread of the tile stops.
	var/shoreline_turf_type = /turf/simulated/floor/plating/asteroid/basalt/lava_land_surface

/datum/river_spawner/New(target_z_, spread_prob_ = 25, spread_prob_loss_ = 10)
	target_z = target_z_
	spread_prob = spread_prob_
	spread_prob_loss = spread_prob_loss_

/datum/river_spawner/proc/safe_replace(turf/T)
	if(!T || !istype(T))
		return FALSE
	if(!istype(get_area(T), whitelist_area_type))
		return FALSE
	if(istype(T, river_turf_type))
		return FALSE
	if(!(istype(T, whitelist_turf_type) || istype(T, shoreline_turf_type)))
		return FALSE
	if(T.flags & NO_LAVA_GEN)
		return FALSE
	if(istype(T, /turf/simulated/floor/indestructible))
		return FALSE
	if(istype(T, /turf/simulated/wall/indestructible))
		return FALSE

	return TRUE

/// Generate a river between the bounds specified by (`min_x`, `min_y`) and
/// (`max_x`, `max_y`).
///
/// `nodes` is the number of unique points in those bounds the river will
/// connect to. Note that `nodes` says little about the resultant size of the
/// river due to its ability to detour far away from the direct path between them.
/datum/river_spawner/proc/generate(nodes = 4, min_x = RIVER_MIN_X, min_y = RIVER_MIN_Y, max_x = RIVER_MAX_X, max_y = RIVER_MAX_Y)
	var/list/river_nodes = list()
	var/num_spawned = 0

	var/list/possible_locs = block(min_x, min_y, target_z, max_x, max_y, target_z)
	while(num_spawned < nodes && length(possible_locs))
		// Random chance of pulling a pre-mapped river waypoint instead.
		if(length(GLOB.river_waypoint_presets) && prob(50))
			var/obj/effect/landmark/river_waypoint/waypoint = pick_n_take(GLOB.river_waypoint_presets)
			river_nodes += waypoint
			num_spawned++
		else
			var/turf/T = pick(possible_locs)
			if(safe_replace(T))
				river_nodes += new /obj/effect/landmark/river_waypoint(T)
				num_spawned++
			else
				log_chat_debug("skipping possible loc [T.x],[T.y],[T.z]")
				possible_locs -= T

	//make some randomly pathing rivers
	for(var/A in river_nodes)
		var/obj/effect/landmark/river_waypoint/W = A
		if(W.z != target_z || W.connected)
			continue
		W.connected = TRUE
		var/turf/cur_turf = get_turf(W)
		if(istype(get_area(cur_turf), whitelist_area_type) && !(cur_turf.flags & NO_LAVA_GEN))
			cur_turf.ChangeTurf(river_turf_type, ignore_air = TRUE)
		var/turf/target_turf = get_turf(pick(river_nodes - W))
		if(!target_turf)
			break
		var/detouring = 0
		var/cur_dir = get_dir(cur_turf, target_turf)
		while(cur_turf != target_turf)
			var/attempts = 100
			do
				if(detouring) //randomly snake around a bit
					if(prob(20))
						detouring = 0
						cur_dir = get_dir(cur_turf, target_turf)
				else if(prob(20))
					detouring = 1
					if(prob(50))
						cur_dir = turn(cur_dir, 45)
					else
						cur_dir = turn(cur_dir, -45)
				else
					cur_dir = get_dir(cur_turf, target_turf)
			// we may veer off the map entirely, returning a null turf; if so, go back and try again
			while(get_step(cur_turf, cur_dir) == null && attempts-- > 0)

			cur_turf = get_step(cur_turf, cur_dir)
			if(isnull(cur_turf))
				stack_trace("Encountered a null turf in river loop, target turf was [target_turf], x=[target_turf.x], y=[target_turf.y].")
				break
			if(safe_replace(cur_turf))
				var/turf/river_turf = cur_turf.ChangeTurf(river_turf_type, ignore_air = TRUE)
				if(prob(1))
					new /obj/effect/spawner/dynamic_bridge(river_turf)
				spread_turf(river_turf, spread_prob, spread_prob_loss)
			else
				detouring = 0
				cur_dir = get_dir(cur_turf, target_turf)
				cur_turf = get_step(cur_turf, cur_dir)

	QDEL_LIST_CONTENTS(river_nodes)

/datum/river_spawner/proc/spread_turf(turf/start_turf, probability, prob_loss)
	if(probability <= 0)
		return
	var/list/cardinal_turfs = list()
	var/list/diagonal_turfs = list()

	for(var/turf/T in RANGE_TURFS(1, start_turf) - start_turf)
		if(!safe_replace(T))
			continue

		if(get_dir(start_turf, T) in GLOB.cardinal)
			cardinal_turfs += T
		else
			diagonal_turfs += T

	for(var/turf/T in cardinal_turfs) //cardinal turfs are always changed but don't always spread
		if(!safe_replace(T))
			continue

		T.ChangeTurf(river_turf_type, ignore_air = TRUE)
		if(prob(probability))
			spread_turf(T, probability - prob_loss, prob_loss)
			if(prob(1))
				new /obj/effect/spawner/dynamic_bridge(T)

	for(var/turf/T in diagonal_turfs) //diagonal turfs only sometimes change, but will always spread if changed
		if(!safe_replace(T))
			continue

		if(prob(probability))
			T.ChangeTurf(river_turf_type, ignore_air = TRUE)
			spread_turf(T, probability - prob_loss, prob_loss)
		else if(istype(T, whitelist_turf_type))
			T.ChangeTurf(shoreline_turf_type, ignore_air = TRUE)
			if(prob(1))
				new /obj/effect/spawner/dynamic_bridge(T)

#undef RIVER_MAX_X
#undef RIVER_MAX_Y

#undef RIVER_MIN_X
#undef RIVER_MIN_Y
