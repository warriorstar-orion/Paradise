
/datum/cooking/recipe/bacon
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/bacon
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/raw_bacon),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/bbqribs
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/bbqribs
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_REAGENT("bbqsauce", 5),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/berry_pancake
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/pancake/berry_pancake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/cookiedough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/birdsteak
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/meatsteak/chicken
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat/chicken),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("blackpepper", 1),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/choc_chip_pancake
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/pancake/choc_chip_pancake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/cookiedough),
		CWJ_ADD_ITEM(/obj/item/food/choc_pile),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/cutlet
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/cutlet
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/rawcutlet),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/fish_skewer
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/fish_skewer
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/stack/rods),
		CWJ_ADD_REAGENT("flour", 10),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/fishfingers
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/fishfingers
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/carpmeat),
		CWJ_ADD_REAGENT("flour", 10),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/friedegg
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/friedegg
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("blackpepper", 1),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/goliath
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/goliath_steak
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/monstermeat/goliath),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/grilledcheese
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/grilledcheese
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/food/breadslice),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/human_kebab
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/human/kebab
	steps = list(
		CWJ_ADD_ITEM(/obj/item/stack/rods),
		CWJ_ADD_ITEM(/obj/item/food/meat/human),
		CWJ_ADD_ITEM(/obj/item/food/meat/human),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/meatkeb
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/meatkebab
	steps = list(
		CWJ_ADD_ITEM(/obj/item/stack/rods),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/meatsteak
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/meatsteak
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("blackpepper", 1),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/omelette
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/omelette
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_USE_GRILL(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/pancake
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/pancake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/cookiedough),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/picoss_kebab
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/picoss_kebab
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/carpmeat),
		CWJ_ADD_ITEM(/obj/item/food/carpmeat),
		CWJ_ADD_ITEM(/obj/item/stack/rods),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		CWJ_ADD_REAGENT("vinegar", 5),
		CWJ_USE_GRILL(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/rofflewaffles
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/rofflewaffles
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_REAGENT("psilocybin", 5),
		CWJ_ADD_REAGENT("sugar", 10),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/salmonsteak
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/salmonsteak
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("blackpepper", 1),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sausage
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sausage
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meatball),
		CWJ_ADD_ITEM(/obj/item/food/cutlet),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/shrimp_skewer
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/shrimp_skewer
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/shrimp),
		CWJ_ADD_ITEM(/obj/item/food/shrimp),
		CWJ_ADD_ITEM(/obj/item/food/shrimp),
		CWJ_ADD_ITEM(/obj/item/food/shrimp),
		CWJ_ADD_ITEM(/obj/item/stack/rods),
		CWJ_USE_GRILL(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/sushi_ebi
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_ebi
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/boiled_shrimp),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_ikura
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_ikura
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/salmon),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_inari
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_inari
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/fried_tofu),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_masago
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_masago
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/goldfish),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_sake
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_sake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_smoked_salmon
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_smoked_salmon
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/salmonsteak),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_tai
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_tai
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/food/catfishmeat),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_tamago
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_tamago
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_ADD_REAGENT("sake", 5),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_tobiko
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_tobiko
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/fish_eggs/shark),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_tobiko_egg
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_tobiko_egg
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sushi_tobiko),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/sushi_unagi
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/sushi_unagi
	steps = list(
		CWJ_ADD_ITEM(/obj/item/fish/electric_eel),
		CWJ_ADD_ITEM(/obj/item/food/boiledrice),
		CWJ_ADD_ITEM(/obj/item/stack/seaweed),
		CWJ_ADD_REAGENT("sake", 5),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/syntikebab
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/syntikebab
	steps = list(
		CWJ_ADD_ITEM(/obj/item/stack/rods),
		CWJ_ADD_ITEM(/obj/item/food/meat/syntiflesh),
		CWJ_ADD_ITEM(/obj/item/food/meat/syntiflesh),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/syntisteak
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/meatsteak
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat/syntiflesh),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("blackpepper", 1),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/syntitelebacon
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/telebacon
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat/syntiflesh),
		CWJ_ADD_ITEM(/obj/item/assembly/signaler),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/telebacon
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/telebacon
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/assembly/signaler),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/tofukebab
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/tofukebab
	steps = list(
		CWJ_ADD_ITEM(/obj/item/stack/rods),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/waffles
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/waffles
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_REAGENT("sugar", 10),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/wingfangchu
	cooking_container = /obj/item/reagent_containers/cooking/grill_grate
	product_type = /obj/item/food/wingfangchu
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/monstermeat/xenomeat),
		CWJ_ADD_REAGENT("soysauce", 5),
		CWJ_USE_GRILL(J_MED, 10 SECONDS),
	)
