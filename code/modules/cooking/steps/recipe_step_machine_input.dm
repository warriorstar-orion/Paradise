RESTRICT_TYPE(/datum/cooking/recipe_step/machine_input)

/datum/cooking/recipe_step/machine_input
	step_verb_desc = "Add item"
	var/obj/item_type
	var/exact_path

/datum/cooking/recipe_step/machine_input/New(item_type_, options)
	item_type = item_type_

	..(options)

/datum/cooking/recipe_step/machine_input/check_conditions_met(obj/added_item, datum/cooking/recipe_tracker/tracker)
	#ifdef CWJ_DEBUG
	log_debug("Called add_item/check_conditions_met for [added_item], checking against item type [item_type]. Exact_path = [exact_path]")
	#endif
	var/obj/machinery/cooking/machine = added_item
	if(istype(added_item))
		for(var/atom/movable/content in added_item.contents)
			if(istype(content, item_type))
				return CWJ_CHECK_VALID

	return CWJ_CHECK_INVALID

//The quality of add_item is special, in that it inherits the quality level of its parent and
//passes it along.
//May need "Balancing" with var/inherited_quality_modifier
/datum/cooking/recipe_step/machine_input/calculate_quality(obj/added_item, datum/cooking/recipe_tracker/tracker)
	return ..()

/datum/cooking/recipe_step/machine_input/follow_step(obj/added_item, datum/cooking/recipe_tracker/tracker, mob/user)
	var/obj/machinery/cooking/machine = added_item
	if(istype(added_item))
		var/obj/item/reagent_containers/cooking/container = locateUID(tracker.container_uid)
		if(istype(container))
			for(var/atom/movable/content in machine.contents)
				if(istype(content, item_type))
					content.forceMove(container)

		machine.machine_input_type = null

	return list()

// /datum/cooking/recipe_step/add_item/get_wiki_formatted_instruction()
// 	var/slug = "[item_type::name]"
// 	if(ispath(item_type, /obj/item/food))
// 		var/obj/item/food/food_type = item_type
// 		slug = "{{RecursiveFood/[item_type::name]}}"
// 	return "Add \a [slug]."

// /datum/cooking/recipe_step/add_item/equals(datum/cooking/recipe_step/other)
// 	var/datum/cooking/recipe_step/add_item/other_add_item = other
// 	if(!istype(other_add_item))
// 		return FALSE

// 	return item_type == other_add_item.item_type && exact_path == other_add_item.exact_path && optional == other_add_item.optional
