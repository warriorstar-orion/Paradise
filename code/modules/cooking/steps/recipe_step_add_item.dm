RESTRICT_TYPE(/datum/cooking/recipe_step/add_item)

// TODO for v2: See if a "count" option can be added to reduce
// the need for both longer recipe step lists, and whatever
// fuckery I eventually come up with for combining equivalent
// steps for generating instructions for the wiki.
/datum/cooking/recipe_step/add_item
	step_verb_desc = "Add item"
	var/obj/item_type
	var/exact_path
	var/skip_reagents = FALSE
	var/list/exclude_reagents

/datum/cooking/recipe_step/add_item/New(item_type_, options)
	item_type = item_type_

	if("exact" in options)
		exact_path = options["exact"]
	if("skip_reagents" in options)
		skip_reagents = options["skip_reagents"]
	if("exclude_reagents" in options)
		exclude_reagents = options["exclude_reagents"]

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
/datum/cooking/recipe_step/add_item/calculate_quality(obj/added_item, datum/cooking/recipe_tracker/tracker)
	var/obj/item/food/food_item = added_item
	if(istype(food_item))
		var/raw_quality = food_item.food_quality * inherited_quality_modifier

		return clamp_quality(raw_quality)

	return ..()

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

		return list(message = "You add \the [added_item] to \the [container].", target = added_item.UID())

	return list(message = "Something went real fucking wrong here!")

/datum/cooking/recipe_step/add_item/get_wiki_formatted_instruction()
	var/slug = "[item_type::name]"
	if(ispath(item_type, /obj/item/food))
		var/obj/item/food/food_type = item_type
		slug = "{{RecursiveFood/[item_type::name]}}"
	return "Add \a [slug]."

/datum/cooking/recipe_step/add_item/equals(datum/cooking/recipe_step/other)
	var/datum/cooking/recipe_step/add_item/other_add_item = other
	if(!istype(other_add_item))
		return FALSE

	return item_type == other_add_item.item_type && exact_path == other_add_item.exact_path && optional == other_add_item.optional

/datum/cooking/recipe_step/add_item/attempt_autochef_perform(obj/machinery/autochef/autochef)
	for(var/atom/movable/content in autochef.contents)
		if(istype(content, item_type))
			autochef.current_container.item_interaction(src, content)
			autochef.Beam(autochef.current_container, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
			// autochef.atom_say("Added [content].")
			return AUTOCHEF_RECIPE_PROCESSING
