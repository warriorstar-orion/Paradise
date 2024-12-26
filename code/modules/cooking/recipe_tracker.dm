/// Datum held by objects that is the core component in a recipe.
/// You use other items on an items with this datum to advance its recipe.
/// Kept intentionally bare-bones because MANY of these objects are going to be made.
/datum/cooking/recipe_tracker
	/// The parent object holding the recipe tracker.
	var/holder_uid
	/// A collection of the classes of steps the recipe can take next.
	var/step_flags
	/// This variable is a little complicated.
	/// It specifically references recipe_pointer objects each pointing to a different point in a different recipe.
	var/list/active_recipe_pointers = list()
	var/completion_lockout = FALSE //Freakin' cheaters...
	/// List of recipes marked as complete.
	var/list/completed_list = list()
	/// Tells if steps have been taken for this recipe.
	var/recipe_started = FALSE

/datum/cooking/recipe_tracker/New(obj/item/reagent_containers/cooking/container)
	#ifdef CWJ_DEBUG
	log_debug("[__PROC__]")
	#endif
	holder_uid = container.UID()
	generate_pointers()
	populate_step_flags()

/// Call when a method is done incorrectly that provides a flat debuff to the whole meal.
/datum/cooking/recipe_tracker/proc/apply_flat_penalty(penalty)
	if(!length(active_recipe_pointers.len))
		return

	for (var/datum/cooking/recipe_pointer/pointer in active_recipe_pointers)
		pointer.tracked_quality -= penalty

/// Generate recipe_pointer objects based on the global list.
/datum/cooking/recipe_tracker/proc/generate_pointers()

	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_tracker/proc/generate_pointers")
	#endif
	var/obj/item/reagent_containers/cooking/container = locateUID(holder_uid)

	#ifdef CWJ_DEBUG
	log_debug("Loading all references to [container] of type [container.type] using [container.appliancetype]")
	#endif
	//iterate through dictionary matching on holder type
	if(GLOB.cwj_recipe_dictionary[container.appliancetype])
		for (var/key in GLOB.cwj_recipe_dictionary[container.appliancetype])
			#ifdef CWJ_DEBUG
			log_debug("Loading [container.appliancetype], [key] into pointer.")
			#endif
			active_recipe_pointers += new /datum/cooking/recipe_pointer(container.appliancetype, key, src)

//Generate next steps
/datum/cooking/recipe_tracker/proc/get_step_options()
	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_tracker/proc/get_step_options")
	#endif
	var/list/options = list()
	for (var/datum/cooking/recipe_pointer/pointer in active_recipe_pointers)
		options += pointer.get_possible_steps()

	#ifdef CWJ_DEBUG
	log_debug("/datum/cooking/recipe_tracker/proc/get_step_options returned [options.len] options")
	#endif
	return options

/datum/cooking/recipe_tracker/proc/populate_step_flags()
	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_tracker/proc/populate_step_flags")
	#endif
	step_flags = 0
	for (var/datum/cooking/recipe_pointer/pointer in active_recipe_pointers)
		var/flag_group = pointer.get_step_flags()
		#ifdef CWJ_DEBUG
		log_debug("Flag group returned with [flag_group]")
		#endif
		step_flags |= flag_group

/// Check if a recipe tracker has recipes loaded.
/datum/cooking/recipe_tracker/proc/has_recipes()
	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_tracker/proc/has_recipes")
	#endif
	return length(active_recipe_pointers)

/// Wrapper function for analyzing process_item internally.
/datum/cooking/recipe_tracker/proc/process_item_wrap(obj/used_object, mob/user)
	#ifdef CWJ_DEBUG
	log_debug("/datum/cooking/recipe_tracker/proc/process_item_wrap called!")
	#endif

	var/response = process_item(used_object, user)
	if(response == CWJ_SUCCESS || response == CWJ_COMPLETE || response == CWJ_PARTIAL_SUCCESS)
		if(!recipe_started)
			recipe_started = TRUE
	return response

/// Core function that checks if a object meets all the requirements for certain recipe actions.
/datum/cooking/recipe_tracker/proc/process_item(obj/used_object, mob/user)
	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_tracker/proc/process_item")
	#endif
	if(completion_lockout)
		#ifdef CWJ_DEBUG
		log_debug("/datum/cooking/recipe_tracker/proc/process_item held in lockout!")
		#endif
		return CWJ_LOCKOUT
	var/list/valid_steps = list()
	var/list/valid_unique_id_list = list()
	var/use_class

	//Decide what action is being taken with the item, if any.
	for (var/datum/cooking/recipe_pointer/pointer in active_recipe_pointers)
		var/list/option_list = list()
		option_list += pointer.get_possible_steps()
		for (var/datum/cooking/recipe_step/step in option_list)
			var/class_string = get_class_string(step.class)
			var/is_valid = step.check_conditions_met(used_object, src)
			#ifdef CWJ_DEBUG
			log_debug("recipe_tracker/proc/process_item: Check conditions met returned [is_valid]")
			#endif
			if(is_valid == CWJ_CHECK_VALID)
				if(!valid_steps["[class_string]"])
					valid_steps["[class_string]"] = list()
				valid_steps["[class_string]"]+= step

				if(!valid_unique_id_list["[class_string]"])
					valid_unique_id_list["[class_string]"] = list()
				valid_unique_id_list["[class_string]"] += step.UID()

				if(!use_class)
					use_class = class_string
	if(valid_steps.len == 0)
		#ifdef CWJ_DEBUG
		log_debug("/recipe_tracker/proc/process_item returned no steps!")
		#endif
		return CWJ_NO_STEPS

	if(valid_steps.len > 1)
		completion_lockout = TRUE
		if(user)
			var/list/choice = input(user, "There's two things you can do with this item!", "Choose One:") in valid_steps
			completion_lockout = FALSE
			if(!choice)
				#ifdef CWJ_DEBUG
				log_debug("/recipe_tracker/proc/process_item returned choice cancel!")
				#endif
				return CWJ_CHOICE_CANCEL
			use_class = choice
		else
			use_class = 1
	#ifdef CWJ_DEBUG
	log_debug("Use class determined: [use_class]")
	#endif

	valid_steps = valid_steps[use_class]
	valid_unique_id_list = valid_unique_id_list[use_class]

	var/has_traversed = FALSE
	//traverse and cull pointers
	for (var/datum/cooking/recipe_pointer/pointer in active_recipe_pointers)
		var/used_id = FALSE
		var/list/option_list = pointer.get_possible_steps()
		for (var/datum/cooking/recipe_step/step in option_list)
			if(!(step.UID() in valid_unique_id_list))
				continue
			else
				used_id = TRUE
				if(step.is_complete(used_object, src))
					has_traversed = TRUE
					pointer.traverse(step.UID(), used_object)
					break
		if (!used_id)
			active_recipe_pointers.Remove(pointer)
			qdel(pointer)

	//Choose to keep baking or finish now.
	if(completed_list.len && (completed_list.len != active_recipe_pointers.len))
		var/recipe_string = null
		for(var/datum/cooking/recipe_pointer/pointer in completed_list)
			if(!recipe_string)
				recipe_string = "\a [pointer.current_recipe.name]"
			else
				recipe_string += ", or \a [pointer.current_recipe.name]"
		if(user)
			if(alert(user, "If you finish cooking now, you will create [recipe_string]. However, you feel there are possibilities beyond even this. Continue cooking anyways?",,"Yes","No") == "Yes")
				//Cull finished recipe items
				for (var/datum/cooking/recipe_pointer/pointer in completed_list)
					active_recipe_pointers.Remove(pointer)
					qdel(pointer)
				completed_list = list()

	//Check if we completed our recipe
	var/datum/cooking/recipe_pointer/chosen_pointer = null
	if(completed_list.len >= 1)
		#ifdef CWJ_DEBUG
		log_debug("/recipe_tracker/proc/process_item YO WE ACTUALLY HAVE A COMPLETED A RECIPE!")
		#endif
		chosen_pointer = completed_list[1]
		if(user && length(completed_list.len) > 1)
			completion_lockout = TRUE
			var/choice = input(user, "There's two things you complete at this juncture!", "Choose One:") in completed_list
			completion_lockout = FALSE
			if(choice)
				chosen_pointer = completed_list[choice]

	//Call a proc that follows one of the steps in question, so we have all the nice to_chat calls.
	var/datum/cooking/recipe_step/sample_step = valid_steps[1]
	#ifdef CWJ_DEBUG
	log_debug("/recipe_tracker/proc/process_item: Calling follow_step")
	#endif
	sample_step.follow_step(used_object, src, user)

	if(chosen_pointer)
		chosen_pointer.current_recipe.create_product(chosen_pointer)
		return CWJ_COMPLETE
	populate_step_flags()

	if(has_traversed)
		#ifdef CWJ_DEBUG
		log_debug("/recipe_tracker/proc/process_item returned success!")
		#endif
		return CWJ_SUCCESS

	#ifdef CWJ_DEBUG
	log_debug("/recipe_tracker/proc/process_item returned partial success!")
	#endif
	return CWJ_PARTIAL_SUCCESS

