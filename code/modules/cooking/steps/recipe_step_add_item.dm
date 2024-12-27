/datum/cooking/recipe_step/add_item
	step_verb_desc = "Add item"
	var/item_type
	var/exact_path

/datum/cooking/recipe_step/add_item/New(item_type_, options)
	item_type = item_type_

	if("exact" in options)
		exact_path = options["exact"]

	..(options)

/datum/cooking/recipe_step/add_item/check_conditions_met(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#ifdef CWJ_DEBUG
	log_debug("Called add_item/check_conditions_met for [added_item], checking against item type [item_type]. Exact_path = [exact_path]")
	#endif
	if(!istype(added_item, /obj/item))
		return CWJ_CHECK_INVALID
	if(exact_path)
		if(added_item.type == item_type)
			return CWJ_CHECK_VALID
	else
		if(istype(added_item, item_type))
			return CWJ_CHECK_VALID
	return CWJ_CHECK_INVALID

//The quality of add_item is special, in that it inherits the quality level of its parent and
//passes it along.
//May need "Balancing" with var/inherited_quality_modifier
/datum/cooking/recipe_step/add_item/calculate_quality(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	var/raw_quality = added_item?:food_quality * inherited_quality_modifier
	return clamp_quality(raw_quality)

/datum/cooking/recipe_step/add_item/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	#ifdef CWJ_DEBUG
	log_debug("Called: /datum/cooking/recipe_step/add_item/follow_step")
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

		return list(message = "You add \the [added_item] to \the [container].")

	return list(message = "Something went real fucking wrong here!")
