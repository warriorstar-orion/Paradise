/obj/machinery/cooking/ice_cream_mixer
	name = "Ice cream mixer"
	desc = "An industrial mixing device for desserts of all kinds."

	icon = 'icons/obj/cwj_cooking/eris_kitchen.dmi'
	icon_state = "cereal_off"

	var/on = FALSE
	active_power_consumption = 200
	var/check_on_10 = 0
	var/timer = 12 SECONDS
	var/reference_time = 0
	var/freezing_timestamp = 0
	var/obj/item
	var/timerstamp = 0

/obj/machinery/cooking/ice_cream_mixer/Initialize(mapload)
	. = ..()
	if(/obj/item/reagent_containers/cooking/icecream_bowl in GLOB.cwj_recipe_dictionary)
		for(var/datum/cooking/recipe/ice_cream/recipe in GLOB.cwj_recipe_dictionary[/obj/item/reagent_containers/cooking/icecream_bowl])
			allowed_inputs |= recipe.destination_object

/obj/machinery/cooking/ice_cream_mixer/process()
	if(on)
		handle_cooking()

	if(check_on_10 != 10)
		check_on_10++
		return
	else
		check_on_10 = 0

	if(on)
		use_power(active_power_consumption)

/obj/machinery/cooking/ice_cream_mixer/attack_hand(mob/user)
	if(item)
		user.put_in_hands(item)
		item = null

/obj/machinery/cooking/ice_cream_mixer/CtrlShiftClick(mob/user, params)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return

	#ifdef CWJ_DEBUG
	log_debug("/cooking/oven/CtrlShiftClick called")
	#endif
	handle_switch(user)

/obj/machinery/cooking/ice_cream_mixer/proc/turn_off(user)
	on = FALSE
	timerstamp = world.time
	freezing_timestamp = world.time
	icon_state = "cereal_off"
	update_appearance(UPDATE_ICON)

/obj/machinery/cooking/ice_cream_mixer/proc/handle_switch(mob/user)
	if(on)
		on = FALSE
		icon_state = "cereal_off"
	else
		on = TRUE
		icon_state = "cereal_on"
		timerstamp = round(world.time)
		var/old_timestamp = timerstamp
		addtimer(CALLBACK(src, PROC_REF(turn_off), user), timer)

	update_appearance(UPDATE_ICON)

/obj/machinery/cooking/ice_cream_mixer/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	if(used.type in allowed_inputs)
		if(user.drop_item(used))
			used.forceMove(src)

		return ITEM_INTERACT_COMPLETE

	if(istype(used, /obj/item/reagent_containers/cooking/icecream_bowl))
		to_chat(user, "<span class='notice'>You put a [used] on \the [src].</span>")
		if(user.drop_item(used))
			used.forceMove(src)
			item = used
			if(on)
				freezing_timestamp = world.time

		return ITEM_INTERACT_COMPLETE

/obj/machinery/cooking/ice_cream_mixer/proc/handle_cooking(mob/user, set_timer = FALSE)
	var/obj/item/reagent_containers/cooking/icecream_bowl/bowl = item
	if(!istype(bowl))
		return

	if(set_timer)
		reference_time = timer
	else
		reference_time = world.time - freezing_timestamp

	if(bowl.freezing_time)
		bowl.freezing_time += reference_time
	else
		bowl.freezing_time = reference_time

	bowl.new_process_item(user, src)
