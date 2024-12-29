RESTRICT_TYPE(/datum/cooking/recipe_step/use_stove)

/datum/cooking/recipe_step/use_stove
	var/time
	var/temperature

/datum/cooking/recipe_step/use_stove/New(temperature_, time_, options)
	time = time_
	temperature = temperature_

	..(options)

/datum/cooking/recipe_step/use_stove/check_conditions_met(obj/used_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)

	if(container.stove_data[temperature] >= time)
		#ifdef CWJ_DEBUG
		log_debug("use_stove/is_complete() Returned True; comparing [temperature]: [container.stove_data[temperature]] to [time]")
		#endif
		return CWJ_CHECK_VALID

	#ifdef CWJ_DEBUG
	log_debug("use_stove/is_complete() Returned False; comparing [temperature]: [container.stove_data[temperature]] to [time]")
	#endif

	if(istype(used_item, /obj/machinery/cooking/stove))
		return CWJ_CHECK_SILENT
	else
		return CWJ_CHECK_INVALID

/datum/cooking/recipe_step/use_stove/calculate_quality(obj/used_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)
	var/obj/machinery/cooking/stove/our_stove = used_item

	var/bad_cooking = 0
	for (var/key in container.stove_data)
		if (temperature != key)
			bad_cooking += container.stove_data[key]

	bad_cooking = round(bad_cooking/(5 SECONDS))
	var/good_cooking = round(time/(3 SECONDS)) - bad_cooking + our_stove.quality_mod

	return clamp_quality(good_cooking)

/datum/cooking/recipe_step/use_stove/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	return list(target = added_item.UID())
