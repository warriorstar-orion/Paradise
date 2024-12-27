/datum/cooking/recipe_step/use_grill
	step_verb_desc = "Use grill"
	var/time
	var/temperature

/datum/cooking/recipe_step/use_grill/New(temperature_, time_, options)
	time = time_
	temperature = temperature_

/datum/cooking/recipe_step/use_grill/check_conditions_met(obj/used_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)

	if(container.grill_data[temperature] >= time)
		#ifdef CWJ_DEBUG
		log_debug("use_grill/is_complete() Returned True; comparing [temperature]: [container.grill_data[temperature]] to [time]")
		#endif
		return CWJ_CHECK_VALID

	#ifdef CWJ_DEBUG
	log_debug("use_grill/is_complete() Returned False; comparing [temperature]: [container.grill_data[temperature]] to [time]")
	#endif

	return CWJ_CHECK_SILENT

/datum/cooking/recipe_step/use_grill/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	return list(target = added_item.UID())
