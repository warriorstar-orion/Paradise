/// Approximate lower bound of the walkable land area on Lavaland, north of the southern lava border.
#define LAVALAND_MIN_CAVE_Y 10
/// Approximate upper bound of the walkable land area on Lavaland, south of the Legion entrance.
#define LAVALAND_MAX_CAVE_Y 222

/// Effective probability modifier for spawning flora and fauna in oases.
#define OASIS_SPAWNER_PROB_MODIFIER 43

/datum/caves_theme
	var/name = "Not Specified"

	var/seed
	var/perlin_accuracy = 5
	var/perlin_stamp_size = 10
	var/perlin_lower_range = 0
	var/perlin_upper_range = 0.3

/datum/caves_theme/New()
	seed = rand(1, 999999)

/datum/caves_theme/proc/setup()
	var/result = rustg_dbp_generate("[seed]", "[perlin_accuracy]", "[perlin_stamp_size]", "[world.maxx]", "[perlin_lower_range]", "[perlin_upper_range]")
	var/z = level_name_to_num(MINING)
	for(var/turf/T in block(1, 1, z, world.maxx, world.maxy, z))
		if(!istype(get_area(T), /area/lavaland/surface/outdoors/unexplored))
			continue
		if(!istype(T, /turf/simulated/mineral))
			continue
		var/c = result[world.maxx * (T.y - 1) + T.x]
		if(c == "1")
			T.ChangeTurf(/turf/simulated/floor/plating/asteroid/basalt/lava_land_surface)
			on_change(T)

		CHECK_TICK

/datum/caves_theme/proc/on_change(turf/T)
	if(prob(5))
		new /obj/effect/spawner/random/pool/lavaland/combined(T)
	else if(prob(5))
		new /obj/effect/spawner/random/flora/lavaland(T)

/datum/caves_theme/proc/safe_replace(turf/T)
	if(T.flags & NO_LAVA_GEN)
		return FALSE
	if(!istype(get_area(T), /area/lavaland/surface/outdoors/unexplored))
		return FALSE
	if(istype(T, /turf/simulated/floor/chasm))
		return FALSE
	if(istype(T, /turf/simulated/floor/lava/lava_land_surface))
		return FALSE
	if(istype(T, /turf/simulated/floor/lava/mapping_lava))
		return FALSE

	return TRUE

/datum/caves_theme/classic
	name = "Classic Caves"

/datum/caves_theme/burrows
	name = "Blocked Burrows"
	perlin_accuracy = 90
	perlin_stamp_size = 7
	perlin_lower_range = 0
	perlin_upper_range = 0.3

/datum/caves_theme/burrows/on_change(turf/T)
	if(prob(6))
		new /obj/structure/flora/ash/rock/style_random(T)
	else if(prob(5))
		new /obj/effect/spawner/random/pool/lavaland/combined(T)
	else if(prob(2))
		new /obj/effect/spawner/random/flora/lavaland(T)

/datum/caves_theme/deeprock/proc/maybe_make_room(turf/T)
	if(rand(1, 150) != 1)
		return

	for(var/turf/oasis_centroid in oasis_centroids)
		if(get_dist(T, oasis_centroid) < oasis_padding)
			return

	oasis_centroids |= T
	var/tempradius = rand(10, 15)
	var/probmodifer = OASIS_SPAWNER_PROB_MODIFIER * tempradius
	var/list/oasis_turfs = list()
	for(var/turf/NT in circlerangeturfs(T, tempradius))
		var/distance = (max(get_dist(T, NT), 1)) //Get dist throws -1 if same turf
		if(safe_replace(NT) && prob(min(probmodifer / distance, 100)))
			var/turf/changed = NT.ChangeTurf(/turf/simulated/floor/plating/asteroid/basalt/lava_land_surface)
			if(prob(15))
				new /obj/effect/spawner/random/pool/lavaland/combined(changed)
			else if (prob(5))
				new /obj/effect/spawner/random/flora/lavaland(T)

			oasis_turfs |= NT

	tempradius = round(tempradius / 3)
	var/oasis_laketype = pickweight(lake_weights)
	if(oasis_laketype == /turf/simulated/floor/plating/asteroid)
		new /obj/effect/spawner/oasisrock(T, tempradius)
	for(var/turf/oasis in circlerangeturfs(T, tempradius))
		if(safe_replace(oasis))
			oasis.ChangeTurf(oasis_laketype)
			oasis_turfs -= oasis

		// Move tendrils out of the oasis
		for(var/obj/structure/spawner/lavaland/O in circlerange(T, tempradius))
			O.forceMove(pick_n_take(oasis_turfs))

	return T

/datum/caves_theme/deeprock
	name = "Deadly Deeprock"
	perlin_stamp_size = 12
	perlin_lower_range = 0
	perlin_upper_range = 0.2
	var/oasis_padding = 50
	var/list/oasis_centroids = list()
	var/lake_weights = list(
		/turf/simulated/floor/lava/lava_land_surface = 4,
		/turf/simulated/floor/lava/lava_land_surface/plasma = 4,
		/turf/simulated/floor/chasm/straight_down/lava_land_surface = 4,
		/turf/simulated/floor/lava/mapping_lava = 6,
		/turf/simulated/floor/beach/away/water/lavaland_air = 1,
		/turf/simulated/floor/plating/asteroid = 1
	)

/datum/caves_theme/deeprock/on_change(turf/T)
	if(prob(1))
		new /obj/effect/spawner/random/pool/lavaland/combined(T)
	else
		maybe_make_room(T)

#undef OASIS_SPAWNER_PROB_MODIFIER

#undef LAVALAND_MIN_CAVE_Y
#undef LAVALAND_MAX_CAVE_Y
