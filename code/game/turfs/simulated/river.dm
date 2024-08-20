#define RIVER_MAX_X 200
#define RIVER_MAX_Y 200

#define RIVER_MIN_X 50
#define RIVER_MIN_Y 50

GLOBAL_LIST_INIT(lavaland_river_turf_whitelist, typecacheof(list(
	/turf/simulated/mineral,
	/turf/simulated/floor/plating/asteroid/basalt/lava_land_surface
)))

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
	/// The turf used when a spread of the tile stops.
	var/shoreline_turf_type = /turf/simulated/floor/plating/asteroid/basalt/lava_land_surface

	/// The probability that a currently occurring path detour will end on each step.
	var/detour_end_prob = 20
	/// The probability that a path will begin to detour on each step.
	var/detour_begin_prob = 20
	/// The list of river waypoints that the spawner will attempt to connect together with rivers.
	var/list/river_waypoints = list()
	/// The number of iterations before another bridge placement is attempted.
	var/next_bridge_at = 100
	/// The current number of iterations until another bridge is placed.
	var/current_bridge = 0

/datum/river_spawner/New(target_z_, spread_prob_ = 25, spread_prob_loss_ = 11)
	target_z = target_z_
	spread_prob = spread_prob_
	spread_prob_loss = spread_prob_loss_

/// Generate a river between the bounds specified by (`min_x`, `min_y`) and
/// (`max_x`, `max_y`).
///
/// `nodes` is the number of unique points in those bounds the river will
/// connect to. Note that `nodes` says little about the resultant size of the
/// river due to its ability to detour far away from the direct path between them.
/datum/river_spawner/proc/generate(nodes = 4, min_x = RIVER_MIN_X, min_y = RIVER_MIN_Y, max_x = RIVER_MAX_X, max_y = RIVER_MAX_Y)
	var/num_spawned = 0
	var/list/possible_locs = block(min_x, min_y, target_z, max_x, max_y, target_z)
	while(num_spawned < nodes && length(possible_locs))
		var/turf/T = pick(possible_locs)
		var/area/A = get_area(T)
		if(!istype(A, whitelist_area_type) || (T.flags & NO_LAVA_GEN))
			possible_locs -= T
		else
			river_waypoints += new /obj/effect/landmark/river_waypoint(T)
			num_spawned++

	//make some randomly pathing rivers
	for(var/A in river_waypoints)
		var/obj/effect/landmark/river_waypoint/W = A
		if(W.z != target_z || W.connected)
			continue
		W.connected = TRUE
		var/turf/cur_turf = get_turf(W)
		maybe_replace_turf(cur_turf)
		var/turf/target_turf = get_turf(pick(river_waypoints - W))
		if(!target_turf)
			break
		var/detouring = FALSE
		var/cur_dir = get_dir(cur_turf, target_turf)
		while(cur_turf != target_turf)
			if(detouring) //randomly snake around a bit
				if(prob(detour_end_prob))
					detouring = FALSE
					cur_dir = get_dir(cur_turf, target_turf)
			else if(prob(detour_begin_prob))
				detouring = TRUE
				if(prob(50))
					cur_dir = turn(cur_dir, 45)
				else
					cur_dir = turn(cur_dir, -45)
			else
				cur_dir = get_dir(cur_turf, target_turf)

			cur_turf = get_step(cur_turf, cur_dir)
			if(isnull(cur_turf)) //This might be the fuck up. Kill the loop if this happens
				stack_trace("Encountered a null turf in river loop, target turf was [target_turf], x=[target_turf.x], y=[target_turf.y].")
				break
			if(cur_turf.flags & NO_LAVA_GEN)
				detouring = FALSE
				cur_dir = get_dir(cur_turf, target_turf)
				cur_turf = get_step(cur_turf, cur_dir)
				continue
			else
				var/turf/river_turf = make_river_turf(cur_turf)
				spread_turf(river_turf, spread_prob, spread_prob_loss)

	for(var/WP in river_waypoints)
		qdel(WP)

	river_waypoints.Cut()

/datum/river_spawner/proc/make_river_turf(turf/T)
	return maybe_replace_turf(T, river_turf_type)

/datum/river_spawner/proc/make_shoreline_turf(turf/T)
	return maybe_replace_turf(T, shoreline_turf_type)

/// Convert the given turf to the given turf type, taking into account all
/// procedural generation safety checks for permitted area and turf types.
/datum/river_spawner/proc/maybe_replace_turf(turf/T, new_turf_type)
	if(istype(T, new_turf_type))
		return T
	if(!istype(get_area(T), whitelist_area_type))
		return T
	if(!is_type_in_typecache(T, GLOB.lavaland_river_turf_whitelist))
		return T

	return change_success(T.ChangeTurf(new_turf_type, ignore_air = TRUE))

/// Called whenever the river spawner successfully replaces a turf.
/// Must always return the turf that was passed in.
/datum/river_spawner/proc/change_success(turf/T)
	current_bridge++
	if(current_bridge >= next_bridge_at)
		current_bridge = 0
		new /obj/effect/spawner/bridge(T)

	return T

/datum/river_spawner/proc/spread_turf(turf/start_turf, probability = 30, prob_loss = 25)
	if(probability <= 0)
		return
	var/list/cardinal_turfs = list()
	var/list/diagonal_turfs = list()

	for(var/turf/T in RANGE_TURFS(1, start_turf) - start_turf)
		var/area/new_area = get_area(T)
		if(!T || istype(T, /turf/simulated/floor/indestructible) || (!istype(new_area, whitelist_area_type)) || (T.flags & NO_LAVA_GEN))
			continue

		if(get_dir(start_turf, T) in GLOB.cardinal)
			cardinal_turfs += T
		else
			diagonal_turfs += T

	for(var/turf/T in cardinal_turfs) //cardinal turfs are always changed but don't always spread
		make_river_turf(T)

		if(prob(probability))
			spread_turf(T, probability - prob_loss, prob_loss)

	for(var/turf/T in diagonal_turfs) //diagonal turfs only sometimes change, but will always spread if changed
		if(prob(probability))
			make_river_turf(T)
			spread_turf(T, probability - prob_loss, prob_loss)
		else
			make_shoreline_turf(T)

#undef RIVER_MAX_X
#undef RIVER_MAX_Y

#undef RIVER_MIN_X
#undef RIVER_MIN_Y
