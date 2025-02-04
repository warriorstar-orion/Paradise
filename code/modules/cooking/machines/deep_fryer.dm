/datum/cooking_surface/deepfryer_basin
	cooker_id = COOKER_SURFACE_DEEPFRYER

/obj/machinery/cooking/deepfryer
	name = "deep fryer"
	desc = "A deep fryer that can hold two baskets."
	icon_state = "deep_fryer"
	density = FALSE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	cooking = FALSE
	allowed_containers = list(
		/obj/item/reagent_containers/cooking/deep_basket,
	)

/obj/machinery/cooking/deepfryer/Initialize(mapload)
	. = ..()

	component_parts = list()
	component_parts += new /obj/item/circuitboard/cooking/stove(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/capacitor(null)

	for(var/i in 1 to 2)
		surfaces += new/datum/cooking_surface/deepfryer_basin(src)

	RefreshParts()

#define ICON_SPLIT_X 16
#define ICON_SPLIT_Y 16

/obj/machinery/cooking/deepfryer/clickpos_to_surface(modifiers)
	var/icon_x = text2num(modifiers["icon-x"])
	var/icon_y = text2num(modifiers["icon-y"])
	if(icon_y <= ICON_SPLIT_Y)
		return

	if(icon_x <= ICON_SPLIT_X)
		return 1
	else if(icon_x > ICON_SPLIT_X)
		return 2

#undef ICON_SPLIT_X
#undef ICON_SPLIT_Y

/obj/machinery/cooking/deepfryer/update_icon()
	..()

	cut_overlays()

	for(var/i in 1 to 2)
		var/datum/cooking_surface/surface = surfaces[i]
		if(!surface.placed_item)
			continue

		if(surface.on)
			add_overlay(image(icon, icon_state = "fryer_basket_on_[i]"))
		else
			add_overlay(image(icon, icon_state = "fryer_basket_[i]"))
