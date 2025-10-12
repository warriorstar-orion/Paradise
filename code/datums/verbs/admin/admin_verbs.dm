ADMIN_VERB(show_watchlist, R_ADMIN, "Show Watchlist", "Show the watchlist.", VERB_CATEGORY_ADMIN)
	user.watchlist_show()

ADMIN_VERB(send_alert_message, R_ADMIN, "Send Alert Message", "Sends a large notice to a player.", VERB_CATEGORY_ADMIN, mob/about_to_be_banned)
	if(!ismob(about_to_be_banned))
		return

	var/default_text = "An admin is trying to talk to you!\nCheck your chat window and click their name to respond or you may be banned!"
	var/new_text = tgui_input_text(user, "Input your message, or use the default.", "Admin Message - Text Selector", default_text, 500, TRUE)

	if(!new_text)
		return

	if(default_text == new_text)
		show_blurb(about_to_be_banned, 15, new_text, null, "center", "center", COLOR_RED, null, null, 1)
		log_admin("[key_name(user)] sent a default admin alert to [key_name(about_to_be_banned)].")
		message_admins("[key_name(user)] sent a default admin alert to [key_name(about_to_be_banned)].")
		return

	new_text = strip_html(new_text, 500)

	var/message_color = tgui_input_color(user, "Input your message color:", "Admin Message - Color Selector", COLOR_RED)
	if(isnull(message_color))
		return

	show_blurb(about_to_be_banned, 15, new_text, null, "center", "center", message_color, null, null, 1)
	log_admin("[key_name(user)] sent an admin alert to [key_name(about_to_be_banned)] with custom message \"[new_text]\".")
	message_admins("[key_name(user)] sent an admin alert to [key_name(about_to_be_banned)] with custom message \"[new_text]\".")

ADMIN_VERB(export_character, R_ADMIN, "Export Character DMI/JSON", "Saves character DMI and JSON to data directory.", VERB_CATEGORY_ADMIN)
	if(ishuman(user.mob))
		var/mob/living/carbon/human/H = user.mob
		H.export_dmi_json()

ADMIN_VERB(global_man_up, R_ADMIN, "Man Up Global", "Tells everyone to man up and deal with it.", VERB_CATEGORY_ADMIN)
	if(tgui_alert(user, "Are you sure you want to send the global message?", "Confirm Man Up Global", list("Yes", "No")) != "No")
		var/manned_up_sound = sound('sound/voice/manup1.ogg')
		for(var/sissy in GLOB.player_list)
			to_chat(sissy, chat_box_notice_thick("<span class='notice'><b><font size=4>Man up.<br> Deal with it.</font></b><br>Move on.</span>"))
			SEND_SOUND(sissy, manned_up_sound)

		log_admin("[key_name(user)] told everyone to man up and deal with it.")
		message_admins("[key_name_admin(user)] told everyone to man up and deal with it.")
		BLACKBOX_LOG_ADMIN_VERB("Man Up Global")

ADMIN_VERB(free_job_slot, R_ADMIN, "Free Job Slot", "Frees a station job role.", VERB_CATEGORY_ADMIN)
	var/list/jobs = list()
	for(var/datum/job/J in SSjobs.occupations)
		if(J.current_positions >= J.total_positions && J.total_positions != -1)
			jobs += J.title
	if(!length(jobs))
		to_chat(user, "There are no fully staffed jobs.")
		return
	var/job = input(user, "Please select job slot to free", "Free Job Slot") as null|anything in jobs
	if(job)
		SSjobs.FreeRole(job, force = TRUE)
		log_admin("[key_name(user)] has freed a job slot for [job].")
		message_admins("[key_name_admin(user)] has freed a job slot for [job].")
		BLACKBOX_LOG_ADMIN_VERB("Free Job Slot")

ADMIN_VERB(check_ai_laws, R_ADMIN, "Check AI Laws", "Output AI laws.", VERB_CATEGORY_ADMIN)
	user.holder.output_ai_laws()

/// Allow an admin to observe someone.
/// mentors are allowed to use this verb while living, but with some stipulations:
/// if they attempt to do anything that would stop their orbit, they will immediately be returned to their body.
ADMIN_VERB(admin_observe, R_ADMIN|R_MOD|R_MENTOR, "Aobserve", "Admin-observe a player mob.", VERB_CATEGORY_ADMIN)
	if(isnewplayer(user.mob))
		to_chat(user, "<span class='warning'>You cannot aobserve while in the lobby. Please join or observe first.</span>")
		return

	var/mob/target

	target = tgui_input_list(user, "Select a mob to observe", "Aobserve", GLOB.player_list)
	if(isnull(target))
		return
	if(target == user)
		to_chat(user, "<span class='warning'>You can't observe yourself!</span>")
		return

	if(isobserver(target))
		to_chat(user, "<span class='warning'>[target] is a ghost, and cannot be observed.</span>")
		return

	if(isnewplayer(target))
		to_chat(user, "<span class='warning'>[target] is in the lobby, and cannot be observed.</span>")
		return

	SSadmin_verbs.invoke_verb(user, /datum/admin_verb/admin_observe_target, target)

ADMIN_VERB_VISIBILITY(grant_full_access, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(grant_full_access, R_EVENT, "Grant Full Access", "Gives mob all-access.", VERB_CATEGORY_ADMIN, mob/M in GLOB.mob_list)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.wear_id)
			var/obj/item/card/id/id = H.wear_id
			if(istype(H.wear_id, /obj/item/pda))
				var/obj/item/pda/pda = H.wear_id
				id = pda.id
			id.icon_state = "gold"
			id:access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
		else
			var/obj/item/card/id/id = new/obj/item/card/id(M)
			id.icon_state = "gold"
			id:access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
			id.registered_name = H.real_name
			id.assignment = "Captain"
			id.name = "[id.registered_name]'s ID Card ([id.assignment])"
			H.equip_to_slot_or_del(id, ITEM_SLOT_ID)
			H.update_inv_wear_id()
	else
		alert(user, "Invalid mob")
	BLACKBOX_LOG_ADMIN_VERB("Grant Full Access")
	log_admin("[key_name(user)] has granted [M.key] full access.")
	message_admins("<span class='notice'>[key_name_admin(user)] has granted [M.key] full access.</span>", 1)

ADMIN_VERB_VISIBILITY(assume_direct_control, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(assume_direct_control, R_ADMIN|R_DEBUG, "Assume direct control", "Direct intervention", VERB_CATEGORY_ADMIN, mob/M in GLOB.mob_list)
	if(M.ckey)
		if(alert(user, "This mob is being controlled by [M.ckey]. Are you sure you wish to assume control of it? [M.ckey] will be made a ghost.", null,"Yes","No") != "Yes")
			return
		else
			var/mob/dead/observer/ghost = new/mob/dead/observer(M,1)
			ghost.ckey = M.ckey
	message_admins("<span class='notice'>[key_name_admin(user)] assumed direct control of [M].</span>", 1)
	log_admin("[key_name(user)] assumed direct control of [M].")
	var/mob/adminmob = user.mob
	M.ckey = user.ckey
	if(isobserver(adminmob))
		qdel(adminmob)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Assume Direct Control") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB(imprison, R_ADMIN, "Prison", "Send a mob to prison.", VERB_CATEGORY_ADMIN, mob/M as mob in GLOB.mob_list)
	if(ismob(M))
		if(is_ai(M))
			alert(user, "The AI can't be sent to prison you jerk!", null, null, null, null)
			return
		//strip their stuff before they teleport into a cell :downs:
		for(var/obj/item/W in M)
			M.drop_item_to_ground(W)
		//teleport person to cell
		if(isliving(M))
			var/mob/living/L = M
			L.Paralyse(10 SECONDS)
		sleep(5)	//so they black out before warping
		M.loc = pick(GLOB.prisonwarp)
		if(ishuman(M))
			var/mob/living/carbon/human/prisoner = M
			prisoner.equip_to_slot_or_del(new /obj/item/clothing/under/color/orange(prisoner), ITEM_SLOT_JUMPSUIT)
			prisoner.equip_to_slot_or_del(new /obj/item/clothing/shoes/orange(prisoner), ITEM_SLOT_SHOES)
		spawn(50)
			to_chat(M, "<span class='warning'>You have been sent to the prison station!</span>")
		log_admin("[key_name(usr)] sent [key_name(M)] to the prison station.")
		message_admins("<span class='notice'>[key_name_admin(usr)] sent [key_name_admin(M)] to the prison station.</span>", 1)
		BLACKBOX_LOG_ADMIN_VERB("Prison")

ADMIN_VERB(godmode, R_ADMIN, "Godmode", "Toggles godmode on a mob.", VERB_CATEGORY_ADMIN, mob/M as mob in GLOB.mob_list)
	M.status_flags ^= GODMODE
	to_chat(usr, "<span class='notice'>Toggled [(M.status_flags & GODMODE) ? "ON" : "OFF"]</span>")

	log_admin("[key_name(usr)] has toggled [key_name(M)]'s nodamage to [(M.status_flags & GODMODE) ? "On" : "Off"]")
	message_admins("[key_name_admin(usr)] has toggled [key_name_admin(M)]'s nodamage to [(M.status_flags & GODMODE) ? "On" : "Off"]", 1)
	BLACKBOX_LOG_ADMIN_VERB("Godmode")

ADMIN_VERB(list_open_jobs, R_ADMIN, "List free slots", "List available station jobs.", VERB_CATEGORY_ADMIN)
	if(SSjobs)
		var/currentpositiontally
		var/totalpositiontally
		to_chat(src, "<span class='notice'>Job Name: Filled job slot / Total job slots <b>(Free job slots)</b></span>")
		for(var/datum/job/job in SSjobs.occupations)
			to_chat(src, "<span class='notice'>[job.title]: [job.current_positions] / \
			[job.total_positions == -1 ? "<b>UNLIMITED</b>" : job.total_positions] \
			<b>([job.total_positions == -1 ? "UNLIMITED" : job.total_positions - job.current_positions])</b></span>")
			if(job.total_positions != -1) // Only count position that isn't unlimited
				currentpositiontally += job.current_positions
				totalpositiontally += job.total_positions
		to_chat(src, "<b>Currently filled job slots (Excluding unlimited): [currentpositiontally] / [totalpositiontally] ([totalpositiontally - currentpositiontally])</b>")
	BLACKBOX_LOG_ADMIN_VERB("List Free Slots")

ADMIN_VERB(gib_mob, R_ADMIN|R_EVENT, "Gib", "Gibs a chosen mob.", VERB_CATEGORY_ADMIN, mob/M as mob in GLOB.mob_list)
	var/confirm = alert(user, "You sure?", "Confirm", "Yes", "No")
	if(confirm != "Yes") return
	//Due to the delay here its easy for something to have happened to the mob
	if(!M)	return

	log_admin("[key_name(user)] has gibbed [key_name(M)]")
	message_admins("[key_name_admin(user)] has gibbed [key_name_admin(M)]", 1)

	if(isobserver(M))
		gibs(M.loc)
		return

	M.gib()
	BLACKBOX_LOG_ADMIN_VERB("Gib")

ADMIN_VERB(toggle_view_range, R_ADMIN, "Change View Range", "Change tile view range.", VERB_CATEGORY_ADMIN)
	if(user.view == world.view)
		user.view = input(user, "Select view range:", "View Range", world.view) in list(1,2,3,4,5,6,7,8,9,10,11,12,13,14,128)
	else
		user.view = world.view

	log_admin("[key_name(user)] changed their view range to [user.view].")
	BLACKBOX_LOG_ADMIN_VERB("Change View Range")

ADMIN_VERB(open_attack_log, R_ADMIN, "Attack Log", "Prints the attack log.", VERB_CATEGORY_ADMIN, mob/M as mob in GLOB.mob_list)
	to_chat(user, "<span class='danger'>Attack Log for [M]</span>")
	for(var/t in M.attack_log_old)
		to_chat(user, t)
	BLACKBOX_LOG_ADMIN_VERB("Attack Log")

ADMIN_VERB(reset_telecoms, R_ADMIN, "Reset NTTC Configuration", "Resets NTTC to the default configuration.", VERB_CATEGORY_ADMIN)
	var/confirm = alert(user, "You sure you want to reset NTTC?", "Confirm", "Yes", "No")
	if(confirm != "Yes")
		return

	for(var/obj/machinery/tcomms/core/C in GLOB.tcomms_machines)
		C.nttc.reset()

	log_admin("[key_name(user)] reset NTTC scripts.")
	message_admins("[key_name_admin(user)] reset NTTC scripts.")
	BLACKBOX_LOG_ADMIN_VERB("Reset NTTC Configuration")

/// Shows a list of clients we could send PMs to, then forwards our choice to cmd_admin_pm.
ADMIN_VERB(admin_pm_panel, R_ADMIN|R_MENTOR, "Admin PM Name", "Send a PM by player name.", VERB_CATEGORY_ADMIN)
	var/list/client/targets[0]
	for(var/client/T)
		if(T.mob)
			if(isnewplayer(T.mob))
				targets["(New Player) - [T]"] = T
			else if(isobserver(T.mob))
				targets["[T.mob.name](Ghost) - [T]"] = T
			else
				targets["[T.mob.real_name](as [T.mob.name]) - [T]"] = T
		else
			targets["(No Mob) - [T]"] = T
	var/list/sorted = sortList(targets)
	var/target = input(src,"To whom shall we send a message?","Admin PM",null) as null|anything in sorted
	if(!target)
		return
	user.cmd_admin_pm(targets[target], null)
	BLACKBOX_LOG_ADMIN_VERB("Admin PM Name")

/// Shows a list of clients we could send PMs to, then forwards our choice to cmd_admin_pm.
ADMIN_VERB(admin_pm_by_key_panel, R_ADMIN|R_MENTOR, "Admin PM Key", "Send a PM by key.", VERB_CATEGORY_ADMIN)
	var/list/client/targets[0]
	for(var/client/T)
		if(T?.holder?.big_brother && !check_rights_client(R_PERMISSIONS, FALSE, user)) // normal admins can't see BB
			continue
		if(T.mob)
			if(isnewplayer(T.mob))
				targets["[T] - (New Player)"] = T
			else if(isobserver(T.mob))
				targets["[T] - [T.mob.name](Ghost)"] = T
			else
				targets["[T] - [T.mob.real_name](as [T.mob.name])"] = T
		else
			targets["(No Mob) - [T]"] = T
	var/list/sorted = sortList(targets)
	var/target = input(src,"To whom shall we send a message?","Admin PM",null) as null|anything in sorted
	if(!target)
		return
	user.cmd_admin_pm(targets[target], null)
	BLACKBOX_LOG_ADMIN_VERB("Admin PM Key")

/// Allows admins to determine who the newer players are.
ADMIN_VERB(check_player_exp, R_ADMIN|R_MOD|R_MENTOR, "Check Player Playtime", "Return a playtime report.", VERB_CATEGORY_ADMIN)
	var/list/msg = list()
	msg  += "<html><meta charset='utf-8'><head><title>Playtime Report</title></head><body>"
	var/datum/job/theirjob
	var/jtext
	msg += "<table border ='1'><tr><th>Player</th><th>Job</th><th>Crew</th>"
	for(var/thisdept in EXP_DEPT_TYPE_LIST)
		msg += "<TH>[thisdept]</TH>"
	msg += "</TR>"
	for(var/client/C in GLOB.clients)
		if(C?.holder?.fakekey && !check_rights(R_ADMIN, FALSE))
			continue // Skip those in stealth mode if an admin isnt viewing the panel

		msg += "<TR>"
		if(check_rights(R_ADMIN, 0))
			msg += "<TD>[key_name_admin(C.mob)]</TD>"
		else
			msg += "<TD>[key_name_mentor(C.mob)]</TD>"

		jtext = "-"
		if(C.mob.mind && C.mob.mind.assigned_role)
			theirjob = SSjobs.GetJob(C.mob.mind.assigned_role)
			if(theirjob)
				jtext = theirjob.title
		msg += "<TD>[jtext]</TD>"

		msg += "<TD><A href='byond://?_src_=holder;getplaytimewindow=[C.mob.UID()]'>" + C.get_exp_type(EXP_TYPE_CREW) + "</a></TD>"
		msg += "[C.get_exp_dept_string()]"
		msg += "</TR>"

	msg += "</TABLE></BODY></HTML>"
	src << browse(msg.Join(""), "window=Player_playtime_check")

ADMIN_VERB(announce, R_ADMIN, "Announce", "Announce your desires to the world", VERB_CATEGORY_ADMIN)
	var/message = input(user, "Global message to send:", "Admin Announce", null, null) as message|null
	if(message)
		if(!check_rights_client(R_SERVER, 0, user))
			message = adminscrub(message,500)
		message = replacetext(message, "\n", "<br>") // required since we're putting it in a <p> tag
		to_chat(world, chat_box_notice("<span class='notice'><b>[user.holder.fakekey ? "Administrator" : user.key] Announces:</b><br><br><p>[message]</p></span>"))
		log_admin("Announce: [key_name(user)] : [message]")
		for(var/client/clients_to_alert in GLOB.clients)
			window_flash(clients_to_alert)
			if(clients_to_alert.prefs?.sound & SOUND_ADMINHELP)
				SEND_SOUND(clients_to_alert, sound('sound/misc/server_alert.ogg'))

	BLACKBOX_LOG_ADMIN_VERB("Announce")

ADMIN_VERB(admin_ghost, R_ADMIN|R_MOD, "Aghost", "Aghost self.", VERB_CATEGORY_ADMIN)
	user.do_aghost()

ADMIN_VERB(send_mob, R_ADMIN, "Send Mob", "Send mob to an area.", VERB_CATEGORY_ADMIN, mob/M in GLOB.mob_list)
	var/area/A = input(user, "Pick an area.", "Pick an area") as null|anything in return_sorted_areas()
	if(!A)
		return

	if(isobj(M.loc))
		var/obj/O = M.loc
		O.force_eject_occupant(M)
	admin_forcemove(M, pick(get_area_turfs(A)))
	log_admin("[key_name(user)] teleported [key_name(M)] to [A]")
	message_admins("[key_name_admin(user)] teleported [key_name_admin(M)] to [A]", 1)
	BLACKBOX_LOG_ADMIN_VERB("Send Mob")

ADMIN_VERB(player_notes, R_ADMIN|R_MOD, "Player Notes", "Open Player Notes panel.", VERB_CATEGORY_ADMIN)
	show_note()

ADMIN_VERB(player_notes_target, R_ADMIN|R_MOD, "Show Player Notes", "Show Player Notes panel for a given ckey.", VERB_CATEGORY_ADMIN, key as text)
	show_note(key)

ADMIN_VERB(vpn_whitelist, R_BAN, "VPN Ckey Whitelist", "Modify ckey's presence on VPN whitelist", VERB_CATEGORY_ADMIN)
	var/key = stripped_input(user, "Enter ckey to add/remove, or leave blank to cancel:", "VPN Whitelist add/remove", max_length=32)
	if(key)
		GLOB.ipintel_manager.vpn_whitelist_panel(key)

ADMIN_VERB(start_vote, R_ADMIN, "Start Vote", "Start a vote on the server", VERB_CATEGORY_ADMIN)
	if(SSvote.active_vote)
		to_chat(user, "A vote is already in progress")
		return

	// Ask admins which type of vote they want to start
	var/vote_types = subtypesof(/datum/vote)
	vote_types |= "\[CUSTOM]"

	// This needs to be a map to instance it properly. I do hate it as well, dont worry.
	var/list/votemap = list()
	for(var/vtype in vote_types)
		votemap["[vtype]"] = vtype

	var/choice = tgui_input_list(user, "Select a vote type", "Vote", vote_types)

	if(choice == null)
		return

	if(choice != "\[CUSTOM]")
		// Not custom, figure it out
		var/datum/vote/votetype = votemap["[choice]"]
		SSvote.start_vote(new votetype(user.ckey))
		return

	// Its custom, lets ask
	var/question = tgui_input_text(user, "What is the vote for?", "Create Vote", encode = FALSE)
	if(isnull(question))
		return

	var/list/choices = list()
	for(var/i in 1 to 10)
		var/option = tgui_input_text(user, "Please enter an option or hit cancel to finish", "Create Vote", encode = FALSE)
		if(isnull(option) || !user)
			break
		choices |= option

	var/c2 = tgui_alert(user, "Show counts while vote is happening?", "Counts", list("Yes", "No"))
	var/c3 = input(user, "Select a result calculation type", "Vote", VOTE_RESULT_TYPE_MAJORITY) as anything in list(VOTE_RESULT_TYPE_MAJORITY)

	var/datum/vote/V = new /datum/vote(user.ckey, question, choices, TRUE)
	V.show_counts = (c2 == "Yes")
	V.vote_result_type = c3
	SSvote.start_vote(V)

ADMIN_VERB(empty_ai_core_toggle_latejoin, R_ADMIN, "Toggle AI Core Latejoin", "Toggle AI Core Latejoin", VERB_CATEGORY_ADMIN)
	var/list/cores = list()
	for(var/obj/structure/ai_core/deactivated/D in world)
		cores["[D] ([D.loc.loc])"] = D

	if(!length(cores))
		to_chat(src, "No deactivated AI cores were found.")

	var/id = input("Which core?", "Toggle AI Core Latejoin", null) as null|anything in cores
	if(!id) return

	var/obj/structure/ai_core/deactivated/D = cores[id]
	if(!D) return

	if(D in GLOB.empty_playable_ai_cores)
		GLOB.empty_playable_ai_cores -= D
		to_chat(src, "\The [id] is now <font color=\"#ff0000\">not available</font> for latejoining AIs.")
	else
		GLOB.empty_playable_ai_cores += D
		to_chat(src, "\The [id] is now <font color=\"#008000\">available</font> for latejoining AIs.")
