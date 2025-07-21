RESTRICT_TYPE(/datum/cooking/recipe_step/surround_with)

/datum/cooking/recipe_step/surround_with
	var/list/items = list()

/datum/cooking/recipe_step/surround_with/New(list/item_types)
	for(var/item_type in item_types)
		items[item_type] = FALSE

/datum/cooking/recipe_step/surround_with/check_conditions_met(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#ifdef PCWJ_DEBUG
	log_debug("Called surround_with/check_conditions_met for [added_item], checking against item type [item_type]. Exact_path = [exact_path]")
	#endif

	var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)
	if(!istype(container))
		return PCWJ_CHECK_INVALID

	if(!isturf(container.loc))
		return PCWJ_CHECK_INVALID

	for(var/item_type in items)
		items[item_type] = FALSE

	var/turf/T = get_turf(container)
	for(var/obj/object in T.contents)
		for(var/item_type in items)
			if(istype(object, item_type))
				items[item_type] = TRUE

	for(var/item_type in items)
		if(!items[item_type])
			return PCWJ_CHECK_INVALID

	return PCWJ_CHECK_VALID

/datum/cooking/recipe_step/surround_with/get_pda_formatted_desc()
	var/list/names = list()
	for(var/item_type in items)
		var/obj/obj_type = item_type
		names += obj_type::name

	return "Surround with [english_list(names)]."

/datum/cooking/recipe/excommunicated_bread
	container_type = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/banarnarbread
	catalog_category = COOKBOOK_CATEGORY_BREAD
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/dough),
		new /datum/cooking/recipe_step/surround_with(list(/obj/item/book, /obj/item/candle, /obj/item/desk_bell)),
	)
