/obj/machinery/cooking/ice_cream_mixer
	name = "Ice cream mixer"
	desc = "An industrial mixing device for desserts of all kinds."

	icon = 'icons/obj/cwj_cooking/eris_kitchen.dmi'
	icon_state = "cereal_off"

	var/on = FALSE


/obj/machinery/cooking/ice_cream_mixer/process()
	if(on)
		return
