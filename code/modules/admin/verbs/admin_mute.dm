/proc/cmd_admin_mute(mob/M as mob, mute_type, automute = 0)
	if(automute)
		if(!GLOB.configuration.general.enable_auto_mute)
			return
	else
		if(!usr || !usr.client)
			return
		if(!check_rights(R_ADMIN|R_MOD))
			to_chat(usr, "<font color='red'>Error: cmd_admin_mute: You don't have permission to do this.</font>")
			return
		if(!M.client)
			to_chat(usr, "<font color='red'>Error: cmd_admin_mute: This mob doesn't have a client tied to it.</font>")
	if(!M.client)
		return

	var/muteunmute
	var/mute_string

	switch(mute_type)
		if(MUTE_IC)
			mute_string = "IC (say and emote)"
		if(MUTE_OOC)
			mute_string = "OOC"
		if(MUTE_PRAY)
			mute_string = "pray"
		if(MUTE_ADMINHELP)
			mute_string = "adminhelp, admin PM and ASAY"
		if(MUTE_DEADCHAT)
			mute_string = "deadchat and DSAY"
		if(MUTE_EMOTE)
			mute_string = "emote"
		if(MUTE_ALL)
			mute_string = "everything"
		else
			return

	if(automute)
		muteunmute = "auto-muted"
		force_add_mute(M.client.ckey, mute_type)
		log_admin("SPAM AUTOMUTE: [muteunmute] [key_name(M)] from [mute_string]")
		message_admins("SPAM AUTOMUTE: [muteunmute] [key_name_admin(M)] from [mute_string].", 1)
		to_chat(M, "You have been [muteunmute] from [mute_string] by the SPAM AUTOMUTE system. Contact an admin.")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Automute") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		return

	toggle_mute(M.client.ckey, mute_type)

	if(check_mute(M.client.ckey, mute_type))
		muteunmute = "muted"
	else
		muteunmute = "unmuted"

	log_admin("[key_name(usr)] has [muteunmute] [key_name(M)] from [mute_string]")
	message_admins("[key_name_admin(usr)] has [muteunmute] [key_name_admin(M)] from [mute_string].", 1)
	to_chat(M, "You have been [muteunmute] from [mute_string].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Mute") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

