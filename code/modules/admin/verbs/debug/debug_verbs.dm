// Would be nice to make this a permanent admin pref so we don't need to click it each time
USER_VERB(enable_debug_verbs, R_DEBUG, "Debug verbs", "Enable all debug verbs.", VERB_CATEGORY_DEBUG)
	SSuser_verbs.update_visibility_flag(client, VERB_VISIBILITY_FLAG_MOREDEBUG, TRUE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Debug Verbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(disable_debug_verbs, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(disable_debug_verbs, R_DEBUG, "Debug verbs", "Disable all debug verbs.", VERB_CATEGORY_DEBUG)
	SSuser_verbs.update_visibility_flag(client, VERB_VISIBILITY_FLAG_MOREDEBUG, FALSE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Debug Verbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(assume_direct_control, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(assume_direct_control, R_ADMIN|R_DEBUG, "Assume direct control", "Direct intervention", VERB_CATEGORY_ADMIN, mob/M in GLOB.mob_list)
	if(M.ckey)
		if(alert(client, "This mob is being controlled by [M.ckey]. Are you sure you wish to assume control of it? [M.ckey] will be made a ghost.", null,"Yes","No") != "Yes")
			return
		else
			var/mob/dead/observer/ghost = new/mob/dead/observer(M,1)
			ghost.ckey = M.ckey
	message_admins(SPAN_NOTICE("[key_name_admin(client)] assumed direct control of [M]."), 1)
	log_admin("[key_name(client)] assumed direct control of [M].")
	var/mob/adminmob = client.mob
	M.ckey = client.ckey
	if(isobserver(adminmob))
		qdel(adminmob)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Assume Direct Control") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(air_status, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(air_status, R_DEBUG, "Air Status in Location", "Print out the local air contents.", VERB_CATEGORY_DEBUG)
	if(!client.mob)
		return
	var/turf/T = client.mob.loc

	if(!isturf(T))
		return

	var/datum/gas_mixture/env = T.get_readonly_air()

	var/t = ""
	t+= "Nitrogen : [env.nitrogen()]\n"
	t+= "Oxygen : [env.oxygen()]\n"
	t+= "Plasma : [env.toxins()]\n"
	t+= "CO2: [env.carbon_dioxide()]\n"

	usr.show_message(t, 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Air Status (Location)") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(delete_singulo, R_DEBUG, "Del Singulo / Tesla", "Delete all singularities and tesla balls.", VERB_CATEGORY_DEBUG)
	//This gets a confirmation check because it's way easier to accidentally hit this and delete things than it is with qdel-all
	var/confirm = alert(client, "This will delete ALL Singularities and Tesla orbs except for any that are on away mission z-levels or the centcomm z-level. Are you sure you want to delete them?", "Confirm Panic Button", "Yes", "No")
	if(confirm != "Yes")
		return

	for(var/I in GLOB.singularities)
		var/obj/singularity/S = I
		if(!is_level_reachable(S.z))
			continue
		qdel(S)
	log_admin("[key_name(client)] has deleted all Singularities and Tesla orbs.")
	message_admins("[key_name_admin(client)] has deleted all Singularities and Tesla orbs.", 0)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Del Singulo/Tesla") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(debug_statpanel, R_DEBUG, "Debug Stat Panel", "Toggles local debug of the stat panel", VERB_CATEGORY_DEBUG)
	client.stat_panel.send_message("create_debug")

USER_VERB(profile_code, R_DEBUG|R_VIEWRUNTIMES, "Profile Code", "View code profiler", VERB_CATEGORY_DEBUG)
	winset(client, null, "command=.profile")

USER_VERB(make_powernets, R_DEBUG, "Make Powernets", "Remake all powernets.", VERB_CATEGORY_DEBUG)
	SSmachines.makepowernets()
	log_admin("[key_name(client)] has remade the powernet. makepowernets() called.")
	message_admins("[key_name_admin(client)] has remade the powernets. makepowernets() called.", 0)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Powernets") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(raw_gas_scan, R_DEBUG|R_VIEWRUNTIMES, "Raw Gas Scan", "Scans your current tile, including LINDA data not normally displayed.", VERB_CATEGORY_DEBUG)
	atmos_scan(client.mob, get_turf(client.mob), silent = TRUE, milla_turf_details = TRUE)

USER_VERB(find_interesting_turf, R_DEBUG|R_VIEWRUNTIMES, "Interesting Turf", \
		"Teleports you to a random Interesting Turf from MILLA", VERB_CATEGORY_DEBUG)
	if(!isobserver(client.mob))
		to_chat(client.mob, SPAN_WARNING("You must be an observer to do this!"))
		return

	var/list/interesting_tile = get_random_interesting_tile()
	if(!length(interesting_tile))
		to_chat(client, SPAN_NOTICE("There are no interesting turfs. How interesting!"))
		return

	var/turf/T = interesting_tile[MILLA_INDEX_TURF]
	var/mob/dead/observer/O = client.mob
	admin_forcemove(O, T)
	O.manual_follow(T)

USER_VERB(visualize_interesting_turfs, R_DEBUG|R_VIEWRUNTIMES, "Visualize Interesting Turfs", "Shows all the Interesting Turfs from MILLA", VERB_CATEGORY_DEBUG)
	if(SSair.interesting_tile_count > 500)
		// This can potentially iterate through a list thats 20k things long. Give ample warning to the user
		if(tgui_alert(client, "WARNING: There are [SSair.interesting_tile_count] Interesting Turfs. This process will be lag intensive and should only be used if the atmos controller \
			is screaming bloody murder. Are you sure you with to continue", "WARNING", list("I am sure", "Nope")) != "I am sure")
			return
	else
		if(tgui_alert(client, "Visualizing turfs may cause server to lag. Are you sure?", "Warning", list("Yes", "No")) != "Yes")
			return

	var/display_turfs_overlay = FALSE
	if(tgui_alert(client, "Would you like to have all interesting turfs have a client side overlay applied as well?", "Optional", list("Yes", "No")) == "Yes")
		display_turfs_overlay = TRUE

	message_admins("[key_name_admin(client)] is visualizing interesting atmos turfs. Server may lag.")

	var/list/zlevel_turf_indexes = list()

	var/list/coords = get_interesting_atmos_tiles()
	if(!length(coords))
		to_chat(client, SPAN_NOTICE("There are no interesting turfs. How interesting!"))
		return

	while(length(coords))
		var/offset = length(coords) - MILLA_INTERESTING_TILE_SIZE
		var/turf/T = coords[offset + MILLA_INDEX_TURF]
		coords.len -= MILLA_INTERESTING_TILE_SIZE


		// ENSURE YOU USE STRING NUMBERS HERE, THIS IS A DICTIONARY KEY NOT AN INDEX!!!
		if(!zlevel_turf_indexes["[T.z]"])
			zlevel_turf_indexes["[T.z]"] = list()
		zlevel_turf_indexes["[T.z]"] |= T
		if(display_turfs_overlay)
			client.images += image('icons/effects/alphacolors.dmi', T, "red")
		CHECK_TICK

	// Sort the keys
	zlevel_turf_indexes = sortAssoc(zlevel_turf_indexes)

	for(var/key in zlevel_turf_indexes)
		to_chat(client, SPAN_NOTICE("Z[key]: <b>[length(zlevel_turf_indexes["[key]"])] Interesting Turfs</b>"))

	var/z_to_view = tgui_input_number(client, "A list of z-levels their ITs has appeared in chat. Please enter a Z to visualize. Enter 0 or close the window to cancel", "Selection", 0)

	if(!z_to_view)
		return

	// Do not combine these
	var/list/ui_dat = list()
	var/list/turf_markers = list()

	var/datum/browser/vis = new(client, "atvis", "Interesting Turfs (Z[z_to_view])", 300, 315)
	ui_dat += "<center><canvas width=\"255px\" height=\"255px\" id=\"atmos\"></canvas></center>"
	ui_dat += "<script>e=document.getElementById(\"atmos\");c=e.getContext('2d');c.fillStyle='#ffffff';c.fillRect(0,0,255,255);function s(x,y){var p=c.createImageData(1,1);p.data\[0]=255;p.data\[1]=0;p.data\[2]=0;p.data\[3]=255;c.putImageData(p,(x-1),255-Math.abs(y-1));}</script>"
	// Now generate the other list
	for(var/x in zlevel_turf_indexes["[z_to_view]"])
		var/turf/T = x
		turf_markers += "s([T.x],[T.y]);"
		CHECK_TICK

	ui_dat += "<script>[turf_markers.Join("")]</script>"

	vis.set_content(ui_dat.Join(""))
	vis.open(FALSE)

USER_VERB(deadmin_self, R_ADMIN|R_MENTOR, "De-admin self", "De-admin yourself.", VERB_CATEGORY_ADMIN)
	log_admin("[key_name(client)] deadmined themself.")
	message_admins("[key_name_admin(client)] deadmined themself.")
	client.deadmin()
	to_chat(client, SPAN_INTERFACE("You are now a normal player."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "De-admin") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(debug_mob_lists, R_DEBUG, "Debug Mob Lists", "For when you just gotta know", VERB_CATEGORY_DEBUG)
	switch(input(client, "Which list?") in list("Players", "Admins", "Mobs", "Living Mobs", "Alive Mobs", "Dead Mobs", "Silicons", "Clients", "Respawnable Mobs"))
		if("Players")
			to_chat(client, jointext(GLOB.player_list, ","))
		if("Admins")
			to_chat(client, jointext(GLOB.admins, ","))
		if("Mobs")
			to_chat(client, jointext(GLOB.mob_list, ","))
		if("Living Mobs")
			to_chat(client, jointext(GLOB.mob_living_list, ","))
		if("Alive Mobs")
			to_chat(client, jointext(GLOB.alive_mob_list, ","))
		if("Dead Mobs")
			to_chat(client, jointext(GLOB.dead_mob_list, ","))
		if("Silicons")
			to_chat(client, jointext(GLOB.silicon_mob_list, ","))
		if("Clients")
			to_chat(client, jointext(GLOB.clients, ","))
		if("Respawnable Mobs")
			var/list/respawnable_mobs
			for(var/mob/potential_respawnable in GLOB.player_list)
				if(HAS_TRAIT(potential_respawnable, TRAIT_RESPAWNABLE))
					respawnable_mobs += potential_respawnable
			to_chat(client, jointext(respawnable_mobs, ", "))

USER_VERB(display_del_log, R_DEBUG|R_VIEWRUNTIMES, "Display del() Log", "Display del's log of everything that's passed through it.", VERB_CATEGORY_DEBUG)
	var/list/dellog = list("<B>List of things that have gone through qdel this round</B><BR><BR><ol>")
	sortTim(SSgarbage.items, GLOBAL_PROC_REF(cmp_qdel_item_time), TRUE)
	for(var/path in SSgarbage.items)
		var/datum/qdel_item/I = SSgarbage.items[path]
		dellog += "<li><u>[path]</u><ul>"
		if(I.failures)
			dellog += "<li>Failures: [I.failures]</li>"
		dellog += "<li>qdel() Count: [I.qdels]</li>"
		dellog += "<li>Destroy() Cost: [I.destroy_time]ms</li>"
		if(I.hard_deletes)
			dellog += "<li>Total Hard Deletes [I.hard_deletes]</li>"
			dellog += "<li>Time Spent Hard Deleting: [I.hard_delete_time]ms</li>"
			dellog += "<li>Average References During Hardel: [I.reference_average] references.</li>"
		if(I.slept_destroy)
			dellog += "<li>Sleeps: [I.slept_destroy]</li>"
		if(I.no_respect_force)
			dellog += "<li>Ignored force: [I.no_respect_force]</li>"
		if(I.no_hint)
			dellog += "<li>No hint: [I.no_hint]</li>"
		dellog += "</ul></li>"

	dellog += "</ol>"

	client << browse(dellog.Join(), "window=dellog")

USER_VERB(display_del_log_simple, R_DEBUG|R_VIEWRUNTIMES, "Display Simple del() Log", \
		"Display a compacted del's log.", VERB_CATEGORY_DEBUG)
	var/dat = "<B>List of things that failed to GC this round</B><BR><BR>"
	for(var/path in SSgarbage.items)
		var/datum/qdel_item/I = SSgarbage.items[path]
		if(I.failures)
			dat += "[I] - [I.failures] times<BR>"

	dat += "<B>List of paths that did not return a qdel hint in Destroy()</B><BR><BR>"
	for(var/path in SSgarbage.items)
		var/datum/qdel_item/I = SSgarbage.items[path]
		if(I.no_hint)
			dat += "[I]<BR>"

	dat += "<B>List of paths that slept in Destroy()</B><BR><BR>"
	for(var/path in SSgarbage.items)
		var/datum/qdel_item/I = SSgarbage.items[path]
		if(I.slept_destroy)
			dat += "[I]<BR>"

	client << browse(dat, "window=simpledellog")

USER_VERB(show_gc_queues, R_DEBUG|R_VIEWRUNTIMES, "View GC Queue", \
		"Shows the list of whats currently in a GC queue", VERB_CATEGORY_DEBUG)
	// Get the amount of queues
	var/queue_count = length(SSgarbage.queues)
	var/list/selectable_queues = list()
	// Setup choices
	for(var/i in 1 to queue_count)
		selectable_queues["Queue #[i] ([length(SSgarbage.queues[i])] item\s)"] = i

	// Ask the user
	var/choice = input(client, "Select a GC queue. Note that the queue lookup may lag the server.", "GC Queue") as null|anything in selectable_queues
	if(!choice)
		return

	// Get our target
	var/list/target_queue = SSgarbage.queues[selectable_queues[choice]]
	var/list/queue_counts = list()

	// Iterate that target and see whats what
	for(var/queue_entry in target_queue)
		var/datum/D = locate(queue_entry[GC_QUEUE_ITEM_REF])
		if(!istype(D))
			continue

		if(!queue_counts[D.type])
			queue_counts[D.type] = 0

		queue_counts[D.type]++

	// Sort it the right way
	var/list/sorted = sortTim(queue_counts, GLOBAL_PROC_REF(cmp_numeric_dsc), TRUE)

	// And make a nice little menu
	var/list/text = list("<h1>Current status of [choice]</h1>", "<ul>")
	for(var/key in sorted)
		text += "<li>[key] - [sorted[key]]</li>"

	text += "</ul>"
	client << browse(text.Join(), "window=gcqueuestatus")

USER_VERB_VISIBILITY(start_singulo, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(start_singulo, R_DEBUG, "Start Singularity", "Sets up the singularity and all machines to get power flowing through the station", VERB_CATEGORY_DEBUG)
	if(alert(client, "Are you sure? This will start up the engine. Should only be used during debug!", null,"Yes","No") != "Yes")
		return

	for(var/obj/machinery/power/emitter/E in SSmachines.get_by_type(/obj/machinery/power/emitter))
		if(E.anchored)
			E.active = TRUE

	for(var/obj/machinery/field/generator/F in SSmachines.get_by_type(/obj/machinery/field/generator))
		if(!F.active)
			F.active = TRUE
			F.state = 2
			F.energy = 125
			F.anchored = TRUE
			F.warming_up = 3
			F.start_fields()
			F.update_icon()

	spawn(30)
		for(var/obj/machinery/the_singularitygen/G in SSmachines.get_by_type(/obj/machinery/the_singularitygen))
			if(G.anchored)
				var/obj/singularity/S = new /obj/singularity(get_turf(G))
				S.energy = 800
				break

	for(var/obj/machinery/power/rad_collector/Rad in SSmachines.get_by_type(/obj/machinery/power/rad_collector))
		if(Rad.anchored)
			if(!Rad.loaded_tank)
				var/obj/item/tank/internals/plasma/Plasma = new/obj/item/tank/internals/plasma(Rad)
				Plasma.air_contents.set_toxins(70)
				Rad.drainratio = 0
				Rad.loaded_tank = Plasma
				Plasma.loc = Rad

			if(!Rad.active)
				Rad.toggle_power()

	for(var/obj/machinery/power/smes/SMES in SSmachines.get_by_type(/obj/machinery/power/smes))
		if(SMES.anchored)
			SMES.input_attempt = 1

USER_VERB(advanced_proccall, R_PROCCALL, "Advanced ProcCall", "Advanced ProcCall", VERB_CATEGORY_DEBUG)
	spawn(0)
		var/target = null
		var/targetselected = 0
		var/returnval = null
		var/class = null

		switch(alert(client, "Proc owned by something?", null,"Yes","No"))
			if("Yes")
				targetselected = 1
				if(client.holder && client.holder.marked_datum)
					class = input(client, "Proc owned by...","Owner",null) as null|anything in list("Obj","Mob","Area or Turf","Client","Marked datum ([client.holder.marked_datum.type])")
					if(class == "Marked datum ([client.holder.marked_datum.type])")
						class = "Marked datum"
				else
					class = input(client, "Proc owned by...","Owner",null) as null|anything in list("Obj","Mob","Area or Turf","Client")
				switch(class)
					if("Obj")
						target = input(client, "Enter target:","Target",usr) as obj in world
					if("Mob")
						target = input(client, "Enter target:","Target",usr) as mob in world
					if("Area or Turf")
						target = input(client, "Enter target:","Target",usr.loc) as area|turf in world
					if("Client")
						var/list/keys = list()
						for(var/client/C)
							keys += C
						target = input(client, "Please, select a player!", "Selection", null) as null|anything in keys
					if("Marked datum")
						target = client.holder.marked_datum
					else
						return
			if("No")
				target = null
				targetselected = 0

		var/procname = clean_input("Proc path, eg: /proc/fake_blood","Path:", null, user = client)
		if(!procname)	return

		// absolutely not
		if(findtextEx(trim(lowertext(procname)), "rustg"))
			message_admins(SPAN_USERDANGER("[key_name_admin(client)] attempted to proc call rust-g procs. Inform the host <u>at once</u>."))
			log_admin("[key_name(client)] attempted to proc call rust-g procs. Inform the host at once.")
			GLOB.discord_manager.send2discord_simple(DISCORD_WEBHOOK_ADMIN, "[key_name(client)] attempted to proc call rustg things. Inform the host at once.")
			return

		if(targetselected && !hascall(target,procname))
			to_chat(client, "<font color='red'>Error: callproc(): target has no such call [procname].</font>")
			return

		var/list/lst = client.get_callproc_args()
		if(!lst)
			return

		if(targetselected)
			if(!target)
				to_chat(client, "<font color='red'>Error: callproc(): owner of proc no longer exists.</font>")
				return
			message_admins("[key_name_admin(client)] called [target]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"].")
			log_admin("[key_name(client)] called [target]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"].")
			returnval = WrapAdminProcCall(target, procname, lst) // Pass the lst as an argument list to the proc
		else
			//this currently has no hascall protection. wasn't able to get it working.
			message_admins("[key_name_admin(client)] called [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")
			log_admin("[key_name(client)] called [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")
			returnval = WrapAdminProcCall(GLOBAL_PROC, procname, lst) // Pass the lst as an argument list to the proc

		to_chat(client, "<font color='#EB4E00'>[procname] returned: [!isnull(returnval) ? returnval : "null"]</font>")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Advanced Proc-Call") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(view_runtimes, R_DEBUG|R_VIEWRUNTIMES, "View Runtimes", "Open the Runtime Viewer", VERB_CATEGORY_DEBUG)
	GLOB.error_cache.showTo(client)

USER_VERB(allow_browser_inspect, R_DEBUG, "Allow Browser Inspect", "Allow browser debugging via inspect", VERB_CATEGORY_DEBUG)
	if(client.byond_version < 516)
		to_chat(client, SPAN_WARNING("You can only use this on 516!"))
		return

	to_chat(client, SPAN_NOTICE("You can now right click to use inspect on browsers."))
	winset(client, "", "browser-options=byondstorage,find,devtools")

USER_VERB_VISIBILITY(debug_clean_radiation, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(debug_clean_radiation, R_DEBUG, "Remove All Radiation", "Remove all radiation in the world.", VERB_CATEGORY_DEBUG)
	if(alert(client, "Are you sure you want to remove all radiation in the world? This may lag the server. Alternatively, use the radiation cleaning buildmode.", "Lag warning", "Yes, I'm sure", "No, I want to live") != "Yes, I'm sure")
		return

	log_and_message_admins("is decontaminating the world of all radiation. (This may be laggy!)")

	var/counter = 0
	for(var/datum/component/radioactive/rad as anything in SSradiation.all_radiations)
		rad.admin_decontaminate()
		counter++
		CHECK_TICK

	log_and_message_admins_no_usr("The world has been decontaminated of [counter] radiation components.")

USER_VERB(view_bug_reports, R_DEBUG|R_VIEWRUNTIMES|R_ADMIN, "View Bug Reports", "Select a bug report to view", VERB_CATEGORY_DEBUG)
	if(!length(GLOB.bug_reports))
		to_chat(client, SPAN_WARNING("There are no bug reports to view"))
		return
	var/list/bug_report_selection = list()
	for(var/datum/tgui_bug_report_form/report in GLOB.bug_reports)
		bug_report_selection["[report.initial_key] - [report.bug_report_data["title"]]"] = report
	var/datum/tgui_bug_report_form/form = bug_report_selection[tgui_input_list(client, "Select a report to view:", "Bug Reports", bug_report_selection)]
	if(!form?.assign_approver(client.mob))
		return
	form.ui_interact(client.mob)

//Debug procs
USER_VERB(test_movable_ui, R_DEBUG, "Spawn Movable UI Object", "Spawn Movable UI Object", VERB_CATEGORY_DEBUG)
	var/atom/movable/screen/movable/M = new()
	M.name = "Movable UI Object"
	M.icon_state = "block"
	M.maptext = "Movable"
	M.maptext_width = 64

	var/screen_l = input(client, "Where on the screen? (Formatted as 'X,Y' e.g: '1,1' for bottom left)","Spawn Movable UI Object") as text
	if(!screen_l)
		return

	M.screen_loc = screen_l
	client.screen += M

USER_VERB(test_snap_ui, R_DEBUG, "Spawn Snap UI Object", "Spawn Snap UI Object", VERB_CATEGORY_DEBUG)
	var/atom/movable/screen/movable/snap/S = new()
	S.name = "Snap UI Object"
	S.icon_state = "block"
	S.maptext = "Snap"
	S.maptext_width = 64

	var/screen_l = input(client, "Where on the screen? (Formatted as 'X,Y' e.g: '1,1' for bottom left)","Spawn Snap UI Object") as text
	if(!screen_l)
		return

	S.screen_loc = screen_l
	client.screen += S

USER_VERB(show_cinematic, R_MAINTAINER, "Cinematic", "Shows a cinematic.", VERB_CATEGORY_HIDDEN, cinematic as anything in list("explosion", null))
	if(SSticker.current_state < GAME_STATE_PREGAME)
		return

	switch(cinematic)
		if("explosion")
			var/parameter = input(client, "station_missed = ?", "Enter Parameter", 0) as num
			var/override
			switch(parameter)
				if(1)
					override = input(client, "mode = ?","Enter Parameter", null) as anything in list("nuclear emergency", "fake", "no override")
				if(0)
					override = input(client, "mode = ?","Enter Parameter", null) as anything in list("blob", "nuclear emergency", "AI malfunction", "no override")
			SSticker.station_explosion_cinematic(parameter, override)

USER_VERB(set_ticklag, R_MAINTAINER, "Set Ticklag", \
		"Sets a new tick lag. Recommend you don't mess with this too much! Stable, time-tested ticklag value is 0.9", \
		VERB_CATEGORY_DEBUG)
	var/newtick = input(client, "Sets a new tick lag. Please don't mess with this too much! The stable, time-tested ticklag value is 0.9","Lag of Tick", world.tick_lag) as num|null
	//I've used ticks of 2 before to help with serious singulo lags
	if(newtick && newtick <= 2 && newtick > 0)
		log_admin("[key_name(client)] has modified world.tick_lag to [newtick]", 0)
		message_admins("[key_name_admin(client)] has modified world.tick_lag to [newtick]", 0)
		world.tick_lag = newtick
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Set Ticklag") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	else
		to_chat(client, SPAN_WARNING("Error: ticklag(): Invalid world.ticklag value. No changes made."))

/**
  * Opens a log of UIDs
  *
  * In-round ability to view what has created a UID, and how many times a UID for that path has been declared
  */
USER_VERB(uid_log, R_DEBUG, "View UID Log", "Shows the log of created UIDs this round", VERB_CATEGORY_DEBUG)
	var/list/sorted = sortTim(GLOB.uid_log, GLOBAL_PROC_REF(cmp_numeric_dsc), TRUE)
	var/list/text = list("<h1>UID Log</h1>", "<p>Current UID: [GLOB.next_unique_datum_id]</p>", "<ul>")
	for(var/key in sorted)
		text += "<li>[key] - [sorted[key]]</li>"

	text += "</ul>"
	client << browse(text.Join(), "window=uidlog")

USER_VERB(debug_global_variables, R_ADMIN|R_VIEWRUNTIMES, "Debug Global Variables", "Debug Global Variables", VERB_CATEGORY_DEBUG, var_search as text)
	var_search = trim(var_search)
	if(!var_search)
		return
	if(!GLOB.can_vv_get(var_search))
		return
	switch(var_search)
		if("vars")
			return FALSE
	if(!(var_search in GLOB.vars))
		to_chat(client, SPAN_DEBUG("GLOB.[var_search] does not exist."))
		return
	log_and_message_admins("is debugging the Global Variables controller with the search term \"[var_search]\"")
	var/result = GLOB.vars[var_search]
	if(islist(result) || isclient(result) || istype(result, /datum))
		to_chat(client, SPAN_DEBUG("Now showing GLOB.[var_search]."))
		return client.debug_variables(result)
	to_chat(client, SPAN_DEBUG("GLOB.[var_search] returned [result]."))
