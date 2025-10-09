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
		BLACKBOX_LOG_ADMIN_VERB("Automute")
		return

	toggle_mute(M.client.ckey, mute_type)

	if(check_mute(M.client.ckey, mute_type))
		muteunmute = "muted"
	else
		muteunmute = "unmuted"

	log_admin("[key_name(usr)] has [muteunmute] [key_name(M)] from [mute_string]")
	message_admins("[key_name_admin(usr)] has [muteunmute] [key_name_admin(M)] from [mute_string].", 1)
	to_chat(M, "You have been [muteunmute] from [mute_string].")
	BLACKBOX_LOG_ADMIN_VERB("Mute")

/client/proc/get_ghosts(notify = 0, what = 2)
	// what = 1, return ghosts ass list.
	// what = 2, return mob list

	var/list/mobs = list()
	var/list/ghosts = list()
	var/list/sortmob = sortAtom(GLOB.mob_list)                           // get the mob list.
	var/any=0
	for(var/mob/dead/observer/M in sortmob)
		mobs.Add(M)                                             //filter it where it's only ghosts
		any = 1                                                 //if no ghosts show up, any will just be 0
	if(!any)
		if(notify)
			to_chat(src, "There doesn't appear to be any ghosts for you to select.")
		return

	for(var/mob/M in mobs)
		var/name = M.name
		ghosts[name] = M                                        //get the name of the mob for the popup list
	if(what==1)
		return ghosts
	else
		return mobs

/// Allow admin to add or remove traits of datum
/datum/admins/proc/modify_traits(datum/D)
	if(!D)
		return

	var/add_or_remove = tgui_input_list(usr, "Add or Remove Trait?", "Modify Trait", list("Add","Remove"))
	if(!add_or_remove)
		return
	var/list/availible_traits = list()

	switch(add_or_remove)
		if("Add")
			for(var/key in GLOB.traits_by_type)
				if(istype(D, key))
					availible_traits += GLOB.traits_by_type[key]
		if("Remove")
			if(!GLOB.trait_name_map)
				GLOB.trait_name_map = generate_trait_name_map()
			for(var/trait in D.status_traits)
				var/name = GLOB.trait_name_map[trait] || trait
				availible_traits[name] = trait

	var/chosen_trait = tgui_input_list(usr, "Select trait to modify.", "Traits", availible_traits)
	if(!chosen_trait)
		return
	chosen_trait = availible_traits[chosen_trait]

	var/source = "adminabuse"
	switch(add_or_remove)
		if("Add") //Not doing source choosing here intentionally to make this bit faster to use, you can always vv it.
			ADD_TRAIT(D, chosen_trait, source)
		if("Remove")
			var/specific = tgui_input_list(usr, "All or from a specific source?", "Add or Remove Trait", list("All","Specific"))
			if(!specific)
				return
			switch(specific)
				if("All")
					source = null
				if("Specific")
					source = tgui_input_list(usr, "Source to be removed?", "Add or Remove Trait", D.status_traits[chosen_trait])
					if(!source)
						return
			REMOVE_TRAIT(D, chosen_trait, source)

/client/proc/create_crate(object as text)
	set name = "Create Crate"
	set desc = "Spawn a crate from a supplypack datum. Append a period to the text in order to exclude subtypes of paths matching the input."
	set category = "Event"

	if(!check_rights(R_SPAWN))
		return

	var/list/types = SSeconomy.supply_packs

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

	if(!length(matches))
		return

	var/chosen = input("Select a supply crate type", "Create Crate", matches[1]) as null|anything in matches
	if(!chosen)
		return
	var/datum/supply_packs/the_pack = new chosen()

	var/spawn_location = get_turf(usr)
	if(!spawn_location)
		return
	var/obj/structure/closet/crate/crate = the_pack.create_package(spawn_location)
	crate.admin_spawned = TRUE
	for(var/atom/A in crate.contents)
		A.admin_spawned = TRUE
	qdel(the_pack)

	log_admin("[key_name(usr)] created a '[chosen]' crate at ([usr.x],[usr.y],[usr.z])")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Create Crate") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
