/obj/item/autochef
	name = "autochef"
	icon = 'icons/obj/tools.dmi'
	icon_state = "autochef"

	var/list/linked_machines = list()
	var/list/linked_cooking_containers = list()
	var/list/linked_inventories = list()

	new_attack_chain = TRUE

/obj/item/autochef/Initialize(mapload)
	. = ..()

/obj/item/autochef/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(interacting_with in linked_machines)
		to_chat(user, "<span class='notice'>[interacting_with] is already linked to [src]!</span>")
		return ITEM_INTERACT_BLOCKING

	if(istype(interacting_with, /obj/item/reagent_containers/cooking_with_jane/cooking_container))
		linked_cooking_containers += interacting_with
	else if(istype(interacting_with, /obj/machinery/cooking_with_jane))
		linked_machines += interacting_with
	else if(istype(interacting_with, /obj/machinery/smartfridge))
		linked_inventories += interacting_with
	else
		return

	to_chat(user, "<span class='notice'>You link [interacting_with] to [src].</span>")
	return ITEM_INTERACT_SUCCESS

/obj/item/autochef/activate_self(mob/user)
	if(..())
		return

	attempt_recipe()

/obj/item/autochef/proc/find_valid_container(container_type)
	for(var/obj/item/reagent_containers/cooking_with_jane/cooking_container/container in linked_cooking_containers)
		if(container_type == container.appliancetype)
			return container

/obj/item/autochef/proc/attempt_recipe()
	var/recipe_type = /datum/cooking_with_jane/recipe/burger
	var/datum/cooking_with_jane/recipe/goal
	for(var/datum/cooking_with_jane/recipe/recipe in GLOB.cwj_recipe_list)
		if(recipe_type == recipe.type) // exact
			goal = recipe

	if(!goal)
		log_debug("Couldn't find recipe")
		return



	return
