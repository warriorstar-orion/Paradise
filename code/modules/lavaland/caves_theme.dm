/// Approximate lower bound of the walkable land area on Lavaland, north of the southern lava border.
#define LAVALAND_MIN_CAVE_Y 10
/// Approximate upper bound of the walkable land area on Lavaland, south of the Legion entrance.
#define LAVALAND_MAX_CAVE_Y 222

/datum/caves_theme
	var/name = "Not Specified"
	VAR_PROTECTED/cave_spawner_type = /datum/river_spawner/caves
	VAR_PRIVATE/datum/river_spawner/caves/caves_spawner

/datum/caves_theme/proc/setup()
	return

/// Frontload the river waypoints list of the cave tunnel spawner with turfs found when placing ruins.
/// This allows the caves spawner to consider them waypoints for the purposes of connecting with tunnels,
/// giving the impression that the tunnels are actually leading to/from those ruins.
/datum/caves_theme/proc/add_ruin_pois_to_river_waypoints(count)
	while(length(caves_spawner.river_waypoints) < count && length(GLOB.lavaland_tunnel_pois))
		var/turf/T = pick_n_take(GLOB.lavaland_tunnel_pois)
		log_chat_debug("Picked turf [T.x],[T.y]")
		caves_spawner.river_waypoints += new /obj/effect/landmark/river_waypoint(T)

/datum/caves_theme/classic
	name = "Classic Caves"

/datum/caves_theme/classic/setup()
	caves_spawner = new cave_spawner_type(level_name_to_num(MINING))
	for(var/i in 1 to 4)
		add_ruin_pois_to_river_waypoints(4)
		caves_spawner.generate(
			nodes = 4,
			min_x = 1,
			min_y = LAVALAND_MIN_CAVE_Y,
			max_x = world.maxx,
			max_y = LAVALAND_MAX_CAVE_Y)

/datum/river_spawner/caves/burrows
	flora_spawn_prob = 35 //Lots of folliage, lots of blockage

/datum/caves_theme/burrows
	name = "Blocked Burrows"
	cave_spawner_type = /datum/river_spawner/caves/burrows

/datum/caves_theme/burrows/setup()
	caves_spawner = new cave_spawner_type(level_name_to_num(MINING))
	caves_spawner.flora_spawns += list(/obj/structure/flora/ash/rock/style_random = 7)
	var/nodes = 4
	for(var/i in 1 to 4)
		add_ruin_pois_to_river_waypoints(nodes)
		caves_spawner.generate(
			nodes = nodes,
			min_x = 1,
			min_y = LAVALAND_MIN_CAVE_Y,
			max_x = world.maxx,
			max_y = LAVALAND_MAX_CAVE_Y)

/datum/river_spawner/caves/deeprock
	var/making_lake = FALSE
	var/list/oasis_centroids = list()
	var/oasis_radius = 50

	mob_spawn_prob = 5
	flora_spawn_prob = 10

	detour_begin_prob = 25
	detour_end_prob = 25

/datum/river_spawner/caves/deeprock/New(target_z_)
	. = ..()
	mob_scan_range = rand(4, 7) // denser mobs

/datum/river_spawner/caves/deeprock/change_success(turf/T)
	// only attempt a mob/flora spawn and return if we're already making a lake
	if(making_lake)
		return ..()

	if(rand(1, 200) != 1)
		return ..()

	for(var/turf/oasis_centroid in oasis_centroids)
		if(get_dist(T, oasis_centroid) < oasis_radius)
			return ..()

	making_lake = TRUE
	oasis_centroids |= T
	var/tempradius = rand(10, 15)
	var/probmodifer = 43 * tempradius //Yes this is a magic number, it is a magic number that works well.
	for(var/turf/NT in circlerangeturfs(T, tempradius))
		var/distance = (max(get_dist(T, NT), 1)) //Get dist throws -1 if same turf
		if(prob(min(probmodifer / distance, 100)))
			make_river_turf(NT)
	if(prob(50))
		tempradius = round(tempradius / 3)
		var/turf/oasis_lake = pickweight(list(/turf/simulated/floor/lava/lava_land_surface = 4, /turf/simulated/floor/lava/lava_land_surface/plasma = 4, /turf/simulated/floor/chasm/straight_down/lava_land_surface = 4, /turf/simulated/floor/lava/mapping_lava = 6, /turf/simulated/floor/beach/away/water/lavaland_air = 1, /turf/simulated/floor/plating/asteroid = 1))
		if(oasis_lake == /turf/simulated/floor/plating/asteroid)
			new /obj/effect/spawner/oasisrock(T, tempradius)
		for(var/turf/oasis in circlerangeturfs(T, tempradius))
			maybe_replace_turf(oasis, oasis_lake)

	making_lake = FALSE

	return T

/datum/caves_theme/deeprock
	name = "Deadly Deeprock"
	cave_spawner_type = /datum/river_spawner/caves/deeprock

/datum/caves_theme/deeprock/setup()
	caves_spawner = new cave_spawner_type(level_name_to_num(MINING))
	for(var/i in 1 to 2)
		add_ruin_pois_to_river_waypoints(2)
		caves_spawner.generate(
			nodes = 5,
			min_x = 1,
			min_y = LAVALAND_MIN_CAVE_Y,
			max_x = world.maxx,
			max_y = LAVALAND_MAX_CAVE_Y)


#undef LAVALAND_MIN_CAVE_Y
#undef LAVALAND_MAX_CAVE_Y
