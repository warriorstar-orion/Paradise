/// Exterior lights use the powernet of the wall they're installed on,
/// not the tile they're placed on. This allows them to be in a different
/// area than the area that powers them, making it possible to have a light
/// "outside" a structure that shares its power state.
/obj/machinery/light/exterior

/obj/machinery/light/exterior/Initialize(mapload)
	. = ..()

	if(machine_powernet)
		machine_powernet.unregister_machine(src)
	var/turf/mounted = get_step(src, dir)
	var/area/area = get_area(mounted)
	register_to_powernet_in(area)

/obj/machinery/light/exterior/outdoors
	brightness_color = "#facd7f"
	nightshift_light_color = "#facd7f"
