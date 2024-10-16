/obj/item/autochef
	name = "autochef"
	icon = 'icons/obj/tools.dmi'
	icon_state = "autochef"

	var/list/linked_machines = list()
	var/static/list/allowed_machines = list(
		/obj/machinery/cooking_with_jane/grill,
		/obj/machinery/cooking_with_jane/oven,
		/obj/machinery/cooking_with_jane/stove,
		/obj/item/reagent_containers/cooking_with_jane/cooking_container/board,
	)

	new_attack_chain = TRUE

/obj/item/autochef/Initialize(mapload)
	. = ..()

/obj/item/autochef/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!..())
		return ITEM_INTERACT_BLOCKING

	if(!is_type_in_list(allowed_machines))
		to_chat(user, "<span class='notice'>This won't work with [src]!</span>")
		return ITEM_INTERACT_BLOCKING

	if(interacting_with in linked_machines)
		to_chat(user, "<span class='notice'>[interacting_with] is already linked to [src]!</span>")
		return ITEM_INTERACT_BLOCKING

	linked_machines += interacting_with
	to_chat(user, "<span class='notice'>You link [interacting_with] to [src].</span>")
	return ITEM_INTERACT_SUCCESS
