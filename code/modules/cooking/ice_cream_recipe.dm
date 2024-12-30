/datum/cooking/recipe/ice_cream
	var/obj/item/destination_object
	var/reagents_amount_per_serving = 10

/datum/cooking/recipe/ice_cream/make_product_item(obj/item/reagent_containers/cooking/container, datum/reagents/slurry, list/applied_steps, tracked_quality)
	var/obj/item/reagent_containers/cooking/icecream_bowl/bowl = container
	if(!istype(container))
		return

	var/destination_object_count = 0
	for(var/atom/movable/content in container.contents)
		if(istype(content, destination_object))
			destination_object_count++

	QDEL_LIST_CONTENTS(container.contents)

	var/products_made = 0
	var/list/allocated_reagent_amounts = list()
	for(var/datum/reagent/bowl_reagent in bowl.reagents.reagent_list)
		allocated_reagent_amounts[bowl_reagent] = bowl.reagents.get_reagent_amount(bowl_reagent) / destination_object_count
	var/ran_out_of_core_ingredients = FALSE
	while(products_made < destination_object_count && bowl.reagents.total_volume && !ran_out_of_core_ingredients)
		var/obj/item/product = new product_type(container)
		products_made++
		for(var/datum/reagent/bowl_reagent in bowl.reagents.reagent_list)
			if(product.reagents.has_reagent(bowl_reagent, bowl_reagent.volume))
				if(bowl.reagents.get_reagent_amount(bowl_reagent) < product.reagents.get_reagent_amount(bowl_reagent))
					ran_out_of_core_ingredients = TRUE
					break
			else
				bowl.reagents.trans_to(product, allocated_reagent_amounts[bowl_reagent])

	bowl.reagents.clear_reagents()
	container.update_appearance(UPDATE_ICON)
