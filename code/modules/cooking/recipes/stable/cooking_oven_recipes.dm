
/datum/cooking/recipe/amanita_pie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/amanita_pie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/amanita),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/applecake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/applecake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/apple),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/apple),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/applepie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/applepie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/apple),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/appletart
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/appletart
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/apple/gold),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("flour", 10),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/baguette
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/baguette
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("blackpepper", 1),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/bananabread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/bananabread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/bananacake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/bananacake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/banarnarbread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/banarnarbread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("blood", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/beary_pie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/beary_pie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/monstermeat/bearmeat),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/berry_muffin
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/berry_muffin
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/berryclafoutis
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/berryclafoutis
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/birthdaycake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/birthdaycake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/candle),
		CWJ_ADD_ITEM(/obj/item/candle),
		CWJ_ADD_ITEM(/obj/item/candle),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_ADD_REAGENT("vanilla", 10),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/blumpkin_pie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/blumpkin_pie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/pumpkin/blumpkin),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/booberry_muffin
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/booberry_muffin
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/ectoplasm),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/braincake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/braincake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/organ/internal/brain),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/bread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/bread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/bun
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/bun
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/cannoli
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/cannoli
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/cookiedough),
		CWJ_ADD_REAGENT("milk", 1),
		CWJ_ADD_REAGENT("sugar", 3),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/carrotcake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/carrotcake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/cheesecake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/cheesecake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/cheesepizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/cheesepizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/cherry_cupcake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/cherry_cupcake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/blue
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/cherry_cupcake/blue
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/bluecherries),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/cherrypie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/cherrypie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		CWJ_ADD_REAGENT("sugar", 10),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/chocolate_cornet
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/chocolate_cornet
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/cookiedough),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/chocolate_lava_tart
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/chocolate_lava_tart
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_ITEM(/obj/item/slime_extract),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/chocolatecake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/chocolatecake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/clowncake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/clowncake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/frozen/sundae),
		CWJ_ADD_ITEM(/obj/item/food/frozen/sundae),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 50 SECONDS),
	)

/datum/cooking/recipe/cookies
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/storage/bag/tray/cookies_tray
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/rawcookies/chocochips),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/cracker
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/cracker
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/doughslice),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/creamcheesebread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/creamcheesebread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/croissant
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/croissant
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/egg),
		CWJ_ADD_REAGENT("sodiumchloride", 1),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/dankpizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/dankpizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cannabis),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cannabis),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cannabis),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cannabis),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/donkpocketpizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/donkpocketpizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/donkpocket),
		CWJ_ADD_ITEM(/obj/item/food/donkpocket),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/firecrackerpizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/firecrackerpizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/chili),
		CWJ_ADD_REAGENT("capsaicin", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/flatbread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/flatbread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/fortunecookie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/fortunecookie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/doughslice),
		CWJ_ADD_ITEM(/obj/item/paper),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/french_silk_pie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/french_silk_pie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/frosty_pie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/frosty_pie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/bluecherries),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/garlicpizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/garlicpizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/garlic),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/garlic),
		CWJ_ADD_REAGENT("garlic", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/grape_tart
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/grape_tart
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/grapes),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/grapes),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/grapes),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/hardware_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/hardware_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/circuitboard),
		CWJ_ADD_ITEM(/obj/item/circuitboard),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_ADD_REAGENT("sacid", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/hawaiianpizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/hawaiianpizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/pineappleslice),
		CWJ_ADD_ITEM(/obj/item/food/pineappleslice),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/holy_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/holy_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_ADD_REAGENT("holywater", 15),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/honey_bun
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/honey_bun
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/cookiedough),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("honey", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/lasagna
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/lasagna
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 40 SECONDS),
	)

/datum/cooking/recipe/lemoncake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/lemoncake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/citrus/lemon),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/citrus/lemon),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/liars_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/liars_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 50 SECONDS),
	)

/datum/cooking/recipe/limecake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/limecake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/citrus/lime),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/citrus/lime),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/loadedbakedpotato
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/loadedbakedpotato
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/potato),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/macncheesepizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/macpizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/macncheese),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/meatbread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/meatbread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_USE_OVEN(J_MED, 40 SECONDS),
	)

/datum/cooking/recipe/meatpie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/meatpie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/meatpizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/meatpizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/mime_tart
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/mime_tart
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_REAGENT("nothing", 5),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/moffin
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/moffin
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/grown/cotton),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/mothmallow
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/mothmallow
	steps = list(
		CWJ_ADD_PRODUCE(/obj/item/food/grown/soybeans),
		CWJ_ADD_REAGENT("vanilla", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_ADD_REAGENT("rum", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/muffin
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/muffin
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/mushroompizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/mushroompizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 40 SECONDS),
	)

/datum/cooking/recipe/oatmeal_cookie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/oatmeal_cookie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/oat),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/orangecake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/orangecake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/citrus/orange),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/citrus/orange),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/peanut_butter_cookie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/peanut_butter_cookie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("peanutbutter", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/pepperonipizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/pepperonipizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/sausage),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/pestopizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/pestopizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_ADD_REAGENT("wasabi", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/pie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/pie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/pizzamargherita
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/margheritapizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/plaincake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/plaincake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/plum_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/plum_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/plum),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/plum),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/plump_pie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/plump_pie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/plumphelmet),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/plumphelmetbiscuit
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/plumphelmetbiscuit
	steps = list(
		CWJ_ADD_PRODUCE(/obj/item/food/grown/mushroom/plumphelmet),
		CWJ_ADD_REAGENT("water", 5),
		CWJ_ADD_REAGENT("flour", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/pound_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pound_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/plaincake),
		CWJ_ADD_ITEM(/obj/item/food/sliceable/plaincake),
		CWJ_ADD_ITEM(/obj/item/food/sliceable/plaincake),
		CWJ_ADD_ITEM(/obj/item/food/sliceable/plaincake),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/pumpkin_spice_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pumpkin_spice_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/pumpkin),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/pumpkin),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/pumpkinpie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pumpkinpie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/pumpkin),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/raisin_cookie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/raisin_cookie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/no_raisin),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/slime_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/slime_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/slime_extract),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/spaceman_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/spaceman_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/trumpet),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/trumpet),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_ADD_REAGENT("cream", 5),
		CWJ_ADD_REAGENT("berryjuice", 5),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/sugarcookies
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/storage/bag/tray/cookies_tray/sugarcookie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/rawcookies),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/syntibread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/meatbread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/meat/syntiflesh),
		CWJ_ADD_ITEM(/obj/item/food/meat/syntiflesh),
		CWJ_ADD_ITEM(/obj/item/food/meat/syntiflesh),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_USE_OVEN(J_MED, 40 SECONDS),
	)

/datum/cooking/recipe/toastedsandwich
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/toastedsandwich
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sandwich),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/tofubread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/tofubread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_USE_OVEN(J_MED, 40 SECONDS),
	)

/datum/cooking/recipe/tofupie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/tofupie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/tofurkey
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/tofurkey
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_ITEM(/obj/item/food/stuffing),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/turkey
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/turkey
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/meat),
		CWJ_ADD_ITEM(/obj/item/food/stuffing),
		CWJ_ADD_ITEM(/obj/item/food/stuffing),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/vanilla_berry_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/vanilla_berry_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/berries),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 40 SECONDS),
	)

/datum/cooking/recipe/vanilla_cake
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/vanilla_cake
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/vanillapod),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/vanillapod),
		CWJ_ADD_REAGENT("milk", 5),
		CWJ_ADD_REAGENT("sugar", 15),
		CWJ_USE_OVEN(J_MED, 20 SECONDS),
	)

/datum/cooking/recipe/vegetablepizza
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/pizza/vegetablepizza
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/eggplant),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/carrot),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/corn),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/tomato),
		CWJ_USE_OVEN(J_MED, 30 SECONDS),
	)

/datum/cooking/recipe/xemeatpie
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/xemeatpie
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/monstermeat/xenomeat),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)

/datum/cooking/recipe/xenomeatbread
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/sliceable/xenomeatbread
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/dough),
		CWJ_ADD_ITEM(/obj/item/food/monstermeat/xenomeat),
		CWJ_ADD_ITEM(/obj/item/food/monstermeat/xenomeat),
		CWJ_ADD_ITEM(/obj/item/food/monstermeat/xenomeat),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_ADD_ITEM(/obj/item/food/cheesewedge),
		CWJ_USE_OVEN(J_MED, 40 SECONDS),
	)

/datum/cooking/recipe/yakiimo
	cooking_container = /obj/item/reagent_containers/cooking/oven
	product_type = /obj/item/food/yakiimo
	steps = list(
		CWJ_ADD_PRODUCE(/obj/item/food/grown/potato/sweet),
		CWJ_USE_OVEN(J_MED, 10 SECONDS),
	)
