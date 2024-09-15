
/obj/effect/spawner/random_room
	name = "random room spawner"
	var/dimensions = "0x0"

/obj/effect/spawner/random_room/Initialize(mapload)
	. = ..()
	SSlate_mapping.random_rooms += src

/obj/effect/spawner/random_room/Destroy()
	. = ..()
	SSlate_mapping.random_rooms -= src

/obj/effect/spawner/random_room/proc/payload()
	if(!length(SSmapping.random_room_templates[dimensions]))
		return

	var/datum/map_template/map_template = pick_n_take(SSmapping.random_room_templates[dimensions])
	var/turf/T = get_turf(src)

	map_template.load(T, centered = FALSE)
	log_debug("spawned [dimensions] room at [T.x],[T.y]")
	qdel(map_template)

/obj/effect/spawner/random_room/size3x3
	name = "3x3 random room spawner"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "random_room_3x3"
	dimensions = "3x3"
