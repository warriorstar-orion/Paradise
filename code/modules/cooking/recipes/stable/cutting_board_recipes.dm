
/datum/cooking/recipe/baseballburger
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/burger/baseball
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/bun),
		CWJ_ADD_ITEM(/obj/item/melee/baseball_bat),
	)

/datum/cooking/recipe/cherrysandwich
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/jellysandwich/cherry
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_REAGENT("cherryjelly", 5),
	)

/datum/cooking/recipe/cak
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /mob/living/simple_animal/pet/cat/cak
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/birthdaycake),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/organ/internal/brain),
		CWJ_ADD_ITEM(/obj/item/organ/internal/heart),
		CWJ_ADD_REAGENT("blood", 30),
		CWJ_ADD_REAGENT("sprinkles", 5),
		CWJ_ADD_REAGENT("teslium", 1),
	)

/datum/cooking/recipe/jellyburger
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/burger/jelly/cherry
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/bun),
		CWJ_ADD_REAGENT("cherryjelly", 5),
	)

/datum/cooking/recipe/notasandwich
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/notasandwich
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_ITEM(/obj/item/clothing/mask/fakemoustache),
	)

/datum/cooking/recipe/sandwich
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sandwich
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meatsteak),
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
	)

/datum/cooking/recipe/slimeburger
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/burger/jelly/slime
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/bun),
		CWJ_ADD_REAGENT("slimejelly", 5),
	)

/datum/cooking/recipe/slimesandwich
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/jellysandwich/slime
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		CWJ_ADD_REAGENT("slimejelly", 5),
	)
