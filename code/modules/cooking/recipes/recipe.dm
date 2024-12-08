
//Example Recipes
/datum/cooking/recipe/steak_stove

	//Name of the recipe. If not defined, it will just use the name of the product_type
	name="Stove-Top cooked Steak"

	//The recipe will be cooked on a pan
	cooking_container = PAN

	//The product of the recipe will be a steak.
	product_type = /obj/item/food/meatsteak

	//The product will have it's initial reagents wiped, prior to the recipe adding in reagents of its own.
	replace_reagents = FALSE

	step_builder = list(

		//Butter your pan by adding a slice of butter, and then melting it. Adding the butter unlocks the option to melt it on the stove.
		CWJ_BEGIN_OPTION_CHAIN,
		//base - the lowest amount of quality following this step can award.
		//reagent_skip - Exclude the added item's reagents from being included the product
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/butterslice, base=10),

		//Melt the butter into the pan by cooking it on a stove set to Low for 10 seconds
		list(CWJ_USE_STOVE_OPTIONAL, J_LO, 10 SECONDS),
		CWJ_END_OPTION_CHAIN,

		//A steak is needed to start the meal.
		//qmod- Half of the food quality of the parent will be considered.
		//exclude_reagents- Blattedin and Carpotoxin will be filtered out of the steak. EXCEPT THIS IS ERIS, WE EMBRACE THE ROACH, and has thus been removed from every
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		//Add some mushrooms to give it some zest. Only one kind is allowed!
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_PRODUCE_OPTIONAL, "mushroom", qmod=0.4),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "plumphelmet", qmod=0.4),
		CWJ_END_EXCLUSIVE_OPTIONS,

		//Beat that meat to increase its quality
		list(CWJ_USE_TOOL_OPTIONAL, QUALITY_HAMMERING, 15),

		//You can add up to 3 units of honey to increase the quality. Any more will negatively impact it.
		//base- for CWJ_ADD_REAGENT, the amount that this step will award if followed perfectly.
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 3, base=3),

		//You can add capaicin or wine, but not both
		//prod_desc- A description appended to the resulting product.
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_REAGENT_OPTIONAL, "capsaicin", 5, base=6, prod_desc="The steak was Spiced with chili powder."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "wine", 5, remain_percent=0.1 ,base=6, prod_desc="The steak was sauteed in wine"),
		CWJ_END_EXCLUSIVE_OPTIONS,

		//Cook on a stove, at medium temperature, for 30 seconds
		list(CWJ_USE_STOVE, J_MED, 30 SECONDS)
	)

//**Meat and Seafood**//
//Missing: cubancarp, friedchicken, tonkatsu, enchiladas, monkeysdelight, fishandchips, katsudon, fishfingers,
/datum/cooking/recipe/donkpocket //Special interactions in recipes_microwave.dm, not sure if this is going to function as expected
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/donkpocket

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_REAGENT, "thermite", 1) //So it cooks inhand, totally.
	)

/datum/cooking/recipe/cooked_cutlet
	cooking_container = GRILL
	product_type = /obj/item/food/cutlet
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/rawcutlet, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/cooked_meatball
	cooking_container = PAN
	product_type = /obj/item/food/meatball
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/rawmeatball, qmod=0.5),
		list(CWJ_ADD_REAGENT, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_LO, 20 SECONDS)
	)

/datum/cooking/recipe/cooked_patty
	cooking_container = GRILL
	product_type = /obj/item/food/patty
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/patty_raw, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_GRILL, J_LO, 10 SECONDS)
	)

/datum/cooking/recipe/chickensteak
	cooking_container = PAN
	product_type = /obj/item/food/chickensteak

	replace_reagents = FALSE

	step_builder = list(
		CWJ_BEGIN_OPTION_CHAIN,
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/butterslice, base=10),
		list(CWJ_USE_STOVE_OPTIONAL, J_LO, 10 SECONDS),
		CWJ_END_OPTION_CHAIN,
		list(CWJ_ADD_ITEM, /obj/item/food/chickenbreast, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_PRODUCE_OPTIONAL, "mushroom", qmod=0.4),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "plumphelmet", qmod=0.4),
		CWJ_END_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 3, base=3),
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_REAGENT_OPTIONAL, "capsaicin", 5, base=6, prod_desc="The chicken was Spiced with chili powder."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "lemonjuice", 5, remain_percent=0.1 ,base=3, prod_desc="The chicken was sauteed in lemon juice"),
		CWJ_END_EXCLUSIVE_OPTIONS,
		list(CWJ_USE_STOVE, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/porkchops
	cooking_container = PAN
	product_type = /obj/item/food/porkchops

	replace_reagents = FALSE

	step_builder = list(
		CWJ_BEGIN_OPTION_CHAIN,
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/butterslice, base=10),
		list(CWJ_USE_STOVE_OPTIONAL, J_LO, 10 SECONDS),
		CWJ_END_OPTION_CHAIN,
		list(CWJ_ADD_ITEM, /obj/item/food/meat/pork, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_PRODUCE_OPTIONAL, "mushroom", qmod=0.4),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "plumphelmet", qmod=0.4),
		CWJ_END_EXCLUSIVE_OPTIONS,
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_REAGENT_OPTIONAL, "capsaicin", 5, base=6, prod_desc="The pork was Spiced with chili powder."),
	//	list(CWJ_ADD_REAGENT_OPTIONAL, "pineapplejuice", 5, remain_percent=0.1, base=5, prod_desc="The pork was rosted in pineapple juice."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 5, remain_percent=0.1 ,base=3, prod_desc="The pork was glazed with honey"),
	//	list(CWJ_ADD_REAGENT_OPTIONAL, "bbqsauce", 3, remain_percent=0.5 ,base=8, prod_desc="The pork was layered with BBQ sauce"),
		CWJ_END_EXCLUSIVE_OPTIONS,
		list(CWJ_USE_STOVE, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/roastchicken
	cooking_container = OVEN
	product_type = /obj/item/food/roastchicken
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat/chicken, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/stuffing, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/tofurkey //Not quite meat but cooked similar to roast chicken
	cooking_container = OVEN
	product_type = /obj/item/food/tofurkey
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/stuffing, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/boiled_egg
	cooking_container = POT
	product_type = /obj/item/food/boiledegg
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_ADD_REAGENT, "water", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/friedegg_basic
	cooking_container = PAN
	product_type = /obj/item/food/friedegg
	step_builder = list(

		CWJ_BEGIN_OPTION_CHAIN,
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/butterslice, base=10),
		list(CWJ_USE_STOVE_OPTIONAL, J_LO, 10 SECONDS),
		CWJ_END_OPTION_CHAIN,

		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_USE_STOVE, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/bacon
	cooking_container = PAN
	product_type = /obj/item/food/bacon
	step_builder = list(
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "cornoil", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/rawbacon, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 1, base=1),
		list(CWJ_USE_OVEN, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/baconegg
	cooking_container = PAN
	product_type = /obj/item/food/baconeggs
	step_builder = list(
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "cornoil", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/friedegg, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_USE_OVEN, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/benedict
	cooking_container = PAN
	product_type = /obj/item/food/benedict
	step_builder = list(
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "cornoil", 1),
		list(CWJ_ADD_REAGENT, "egg", 3),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 3, base=3),
		list(CWJ_ADD_ITEM, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledegg, qmod=0.5),
		list(CWJ_USE_OVEN, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/omelette
	cooking_container = PAN
	product_type = /obj/item/food/omelette
	step_builder = list(
		list(CWJ_ADD_REAGENT, "cornoil", 2),
		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 3, base=3),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_LO, 10 SECONDS)
	)

/datum/cooking/recipe/taco
	cooking_container = PAN
	product_type = /obj/item/food/taco
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/tortilla),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "cornoil", 1),
		list(CWJ_ADD_PRODUCE, "corn"),
		list(CWJ_ADD_PRODUCE, "cabbage"),
		list(CWJ_ADD_ITEM, /obj/item/food/cutlet),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/hotdog
	cooking_container = GRILL
	product_type = /obj/item/food/hotdog
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/sausage, qmod=0.5),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/sausage
	cooking_container = GRILL
	product_type = /obj/item/food/sausage
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/rawmeatball),
		list(CWJ_ADD_ITEM, /obj/item/food/rawbacon),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_USE_GRILL, J_MED, 10 SECONDS)
	)

/datum/cooking/recipe/wingfangchu
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/wingfangchu
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat/xenomeat, qmod=0.5),
		list(CWJ_ADD_REAGENT, "soysauce", 5),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15)
	)

/datum/cooking/recipe/sashimi
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/sashimi
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/meat/carp, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/carp, qmod=0.5),
		list(CWJ_ADD_REAGENT, "soysauce", 5),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15)
	)

/datum/cooking/recipe/chawanmushi
	cooking_container = OVEN
	product_type = /obj/item/food/chawanmushi
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_ADD_REAGENT, "water", 5),
		list(CWJ_ADD_REAGENT, "soysauce", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_USE_OVEN, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/kabob
	cooking_container = GRILL
	product_type = /obj/item/food/kabob
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/stack/rods = 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_USE_GRILL, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/tofukabob
	cooking_container = GRILL
	product_type = /obj/item/food/tofukabob
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/stack/rods = 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_USE_GRILL, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/humankabob
	cooking_container = GRILL
	product_type = /obj/item/food/kabob
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/stack/rods = 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/human, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/human, qmod=0.5),
		list(CWJ_USE_GRILL, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/nigiri
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/nigiri
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/carp, qmod=0.5),
	)

/datum/cooking/recipe/makiroll
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/makiroll
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "ambrosia", qmod=0.2),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/carp, qmod=0.5),
		list(CWJ_ADD_REAGENT, "soysauce", 5),
	)

/datum/cooking/recipe/maki
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/maki
	product_count = 4
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/makiroll, qmod=0.5),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15)
	)

//**Cereals and Grains**//
//missing: poppyprezel
/datum/cooking/recipe/bread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/bread
	recipe_guide = "Put dough in an oven, bake for 30 seconds on medium."
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/meatbread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/meatbread
	recipe_guide = "Put dough in an oven, bake for 30 seconds on medium."
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/xenomeatbread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/xenomeatbread
	recipe_guide = "Put dough in an oven, bake for 30 seconds on medium."
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/xenomeat),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/xenomeat),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/tofubread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/tofubread
	recipe_guide = "Put dough in an oven, bake for 30 seconds on medium."
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/creamcheesebread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/creamcheesebread
	recipe_guide = "Put dough in an oven, bake for 30 seconds on medium."
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/dough),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/bananabread
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/bananabread

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/dough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/dough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/dough, qmod=0.5),
		list(CWJ_ADD_REAGENT, "milk", 2),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_PRODUCE, "banana", 1),
		list(CWJ_USE_OVEN, J_MED, 40 SECONDS)
	)
/datum/cooking/recipe/baguette
	cooking_container = OVEN
	product_type = /obj/item/food/baguette
	step_builder = list(
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/dough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/dough, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/cracker
	cooking_container = OVEN
	product_type = /obj/item/food/cracker
	step_builder = list(
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/bun
	cooking_container = OVEN
	product_type = /obj/item/food/bun
	product_count = 3
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1),
		list(CWJ_USE_OVEN, J_HI, 5 SECONDS)
	)

/datum/cooking/recipe/flatbread
	cooking_container = OVEN
	product_type = /obj/item/food/flatbread
	product_count = 3
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1),
		list(CWJ_USE_OVEN, J_HI, 5 SECONDS)
	)

/datum/cooking/recipe/twobread
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/twobread
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "wine", 5)
	)

/datum/cooking/recipe/pancakes
	cooking_container = PAN
	product_type = /obj/item/food/pancakes
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sugar", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 3, base=3),
		list(CWJ_ADD_REAGENT, "milk", 5, base=1),
		list(CWJ_ADD_REAGENT, "flour", 5, base=1),
		list(CWJ_USE_OVEN, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/waffles
	cooking_container = PAN
	product_type = /obj/item/food/waffles
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sugar", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 3, base=3),
		list(CWJ_ADD_REAGENT, "milk", 5, base=1),
		list(CWJ_ADD_REAGENT, "flour", 5, base=1),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15),
		list(CWJ_USE_OVEN, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/rofflewaffles
	cooking_container = PAN
	product_type = /obj/item/food/rofflewaffles
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/waffles, qmod=0.5),
		list(CWJ_ADD_REAGENT, "psilocybin", 5),
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_REAGENT_OPTIONAL, "pwine", 5, base=6, remain_percent=0.1, prod_desc="The fancy wine soaks up into the fluffy waffles."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "space_drugs", 5, base=6, remain_percent=0.5, prod_desc="The space drugs soak into the waffles."),
	//	list(CWJ_ADD_REAGENT_OPTIONAL, "lean", 5, base=6, remain_percent=0.5, prod_desc="Normally not for breakfast."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "mindbreaker", 5, base=6, remain_percent=0.1, prod_desc="Not for waking up to."),
	//	list(CWJ_ADD_REAGENT_OPTIONAL, "psi_juice", 5, base=6, prod_desc="For when you wake up feeling droggy still."),
		CWJ_END_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_USE_OVEN, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/jelliedtoast
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jelliedtoast/cherry
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "cherryjelly", 5),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15)
	)

/datum/cooking/recipe/amanitajellytoast
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jelliedtoast/amanita
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/jelly/amanita, qmod=0.5),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15)
	)

/datum/cooking/recipe/slimetoast
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jelliedtoast/slime
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "slimejelly", 5),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15)
	)

/datum/cooking/recipe/stuffing
	cooking_container = BOWL
	product_type = /obj/item/food/stuffing
	product_count = 3
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/bread, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		list(CWJ_ADD_REAGENT, "water", 5),
	)

/datum/cooking/recipe/tortilla
	cooking_container = OVEN
	product_type = /obj/item/food/tortilla
	product_count = 3
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/flatdoughslice),
		list(CWJ_ADD_ITEM, /obj/item/food/flatdoughslice),
		list(CWJ_ADD_ITEM, /obj/item/food/flatdoughslice),
		list(CWJ_USE_OVEN, J_HI, 5 SECONDS)
	)

/datum/cooking/recipe/muffin
	cooking_container = OVEN
	product_type = /obj/item/food/muffin
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar, qmod=0.5),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/boiledrice
	cooking_container = POT
	product_type = /obj/item/food/boiledrice
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT, "rice", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_HI, 15 SECONDS)
	)

/datum/cooking/recipe/ricepudding
	cooking_container = BOWL
	product_type = /obj/item/food/ricepudding
	step_builder = list(
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cream", 10),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice, qmod=0.5)
	)

//**Burgers**//
/datum/cooking/recipe/burger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/monkeyburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/patty)
	)

/datum/cooking/recipe/humanburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/human/burger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/human)
	)

/*/datum/cooking/recipe/brainburger //Currently nonfunctional as base body parts do not have food_quality\
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/brainburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/organ/internal/vital/brain)
	)

/datum/cooking/recipe/roburger //Currently nonfunctional as base body parts do not have food_quality
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/roburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/robot_parts/head)
	)
*/
/datum/cooking/recipe/xenoburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/xenoburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/xenomeat)
	)

/datum/cooking/recipe/fishburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/fishburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/carp)
	)

/datum/cooking/recipe/tofuburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/tofuburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5), //Adding non-vegan optional to a vegan style dish is hysterical
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5), //Double down
		list(CWJ_ADD_ITEM, /obj/item/food/tofu)
	)

/*/datum/cooking/recipe/clownburger //Currently nonfunctional as clothing do not have food_quality
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/clownburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/clothing/mask/gas/clown_hat)
	)

/datum/cooking/recipe/mimeburger //Currently nonfunctional as clothing do not have food_quality
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/mimeburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/clothing/head/beret)
	)
*/
/datum/cooking/recipe/bigbiteburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/bigbiteburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/monkeyburger, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/patty, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/patty, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/patty, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledegg, qmod=0.5)
	)

/datum/cooking/recipe/superbiteburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/superbiteburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bigbiteburger, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/patty, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledegg, qmod=0.5)
	)

/datum/cooking/recipe/jellyburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jellyburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_REAGENT, "cherryjelly", 5)
	)

/datum/cooking/recipe/amanitajellyburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jellyburger/amanita

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/jelly/amanita, qmod=0.5)
	)

/datum/cooking/recipe/slimeburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jellyburger/slime

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_REAGENT, "slimejelly", 5)
	)

//**Sandwiches**//
/datum/cooking/recipe/sandwich_basic
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/sandwich
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "cabbage"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_ADD_ITEM, /obj/item/food/cutlet, qmod=0.5, desc="Add any kind of cooked cutlet."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5)
	)

/datum/cooking/recipe/slimesandwich
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jellysandwich/slime
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "slimejelly", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5)
	)

/datum/cooking/recipe/cherrysandwich
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jellysandwich/cherry
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "cherryjelly", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5)
	)

/datum/cooking/recipe/amanitajellysandwich
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jellysandwich/amanita
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/jelly/amanita, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5)
	)

/datum/cooking/recipe/blt
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/blt
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/bacon, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "cabbage"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_ADD_ITEM, /obj/item/food/cutlet, qmod=0.5, desc="Add any kind of cooked cutlet."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5)
	)

/datum/cooking/recipe/grilledcheese
	cooking_container = GRILL
	product_type = /obj/item/food/grilledcheese
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/breadslice, qmod=0.5),
		list(CWJ_USE_GRILL, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/toastedsandwich
	cooking_container = GRILL
	product_type = /obj/item/food/toastedsandwich
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sandwich, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_GRILL, J_LO, 15 SECONDS)
	)

//**Erisian Cuisine**//
//Left out due to never having existed previously: Spider burgers, Kraftwerk, Benzin
/datum/cooking/recipe/boiled_roach_egg
	cooking_container = POT
	product_type = /obj/item/food/roach_egg
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/roach_egg, qmod=0.5),
		list(CWJ_ADD_REAGENT, "water", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/kampferburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/kampferburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/kampfer)
	)

/datum/cooking/recipe/seucheburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/seucheburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/seuche)
	)

/datum/cooking/recipe/panzerburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/panzerburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/panzer)
	)

/datum/cooking/recipe/jagerburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/jagerburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/jager)
	)

/datum/cooking/recipe/bigroachburger //Difference: Requires boiled roach egg
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/bigroachburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/roach_egg),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/kampfer),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/seuche),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/panzer),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/jager)
	)

/datum/cooking/recipe/fuhrerburger //Difference: Requires boiled roach egg
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/fuhrerburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/roach_egg),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/fuhrer)
	)

/datum/cooking/recipe/kaiserburger //Difference: Requires boiled roach egg
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/kaiserburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/roach_egg),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/roachmeat/kaiser)
	)

/datum/cooking/recipe/wormburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/wormburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/moecube/worm)
	)

/datum/cooking/recipe/geneburger
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/geneburger

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/bun, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "ketchup", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/moecube)
	)

//**Pastas**//
/datum/cooking/recipe/raw_spaghetti
	cooking_container = CUTTING_BOARD
	product_type = /obj/item/food/spaghetti
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "flour", 1, base=1),
		list(CWJ_USE_TOOL, QUALITY_CUTTING, 15)
	)

/datum/cooking/recipe/boiledspaghetti
	cooking_container = POT
	product_type = /obj/item/food/boiledspaghetti
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/spaghetti, qmod=0.5),
		list(CWJ_USE_STOVE, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/pastatomato
	cooking_container = PAN
	product_type = /obj/item/food/pastatomato
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledspaghetti, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "tomato", qmod=0.4),
		list(CWJ_ADD_PRODUCE, "tomato", qmod=0.4),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/meatballspaghetti
	cooking_container = PAN
	product_type = /obj/item/food/meatballspaghetti
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledspaghetti, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato", qmod=0.4),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/spesslaw
	cooking_container = PAN
	product_type = /obj/item/food/spesslaw
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledspaghetti, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato", qmod=0.4),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS)
	)

//**Pizzas**//
/datum/cooking/recipe/pizzamargherita
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/margherita
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "water", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "flour", 5),
		list(CWJ_ADD_PRODUCE, "tomato", qmod=0.2),
		list(CWJ_USE_OVEN, J_MED, 35 SECONDS)
	)

/datum/cooking/recipe/meatpizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/meatpizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "water", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "flour", 5),
		list(CWJ_ADD_PRODUCE, "tomato", qmod=0.2),
		list(CWJ_USE_OVEN, J_MED, 35 SECONDS)
	)

/datum/cooking/recipe/mushroompizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/mushroompizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "water", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "flour", 5),
		list(CWJ_ADD_PRODUCE, "tomato", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_USE_OVEN, J_MED, 35 SECONDS)
	)

/datum/cooking/recipe/vegetablepizza
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pizza/vegetablepizza
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "water", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "flour", 5),
		list(CWJ_ADD_PRODUCE, "tomato", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "eggplant", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "cabbage", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "carrot", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_USE_OVEN, J_MED, 35 SECONDS)
	)

//**Pies**//
/datum/cooking/recipe/meatpie
	cooking_container = OVEN
	product_type = /obj/item/food/meatpie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/tofupie
	cooking_container = OVEN
	product_type = /obj/item/food/tofupie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/xemeatpie
	cooking_container = OVEN
	product_type = /obj/item/food/xemeatpie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/xenomeat, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/pie
	cooking_container = OVEN
	product_type = /obj/item/food/pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "banana", qmod=0.2),
		list(CWJ_ADD_REAGENT, "sugar", 5, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/cherrypie
	cooking_container = OVEN
	product_type = /obj/item/food/cherrypie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "cherry", qmod=0.2),
		list(CWJ_ADD_REAGENT, "sugar", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/berryclafoutis
	cooking_container = OVEN
	product_type = /obj/item/food/berryclafoutis
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "berries", qmod=0.2),
		list(CWJ_ADD_REAGENT, "sugar", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/amanita_pie
	cooking_container = OVEN
	product_type = /obj/item/food/amanita_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_REAGENT, "amatoxin", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/plump_pie
	cooking_container = OVEN
	product_type = /obj/item/food/plump_pie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "plumphelmet", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/pumpkinpie
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/pumpkinpie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "pumpkin", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/applepie
	cooking_container = OVEN
	product_type = /obj/item/food/applepie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "apple", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

//**Salads**//
/datum/cooking/recipe/tossedsalad
	cooking_container = BOWL
	product_type = /obj/item/food/tossedsalad
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "cabbage", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "cabbage", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "carrot", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "apple", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/stuffing, base=10),
		list(CWJ_ADD_PRODUCE, "tomato", qmod=0.2),
	)

/datum/cooking/recipe/aesirsalad
	cooking_container = BOWL
	product_type = /obj/item/food/aesirsalad
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "ambrosiadeus", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/stuffing, base=10),
		list(CWJ_ADD_PRODUCE, "goldapple", qmod=0.2),
	)

/datum/cooking/recipe/validsalad
	cooking_container = BOWL
	product_type = /obj/item/food/validsalad
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "ambrosia", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "ambrosia", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "ambrosia", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/stuffing, base=5),
		list(CWJ_ADD_PRODUCE, "potato", qmod=0.2),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
	)
//**Soups**// Possibly replaced by Handyman's Soup project, which'll be based on cauldron soup kitchen aesthetic
/datum/cooking/recipe/tomatosoup
	cooking_container = POT
	product_type = /obj/item/food/tomatosoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_REAGENT_OPTIONAL, "cream", 5, base=3, prod_desc="The soup turns a lighter red and thickens with the cream."),
		list(CWJ_ADD_REAGENT_OPTIONAL, "honey", 5 ,base=5, prod_desc="The thickens as the honey mixes in."),
		CWJ_END_EXCLUSIVE_OPTIONS,
		list(CWJ_USE_STOVE, J_LO, 30 SECONDS)
	)

/datum/cooking/recipe/meatballsoup
	cooking_container = POT
	product_type = /obj/item/food/meatballsoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/meatball, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "carrot"),
		list(CWJ_ADD_PRODUCE, "potato"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_USE_STOVE, J_LO, 30 SECONDS)
	)

/datum/cooking/recipe/vegetablesoup
	cooking_container = POT
	product_type = /obj/item/food/vegetablesoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "carrot"),
		list(CWJ_ADD_PRODUCE, "potato"),
		list(CWJ_ADD_PRODUCE, "eggplant"),
		list(CWJ_ADD_PRODUCE, "cabbage"),
		list(CWJ_USE_STOVE, J_LO, 30 SECONDS)
	)

/datum/cooking/recipe/nettlesoup
	cooking_container = POT
	product_type = /obj/item/food/nettlesoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "potato"),
		list(CWJ_ADD_PRODUCE, "nettle"),
		list(CWJ_USE_STOVE, J_LO, 30 SECONDS)
	)

/datum/cooking/recipe/wishsoup
	cooking_container = POT
	product_type = /obj/item/food/wishsoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 20),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/coldchili
	cooking_container = POT
	product_type = /obj/item/food/coldchili
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "icechili"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_USE_STOVE, J_LO, 30 SECONDS)
	)

/datum/cooking/recipe/hotchili
	cooking_container = POT
	product_type = /obj/item/food/coldchili
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "chili"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_USE_STOVE, J_LO, 30 SECONDS)
	)

/datum/cooking/recipe/bearchili
	cooking_container = POT
	product_type = /obj/item/food/bearchili
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "chili"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_ADD_ITEM, /obj/item/food/meat/bearmeat, qmod=0.5),
		list(CWJ_USE_STOVE, J_LO, 30 SECONDS)
	)

/datum/cooking/recipe/stew
	cooking_container = POT
	product_type = /obj/item/food/stew
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "carrot"),
		list(CWJ_ADD_PRODUCE, "potato"),
		list(CWJ_ADD_PRODUCE, "mushroom"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/milosoup
	cooking_container = POT
	product_type = /obj/item/food/milosoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/soydope, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/soydope, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/beetsoup
	cooking_container = POT
	product_type = /obj/item/food/beetsoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_PRODUCE, "whitebeet"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "potato"),
		list(CWJ_ADD_PRODUCE, "cabbage"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cream", 5, base=1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "blackpepper", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/mushroomsoup
	cooking_container = POT
	product_type = /obj/item/food/mushroomsoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_REAGENT, "cream", 5),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sodiumchloride", 1),
		list(CWJ_ADD_REAGENT, "blackpepper", 1),
		list(CWJ_ADD_PRODUCE, "mushroom", qmod=0.2),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS),
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_PRODUCE_OPTIONAL, "mushroom", qmod=0.4),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "plumphelmet", qmod=0.4),
		CWJ_END_EXCLUSIVE_OPTIONS,
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/mysterysoup
	cooking_container = POT
	product_type = /obj/item/food/mysterysoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/food/badrecipe, qmod=0.5),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS),
		list(CWJ_ADD_ITEM, /obj/item/food/tofu, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_USE_STOVE, J_MED, 20 SECONDS)
	)

/datum/cooking/recipe/bloodsoup
	cooking_container = POT
	product_type = /obj/item/food/bloodsoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "blood", 30),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/slimesoup
	cooking_container = POT
	product_type = /obj/item/food/slimesoup
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT, "slimejelly", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 15 SECONDS)
	)

/datum/cooking/recipe/beefcurry
	cooking_container = POT
	product_type = /obj/item/food/beefcurry

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, base=10),
		list(CWJ_USE_STOVE, J_LO, 10 SECONDS),
		list(CWJ_ADD_REAGENT, "flour", 5),
		list(CWJ_ADD_REAGENT, "soysauce", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/meat, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "chili"),
		list(CWJ_ADD_PRODUCE, "carrot"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_USE_STOVE, J_MED, 40 SECONDS)
	)

/datum/cooking/recipe/chickencurry
	cooking_container = POT
	product_type = /obj/item/food/chickencurry

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, base=10),
		list(CWJ_USE_STOVE, J_LO, 10 SECONDS),
		list(CWJ_ADD_REAGENT, "flour", 5),
		list(CWJ_ADD_REAGENT, "soysauce", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/boiledrice, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/chickenbreast, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "chili"),
		list(CWJ_ADD_PRODUCE, "carrot"),
		list(CWJ_ADD_PRODUCE, "tomato"),
		list(CWJ_USE_STOVE, J_MED, 40 SECONDS)
	)

//**Vegetables**//
//missing: soylenviridians, soylentgreen
/datum/cooking/recipe/mashpotato
	cooking_container = BOWL
	product_type = /obj/item/food/mashpotatoes

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_PRODUCE, "potato", 2),
		list(CWJ_ADD_REAGENT, "milk", 2),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, base=10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_USE_TOOL, QUALITY_HAMMERING, 15)
	)

/datum/cooking/recipe/loadedbakedpotato
	cooking_container = OVEN
	product_type = /obj/item/food/loadedbakedpotato

	replace_reagents = FALSE

	step_builder = list(
		list(CWJ_ADD_PRODUCE, "potato", 1),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/butterslice, base=10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/fries
	cooking_container = PAN
	product_type = /obj/item/food/fries
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/rawsticks),
		list(CWJ_ADD_REAGENT, "cornoil", 1),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1),
		list(CWJ_USE_STOVE, J_HI, 15 SECONDS)
	)

/datum/cooking/recipe/cheesyfries
	cooking_container = PAN
	product_type = /obj/item/food/cheesyfries
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/fries),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge),
		list(CWJ_USE_STOVE, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/eggplantparm
	cooking_container = OVEN
	product_type = /obj/item/food/eggplantparm
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "eggplant"),
		list(CWJ_ADD_ITEM_OPTIONAL, /obj/item/food/butterslice, base=3),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		CWJ_BEGIN_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_PRODUCE_OPTIONAL, "mushroom", qmod=0.4),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "plumphelmet", qmod=0.4),
		CWJ_END_EXCLUSIVE_OPTIONS,
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_USE_STOVE, J_HI, 30 SECONDS)
	)

/datum/cooking/recipe/stewedsoymeat
	cooking_container = POT
	product_type = /obj/item/food/stewedsoymeat
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_ITEM, /obj/item/food/soydope, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/soydope, qmod=0.5),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "carrot"),
		list(CWJ_ADD_PRODUCE_OPTIONAL, "tomato"),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_HI, 15 SECONDS)
	)

//**Cakes**//
/datum/cooking/recipe/plaincake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/plaincake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/butterstick, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_REAGENT, "flour", 15),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "egg", 9),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/carrotcake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/carrotcake
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "carrot", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "carrot", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "carrot", qmod=0.2),
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/cheesecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/cheesecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/cheesewedge, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/orangecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/orangecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "orange", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/limecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/limecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "lime", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/lemoncake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/lemoncake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "lemon", qmod=0.2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/chocolatecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/chocolatecake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar, qmod=0.5),
		list(CWJ_ADD_REAGENT, "coco", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/applecake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/applecake
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "apple", qmod=0.2),
		list(CWJ_ADD_PRODUCE, "apple", qmod=0.2),
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 1, base=1),
		list(CWJ_USE_STOVE, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/birthdaycake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/birthdaycake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/clothing/head/cakehat, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/braincake
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/braincake
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/plaincake, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/organ/internal/vital/brain, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/butterstick, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

/datum/cooking/recipe/brownies
	cooking_container = OVEN
	product_type = /obj/item/food/sliceable/brownie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/butterstick, qmod=0.5),
		list(CWJ_ADD_REAGENT, "sugar", 15),
		list(CWJ_ADD_REAGENT, "coco", 10),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "egg", 9),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "woodpulp", 5),
		list(CWJ_USE_OVEN, J_MED, 30 SECONDS)
	)

//**Desserts and Sweets**//
//missing: fortunecookie, honey_bun, honey_pudding
//Changes: Now a chemical reaction: candy_corn, mint,
/datum/cooking/recipe/chocolateegg
	cooking_container = POT
	product_type = /obj/item/food/chocolateegg
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/egg, qmod=0.5),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sugar", 5),
		list(CWJ_USE_STOVE, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/candiedapple
	cooking_container = PAN
	product_type = /obj/item/food/candiedapple
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "apple", qmod=0.2),
		list(CWJ_ADD_REAGENT, "water", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 1, base=1),
		list(CWJ_USE_STOVE, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/cookie
	cooking_container = OVEN
	product_type = /obj/item/food/cookie
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_ADD_REAGENT_OPTIONAL, "cornoil", 2),
		list(CWJ_ADD_ITEM, /obj/item/food/doughslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/chocolatebar, qmod=0.5),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS)
	)

/datum/cooking/recipe/appletart
	cooking_container = OVEN
	product_type = /obj/item/food/appletart
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "goldapple", qmod=0.2),
		list(CWJ_ADD_REAGENT, "sugar", 5),
		list(CWJ_ADD_REAGENT, "milk", 5),
		list(CWJ_ADD_REAGENT, "flour", 10),
		list(CWJ_ADD_REAGENT, "egg", 3),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/plumphelmetbiscuit
	cooking_container = OVEN
	product_type = /obj/item/food/plumphelmetbiscuit
	step_builder = list(
		list(CWJ_ADD_ITEM, /obj/item/food/sliceable/flatdough, qmod=0.5),
		list(CWJ_ADD_PRODUCE, "plumphelmet", qmod=0.2),
		list(CWJ_ADD_REAGENT, "water", 5),
		list(CWJ_ADD_REAGENT, "flour", 5),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_USE_OVEN, J_LO, 15 SECONDS)
	)

/datum/cooking/recipe/popcorn
	cooking_container = PAN
	product_type = /obj/item/food/popcorn
	step_builder = list(
		list(CWJ_ADD_PRODUCE, "corn"),
		list(CWJ_ADD_ITEM, /obj/item/food/butterslice, qmod=0.5),
		list(CWJ_ADD_REAGENT, "cornoil", 2),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_USE_STOVE, J_LO, 5 SECONDS)
	)

//UNSORTED
//missing: spacylibertyduff
/datum/cooking/recipe/boiledslimeextract
	cooking_container = POT
	product_type = /obj/item/food/boiledslimecore
	step_builder = list(
		list(CWJ_ADD_REAGENT, "water", 10),
		list(CWJ_ADD_REAGENT_OPTIONAL, "sodiumchloride", 1, base=1),
		list(CWJ_ADD_ITEM, /obj/item/slime_extract, qmod=0.5),
		list(CWJ_USE_STOVE, J_HI, 15 SECONDS)
	)
