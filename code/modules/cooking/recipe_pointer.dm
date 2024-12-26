//Points to a specific step in a recipe while considering the optional paths that recipe can take.
/datum/cooking/recipe_pointer
	var/datum/cooking/recipe/current_recipe //The recipe being followed here.
	var/datum/cooking/recipe_step/current_step //The current step in the recipe we are following.
	var/parent_ref
	var/tracked_quality = 0 //The current level of quality within that recipe.
	var/list/steps_taken = list() //built over the course of following a recipe, tracks what has been done to the object. Format is unique_id:result

/datum/cooking/recipe_pointer/New(start_type, recipe_id, datum/cooking/recipe_tracker/parent)
	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_pointer/pointer/New([start_type], [recipe_id], parent)")
	#endif

	parent_ref = parent.UID()

	#ifdef CWJ_DEBUG
	if(!GLOB.cwj_recipe_dictionary[start_type][recipe_id])
		log_debug("Recipe [start_type]-[recipe_id] not found by tracker!")
	#endif

	current_recipe = GLOB.cwj_recipe_dictionary[start_type][recipe_id]

	#ifdef CWJ_DEBUG
	if(!current_recipe)
		log_debug("Recipe [start_type]-[recipe_id] initialized as null!")
	#endif

	current_step = current_recipe.first_step

	#ifdef CWJ_DEBUG
	steps_taken["[current_step.UID()]"]="Started with a [start_type]"
	#endif

//A list returning the next possible steps in a given recipe
/datum/cooking/recipe_pointer/proc/get_possible_steps()

	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_pointer/proc/get_possible_steps")
	if(!current_step)
		log_debug("Recipe pointer in [current_recipe] has no current_step assigned?")

	if(!current_step.next_step)
		log_debug("Recipe pointer in [current_recipe] has no next step.")
	#endif

	//Build a list of all possible steps while accounting for exclusive step relations.
	//Could be optimized, but keeps the amount of variables in the pointer low.
	var/list/return_list = list(current_step.next_step)
	for(var/datum/cooking/recipe_step/step in current_step.optional_step_list)

		if(steps_taken["[step.UID()]"])
			//Traverse an option chain if one is present.
			if(step.flags & CWJ_IS_OPTION_CHAIN)
				var/datum/cooking/recipe_step/option_chain_step = step.next_step
				while(option_chain_step.UID() != current_step.UID())
					if(!steps_taken["[option_chain_step.UID()]"])
						return_list += option_chain_step
						break
					option_chain_step = option_chain_step.next_step
			continue

		//Reference the global exclusion list to see if we can add this
		var/exclude_step = FALSE
		if(step.flags & CWJ_IS_EXCLUSIVE)
			for (var/id in GLOB.cwj_optional_step_exclusion_dictionary["[step.UID()]"])
				//Reference the global exclusion list to see if any of the taken steps
				//Have the current step marked as exclusive.
				if(steps_taken["[id]"])
					exclude_step = TRUE
					break


		if(!exclude_step)
			return_list += step
		#ifdef CWJ_DEBUG
		else
			log_debug("Ignoring step [step.UID()] due to exclusion.")
		#endif


	#ifdef CWJ_DEBUG
	log_debug("/datum/cooking/recipe_pointer/proc/get_possible_steps returned list of length [return_list.len]")
	#endif
	return return_list

//Get the classes of all applicable next-steps for a recipe in a bitmask.
/datum/cooking/recipe_pointer/proc/get_step_flags()
	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_pointer/proc/get_step_flags")
	if(!current_step)
		log_debug("Recipe pointer in [current_recipe] has no current_step assigned?")
	else if(!current_step.next_step)
		log_debug("Recipe pointer in [current_recipe] has no next step.")
	#endif

	//Build a list of all possible steps while accounting for exclusive step relations.
	//Could be optimized, but keeps the amount of variables in the pointer low.
	var/return_flags = current_step.next_step.class
	for(var/datum/cooking/recipe_step/step in current_step.optional_step_list)

		if(steps_taken["[step.UID()]"])
			//Traverse an option chain if one is present.
			if(step.flags & CWJ_IS_OPTION_CHAIN)
				var/datum/cooking/recipe_step/option_chain_step = step.next_step
				while(option_chain_step.UID() != current_step.UID())
					if(!steps_taken["[option_chain_step.UID()]"])
						return_flags |= option_chain_step.class
						break
					option_chain_step = option_chain_step.next_step
			continue

		//Reference the global exclusion list to see if we can add this
		var/exclude_step = FALSE
		if(step.flags & CWJ_IS_EXCLUSIVE)
			for (var/id in GLOB.cwj_optional_step_exclusion_dictionary["[step.UID()]"])
				//Reference the global exclusion list to see if any of the taken steps
				//Have the current step marked as exclusive.
				if(steps_taken["[id]"])
					exclude_step = TRUE
					break
		if(!exclude_step)
			return_flags |= step.class
	return return_flags

/datum/cooking/recipe_pointer/proc/traverse(id, obj/used_obj)
	#ifdef CWJ_DEBUG
	log_debug("/recipe_pointer/traverse: Traversing pointer from [current_step.UID()] to [id].")
	#endif
	if(!GLOB.cwj_step_dictionary["[id]"])
		return FALSE
	var/datum/cooking/recipe_tracker/tracker = locateUID(parent_ref)
	var/datum/cooking/recipe_step/active_step = GLOB.cwj_step_dictionary["[id]"]

	var/is_valid_step =  FALSE
	var/list/possible_steps = get_possible_steps()
	for(var/datum/cooking/recipe_step/possible_step in possible_steps)
		if(active_step.UID() == possible_step.UID())
			is_valid_step = TRUE
			break

	if(!is_valid_step)
		#ifdef CWJ_DEBUG
		log_debug("/recipe_pointer/traverse: step [id] is not valid for recipe [current_recipe.UID()]")
		#endif
		return FALSE

	var/step_quality = active_step.calculate_quality(used_obj, tracker)
	tracked_quality += step_quality
	steps_taken["[id]"] = active_step.get_step_result_text(used_obj, step_quality)
	if(!(active_step.flags & CWJ_IS_OPTIONAL))
		current_step = active_step

	//The recipe has been completed.
	if(!current_step.next_step && current_step.UID() == id)

		tracker.completed_list +=  src
		return TRUE

	return FALSE
