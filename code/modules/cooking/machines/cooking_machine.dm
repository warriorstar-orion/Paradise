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
	var/list/allowed_inputs = list()
	var/machine_input_count = 0
	var/max_machine_inputs = 10
	var/machine_input_type
	var/quality_mod = 1

	new_attack_chain = TRUE

/obj/machinery/cooking/proc/ignite()
	resistance_flags |= ON_FIRE
	new /obj/effect/fire(loc, T0C + 300, (roll("2d10+15") SECONDS), 1)
