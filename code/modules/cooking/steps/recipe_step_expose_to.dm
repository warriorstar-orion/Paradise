RESTRICT_TYPE(/datum/cooking/recipe_step/expose_to)

/datum/cooking/recipe_step/expose_to
	var/required_count = 3

/datum/cooking/recipe_step/expose_to/check_conditions_met(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#ifdef PCWJ_DEBUG
	log_debug("Called expose_to/check_conditions_met for [added_item], checking against item type [item_type]. Exact_path = [exact_path]")
	#endif

	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)
	if(!istype(container))
		return PCWJ_CHECK_INVALID

	if(!isturf(container.loc))
		container.cooker_data["plasma"] = 0
		return PCWJ_CHECK_INVALID

	var/turf/T = container.loc
	if(!istype(T))
		container.cooker_data["plasma"] = 0
		return PCWJ_CHECK_INVALID

	var/datum/gas_mixture/readonly/air = T.get_readonly_air()
	if(air.toxins() >= 5)
		if(!("plasma" in container.cooker_data))
			container.cooker_data["plasma"] = 0
		container.cooker_data["plasma"]++
	else
		container.cooker_data["plasma"] = 0

	if(container.cooker_data["plasma"] >= required_count)
		return PCWJ_CHECK_VALID

	return PCWJ_CHECK_SILENT

/datum/cooking/recipe/plasma_torilla
	container_type = /obj/item/reagent_containers/cooking/pan
	product_type = /obj/item/food/tortilla
	catalog_category = COOKBOOK_CATEGORY_BREAD
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/dough),
		new /datum/cooking/recipe_step/expose_to(),
	)

/datum/cooking/recipe_step/expose_to/get_pda_formatted_desc()
	return "Soak in plasma for [required_count * 2] seconds."

