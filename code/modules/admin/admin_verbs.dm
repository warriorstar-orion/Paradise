GLOBAL_LIST_INIT(admin_verbs_admin, list(
	/client/proc/cmd_mentor_say,
	/client/proc/update_mob_sprite,
	/client/proc/man_up,
	/client/proc/aooc,
	/client/proc/debug_variables,
	/client/proc/toggle_mentor_chat,
	/client/proc/view_instances,
	/client/proc/ping_all_admins,
))
GLOBAL_LIST_INIT(admin_verbs_sounds, list(
	/client/proc/play_local_sound,
	/client/proc/play_sound,
	/client/proc/play_server_sound,
	/client/proc/play_intercomm_sound,
	/client/proc/stop_global_admin_sounds,
	/client/proc/stop_sounds_global,
	/client/proc/play_sound_tgchat
	))
GLOBAL_LIST_INIT(admin_verbs_event, list(
	/client/proc/object_talk,
	/client/proc/cmd_admin_gib_self,
	/client/proc/one_click_antag,
	/client/proc/cmd_admin_add_freeform_ai_law,
	/client/proc/economy_manager,
	/client/proc/everyone_random,
	/client/proc/make_sound,
	/client/proc/toggle_random_events,
	/client/proc/toggle_random_events,
	/client/proc/toggle_ert_calling,
	/client/proc/set_holiday,
	/client/proc/show_tip,
	/client/proc/cmd_admin_change_custom_event,
	/client/proc/cmd_admin_subtle_message,	/*send an message to somebody as a 'voice in their head'*/
	/client/proc/cmd_admin_direct_narrate,	/*send text directly to a player with no padding. Useful for narratives and fluff-text*/
	/client/proc/response_team, // Response Teams admin verb
	/client/proc/cmd_admin_create_centcom_report,
	/client/proc/fax_panel,
	// /client/proc/event_manager_panel,
	/client/proc/modify_goals,
	/client/proc/outfit_manager,
	/client/proc/cmd_admin_headset_message,
	/client/proc/change_human_appearance_admin,	/* Allows an admin to change the basic appearance of human-based mobs */
	/client/proc/change_human_appearance_self,	/* Allows the human-based mob itself to change its basic appearance */
	/datum/admins/proc/toggle_ai,
	))

GLOBAL_LIST_INIT(admin_verbs_spawn, list(
	/client/proc/admin_deserialize,
	/client/proc/create_crate,
	/client/proc/json_spawn_menu
	))
GLOBAL_LIST_INIT(admin_verbs_server, list(
	/client/proc/reload_admins,
	/datum/admins/proc/end_round,
	/datum/admins/proc/delay,
	/datum/admins/proc/toggleguests,	/*toggles whether guests can join the current game*/
	/client/proc/toggle_log_hrefs,
	/client/proc/toggle_antagHUD_use,
	/client/proc/toggle_antagHUD_restrictions,
	/client/proc/manage_queue,
	/client/proc/add_queue_server_bypass
	))
GLOBAL_LIST_INIT(admin_verbs_debug, list(
	/client/proc/debug_controller,
	/client/proc/restart_controller,
	/client/proc/check_bomb_impacts,
	/client/proc/test_movable_UI,
	/client/proc/test_snap_UI,
	/client/proc/map_template_load,
	/client/proc/map_template_upload,
	/client/proc/map_template_load_lazy,
	// /client/proc/view_runtimes,
	/client/proc/admin_serialize,
	/client/proc/uid_log,
	/client/proc/reestablish_db_connection,
	/client/proc/ss_breakdown,
	#ifdef REFERENCE_TRACKING
	/datum/proc/find_refs,
	/datum/proc/qdel_then_find_references,
	/datum/proc/qdel_then_if_fail_find_references,
	#endif
	/client/proc/dmapi_debug,
	/client/proc/dmapi_log,
	/client/proc/timer_log,
	/client/proc/debug_timers,
	/client/proc/force_verb_bypass,
	/client/proc/debug_global_variables,
	/client/proc/debug_atom_init,
	/client/proc/debug_bloom,
	// /client/proc/allow_browser_inspect,
	))
GLOBAL_LIST_INIT(admin_verbs_mod, list(
	/client/proc/cmd_mentor_say,
	/client/proc/debug_variables,		/*allows us to -see- the variables of any instance in the game. +VAREDIT needed to modify*/
))
GLOBAL_LIST_INIT(admin_verbs_mentor, list(
	/client/proc/openMentorTicketUI,
	/client/proc/cmd_mentor_say,	/* mentor say*/
))
GLOBAL_LIST_INIT(admin_verbs_ticket, list(
	/client/proc/openAdminTicketUI,
	/client/proc/openMentorTicketUI,
	/client/proc/resolveAllAdminTickets,
	/client/proc/resolveAllMentorTickets
))
// In this list are verbs that should ONLY be executed by maintainers, aka people who know how badly this will break the server
// If you are adding something here, you MUST justify it
GLOBAL_LIST_INIT(admin_verbs_maintainer, list(
	/client/proc/ticklag, // This adjusts the server tick rate and is VERY easy to hard lockup the server with
	/client/proc/debugNatureMapGenerator, // This lags like hell, and is very easy to nuke half the server with
	/client/proc/vv_by_ref, // This allows you to lookup **ANYTHING** in the server memory by spamming refs. Locked for security.
	/client/proc/cinematic, // This will break everyone's screens in the round. Dont use this for adminbus.
	/client/proc/throw_runtime, // Do I even need to explain why this is locked?
))
GLOBAL_LIST_INIT(view_runtimes_verbs, list(
	// /client/proc/view_runtimes,
	/client/proc/debug_variables, /*allows us to -see- the variables of any instance in the game. +VAREDIT needed to modify*/
	/client/proc/ss_breakdown,
	/client/proc/debug_global_variables,
	/client/proc/debug_timers,
	/client/proc/timer_log,
))

// /client/proc/add_admin_verbs()
// 	if(holder)
// 		// If they have ANYTHING OTHER THAN ONLY VIEW RUNTIMES AND/OR DEV, then give them the default admin verbs
// 		if(holder.rights & ~(R_VIEWRUNTIMES|R_DEV_TEAM))
// 			add_verb(src, GLOB.admin_verbs_default)
// 		if(holder.rights & R_BUILDMODE)
// 			add_verb(src, /client/proc/togglebuildmodeself)
// 		if(holder.rights & R_ADMIN)
// 			add_verb(src, GLOB.admin_verbs_admin)
// 			add_verb(src, GLOB.admin_verbs_ticket)
// 			spawn(1)
// 				control_freak = 0
// 		if(holder.rights & R_BAN)
// 			add_verb(src, GLOB.admin_verbs_ban)
// 		if(holder.rights & R_EVENT)
// 			add_verb(src, GLOB.admin_verbs_event)
// 		if(holder.rights & R_SERVER)
// 			add_verb(src, GLOB.admin_verbs_server)
// 		if(holder.rights & R_DEBUG)
// 			add_verb(src, GLOB.admin_verbs_debug)
// 			spawn(1)
// 				control_freak = 0 // Setting control_freak to 0 allows you to use the Profiler and other client-side tools
// 		if(holder.rights & R_PERMISSIONS)
// 			add_verb(src, GLOB.admin_verbs_permissions)
// 		if(holder.rights & R_STEALTH)
// 			add_verb(src, /client/proc/stealth)
// 		if(holder.rights & R_REJUVINATE)
// 			add_verb(src, GLOB.admin_verbs_rejuv)
// 		if(holder.rights & R_SOUNDS)
// 			add_verb(src, GLOB.admin_verbs_sounds)
// 		if(holder.rights & R_SPAWN)
// 			add_verb(src, GLOB.admin_verbs_spawn)
// 		if(holder.rights & R_MOD)
// 			add_verb(src, GLOB.admin_verbs_mod)
// 		if(holder.rights & R_MENTOR)
// 			add_verb(src, GLOB.admin_verbs_mentor)
// 		if(holder.rights & R_PROCCALL)
// 			add_verb(src, GLOB.admin_verbs_proccall)
// 		if(holder.rights & R_MAINTAINER)
// 			add_verb(src, GLOB.admin_verbs_maintainer)
// 		if(holder.rights & R_VIEWRUNTIMES)
// 			add_verb(src, GLOB.view_runtimes_verbs)
// 			spawn(1) // This setting exposes the profiler for people with R_VIEWRUNTIMES. They must still have it set in cfg/admin.txt
// 				control_freak = 0
// 		if(holder.rights & R_DEV_TEAM)
// 			add_verb(src, GLOB.admin_verbs_dev)
// 		if(holder.rights & R_VIEWLOGS)
// 			add_verb(src, GLOB.view_logs_verbs)
// 		if(is_connecting_from_localhost())
// 			add_verb(src, /client/proc/export_current_character)

// /client/proc/hide_verbs()
// 	set name = "Adminverbs - Hide All"
// 	set category = "Admin"

// 	if(!holder)
// 		return

// 	remove_verb(src, list(
// 		/client/proc/togglebuildmodeself,
// 		/client/proc/stealth,
// 		/client/proc/readmin,
// 		/client/proc/cmd_dev_say,
// 		/client/proc/export_current_character,
// 		GLOB.admin_verbs_default,
// 		GLOB.admin_verbs_admin,
// 		GLOB.admin_verbs_ban,
// 		GLOB.admin_verbs_event,
// 		GLOB.admin_verbs_server,
// 		GLOB.admin_verbs_debug,
// 		GLOB.admin_verbs_permissions,
// 		GLOB.admin_verbs_rejuv,
// 		GLOB.admin_verbs_sounds,
// 		GLOB.admin_verbs_spawn,
// 		GLOB.admin_verbs_mod,
// 		GLOB.admin_verbs_mentor,
// 		GLOB.admin_verbs_proccall,
// 		GLOB.admin_verbs_show_debug_verbs,
// 		GLOB.admin_verbs_ticket,
// 		GLOB.admin_verbs_maintainer,
// 		GLOB.admin_verbs_dev
// 	))
// 	add_verb(src, /client/proc/show_verbs)

// 	to_chat(src, "<span class='interface'>Almost all of your adminverbs have been hidden.</span>")
// 	SSblackbox.record_feedback("tally", "admin_verb", 1, "Hide Admin Verbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
// 	return

/client/proc/add_admin_verbs()
	SSadmin_verbs.associate_admin(src)

/client/proc/remove_admin_verbs()
	SSadmin_verbs.deassociate_admin(src)

/client/proc/show_verbs()
	set name = "Adminverbs - Show"
	set category = VERB_CATEGORY_ADMIN

	remove_verb(src, /client/proc/show_verbs)
	add_admin_verbs()

	to_chat(src, "<span class='interface'>All of your adminverbs are now visible.</span>")
	BLACKBOX_LOG_ADMIN_VERB("Show Admin Verbs")

/client/proc/mentor_ghost()
	var/is_mentor = check_rights(R_MENTOR, FALSE)
	var/is_full_admin = check_rights(R_ADMIN|R_MOD, FALSE)

	if(!is_mentor && !is_full_admin)
		to_chat(src, "<span class='warning'>You aren't allowed to use this!</span>")
		return

	// mentors are allowed only if they have the observe trait, which is given on observe.
	// they should also not be given this proc.
	if(!is_full_admin && (is_mentor && !HAS_MIND_TRAIT(mob, TRAIT_MENTOR_OBSERVING) || !is_mentor))
		return

	do_aghost()

/client/proc/do_aghost()
	if(isobserver(mob))
		//re-enter
		var/mob/dead/observer/ghost = mob
		var/old_turf = get_turf(ghost)
		ghost.ghost_flags |= GHOST_CAN_REENTER // just in-case.
		ghost.reenter_corpse()
		log_admin("[key_name(usr)] re-entered their body")
		BLACKBOX_LOG_ADMIN_VERB("Aghost")
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			H.regenerate_icons() // workaround for #13269
		if(is_ai(mob)) // client.mob, built in byond client var
			var/mob/living/silicon/ai/ai = mob
			ai.eyeobj.set_loc(old_turf)
	else if(isnewplayer(mob))
		to_chat(src, "<font color='red'>Error: Aghost: Can't admin-ghost whilst in the lobby. Join or observe first.</font>")
	else
		//ghostize
		var/mob/body = mob
		body.ghostize()
		if(body && !body.key)
			body.key = "@[key]"	//Haaaaaaaack. But the people have spoken. If it breaks; blame adminbus
		log_admin("[key_name(usr)] has admin-ghosted")
		// TODO: SStgui.on_transfer() to move windows from old and new
		BLACKBOX_LOG_ADMIN_VERB("Aghost")

/client/proc/object_talk(msg as text) // -- TLE
	set name = "oSay"
	set desc = "Display a message to everyone who can hear the target"

	if(!check_rights(R_EVENT))
		return

	if(mob.control_object)
		if(!msg)
			return
		for(var/mob/V in hearers(mob.control_object))
			V.show_message("<b>[mob.control_object.name]</b> says: \"" + msg + "\"", 2)
		log_admin("[key_name(usr)] used oSay on [mob.control_object]: [msg]")
		message_admins("[key_name_admin(usr)] used oSay on [mob.control_object]: [msg]")

	BLACKBOX_LOG_ADMIN_VERB("oSay")

/proc/ghost_follow_uid(mob/user, uid)
	var/client/client = user.client
	if(!isobserver(user))
		SSadmin_verbs.invoke_verb(user, /datum/admin_verb/admin_ghost)
	var/datum/target = locateUID(uid)
	if(QDELETED(target))
		to_chat(user, "<span class='warning'>This datum has been deleted!</span>")
		return

	if(istype(target, /datum/mind))
		var/datum/mind/mind = target
		if(!ismob(mind.current))
			to_chat(user, "<span class='warning'>This can only be used on instances of type /mob</span>")
			return
		target = mind.current

	var/mob/dead/observer/A = client.mob
	A.manual_follow(target)
