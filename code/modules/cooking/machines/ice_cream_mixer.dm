/datum/cooking_surface/ice_cream_mixer
	var/obj/machinery/cooking/ice_cream_mixer/mixer
	cooker_id = COOKER_SURFACE_ICE_CREAM_MIXER

// A bit more tightly coupled to handle appearance updates
/datum/cooking_surface/ice_cream_mixer/New(obj/machinery/cooking/ice_cream_mixer/mixer_)
	mixer = mixer_

/datum/cooking_surface/ice_cream_mixer/turn_on(mob/user)
	. = ..()
	mixer.icon_state = "cereal_on"
	mixer.update_appearance()

/datum/cooking_surface/ice_cream_mixer/turn_off(mob/user)
	. = ..()
	mixer.icon_state = "cereal_off"
	mixer.update_appearance()

/obj/machinery/cooking/ice_cream_mixer
	name = "Ice cream mixer"
	desc = "An industrial mixing device for desserts of all kinds."
	icon_state = "cereal_off"
	active_power_consumption = 200
	allowed_containers = list(
		/obj/item/reagent_containers/cooking/icecream_bowl,
		/obj/item/reagent_containers/cooking/mould,
	)

/obj/machinery/cooking/ice_cream_mixer/Initialize(mapload)
	. = ..()

	component_parts = list()
	component_parts += new /obj/item/circuitboard/cooking/ice_cream_mixer(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/capacitor(null)

	surfaces += new /datum/cooking_surface/ice_cream_mixer

	RefreshParts()

/obj/machinery/cooking/ice_cream_mixer/AltShiftClick(mob/user, modifiers)
	// No temperature changing on the ice cream mixer.
	return

/obj/machinery/cooking/ice_cream_mixer/attack_hand(mob/user)
	var/datum/cooking_surface/surface = surfaces[1]
	if(!surface.placed_item)
		return

	if(surface.on)
		to_chat(user, "<span class='notice'>\The [src] must be off to retrieve its contents.</span>")
		return

	user.put_in_hands(surface.placed_item)
	surface.placed_item = null

/obj/item/circuitboard/cooking/ice_cream_mixer
	board_name = "Ice Cream Mixer"
	build_path = /obj/machinery/cooking/ice_cream_mixer
	board_type = "machine"
	origin_tech = list(TECH_BIO = 1)
	req_components = list(
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/capacitor = 1,
	)
