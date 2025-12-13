GLOBAL_VAR_INIT(camera_range_display_status, 0)
GLOBAL_VAR_INIT(intercom_range_display_status, 0)

USER_VERB_VISIBILITY(debug_camera_view, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(debug_camera_view, R_DEBUG, "Camera Range Display", "Camera Range Display", VERB_CATEGORY_MAPPING)
	if(GLOB.camera_range_display_status)
		GLOB.camera_range_display_status = 0
	else
		GLOB.camera_range_display_status = 1

	for(var/obj/effect/debugging/marker/M in world)
		qdel(M)

	if(GLOB.camera_range_display_status)
		for(var/obj/machinery/camera/C in GLOB.cameranet.cameras)
			for(var/turf/T in orange(7, C))
				var/obj/effect/debugging/marker/F = new/obj/effect/debugging/marker(T)
				if(!(F in view(7, C.loc)))
					qdel(F)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Camera Range Display") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(debug_camera_report, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(debug_camera_report, R_DEBUG, "Camera Report", "Camera Report", VERB_CATEGORY_MAPPING)
	var/list/obj/machinery/camera/CL = list()

	for(var/obj/machinery/camera/C in GLOB.cameranet.cameras)
		CL += C

	var/output = {"<B>CAMERA ANOMALIES REPORT</B><HR>
<B>The following anomalies have been detected. The ones in red need immediate attention: Some of those in black may be intentional.</B><BR><ul>"}

	for(var/obj/machinery/camera/C1 in CL)
		for(var/obj/machinery/camera/C2 in CL)
			if(C1 != C2)
				if(C1.c_tag == C2.c_tag)
					output += "<li><font color='red'>c_tag match for sec. cameras at \[[C1.x], [C1.y], [C1.z]\] ([C1.loc.loc]) and \[[C2.x], [C2.y], [C2.z]\] ([C2.loc.loc]) - c_tag is [C1.c_tag]</font></li>"
				if(C1.loc == C2.loc && C1.dir == C2.dir && C1.pixel_x == C2.pixel_x && C1.pixel_y == C2.pixel_y)
					output += "<li><font color='red'>FULLY overlapping sec. cameras at \[[C1.x], [C1.y], [C1.z]\] ([C1.loc.loc]) Networks: [C1.network] and [C2.network]</font></li>"
				if(C1.loc == C2.loc)
					output += "<li>overlapping sec. cameras at \[[C1.x], [C1.y], [C1.z]\] ([C1.loc.loc]) Networks: [C1.network] and [C2.network]</font></li>"
		var/turf/T = get_step(C1,turn(C1.dir,180))
		if(!T || !isturf(T) || !T.density)
			if(!(locate(/obj/structure/grille,T)))
				var/window_check = 0
				for(var/obj/structure/window/W in T)
					if(W.dir == turn(C1.dir,180) || W.fulltile)
						window_check = 1
						break
				if(!window_check)
					output += "<li><font color='red'>Camera not connected to wall at \[[C1.x], [C1.y], [C1.z]\] ([C1.loc.loc]) Network: [C1.network]</color></li>"

	output += "</ul>"
	client << browse(output,"window=airreport;size=1000x500")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Camera Report") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(debug_view_intercoms, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(debug_view_intercoms, R_DEBUG, "Intercom Range Display", "Intercom Range Display", VERB_CATEGORY_MAPPING)
	if(GLOB.intercom_range_display_status)
		GLOB.intercom_range_display_status = 0
	else
		GLOB.intercom_range_display_status = 1

	for(var/obj/effect/debugging/marker/M in world)
		qdel(M)

	if(GLOB.intercom_range_display_status)
		for(var/obj/item/radio/intercom/I in GLOB.global_radios)
			for(var/turf/T in orange(7,I))
				var/obj/effect/debugging/marker/F = new/obj/effect/debugging/marker(T)
				if(!(F in view(7,I.loc)))
					qdel(F)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Intercom Range Display") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(debug_object_count_zlevel, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(debug_object_count_zlevel, R_DEBUG, "Count Objects On Level", "Count Objects On Level", VERB_CATEGORY_MAPPING)
	var/level = clean_input("Which z-level?","Level?", user = client)
	if(!level) return
	var/num_level = text2num(level)
	if(!num_level) return
	if(!isnum(num_level)) return

	var/type_text = clean_input("Which type path?","Path?", user = client)
	if(!type_text) return
	var/type_path = text2path(type_text)
	if(!type_path) return

	var/count = 0

	var/list/atom/atom_list = list()

	for(var/atom/A in world)
		if(istype(A,type_path))
			var/atom/B = A
			while(!(isturf(B.loc)))
				if(B && B.loc)
					B = B.loc
				else
					break
			if(B)
				if(B.z == num_level)
					count++
					atom_list += A

	to_chat(world, "There are [count] objects of type [type_path] on z-level [num_level].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Count Objects (On Level)") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(debug_object_count_world, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(debug_object_count_world, R_DEBUG, "Count Objects All", "Count Objects All", VERB_CATEGORY_MAPPING)
	var/type_text = clean_input("Which type path?","", user = client)
	if(!type_text) return
	var/type_path = text2path(type_text)
	if(!type_path) return

	var/count = 0

	for(var/atom/A in world)
		if(istype(A,type_path))
			count++

	to_chat(world, "There are [count] objects of type [type_path] in the game world.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Count Objects (Global)") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(mapping_area_test, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(mapping_area_test, R_DEBUG, "Test areas", "Run mapping area test", VERB_CATEGORY_MAPPING)
	var/list/areas_all = list()
	var/list/areas_with_APC = list()
	var/list/areas_with_air_alarm = list()
	var/list/areas_with_RC = list()
	var/list/areas_with_light = list()
	var/list/areas_with_LS = list()
	var/list/areas_with_intercom = list()
	var/list/areas_with_camera = list()

	var/list/areas_with_multiple_APCs = list()
	var/list/areas_with_multiple_air_alarms = list()

	for(var/area/A in world)
		areas_all |= A.type

	for(var/thing in GLOB.apcs)
		var/obj/machinery/power/apc/APC = thing
		var/area/A = get_area(APC)
		if(!A)
			continue
		if(!(A.type in areas_with_APC))
			areas_with_APC |= A.type
		else
			areas_with_multiple_APCs |= A.type

	for(var/thing in GLOB.air_alarms)
		var/obj/machinery/alarm/alarm = thing
		var/area/A = get_area(alarm)
		if(!A)
			continue
		if(!(A.type in areas_with_air_alarm))
			areas_with_air_alarm |= A.type
		else
			areas_with_multiple_air_alarms |= A.type

	for(var/obj/machinery/requests_console/RC in SSmachines.get_by_type(/obj/machinery/requests_console))
		var/area/A = get_area(RC)
		if(!A)
			continue
		areas_with_RC |= A.type

	for(var/obj/machinery/light/L in SSmachines.get_by_type(/obj/machinery/light))
		var/area/A = get_area(L)
		if(!A)
			continue
		areas_with_light |= A.type

	for(var/obj/machinery/light_switch/LS in SSmachines.get_by_type(/obj/machinery/light_switch))
		var/area/A = get_area(LS)
		if(!A)
			continue
		areas_with_LS |= A.type

	for(var/obj/item/radio/intercom/I in SSmachines.get_by_type(/obj/item/radio/intercom))
		var/area/A = get_area(I)
		if(!A)
			continue
		areas_with_intercom |= A.type

	for(var/obj/machinery/camera/C in SSmachines.get_by_type(/obj/machinery/camera))
		var/area/A = get_area(C)
		if(!A)
			continue
		areas_with_camera |= A.type

	var/list/areas_without_APC = areas_all - areas_with_APC
	var/list/areas_without_air_alarm = areas_all - areas_with_air_alarm
	var/list/areas_without_RC = areas_all - areas_with_RC
	var/list/areas_without_light = areas_all - areas_with_light
	var/list/areas_without_LS = areas_all - areas_with_LS
	var/list/areas_without_intercom = areas_all - areas_with_intercom
	var/list/areas_without_camera = areas_all - areas_with_camera

	to_chat(world, "<b>AREAS WITHOUT AN APC:</b>")
	for(var/areatype in areas_without_APC)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITHOUT AN AIR ALARM:</b>")
	for(var/areatype in areas_without_air_alarm)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITH TOO MANY APCS:</b>")
	for(var/areatype in areas_with_multiple_APCs)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITH TOO MANY AIR ALARMS:</b>")
	for(var/areatype in areas_with_multiple_air_alarms)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITHOUT A REQUEST CONSOLE:</b>")
	for(var/areatype in areas_without_RC)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITHOUT ANY LIGHTS:</b>")
	for(var/areatype in areas_without_light)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITHOUT A LIGHT SWITCH:</b>")
	for(var/areatype in areas_without_LS)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITHOUT ANY INTERCOMS:</b>")
	for(var/areatype in areas_without_intercom)
		to_chat(world, "* [areatype]")

	to_chat(world, "<b>AREAS WITHOUT ANY CAMERAS:</b>")
	for(var/areatype in areas_without_camera)
		to_chat(world, "* [areatype]")
