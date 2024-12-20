/datum/cooking_with_jane/recipe_step/use_stove
	class = CWJ_USE_STOVE
	auto_complete_enabled = TRUE
	var/time
	var/heat

//set_heat: The temperature the stove must cook at.
//set_time: How long something must be cook in the stove
//our_recipe: The parent recipe object
/datum/cooking_with_jane/recipe_step/use_stove/New(set_heat, set_time, datum/cooking_with_jane/recipe/our_recipe)
	time = set_time
	heat = set_heat

	#warn fix description ticks_to_text
	// desc = "Cook on a stove set to [heat] for [ticks_to_text(time)]."

	..(our_recipe)

/datum/cooking_with_jane/recipe_step/use_stove/check_conditions_met(obj/used_item, datum/cooking_with_jane/recipe_tracker/tracker)

	if(!istype(used_item, /obj/machinery/cooking_with_jane/stove))
		return CWJ_CHECK_INVALID

	return CWJ_CHECK_VALID

//Reagents are calculated prior to object creation
/datum/cooking_with_jane/recipe_step/use_stove/calculate_quality(obj/used_item, datum/cooking_with_jane/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking_with_jane/cooking_container/container = locateUID(tracker.holder_ref)
	var/obj/machinery/cooking_with_jane/stove/our_stove = used_item

	var/bad_cooking = 0
	for (var/key in container.stove_data)
		if (heat != key)
			bad_cooking += container.stove_data[key]

	bad_cooking = round(bad_cooking/(5 SECONDS))
	var/good_cooking = round(time/(3 SECONDS)) - bad_cooking + our_stove.quality_mod

	return clamp_quality(good_cooking)

/datum/cooking_with_jane/recipe_step/use_stove/follow_step(obj/used_item, datum/cooking_with_jane/recipe_tracker/tracker)
	return CWJ_SUCCESS

/datum/cooking_with_jane/recipe_step/use_stove/is_complete(obj/used_item, datum/cooking_with_jane/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking_with_jane/cooking_container/container = locateUID(tracker.holder_ref)

	if(container.stove_data[heat] >= time)
		#ifdef CWJ_DEBUG
		log_debug("use_stove/is_complete() Returned True; comparing [heat]: [container.stove_data[heat]] to [time]")
		#endif
		return TRUE

	#ifdef CWJ_DEBUG
	log_debug("use_stove/is_complete() Returned False; comparing [heat]: [container.stove_data[heat]] to [time]")
	#endif
	return FALSE
