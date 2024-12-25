
/datum/cooking/recipe/amanita_pie
	cooking_container = OVEN
	product_type = /obj/item/food/amanita_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom/amanita),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/applecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/applecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/apple),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/apple),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/applepie
	cooking_container = OVEN
	product_type = /obj/item/food/applepie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/apple),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/appletart
	cooking_container = OVEN
	product_type = /obj/item/food/appletart
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/apple/gold),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "flour", 10),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/baguette
	cooking_container = OVEN
	product_type = /obj/item/food/baguette
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/bananabread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/bananabread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/bananacake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/bananacake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/banarnarbread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/banarnarbread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_REAGENT, "blood", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/beary_pie
	cooking_container = OVEN
	product_type = /obj/item/food/beary_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/monstermeat/bearmeat),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/berry_muffin
	cooking_container = OVEN
	product_type = /obj/item/food/berry_muffin
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/berryclafoutis
	cooking_container = OVEN
	product_type = /obj/item/food/berryclafoutis
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/birthdaycake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/birthdaycake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/candle),
		list(CWJ_ADD_ITEM, /obj/item/candle),
		list(CWJ_ADD_ITEM, /obj/item/candle),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_REAGENT, "vanilla", 10),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/blumpkin_pie
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/blumpkin_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/pumpkin/blumpkin),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/booberry_muffin
	cooking_container = OVEN
	product_type = /obj/item/food/booberry_muffin
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/ectoplasm),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/braincake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/braincake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/organ/internal/brain),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/bread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/bread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/bun
	cooking_container = OVEN
	product_type = /obj/item/food/bun
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/cannoli
	cooking_container = OVEN
	product_type = /obj/item/food/cannoli
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cookiedough),
		list(CWJ_ADD_REAGENT, "milk", 1),
		list(CWJ_ADD_REAGENT, "sugar", 3),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/carrotcake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/carrotcake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/carrot),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/carrot),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/carrot),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/cheesecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/cheesecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/cheesepizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/cheesepizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/cherry_cupcake
	cooking_container = OVEN
	product_type = /obj/item/food/cherry_cupcake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/cherries),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/blue
	cooking_container = OVEN
	product_type = /obj/item/food/cherry_cupcake/blue
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/bluecherries),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/cherrypie
	cooking_container = OVEN
	product_type = /obj/item/food/cherrypie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/cherries),
		list(CWJ_ADD_REAGENT, "sugar", 10),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/chocolate_cornet
	cooking_container = OVEN
	product_type = /obj/item/food/chocolate_cornet
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cookiedough),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/chocolate_lava_tart
	cooking_container = OVEN
	product_type = /obj/item/food/chocolate_lava_tart
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_ITEM, /obj/item/slime_extract),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/chocolatecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/chocolatecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/clowncake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/clowncake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/frozen/sundae),
		list(CWJ_ADD_ITEM, /obj/item/food/frozen/sundae),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 50 SECONDS)
	)

/datum/cooking/recipe/cookies
	cooking_container = OVEN
	product_type = /obj/item/storage/bag/tray/cookies_tray
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/rawcookies/chocochips),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/cracker
	cooking_container = OVEN
	product_type = /obj/item/food/cracker
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/creamcheesebread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/creamcheesebread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/croissant
	cooking_container = OVEN
	product_type = /obj/item/food/croissant
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/egg),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/dankpizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/dankpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/cannabis),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/cannabis),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/cannabis),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/cannabis),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/donkpocketpizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/donkpocketpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/donkpocket),
		list(CWJ_ADD_ITEM, /obj/item/food/donkpocket),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/firecrackerpizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/firecrackerpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/chili),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/chili),
		list(CWJ_ADD_REAGENT, "capsaicin", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/flatbread
	cooking_container = OVEN
	product_type = /obj/item/food/flatbread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/fortunecookie
	cooking_container = OVEN
	product_type = /obj/item/food/fortunecookie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice),
		list(CWJ_ADD_ITEM, /obj/item/paper),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/french_silk_pie
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/french_silk_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/frosty_pie
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/frosty_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/bluecherries),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/garlicpizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/garlicpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/garlic),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/garlic),
		list(CWJ_ADD_REAGENT, "garlic", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/grape_tart
	cooking_container = OVEN
	product_type = /obj/item/food/grape_tart
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/grapes),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/grapes),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/grapes),
		list(CWJ_ADD_REAGENT, "milk = 5", None),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/hardware_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/hardware_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/circuitboard),
		list(CWJ_ADD_ITEM, /obj/item/circuitboard),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_REAGENT, "sacid", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/hawaiianpizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/hawaiianpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/pineappleslice),
		list(CWJ_ADD_ITEM, /obj/item/food/pineappleslice),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/holy_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/holy_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_REAGENT, "holywater", 15),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/honey_bun
	cooking_container = OVEN
	product_type = /obj/item/food/honey_bun
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cookiedough),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_REAGENT, "honey", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/lasagna
	cooking_container = OVEN
	product_type = /obj/item/food/lasagna
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/lemoncake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/lemoncake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/citrus/lemon),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/citrus/lemon),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/liars_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/liars_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 50 SECONDS)
	)

/datum/cooking/recipe/limecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/limecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/citrus/lime),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/citrus/lime),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/loadedbakedpotato
	cooking_container = OVEN
	product_type = /obj/item/food/loadedbakedpotato
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/potato),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/macncheesepizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/macpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/macncheese),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/meatbread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/meatbread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/meatpie
	cooking_container = OVEN
	product_type = /obj/item/food/meatpie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/meatpizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/meatpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/mime_tart
	cooking_container = OVEN
	product_type = /obj/item/food/mime_tart
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_REAGENT, "nothing", 5),
		list(CWJ_ADD_REAGENT, "milk = 5", None),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/moffin
	cooking_container = OVEN
	product_type = /obj/item/food/moffin
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/grown/cotton),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/mothmallow
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/mothmallow
	step_builder = list(
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/soybeans),
		list(CWJ_ADD_REAGENT, "vanilla", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_REAGENT, "rum", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/muffin
	cooking_container = OVEN
	product_type = /obj/item/food/muffin
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/mushroompizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/mushroompizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/oatmeal_cookie
	cooking_container = OVEN
	product_type = /obj/item/food/oatmeal_cookie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/oat),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/orangecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/orangecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/citrus/orange),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/citrus/orange),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/peanut_butter_cookie
	cooking_container = OVEN
	product_type = /obj/item/food/peanut_butter_cookie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_REAGENT, "peanutbutter", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/pepperonipizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/pepperonipizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/sausage),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/pestopizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/pestopizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_ADD_REAGENT, "wasabi", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/pie
	cooking_container = OVEN
	product_type = /obj/item/food/pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/banana),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/pizzamargherita
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/margheritapizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/plaincake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/plaincake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/plum_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/plum_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/plum),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/plum),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/plump_pie
	cooking_container = OVEN
	product_type = /obj/item/food/plump_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom/plumphelmet),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/plumphelmetbiscuit
	cooking_container = OVEN
	product_type = /obj/item/food/plumphelmetbiscuit
	step_builder = list(
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/mushroom/plumphelmet),
		list(CWJ_ADD_REAGENT, "water", 5),
		list(CWJ_ADD_REAGENT, "flour", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/pound_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pound_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake),
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake),
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake),
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/pumpkin_spice_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pumpkin_spice_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/pumpkin),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/pumpkin),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/pumpkinpie
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pumpkinpie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/pumpkin),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/raisin_cookie
	cooking_container = OVEN
	product_type = /obj/item/food/raisin_cookie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/no_raisin),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/slime_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/slime_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/slime_extract),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/spaceman_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/spaceman_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/trumpet),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/trumpet),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_REAGENT, "cream", 5),
		list(CWJ_ADD_REAGENT, "berryjuice", 5),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/sugarcookie
	cooking_container = OVEN
	product_type = None
	step_builder = list(
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/sugarcookies
	cooking_container = OVEN
	product_type = /obj/item/storage/bag/tray/cookies_tray/sugarcookie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/rawcookies),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/syntibread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/meatbread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/syntiflesh),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/syntiflesh),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/syntiflesh),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/toastedsandwich
	cooking_container = OVEN
	product_type = /obj/item/food/toastedsandwich
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sandwich),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/tofubread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/tofubread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/tofupie
	cooking_container = OVEN
	product_type = /obj/item/food/tofupie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/tofurkey
	cooking_container = OVEN
	product_type = /obj/item/food/tofurkey
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/stuffing),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/turkey
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/turkey
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/stuffing),
		list(CWJ_ADD_ITEM, /obj/item/food/stuffing),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/vanilla_berry_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/vanilla_berry_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/berries),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/vanilla_cake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/vanilla_cake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/vanillapod),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/vanillapod),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_USE_OVEN, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/vegetablepizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/vegetablepizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/eggplant),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/carrot),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/corn),
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/tomato),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/xemeatpie
	cooking_container = OVEN
	product_type = /obj/item/food/xemeatpie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough),
		list(CWJ_ADD_ITEM, /obj/item/food/monstermeat/xenomeat),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/xenomeatbread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/xenomeatbread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/monstermeat/xenomeat),
		list(CWJ_ADD_ITEM, /obj/item/food/monstermeat/xenomeat),
		list(CWJ_ADD_ITEM, /obj/item/food/monstermeat/xenomeat),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/yakiimo
	cooking_container = OVEN
	product_type = /obj/item/food/yakiimo
	step_builder = list(
		list(CWJ_ADD_PRODUCE, /obj/item/food/grown/potato/sweet),
		list(CWJ_USE_OVEN, J_MED, 10 SECONDS)
	)
