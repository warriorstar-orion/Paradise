
/datum/cooking/recipe/bacon
	cooking_container = GRILL
	product_type = /obj/item/food/bacon
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/raw_bacon),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/bbqribs
	cooking_container = GRILL
	product_type = /obj/item/food/bbqribs
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/berry_pancake
	cooking_container = GRILL
	product_type = /obj/item/food/pancake/berry_pancake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cookiedough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/birdsteak
	cooking_container = GRILL
	product_type = /obj/item/food/meatsteak/chicken
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat/chicken),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/choc_chip_pancake
	cooking_container = GRILL
	product_type = /obj/item/food/pancake/choc_chip_pancake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cookiedough),
		list(CWJ_ADD_ITEM, /obj/item/food/choc_pile),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/cutlet
	cooking_container = GRILL
	product_type = /obj/item/food/cutlet
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/rawcutlet),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/fish_skewer
	cooking_container = GRILL
	product_type = /obj/item/food/fish_skewer
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/salmonmeat),
		list(CWJ_ADD_ITEM, /obj/item/food/salmonmeat),
		list(CWJ_ADD_ITEM, /obj/item/stack/rods),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/fishfingers
	cooking_container = GRILL
	product_type = /obj/item/food/fishfingers
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_ADD_ITEM, /obj/item/food/carpmeat),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/friedegg
	cooking_container = GRILL
	product_type = /obj/item/food/friedegg
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/goliath
	cooking_container = GRILL
	product_type = /obj/item/food/goliath_steak
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/monstermeat/goliath),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/grilledcheese
	cooking_container = GRILL
	product_type = /obj/item/food/grilledcheese
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/human_kebab
	cooking_container = GRILL
	product_type = /obj/item/food/human/kebab
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/stack/rods),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/human),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/human),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/meatkeb
	cooking_container = GRILL
	product_type = /obj/item/food/meatkebab
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/stack/rods),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/meatsteak
	cooking_container = GRILL
	product_type = /obj/item/food/meatsteak
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/omelette
	cooking_container = GRILL
	product_type = /obj/item/food/omelette
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_GRILL, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/pancake
	cooking_container = GRILL
	product_type = /obj/item/food/pancake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cookiedough),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/picoss_kebab
	cooking_container = GRILL
	product_type = /obj/item/food/picoss_kebab
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/carpmeat),
		list(CWJ_ADD_ITEM, /obj/item/food/carpmeat),
		list(CWJ_ADD_ITEM, /obj/item/stack/rods),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/onion),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/chili),
		list(CWJ_USE_GRILL, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/rofflewaffles
	cooking_container = GRILL
	product_type = /obj/item/food/rofflewaffles
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/salmonsteak
	cooking_container = GRILL
	product_type = /obj/item/food/salmonsteak
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/salmonmeat),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sausage
	cooking_container = GRILL
	product_type = /obj/item/food/sausage
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meatball),
		list(CWJ_ADD_ITEM, /obj/item/food/cutlet),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/shrimp_skewer
	cooking_container = GRILL
	product_type = /obj/item/food/shrimp_skewer
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/shrimp),
		list(CWJ_ADD_ITEM, /obj/item/food/shrimp),
		list(CWJ_ADD_ITEM, /obj/item/food/shrimp),
		list(CWJ_ADD_ITEM, /obj/item/food/shrimp),
		list(CWJ_ADD_ITEM, /obj/item/stack/rods),
		list(CWJ_USE_GRILL, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/sushi_ebi
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_ebi
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/food/boiled_shrimp),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_ikura
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_ikura
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/fish_eggs/salmon),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_inari
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_inari
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/food/fried_tofu),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_masago
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_masago
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/fish_eggs/goldfish),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_sake
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_sake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/food/salmonmeat),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_smoked_salmon
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_smoked_salmon
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/food/salmonsteak),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_tai
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_tai
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/food/catfishmeat),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_tamago
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_tamago
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_tobiko
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_tobiko
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/fish_eggs/shark),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_tobiko_egg
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_tobiko_egg
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sushi_tobiko),
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sushi_unagi
	cooking_container = GRILL
	product_type = /obj/item/food/sushi_unagi
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/fish/electric_eel),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice),
		list(CWJ_ADD_ITEM, /obj/item/stack/seaweed),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/syntikebab
	cooking_container = GRILL
	product_type = /obj/item/food/syntikebab
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/stack/rods),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/syntiflesh),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/syntiflesh),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/syntisteak
	cooking_container = GRILL
	product_type = /obj/item/food/meatsteak
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat/syntiflesh),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/syntitelebacon
	cooking_container = GRILL
	product_type = /obj/item/food/telebacon
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat/syntiflesh),
		list(CWJ_ADD_ITEM, /obj/item/assembly/signaler),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/telebacon
	cooking_container = GRILL
	product_type = /obj/item/food/telebacon
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/assembly/signaler),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/tofukebab
	cooking_container = GRILL
	product_type = /obj/item/food/tofukebab
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/stack/rods),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/waffles
	cooking_container = GRILL
	product_type = /obj/item/food/waffles
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/wingfangchu
	cooking_container = GRILL
	product_type = /obj/item/food/wingfangchu
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/monstermeat/xenomeat),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)
