RESTRICT_TYPE(/datum/cooking/recipe_step/add_produce)

/// A cooking step that involves using grown foods.
/datum/cooking/recipe_step/add_produce
	// class = CWJ_ADD_PRODUCE
	var/produce_type
	var/base_potency
	var/exact_path
	var/skip_reagents = FALSE
	var/list/exclude_reagents

/datum/cooking/recipe_step/add_produce/New(produce_type_, options)
	produce_type = produce_type_

	if("exact" in options)
		exact_path = options["exact"]
	if("skip_reagents" in options)
		skip_reagents = options["skip_reagents"]
	if("exclude_reagents" in options)
		exclude_reagents = options["exclude_reagents"]

	..(options)

/datum/cooking/recipe_step/add_produce/check_conditions_met(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#ifdef CWJ_DEBUG
	log_debug("Called add_produce/check_conditions_met for [added_item] against [required_produce_type]")
	#endif

	if(!istype(added_item, /obj/item/food/grown))
		return CWJ_CHECK_INVALID
	if(exact_path)
		if(added_item == produce_type)
			return CWJ_CHECK_VALID
	else
		if(istype(added_item, produce_type))
			return CWJ_CHECK_VALID

	return CWJ_CHECK_INVALID

/datum/cooking/recipe_step/add_produce/calculate_quality(obj/added_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/food/grown/added_produce = added_item
	var/potency_raw = round(base_quality_award + (added_produce.seed.potency - base_potency) * inherited_quality_modifier)
	return clamp_quality(potency_raw)

/datum/cooking/recipe_step/add_produce/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	#ifdef CWJ_DEBUG
	log_debug("Called: /datum/cooking/recipe_step/add_produce/follow_step")
	#endif
	var/obj/item/container = locateUID(tracker.container_uid)
	if(!user && ismob(added_item.loc))
		user = added_item.loc
	if(container)
		if(istype(user) && user.Adjacent(container))
			if(user.drop_item(added_item))
				added_item.forceMove(container)
			#warn what if you can't drop it
		else
			added_item.forceMove(container)

		return list(message = "You add \the [added_item] to \the [container].", target = added_item.UID())

	return list(message = "Something went real fucking wrong here!")
