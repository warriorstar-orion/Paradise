/datum/cooking/recipe/friedegg
	cooking_container = /obj/item/reagent_containers/cooking/pan
	product_type = /obj/item/food/friedegg
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("blackpepper", 1),
		CWJ_USE_STOVE(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/omlette
	cooking_container = /obj/item/reagent_containers/cooking/pan
	product_type = /obj/item/food/omelette
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		CWJ_USE_STOVE(J_MED, 4 SECONDS),
	)
