/// Stores conveyor belts, click floor to make belt, use a conveyor switch on this to link all belts to that lever.
/obj/item/storage/conveyor
	name = "conveyor belt placer"
	desc = "This device facilitates the rapid deployment of conveyor belts."
	icon_state = "belt_placer"
	item_state = "belt_placer"
	w_class = WEIGHT_CLASS_BULKY //Because belts are large things, you know?
	can_hold = list(/obj/item/conveyor_construct)
	flags = CONDUCT
	max_w_class = WEIGHT_CLASS_BULKY
	max_combined_w_class = 28 //7 belts
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	display_contents_with_number = TRUE
	use_to_pickup = TRUE
	origin_tech = "engineering=1"

/obj/item/storage/conveyor/bluespace
	name = "bluespace conveyor belt placer"
	desc = "This device facilitates the rapid deployment of conveyor belts via the incorporation of experimental Bluespace technology."
	icon_state = "bluespace_belt_placer"
	item_state = "bluespace_belt_placer"
	w_class = WEIGHT_CLASS_NORMAL
	storage_slots = 50
	max_combined_w_class = 200 //50 belts
	origin_tech = "engineering=2;bluespace=1"

/// So we can link belts en masse
/obj/item/storage/conveyor/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	if(istype(used, /obj/item/conveyor_switch_construct))
		var/obj/item/conveyor_switch_construct/S = used
		var/linked = FALSE //For nice message
		for(var/obj/item/conveyor_construct/C in src)
			C.id = S.id
			linked = TRUE
		if(linked)
			to_chat(user, "<span class='notice'>All belts in [src] linked with [S].</span>")

		return ITEM_INTERACT_COMPLETE

	return ..()

/obj/item/storage/conveyor/after_attack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return COMPONENT_SKIP_ATTACK
	var/obj/item/conveyor_construct/C = locate() in src
	if(!C)
		to_chat(user, "<span class='notice'>There are no belts in [src].</span>")
	else
		C.afterattack__legacy__attackchain(target, user, proximity_flag)

	return ..()
