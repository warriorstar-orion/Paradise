/obj/item/mounted/frame/airlock_button
	name = "Airlock button frame"
	desc = "Used for building airlock buttons."
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "access_button_off"

	#warn add back, just so we can test in test_tiny
	mount_requirements = MOUNTED_FRAME_SIMFLOOR // | MOUNTED_FRAME_NOSPACE
	metal_sheets_refunded = 2

/obj/item/mounted/frame/airlock_button/do_build(turf/on_wall, mob/user)
	new /obj/machinery/access_button(get_turf(src), get_dir(user, on_wall))
	qdel(src)

/obj/item/mounted/frame/airlock_controller
	name = "Report this on GitHub."
	desc = "Used for building airlock controllers."
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "airlock_control_off"

	#warn add back, just so we can test in test_tiny
	mount_requirements = MOUNTED_FRAME_SIMFLOOR // | MOUNTED_FRAME_NOSPACE
	metal_sheets_refunded = 2

/obj/item/mounted/frame/airlock_controller/access_controller
	name = "Airlock access controller frame"

/obj/item/mounted/frame/airlock_controller/access_controller/do_build(turf/on_wall, mob/user)
	new /obj/machinery/airlock_controller/access_controller(get_turf(src), get_dir(user, on_wall))
	qdel(src)

/obj/item/mounted/frame/airlock_controller/air_cycler
	name = "Cycling airlock controller frame"
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "airlock_control_off"

	#warn add back, just so we can test in test_tiny
	mount_requirements = MOUNTED_FRAME_SIMFLOOR // | MOUNTED_FRAME_NOSPACE
	metal_sheets_refunded = 2

/obj/item/mounted/frame/airlock_controller/air_cycler/do_build(turf/on_wall, mob/user)
	new /obj/machinery/airlock_controller/air_cycler(get_turf(src), get_dir(user, on_wall))
	qdel(src)

