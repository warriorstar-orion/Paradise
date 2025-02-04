/datum/cooking/recipe/friedegg
	cooking_container = /obj/item/reagent_containers/cooking/pan
	product_type = /obj/item/food/friedegg
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_REAGENT("sodiumchloride", 1),
		PCWJ_ADD_REAGENT("blackpepper", 1),
		PCWJ_USE_STOVE(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/beanstew
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/beanstew
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/beans),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cabbage),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/corn),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/beetsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/beetsoup
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/whitebeet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cabbage),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/bloodsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/bloodsoup
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato/blood),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato/blood),
		PCWJ_ADD_REAGENT("blood", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/chicken_noodle_soup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/chicken_noodle_soup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meat),
		PCWJ_ADD_ITEM(/obj/item/food/boiledspaghetti),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/clownchili
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/clownchili
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_ITEM(/obj/item/clothing/shoes/clown_shoes),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/clownstears
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/clownstears
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/stack/ore/bananium),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/coldchili
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/coldchili
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meat),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/icepepper),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cornchowder
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/cornchowder
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/bacon),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/corn),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("cream", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cullenskink
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/cullenskink
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/salmonmeat),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("milk", 10),
		PCWJ_ADD_REAGENT("blackpepper", 4),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/eyesoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/eyesoup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/organ/internal/eyes),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/frenchonionsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/frenchonionsoup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/hong_kong_borscht
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/hong_kong_borscht
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cabbage),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("soysauce", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/hong_kong_macaroni
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/hong_kong_macaroni
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/boiledspaghetti),
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_ITEM(/obj/item/food/bacon),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("cream", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/hotchili
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/hotchili
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meat),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/meatball_noodles
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/meatball_noodles
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_ITEM(/obj/item/food/spaghetti),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/peanuts),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/meatballsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/meatballsoup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/misosoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/misosoup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/soydope),
		PCWJ_ADD_ITEM(/obj/item/food/soydope),
		PCWJ_ADD_ITEM(/obj/item/food/tofu),
		PCWJ_ADD_ITEM(/obj/item/food/tofu),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/mushroomsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/mushroomsoup
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/mysterysoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/mysterysoup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/badrecipe),
		PCWJ_ADD_ITEM(/obj/item/food/tofu),
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/nettlesoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/nettlesoup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_PRODUCE(/obj/item/grown/nettle/basic),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/oatstew
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/oatstew
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/oat),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato/sweet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/parsnip),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/red_porridge
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/red_porridge
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/redbeet),
		PCWJ_ADD_REAGENT("vanilla", 5),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("yogurt", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/redbeetsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/redbeetsoup
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/redbeet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/redbeet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cabbage),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/seedsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/seedsoup
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/seeds/sunflower),
		PCWJ_ADD_ITEM(/obj/item/seeds/poppy/lily),
		PCWJ_ADD_ITEM(/obj/item/seeds/ambrosia),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("vinegar", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/slimesoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/slimesoup
	steps = list(
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("slimejelly", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/stew
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/stew
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meat),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/eggplant),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/sweetpotatosoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/sweetpotatosoup
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato/sweet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato/sweet),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("milk", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/tomatosoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/tomatosoup
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/vegetablesoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/vegetablesoup
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/corn),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/eggplant),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/wishsoup
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/wishsoup
	steps = list(
		PCWJ_ADD_REAGENT("water", 20),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/zurek
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soup/zurek
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/boiledegg),
		PCWJ_ADD_ITEM(/obj/item/food/sausage),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_ADD_REAGENT("flour", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

