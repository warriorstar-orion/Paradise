RESTRICT_TYPE(/obj/machinery/autochef)

#define AUTOCHEF_RECIPE_NONE 0
#define AUTOCHEF_RECIPE_PROCESSING 1
#define AUTOCHEF_RECIPE_SELECTED 2
#define AUTOCHEF_RECIPE_COMPLETE 3
#define AUTOCHEF_CONTAINER_LOCATING 4
#define AUTOCHEF_CONTAINER_MISSING 5
#define AUTOCHEF_CONTAINER_LOCATED 6
#define AUTOCHEF_INGREDIENTS_LOCATING 7
#define AUTOCHEF_INGREDIENTS_MISSING 8
#define AUTOCHEF_INGREDIENTS_LOCATED 9
#define AUTOCHEF_WAITING_ON_MACHINE 10
#define AUTOCHEF_RECIPE_WAITING 11
#define AUTOCHEF_RECIPE_ERROR 12

/obj/machinery/autochef
	name = "autochef"
	icon = 'icons/obj/machines/autochef.dmi'
	icon_state = "base"

	var/list/linked_cooking_containers = list()
	var/list/linked_machines = list()
	var/list/linked_storages = list()

	var/obj/item/reagent_containers/cooking/current_container

	var/current_state = AUTOCHEF_RECIPE_WAITING
	var/current_step = 0
	var/found_ingredients = 0
	var/list/ingredients_searching = list()
	var/datum/cooking/recipe/current_recipe

	COOLDOWN_DECLARE(next_step_cd)

/obj/machinery/autochef/attack_hand(mob/user)
	if(..())
		return

	attempt_recipe()

/obj/machinery/autochef/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	var/obj/item/food/food_item = used
	if(istype(food_item))
		if(current_recipe)
			atom_say("Recipe currently in progress.")
			return ITEM_INTERACT_COMPLETE

		for(var/container_type in GLOB.pcwj_recipe_dictionary)
			for(var/datum/cooking/recipe/recipe in GLOB.pcwj_recipe_dictionary[container_type])
				if(recipe.product_type == food_item.type)
					current_recipe = recipe
					atom_say("Recipe selected: [food_item].")
					return ITEM_INTERACT_COMPLETE

		log_debug("Couldn't find recipe")
		return ITEM_INTERACT_COMPLETE

	var/obj/item/autochef_remote/remote = used

	if(!istype(remote))
		return ITEM_INTERACT_COMPLETE

	for(var/uid in remote.linkable_machine_uids)
		var/obj = locateUID(uid)
		var/success = FALSE
		if(obj)
			if(istype(obj, /obj/item/reagent_containers/cooking))
				linked_cooking_containers |= obj
				success = TRUE
			else if(istype(obj, /obj/machinery/cooking))
				linked_machines |= obj
				success = TRUE
			else if(istype(obj, /obj/machinery/smartfridge))
				linked_storages |= obj
				success = TRUE

		if(success)
			RegisterSignal(obj, COMSIG_PARENT_QDELETING, PROC_REF(unlink))
			to_chat(user, "<span class='notice'>[obj] is registered to [src].</span>")
		else
			to_chat(user, "<span class='notice'>[src] failed to register [obj].</span>")

		return ITEM_INTERACT_COMPLETE

	return ITEM_INTERACT_COMPLETE

/obj/machinery/autochef/proc/unlink(datum/source)
	SIGNAL_HANDLER // COMSIG_PARENT_QDELETING
	return

/obj/machinery/autochef/proc/find_free_container(container_type)
	for(var/obj/item/reagent_containers/cooking/container in linked_cooking_containers)
		if(container.type == container_type && container.get_usable_status() == PCWJ_CONTAINER_AVAILABLE && isInSight(src, container))
			return container

/obj/machinery/autochef/proc/attempt_recipe()
	if(!current_state == AUTOCHEF_RECIPE_WAITING)
		atom_say("Recipe currently in progress.")
		return

	if(!length(linked_cooking_containers))
		atom_say("No linked cooking machines.")
		return

	if(!length(linked_storages))
		atom_say("No linked storage units.")
		return

	atom_say("Preparing.")
	found_ingredients = 0
	ingredients_searching.Cut()
	current_state = AUTOCHEF_RECIPE_SELECTED
	COOLDOWN_START(src, next_step_cd, 0.5 SECONDS)

/obj/machinery/autochef/proc/stop_it()
	atom_say("Stop fucking with my shit!")
	disassociate_container()

/obj/machinery/autochef/proc/stop_it_man(datum/source, atom/destination)
	if(ismob(destination))
		atom_say("Stop fucking with my shit!")
		disassociate_container()

/obj/machinery/autochef/proc/disassociate_container()
	if(!current_container)
		return
	current_state = AUTOCHEF_RECIPE_NONE
	current_container = null
	UnregisterSignal(current_container, list(COMSIG_ATOM_ENTERED, COMSIG_COOKING_CONTAINER_MODIFIED))

/obj/machinery/autochef/process()
	if(!COOLDOWN_FINISHED(src, next_step_cd))
		return

	COOLDOWN_START(src, next_step_cd, 0.5 SECONDS)

	switch(current_state)
		if(AUTOCHEF_RECIPE_NONE)
			return
		if(AUTOCHEF_RECIPE_SELECTED)
			var/obj/item/reagent_containers/cooking/container_type = current_recipe.cooking_container
			// atom_say("Locating [container_type::name].")
			current_state = AUTOCHEF_CONTAINER_LOCATING
		if(AUTOCHEF_CONTAINER_LOCATING)
			var/obj/item/reagent_containers/cooking/container = find_free_container(current_recipe.cooking_container)
			if(container)
				container.claimed = TRUE
				atom_say("[container] located.")
				current_state = AUTOCHEF_CONTAINER_LOCATED
				current_container = container
				RegisterSignal(current_container, COMSIG_COOKING_CONTAINER_MODIFIED, PROC_REF(stop_it))
				RegisterSignal(current_container, COMSIG_ATOM_ENTERED, PROC_REF(stop_it_man))
		if(AUTOCHEF_CONTAINER_LOCATED)
			atom_say("Locating ingredients.")
			for(var/datum/cooking/recipe_step/step in current_recipe.steps)
				if(step.optional)
					continue
				var/datum/cooking/recipe_step/add_item/add_item_step = step
				if(istype(add_item_step))
					ingredients_searching += add_item_step.item_type
					continue
				var/datum/cooking/recipe_step/add_produce/add_produce_step = step
				if(istype(add_produce_step))
					ingredients_searching += add_produce_step.produce_type
					continue

			current_state = AUTOCHEF_INGREDIENTS_LOCATING
		if(AUTOCHEF_INGREDIENTS_LOCATING)
			if(length(ingredients_searching))
				var/next_ingredient_type = popleft(ingredients_searching)
				for(var/storage in linked_storages)
					for(var/obj/possible_item in storage)
						if(istype(possible_item, next_ingredient_type))
							// atom_say("[possible_item] located.")
							Beam(storage, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
							possible_item.forceMove(src)
							found_ingredients++
							return

			if(found_ingredients < length(ingredients_searching))
				atom_say("Could not locate all ingredients.")
				current_state = AUTOCHEF_INGREDIENTS_MISSING
			else
				// atom_say("All ingredients located. Processing...")
				current_step = 1
				current_state = AUTOCHEF_RECIPE_PROCESSING
		if(AUTOCHEF_RECIPE_PROCESSING)
			var/datum/cooking/recipe_step/step = current_recipe.steps[current_step]
			var/result = step.attempt_autochef_perform(src)
			if(!result)
				atom_say("Recipe failed.")
				current_state = AUTOCHEF_RECIPE_ERROR
				return
			switch(result)
				if(AUTOCHEF_RECIPE_PROCESSING)
					current_step++
					if(current_step > length(current_recipe.steps))
						current_state = AUTOCHEF_RECIPE_COMPLETE
				else
					current_state = result
		if(AUTOCHEF_WAITING_ON_MACHINE)
			for(var/atom/movable/content in current_container.contents)
				if(istype(content, current_recipe.product_type))
					current_state = AUTOCHEF_RECIPE_COMPLETE
		if(AUTOCHEF_RECIPE_COMPLETE)
			atom_say("Recipe complete.")
			var/turf/center = get_turf(current_container)
			for(var/turf/T in RANGE_EDGE_TURFS(1, center))
				if(locate(/obj/structure/table) in T)
					for(var/atom/movable/content in current_container.contents)
						content.forceMove(T)
						content.pixel_x = rand(-8, 8)
						content.pixel_y = rand(-8, 8)

			current_container.do_empty(src)
			current_container.claimed = FALSE
			UnregisterSignal(current_container, list(COMSIG_ATOM_ENTERED, COMSIG_COOKING_CONTAINER_MODIFIED))
			current_state = AUTOCHEF_RECIPE_NONE

/obj/machinery/autochef/proc/collect_items()
	return
