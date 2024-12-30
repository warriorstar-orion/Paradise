RESTRICT_TYPE(/datum/cooking/recipe_step/use_ice_cream_mixer)

/datum/cooking/recipe_step/use_ice_cream_mixer
	step_verb_desc = "Use ice cream mixer"
	var/time

/datum/cooking/recipe_step/use_ice_cream_mixer/New(time_, options)
	time = time_

	..(options)

/datum/cooking/recipe_step/use_ice_cream_mixer/check_conditions_met(obj/used_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/reagent_containers/cooking/icecream_bowl/bowl = locateUID(tracker.container_uid)
	if(!istype(bowl))
		return CWJ_CHECK_INVALID

	if(bowl.freezing_time >= time)
		return CWJ_CHECK_VALID

	if(istype(used_item, /obj/machinery/cooking/ice_cream_mixer))
		return CWJ_CHECK_SILENT

	return CWJ_CHECK_INVALID

/datum/cooking/recipe_step/use_ice_cream_mixer/calculate_quality(obj/used_item, datum/cooking/recipe_tracker/tracker)
	return 5

/datum/cooking/recipe_step/use_ice_cream_mixer/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	return list(target = added_item.UID())

/datum/cooking/recipe_step/use_ice_cream_mixer/get_wiki_formatted_instruction()
	return "Mix in an ice cream mixer for [DisplayTimeText(time)]."
