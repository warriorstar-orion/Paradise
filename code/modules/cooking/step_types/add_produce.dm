/// A cooking step that involves using grown foods.
/datum/cooking/recipe_step/add_produce
	class = CWJ_ADD_PRODUCE
	var/required_produce_type
	var/base_potency
	var/reagent_skip = FALSE
	var/inherited_quality_modifier = 1
	var/list/exclude_reagents = list()

/datum/cooking/recipe_step/add_produce/New(produce_type, datum/cooking/recipe/our_recipe)
	var/obj/item/grown/produce = produce_type
	if(produce)
		desc = "Add \a [produce::name] into the recipe."
		required_produce_type = produce_type
		group_identifier = produce_type

		//Get tooltip image for plants
		var/obj/item/seeds/seeds = produce::seed
		if(seeds)
			#warn fix icon cache or something
			// var/icon_key = "fruit-[seed.get_trait(TRAIT_PRODUCT_ICON)]-[seed.get_trait(TRAIT_PRODUCT_COLOUR)]-[seed.get_trait(TRAIT_PLANT_COLOUR)]"
			// if(plant_controller.plant_icon_cache[icon_key])
			// 	tooltip_image = plant_controller.plant_icon_cache[icon_key]
			// else
			// 	log_debug("[seed] is missing it's icon to add to tooltip_image")
			base_potency = seeds::potency

	return ..(base_quality_award, our_recipe)

/datum/cooking/recipe_step/add_produce/check_conditions_met(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#ifdef CWJ_DEBUG
	log_debug("Called add_produce/check_conditions_met for [added_item] against [required_produce_type]")
	#endif

	if(!istype(added_item, /obj/item/food/grown))
		return CWJ_CHECK_INVALID

	var/obj/item/food/grown/added_produce = added_item

	if(added_produce.type == required_produce_type)
		return CWJ_CHECK_VALID

	return CWJ_CHECK_INVALID

/datum/cooking/recipe_step/add_produce/calculate_quality(obj/added_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/food/grown/added_produce = added_item
	var/potency_raw = round(base_quality_award + (added_produce.seed.potency - base_potency) * inherited_quality_modifier)
	return clamp_quality(potency_raw)

/datum/cooking/recipe_step/add_produce/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#ifdef CWJ_DEBUG
	log_debug("Called: /datum/cooking/recipe_step/add_produce/follow_step")
	#endif
	var/obj/item/container = locateUID(tracker.holder_ref)
	if(container && usr.drop_item())
		added_item.forceMove(container)
	return CWJ_SUCCESS
