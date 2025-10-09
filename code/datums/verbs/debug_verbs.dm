ADMIN_VERB(debug_statpanel, R_DEBUG, "Debug Stat Panel", "Toggles local debug of the stat panel", VERB_CATEGORY_DEBUG)
	user.stat_panel.send_message("create_debug")

ADMIN_VERB(profile_code, R_DEBUG, "Debug Stat Panel", "View code profiler", VERB_CATEGORY_DEBUG)
	winset(user, null, "command=.profile")

ADMIN_VERB(raw_gas_scan, R_DEBUG|R_VIEWRUNTIMES, "Raw Gas Scan", "Scans your current tile, including LINDA data not normally displayed.", VERB_CATEGORY_DEBUG)
	atmos_scan(user.mob, get_turf(user.mob), silent = TRUE, milla_turf_details = TRUE)

ADMIN_VERB(find_interesting_turf, R_DEBUG|R_VIEWRUNTIMES, "Interesting Turf", \
		"Teleports you to a random Interesting Turf from MILLA", VERB_CATEGORY_DEBUG)
	if(!isobserver(user.mob))
		to_chat(user.mob, "<span class='warning'>You must be an observer to do this!</span>")
		return

	var/list/interesting_tile = get_random_interesting_tile()
	if(!length(interesting_tile))
		to_chat(user, "<span class='notice'>There are no interesting turfs. How interesting!</span>")
		return

	var/turf/T = interesting_tile[MILLA_INDEX_TURF]
	var/mob/dead/observer/O = user.mob
	admin_forcemove(O, T)
	O.manual_follow(T)

ADMIN_VERB(visualize_interesting_turfs, R_DEBUG|R_VIEWRUNTIMES, "Visualize Interesting Turfs", "Shows all the Interesting Turfs from MILLA", VERB_CATEGORY_DEBUG)
	if(SSair.interesting_tile_count > 500)
		// This can potentially iterate through a list thats 20k things long. Give ample warning to the user
		if(tgui_alert(user, "WARNING: There are [SSair.interesting_tile_count] Interesting Turfs. This process will be lag intensive and should only be used if the atmos controller \
			is screaming bloody murder. Are you sure you with to continue", "WARNING", list("I am sure", "Nope")) != "I am sure")
			return
	else
		if(tgui_alert(user, "Visualizing turfs may cause server to lag. Are you sure?", "Warning", list("Yes", "No")) != "Yes")
			return

	var/display_turfs_overlay = FALSE
	if(tgui_alert(user, "Would you like to have all interesting turfs have a client side overlay applied as well?", "Optional", list("Yes", "No")) != "No")
		display_turfs_overlay = TRUE

	message_admins("[key_name_admin(user)] is visualizing interesting atmos turfs. Server may lag.")

	var/list/zlevel_turf_indexes = list()

	var/list/coords = get_interesting_atmos_tiles()
	if(!length(coords))
		to_chat(user, "<span class='notice'>There are no interesting turfs. How interesting!</span>")
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
			user.images += image('icons/effects/alphacolors.dmi', T, "red")
		CHECK_TICK

	// Sort the keys
	zlevel_turf_indexes = sortAssoc(zlevel_turf_indexes)

	for(var/key in zlevel_turf_indexes)
		to_chat(user, "<span class='notice'>Z[key]: <b>[length(zlevel_turf_indexes["[key]"])] Interesting Turfs</b></span>")

	var/z_to_view = tgui_input_number(user, "A list of z-levels their ITs has appeared in chat. Please enter a Z to visualize. Enter 0 or close the window to cancel", "Selection", 0)

	if(!z_to_view)
		return

	// Do not combine these
	var/list/ui_dat = list()
	var/list/turf_markers = list()

	var/datum/browser/vis = new(user, "atvis", "Interesting Turfs (Z[z_to_view])", 300, 315)
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

ADMIN_VERB(spawn_atom, R_SPAWN, "Spawn", \
		"Spawn an atom. Append a period to the text in order to exclude subtypes of paths matching the input.", \
		VERB_CATEGORY_DEBUG, object as text)
	if(!object)
		return

	var/list/types = typesof(/atom)
	var/list/matches = list()

	var/include_subtypes = TRUE
	if(copytext(object, -1) == ".")
		include_subtypes = FALSE
		object = copytext(object, 1, -1)

	if(include_subtypes)
		for(var/path in types)
			if(findtext("[path]", object))
				matches += path
	else
		var/needle_length = length(object)
		for(var/path in types)
			if(copytext("[path]", -needle_length) == object)
				matches += path

	if(length(matches)==0)
		return

	var/chosen
	if(length(matches)==1)
		chosen = matches[1]
	else
		chosen = tgui_input_list(usr, "Select an Atom Type", "Spawn Atom", matches)
		if(!chosen)
			return

	if(ispath(chosen,/turf))
		var/turf/T = get_turf(usr.loc)
		T.ChangeTurf(chosen)
	else
		var/atom/A = new chosen(usr.loc)
		A.admin_spawned = TRUE

	log_admin("[key_name(usr)] spawned [chosen] at ([usr.x],[usr.y],[usr.z])")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Spawn Atom") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB_VISIBILITY(air_status, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(air_status, R_DEBUG, "Air Status in Location", "Print out the local air contents.", VERB_CATEGORY_DEBUG)
	if(!user.mob)
		return
	var/turf/T = user.mob.loc

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

ADMIN_VERB(delete_singulo, R_DEBUG, "Del Singulo / Tesla", "Delete all singularities and tesla balls.", VERB_CATEGORY_DEBUG)
	//This gets a confirmation check because it's way easier to accidentally hit this and delete things than it is with qdel-all
	var/confirm = alert(user, "This will delete ALL Singularities and Tesla orbs except for any that are on away mission z-levels or the centcomm z-level. Are you sure you want to delete them?", "Confirm Panic Button", "Yes", "No")
	if(confirm != "Yes")
		return

	for(var/I in GLOB.singularities)
		var/obj/singularity/S = I
		if(!is_level_reachable(S.z))
			continue
		qdel(S)
	log_admin("[key_name(user)] has deleted all Singularities and Tesla orbs.")
	message_admins("[key_name_admin(user)] has deleted all Singularities and Tesla orbs.", 0)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Del Singulo/Tesla") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB(make_powernets, R_DEBUG, "Make Powernets", "Remake all powernets.", VERB_CATEGORY_DEBUG)
	SSmachines.makepowernets()
	log_admin("[key_name(src)] has remade the powernet. makepowernets() called.")
	message_admins("[key_name_admin(src)] has remade the powernets. makepowernets() called.", 0)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Powernets") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB_VISIBILITY(start_singulo, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(start_singulo, R_DEBUG, "Start Singularity", "Sets up the singularity and all machines to get power flowing through the station", VERB_CATEGORY_DEBUG)
	if(alert(user, "Are you sure? This will start up the engine. Should only be used during debug!", null,"Yes","No") != "Yes")
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

ADMIN_VERB(debug_mob_lists, R_DEBUG, "Debug Mob Lists", "For when you just gotta know", VERB_CATEGORY_DEBUG)
	switch(input("Which list?") in list("Players", "Admins", "Mobs", "Living Mobs", "Alive Mobs", "Dead Mobs", "Silicons", "Clients", "Respawnable Mobs"))
		if("Players")
			to_chat(user, jointext(GLOB.player_list, ","))
		if("Admins")
			to_chat(user, jointext(GLOB.admins, ","))
		if("Mobs")
			to_chat(user, jointext(GLOB.mob_list, ","))
		if("Living Mobs")
			to_chat(user, jointext(GLOB.mob_living_list, ","))
		if("Alive Mobs")
			to_chat(user, jointext(GLOB.alive_mob_list, ","))
		if("Dead Mobs")
			to_chat(user, jointext(GLOB.dead_mob_list, ","))
		if("Silicons")
			to_chat(user, jointext(GLOB.silicon_mob_list, ","))
		if("Clients")
			to_chat(user, jointext(GLOB.clients, ","))
		if("Respawnable Mobs")
			var/list/respawnable_mobs
			for(var/mob/potential_respawnable in GLOB.player_list)
				if(HAS_TRAIT(potential_respawnable, TRAIT_RESPAWNABLE))
					respawnable_mobs += potential_respawnable
			to_chat(user, jointext(respawnable_mobs, ", "))

ADMIN_VERB(display_del_log, R_DEBUG|R_VIEWRUNTIMES, "Display del() Log", "Display del's log of everything that's passed through it.", VERB_CATEGORY_DEBUG)
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

	user << browse(dellog.Join(), "window=dellog")

ADMIN_VERB(display_del_log_simple, R_DEBUG|R_VIEWRUNTIMES, "Display Simple del() Log", \
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

	user << browse(dat, "window=simpledellog")

ADMIN_VERB(show_gc_queues, R_DEBUG|R_VIEWRUNTIMES, "View GC Queue", \
		"Shows the list of whats currently in a GC queue", VERB_CATEGORY_DEBUG)
	// Get the amount of queues
	var/queue_count = length(SSgarbage.queues)
	var/list/selectable_queues = list()
	// Setup choices
	for(var/i in 1 to queue_count)
		selectable_queues["Queue #[i] ([length(SSgarbage.queues[i])] item\s)"] = i

	// Ask the user
	var/choice = input(usr, "Select a GC queue. Note that the queue lookup may lag the server.", "GC Queue") as null|anything in selectable_queues
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
	user << browse(text.Join(), "window=gcqueuestatus")

// Would be nice to make this a permanent admin pref so we don't need to click it each time
ADMIN_VERB(enable_debug_verbs, R_DEBUG, "Debug verbs", "Enable all debug verbs.", VERB_CATEGORY_DEBUG)
	SSadmin_verbs.update_visibility_flag(user, VERB_VISIBILITY_FLAG_MOREDEBUG, TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Debug Verbs")

ADMIN_VERB_VISIBILITY(disable_debug_verbs, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(disable_debug_verbs, R_DEBUG, "Debug verbs", "Disable all debug verbs.", VERB_CATEGORY_DEBUG)
	SSadmin_verbs.update_visibility_flag(user, VERB_VISIBILITY_FLAG_MOREDEBUG, FALSE)
	BLACKBOX_LOG_ADMIN_VERB("Debug Verbs")

ADMIN_VERB(advanced_proccall, R_PROCCALL, "Advanced ProcCall", "Advanced ProcCall", VERB_CATEGORY_DEBUG)
	spawn(0)
		var/target = null
		var/targetselected = 0
		var/returnval = null
		var/class = null

		switch(alert("Proc owned by something?", null,"Yes","No"))
			if("Yes")
				targetselected = 1
				if(user.holder && user.holder.marked_datum)
					class = input("Proc owned by...","Owner",null) as null|anything in list("Obj","Mob","Area or Turf","Client","Marked datum ([user.holder.marked_datum.type])")
					if(class == "Marked datum ([user.holder.marked_datum.type])")
						class = "Marked datum"
				else
					class = input("Proc owned by...","Owner",null) as null|anything in list("Obj","Mob","Area or Turf","Client")
				switch(class)
					if("Obj")
						target = input("Enter target:","Target",usr) as obj in world
					if("Mob")
						target = input("Enter target:","Target",usr) as mob in world
					if("Area or Turf")
						target = input("Enter target:","Target",usr.loc) as area|turf in world
					if("Client")
						var/list/keys = list()
						for(var/client/C)
							keys += C
						target = input("Please, select a player!", "Selection", null, null) as null|anything in keys
					if("Marked datum")
						target = user.holder.marked_datum
					else
						return
			if("No")
				target = null
				targetselected = 0

		var/procname = clean_input("Proc path, eg: /proc/fake_blood","Path:", null)
		if(!procname)	return

		// absolutely not
		if(findtextEx(trim(lowertext(procname)), "rustg"))
			message_admins("<span class='userdanger'>[key_name_admin(src)] attempted to proc call rust-g procs. Inform the host <u>at once</u>.</span>")
			log_admin("[key_name(src)] attempted to proc call rust-g procs. Inform the host at once.")
			GLOB.discord_manager.send2discord_simple(DISCORD_WEBHOOK_ADMIN, "[key_name(src)] attempted to proc call rustg things. Inform the host at once.")
			return

		if(targetselected && !hascall(target,procname))
			to_chat(usr, "<font color='red'>Error: callproc(): target has no such call [procname].</font>")
			return

		var/list/lst = user.get_callproc_args()
		if(!lst)
			return

		if(targetselected)
			if(!target)
				to_chat(usr, "<font color='red'>Error: callproc(): owner of proc no longer exists.</font>")
				return
			message_admins("[key_name_admin(src)] called [target]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"].")
			log_admin("[key_name(src)] called [target]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"].")
			returnval = WrapAdminProcCall(target, procname, lst) // Pass the lst as an argument list to the proc
		else
			//this currently has no hascall protection. wasn't able to get it working.
			message_admins("[key_name_admin(src)] called [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")
			log_admin("[key_name(src)] called [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")
			returnval = WrapAdminProcCall(GLOBAL_PROC, procname, lst) // Pass the lst as an argument list to the proc

		to_chat(usr, "<font color='#EB4E00'>[procname] returned: [!isnull(returnval) ? returnval : "null"]</font>")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Advanced Proc-Call") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB(view_runtimes, R_DEBUG|R_VIEWRUNTIMES, "View Runtimes", "Open the Runtime Viewer", VERB_CATEGORY_DEBUG)
	GLOB.error_cache.showTo(user)

ADMIN_VERB(allow_browser_inspect, R_DEBUG, "Allow Browser Inspect", "Allow browser debugging via inspect", VERB_CATEGORY_DEBUG)
	if(user.byond_version < 516)
		to_chat(user, "<span class='warning'>You can only use this on 516!</span>")
		return

	to_chat(user, "<span class='notice'>You can now right click to use inspect on browsers.</span>")
	winset(user, "", "browser-options=byondstorage,find,devtools")

ADMIN_VERB_VISIBILITY(debug_clean_radiation, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(debug_clean_radiation, R_DEBUG, "Remove All Radiation", "Remove all radiation in the world.", VERB_CATEGORY_DEBUG)
	if(alert(user, "Are you sure you want to remove all radiation in the world? This may lag the server. Alternatively, use the radiation cleaning buildmode.", "Lag warning", "Yes, I'm sure", "No, I want to live") != "Yes, I'm sure")
		return

	log_and_message_admins("is decontaminating the world of all radiation. (This may be laggy!)")

	var/counter = 0
	for(var/datum/component/radioactive/rad as anything in SSradiation.all_radiations)
		rad.admin_decontaminate()
		counter++
		CHECK_TICK

	log_and_message_admins_no_usr("The world has been decontaminated of [counter] radiation components.")

ADMIN_VERB_VISIBILITY(redo_space_transitions, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(redo_space_transitions, R_ADMIN|R_DEBUG, "Remake Space Transitions", "Re-assigns all space transitions", VERB_CATEGORY_DEBUG)
	var/choice = alert(user, "Do you want to rebuild space transitions?", null,"Yes", "No")

	if(choice == "No")
		return

	message_admins("[key_name_admin(usr)] re-assigned all space transitions")
	GLOB.space_manager.do_transition_setup()
	log_admin("[key_name(usr)] re-assigned all space transitions")

	BLACKBOX_LOG_ADMIN_VERB("Remake Space Transitions")

ADMIN_VERB_VISIBILITY(make_turf_space_map, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(make_turf_space_map, R_ADMIN|R_DEBUG, "Make Space Map", "Create a map of the space levels as turfs at your feet", VERB_CATEGORY_DEBUG)
	var/choice = alert("Are you sure you want to make a space map out of turfs?", null,"Yes","No")

	if(choice == "No")
		return

	var/static/list/sectortypes = list(TRANSITION_TAG_SPACE, TRANSITION_TAG_LAVALAND)
	var/sectortype = tgui_input_list(user, "Please select sector type", "", sectortypes)

	if(!(sectortype in sectortypes))
		return

	message_admins("[key_name_admin(user)] made a space map")

	GLOB.space_manager.map_as_turfs(get_turf(user), sectortype)
	log_admin("[key_name(user)] made a space map")

	BLACKBOX_LOG_ADMIN_VERB("Make Space Map")
