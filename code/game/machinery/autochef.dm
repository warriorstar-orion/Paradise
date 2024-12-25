RESTRICT_TYPE(/obj/machinery/autochef)

#define AUTOCHEF_RECIPE_NONE			0
#define AUTOCHEF_RECIPE_PROCESSING		1
#define AUTOCHEF_RECIPE_SELECTED		2
#define AUTOCHEF_RECIPE_COMPLETE		3
#define AUTOCHEF_CONTAINER_LOCATING		4
#define AUTOCHEF_CONTAINER_MISSING		5
#define AUTOCHEF_CONTAINER_LOCATED		6
#define AUTOCHEF_INGREDIENTS_LOCATING	7
#define AUTOCHEF_INGREDIENTS_MISSING	8
#define AUTOCHEF_INGREDIENTS_LOCATED	9
#define AUTOCHEF_WAITING_ON_MACHINE		10

/obj/machinery/autochef
	name = "autochef"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "autochef"

	new_attack_chain = TRUE

	VAR_PRIVATE/list/linked_cooking_containers = list()
	VAR_PRIVATE/list/linked_machines = list()
	VAR_PRIVATE/list/linked_storages = list()

	VAR_PRIVATE/obj/item/reagent_containers/cooking/current_container
	VAR_PRIVATE/current_state = AUTOCHEF_RECIPE_NONE
	VAR_PRIVATE/current_step = 0
	VAR_PRIVATE/found_ingredients = 0
	VAR_PRIVATE/list/ingredients_searching = list()
	VAR_PRIVATE/datum/cooking/recipe/current_recipe

	VAR_PRIVATE/static/list/ingredient_locating_steps = list(
		CWJ_ADD_ITEM,
		CWJ_ADD_REAGENT,
		CWJ_ADD_PRODUCE,
	)

	COOLDOWN_DECLARE(next_step_cd)

/obj/machinery/autochef/attack_hand(mob/user)
	if(..())
		return

	attempt_recipe()

/obj/machinery/autochef/item_interaction(mob/living/user, obj/item/autochef_remote/remote, list/modifiers)
	if(!istype(remote))
		#warn Some kind of error
		return ITEM_INTERACT_COMPLETE

	for(var/uid in remote.linkable_machine_uids)
		var/obj = locateUID(uid)
		var/success = FALSE
		if(obj)
			if(istype(obj, /obj/item/reagent_containers/cooking))
				linked_cooking_containers += obj
				success = TRUE
			else if(istype(obj, /obj/machinery/cooking))
				linked_machines += obj
				success = TRUE
			else if(istype(obj, /obj/machinery/smartfridge))
				linked_storages += obj
				success = TRUE

		if(success)
			RegisterSignal(obj, COMSIG_PARENT_QDELETING, PROC_REF(unlink))
			to_chat(user, "<span class='notice'>[obj] is registered to [src].</span>")
			remote.linkable_machine_uids -= uid

		else
			#warn some kind of error
			return ITEM_INTERACT_COMPLETE

	return ITEM_INTERACT_COMPLETE

/obj/machinery/autochef/proc/unlink(datum/source)
	SIGNAL_HANDLER // COMSIG_PARENT_QDELETING
	return

/obj/machinery/autochef/proc/find_valid_container(container_type)
	for(var/obj/item/reagent_containers/cooking/container in linked_cooking_containers)
		if(container_type == container.appliancetype)
			return container

/obj/machinery/autochef/proc/attempt_recipe()
	if(current_recipe)
		atom_say("Recipe currently in progress.")
		return

	if(!length(linked_cooking_containers))
		atom_say("No linked cooking machines.")
		return

	if(!length(linked_storages))
		atom_say("No linked storage units.")
		return

	var/recipe_type = /datum/cooking/recipe/burger
	for(var/datum/cooking/recipe/recipe in GLOB.cwj_recipe_list)
		if(recipe_type == recipe.type) // exact
			current_recipe = recipe

	if(!current_recipe)
		#warn better error
		log_debug("Couldn't find recipe")
		return

	atom_say("Building recipe: [current_recipe].")
	found_ingredients = 0
	ingredients_searching.Cut()
	current_state = AUTOCHEF_RECIPE_SELECTED
	COOLDOWN_START(src, next_step_cd, 1.5 SECONDS)

/obj/machinery/autochef/process()
	if(!COOLDOWN_FINISHED(src, next_step_cd))
		return

	COOLDOWN_START(src, next_step_cd, 1.5 SECONDS)

	switch(current_state)
		if(AUTOCHEF_RECIPE_NONE)
			return
		if(AUTOCHEF_RECIPE_SELECTED)
			atom_say("Locating [current_recipe.cooking_container].")
			current_state = AUTOCHEF_CONTAINER_LOCATING
		if(AUTOCHEF_CONTAINER_LOCATING)
			for(var/obj/item/reagent_containers/cooking/container in linked_cooking_containers)
				if(container.appliancetype == current_recipe.cooking_container)
					atom_say("[container] located.")
					current_state = AUTOCHEF_CONTAINER_LOCATED
					current_container = container
		if(AUTOCHEF_CONTAINER_LOCATED)
			atom_say("Locating ingredients.")

			for(var/list/step in current_recipe.step_builder)
				if(step[1] in ingredient_locating_steps)
					ingredients_searching += step[2]

			current_state = AUTOCHEF_INGREDIENTS_LOCATING
		if(AUTOCHEF_INGREDIENTS_LOCATING)
			if(length(ingredients_searching))
				var/next_ingredient_type = popleft(ingredients_searching)
				for(var/storage in linked_storages)
					for(var/obj/possible_item in storage)
						if(istype(possible_item, next_ingredient_type))
							atom_say("[possible_item] located.")
							Beam(storage, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
							possible_item.forceMove(src)
							found_ingredients++
							return

			if(found_ingredients < length(ingredients_searching))
				atom_say("Could not locate all ingredients.")
				current_state = AUTOCHEF_INGREDIENTS_MISSING
			else
				atom_say("All ingredients located.")
				current_state = AUTOCHEF_RECIPE_PROCESSING
		if(AUTOCHEF_RECIPE_PROCESSING)
			if(length(contents))
				var/obj/next_item = popleft(contents)
				current_container.item_interaction(src, next_item)
				Beam(current_container, icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
				atom_say("Added [next_item].")

			if(!length(contents))
				current_state = AUTOCHEF_RECIPE_COMPLETE

		if(AUTOCHEF_RECIPE_COMPLETE)
			atom_say("Recipe complete.")
			current_container.do_empty(src)
			current_state = AUTOCHEF_RECIPE_NONE


/obj/machinery/autochef/proc/collect_items()
	return
