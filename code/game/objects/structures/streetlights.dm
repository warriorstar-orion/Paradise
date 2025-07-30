/obj/structure/streetlight
	icon = 'icons/obj/structures/street.dmi'
	icon_state = "streetlamp-empty"

/obj/structure/streetlight/Initialize(mapload)
	. = ..()
	var/obj/effect/streetlight_active_bulb/active_bulb = new(src)
	active_bulb.pixel_y = 50
	vis_contents += active_bulb

/obj/effect/streetlight_active_bulb
	name = ""
	icon = 'icons/obj/structures/streetbulb.dmi'
	icon_state = "bulb_on"
	light_power = 1
	light_color = "#6a8edd"
	light_range = 6
