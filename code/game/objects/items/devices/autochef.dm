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

/obj/item/autochef/Initialize(mapload)
	. = ..()


/obj/item/autochef/attack_obj(obj/O, mob/living/user, params)
	if(!..())
		return

	if(!is_type_in_list(allowed_machines))
		to_chat(user, "<span class='notice'>This won't work with [src]!</span>")
		return

	if(O in linked_machines)
		to_chat(user, "<span class='notice'>[O] is already linked to [src]!</span>")
		return

	linked_machines += O
	to_chat(user, "<span class='notice'>You link [O] to [src].</span>")
