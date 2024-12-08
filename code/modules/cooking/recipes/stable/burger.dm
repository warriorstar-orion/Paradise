/datum/cooking/recipe/cooked_patty
	cooking_container = GRILL
	product_type = /obj/item/food/patty
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/patty_raw, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_GRILL, J_LO, 10 SECONDS)
	)

/datum/cooking/recipe/burger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/burger/plain

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		// list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		// list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/patty)
	)
