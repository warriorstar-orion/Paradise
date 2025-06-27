#define LINK_STAGE_NOT_STARTED 0
#define LINK_STAGE_EXTERIOR_BUTTONS 1
#define LINK_STAGE_EXTERIOR_AIRLOCKS 2
#define LINK_STAGE_INTERIOR_BUTTONS 3
#define LINK_STAGE_INTERIOR_AIRLOCKS 4
#define LINK_STAGE_VENTS 5
#define LINK_STAGE_COMPLETE 6

/obj/item/mounted/frame/airlock_button
	name = "Airlock button frame"
	desc = "Used for building airlock buttons."
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "access_button_off"

	// external airlock buttons are expected to be placed in space
	mount_requirements = MOUNTED_FRAME_SIMFLOOR
	metal_sheets_refunded = 2

/obj/item/mounted/frame/airlock_button/do_build(turf/on_wall, mob/user)
	new /obj/machinery/access_button(get_turf(src), get_dir(user, on_wall))
	qdel(src)

/obj/item/mounted/frame/airlock_controller
	name = "Report this on GitHub."
	desc = "Report this on GitHub."
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "access_control_off"

	#warn add back, just so we can test in test_tiny
	mount_requirements = MOUNTED_FRAME_SIMFLOOR // | MOUNTED_FRAME_NOSPACE
	metal_sheets_refunded = 2

	var/obj/item/airlock_electronics/access_electronics
	var/link_stage = LINK_STAGE_NOT_STARTED
	var/result_controller_type

	var/list/interior_airlocks = list()
	var/list/interior_buttons = list()
	var/list/exterior_airlocks = list()
	var/list/exterior_buttons = list()

/obj/item/mounted/frame/airlock_controller/Destroy()
	. = ..()

	QDEL_NULL(access_electronics)

	interior_airlocks.Cut()
	interior_buttons.Cut()
	exterior_airlocks.Cut()
	exterior_buttons.Cut()

/obj/item/mounted/frame/airlock_controller/examine(mob/user)
	. = ..()

	if(istype(access_electronics))
		. += "<span class='notice'>Airlock electronics have been inserted to configure access for all its airlocks and buttons.</span>"
	else
		. += "<span class='notice'>Airlock electronics may be placed in it to configure access for all its airlocks and buttons.</span>"

	switch(link_stage)
		if(LINK_STAGE_NOT_STARTED)
			. += "<span class='notice'>It requires its exterior buttons linked next.</span>"
		if(LINK_STAGE_EXTERIOR_BUTTONS)
			. += "<span class='notice'>It requires its exterior airlocks linked next.</span>"
		if(LINK_STAGE_EXTERIOR_AIRLOCKS)
			. += "<span class='notice'>It requires its interior buttons linked next.</span>"
		if(LINK_STAGE_INTERIOR_BUTTONS)
			. += "<span class='notice'>It requires its interior airlocks linked next.</span>"

/obj/item/mounted/frame/airlock_controller/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(..())
		return ITEM_INTERACT_COMPLETE

	return attempt_item_link(user, target)

/obj/item/mounted/frame/airlock_controller/try_build(turf/on_wall, mob/user)
	. = ..()
	var/list/missing_items = get_missing_items()
	if(length(missing_items))
		to_chat(user, "<span class='notice'>[src] cannot be placed yet. It is missing at least one [english_list(missing_items)].</span>")
		return FALSE

	return TRUE

/obj/item/mounted/frame/airlock_controller/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	var/obj/item/airlock_electronics/airlock_electronics = used
	if(istype(airlock_electronics))
		if(istype(access_electronics))
			to_chat(user, "<span class='notice'>There is already \a [access_electronics] in [src].</span>")
		else
			if(user.unequip(used))
				access_electronics = airlock_electronics
				used.forceMove(src)
			else
				to_chat(user, "<span class='notice'>You can't put [airlock_electronics] in [src].</span>")

	return ..()

/obj/item/mounted/frame/airlock_controller/do_build(turf/on_wall, mob/user)
	var/obj/machinery/airlock_controller/controller = new result_controller_type(get_turf(src), get_dir(user, on_wall))
	setup_controller(controller)
	controller.link_all_items()
	qdel(src)

/obj/item/mounted/frame/airlock_controller/proc/get_missing_items()
	. = list()
	if(!length(exterior_buttons))
		. += "exterior button"
	if(!length(exterior_airlocks))
		. += "exterior airlock"
	if(!length(interior_buttons))
		. += "interior button"
	if(!length(interior_airlocks))
		. += "interior airlock"

/obj/item/mounted/frame/airlock_controller/proc/attempt_item_link(mob/user, atom/target)
	SHOULD_CALL_PARENT(TRUE)

	var/obj/machinery/door/airlock/external/airlock = target
	var/obj/machinery/access_button/button = target
	switch(link_stage)
		if(LINK_STAGE_COMPLETE)
			to_chat(user, "<span class='notice'>[src] has already been linked to its components.</span>")
			return ITEM_INTERACT_COMPLETE
		if(LINK_STAGE_NOT_STARTED)
			if(!istype(button))
				to_chat(user, "<span class='notice'>[src] must have its exterior buttons linked first.</span>")
				return TRUE
			link_stage = LINK_STAGE_EXTERIOR_BUTTONS
			return attempt_item_link(user, target)
		if(LINK_STAGE_EXTERIOR_BUTTONS)
			if(istype(button))
				to_chat(user, "<span class='notice'>You link [button] to [src].</span>")
				exterior_buttons |= button
				return ITEM_INTERACT_COMPLETE
			if(istype(airlock))
				link_stage = LINK_STAGE_EXTERIOR_AIRLOCKS
				return attempt_item_link(user, target)
		if(LINK_STAGE_EXTERIOR_AIRLOCKS)
			if(istype(airlock))
				to_chat(user, "<span class='notice'>You link [airlock] to [src].</span>")
				exterior_airlocks |= airlock
				return ITEM_INTERACT_COMPLETE
			if(istype(button))
				link_stage = LINK_STAGE_INTERIOR_BUTTONS
				return attempt_item_link(user, target)
		if(LINK_STAGE_INTERIOR_BUTTONS)
			if(istype(button))
				to_chat(user, "<span class='notice'>You link [button] to [src].</span>")
				interior_buttons |= airlock
				return ITEM_INTERACT_COMPLETE
			if(istype(airlock))
				link_stage = LINK_STAGE_INTERIOR_AIRLOCKS
				return attempt_item_link(user, target)
		if(LINK_STAGE_INTERIOR_AIRLOCKS)
			if(istype(airlock))
				to_chat(user, "<span class='notice'>You link [airlock] to [src].</span>")
				interior_airlocks |= airlock
				return ITEM_INTERACT_COMPLETE

/obj/item/mounted/frame/airlock_controller/proc/setup_controller(obj/machinery/airlock_controller/controller)
	for(var/obj/machinery/door/airlock/airlock in interior_airlocks)
		airlock.id_tag = controller.int_door_link_id
		if(access_electronics)
			access_electronics.apply_access_to(airlock)
	for(var/obj/machinery/access_button/button in interior_buttons)
		button.autolink_id = controller.int_button_link_id
		if(access_electronics)
			access_electronics.apply_access_to(button)
	for(var/obj/machinery/door/airlock/airlock in exterior_airlocks)
		airlock.id_tag = controller.ext_door_link_id
		if(access_electronics)
			access_electronics.apply_access_to(airlock)
	for(var/obj/machinery/access_button/button in exterior_buttons)
		button.autolink_id = controller.ext_button_link_id
		if(access_electronics)
			access_electronics.apply_access_to(button)

/obj/item/mounted/frame/airlock_controller/access_controller
	name = "Airlock access controller frame"
	result_controller_type = /obj/machinery/airlock_controller/access_controller

/obj/item/mounted/frame/airlock_controller/air_cycler
	name = "Cycling airlock controller frame"
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "airlock_control_off"
	result_controller_type = /obj/machinery/airlock_controller/air_cycler

	var/list/vents = list()

/obj/item/mounted/frame/airlock_controller/air_cycler/Destroy()
	. = ..()
	vents.Cut()

/obj/item/mounted/frame/airlock_controller/air_cycler/examine(mob/user)
	. = ..()
	switch(link_stage)
		if(LINK_STAGE_INTERIOR_AIRLOCKS)
			. += "<span class='notice'>It requires its vents linked next.</span>"

/obj/item/mounted/frame/airlock_controller/air_cycler/setup_controller(obj/machinery/airlock_controller/air_cycler/controller)
	. = ..()
	for(var/obj/machinery/atmospherics/unary/vent_pump/vent in vents)
		vent.autolink_id = controller.vent_link_id

/obj/item/mounted/frame/airlock_controller/air_cycler/attempt_item_link(mob/user, atom/target)
	. = ..()

	if(.)
		return

	var/obj/machinery/atmospherics/unary/vent_pump/vent = target
	switch(link_stage)
		if(LINK_STAGE_INTERIOR_AIRLOCKS)
			if(istype(vent))
				link_stage = LINK_STAGE_VENTS
				return attempt_item_link(user, target)
		if(LINK_STAGE_VENTS)
			if(istype(vent))
				to_chat(user, "<span class='notice'>You link [vent] to [src].</span>")
				vents |= vent
				return TRUE

/obj/item/mounted/frame/airlock_controller/air_cycler/get_missing_items()
	. = ..()
	if(!length(vents))
		. += "vent"

#undef LINK_STAGE_NOT_STARTED
#undef LINK_STAGE_EXTERIOR_BUTTONS
#undef LINK_STAGE_EXTERIOR_AIRLOCKS
#undef LINK_STAGE_INTERIOR_BUTTONS
#undef LINK_STAGE_INTERIOR_AIRLOCKS
#undef LINK_STAGE_VENTS
#undef LINK_STAGE_COMPLETE
