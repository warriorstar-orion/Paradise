RESTRICT_TYPE(/obj/item/autochef_remote)

/obj/item/autochef_remote
	name = "autochef remote"
	icon = 'icons/obj/tools.dmi'
	icon_state = "autochef"

	new_attack_chain = TRUE

	var/list/linkable_machine_uids = list()
	VAR_PRIVATE/static/list/valid_machines = list(
		/obj/item/reagent_containers/cooking_with_jane/cooking_container,
		/obj/machinery/cooking_with_jane,
		/obj/machinery/smartfridge,
	)

/obj/item/autochef_remote/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/target_uid = interacting_with.UID()
	if(target_uid in linkable_machine_uids)
		to_chat(user, "<span class='notice'>[interacting_with] is already linked to [src]!</span>")
		return ITEM_INTERACT_BLOCKING

	if(is_type_in_list(interacting_with, valid_machines))
		linkable_machine_uids |= target_uid
	else
		return

	to_chat(user, "<span class='notice'>You add [interacting_with] to [src]'s buffer.</span>")

	return ITEM_INTERACT_SUCCESS
