/// A cooking step that involves using an item on the food.
/datum/cooking/recipe_step/use_item
	// class = PCWJ_USE_ITEM

	var/required_item_type
	var/exact_path = FALSE //Tests if the item has to be the EXACT ITEM PATH, or just a child of the item path.

//item_type: The type path of the object we are looking for.
//base_quality_award: The quality awarded by following this step.
//our_recipe: The parent recipe object
/datum/cooking/recipe_step/use_item/New(obj/item/item_type, datum/cooking/recipe/our_recipe)
	#ifdef PCWJ_DEBUG
	if(!ispath(item_type))
		log_debug("/datum/cooking/recipe_step/add_item/New(): item [item_type] is not a valid path")
	#endif

	desc = "Apply \a [item_type::name]."

	required_item_type = item_type
	group_identifier = item_type

	#ifdef PCWJ_DEBUG
	else
		log_debug("/datum/cooking/recipe_step/add_item/New(): item [item_type] couldn't be created.")
	#endif
	..(our_recipe)

/datum/cooking/recipe_step/use_item/check_conditions_met(var/obj/added_item, var/datum/cooking/recipe_tracker/tracker)
	if(src.exact_path)
		if(added_item.type == required_item_type)
			return PCWJ_CHECK_VALID
	else
		if(istype(added_item,required_item_type))
			return PCWJ_CHECK_VALID
	return PCWJ_CHECK_INVALID

//Think about a way to make this more intuitive?
/datum/cooking/recipe_step/use_item/calculate_quality(var/obj/added_item)
	return clamp_quality(0)
