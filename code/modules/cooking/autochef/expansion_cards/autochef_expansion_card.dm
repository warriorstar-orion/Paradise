/obj/item/autochef_expansion_card
	name = "autochef expansion card"
	icon = 'icons/obj/module.dmi'
	icon_state = "autochef_expansion_card"
	new_attack_chain = TRUE

	var/task_message
	var/list/registerable_machines = list()

/obj/item/autochef_expansion_card/proc/can_produce(obj/machinery/autochef/autochef, target_type)
	return FALSE

/obj/item/autochef_expansion_card/proc/perform_step(datum/autochef_task/origin_task, obj/machinery/autochef/autochef, target_type)
	return AUTOCHEF_ACT_FAILED

/obj/item/autochef_expansion_card/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	var/obj/machinery/autochef/autochef = target
	if(!istype(autochef))
		return

	if(!user.drop_item())
		return ITEM_INTERACT_COMPLETE

	autochef.try_insert_expansion(user, src)
	return ITEM_INTERACT_COMPLETE

/obj/item/autochef_expansion_card/basic_prep
	name = "Autochef Expansion Card: Basic Prep"
	desc = "This fairly common expansion card enables autochefs to perform basic cutting, rolling, and shaping tasks."
	icon_state = "autochef_expansion_card_blue"
	task_message = "Basic prepping"
	var/static/list/sliceable_foods
	var/static/list/rollable_foods = list(
		/obj/item/food/sliceable/flatdough = /obj/item/food/dough,
	)

/obj/item/autochef_expansion_card/basic_prep/Initialize(mapload)
	. = ..()
	if(!sliceable_foods)
		sliceable_foods = list()
		for(var/food_type in subtypesof(/obj/item/food/sliceable))
			var/obj/item/food/sliceable/sliceable_food_type = food_type
			sliceable_foods[sliceable_food_type::slice_path] = sliceable_food_type

/obj/item/autochef_expansion_card/basic_prep/can_produce(obj/machinery/autochef/autochef, target_type)
	if(target_type in sliceable_foods)
		return TRUE
	if(target_type in rollable_foods)
		return TRUE

	return FALSE

/obj/item/autochef_expansion_card/basic_prep/perform_step(datum/autochef_task/origin_task, obj/machinery/autochef/autochef, target_type)
	if(target_type in sliceable_foods)
		var/sliceable_food_type = sliceable_foods[target_type]
		for(var/obj/machinery/smartfridge/smartfridge in autochef.linked_storages)
			var/obj/item/food/sliceable/ingredient = smartfridge.directly_move_to(sliceable_food_type, autochef)
			if(ingredient)
				var/list/output = ingredient.convert_to_slices(inaccurate = FALSE)
				for(var/atom/movable/A in output)
					A.forceMove(src) // that's right we're putting the results in the card itself

				return AUTOCHEF_ACT_COMPLETE
		if(autochef.upgrade_level > 2)
			var/datum/autochef_task/task = autochef.handle_missing_item(sliceable_food_type)
			if(istype(task))
				autochef.add_task(task, origin_task)
				return AUTOCHEF_ACT_ADDED_TASK
	else if(target_type in rollable_foods)
		var/rollable_food_type = rollable_foods[target_type]
		for(var/obj/machinery/smartfridge/smartfridge in autochef.linked_storages)
			var/atom/movable/ingredient = smartfridge.directly_move_to(rollable_food_type, autochef)
			if(ingredient)
				qdel(ingredient)
				new target_type(src)
				return AUTOCHEF_ACT_COMPLETE

		if(autochef.upgrade_level > 2)
			var/datum/autochef_task/task = autochef.handle_missing_item(rollable_food_type)
			if(istype(task))
				autochef.add_task(task, origin_task)
				return AUTOCHEF_ACT_ADDED_TASK

	// if an expansion card fails, we take the task off the list and let
	// whatever step called it find the best solution, which may not be
	// the expansion card still
	autochef.remove_task(origin_task)
	return AUTOCHEF_ACT_FAILED

/obj/item/autochef_expansion_card/mixing_prep
	name = "Autochef Expansion Card: Mixing Prep"
	desc = "This rare expansion card enables autochefs to perform reagent mixing."
	icon_state = "autochef_expansion_card_green"
	task_message = "Mixing"
	registerable_machines = list(
		/obj/machinery/chem_dispenser,
	)

/obj/item/autochef_expansion_card/processing_prep
	name = "Autochef Expansion Card: Processing Prep"
	desc = "This extremely rare expansion card enables autochefs to utilize grinders and food processors."
	icon_state = "autochef_expansion_card_red"
	task_message = "Food-processing"
	registerable_machines = list(
		/obj/machinery/processor,
		/obj/machinery/reagentgrinder,
	)

