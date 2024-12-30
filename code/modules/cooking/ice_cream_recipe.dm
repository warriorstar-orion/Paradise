/datum/cooking/recipe/ice_cream
	name = "generic ice cream recipe"
	var/obj/item/destination_object
	var/reagents_amount_per_serving = 10

/datum/cooking/recipe/ice_cream/make_product_item(obj/item/reagent_containers/cooking/container, datum/reagents/slurry, list/applied_steps, tracked_quality)
	var/obj/item/reagent_containers/cooking/icecream_bowl/bowl = container
	if(!istype(container))
		return

	bowl.total_reagents_amount = bowl.reagents.total_volume
	bowl.output_product_type = product_type
	bowl.reagents_amount_per_serving = reagents_amount_per_serving
	bowl.destination_object_type = destination_object

	bowl.reagents.clear_reagents()
	QDEL_LIST_CONTENTS(bowl.contents)
