ADMIN_VERB_VISIBILITY(mapping_area_test, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(mapping_area_test, R_DEBUG, "Test areas", "Run mapping area test", VERB_CATEGORY_MAPPING)
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

//- Are all the floors with or without air, as they should be? (regular or airless)
//- Does the area have an APC?
//- Does the area have an Air Alarm?
//- Does the area have a Request Console?
//- Does the area have lights?
//- Does the area have a light switch?
//- Does the area have enough intercoms?
//- Does the area have enough security cameras? (Use the 'Camera Range Display' verb under Debug)
//- Is the area connected to the scrubbers air loop?
//- Is the area connected to the vent air loop? (vent pumps)
//- Is everything wired properly?
//- Does the area have a fire alarm and firedoors?
//- Do all pod doors work properly?
//- Are accesses set properly on doors, pod buttons, etc.
//- Are all items placed properly? (not below vents, scrubbers, tables)
//- Does the disposal system work properly from all the disposal units in this room and all the units, the pipes of which pass through this room?
//- Check for any misplaced or stacked piece of pipe (air and disposal)
//- Check for any misplaced or stacked piece of wire
//- Identify how hard it is to break into the area and where the weak points are
//- Check if the area has too much empty space. If so, make it smaller and replace the rest with maintenance tunnels.

GLOBAL_VAR_INIT(camera_range_display_status, 0)
GLOBAL_VAR_INIT(intercom_range_display_status, 0)

/obj/effect/debugging/mapfix_marker
	name = "map fix marker"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "mapfixmarker"
	desc = "I am a mappers mistake."

/obj/effect/debugging/marker
	icon = 'icons/turf/areas.dmi'
	icon_state = "yellow"

/obj/effect/debugging/marker/Move()
	return 0

ADMIN_VERB_VISIBILITY(debug_camera_view, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(debug_camera_view, R_DEBUG, "Camera Range Display", "Camera Range Display", VERB_CATEGORY_MAPPING)
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

	BLACKBOX_LOG_ADMIN_VERB("Camera Range Display")

ADMIN_VERB_VISIBILITY(debug_camera_report, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(debug_camera_report, R_DEBUG, "Camera Report", "Camera Report", VERB_CATEGORY_MAPPING)
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
	user << browse(output,"window=airreport;size=1000x500")
	BLACKBOX_LOG_ADMIN_VERB("Camera Report")

ADMIN_VERB_VISIBILITY(debug_view_intercoms, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(debug_view_intercoms, R_DEBUG, "Intercom Range Display", "Intercom Range Display", VERB_CATEGORY_MAPPING)
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

ADMIN_VERB_VISIBILITY(debug_object_count_zlevel, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(debug_object_count_zlevel, R_DEBUG, "Count Objects On Level", "Count Objects On Level", VERB_CATEGORY_MAPPING)
	var/level = clean_input("Which z-level?","Level?")
	if(!level) return
	var/num_level = text2num(level)
	if(!num_level) return
	if(!isnum(num_level)) return

	var/type_text = clean_input("Which type path?","Path?")
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
	BLACKBOX_LOG_ADMIN_VERB("Count Objects (On Level)")

ADMIN_VERB_VISIBILITY(debug_object_count_world, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(debug_object_count_world, R_DEBUG, "Count Objects All", "Count Objects All", VERB_CATEGORY_MAPPING)
	var/type_text = clean_input("Which type path?","")
	if(!type_text) return
	var/type_path = text2path(type_text)
	if(!type_path) return

	var/count = 0

	for(var/atom/A in world)
		if(istype(A,type_path))
			count++

	to_chat(world, "There are [count] objects of type [type_path] in the game world.")
	BLACKBOX_LOG_ADMIN_VERB("Count Objects (Global)")
