#define ICON_SPLIT_X 16
#define ICON_SPLIT_Y 21

/datum/stovetop_burner
	var/obj/machinery/cooking/stove/parent
	var/temperature = "Low"
	var/timer = 0
	var/timerstamp = 0
	var/switches = 0
	var/cooking_timestamp = 0
	var/obj/placed_item
	var/burn_callback
	var/fire_callback

/datum/stovetop_burner/New(obj/machinery/cooking/stove/parent_)
	. = ..()
	parent = parent_

/datum/stovetop_burner/proc/handle_cooking(mob/user, set_timer = FALSE)
	var/obj/item/reagent_containers/cooking/container = placed_item
	if(!istype(placed_item))
		return

	var/reference_time = set_timer ? timer : world.time - cooking_timestamp

	if(container.stove_data[temperature])
		container.stove_data[temperature] += reference_time
	else
		container.stove_data[temperature] = reference_time

	container.new_process_item(user, parent)

/datum/stovetop_burner/proc/handle_switch(mob/user)
	playsound(parent, 'sound/items/lighter.ogg', 100, 1, 0)
	if(switches == 1)
		handle_cooking(user)
		switches = 0
		timerstamp = world.time
		cooking_timestamp = world.time
	else
		switches = 1
		cooking_timestamp = world.time
		cook_checkin()
		if(timer)
			timer_act(user)

	parent.update_appearance(UPDATE_ICON)

/datum/stovetop_burner/proc/cook_checkin()
	if(placed_item)
		var/old_timestamp = cooking_timestamp
		var/burn_time = CWJ_BURN_TIME_LOW
		var/fire_time = CWJ_IGNITE_TIME_LOW
		switch(temperature)
			if(J_MED)
				burn_time = CWJ_BURN_TIME_MEDIUM
				fire_time = CWJ_IGNITE_TIME_MEDIUM
			if(J_HI)
				burn_time = CWJ_BURN_TIME_HIGH
				fire_time = CWJ_IGNITE_TIME_HIGH

		burn_callback = addtimer(CALLBACK(src, PROC_REF(handle_burn), burn_time, TIMER_STOPPABLE))
		fire_callback = addtimer(CALLBACK(src, PROC_REF(handle_fire), fire_time, TIMER_STOPPABLE))

/datum/stovetop_burner/proc/timer_act(mob/user)
	timerstamp = round(world.time)
	var/old_timerstamp = timerstamp
	addtimer(CALLBACK(src, PROC_REF(turn_off), user), timer)
	parent.update_appearance(UPDATE_ICON)

/datum/stovetop_burner/proc/turn_off(mob/user)
	playsound(parent, 'sound/items/lighter.ogg', 100, 1, 0)
	handle_cooking(user, set_timer = TRUE)
	switches = 0
	timerstamp = world.time
	cooking_timestamp = world.time
	parent.update_appearance(UPDATE_ICON)
	kill_timers()

/datum/stovetop_burner/proc/handle_burn()
	var/obj/item/reagent_containers/cooking/container = placed_item
	if(istype(container))
		container.handle_burning()

/datum/stovetop_burner/proc/handle_fire()
	var/obj/item/reagent_containers/cooking/container = placed_item
	if(istype(container) && container.handle_ignition())
		parent.on_fire = TRUE

/datum/stovetop_burner/proc/kill_timers()
	deltimer(burn_callback)
	deltimer(fire_callback)

/obj/machinery/cooking/stove
	name = "Stovetop"
	desc = "A set of four burners for cooking food."
	#warn fix desc info
	// description_info = "Ctrl+Click: Set Temperatures / Timers. \nShift+Ctrl+Click: Turn on a burner.\nAlt+Click: Empty container of physical food."
	icon = 'icons/obj/cwj_cooking/stove.dmi'
	icon_state = "stove"
	density = FALSE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	cooking = FALSE

	var/list/burners[4]

	var/reference_time = 0 //The exact moment when we call the process routine, just to account for lag.
	var/power_cost = 2500 //Power cost per process step for a particular burner
	var/check_on_10 = 0

	var/on_fire = FALSE //if the stove has caught fire or not.

	#warn fix circuit
	// circuit = /obj/item/circuitboard/cooking/stove

/obj/machinery/cooking/stove/Initialize(mapload)
	. = ..()

	component_parts = list()
	component_parts += new /obj/item/circuitboard/cooking/stove(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/capacitor(null)

	for(var/i in 1 to 4)
		burners[i] = new/datum/stovetop_burner(src)

	RefreshParts()

/obj/machinery/cooking/stove/process()
	//if(on_fire)
		//Do bad things if it is on fire.
	for(var/datum/stovetop_burner/burner in burners)
		if(burner.switches)
			burner.handle_cooking(null, set_timer = FALSE)

	//Under normal circumstances, Only process the rest of this 10 process calls; it doesn't need to be hyper-accurate.
	if(check_on_10 != 10)
		check_on_10++
		return
	else
		check_on_10 = 0

	var/used_power = 0
	for(var/datum/stovetop_burner/burner in burners)
		if(burner.switches)
			used_power += power_cost

	use_power(used_power)

/obj/machinery/cooking/stove/RefreshParts()
	..()
	var/man_rating = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating
	quality_mod = round(man_rating/2)

/obj/machinery/cooking/stove/proc/handle_burn(input)
	if(!(items[input] && istype(items[input], /obj/item/reagent_containers/cooking)))
		return

	var/obj/item/reagent_containers/cooking/container = items[input]
	container.handle_burning()

/obj/machinery/cooking/stove/proc/handle_fire(input)
	if(!(items[input] && istype(items[input], /obj/item/reagent_containers/cooking)))
		return

	var/obj/item/reagent_containers/cooking/container = items[input]
	if(container.handle_ignition())
		on_fire = TRUE

// Retrieve which quadrant of the stovetop is being used.
/obj/machinery/cooking/stove/proc/getInput(modifiers)
	var/input
	var/icon_x = text2num(modifiers["icon-x"])
	var/icon_y = text2num(modifiers["icon-y"])
	if(icon_x <= ICON_SPLIT_X && icon_y <= ICON_SPLIT_Y)
		input = 1
	else if(icon_x > ICON_SPLIT_X && icon_y <= ICON_SPLIT_Y)
		input = 2
	else if(icon_x <= ICON_SPLIT_X && icon_y > ICON_SPLIT_Y)
		input = 3
	else if(icon_x > ICON_SPLIT_X && icon_y > ICON_SPLIT_Y)
		input = 4

	#ifdef CWJ_DEBUG
	log_debug("cooking_with_jane/stove/proc/getInput returned burner [input]. icon-x: [click_params["icon-x"]], icon-y: [click_params["icon-y"]]")
	#endif
	return input

/obj/machinery/cooking/stove/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	#warn fix default deconstruct
	// if(default_deconstruction(used_item, user))
	// 	return

	var/input = getInput(modifiers)
	var/datum/stovetop_burner/burner = burners[input]
	if(burner.placed_item)
		var/obj/item/reagent_containers/cooking/container = burner.placed_item
		container.process_item(used, user)
	else if(istype(used, /obj/item/reagent_containers/cooking/pot) || istype(used, /obj/item/reagent_containers/cooking/pan))
		to_chat(usr, "<span class='notice'>You put [used] on \the [src].</span>")
		if(usr.drop_item())
			used.forceMove(src)
		burner.placed_item = used
		if(burner.switches == 1)
			burner.cooking_timestamp = world.time

	update_appearance(UPDATE_ICON)
	return ITEM_INTERACT_COMPLETE

/obj/machinery/cooking/stove/attack_hand(mob/user, params)
	var/input = getInput(params2list(params))
	var/datum/stovetop_burner/burner = burners[input]
	if(burner.placed_item)
		if(burner.switches == 1)
			burner.handle_cooking(user)
			burner.cooking_timestamp = world.time
			var/mob/living/carbon/human/burn_victim = user
			if(istype(burn_victim) && !burn_victim.gloves)
				var/which_hand = "l_hand"
				if(!burn_victim.hand)
					which_hand = "r_hand"
				switch(burner.temperature)
					if(J_HI)
						burn_victim.adjustFireLossByPart(5, which_hand)
					if(J_MED)
						burn_victim.adjustFireLossByPart(2, which_hand)
					if(J_LO)
						burn_victim.adjustFireLossByPart(1, which_hand)

				to_chat(burn_victim, "<span class='danger'>You burn your hand a little taking the [burner.placed_item] off of the stove.</span>")
		user.put_in_hands(burner.placed_item)
		burner.placed_item = null
		update_appearance(UPDATE_ICON)

/obj/machinery/cooking/stove/CtrlClick(mob/user, modifiers)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return

	var/input = getInput(modifiers)
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/CtrlClick called on burner [input]")
	#endif
	var/choice = alert(user,"Select an action for burner #[input]","Select One:","Set temperature","Set timer","Cancel")
	switch(choice)
		if("Set temperature")
			handle_temperature(user, input)
		if("Set timer")
			handle_timer(user, input)

//Switch the cooking device on or off
/obj/machinery/cooking/stove/CtrlShiftClick(mob/user, modifiers)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return
	var/input = getInput(modifiers)
	var/datum/stovetop_burner/burner = burners[input]
	burner.handle_switch(user)

//Empty a container without a tool
/obj/machinery/cooking/stove/AltClick(mob/user, modifiers)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return

	var/input = getInput(modifiers)
	var/datum/stovetop_burner/burner = burners[input]
	var/obj/item/reagent_containers/cooking/container = burner.placed_item
	if(!(istype(container)))
		return

	container.do_empty(user)
	burner.kill_timers()

/obj/machinery/cooking/stove/proc/handle_temperature(mob/user, input)
	var/datum/stovetop_burner/burner = burners[input]
	var/old_temp = burner.temperature
	var/choice = input(user,"Select a heat setting for burner #[input].\nCurrent temp :[old_temp]","Select Temperature",old_temp) in list("High","Medium","Low","Cancel")
	if(choice && choice != "Cancel" && choice != old_temp)
		burner.temperature = choice
		if(burner.switches == 1)
			burner.handle_cooking(user)
			burner.cooking_timestamp = world.time
			burner.timerstamp = world.time

/obj/machinery/cooking/stove/proc/handle_timer(mob/user, input)
	var/datum/stovetop_burner/burner = burners[input]
	var/old_time = burner.timer ? round((burner.timer / (1 SECONDS)), 1 SECONDS): 1
	burner.timer = (input(user, "Enter a timer for burner #[input] (In Seconds, 0 Stays On)","Set Timer", old_time) as num) SECONDS
	if(burner.timer != 0 && burner.switches == 1)
		burner.timer_act(user)

	update_appearance(UPDATE_ICON)

/obj/machinery/cooking/stove/update_icon()
	..()
	cut_overlays()

	for(var/obj/item/our_item in vis_contents)
		remove_from_visible(our_item)

	if(panel_open)
		icon_state="stove_open"
	else
		icon_state="stove"

	var/stove_on = FALSE
	for(var/i in 1 to length(burners))
		var/datum/stovetop_burner/burner = burners[i]
		if(burner.switches == TRUE)
			if(!stove_on)
				stove_on = TRUE
			add_overlay(image(icon, icon_state = "[panel_open?"open_":""]burner_[i]"))

	if(stove_on)
		add_overlay(image(icon, icon_state = "indicator"))

	for(var/i in 1 to length(burners))
		var/datum/stovetop_burner/burner = burners[i]
		if(!burner.placed_item)
			continue
		var/obj/item/our_item = burner.placed_item
		switch(i)
			if(1)
				our_item.pixel_x = -7
				our_item.pixel_y = 0
			if(2)
				our_item.pixel_x = 7
				our_item.pixel_y = 0
			if(3)
				our_item.pixel_x = -7
				our_item.pixel_y = 9
			if(4)
				our_item.pixel_x = 7
				our_item.pixel_y = 9
		src.add_to_visible(our_item, i)
		if(burner.switches == 1)
			add_overlay(image(src.icon, icon_state="steam_[i]", layer=ABOVE_OBJ_LAYER))

/obj/machinery/cooking/stove/proc/add_to_visible(var/obj/item/our_item, input)
	our_item.vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	src.vis_contents += our_item
	if(input == 2 || input == 4)
		var/matrix/M = matrix()
		M.Scale(-1,1)
		our_item.transform = M
	our_item.transform *= 0.8

/obj/machinery/cooking/stove/proc/remove_from_visible(var/obj/item/our_item, input)
	our_item.vis_flags = 0
	our_item.blend_mode = 0
	our_item.transform =  null
	src.vis_contents.Remove(our_item)

/obj/machinery/cooking/stove/verb/toggle_burner_1()
	set src in view(1)
	set name = "Stove burner 1 - Toggle"
	set category = "Object"
	set desc = "Turn on a burner on the stove"
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/toggle_burner_1() called to toggle burner 1")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_switch(usr, 1)

/obj/machinery/cooking/stove/verb/toggle_burner_2()
	set src in view(1)
	set name = "Stove burner 2 - Toggle"
	set category = "Object"
	set desc = "Turn on a burner on the stove"
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/toggle_burner_2() called to toggle burner 2")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_switch(usr, 2)

/obj/machinery/cooking/stove/verb/toggle_burner_3()
	set src in view(1)
	set name = "Stove burner 3 - Toggle"
	set category = "Object"
	set desc = "Turn on a burner on the stove"
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/toggle_burner_3() called to toggle burner 3")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_switch(usr, 3)

/obj/machinery/cooking/stove/verb/toggle_burner_4()
	set src in view(1)
	set name = "Stove burner 4 - Toggle"
	set category = "Object"
	set desc = "Turn on a burner on the stove"
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/toggle_burner_4() called to toggle burner 4")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_switch(usr, 4)

/obj/machinery/cooking/stove/verb/change_temperature_1()
	set src in view(1)
	set name = "Stove burner 1 - Set Temp"
	set category = "Object"
	set desc = "Set a temperature for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_temperature_1() called to change temperature on 1")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_temperature(usr, 1)

/obj/machinery/cooking/stove/verb/change_temperature_2()
	set src in view(1)
	set name = "Stove burner 2 - Set Temp"
	set category = "Object"
	set desc = "Set a temperature for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_temperature_2() called to change temperature on 2")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_temperature(usr, 2)

/obj/machinery/cooking/stove/verb/change_temperature_3()
	set src in view(1)
	set name = "Stove burner 3 - Set Temp"
	set category = "Object"
	set desc = "Set a temperature for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_temperature_3() called to change temperature on 3")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_temperature(usr, 3)

/obj/machinery/cooking/stove/verb/change_temperature_4()
	set src in view(1)
	set name = "Stove burner 4 - Set Temp"
	set category = "Object"
	set desc = "Set a temperature for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_temperature_4() called to change temperature on 4")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_temperature(usr, 4)

/obj/machinery/cooking/stove/verb/change_timer_1()
	set src in view(1)
	set name = "Stove burner 1 - Set Timer"
	set category = "Object"
	set desc = "Set a timer for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_timer_1() called to change timer on 1")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_timer(usr, 1)

/obj/machinery/cooking/stove/verb/change_timer_2()
	set src in view(1)
	set name = "Stove burner 2 - Set Timer"
	set category = "Object"
	set desc = "Set a timer for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_timer_2() called to change timer on 2")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_timer(usr, 2)

/obj/machinery/cooking/stove/verb/change_timer_3()
	set src in view(1)
	set name = "Stove burner 3 - Set Timer"
	set category = "Object"
	set desc = "Set a timer for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_timer_3() called to change timer on 3")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_timer(usr, 3)

/obj/machinery/cooking/stove/verb/change_timer_4()
	set src in view(1)
	set name = "Stove burner 4 - Set Timer"
	set category = "Object"
	set desc = "Set a timer for a burner."
	#ifdef CWJ_DEBUG
	log_debug("/cooking/stove/verb/change_timer_4() called to change timer on 4")
	#endif
	if(!ishuman(usr) && !isrobot(usr))
		return
	handle_timer(usr, 4)
#undef ICON_SPLIT_X
#undef ICON_SPLIT_Y
