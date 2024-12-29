/// Datum held by objects that is the core component in a recipe.
/// You use other items on an items with this datum to advance its recipe.
/datum/cooking/recipe_tracker
	/// The parent object holding the recipe tracker.
	var/container_uid
	var/completion_lockout = FALSE //Freakin' cheaters...
	/// Tells if steps have been taken for this recipe.
	var/recipe_started = FALSE
	/// A list of recipe types to the index of the latest step we know we've gotten to.
	var/list/matching_recipe_steps = list()
	/// A list of recipe types to list of step indices we know we've performed.
	/// Ensures we don't perform e.g. optional steps we skipped on completion.
	var/list/applied_recipe_steps = list()
	var/list/applied_step_data = list()
	var/step_reaction_message

/datum/cooking/recipe_tracker/New(obj/item/reagent_containers/cooking/container)
	#ifdef CWJ_DEBUG
	log_debug("[__PROC__]")
	#endif
	container_uid = container.UID()

/datum/cooking/recipe_tracker/Destroy(force, ...)
	// Not QDEL_LIST_CONTENTS because there's references to the global recipe singletons.
	matching_recipe_steps.Cut()
	applied_recipe_steps.Cut()
	applied_step_data.Cut()

	. = ..()

/// Wrapper function for analyzing process_item internally.
/datum/cooking/recipe_tracker/proc/process_item_wrap(mob/user, obj/used)
	#ifdef CWJ_DEBUG
	log_debug("/datum/cooking/recipe_tracker/proc/process_item_wrap called!")
	#endif

	var/response = process_item(user, used)
	if(response == CWJ_SUCCESS || response == CWJ_COMPLETE || response == CWJ_PARTIAL_SUCCESS)
		if(!recipe_started)
			recipe_started = TRUE
	return response

/// Core function that checks if a object meets all the requirements for certain recipe actions.
/datum/cooking/recipe_tracker/proc/process_item(mob/user, obj/used)
	// TODO: I *hate* passing in a user here and want to move all the necessary
	// UI interactions (selecting which recipe to complete, selecting which step
	// to perform) to be moved somewhere else entirely.
	#ifdef CWJ_DEBUG
	log_debug("Called /datum/cooking/recipe_tracker/proc/process_item")
	#endif
	if(completion_lockout)
		#ifdef CWJ_DEBUG
		log_debug("/datum/cooking/recipe_tracker/proc/process_item held in lockout!")
		#endif
		return CWJ_LOCKOUT

	var/list/valid_steps = list()
	var/list/valid_recipes = list()
	var/list/completed_recipes = list()
	var/list/silent_recipes = list()
	var/list/attempted_step_per_recipe = list()
	var/use_step

	for(var/datum/cooking/recipe/recipe in matching_recipe_steps)
		var/current_idx = matching_recipe_steps[recipe]
		var/datum/cooking/recipe_step/next_step

		var/match = FALSE
		do
			next_step = recipe.steps[++current_idx]
			var/conditions = next_step.check_conditions_met(used, src)
			if(conditions == CWJ_CHECK_VALID)
				LAZYADD(valid_steps[next_step.type], next_step)
				LAZYADD(valid_recipes[next_step.type], recipe)
				attempted_step_per_recipe[recipe] = current_idx
				if(!use_step)
					use_step = next_step.type
				match = TRUE
				break
			else if(conditions == CWJ_CHECK_SILENT)
				LAZYADD(silent_recipes, recipe)
		while(next_step && next_step.optional && current_idx <= length(recipe.steps))

		if(match)
			LAZYOR(applied_recipe_steps[recipe], current_idx)
			if(length(recipe.steps) == current_idx)
				completed_recipes |= recipe

	if(!length(valid_steps))
		if(length(silent_recipes))
			return CWJ_PARTIAL_SUCCESS
		return CWJ_NO_STEPS

	// if(valid_steps.len > 1)
	// 	completion_lockout = TRUE
	// 	if(user)
	// 		var/list/choice = input(user, "There's two things you can do with this item!", "Choose One:") in valid_steps
	// 		completion_lockout = FALSE
	// 		if(!choice)
	// 			#ifdef CWJ_DEBUG
	// 			log_debug("/recipe_tracker/proc/process_item returned choice cancel!")
	// 			#endif
	// 			return CWJ_CHOICE_CANCEL
	// 		use_class = choice
	// 	else
	// 		use_class = 1
	// #ifdef CWJ_DEBUG
	// log_debug("Use class determined: [use_class]")
	// #endif

	if(length(valid_steps) > 1)
		log_debug("BLAH BLAH")
		return CWJ_NO_STEPS

	valid_steps = valid_steps[use_step]
	var/datum/cooking/recipe_step/sample_step = valid_steps[1]
	var/step_data = sample_step.follow_step(used, src)

	step_reaction_message = step_data["message"]
	if(sample_step.is_complete(used, src))
		applied_step_data += list(step_data)
		for(var/datum/cooking/recipe in valid_recipes[sample_step.type])
			matching_recipe_steps[recipe] = attempted_step_per_recipe[recipe]

	for(var/datum/cooking/recipe in matching_recipe_steps)
		if(!(recipe in valid_recipes[sample_step.type]))
			matching_recipe_steps -= recipe

	var/datum/cooking/recipe/recipe_to_complete
	if(length(completed_recipes))
		if(length(completed_recipes) == 1)
			recipe_to_complete = completed_recipes[1]
		else if(user && length(completed_recipes) > 1)
			completion_lockout = TRUE
			var/choice = input(user, "There's two things you complete at this juncture!", "Choose One:") in completed_recipes
			completion_lockout = FALSE
			if(choice)
				recipe_to_complete = completed_recipes[choice]

	if(recipe_to_complete)
		var/obj/container = locateUID(container_uid)
		var/result = recipe_to_complete.create_product(src)
		// if(user && user.Adjacent(container))
		// 	to_chat(user, "<span class='notice'>You have completed \a [result]!</span>")
		return CWJ_COMPLETE

	return CWJ_SUCCESS

	// //Choose to keep baking or finish now.
	// if(completed_list.len && (completed_list.len != active_recipe_pointers.len))
	// 	var/recipe_string = null
	// 	for(var/datum/cooking/recipe_pointer/pointer in completed_list)
	// 		if(!recipe_string)
	// 			recipe_string = "\a [pointer.current_recipe.name]"
	// 		else
	// 			recipe_string += ", or \a [pointer.current_recipe.name]"
	// 	if(user)
	// 		if(alert(user, "If you finish cooking now, you will create [recipe_string]. However, you feel there are possibilities beyond even this. Continue cooking anyways?",,"Yes","No") == "Yes")
	// 			//Cull finished recipe items
	// 			for (var/datum/cooking/recipe_pointer/pointer in completed_list)
	// 				active_recipe_pointers.Remove(pointer)
	// 				qdel(pointer)
	// 			completed_list = list()

	// //Check if we completed our recipe
	// var/datum/cooking/recipe_pointer/chosen_pointer = null
	// if(completed_list.len >= 1)
	// 	#ifdef CWJ_DEBUG
	// 	log_debug("/recipe_tracker/proc/process_item YO WE ACTUALLY HAVE A COMPLETED A RECIPE!")
	// 	#endif
	// 	chosen_pointer = completed_list[1]
	// 	if(user && length(completed_list.len) > 1)
	// 		completion_lockout = TRUE
	// 		var/choice = input(user, "There's two things you complete at this juncture!", "Choose One:") in completed_list
	// 		completion_lockout = FALSE
	// 		if(choice)
	// 			chosen_pointer = completed_list[choice]
