USER_VERB(invisimin, R_ADMIN, "Invisimin", "Toggles ghost-like invisibility (Don't abuse this)", VERB_CATEGORY_ADMIN)
	if(!isliving(client.mob))
		return

	var/mob/living/client_mob = client.mob
	if(client_mob.invisibility == INVISIBILITY_OBSERVER)
		client_mob.invisibility = initial(client_mob.invisibility)
		client_mob.add_to_all_human_data_huds()
		to_chat(client, SPAN_DANGER("Invisimin off. Invisibility reset."))
		log_admin("[key_name(client)] has turned Invisimin OFF")
	else
		client_mob.invisibility = INVISIBILITY_OBSERVER
		client_mob.remove_from_all_data_huds()
		to_chat(client, SPAN_NOTICE("Invisimin on. You are now as invisible as a ghost."))
		log_admin("[key_name(client)] has turned Invisimin ON")

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Invisimin") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(big_brother, R_PERMISSIONS, "Big Brother Mode", "Enables Big Brother mode.", VERB_CATEGORY_ADMIN)
	var/datum/admins/holder = client.holder
	if(holder)
		if(holder.fakekey)
			holder.fakekey = null
			holder.big_brother = 0
		else
			var/new_key = ckeyEx(clean_input("Enter your desired display name. Unlike normal stealth mode, this will not appear in Who at all, except for other heads.", "Fake Key", client.key, user = client))
			if(!new_key)
				return
			if(length(new_key) >= 26)
				new_key = copytext(new_key, 1, 26)
			holder.fakekey = new_key
			holder.big_brother = 1
			if(isobserver(client.mob))
				client.mob.invisibility = 90
				client.mob.see_invisible = 90
			client.createStealthKey()
		log_admin("[key_name(client)] has turned BB mode [holder.fakekey ? "ON" : "OFF"]", TRUE)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Big Brother Mode") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(stealth_mode, R_ADMIN, "Stealth Mode", "Enables stealth mode.", VERB_CATEGORY_ADMIN)
	var/datum/admins/holder = client.holder
	if(istype(holder))
		holder.big_brother = 0
		if(holder.fakekey)
			holder.fakekey = null
		else
			var/new_key = ckeyEx(clean_input("Enter your desired display name.", "Fake Key", client.key, user = client))
			if(!new_key)	return
			if(length(new_key) >= 26)
				new_key = copytext(new_key, 1, 26)
			holder.fakekey = new_key
			client.createStealthKey()
		log_admin("[key_name(client)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]")
		message_admins("[key_name_admin(client)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]", 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Stealth Mode") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/createStealthKey()
	var/num = (rand(0,1000))
	var/i = 0
	while(i == 0)
		i = 1
		for(var/P in GLOB.stealthminID)
			if(num == GLOB.stealthminID[P])
				num++
				i = 0
	GLOB.stealthminID["[ckey]"] = "@[num2text(num)]"

/client/proc/getStealthKey()
	return GLOB.stealthminID[ckey]
