/datum/cooking/recipe/cooked_patty
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/patty
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/patty_raw, qmod = 0.5),
		CWJ_ADD_REAGENT("sodiumchloride", 1, optional = TRUE, base = 1),
		CWJ_USE_GRILL(J_LO, 10 SECONDS),
	)
// 	step_builder = list(
// 		list(CWJ_ADD_ITEM, /obj/item/food/patty_raw, qmod=0.5),
// 		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
// 		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
// 		list(CWJ_USE_GRILL, J_LO, 10 SECONDS)
// 	)

/datum/cooking/recipe/burger
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/burger/plain

	replace_reagents = FALSE

	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/bun, qmod = 0.5),
		CWJ_ADD_ITEM(/obj/item/food/sliced/tomato, optional = TRUE, base = 5),
		CWJ_ADD_ITEM(/obj/item/food/patty),
	)

/datum/cooking/recipe/cheeseburger
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/burger/cheese

	replace_reagents = FALSE

	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/bun, qmod = 0.5),
		CWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/sliced/tomato, optional = TRUE),
		CWJ_ADD_ITEM(/obj/item/food/patty),
	)

	// step_builder = list(
	// 	list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
	// 	list(CWJ_ADD_PRODUCE_OPTIONAL, /obj/item/food/grown/cabbage),
	// 	list(CWJ_ADD_PRODUCE_OPTIONAL, /obj/item/food/grown/tomato),
	// 	list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
	// 	list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
	// 	list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
	// 	list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
	// 	list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/sliced/cheesewedge, qmod=0.5),
	// 	list(CWJ_ADD_ITEM, /obj/item/food/patty)
	// )
