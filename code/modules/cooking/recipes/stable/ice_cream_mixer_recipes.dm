/datum/cooking/recipe/orange_creamsicle
	product_type = /obj/item/food/frozen/popsicle/orangecream
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_REAGENT("sugar", 2),
		CWJ_ADD_REAGENT("orangejuice", 4),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_ADD_REAGENT("vanilla", 2),
		CWJ_ADD_REAGENT("cream", 2),
		CWJ_USE_ICE_CREAM_MIXER(3 SECONDS),
	)

/datum/cooking/recipe/orange_snowcone
	product_type = /obj/item/food/frozen/snowcone/orange
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("orangejuice", 4),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_USE_ICE_CREAM_MIXER(3 SECONDS),
	)

