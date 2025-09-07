/obj/item/autochef_expansion_card
	name = "autochef expansion card"
	icon = 'icons/obj/module.dmi'
	icon_state = "autochef_expansion_card"

/obj/item/autochef_expansion_card/proc/can_produce(obj/machinery/autochef/autochef, obj/target)
	return FALSE

/obj/item/autochef_expansion_card/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	var/obj/machinery/autochef/autochef = target
	if(!istype(autochef))
		return




/obj/item/autochef_expansion_card/basic_prep
	name = "Autochef Expansion Card: Basic Prep"
	desc = "This fairly common expansion card enables autochefs to perform basic cutting, rolling, and shaping tasks."
	var/static/list/sliceable_foods

/obj/item/autochef_expansion_card/basic_prep/Initialize(mapload)
	. = ..()
	if(!sliceable_foods)
		sliceable_foods = list()
		for(var/food_type in subtypesof(/obj/item/food/sliceable))
			var/obj/item/food/sliceable/sliceable_food_type = food_type
			sliceable_foods[sliceable_food_type::slice_path] = sliceable_food_type

/obj/item/autochef_expansion_card/basic_prep/can_produce(obj/machinery/autochef/autochef, obj/target)
	if(!istype(target, /obj/item/food/sliced))
		return FALSE

	var/obj/item/food/sliced/sliced_food = target

	if(!autochef.find_available_resource_of_type(sliced_food.slice_path))




/obj/item/autochef_expansion_card/mincing_prep
	name = "Autochef Expansion Card: Mincing Prep"
	desc = "This rare expansion card enables autochefs to utilize grinders and food processors."

/obj/item/autochef_expansion_card/mixing_prep
	name = "Autochef Expansion Card: Mixing Prep"
	desc = "This extremely rare expansion card enables autochefs to perform reagent mixing."
