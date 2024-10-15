RESTRICT_TYPE(/datum/cooking/recipe_step/use_stove)

/datum/cooking/recipe_step/use_stove
	var/time
	var/temperature

/datum/cooking/recipe_step/use_stove/New(temperature_, time_, options)
	time = time_
	temperature = temperature_

	..(options)

/datum/cooking/recipe_step/use_stove/calculate_quality(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#warn increase quality based on component rating
	return 1

/datum/cooking/recipe_step/use_stove/check_conditions_met(obj/used_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)

	if(LAZYACCESSASSOC(container.cooker_data, COOKER_SURFACE_STOVE, temperature) >= time)
		return PCWJ_CHECK_VALID

	if(istype(used_item, /obj/machinery/cooking/stovetop))
		return PCWJ_CHECK_SILENT
	else
		return PCWJ_CHECK_INVALID

/datum/cooking/recipe_step/use_stove/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	var/list/step_data = list(target = added_item.UID())
	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)
	if(istype(container))
		step_data["cooker_data"] = container.cooker_data.Copy()

	return step_data

/datum/cooking/recipe_step/use_stove/attempt_autochef_perform(obj/machinery/autochef/autochef)
	var/obj/item/reagent_containers/cooking/container = autochef.current_container
	if(!container)
		autochef.atom_say("Lost container!")
		return FALSE
	for(var/obj/machinery/machine in autochef.linked_machines)
		var/obj/machinery/cooking/stovetop/stove = machine
		if(istype(stove))
			for(var/datum/cooking_surface/burner in stove.surfaces)
				if(!burner.placed_item || burner.placed_item == container)
					// Grab that shit
					container.Beam(stove, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
					stove.surface_item_interaction(null, container, burner)
					autochef.atom_say("Preparing on stove.")
					burner.timer = time
					burner.temperature = temperature
					if(burner.on)
						burner.handle_cooking(null)
						burner.timer_act(null)
					else
						burner.handle_switch(null)
					return AUTOCHEF_WAITING_ON_MACHINE

	return FALSE
