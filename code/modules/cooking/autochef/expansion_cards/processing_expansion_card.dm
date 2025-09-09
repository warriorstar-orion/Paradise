RESTRICT_TYPE(/obj/item/autochef_expansion_card/processing)

#define MODE_NONE 0
#define MODE_GRIND 1
#define MODE_JUICE 2


/obj/item/autochef_expansion_card/processing
	name = "Autochef Expansion Card: Processing"
	desc = "This extremely rare expansion card enables autochefs to utilize grinders and food processors."
	icon_state = "autochef_expansion_card_red"
	task_message = "Food-processing"
	registerable_machines = list(
		/obj/machinery/chem_master/condimaster,
		/obj/machinery/processor,
		/obj/machinery/reagentgrinder,
	)

/obj/item/autochef_expansion_card/processing/can_produce(obj/machinery/autochef/autochef, target_type)
	var/valid_grinders = 0
	var/valid_condimasters = 0

	for(var/obj/machinery/reagentgrinder/grinder in autochef.get_linked_objects(/obj/machinery/reagentgrinder))
		if(grinder.can_make(target_type))
			valid_grinders++

	for(var/obj/machinery/chem_master/condimaster/condimaster in autochef.get_linked_objects(/obj/machinery/chem_master/condimaster))
		valid_condimasters++

	if(valid_grinders && valid_condimasters)
		return AUTOCHEF_ACT_VALID

	return AUTOCHEF_ACT_MISSING_MACHINE

/obj/item/autochef_expansion_card/processing/perform_step(datum/autochef_task/origin_task, obj/machinery/autochef/autochef, target_type)
	autochef.set_display("screen-gear")

	switch(origin_task.current_state)
		if(AUTOCHEF_ACT_STARTED)
			attempt_grinding(origin_task, autochef, target_type)
		if(AUTOCHEF_ACT_WAIT_FOR_RESULT)
			return AUTOCHEF_ACT_WAIT_FOR_RESULT

/obj/item/autochef_expansion_card/processing/proc/attempt_grinding(datum/autochef_task/origin_task, obj/machinery/autochef/autochef, target_type)
	var/obj/machinery/chem_master/condimaster/condimaster
	var/obj/machinery/reagentgrinder/grinder

	// for each grinder we have access to:
	// - see if it can make what we need
	// - see if it has something in the output container already (no mixing outputs!)
	// - see if there's something in the hopper already (no mixing inputs!)
	// - if there is one type of thing in the hopper, see if it's something we can use
	// - how do we know if we have enough ingredients to make the amount of output we need? uhhhhhhhh
	//   i suspect we're going to just fill the grinder with the input as much as we can
	//   and then just repeatedly test to see if we've made enough
	// - oh yeah and since we can't make bottles out of thin air we need to connect
	//   to a condimaster too to make bottles of things! amazing!
	for(var/obj/machinery/reagentgrinder/G in autochef.get_linked_objects(/obj/machinery/reagentgrinder))
		if(!G.beaker)
			continue

		if(!G.beaker.reagents.is_empty())
			continue

		var/mode = MODE_NONE

		var/sole_input_type
		var/list/found_inputs = list()
		for(var/atom/movable/AM in G.holdingitems)
			found_inputs[AM.type]++
			sole_input_type = AM.type

		if(length(found_inputs) > 1)
			return AUTOCHEF_ACT_NO_AVAILABLE_MACHINES

		var/contains_valid_input_already = FALSE
		if(length(found_inputs) == 1)
			var/list/blend_items = G.get_special_blend(sole_input_type)
			if(blend_items && (target_type in blend_items))
				mode = MODE_GRIND
				contains_valid_input_already = TRUE
				break
			var/list/juice_items = G.get_special_juice(sole_input_type)
			if(juice_items && (target_type in juice_items))
				mode = MODE_JUICE
				contains_valid_input_already = TRUE
				break

		var/list/possible_items = list()
		if(!contains_valid_input_already)
			for(var/obj/machinery/smartfridge/fridge in autochef.linked_storages)
				for(var/obj/item/food/grown/possible_item in fridge)
					if(possible_item.reagents.has_reagent(target_type))
						possible_items += possible_item
					var/list/blend_items = G.get_special_blend(possible_item.type)
					if(blend_items && (target_type in blend_items))
						possible_items += possible_item
					var/list/juice_items = G.get_special_juice(possible_item.type)
					if(juice_items && (target_type in juice_items))
						possible_items += possible_item

		while(length(grinder.holdingitems) < grinder.limit && length(possible_items))
			var/obj/input_item = possible_items[possible_items.len]
			possible_items.len--

			var/obj/machinery/smartfridge/fridge = input_item.loc
			if(!istype(fridge) || !(isInSight(autochef, fridge)))
				continue

			grinder.item_interaction(null, input_item)
			input_item.forceMove(grinder)
			fridge.item_quants[input_item.name]--
			fridge.Beam(grinder, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)

		if(mode == MODE_JUICE)
			grinder.juice()
			RegisterSignal(grinder, COMSIG_MACHINE_STEP_COMPLETE, PROC_REF(on_machine_step_complete))
			origin_task.current_state = AUTOCHEF_ACT_WAIT_FOR_RESULT
			return
		if(mode == MODE_GRIND)
			grinder.grind()
			RegisterSignal(grinder, COMSIG_MACHINE_STEP_COMPLETE, PROC_REF(on_machine_step_complete))
			origin_task.current_state = AUTOCHEF_ACT_WAIT_FOR_RESULT
			return
		if(mode == MODE_NONE)
			autochef.atom_say("Unknown error in [src]. please contact customer support.")

	for(var/obj/machinery/chem_master/condimaster/C in autochef.get_linked_objects(/obj/machinery/chem_master/condimaster))
		if(C.beaker)
			continue
		if(length(C.reagents.reagent_list))
			continue
		condimaster = C

	if(!condimaster)
		return AUTOCHEF_ACT_NO_AVAILABLE_MACHINES

	autochef.Beam(grinder, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
	autochef.Beam(condimaster, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
	grinder.beaker.forceMove(condimaster)
	condimaster.beaker = grinder.beaker
	condimaster.update_appearance()
	grinder.beaker = null
	grinder.update_appearance()

	var/datum/chemical_production_mode/production_mode = condimaster.production_modes["condi_bottles"]
	if(!production_mode)
		return AUTOCHEF_ACT_FAILED
	while(!condimaster.beaker.reagents.is_empty())
		production_mode.synthesize(null, src, condimaster.beaker.reagents)

	if(length(contents))
		return AUTOCHEF_ACT_COMPLETE

	return AUTOCHEF_ACT_FAILED

/obj/item/autochef_expansion_card/proc/on_machine_step_complete(datum/source)
	SIGNAL_HANDLER // COMSIG_MACHINE_STEP_COMPLETE
	return

#undef MODE_NONE
#undef MODE_GRIND
#undef MODE_JUICE
