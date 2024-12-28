/datum/wikigen/cooking_recipes
	name = "Cooking Recipes Wiki Generator"
	output_filename = "cooking_recipes.mediawiki"

/datum/wikigen/cooking_recipes/generate()
	var/output = ""

	for(var/recipe_container_type in GLOB.cwj_recipe_dictionary)
		for(var/datum/cooking/recipe/recipe in GLOB.cwj_recipe_dictionary[recipe_container_type])
			var/obj/output_type = recipe.product_type
			output += "[output_type::name]:\n"

			for(var/i in 1 to length(recipe.steps))
				var/datum/cooking/recipe_step/step = recipe.steps[i]
				output += "[i].[step.optional ? " (Optional)" : ""] [step.get_human_readable_instruction()]\n"
			output += "\n\n"

	return output
