/datum/cooking_surface/deepfryer_basin
	cooker_id = COOKER_SURFACE_DEEPFRYER

/obj/machinery/cooking/deepfryer
	name = "deep fryer"
	desc = "A deep fryer that can hold two baskets."
	icon = 'icons/obj/cwj_cooking/stove.dmi'
	icon_state = "stove"
	density = FALSE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	cooking = FALSE
	allowed_containers = list(
		/obj/item/reagent_containers/cooking/deep_basket,
		/obj/item/reagent_containers/cooking/pan,
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
