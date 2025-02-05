/datum/cooking/recipe/amanitajelly
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/amanitajelly
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/amanita),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/amanita),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/amanita),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("vodka", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/beans
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/beans
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/soybeans),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/soybeans),
		PCWJ_ADD_REAGENT("ketchup", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/benedict
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/benedict
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/friedegg),
		PCWJ_ADD_ITEM(/obj/item/food/meatsteak),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/blt
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/blt
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/tomato),
		PCWJ_ADD_ITEM(/obj/item/food/bacon),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/lettuce),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/boiled_shrimp
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/boiled_shrimp
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/shrimp),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/boiledegg
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/boiledegg
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/boiledrice
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/boiledrice
	steps = list(
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("rice", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/boiledslimeextract
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/boiledslimecore
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/slime_extract),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/boiledspaghetti
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/boiledspaghetti
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/spaghetti),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/boiledspiderleg
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/boiledspiderleg
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/monstermeat/spiderleg),
		PCWJ_ADD_REAGENT("water", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/burrito
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/burrito
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_ITEM(/obj/item/food/beans),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		PCWJ_ADD_REAGENT("capsaicin", 5),
		PCWJ_ADD_REAGENT("rice", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/candiedapple
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/candiedapple
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/apple),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/chawanmushi
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/chawanmushi
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("soysauce", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cheese_balls
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/cheese_balls
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/cheese_curds),
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_ADD_REAGENT("flour", 5),
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("honey", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cheesyfries
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/cheesyfries
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/fries),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cherrysandwich
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/jellysandwich/cherry
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_REAGENT("cherryjelly", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/chocolateegg
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/chocolateegg
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/egg),
		PCWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cubancarp
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/cubancarp
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/dough),
		PCWJ_ADD_ITEM(/obj/item/food/carpmeat),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/dionaroast
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/dionaroast
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/holder/diona),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/apple),
		PCWJ_ADD_REAGENT("facid", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/donkpocket
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/donkpocket
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/dough),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/dulce_de_batata
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/sliceable/dulce_de_batata
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato/sweet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato/sweet),
		PCWJ_ADD_REAGENT("vanilla", 5),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/eggplantparm
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/eggplantparm
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/eggplant),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/enchiladas
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/enchiladas
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/corn),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/fishandchips
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/fishandchips
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/fries),
		PCWJ_ADD_ITEM(/obj/item/food/carpmeat),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/friedbanana
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/friedbanana
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/dough),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		PCWJ_ADD_REAGENT("sugar", 10),
		PCWJ_ADD_REAGENT("cornoil", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/human_burger
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/human/burger
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meat/human),
		PCWJ_ADD_ITEM(/obj/item/food/bun),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/lettuce),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/jelliedtoast
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/jelliedtoast/cherry
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_REAGENT("cherryjelly", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/macncheese
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/macncheese
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_ADD_ITEM(/obj/item/food/macaroni),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/mashedtaters
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/mashed_potatoes
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		PCWJ_ADD_REAGENT("gravy", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/meatballspaggetti
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/meatballspaghetti
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/spaghetti),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/meatbun
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/meatbun
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/dough),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cabbage),
		PCWJ_ADD_REAGENT("soysauce", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/mint
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/mint
	steps = list(
		PCWJ_ADD_REAGENT("toxin", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/mint_2
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/mint
	steps = list(
		PCWJ_ADD_REAGENT("sugar", 5),
		PCWJ_ADD_REAGENT("frostoil", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/monkeysdelight
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/monkeysdelight
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/monkeycube),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		PCWJ_ADD_REAGENT("sodiumchloride", 1),
		PCWJ_ADD_REAGENT("blackpepper", 1),
		PCWJ_ADD_REAGENT("flour", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/notasandwich
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/notasandwich
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/clothing/mask/fakemoustache),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/pastatomato
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/pastatomato
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/spaghetti),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/peanut_butter_banana
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/peanut_butter_banana
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		PCWJ_ADD_REAGENT("peanutbutter", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cherry
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/peanut_butter_jelly/cherry
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_REAGENT("cherryjelly", 5),
		PCWJ_ADD_REAGENT("peanutbutter", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/slime
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/peanut_butter_jelly/slime
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_REAGENT("slimejelly", 5),
		PCWJ_ADD_REAGENT("peanutbutter", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/philly_cheesesteak
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/philly_cheesesteak
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/cutlet),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/onion),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/popcorn
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/popcorn
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/corn),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/poppypretzel
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/poppypretzel
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/seeds/poppy),
		PCWJ_ADD_ITEM(/obj/item/food/dough),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/reheatwarmdonkpocket
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/warmdonkpocket
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/warmdonkpocket),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/ricepudding
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/ricepudding
	steps = list(
		PCWJ_ADD_REAGENT("milk", 5),
		PCWJ_ADD_REAGENT("rice", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/sandwich
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/sandwich
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meatsteak),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/cheesewedge),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/sashimi
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/sashimi
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/monstermeat/spidereggs),
		PCWJ_ADD_ITEM(/obj/item/food/carpmeat),
		PCWJ_ADD_REAGENT("soysauce", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/slimesandwich
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/jellysandwich/slime
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_REAGENT("slimejelly", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/slimetoast
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/jelliedtoast/slime
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_REAGENT("slimejelly", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/soylentgreen
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soylentgreen
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/meat/human),
		PCWJ_ADD_ITEM(/obj/item/food/meat/human),
		PCWJ_ADD_REAGENT("flour", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/soylentviridians
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/soylentviridians
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/soybeans),
		PCWJ_ADD_REAGENT("flour", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/spacylibertyduff
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/spacylibertyduff
	steps = list(
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/libertycap),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/libertycap),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/libertycap),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("vodka", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/spesslaw
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/spesslaw
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/spaghetti),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_ITEM(/obj/item/food/meatball),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/spidereggsham
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/spidereggsham
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/monstermeat/spidereggs),
		PCWJ_ADD_ITEM(/obj/item/food/monstermeat/spidermeat),
		PCWJ_ADD_REAGENT("sodiumchloride", 1),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/stewedsoymeat
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/stewedsoymeat
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/soydope),
		PCWJ_ADD_ITEM(/obj/item/food/soydope),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/stuffing
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/stuffing
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliceable/bread),
		PCWJ_ADD_REAGENT("water", 5),
		PCWJ_ADD_REAGENT("sodiumchloride", 1),
		PCWJ_ADD_REAGENT("blackpepper", 1),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/twobread
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/twobread
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_ITEM(/obj/item/food/sliced/bread),
		PCWJ_ADD_REAGENT("wine", 5),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/warmdonkpocket
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/warmdonkpocket
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/donkpocket),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/wrap
	cooking_container = /obj/item/reagent_containers/cooking/pot
	product_type = /obj/item/food/wrap
	steps = list(
		PCWJ_ADD_ITEM(/obj/item/food/friedegg),
		PCWJ_ADD_PRODUCE(/obj/item/food/grown/cabbage),
		PCWJ_ADD_REAGENT("soysauce", 10),
		PCWJ_USE_STOVE(J_MED, 20 SECONDS),
	)

