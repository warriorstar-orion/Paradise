RESTRICT_TYPE(/datum/cooking/recipe_step/use_oven)

/datum/cooking/recipe_step/use_oven
	step_verb_desc = "Use oven"
	var/time
	var/temperature

/datum/cooking/recipe_step/use_oven/New(temperature_, time_, options)
	temperature = temperature_
	time = time_

	..(options)

/datum/cooking/recipe_step/use_oven/is_complete(obj/used_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)

	if(container.oven_data[temperature] >= time)
		#ifdef CWJ_DEBUG
		log_debug("use_oven/is_complete() Returned True; comparing [temperature]: [container.oven_data[temperature]] to [time]")
		#endif
		return TRUE

	#ifdef CWJ_DEBUG
	log_debug("use_oven/is_complete() Returned False; comparing [temperature]: [container.oven_data[temperature]] to [time]")
	#endif
	return FALSE

//Reagents are calculated prior to object creation
/datum/cooking/recipe_step/use_oven/calculate_quality(obj/used_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking/container = locate(tracker.container_uid)
	var/obj/machinery/cooking/oven/our_oven = used_item
	var/bad_cooking = 0
	for (var/key in container.oven_data)
		if (temperature != key)
			bad_cooking += container.oven_data[key]

	bad_cooking = round(bad_cooking/(5 SECONDS))
	var/good_cooking = round(time/(3 SECONDS)) - bad_cooking + our_oven.quality_mod

	return clamp_quality(good_cooking)

/datum/cooking/recipe_step/use_oven/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	return list(target = added_item.UID())

/datum/cooking/recipe_step/use_oven/get_wiki_formatted_instruction()
	return "Bake in an oven for [DisplayTimeText(time)] at [temperature] temperature."
