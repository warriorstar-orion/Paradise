ADMIN_VERB(toggle_advanced_interaction, R_ADMIN, "Toggle Advanced Admin Interaction", \
		"Allows you to interact with atoms such as buttons and doors, on top of regular machinery interaction.", VERB_CATEGORY_ADMIN)
	user.advanced_admin_interaction = !user.advanced_admin_interaction

	log_admin("[key_name(usr)] has [user.advanced_admin_interaction ? "activated" : "deactivated"] their advanced admin interaction.")
	message_admins("[key_name_admin(usr)] has [user.advanced_admin_interaction ? "activated" : "deactivated"] their advanced admin interaction.")

ADMIN_VERB(big_brother, R_PERMISSIONS, "Big Brother Mode", "Enables Big Brother mode.", VERB_CATEGORY_ADMIN)
	var/datum/admins/holder = user.holder
	if(holder)
		if(holder.fakekey)
			holder.fakekey = null
			holder.big_brother = 0
		else
			var/new_key = ckeyEx(clean_input(user, "Enter your desired display name. Unlike normal stealth mode, this will not appear in Who at all, except for other heads.", "Fake Key", user.key))
			if(!new_key)
				return
			if(length(new_key) >= 26)
				new_key = copytext(new_key, 1, 26)
			holder.fakekey = new_key
			holder.big_brother = 1
			if(isobserver(user.mob))
				user.mob.invisibility = 90
				user.mob.see_invisible = 90
			user.createStealthKey()
		log_admin("[key_name(user)] has turned BB mode [holder.fakekey ? "ON" : "OFF"]", TRUE)
		BLACKBOX_LOG_ADMIN_VERB("Big Brother Mode")

ADMIN_VERB(invisimin, R_ADMIN, "Invisimin", "Toggles ghost-like invisibility (Don't abuse this)", VERB_CATEGORY_ADMIN)
	if(!isliving(user.mob))
		return

	var/mob/living/client_mob = user.mob
	if(client_mob.invisibility == INVISIBILITY_OBSERVER)
		client_mob.invisibility = initial(client_mob.invisibility)
		client_mob.add_to_all_human_data_huds()
		to_chat(user, "<span class='danger'>Invisimin off. Invisibility reset.</span>")
		log_admin("[key_name(user)] has turned Invisimin OFF")
	else
		client_mob.invisibility = INVISIBILITY_OBSERVER
		client_mob.remove_from_all_data_huds()
		to_chat(user, "<span class='notice'>Invisimin on. You are now as invisible as a ghost.</span>")
		log_admin("[key_name(user)] has turned Invisimin ON")

	BLACKBOX_LOG_ADMIN_VERB("Invisimin")

/client/proc/getStealthKey()
	return GLOB.stealthminID[ckey]

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

ADMIN_VERB(stealth_mode, R_ADMIN, "Stealth Mode", "Enables stealth mode.", VERB_CATEGORY_ADMIN)
	var/datum/admins/holder = user.holder
	if(istype(holder))
		holder.big_brother = 0
		if(holder.fakekey)
			holder.fakekey = null
		else
			var/new_key = ckeyEx(clean_input("Enter your desired display name.", "Fake Key", user.key))
			if(!new_key)	return
			if(length(new_key) >= 26)
				new_key = copytext(new_key, 1, 26)
			holder.fakekey = new_key
			user.createStealthKey()
		log_admin("[key_name(usr)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]")
		message_admins("[key_name_admin(usr)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]", 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Stealth Mode") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB(deadmin_self, R_ADMIN|R_MENTOR, "De-admin self", "De-admin yourself.", VERB_CATEGORY_ADMIN)
	log_admin("[key_name(user)] deadmined themself.")
	message_admins("[key_name_admin(user)] deadmined themself.")
	user.deadmin()
	to_chat(user, "<span class='interface'>You are now a normal player.</span>")
	BLACKBOX_LOG_ADMIN_VERB("De-admin")
