// This subsystem is to initialize things which need to happen after SSatoms
// This is for things which can take a long period of time and shouldnt bog down SSatoms
// Use this for stuff like random room spawners or maze generators
// Basically, this manages atom-based maploaders
SUBSYSTEM_DEF(late_mapping)
	name = "Late Mapping"
	init_order = INIT_ORDER_LATE_MAPPING
	flags = SS_NO_FIRE
	/// List of all maze generators to process
	var/list/obj/effect/mazegen/generator/maze_generators = list()
	/// List of all bridge spawners to process
	var/list/obj/effect/spawner/bridge/bridge_spawners = list()
	/// List of all random room spawners to process
	var/list/obj/effect/spawner/random_room/random_rooms = list()

/datum/controller/subsystem/late_mapping/Initialize()
	if(length(maze_generators))
		var/watch = start_watch()
		log_startup_progress("Generating mazes...")

		for(var/i in maze_generators)
			var/obj/effect/mazegen/generator/MG = i
			MG.run_generator()

		var/list/mgcount = length(maze_generators) // Keeping track of this here because we wipe it next line down
		QDEL_LIST_CONTENTS(maze_generators)
		var/duration = stop_watch(watch)
		log_startup_progress("Generated [mgcount] mazes in [duration]s")

	if(length(bridge_spawners))
		var/watch = start_watch()
		log_startup_progress("Spawning bridges...")

		for(var/i in bridge_spawners)
			var/obj/effect/spawner/bridge/BS = i
			BS.generate_bridge()

		var/list/bscount = length(bridge_spawners) // Keeping track of this here because we wipe it next line down
		QDEL_LIST_CONTENTS(bridge_spawners)
		var/duration = stop_watch(watch)
		log_startup_progress("Spawned [bscount] bridges in [duration]s")

	if(length(random_rooms))
		var/watch = start_watch()
		log_startup_progress("Spawning random rooms...")

		for(var/i in random_rooms)
			var/obj/effect/spawner/random_room/RR = i
			RR.payload()

		var/list/rrcount = length(random_rooms)
		QDEL_LIST_CONTENTS(random_rooms)
		var/duration = stop_watch(watch)
		log_startup_progress("Spawned [rrcount] random rooms in [duration]s")
