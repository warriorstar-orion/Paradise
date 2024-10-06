/datum/spawn_pool/lavaland_nature
	id = SPAWN_POOL_LAVALAND_NATURE
	available_points = 3000

/obj/effect/spawner/random/flora/lavaland
	loot = list(
		/obj/structure/flora/ash/cacti = 1,
		/obj/structure/flora/ash/cap_shroom = 2,
		/obj/structure/flora/ash/leaf_shroom = 2,
		/obj/structure/flora/ash/rock/style_random = 1,
		/obj/structure/flora/ash/stem_shroom = 2,
		/obj/structure/flora/ash/tall_shroom = 2,
	)

/obj/effect/spawner/random/pool/lavaland
	record_spawn = TRUE
	spawn_pool_id = SPAWN_POOL_LAVALAND_NATURE

	var/static/list/unsafe_turfs = list(
		/turf/simulated/floor/lava/lava_land_surface,
		/turf/simulated/floor/lava/lava_land_surface/plasma,
		/turf/simulated/floor/chasm/straight_down/lava_land_surface,
		/turf/simulated/floor/lava/mapping_lava,
		/turf/simulated/floor/beach/away/water/lavaland_air,
		/turf/simulated/wall/mineral,
	)
	var/mob_scan_range = 12
	var/megafauna_scan_range = 7


/obj/effect/spawner/random/pool/lavaland/check_safe(type_path_to_make)
	var/turf/T = get_turf(src)
	if(istype(T) && is_type_in_list(T, unsafe_turfs))
		return FALSE

	return ..()

/obj/effect/spawner/random/pool/lavaland/fauna
	point_value = 1
	loot = list(
		/obj/effect/landmark/mob_spawner/abandoned_minebot = 6,
		/obj/effect/landmark/mob_spawner/goldgrub = 10,
		/obj/effect/landmark/mob_spawner/goliath = 50,
		/obj/effect/landmark/mob_spawner/gutlunch = 4,
		/obj/effect/landmark/mob_spawner/legion = 30,
		/obj/effect/landmark/mob_spawner/watcher = 40,
	)

/obj/effect/spawner/random/pool/lavaland/fauna/check_safe(type_path_to_make)
	for(var/thing in urange(mob_scan_range, src))
		if((ishostile(thing) || istype(thing, /obj/structure/spawner) || istype(thing, /obj/effect/landmark/mob_spawner)))
			return FALSE

	return ..()

/obj/effect/spawner/random/pool/lavaland/tendril
	point_value = 50
	loot = list(
		/obj/structure/spawner/lavaland = 2,
		/obj/structure/spawner/lavaland/goliath = 3,
		/obj/structure/spawner/lavaland/legion = 3,
	)

/obj/effect/spawner/random/pool/lavaland/tendril/check_safe(type_path_to_make)
	for(var/thing in urange(mob_scan_range, src))
		if(istype(thing, /obj/structure/spawner/lavaland) && (get_dist(src, thing) <= LAVALAND_TENDRIL_COLLAPSE_RANGE))
			return FALSE

	return ..()


/obj/effect/spawner/random/pool/lavaland/megafauna
	point_value = 200
	loot = list(
		/mob/living/simple_animal/hostile/megafauna/dragon = 4,
		/mob/living/simple_animal/hostile/megafauna/colossus = 2,
	)

/obj/effect/spawner/random/pool/lavaland/megafauna/check_safe(type_path_to_make)
	if(!istype(get_area(src), /area/lavaland/surface/outdoors/unexplored/danger))
		return FALSE

	for(var/thing in urange(mob_scan_range, src))
		if(ismegafauna(thing) && (get_dist(src, thing) <= megafauna_scan_range))
			return FALSE

	return ..()

/obj/effect/spawner/random/pool/lavaland/megafauna/rare
	unique_picks = TRUE
	loot = list(
		/mob/living/simple_animal/hostile/megafauna/bubblegum,
		/mob/living/simple_animal/hostile/megafauna/ancient_robot,
	)

/obj/effect/spawner/random/pool/lavaland/record_item(type_path_to_make)
	if(ispath(type_path_to_make, /obj/effect/spawner))
		return

	SSblackbox.record_feedback("tally", "lavaland_mob_spawns", 1, "[type_path_to_make]")

/obj/effect/spawner/random/pool/lavaland/combined
	loot = list(
		/obj/effect/spawner/random/pool/lavaland/fauna = 4,

		/obj/effect/spawner/random/pool/lavaland/tendril,
		/obj/effect/spawner/random/pool/lavaland/megafauna,
		/obj/effect/spawner/random/pool/lavaland/megafauna/rare,
	)
