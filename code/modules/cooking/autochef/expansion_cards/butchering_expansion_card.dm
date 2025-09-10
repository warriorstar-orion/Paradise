RESTRICT_TYPE(/obj/item/autochef_expansion_card/butchering)

/obj/item/autochef_expansion_card/butchering
	name = "\improper Autochef Expansion Card: Butchering"
	desc = "This rare expansion card enables autochefs to utilize food processors and shape meat."
	icon_state = "autochef_expansion_card_red"
	task_message = "Preparing"
	registerable_machines = list(
		/obj/machinery/processor,
	)
	var/static/list/meat_shaping = list(
		/obj/item/food/meat/patty_raw = /obj/item/food/ground_meat,
		/obj/item/food/meat/raw_meatball = /obj/item/food/meat/patty_raw,
		/obj/item/food/meat = /obj/item/food/grown/meatwheat,
	)
	var/static/list/processor_recipes

/obj/item/autochef_expansion_card/butchering/Initialize(mapload)
	. = ..()
	if(isnull(processor_recipes))
		processor_recipes = list()
		for(var/subtype in subtypesof(/datum/food_processor_process))
			var/datum/food_processor_process/process = subtype
			if(process::input)
				processor_recipes[process::output] = process:input

/obj/item/autochef_expansion_card/butchering/can_produce(obj/machinery/autochef/autochef, target_type)
	if(target_type in processor_recipes)
		return AUTOCHEF_ACT_VALID

	if(target_type in meat_shaping)
		return AUTOCHEF_ACT_VALID

	return FALSE

/obj/item/autochef_expansion_card/butchering/perform_step(datum/autochef_task/origin_task, target_type)
	switch(origin_task.current_state)
		if(AUTOCHEF_ACT_STARTED, AUTOCHEF_ACT_ADDED_TASK)
			if(target_type in processor_recipes)
				return attempt_processing(origin_task, target_type)
			else if(target_type in meat_shaping)
				return attempt_shaping(origin_task, target_type)

	return AUTOCHEF_ACT_FAILED

/obj/item/autochef_expansion_card/butchering/proc/attempt_processing(datum/autochef_task/origin_task, target_type)
	var/input_type = processor_recipes[target_type]
	for(var/obj/machinery/processor/processor in autochef.get_linked_objects(/obj/machinery/processor))
		if(length(processor.contents))
			continue

		if(processor.processing)
			continue

		if(!isInSight(autochef, processor))
			continue

		var/obj/resource = autochef.find_available_resource_of_type(input_type)
		if(istype(resource))
			var/obj/machinery/smartfridge/fridge = resource.loc
			resource.forceMove(processor)
			fridge.item_quants[resource.name]--
			fridge.Beam(processor, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
			fridge.update_appearance()

			var/datum/autochef_task/use_expansion_card/card_task = origin_task
			card_task.RegisterSignal(processor, COMSIG_MACHINE_PROCESS_COMPLETE, TYPE_PROC_REF(/datum/autochef_task/use_expansion_card, on_machine_process_complete))
			processor.activate()
			return AUTOCHEF_ACT_WAIT_FOR_RESULT

		if(autochef.upgrade_level > 2)
			var/datum/autochef_task/task = autochef.handle_missing_item(input_type)
			if(istype(task))
				autochef.add_task(task, origin_task)
				return AUTOCHEF_ACT_ADDED_TASK

		return AUTOCHEF_ACT_MISSING_INGREDIENT

	return AUTOCHEF_ACT_NO_AVAILABLE_MACHINES

/obj/item/autochef_expansion_card/butchering/proc/attempt_shaping(datum/autochef_task/origin_task, target_type)
	var/input_type = meat_shaping[target_type]

	var/obj/item/resource = autochef.find_available_resource_of_type(input_type)
	if(istype(resource))
		var/obj/machinery/smartfridge/fridge = resource.loc
		resource.forceMove(autochef)
		fridge.item_quants[resource.name]-- // love doing this still
		fridge.update_appearance()
		autochef.Beam(fridge, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)

		// ready for something horrifying? the three things we want to
		// hand-manipulate, ground meat, raw patties/meatballs, and meatwheat,
		// all have the same pattern: on activate_self(), they delete
		// themselves, spawn the new thing at the turf, and then put it in the
		// user's hand. maybe you could make this into an element or something,
		// idk, instead, we *listen for the creation of new atoms on the turf*
		// for things we're looking for. and just rearranage the code of the
		// objects' activate_self() so they don't break when no user is
		// available.
		var/datum/autochef_task/use_expansion_card/card_task = origin_task
		card_task.RegisterSignal(get_turf(autochef), COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, TYPE_PROC_REF(/datum/autochef_task/use_expansion_card, on_atom_after_successful_initialized_on))
		resource.activate_self(user = null)

		return AUTOCHEF_ACT_WAIT_FOR_RESULT

	if(autochef.upgrade_level > 2)
		var/datum/autochef_task/task = autochef.handle_missing_item(input_type)
		if(istype(task))
			autochef.add_task(task, origin_task)
			return AUTOCHEF_ACT_ADDED_TASK

	return AUTOCHEF_ACT_MISSING_INGREDIENT
