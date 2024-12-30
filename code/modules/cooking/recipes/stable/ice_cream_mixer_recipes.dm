
/datum/cooking/recipe/antpopsicle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/ant
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("water", 5),
		CWJ_ADD_REAGENT("ants", 10),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/bananatopsicle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/bananatop
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("banana", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/berrycreamsicle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/berrycream
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_REAGENT("sugar", 2),
		CWJ_ADD_REAGENT("berryjuice", 4),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_ADD_REAGENT("vanilla", 2),
		CWJ_ADD_REAGENT("cream", 2),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/berryicecreamsandwich
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/berryicecreamsandwich
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/wafflecone),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		CWJ_ADD_REAGENT("ice", 5),
		CWJ_ADD_REAGENT("cream", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/berrytopsicle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/berrytop
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("berryjuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cornuto
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/cornuto
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/sliceable/flatdough),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_ADD_REAGENT("sugar", 4),
		CWJ_ADD_REAGENT("cream", 4),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/frozenpineapplepop
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/frozenpineapple
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_ITEM(/obj/item/food/pineappleslice),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/honkdae
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/honkdae
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/wafflecone),
		CWJ_ADD_ITEM(/obj/item/clothing/mask/gas/clown_hat),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_REAGENT("cream", 5),
		CWJ_ADD_REAGENT("ice", 5),
		CWJ_USE_ICE_CREAM_MIXER(20 SECONDS),
	)

/datum/cooking/recipe/icecreamsandwich
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/icecreamsandwich
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/frozen/icecream),
		CWJ_ADD_REAGENT("ice", 5),
		CWJ_ADD_REAGENT("cream", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/jumboicecream
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_ITEM(/obj/item/food/chocolatebar),
		CWJ_ADD_REAGENT("sugar", 2),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_ADD_REAGENT("vanilla", 3),
		CWJ_ADD_REAGENT("cream", 2),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/licoricecreamsicle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/licoricecream
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_REAGENT("sugar", 2),
		CWJ_ADD_REAGENT("blumpkinjuice", 4),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_ADD_REAGENT("vanilla", 2),
		CWJ_ADD_REAGENT("cream", 2),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/orangecreamsicle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/orangecream
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_REAGENT("sugar", 2),
		CWJ_ADD_REAGENT("orangejuice", 4),
		CWJ_ADD_REAGENT("ice", 2),
		CWJ_ADD_REAGENT("vanilla", 2),
		CWJ_ADD_REAGENT("cream", 2),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/peanutbuttermochi
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/peanutbuttermochi
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/wafflecone),
		CWJ_ADD_REAGENT("cream", 5),
		CWJ_ADD_REAGENT("rice", 5),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("peanutbutter", 2),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/pineappletopsicle
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/pineappletop
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_ITEM(/obj/item/food/tofu),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("pineapplejuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/seasalticecream
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/popsicle/sea_salt
	steps = list(
		CWJ_ADD_ITEM(/obj/item/popsicle_stick),
		CWJ_ADD_REAGENT("sugar", 5),
		CWJ_ADD_REAGENT("sodiumchloride", 3),
		CWJ_ADD_REAGENT("cream", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/apple
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/apple
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("applejuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/berry
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/berry
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("berryjuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/bluecherry
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/bluecherry
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("bluecherryjelly", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cherry
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/cherry
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("cherryjelly", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/cola
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/cola
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("cola", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/flavorless
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/fruitsalad
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/fruitsalad
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("banana", 5),
		CWJ_ADD_REAGENT("orangejuice", 5),
		CWJ_ADD_REAGENT("watermelonjuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/grape
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/grape
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("grapejuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/honey
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/honey
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("honey", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/lemon
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/lemon
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("lemonjuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/lime
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/lime
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("limejuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/mime
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/mime
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("nothing", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/orange
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/orange
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("orangejuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/pineapple
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/pineapple
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("pineapplejuice", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/rainbow
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/rainbow
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("colorful_reagent", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/spacemountainwind
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/snowcone/spacemountain
	steps = list(
		CWJ_ADD_ITEM(/obj/item/reagent_containers/drinks/sillycup),
		CWJ_ADD_REAGENT("ice", 15),
		CWJ_ADD_REAGENT("spacemountainwind", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/spacefreezy
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/spacefreezy
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/frozen/icecream),
		CWJ_ADD_REAGENT("bluecherryjelly", 5),
		CWJ_ADD_REAGENT("spacemountainwind", 15),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)

/datum/cooking/recipe/sundae
	cooking_container = /obj/item/reagent_containers/cooking/icecream_bowl
	product_type = /obj/item/food/frozen/sundae
	steps = list(
		CWJ_ADD_ITEM(/obj/item/food/wafflecone),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/cherries),
		CWJ_ADD_PRODUCE(/obj/item/food/grown/banana),
		CWJ_ADD_REAGENT("cream", 5),
		CWJ_USE_ICE_CREAM_MIXER(10 SECONDS),
	)
