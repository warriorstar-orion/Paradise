USER_CONTEXT_MENU(admin_observe_target, R_ADMIN|R_MOD|R_MENTOR, "\[Admin\] Aobserve", mob/target as mob)
	if(isnewplayer(client.mob))
		to_chat(client, SPAN_WARNING("You cannot aobserve while in the lobby. Please join or observe first."))
		return

	if(isnewplayer(target))
		to_chat(client, SPAN_WARNING("[target] is currently in the lobby."))
		return

	if(isobserver(target))
		to_chat(client, SPAN_WARNING("You can't observe a ghost."))
		return

	var/mob/dead/observer/observer = client.mob
	if(istype(observer) && target == locateUID(observer.mob_observed))
		client.cleanup_admin_observe(client.mob)
		return
	client.cleanup_admin_observe(client.mob)

	if(isnull(target) || target == client.mob)
		// let the default one find the target if there isn't one
		SSuser_verbs.invoke_verb(client, /datum/user_verb/admin_observe)
		return

	// observers don't need to ghost, so we don't need to worry about adding any traits
	if(isobserver(client.mob))
		var/mob/dead/observer/ghost = client.mob
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Aobserve") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		ghost.do_observe(target)
		return

	log_admin("[key_name(client)] has Aobserved out of their body to follow [target]")
	client.do_aghost()
	var/mob/dead/observer/ghost = client.mob

	var/full_admin = check_rights_client(R_ADMIN|R_MOD, FALSE, client)
	if(!full_admin)
		// if they're a me and they're alive, add the MENTOR_OBSERVINGtrait to ensure that they can only go back to their body.
		// we need to handle this here because when you aghost, your mob gets set to the ghost. Oops!
		ADD_TRAIT(client.mob.mind, TRAIT_MENTOR_OBSERVING, MENTOR_OBSERVING)
		RegisterSignal(ghost, COMSIG_ATOM_ORBITER_STOP, TYPE_PROC_REF(/client, on_mentor_observe_end), override = TRUE)
		to_chat(client, SPAN_NOTICE("You have temporarily observed [target], either move or observe again to un-observe."))
		log_admin("[key_name(client)] has mobserved out of their body to follow [target].")
	else
		log_admin("[key_name(client)] is aobserving [target].")

	ghost.do_observe(target)
