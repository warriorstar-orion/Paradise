#define MAX_HEAT 1.0

/obj/structure/freight
	name = "freight container"
	desc = "A specialized compartment for shipping valuable freight. Often customized with climate control or monitoring systems for luxury goods. Interfaces with most common mail scanners."
	icon = 'icons/obj/structures/freight.dmi'
	icon_state = "freight_base"
	density = 1
	new_attack_chain = TRUE

	var/order_code
	var/livery
	var/current_heat = 0
	COOLDOWN_DECLARE(assault_cooldown)

/obj/structure/freight/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/freight/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/structure/freight/proc/set_heat(amt)
	current_heat = clamp(amt, 0, MAX_HEAT)

/obj/structure/freight/process()
	var/area/A = get_area(src)
	if(istype(A, /area/shuttle/abandoned))
		set_heat(current_heat + 0.005)

/obj/structure/freight/proc/add_random_livery()
	livery = "seal_[rand(1, 5)]"
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/freight/update_overlays()
	. = ..()
	. += image(icon, icon_state = "light_off")

	if(livery)
		. += image(icon, icon_state = livery)

#undef MAX_HEAT
