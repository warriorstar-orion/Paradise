/datum/cooking/recipe_step/use_grill
	var/time
	var/temperature

/datum/cooking/recipe_step/use_grill/New(temperature_, time_, options)
	time = time_
	temperature = temperature_

/datum/cooking/recipe_step/use_grill/check_conditions_met(obj/used_item, datum/cooking/recipe_tracker/tracker)
	if(!istype(used_item, /obj/machinery/cooking/grill))
		return CWJ_CHECK_INVALID

	return CWJ_CHECK_VALID
