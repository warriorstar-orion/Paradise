PROCESSING_SUBSYSTEM_DEF(cooking)
	name = "Cooking"
	init_order = INIT_ORDER_DEFAULT
	priority = FIRE_PRIORITY_OBJ
	wait = 2 SECONDS
	flags = SS_TICKER

	var/list/recipe_dictionary

/datum/controller/subsystem/processing/cooking/Initialize()
	initialize_recipe_data()

/datum/controller/subsystem/processing/cooking/proc/initialize_recipe_data()
	var/list/recipe_paths = subtypesof(/datum/cooking/recipe)
	for(var/path in recipe_paths)
		var/datum/cooking/recipe/example_recipe = new path()
		LAZYORASSOCLIST(recipe_dictionary, example_recipe.cooking_container, example_recipe)

/datum/controller/subsystem/processing/cooking/proc/on_recipe_begin(obj/item/reagent_containers/cooking/source, obj/item/used)
	SIGNAL_HANDLER // COMSIG_COOKING_RECIPE_BEGIN
	if(!istype(source) || !istype(used))
		return COMPONENT_COOKING_NO_RECIPE

	if(!(source.type in recipe_dictionary))
		return COMPONENT_COOKING_NO_RECIPE

	var/list/matching_recipes = list()
	source.tracker = new(source)
	for(var/datum/cooking/recipe/recipe in recipe_dictionary[source.type])
		var/datum/cooking/recipe_step/first_step = recipe.steps[1]
		if(first_step.check_conditions_met(used, source.tracker) == CWJ_CHECK_VALID)
			matching_recipes[recipe] = 1

	if(!length(matching_recipes))
		return COMPONENT_COOKING_NO_RECIPE
