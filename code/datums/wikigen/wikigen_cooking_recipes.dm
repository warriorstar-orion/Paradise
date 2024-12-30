/datum/wikigen/cooking_recipes
	name = "Cooking Recipes Wiki Generator"
	output_filename = "cooking_recipes.json"

/datum/wikigen/cooking_recipes/generate()
	var/output = list()

	for(var/recipe_container_type in GLOB.cwj_recipe_dictionary)
		for(var/datum/cooking/recipe/recipe in GLOB.cwj_recipe_dictionary[recipe_container_type])
			var/obj/output_type = recipe.product_type
			var/list/recipe_data = list()
			recipe_data["internal_name"] = output_type::name
			recipe_data["steps"] = list()

			var/datum/cooking/recipe_step/last_step
			var/running_count = 0
			var/step_list_item = 0
			var/suffix = ""

			for(var/i in 1 to length(recipe.steps))
				var/datum/cooking/recipe_step/step = recipe.steps[i]
				if(step.equals(last_step))
					running_count++
				else if(last_step)
					if(running_count > 1)
						suffix = "[running_count]x"
					recipe_data["steps"] += "[last_step.optional ? "(Optional)" : ""] [last_step.get_wiki_formatted_instruction()] [suffix]"
					last_step = step
					running_count = 1
					step_list_item++
					suffix = ""
				else
					last_step = step
					running_count = 1
					step_list_item = 1
					suffix = ""

			recipe_data["steps"] += "[last_step.optional ? "(Optional)" : ""] [last_step.get_wiki_formatted_instruction()] [suffix]\n"

			output[recipe.type] += recipe_data

	return json_encode(output)
