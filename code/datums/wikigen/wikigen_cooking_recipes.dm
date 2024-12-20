/datum/wikigen/cooking_recipes
	name = "Cooking Recipes Wiki Generator"
	output_filename = "cooking_recipes.mediawiki"

/datum/wikigen/cooking_recipes/generate()
	var/output = ""

	for(var/food_type in subtypesof(/obj/item/food))
		if(food_type == /obj/item/food/egg/gland)
			continue
		var/obj/item/food/food = new food_type
		var/total_reagents = list()
		// for(var/top_level_reagent in food.list_reagents)
		// 	if(!(top_level_reagent in total_reagents))
		// 		total_reagents[top_level_reagent] = 0
		// 	total_reagents[top_level_reagent] += food.list_reagents[top_level_reagent]
		for(var/datum/reagent/reagent in food.reagents.reagent_list)
			if(!(reagent.id in total_reagents))
				total_reagents[reagent.id] = 0
			total_reagents[reagent.id] += reagent.volume
		output += "[food_type],[food.name],"
		var/list/reagent_list = list()
		for(var/reagent_name in total_reagents)
			reagent_list += "[reagent_name]=[total_reagents[reagent_name]]"
		output += reagent_list.Join(";")
		output += "\n"

	return output
