/datum/cooking/recipe/candied_pineapple
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/candied_pineapple
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/pineapple),
		PCWJ_ADD_REAGENT("sugar", 2),
		PCWJ_ADD_REAGENT("water", 2),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/candybar
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/candybar
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/caramel
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/caramel
	steps = list(
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("cream", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/chocolate_bar
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/chocolatebar
	steps = list(
		PCWJ_ADD_REAGENT("soymilk", 2),
		PCWJ_ADD_REAGENT("cocoa", 2),
		PCWJ_ADD_REAGENT("sugar", 2),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/chocolate_bar2
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/chocolatebar
	steps = list(
		PCWJ_ADD_REAGENT("milk", 2),
		PCWJ_ADD_REAGENT("cocoa", 2),
		PCWJ_ADD_REAGENT("sugar", 2),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/chocolate_bunny
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/chocolate_bunny
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_REAGENT("sugar", 2),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/chocolate_coin
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/chocolate_coin
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/coin),
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/chocolate_orange
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/chocolate_orange
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/citrus/orange),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/c_tube),
		PCWJ_ADD_REAGENT("sugar", 15),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_blue
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/blue
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("berryjuice", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_green
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/green
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("limejuice", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_orange
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/orange
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("orangejuice", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_pink
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/pink
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("watermelonjuice", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_poison
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/poison
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("poisonberryjuice", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_purple
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/purple
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("grapejuice", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_rainbow
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/rainbow
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/red),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/blue),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/green),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/yellow),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/orange),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/purple),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/pink),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_rainbow2
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/bad_rainbow
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/red),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/poison),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/green),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/yellow),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/orange),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/purple),
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton/pink),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_red
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/red
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("cherryjelly", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cottoncandy_yellow
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/cotton/yellow
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/candy/cotton),
		PCWJ_ADD_REAGENT("lemonjuice", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/fudge
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/fudge
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/fudge_cherry
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/fudge/cherry
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/fudge_cookies_n_cream
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/fudge/cookies_n_cream
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_ITEM(/obj/item/food/cookie),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_ADD_REAGENT("cream", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/fudge_dice
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/fudge_dice
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/dice),
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/fudge_peanut
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/fudge/peanut
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/peanuts),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/peanuts),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/peanuts),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/fudge_turtle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/fudge/turtle
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_ITEM(/obj/item/food/candy/caramel),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/peanuts),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/gum
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/gum
	steps = list(
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("cornoil", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/nougat
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/nougat
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("cornoil", 5),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/taffy
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/taffy
	steps = list(
		PCWJ_ADD_REAGENT("salglu_solution", 15),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/toffee
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/candy/toffee
	steps = list(
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("flour", 10),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/wafflecone
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/wafflecone
	steps = list(
		PCWJ_ADD_REAGENT("milk", 1),
		PCWJ_ADD_REAGENT("sugar", 1),
		PCWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

