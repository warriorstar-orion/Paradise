#define SPAWN_MEGAFAUNA "bluh bluh huge boss"

GLOBAL_LIST_INIT(megafauna_spawn_list, list(
	/mob/living/simple_animal/hostile/megafauna/dragon = 4,
	/mob/living/simple_animal/hostile/megafauna/colossus = 2,
	/mob/living/simple_animal/hostile/megafauna/bubblegum = 6,
	/mob/living/simple_animal/hostile/megafauna/ancient_robot = 4,
))

/datum/river_spawner/caves
	river_turf_type = /turf/simulated/floor/plating/asteroid/basalt/lava_land_surface

	var/list/mob_spawns = list(
		/obj/effect/landmark/mob_spawner/abandoned_minebot = 6,
		/obj/effect/landmark/mob_spawner/goldgrub = 10,
		/obj/effect/landmark/mob_spawner/goliath = 50,
		/obj/effect/landmark/mob_spawner/gutlunch = 4,
		/obj/effect/landmark/mob_spawner/legion = 30,
		/obj/effect/landmark/mob_spawner/watcher = 40,

		/obj/structure/spawner/lavaland = 2,
		/obj/structure/spawner/lavaland/goliath = 3,
		/obj/structure/spawner/lavaland/legion = 3,

		SPAWN_MEGAFAUNA = 6,
	)

	var/list/flora_spawns = list(
		/obj/structure/flora/ash/cacti = 1,
		/obj/structure/flora/ash/cap_shroom = 2,
		/obj/structure/flora/ash/leaf_shroom = 2,
		/obj/structure/flora/ash/rock/style_random = 1,
		/obj/structure/flora/ash/stem_shroom = 2,
		/obj/structure/flora/ash/tall_shroom = 2,
	)

	/// The probability per successful tile generation of spawning flora.
	var/flora_spawn_prob = 12
	/// The probability per successful tile generation of spawning mobs or tendrils.
	var/mob_spawn_prob = 1

	/// The minimum number of tiles required between megafauna when spawning them.
	var/megafauna_scan_range = 7
	/// The minimum number of tiles required between mobs when spawning them.
	var/mob_scan_range = 12

	detour_end_prob = 30
	detour_begin_prob = 10

/datum/river_spawner/caves/New(target_z_)
	..(target_z_, spread_prob_ = 1, spread_prob_loss_ = 1)

/datum/river_spawner/caves/proc/spawn_mob(turf/T)
	if(!istype(get_area(T), whitelist_area_type))
		return

	var/mob_spawn = pickweight(mob_spawns)

	while(mob_spawn == SPAWN_MEGAFAUNA)
		if(istype(get_area(T), /area/lavaland/surface/outdoors/unexplored/danger)) //this is danger. it's boss time.
			mob_spawn = pickweight(GLOB.megafauna_spawn_list)
		else //this is not danger, don't spawn a boss, spawn something else
			mob_spawn = pickweight(mob_spawns)

	for(var/thing in urange(mob_scan_range, T))
		if(!ishostile(thing) && !istype(thing, /obj/structure/spawner))
			continue
		if(ispath(mob_spawn, /mob/living/simple_animal/hostile/megafauna) && ismegafauna(thing) && get_dist(T, thing) <= megafauna_scan_range)
			return
		// if the random is a standard mob, avoid spawning if there's another one within 12 tiles
		if(ispath(mob_spawn, /obj/effect/landmark/mob_spawner) || istype(thing, /mob/living/simple_animal/hostile/asteroid))
			return
		// prevents tendrils spawning in each other's collapse range
		if((ispath(mob_spawn, /obj/structure/spawner/lavaland) || istype(thing, /obj/structure/spawner/lavaland)) && get_dist(T, thing) <= 2)
			return

	new mob_spawn(T)

/datum/river_spawner/caves/proc/spawn_flora(turf/T)
	if(!istype(get_area(T), whitelist_area_type))
		return

	if(prob(flora_spawn_prob))
		var/flora_spawn = pickweight(flora_spawns)
		for(var/obj/structure/flora/ash/F in range(4, T)) //Allows for growing patches, but not ridiculous stacks of flora
			if(!istype(F, flora_spawn))
				return
		new flora_spawn(T)

/datum/river_spawner/caves/change_success(turf/T)
	if(istype(T, /turf/simulated/floor/chasm))
		return T
	if(istype(T, /turf/simulated/floor/lava/lava_land_surface))
		return T
	if(istype(T, /turf/simulated/floor/lava/mapping_lava))
		return T

	if(prob(mob_spawn_prob))
		spawn_mob(T)
	else if(prob(flora_spawn_prob))
		spawn_flora(T)

	return T

#undef SPAWN_MEGAFAUNA
