#define LONG_BRIDGE_THEME_CULT "cult"
#define LONG_BRIDGE_THEME_HIERO "hiero"
#define LONG_BRIDGE_THEME_CLOCKWORK "clockwork"
#define LONG_BRIDGE_THEME_STONE "stone"
#define LONG_BRIDGE_THEME_WOOD "wood"
#define LONG_BRIDGE_THEME_CATWALK "catwalk"

/obj/effect/spawner/long_bridge
	var/max_length = 8
	var/min_length = 4
	var/bridge_theme = LONG_BRIDGE_THEME_CULT
	var/direction

/obj/effect/spawner/long_bridge/Initialize(mapload)
	. = ..()
	bridge_theme = pick(
		LONG_BRIDGE_THEME_CULT,
		LONG_BRIDGE_THEME_HIERO,
		LONG_BRIDGE_THEME_CLOCKWORK,
		LONG_BRIDGE_THEME_STONE,
		LONG_BRIDGE_THEME_WOOD,
		LONG_BRIDGE_THEME_CATWALK,
	)
	return INITIALIZE_HINT_LATELOAD

/obj/effect/spawner/long_bridge/LateInitialize()
	if(!attempt_vertical_bridge())
		attempt_horizontal_bridge()

	qdel(src)

/obj/effect/spawner/long_bridge/proc/valid_landing(turf/T, direction)
	if(T.flags & LAVA_BRIDGE || T.flags & NO_LAVA_GEN)
		return FALSE

	var/turf/end = get_step(T, direction)
	if(!(ismineralturf(end) || istype(end, /turf/simulated/floor/plating/asteroid)))
		return FALSE

	return TRUE

/obj/effect/spawner/long_bridge/proc/valid_passage(turf/T)
	if(T.flags & LAVA_BRIDGE)
		return FALSE
	if(!istype(T, /turf/simulated/floor/lava/mapping_lava))
		return FALSE
	var/list/sides = direction == "vertical" ? list(EAST, WEST) : list(NORTH, SOUTH)
	if(!istype(get_step(T, sides[1]), /turf/simulated/floor/lava/mapping_lava))
		return FALSE
	if(!istype(get_step(T, sides[2]), /turf/simulated/floor/lava/mapping_lava))
		return FALSE

	return TRUE

/obj/effect/spawner/long_bridge/proc/make_pillar(turf/T)
	switch(bridge_theme)
		if(LONG_BRIDGE_THEME_CULT)
			T.ChangeTurf(/turf/simulated/wall/cult)
		if(LONG_BRIDGE_THEME_HIERO)
			T.ChangeTurf(/turf/simulated/wall/indestructible/hierophant)
		if(LONG_BRIDGE_THEME_CLOCKWORK)
			T.ChangeTurf(/turf/simulated/wall/clockwork)
		if(LONG_BRIDGE_THEME_STONE)
			T.ChangeTurf(/turf/simulated/wall/cult)
		if(LONG_BRIDGE_THEME_WOOD)
			T.ChangeTurf(/turf/simulated/wall/mineral/wood/nonmetal)
		if(LONG_BRIDGE_THEME_CATWALK)
			new /obj/structure/lattice/catwalk/mining(T)
			new /obj/structure/marker_beacon/dock_marker/collision(T)

	T.flags |= LAVA_BRIDGE

/obj/effect/spawner/long_bridge/proc/make_walkway(turf/T)
	switch(bridge_theme)
		if(LONG_BRIDGE_THEME_CULT)
			T.ChangeTurf(/turf/simulated/floor/engine/cult/lavaland_air)
		if(LONG_BRIDGE_THEME_HIERO)
			T.ChangeTurf(/turf/simulated/floor/indestructible/hierophant)
		if(LONG_BRIDGE_THEME_CLOCKWORK)
			T.ChangeTurf(/turf/simulated/floor/clockwork/lavaland_air)
		if(LONG_BRIDGE_THEME_STONE)
			switch(rand(1, 5))
				if(1)
					new /obj/structure/stone_tile/block(T)
					var/obj/structure/stone_tile/block/cracked/C = new(T)
					C.dir = NORTH
				if(2)
					new /obj/structure/stone_tile/slab(T)
				if(3)
					new /obj/structure/stone_tile/surrounding(T)
					new /obj/structure/stone_tile/center(T)
				if(4)
					new /obj/structure/stone_tile/slab/cracked(T)
				if(5)
					new /obj/structure/stone_tile/burnt(T)
					var/obj/structure/stone_tile/surrounding_tile/ST = new(T)
					ST.dir = WEST
					var/obj/structure/stone_tile/block/B = new(T)
					B.dir = NORTH
		if(LONG_BRIDGE_THEME_WOOD)
			T.ChangeTurf(/turf/simulated/floor/wood/lavaland_air)
			if(prob(20))
				new /obj/effect/landmark/damageturf(T)
		if(LONG_BRIDGE_THEME_CATWALK)
			new /obj/structure/lattice/catwalk/mining(T)

	T.flags |= LAVA_BRIDGE

/// Make a tile safe for player passage, for use at the bridge entrance and exits
/obj/effect/spawner/long_bridge/proc/cleanup_edge(turf/T)
	if(istype(T, /turf/simulated/floor/lava/mapping_lava))
		T.ChangeTurf(/turf/simulated/floor/plating/asteroid/basalt/lava_land_surface)
		T.icon_state = "basalt"

/obj/effect/spawner/long_bridge/proc/attempt_vertical_bridge()
	direction = "vertical"
	var/count = 1
	var/walk_dir = NORTH
	var/y_pos_walk = 1
	var/y_neg_walk = 1
	var/turf/y_pos_turf
	var/turf/y_neg_turf
	var/bad_passage = FALSE

	while(count <= max_length && !(y_pos_turf && y_neg_turf) && !bad_passage)
		switch(walk_dir)
			if(NORTH)
				if(!y_pos_turf)
					var/turf/next_turf = locate(x, y + y_pos_walk, z)
					if(valid_landing(next_turf, walk_dir))
						y_pos_turf = next_turf
					else if(!valid_passage(next_turf))
						bad_passage = TRUE
					else
						y_pos_walk++
					count++
				walk_dir = SOUTH
			if(SOUTH)
				if(!y_neg_turf)
					var/turf/next_turf = locate(x, y - y_neg_walk, z)
					if(valid_landing(next_turf, walk_dir))
						y_neg_turf = next_turf
					else if(!valid_passage(next_turf))
						bad_passage = TRUE
					else
						y_neg_walk++
					count++
				walk_dir = NORTH

	if(!bad_passage && count >= min_length && y_pos_turf && y_neg_turf)
		for(var/turf/T in get_line(y_pos_turf, y_neg_turf))
			make_walkway(T)
		for(var/turf/T in list(get_step(y_pos_turf, EAST), get_step(y_neg_turf, EAST), get_step(y_pos_turf, WEST), get_step(y_neg_turf, WEST)))
			make_pillar(T)
		for(var/turf/T in get_line(locate(x - 1, y_pos_turf.y + 1, z), locate(x + 1, y_pos_turf.y + 1, z)))
			cleanup_edge(T)
		for(var/turf/T in get_line(locate(x - 1, y_neg_turf.y - 1, z), locate(x + 1, y_neg_turf.y - 1, z)))
			cleanup_edge(T)

		return TRUE

/obj/effect/spawner/long_bridge/proc/attempt_horizontal_bridge()
	direction = "horizontal"
	var/count = 1
	var/walk_dir = EAST
	var/x_pos_walk = 1
	var/x_neg_walk = 1
	var/turf/x_pos_turf
	var/turf/x_neg_turf
	var/bad_passage = FALSE

	while(count <= max_length && !(x_pos_turf && x_neg_turf) && !bad_passage)
		switch(walk_dir)
			if(EAST)
				if(!x_pos_turf)
					var/turf/next_turf = locate(x + x_pos_walk, y, z)
					if(valid_landing(next_turf, walk_dir))
						x_pos_turf = next_turf
					else if(!valid_passage(next_turf))
						bad_passage = TRUE
					else
						x_pos_walk++
					count++
				walk_dir = WEST
			if(WEST)
				if(!x_neg_turf)
					var/turf/next_turf = locate(x - x_neg_walk, y, z)
					if(valid_landing(next_turf, walk_dir))
						x_neg_turf = next_turf
					else if(!valid_passage(next_turf))
						bad_passage = TRUE
					else
						x_neg_walk++
					count++
				walk_dir = EAST

	if(!bad_passage && count >= min_length && x_pos_turf && x_neg_turf)
		for(var/turf/T in get_line(x_pos_turf, x_neg_turf))
			make_walkway(T)
		for(var/turf/T in list(get_step(x_pos_turf, NORTH), get_step(x_neg_turf, NORTH), get_step(x_pos_turf, SOUTH), get_step(x_neg_turf, SOUTH)))
			make_pillar(T)
		for(var/turf/T in get_line(locate(x_neg_turf.x - 1, y + 1, z), locate(x_neg_turf.x - 1, y - 1, z)))
			cleanup_edge(T)
		for(var/turf/T in get_line(locate(x_pos_turf.x + 1, y + 1, z), locate(x_pos_turf.x + 1, y - 1, z)))
			cleanup_edge(T)

		return TRUE
