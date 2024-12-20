/obj/machinery/cooking
	name = "Default Cooking Appliance"
	desc = "Lookit me, I'm a cool machinery-doo. Hex didn't take his focus pills today."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "processor"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/cooking = FALSE
	var/list/scan_types = list()
	var/quality_mod = 1

	new_attack_chain = TRUE
