ADMIN_VERB(call_shuttle, R_ADMIN, "Call Shuttle", "Calls the shuttle.", VERB_CATEGORY_ADMIN)
	if(SSshuttle.emergency.mode >= SHUTTLE_DOCKED)
		return

	var/confirm = alert(src, "You sure?", "Confirm", "Yes", "No")
	if(confirm != "Yes") return

	if(alert("Set Shuttle Recallable (Select Yes unless you know what this does)", "Recallable?", "Yes", "No") == "Yes")
		SSshuttle.emergency.canRecall = TRUE
	else
		SSshuttle.emergency.canRecall = FALSE

	if(SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_RED)
		SSshuttle.emergency.request(coefficient = 0.5, redAlert = TRUE)
	else
		SSshuttle.emergency.request()

	log_admin("[key_name(usr)] admin-called the emergency shuttle.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] admin-called the emergency shuttle.</span>")
	BLACKBOX_LOG_ADMIN_VERB("Call Shuttle")

ADMIN_VERB(cancel_shuttle, R_ADMIN, "Cancel Shuttle", "Cancels the shuttle.", VERB_CATEGORY_ADMIN)
	if(alert(user, "You sure?", "Confirm", "Yes", "No") != "Yes") return

	if(SSshuttle.emergency.mode >= SHUTTLE_DOCKED)
		return

	if(!SSshuttle.emergency.canRecall)
		if(alert("Shuttle is currently set to be nonrecallable. Recalling may break things. Respect Recall Status?", "Override Recall Status?", "Yes", "No") == "Yes")
			return
		else
			var/keepStatus = alert("Maintain recall status on future shuttle calls?", "Maintain Status?", "Yes", "No") == "Yes" //Keeps or drops recallability
			SSshuttle.emergency.canRecall = TRUE // must be true for cancel proc to work
			SSshuttle.emergency.cancel(byCC = TRUE)
			if(keepStatus)
				SSshuttle.emergency.canRecall = FALSE // restores original status
	else
		SSshuttle.emergency.cancel(byCC = TRUE)

	log_admin("[key_name(usr)] admin-recalled the emergency shuttle.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] admin-recalled the emergency shuttle.</span>")
	BLACKBOX_LOG_ADMIN_VERB("Cancel Shuttle")

ADMIN_VERB(deny_shuttle, R_ADMIN, "Toggle Deny Shuttle", "Toggles crew shuttle calling-ability.", VERB_CATEGORY_ADMIN)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("The game hasn't started yet!")
		return

	var/alert = alert(user, "Do you want to ALLOW or DENY shuttle calls?", "Toggle Deny Shuttle", "Allow", "Deny", "Cancel")
	if(alert == "Cancel")
		return

	BLACKBOX_LOG_ADMIN_VERB("Toggle Deny Shuttle")

	if(alert == "Allow")
		if(!length(SSshuttle.hostile_environments))
			to_chat(user, "<span class='notice'>No hostile environments found, cleared for takeoff!</span>")
			return
		if(alert(user, "[english_list(SSshuttle.hostile_environments)] is currently blocking the shuttle call, do you want to clear them?", "Toggle Deny Shuttle", "Yes", "No") == "Yes")
			SSshuttle.hostile_environments.Cut()
			var/log = "[key_name(user)] has cleared all hostile environments, allowing the shuttle to be called."
			log_admin(log)
			message_admins(log)
		return

	SSshuttle.registerHostileEnvironment(src) // wow, a client blocking the shuttle
	log_and_message_admins("has denied the shuttle to be called.")
