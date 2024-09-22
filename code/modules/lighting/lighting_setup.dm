/proc/create_all_lighting_objects()
	for(var/area/A in GLOB.all_areas)
		if(!IS_DYNAMIC_LIGHTING(A))
			continue

		for(var/turf/T in A)
			if(!IS_DYNAMIC_LIGHTING(T))
				continue

			new/atom/movable/lighting_object(T)
			CHECK_TICK
		CHECK_TICK

/proc/create_all_lighting_objects_on_zlvl(zlvl)
	for(var/turf/T in block(1, 1, zlvl, world.maxx, world.maxy))
		T.lighting_build_overlay()
