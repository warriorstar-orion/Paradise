/obj/machinery/cooking
	name = "Default Cooking Appliance"
	desc = "You shouldn't be seeing this. Please report this as an issue on GitHub."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "processor"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/cooking = FALSE
	var/list/scan_types = list()
	var/quality_mod = 1

	new_attack_chain = TRUE
