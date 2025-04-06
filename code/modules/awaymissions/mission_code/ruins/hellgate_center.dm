/area/ruin/hellgate_center

/obj/structure/doomed_portal
	icon = 'icons/obj/machines/gateway.dmi'
	icon_state = "toff"
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/datum/spawn_pool/hellgate_center

/datum/spawn_pool/hellgate_center/New()
	. = ..()
	available_points = roll("8d3")

/obj/effect/spawner/random/pool/hellgate_monster
	spawn_pool = /datum/spawn_pool/hellgate_center
	point_value = 1
	loot = list(
		list(
			/mob/living/basic/netherworld,
			/mob/living/basic/netherworld/faithless,
			/mob/living/basic/netherworld/blankbody,
			/mob/living/basic/netherworld/migo,
			/mob/living/basic/skeleton,
		) = 2,

		list(/mob/living/basic/hellhound)
	)

/obj/effect/spawner/random/pool/hellgate_monster/make_item(spawn_loc, type_path_to_make)
	var/mob/living/result = ..()
	result.faction |= "hellgate_monster"
	return result
