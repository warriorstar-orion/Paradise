/obj/structure/streetlight
	icon = 'icons/obj/structures/street.dmi'
	icon_state = "streetlamp-empty"

/obj/structure/streetlight/Initialize(mapload)
	. = ..()
	var/obj/effect/streetlight_active_bulb/active_bulb = new(src)
	active_bulb.pixel_y = 72
	vis_contents += active_bulb

/obj/effect/streetlight_active_bulb
	icon = 'icons/obj/structures/streetbulb.dmi'
	icon_state = "bulb_on"
	light_power = 3
	light_color = "#3e73e6"
	light_range = 4
