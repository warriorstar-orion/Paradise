/datum/cooking/recipe/ice_cream/orange_creamsicle
	product_type = /obj/item/food/frozen/popsicle/orangecream
	steps = list(
		CWJ_ADD_REAGENT("sugar", 2),
		CWJ_ADD_REAGENT("orangejuice", 4),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_ADD_REAGENT("vanilla", 2),
		CWJ_ADD_REAGENT("cream", 2),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)
	destination_object = /obj/item/popsicle_stick
