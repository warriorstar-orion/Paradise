/datum/admins/proc/toggleguests()
	set category = "Server"
	set desc="Guests can't enter"
	set name="Toggle Guests"

	if(!check_rights(R_SERVER))
		return

	if(!usr.client.is_connecting_from_localhost())
		if(tgui_alert(usr, "Are you sure about this?", "Confirm", list("Yes", "No")) != "Yes")
			return

	GLOB.configuration.general.guest_ban = !(GLOB.configuration.general.guest_ban)
	if(GLOB.configuration.general.guest_ban)
		to_chat(world, "<B>Guests may no longer enter the game.</B>")
	else
		to_chat(world, "<B>Guests may now enter the game.</B>")
	log_admin("[key_name(usr)] toggled guests game entering [GLOB.configuration?.general.guest_ban ? "dis" : ""]allowed.")
	message_admins("<span class='notice'>[key_name_admin(usr)] toggled guests game entering [GLOB.configuration?.general.guest_ban ? "dis" : ""]allowed.</span>", 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Guests") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggle_log_hrefs()
	set name = "Toggle href logging"
	set category = "Server"

	if(!check_rights(R_SERVER))
		return

	if(!usr.client.is_connecting_from_localhost())
		if(tgui_alert(usr, "Are you sure about this?", "Confirm", list("Yes", "No")) != "Yes")
			return

	// Why would we ever turn this off?
	if(GLOB.configuration.logging.href_logging)
		GLOB.configuration.logging.href_logging = FALSE
		to_chat(src, "<b>Stopped logging hrefs</b>")
	else
		GLOB.configuration.logging.href_logging = TRUE
		to_chat(src, "<b>Started logging hrefs</b>")

/datum/admins/proc/delay()
	set category = "Server"
	set desc="Delay the game start/end"
	set name="Delay"

	if(!check_rights(R_SERVER))
		return

	if(SSticker.current_state < GAME_STATE_STARTUP)
		alert("Slow down a moment, let the ticker start first!")
		return

	if(!usr.client.is_connecting_from_localhost())
		if(tgui_alert(usr, "Are you sure about this?", "Confirm", list("Yes", "No")) != "Yes")
			return

	if(SSblackbox)
		BLACKBOX_LOG_ADMIN_VERB("Delay")

	if(SSticker.current_state > GAME_STATE_PREGAME)
		SSticker.delay_end = !SSticker.delay_end
		log_admin("[key_name(usr)] [SSticker.delay_end ? "delayed the round end" : "has made the round end normally"].")
		message_admins("[key_name(usr)] [SSticker.delay_end ? "delayed the round end" : "has made the round end normally"].", 1)
		if(SSticker.delay_end)
			SSticker.real_reboot_time = 0 // Immediately show the "Admin delayed round end" message
		return //alert("Round end delayed", null, null, null, null, null)
	if(SSticker.ticker_going)
		SSticker.ticker_going = FALSE
		SSticker.delay_end = TRUE
		to_chat(world, "<b>The game start has been delayed.</b>")
		log_admin("[key_name(usr)] delayed the game.")
	else
		SSticker.ticker_going = TRUE
		SSticker.round_start_time = world.time + SSticker.pregame_timeleft
		to_chat(world, "<b>The game will start soon.</b>")
		log_admin("[key_name(usr)] removed the delay.")

/client/proc/toggle_antagHUD_use()
	set category = "Server"
	set name = "Toggle antagHUD usage"
	set desc = "Toggles antagHUD usage for observers"

	if(!check_rights(R_SERVER))
		return

	var/action=""
	if(GLOB.configuration.general.allow_antag_hud)
		GLOB.antag_hud_users.Cut()
		for(var/mob/dead/observer/g in get_ghosts())
			if(g.antagHUD)
				g.antagHUD = FALSE						// Disable it on those that have it enabled
				to_chat(g, "<span class='danger'>The Administrators have disabled AntagHUD.</span>")
		GLOB.configuration.general.allow_antag_hud = FALSE
		to_chat(src, "<span class='danger'>AntagHUD usage has been disabled</span>")
		action = "disabled"
	else
		for(var/mob/dead/observer/g in get_ghosts())
			if(!g.client.holder)						// Add the verb back for all non-admin ghosts
				to_chat(g, "<span class='boldnotice'>The Administrators have enabled AntagHUD.</span>")// Notify all observers they can now use AntagHUD

		GLOB.configuration.general.allow_antag_hud = TRUE
		action = "enabled"
		to_chat(src, "<span class='boldnotice'>AntagHUD usage has been enabled</span>")


	log_admin("[key_name(usr)] has [action] antagHUD usage for observers")
	message_admins("Admin [key_name_admin(usr)] has [action] antagHUD usage for observers", 1)

/client/proc/toggle_antagHUD_restrictions()
	set category = "Server"
	set name = "Toggle antagHUD Restrictions"
	set desc = "Restricts players that have used antagHUD from being able to join this round."

	if(!check_rights(R_SERVER))
		return

	if(!usr.client.is_connecting_from_localhost())
		if(tgui_alert(usr, "Are you sure about this?", "Confirm", list("Yes", "No")) != "Yes")
			return

	var/action=""
	if(GLOB.configuration.general.restrict_antag_hud_rejoin)
		for(var/mob/dead/observer/g in get_ghosts())
			to_chat(g, "<span class='boldnotice'>The administrator has lifted restrictions on joining the round if you use AntagHUD</span>")
		action = "lifted restrictions"
		GLOB.configuration.general.restrict_antag_hud_rejoin = FALSE
		to_chat(src, "<span class='boldnotice'>AntagHUD restrictions have been lifted</span>")
	else
		for(var/mob/dead/observer/g in get_ghosts())
			to_chat(g, "<span class='danger'>The administrator has placed restrictions on joining the round if you use AntagHUD</span>")
			to_chat(g, "<span class='danger'>Your AntagHUD has been disabled, you may choose to re-enabled it but will be under restrictions.</span>")
			g.antagHUD = FALSE
			GLOB.antag_hud_users -= g.ckey
		action = "placed restrictions"
		GLOB.configuration.general.restrict_antag_hud_rejoin = TRUE
		to_chat(src, "<span class='danger'>AntagHUD restrictions have been enabled</span>")

	log_admin("[key_name(usr)] has [action] on joining the round if they use AntagHUD")
	message_admins("Admin [key_name_admin(usr)] has [action] on joining the round if they use AntagHUD", 1)

/datum/admins/proc/end_round()
	set category = "Server"
	set name = "End Round"
	set desc = "Instantly ends the round and brings up the scoreboard, in the same way that wizards dying do."
	if(!check_rights(R_SERVER))
		return
	var/input = sanitize(copytext_char(input(usr, "What text should players see announcing the round end? Input nothing to cancel.", "Specify Announcement Text", "Shift Has Ended!"), 1, MAX_MESSAGE_LEN))

	if(!input)
		return
	if(SSticker.force_ending)
		return
	message_admins("[key_name_admin(usr)] has admin ended the round with message: '[input]'")
	log_admin("[key_name(usr)] has admin ended the round with message: '[input]'")
	SSticker.force_ending = TRUE
	SSticker.record_biohazard_results()
	to_chat(world, "<span class='warning'><big><b>[input]</b></big></span>")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "End Round") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	SSticker.mode_result = "admin ended"

ADMIN_VERB(toggle_ooc, R_ADMIN, "Toggle OOC", "Globally Toggles OOC", VERB_CATEGORY_SERVER)
	user.toggle_ooc()
	log_and_message_admins("toggled OOC.")
	BLACKBOX_LOG_ADMIN_VERB("Toggle OOC")

ADMIN_VERB(toggle_looc, R_ADMIN, "Toggle LOOC", "Globally Toggles LOOC", VERB_CATEGORY_SERVER)
	GLOB.looc_enabled = !(GLOB.looc_enabled)
	if(GLOB.looc_enabled)
		to_chat(world, "<B>The LOOC channel has been globally enabled!</B>")
	else
		to_chat(world, "<B>The LOOC channel has been globally disabled!</B>")
	log_and_message_admins("toggled LOOC.")
	BLACKBOX_LOG_ADMIN_VERB("Toggle LOOC")

ADMIN_VERB(toggle_dsay, R_ADMIN, "Toggle DSAY", "Globally Toggles DSAY", VERB_CATEGORY_SERVER)
	GLOB.dsay_enabled = !(GLOB.dsay_enabled)
	if(GLOB.dsay_enabled)
		to_chat(world, "<b>Deadchat has been globally enabled!</b>", MESSAGE_TYPE_DEADCHAT)
	else
		to_chat(world, "<b>Deadchat has been globally disabled!</b>", MESSAGE_TYPE_DEADCHAT)
	log_admin("[key_name(usr)] toggled deadchat.")
	message_admins("[key_name_admin(usr)] toggled deadchat.", 1)
	BLACKBOX_LOG_ADMIN_VERB("Toggle Deadchat")

ADMIN_VERB(toggle_ooc_dead, R_ADMIN, "Toggle Dead OOC", "Toggle Dead OOC.", VERB_CATEGORY_SERVER)
	GLOB.dooc_enabled = !(GLOB.dooc_enabled)
	log_admin("[key_name(usr)] toggled Dead OOC.")
	message_admins("[key_name_admin(usr)] toggled Dead OOC.", 1)
	BLACKBOX_LOG_ADMIN_VERB("Toggle Dead OOC")

ADMIN_VERB(toggle_emoji, R_ADMIN, "Toggle OOC Emoji", "Toggle OOC Emoji", VERB_CATEGORY_SERVER)
	GLOB.configuration.general.enable_ooc_emoji = !(GLOB.configuration.general.enable_ooc_emoji)
	log_admin("[key_name(usr)] toggled OOC Emoji.")
	message_admins("[key_name_admin(usr)] toggled OOC Emoji.", 1)
	BLACKBOX_LOG_ADMIN_VERB("Toggle OOC Emoji")

ADMIN_VERB(start_server_now, R_SERVER, "Start Now", "Start the round RIGHT NOW", VERB_CATEGORY_SERVER)
	if(SSticker.current_state < GAME_STATE_STARTUP)
		alert("Unable to start the game as it is not set up.")
		return

	if(!SSticker.ticker_going)
		alert("Remove the round-start delay first.")
		return

	if(GLOB.configuration.general.start_now_confirmation)
		if(alert(user, "This is a live server. Are you sure you want to start now?", "Start game", "Yes", "No") != "Yes")
			return

	if(SSticker.current_state == GAME_STATE_PREGAME || SSticker.current_state == GAME_STATE_STARTUP)
		SSticker.force_start = TRUE
		log_admin("[user.key] has started the game.")
		var/msg = ""
		if(SSticker.current_state == GAME_STATE_STARTUP)
			msg = " (The server is still setting up, but the round will be started as soon as possible.)"
		message_admins("<span class='darkmblue'>[user.key] has started the game.[msg]</span>")
		BLACKBOX_LOG_ADMIN_VERB("Start Game")
		return 1
	else
		to_chat(user, "<font color='red'>Error: Start Now: Game has already started.</font>")
		return

ADMIN_VERB(toggle_enter, R_SERVER, "Toggle Entering", "People can't enter", VERB_CATEGORY_SERVER)
	if(!usr.client.is_connecting_from_localhost())
		if(tgui_alert(usr, "Are you sure about this?", "Confirm", list("Yes", "No")) != "Yes")
			return

	GLOB.enter_allowed = !GLOB.enter_allowed
	if(!GLOB.enter_allowed)
		to_chat(world, "<B>New players may no longer enter the game.</B>")
	else
		to_chat(world, "<B>New players may now enter the game.</B>")
	log_admin("[key_name(usr)] toggled new player game entering.")
	message_admins("[key_name_admin(usr)] toggled new player game entering.", 1)
	world.update_status()
	BLACKBOX_LOG_ADMIN_VERB("Toggle Entering")

ADMIN_VERB(toggle_respawn, R_SERVER, "Toggle Respawn", "Toggle the ability for players to respawn.", VERB_CATEGORY_SERVER)
	if(!user.is_connecting_from_localhost())
		if(tgui_alert(user, "Are you sure about this?", "Confirm", list("Yes", "No")) != "Yes")
			return

	GLOB.configuration.general.respawn_enabled = !(GLOB.configuration.general.respawn_enabled)
	if(GLOB.configuration.general.respawn_enabled)
		to_chat(world, "<B>You may now respawn.</B>")
	else
		to_chat(world, "<B>You may no longer respawn</B>")
	message_admins("[key_name_admin(user)] toggled respawn to [GLOB.configuration.general.respawn_enabled ? "On" : "Off"].", 1)
	log_admin("[key_name(user)] toggled respawn to [GLOB.configuration.general.respawn_enabled ? "On" : "Off"].")
	world.update_status()
	BLACKBOX_LOG_ADMIN_VERB("Toggle Respawn")

ADMIN_VERB(restart_server, R_SERVER, "Restart", "Restarts the world.", VERB_CATEGORY_SERVER)
	// Give an extra popup if they are rebooting a live server
	var/is_live_server = TRUE
	if(user.is_connecting_from_localhost())
		is_live_server = FALSE

	var/list/options = list("Regular Restart", "Hard Restart")
	if(world.TgsAvailable()) // TGS lets you kill the process entirely
		options += "Terminate Process (Kill and restart DD)"

	var/result = input(usr, "Select reboot method", "World Reboot", options[1]) as null|anything in options

	if(result && is_live_server)
		if(alert(usr, "WARNING: THIS IS A LIVE SERVER, NOT A LOCAL TEST SERVER. DO YOU STILL WANT TO RESTART","This server is live","Restart","Cancel") != "Restart")
			return FALSE

	if(result)
		BLACKBOX_LOG_ADMIN_VERB("Reboot World")
		var/init_by = "Initiated by [usr.client.holder.fakekey ? "Admin" : usr.key]."
		switch(result)

			if("Regular Restart")
				var/delay = input("What delay should the restart have (in seconds)?", "Restart Delay", 5) as num|null
				if(!delay)
					return FALSE


				// These are pasted each time so that they dont false send if reboot is cancelled
				message_admins("[key_name_admin(usr)] has initiated a server restart of type [result]")
				log_admin("[key_name(usr)] has initiated a server restart of type [result]")
				SSticker.delay_end = FALSE // We arent delayed anymore
				SSticker.reboot_helper(init_by, "admin reboot - by [usr.key] [usr.client.holder.fakekey ? "(stealth)" : ""]", delay * 10)

			if("Hard Restart")
				message_admins("[key_name_admin(usr)] has initiated a server restart of type [result]")
				log_admin("[key_name(usr)] has initiated a server restart of type [result]")
				world.Reboot(fast_track = TRUE)

			if("Terminate Process (Kill and restart DD)")
				message_admins("[key_name_admin(usr)] has initiated a server restart of type [result]")
				log_admin("[key_name(usr)] has initiated a server restart of type [result]")
				world.TgsEndProcess() // Just nuke the entire process if we are royally fucked

ADMIN_VERB(set_next_map, R_SERVER, "Set Next Map", "Set Next Map", VERB_CATEGORY_SERVER)
	var/list/map_datums = list()
	for(var/x in subtypesof(/datum/map))
		var/datum/map/M = x
		if(initial(M.voteable))
			map_datums["[initial(M.fluff_name)] ([initial(M.technical_name)])"] = M // Put our map in

	var/target_map_name = input(usr, "Select target map", "Next map", null) as null|anything in map_datums

	if(!target_map_name)
		return

	var/datum/map/TM = map_datums[target_map_name]
	SSmapping.next_map = new TM
	var/announce_to_players = alert(usr, "Do you wish to tell the playerbase about your choice?", "Announce", "Yes", "No")
	message_admins("[key_name_admin(usr)] has set the next map to [SSmapping.next_map.fluff_name] ([SSmapping.next_map.technical_name])")
	log_admin("[key_name(usr)] has set the next map to [SSmapping.next_map.fluff_name] ([SSmapping.next_map.technical_name])")
	if(announce_to_players == "Yes")
		to_chat(world, "<span class='boldannounceooc'>[user.key] has chosen the following map for next round: <font color='cyan'>[SSmapping.next_map.fluff_name] ([SSmapping.next_map.technical_name])</font></span>")
