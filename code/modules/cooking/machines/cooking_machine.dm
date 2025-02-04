RESTRICT_TYPE(/obj/machinery/cooking)

/obj/machinery/cooking
	name = "Default Cooking Appliance"
	desc = "You shouldn't be seeing this. Please report this as an issue on GitHub."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "processor"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/cooking = FALSE
	var/quality_mod = 1
	/// Power cost per process step for a particular burner
	var/power_cost = 250
	var/check_on_10 = 0
	idle_power_consumption = 5
	active_power_consumption = 100

	var/list/allowed_containers
	var/list/surfaces = list()

/obj/machinery/cooking/process()
	for(var/datum/cooking_surface/surface in surfaces)
		if(surface.on)
			surface.handle_cooking(null)

	// Under normal circumstances, only process the rest of this 10 process calls;
	// it doesn't need to be hyper-accurate.
	if(check_on_10 != 10)
		check_on_10++
		return
	else
		check_on_10 = 0

	var/used_power = 0
	for(var/datum/cooking_surface/surface in surfaces)
		if(surface.on)
			used_power += power_cost

	use_power(used_power)

/obj/machinery/cooking/RefreshParts()
	..()
	var/man_rating = 0
	for(var/obj/item/stock_parts/stock_part in component_parts)
		man_rating += stock_part.rating
	quality_mod = round(man_rating / 2)

/// Retrieve which burning surface on the machine is being accessed.
/obj/machinery/cooking/proc/clickpos_to_surface(modifiers)
	return

/obj/machinery/cooking/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	#warn fix default deconstruct
	// if(default_deconstruction(used_item, user))
	// 	return

	var/input = clickpos_to_surface(modifiers)
	if(input)
		var/datum/cooking_surface/surface = surfaces[input]
		return surface_item_interaction(user, used, surface)

	return ..()

/obj/machinery/cooking/proc/surface_item_interaction(mob/living/user, obj/item/used, datum/cooking_surface/surface)
	if(surface.placed_item)
		surface.placed_item.item_interaction(user, used)
	else if(used.type in allowed_containers)
		if(ismob(user))
			to_chat(user, "<span class='notice'>You put [used] on \the [src].</span>")
			if(user.drop_item())
				used.forceMove(src)
		else
			used.forceMove(src)

		surface.placed_item = used
		surface.prob_quality_decrease = 0
		if(surface.on)
			surface.reset_cooktime()

	update_appearance(UPDATE_ICON)
	return ITEM_INTERACT_COMPLETE

/// Ask the user to set the a cooking surfaces's temperature.
/obj/machinery/cooking/AltShiftClick(mob/user, modifiers)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return

	var/surface_idx = clickpos_to_surface(modifiers)
	if(!surface_idx)
		return

	var/datum/cooking_surface/burner = surfaces[surface_idx]
	burner.handle_temperature(user)

/// Ask the user to set a cooking surface's timer.
/obj/machinery/cooking/CtrlClick(mob/user, modifiers)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return

	var/surface_idx = clickpos_to_surface(modifiers)
	if(!surface_idx)
		return

	var/datum/cooking_surface/burner = surfaces[surface_idx]
	burner.handle_timer(user)

/// Switch the cooking surface on or off.
/obj/machinery/cooking/CtrlShiftClick(mob/user, modifiers)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return

	var/surface_idx = clickpos_to_surface(modifiers)
	if(!surface_idx)
		return

	var/datum/cooking_surface/burner = surfaces[surface_idx]
	burner.handle_switch(user)

/// Empty the container on the surface if it exists.
/obj/machinery/cooking/AltClick(mob/user, modifiers)
	if(user.stat || user.restrained() || (!in_range(src, user)))
		return

	var/input = clickpos_to_surface(modifiers)
	var/datum/cooking_surface/burner = surfaces[input]
	var/obj/item/reagent_containers/cooking/container = burner.placed_item
	if(!(istype(container)))
		return

	container.do_empty(user)
	burner.kill_timers()

/obj/machinery/cooking/proc/ignite()
	resistance_flags |= ON_FIRE
	new /obj/effect/fire(loc, T0C + 300, (roll("2d10+15") SECONDS), 1)

	// Chance of spreading
	var/spread_count = rand(1, 3)
	if(prob(30))
		var/list/dirs = GLOB.alldirs.Copy()
		while(spread_count && length(dirs))
			var/direction = pick_n_take(dirs)
			var/turf/T = get_step(src, direction)
			if(T.density)
				continue
			new /obj/effect/fire(T, T0C + 300, (roll("2d10+15") SECONDS), 1)
			spread_count--

	for(var/datum/cooking_surface/surface in surfaces)
		if(surface.on)
			surface.handle_switch()
