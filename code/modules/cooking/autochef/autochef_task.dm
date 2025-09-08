/datum/autochef_task
	var/obj/machinery/autochef/autochef
	var/current_state = AUTOCHEF_ACT_STARTED
	var/repeating = FALSE

/datum/autochef_task/New(autochef_)
	autochef = autochef_

/datum/autochef_task/proc/resume()
	return

/datum/autochef_task/proc/finalize()
	return

/datum/autochef_task/proc/reset()
	return

/datum/autochef_task/proc/move_output_from_container(obj/machinery/autochef/autochef, atom/source)
	var/moved = FALSE
	for(var/i = length(autochef.linked_storages); i >= 1; i--)
		var/obj/machinery/smartfridge/storage = autochef.linked_storages[i]
		if(!istype(storage))
			continue
		for(var/atom/movable/result in source.contents)
			if(isInSight(autochef, storage) && storage.load(result))
				storage.Beam(get_turf(source), icon_state = "rped_upgrade", icon = 'icons/effects/effects.dmi', time = 5)
				SStgui.update_uis(storage)
				moved = TRUE
		if(moved)
			break

	// If we can't find somewhere to store it, just toss it
	// on a nearby table.
	if(!moved)
		var/turf/center = get_turf(source)
		for(var/turf/T in RANGE_EDGE_TURFS(1, center))
			if(locate(/obj/structure/table) in T)
				for(var/atom/movable/content in source.contents)
					if(content.forceMove(T))
						content.pixel_x = rand(-8, 8)
						content.pixel_y = rand(-8, 8)
					else
						content.forceMove(content.loc)
