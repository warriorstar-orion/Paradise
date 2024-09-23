#define ORE_VEIN_MAX_Y 240

// Each successive ore type will clobber placement of previous ores,
// so they should be sorted from least to most rare.
GLOBAL_LIST_INIT(ore_vein_noise_parameters, list(
	list(
		"ore_type" = /datum/ore/iron,
		"accuracy" = "10",
		"stamp_size" = "10",
		"lower_range" = "0.2",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/plasma,
		"accuracy" = "10",
		"stamp_size" = "10",
		"lower_range" = "0.25",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/titanium,
		"accuracy" = "50",
		"stamp_size" = "15",
		"lower_range" = "0.3",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/silver,
		"accuracy" = "50",
		"stamp_size" = "15",
		"lower_range" = "0.3",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/uranium,
		"accuracy" = "50",
		"stamp_size" = "15",
		"lower_range" = "0.35",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/gold,
		"accuracy" = "50",
		"stamp_size" = "15",
		"lower_range" = "0.35",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/diamond,
		"accuracy" = "50",
		"stamp_size" = "10",
		"lower_range" = "0.38",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/bluespace,
		"accuracy" = "50",
		"stamp_size" = "10",
		"lower_range" = "0.38",
		"upper_range" = "0.5",
	),
	list(
		"ore_type" = /datum/ore/gibtonite,
		"accuracy" = "50",
		"stamp_size" = "3",
		"lower_range" = "0.37",
		"upper_range" = "0.5",
	),
))

/datum/lavaland_theme
	/// Name of lavaland theme
	var/name = "Not Specified"
	/// Typepath of turf the `/turf/simulated/floor/lava/mapping_lava` will be changed to on Late Initialization
	var/turf/simulated/floor/primary_turf_type
	/// Icon state of planet present on background of station Z-level
	var/planet_icon_state
	var/list/built_bridges
	/// Icon for glass floors
	var/primary_turf_type_icon

/datum/lavaland_theme/New()
	if(!primary_turf_type)
		stack_trace("Turf type is `null` in `[type]` lavaland theme")
	else if(!ispath(primary_turf_type))
		stack_trace("Wrong turf type `[primary_turf_type.type]` in `[type]` lavaland theme")

	built_bridges = list()

/**
 * This proc should do all theme specific thing.
 * Now it only generates rivers, but it can do all stuff you desire.
 */
/datum/lavaland_theme/proc/setup()
	SHOULD_CALL_PARENT(TRUE)
	setup_ore_veins()
	setup_multisector()

/datum/lavaland_theme/proc/setup_ore_veins()
	for(var/zlvl in levels_by_trait(ORE_LEVEL))
		var/seed
		var/list/result[world.maxx * world.maxy]

		for(var/idx in 1 to length(GLOB.ore_vein_noise_parameters))
			seed = rand(1, 1e9)
			var/parameters = GLOB.ore_vein_noise_parameters[idx]
			var/ore_result = rustlibs_dbp_generate("[seed]", parameters["accuracy"], parameters["stamp_size"], "[world.maxx]", parameters["lower_range"], parameters["upper_range"])
			for(var/char in 1 to length(result))
				if(ore_result[char] == "1")
					result[char] = idx

			CHECK_TICK

		var/list/final_counts = list()
		for(var/turf/T in block(1, 1, zlvl, world.maxx, ORE_VEIN_MAX_Y, zlvl))
			var/cell = result[world.maxx * (T.y - 1) + T.x]
			if(!cell)
				continue
			if(!istype(get_area(T), /area/lavaland/surface/outdoors/unexplored))
				continue
			if(!istype(T, /turf/simulated/mineral/rock))
				continue

			var/parameters = GLOB.ore_vein_noise_parameters[cell]
			if(!(parameters["ore_type"] in final_counts))
				final_counts[parameters["ore_type"]] = 0
			final_counts[parameters["ore_type"]]++

			var/turf/simulated/mineral/M = T
			if(rand(1, 2000) == 1)
				if(prob(50))
					M.set_ore(/datum/ore/bananium)
				else
					M.set_ore(/datum/ore/tranquillite)
			else
				M.should_reset_color = FALSE
				M.set_ore(parameters["ore_type"])

			CHECK_TICK

		for(var/i in final_counts)
			log_chat_debug("COUNT:[i]=[final_counts[i]]")

/datum/lavaland_theme/proc/setup_multisector()
	var/bridge_diameter = 14
	var/interval = 20
	for(var/zlvl in levels_by_trait(ORE_LEVEL))
		var/datum/space_level/level = GLOB.space_manager.get_zlev(zlvl)
		if(!built_bridges["[zlvl]"])
			built_bridges["[zlvl]"] = list()

		for(var/d in level.neighbors)
			if(d == Z_LEVEL_SOUTH)
				var/datum/space_level/connected = level.get_connection(Z_LEVEL_SOUTH)
				if(!built_bridges["[connected.zpos]"])
					built_bridges["[connected.zpos]"] = list()
				var/left_margin = TRANSITIONEDGE + 5
				while(left_margin < world.maxx - TRANSITIONEDGE)
					if(prob(50))
						var/left_edge = rand(left_margin, left_margin + bridge_diameter)
						var/loc = locate(left_edge, bridge_diameter / 2 + 1, level.zpos)
						var/datum/map_template/ruin/lavaland/zlvl_bridge/template = GLOB.lavaland_zlvl_bridge_templates["lavaland_zlvl_bridge_vertical_1.dmm"]
						template.load(loc, centered = TRUE)
						// now make sure we line up another bridge on the linked map
						loc = locate(left_edge, world.maxy - (bridge_diameter / 2) + 1, connected.zpos)
						template.load(loc, centered = TRUE)

					left_margin += interval

				built_bridges["[zlvl]"]["[connected.zpos]"] = Z_LEVEL_SOUTH
				built_bridges["[connected.zpos]"]["[zlvl]"] = Z_LEVEL_NORTH

			else if(d == Z_LEVEL_EAST)
				var/datum/space_level/connected = level.get_connection(Z_LEVEL_EAST)
				if(!built_bridges["[connected.zpos]"])
					built_bridges["[connected.zpos]"] = list()
				var/north_margin = TRANSITIONEDGE + 5
				while(north_margin < world.maxy - TRANSITIONEDGE)
					if(prob(50))
						var/north_edge = rand(north_margin, north_margin + bridge_diameter)
						var/loc = locate(bridge_diameter / 2, north_edge, level.zpos)
						var/datum/map_template/ruin/lavaland/zlvl_bridge/template = GLOB.lavaland_zlvl_bridge_templates["lavaland_zlvl_bridge_horizontal_1.dmm"]
						template.load(loc, centered = TRUE)
						// now make sure we line up another bridge on the linked map
						loc = locate(world.maxx - (bridge_diameter / 2) + 1, north_edge, connected.zpos)
						template.load(loc, centered = TRUE)

					north_margin += interval

				built_bridges["[zlvl]"]["[connected.zpos]"] = Z_LEVEL_EAST
				built_bridges["[connected.zpos]"]["[zlvl]"] = Z_LEVEL_WEST

/datum/lavaland_theme/proc/get_bridge_direction(z1, z2)
	if(z1 == z2)
		return null

	if(("[z1]" in built_bridges) && ("[z2]" in built_bridges["[z1]"]))
		return built_bridges["[z1]"]["[z2]"]
	if(("[z2]" in built_bridges) && ("[z1]" in built_bridges["[z2]"]))
		return built_bridges["[z2]"]["[z1]"]

	return null

/datum/lavaland_theme/lava
	name = "lava"
	primary_turf_type = /turf/simulated/floor/lava/lava_land_surface
	planet_icon_state = "planet_lava"
	primary_turf_type_icon = 'icons/turf/floors/lava.dmi'

/datum/lavaland_theme/lava/setup()
	. = ..()
	for(var/zlvl in levels_by_trait(ORE_LEVEL))
		var/datum/river_spawner/lava_spawner = new(zlvl)
		lava_spawner.generate()

/datum/lavaland_theme/plasma
	name = "plasma"
	primary_turf_type = /turf/simulated/floor/lava/lava_land_surface/plasma
	planet_icon_state = "planet_plasma"
	primary_turf_type_icon = 'icons/turf/floors/liquidplasma.dmi'

/datum/lavaland_theme/plasma/setup()
	. = ..()
	for(var/zlvl in levels_by_trait(ORE_LEVEL))
		var/datum/river_spawner/spawner = new(zlvl)
		spawner.generate(nodes = 2)
		spawner.generate(nodes = 2) // twice

/datum/lavaland_theme/chasm
	name = "chasm"
	primary_turf_type = /turf/simulated/floor/chasm/straight_down/lava_land_surface
	planet_icon_state = "planet_chasm"
	primary_turf_type_icon = 'icons/turf/floors/Chasms.dmi'

/datum/lavaland_theme/chasm/setup()
	. = ..()
	for(var/zlvl in levels_by_trait(ORE_LEVEL))
		var/datum/river_spawner/spawner = new(zlvl, spread_prob_ = 10, spread_prob_loss_ = 5)
		spawner.generate(nodes = 6, min_x = 50, min_y = 7, max_x = 250, max_y = 225)
