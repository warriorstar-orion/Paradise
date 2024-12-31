/**
 * Cooking containers are used in ovens, fryers and so on, to hold multiple
 * ingredients for a recipe. They interact with the cooking process, and link
 * up with the cooking code dynamically. Originally sourced from the Aurora,
 * heavily retooled to actually work with CWJ Holder for a portion of an
 * incomplete meal, allows a cook to temporarily offload recipes to work on
 * things factory-style, eliminating the need for 20 plates to get things done
 * fast.
 **/
/obj/item/reagent_containers/cooking
	icon = 'icons/obj/cwj_cooking/kitchen.dmi'
	#warn fix descp info
	// description_info = "Can be emptied of physical food with alt-click."
	var/shortname
	var/place_verb = "into"
	w_class = WEIGHT_CLASS_SMALL
	volume = 240 //Don't make recipes using reagents in larger quantities than this amount; they won't work.
	var/datum/cooking/recipe_tracker/tracker = null //To be populated the first time the plate is interacted with.
	var/lip //Icon state of the lip layer of the object
	var/removal_penalty = 0 //A flat quality reduction for removing an unfinished recipe from the container.

	possible_transfer_amounts = list(5,10,30,50,100,200)
	amount_per_transfer_from_this = 10

	#warn fix "no react" flag
	// reagent_flags = OPENCONTAINER | NO_REACT
	container_type = OPENCONTAINER
	var/list/stove_data = list("High" = 0, "Medium" = 0, "Low" = 0) //Record of what stove-cooking has been done on this food.
	var/list/grill_data = list("High" = 0, "Medium" = 0, "Low" = 0) //Record of what grill-cooking has been done on this food.
	var/list/oven_data =  list("High" = 0, "Medium" = 0, "Low" = 0) //Record of what oven-cooking has been done on this food.

	new_attack_chain = TRUE

/obj/item/reagent_containers/cooking/examine(mob/user)
	. = ..()

	if(contents)
		. += get_content_info()
	if(reagents.total_volume)
		. += get_reagent_info()

/obj/item/reagent_containers/cooking/proc/get_content_info()
	var/string = "It contains:</br><ul><li>"
	string += jointext(contents, "</li><li>") + "</li></ul>"
	return string

/obj/item/reagent_containers/cooking/proc/get_reagent_info()
	return "It contains [reagents.total_volume] units of reagents."

/obj/item/reagent_containers/cooking/proc/get_usable_status()
	if(tracker)
		return CWJ_CONTAINER_BUSY
	if(length(contents) || reagents.total_volume > 0)
		return CWJ_CONTAINER_BUSY

	return CWJ_CONTAINER_AVAILABLE

/obj/item/reagent_containers/cooking/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	#ifdef CWJ_DEBUG
	log_debug("[__PROC__]")
	#endif

	if(istype(used, /obj/item/autochef_remote))
		return

	if(!tracker && (contents.len || reagents.total_volume != 0))
		to_chat(user, "The [src] is full. Empty its contents first.")
		return ITEM_INTERACT_COMPLETE

	new_process_item(user, used)

	return ITEM_INTERACT_COMPLETE

/obj/item/reagent_containers/cooking/proc/new_process_item(mob/user, obj/used)
	if(!istype(used))
		return CWJ_NO_STEPS

	if(!tracker)
		if(!(type in GLOB.cwj_recipe_dictionary))
			return CWJ_NO_STEPS

		var/list/container_recipes = GLOB.cwj_recipe_dictionary[type]
		if(!length(container_recipes))
			return CWJ_NO_STEPS

		tracker = new(src)

		for(var/datum/cooking/recipe/recipe in container_recipes)
			tracker.matching_recipe_steps[recipe] = 0

	react_to_process(tracker.process_item_wrap(user, used), user, used)

/obj/item/reagent_containers/cooking/standard_pour_into(mob/user, atom/target)
	#ifdef CWJ_DEBUG
	log_debug("cooking_container/standard_pour_into() called!")
	#endif

	if(tracker)
		#warn turn alert to tgui_alert
		if(alert(user, "There is an ongoing recipe in the [src]. Dump it out?",,"Yes","No") == "No")
			return FALSE
		for(var/datum/reagent/our_reagent in reagents.reagent_list)
			if(our_reagent.data && istype(our_reagent.data, /list) && our_reagent.data["FOOD_QUALITY"])
				our_reagent.data["FOOD_QUALITY"] = 0

	do_empty(user, target, reagent_clear = FALSE)

	#ifdef CWJ_DEBUG
	log_debug("cooking_container/do_empty() completed!")
	#endif

	. = ..(user, target)

/obj/item/reagent_containers/cooking/after_attack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()

	if(!istype(target, /obj/item/reagent_containers))
		return
	if(!proximity_flag)
		return
	if(tracker)
		return
	if(standard_pour_into(user, target))
		return 1

/obj/item/reagent_containers/cooking/proc/react_to_process(reaction_status, mob/user, obj/used)
	if(istype(used, /obj/machinery/cooking) && reaction_status == CWJ_NO_STEPS)
		// When a finished recipe is still sitting on a cooking machine,
		// and the cooking machine is sending periodic process pings as it
		// is activated, the container will still be processed and a tracker
		// created, because the result from the finished recipe counts as the
		// potential input to a new recipe. Which is valid; it may be the input
		// to a new recipe. But if it's not, we don't want a message to keep
		// showing up as if the player is trying to step through a recipe.
		return

	if(reaction_status == CWJ_NO_STEPS && !tracker.recipe_started)
		to_chat(user, "You don't know what you'd begin to make with this.")
		return

	switch(reaction_status)
		if(CWJ_NO_RECIPES)
			to_chat(user, "You don't know what you'd begin to make with this.")
		if(CWJ_NO_STEPS)
			to_chat(user, "You get a feeling this wouldn't improve the recipe.")
		if(CWJ_SUCCESS)
			if(tracker.step_reaction_message && ismob(user))
				to_chat(user, "<span class='notice'>[tracker.step_reaction_message]</span>")

			update_appearance(UPDATE_ICON)
		if(CWJ_COMPLETE)
			if(tracker.step_reaction_message && ismob(user))
				to_chat(user, "<span class='notice'>[tracker.step_reaction_message]</span>")
				to_chat(user, "You finish cooking with \the [src].")
			QDEL_NULL(tracker)
			clear_cooking_data()
			update_appearance(UPDATE_ICON)

/obj/item/reagent_containers/cooking/proc/process_item(obj/I, mob/user, lower_quality_on_fail = 0, send_message = TRUE)
	#ifdef CWJ_DEBUG
	log_debug("cooking_container/process_item() called!")
	#endif

	//OK, time to load the tracker
	if(!tracker)
		if(lower_quality_on_fail)
			#warn fix this
			// for (var/obj/item/contained in contents)
			// 	contained?:food_quality -= lower_quality_on_fail
		else
			tracker = new /datum/cooking/recipe_tracker(src)

	var/return_value = 0
	switch(tracker.process_item_wrap(I, user))
		if(CWJ_NO_STEPS)
			if(send_message)
				to_chat(user, "It doesn't seem like you can create a meal from that. Yet.")
			// if(lower_quality_on_fail)
			// 	for (var/datum/cooking/recipe_pointer/pointer in tracker.active_recipe_pointers)
			// 		#warn oh god
			// 		pointer?:tracked_quality -= lower_quality_on_fail
		if(CWJ_CHOICE_CANCEL)
			if(send_message)
				to_chat(user, "You decide against cooking with the [src].")
		if(CWJ_COMPLETE)
			if(send_message)
				to_chat(user, "You finish cooking with the [src].")
			qdel(tracker)
			tracker = null
			clear_cooking_data()
			update_icon()
			return_value = 1
		if(CWJ_SUCCESS)
			if(send_message)
				to_chat(user, "You have successfully completed a recipe step.")
			clear_cooking_data()
			return_value = 1
			update_icon()
		if(CWJ_PARTIAL_SUCCESS)
			if(send_message)
				to_chat(user, "More must be done to complete this step of the recipe.")
		if(CWJ_LOCKOUT)
			if(send_message)
				to_chat(user, "You can't make the same decision twice!")

	if(tracker && !tracker.recipe_started)
		qdel(tracker)
		tracker = null
	return return_value

//TODO: Handle the contents of the container being ruined via burning.
/obj/item/reagent_containers/cooking/proc/handle_burning()
	clear()
	new/obj/item/food/badrecipe(src)
	update_appearance(UPDATE_ICON)

//TODO: Handle the contents of the container lighting on actual fire.
/obj/item/reagent_containers/cooking/proc/handle_ignition()
	clear()
	update_appearance(UPDATE_ICON)
	return TRUE

/obj/item/reagent_containers/cooking/verb/empty()
	set src in view(1)
	set name = "Empty Container"
	set category = "Object"
	set desc = "Removes items from the container, excluding reagents."
	do_empty(usr)

/obj/item/reagent_containers/cooking/proc/do_empty(mob/user, atom/target, reagent_clear = TRUE)
	#ifdef CWJ_DEBUG
	log_debug("cooking_container/do_empty() called!")
	#endif

	if(contents.len != 0)
		if(tracker && removal_penalty)
			for (var/obj/item/contained in contents)
				#warn fix food quality
				// contained?:food_quality -= removal_penalty
			if(ismob(user))
				to_chat(user, "<span class='warning'>The quality of ingredients in the [src] was reduced by the extra jostling.</span>")

		//Handle quality reduction for reagents
		if(reagents.total_volume != 0)
			var/reagent_qual_reduction = round(reagents.total_volume/contents.len)
			if(reagent_qual_reduction != 0)
				for (var/obj/item/contained in contents)
					#warn fix food quality
					// contained?:food_quality -= reagent_qual_reduction
				if(ismob(user))
					to_chat(user, "<span class='warning'>The quality of ingredients in the [src] was reduced by the presence of reagents in the container.</span>")

		for (var/contained in contents)
			var/atom/movable/AM = contained
			remove_from_visible(AM)
			if(!target)
				AM.forceMove(get_turf(src))
			else
				AM.forceMove(get_turf(target))

	//TODO: Splash the reagents somewhere
	if(reagent_clear)
		reagents.clear_reagents()

	update_icon()
	qdel(tracker)
	tracker = null
	clear_cooking_data()

	if(contents.len != 0 && ismob(user))
		to_chat(user, "<span class='notice'>You remove all the solid items from [src].</span>")

/obj/item/reagent_containers/cooking/AltClick(mob/user)
	do_empty(user)

//Deletes contents of container.
//Used when food is burned, before replacing it with a burned mess
/obj/item/reagent_containers/cooking/proc/clear()
	QDEL_LIST_CONTENTS(contents)
	contents = list()
	reagents.clear_reagents()
	if(tracker)
		qdel(tracker)
		tracker = null
	clear_cooking_data()

/obj/item/reagent_containers/cooking/proc/clear_cooking_data()
	stove_data = list("High"=0 , "Medium" = 0, "Low"=0)
	grill_data = list("High"=0 , "Medium" = 0, "Low"=0)

/obj/item/reagent_containers/cooking/proc/label(number, CT)
	#warn what is the CT param for
	//This returns something like "Fryer basket 1 - empty"
	//The latter part is a brief reminder of contents
	//This is used in the removal menu
	. = shortname
	if (!isnull(number))
		.+= " [number]"
	.+= " - "
	if (LAZYLEN(contents))
		var/obj/O = locate() in contents
		return . + O.name //Just append the name of the first object
	return . + "empty"

/obj/item/reagent_containers/cooking/update_icon()
	..()

	cut_overlays()
	for(var/obj/item/our_item in vis_contents)
		src.remove_from_visible(our_item)

	for(var/i=contents.len, i>=1, i--)
		var/obj/item/our_item = contents[i]
		src.add_to_visible(our_item)
	if(lip)
		add_overlay(image(src.icon, icon_state=lip, layer=ABOVE_OBJ_LAYER))

/obj/item/reagent_containers/cooking/proc/add_to_visible(obj/item/our_item)
	our_item.pixel_x = initial(our_item.pixel_x)
	our_item.pixel_y = initial(our_item.pixel_y)
	our_item.vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	our_item.blend_mode = BLEND_INSET_OVERLAY
	our_item.transform *= 0.6
	src.vis_contents += our_item

/obj/item/reagent_containers/cooking/proc/remove_from_visible(obj/item/our_item)
	our_item.vis_flags = 0
	our_item.blend_mode = 0
	our_item.transform = null
	src.vis_contents.Remove(our_item)

/obj/item/reagent_containers/cooking/plate
	icon = 'icons/obj/cwj_cooking/eris_kitchen.dmi'
	name = "serving plate"
	shortname = "plate"
	desc = "A shitty serving plate. You probably shouldn't be seeing this."
	icon_state = "plate"
	materials = list(MAT_METAL = 5)

/obj/item/reagent_containers/cooking/board
	name = "cutting board"
	shortname = "cutting_board"
	desc = "Good for making sandwiches on, too."
	icon_state = "cutting_board"
	item_state = "cutting_board"
	materials = list(MAT_WOOD = 5)

/obj/item/reagent_containers/cooking/sushimat
	name = "Sushi Mat"
	desc = "A wooden mat used for efficient sushi crafting."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "sushi_mat"
	force = 5
	throwforce = 5
	throw_speed = 3
	throw_range = 3
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("rolled", "cracked", "battered", "thrashed")

/obj/item/reagent_containers/cooking/oven
	name = "oven dish"
	shortname = "shelf"
	desc = "Put ingredients in this; designed for use with an oven. Warranty void if used."
	icon_state = "oven_dish"
	lip = "oven_dish_lip"
	item_state = "oven_dish"
	materials = list(MAT_METAL = 10)

/obj/item/reagent_containers/cooking/pan
	name = "pan"
	desc = "An normal pan."

	icon_state = "pan" //Default state is the base icon so it looks nice in the map builder
	lip = "pan_lip"
	item_state = "pan"
	// materials = list(MAT_PLASTEEL = 5)
	#warn do we genuinely not have plasteel as a mat
	materials = list(MAT_METAL = 5)
	hitsound = 'sound/weapons/smash.ogg'

/obj/item/reagent_containers/cooking/pot
	name = "cooking pot"
	shortname = "pot"
	desc = "Boil things with this. Maybe even stick 'em in a stew."

	icon = 'icons/obj/cwj_cooking/eris_kitchen.dmi'
	icon_state = "pot"
	lip = "pot_lip"
	item_state = "pot"
	materials = list(MAT_METAL = 5)

	hitsound = 'sound/weapons/smash.ogg'
	removal_penalty = 5
	w_class = WEIGHT_CLASS_BULKY

/obj/item/reagent_containers/cooking/deep_basket
	name = "deep fryer basket"
	shortname = "basket"
	desc = "Cwispy! Warranty void if used."

	icon_state = "deepfryer_basket"
	lip = "deepfryer_basket_lip"
	item_state = "deepfryer_basket"
	removal_penalty = 5

/obj/item/reagent_containers/cooking/air_basket
	name = "air fryer basket"
	shortname = "basket"
	desc = "Permanently laminated with dried oil and late-stage capitalism."

	icon_state = "airfryer_basket"
	lip = "airfryer_basket_lip"
	item_state = "airfryer_basket"
	removal_penalty = 5

/obj/item/reagent_containers/cooking/grill_grate
	name = "grill grate"
	shortname = "grate"
	place_verb = "onto"
	desc = "Primarily used to grill meat, place this on a grill and enjoy an ancient human tradition."

	icon_state = "grill_grate"
	materials = list(MAT_METAL = 5)

/obj/item/reagent_containers/cooking/bowl
	name = "prep bowl"
	shortname = "bowl"
	desc = "A bowl for mixing, or tossing a salad. Not to be eaten out of"

	icon_state = "bowl"
	lip = "bowl_lip"
	item_state = "pot"
	materials = list(MAT_PLASTIC = 5)

	removal_penalty = 2

/obj/item/reagent_containers/cooking/icecream_bowl
	name = "freezing bowl"
	shortname = "mixerbowl"
	desc = "A stainless steel bowl that fits into the ice cream mixer."
	icon = 'icons/obj/cwj_cooking/eris_kitchen.dmi'
	icon_state = "ice_cream_bowl"
	lip = "ice_cream_bowl_lip"

	var/freezing_time = 0
