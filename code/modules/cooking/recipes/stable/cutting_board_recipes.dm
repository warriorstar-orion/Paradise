
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
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_REAGENT("cherryjelly", 5),
	)

/datum/cooking/recipe/ebi_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/ebi_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/boiled_shrimp),
		CWJ_ADD_ITEM(/obj/item/food/boiled_shrimp),
		CWJ_ADD_ITEM(/obj/item/food/boiled_shrimp),
		CWJ_ADD_ITEM(/obj/item/food/boiled_shrimp),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
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

/datum/cooking/recipe/ikura_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/ikura_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/salmon),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/salmon),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/salmon),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/salmon),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/inari_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/inari_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/fried_tofu),
		CWJ_ADD_ITEM(/obj/item/food/fried_tofu),
		CWJ_ADD_ITEM(/obj/item/food/fried_tofu),
		CWJ_ADD_ITEM(/obj/item/food/fried_tofu),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/jellyburger
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/burger/jelly/cherry
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/bun),
		CWJ_ADD_REAGENT("cherryjelly", 5),
	)

/datum/cooking/recipe/masago_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/masago_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/goldfish),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/goldfish),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/goldfish),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/goldfish),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/notasandwich
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/notasandwich
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/clothing/mask/fakemoustache),
	)

/datum/cooking/recipe/sake_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/sake_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sandwich
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sandwich
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meatsteak),
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
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
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_REAGENT("slimejelly", 5),
	)

/datum/cooking/recipe/smoked_salmon_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/smoked_salmon_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/salmonsteak),
		CWJ_ADD_ITEM(/obj/item/food/salmonsteak),
		CWJ_ADD_ITEM(/obj/item/food/salmonsteak),
		CWJ_ADD_ITEM(/obj/item/food/salmonsteak),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_ebi
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_ebi
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/boiled_shrimp),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_ikura
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_ikura
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/salmon),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_inari
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_inari
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/fried_tofu),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_masago
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_masago
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/goldfish),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_sake
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_sake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_smoked_salmon
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_smoked_salmon
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/salmonsteak),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_tai
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_tai
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/catfishmeat),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_tobiko
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_tobiko
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/shark),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/sushi_tobiko_egg
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sushi_tobiko_egg
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sushi_tobiko),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/tai_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/tai_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/catfishmeat),
		CWJ_ADD_ITEM(/obj/item/food/catfishmeat),
		CWJ_ADD_ITEM(/obj/item/food/catfishmeat),
		CWJ_ADD_ITEM(/obj/item/food/catfishmeat),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/tobiko_egg_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/tobiko_egg_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sushi_tobiko),
		CWJ_ADD_ITEM(/obj/item/food/sushi_tobiko),
		CWJ_ADD_ITEM(/obj/item/food/sushi_tobiko),
		CWJ_ADD_ITEM(/obj/item/food/sushi_tobiko),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)

/datum/cooking/recipe/tobiko_maki
	cooking_container = /obj/item/reagent_containers/cooking/board
	product_type = /obj/item/food/sliceable/tobiko_maki
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/shark),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/shark),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/shark),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/shark),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
	)
