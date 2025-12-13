USER_VERB(add_random_ai_law, R_EVENT, "Add Random AI Law", "Add a random law to the AI.", VERB_CATEGORY_EVENT)
	var/confirm = alert(client, "You sure?", "Confirm", "Yes", "No")
	if(confirm != "Yes") return
	log_admin("[key_name(client)] has added a random AI law.")
	message_admins("[key_name_admin(client)] has added a random AI law.")

	var/show_log = alert(client, "Show ion message?", "Message", "Yes", "No")
	var/announce_ion_laws = (show_log == "Yes" ? 1 : -1)

	new /datum/event/ion_storm(botEmagChance = 0, announceEvent = announce_ion_laws)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Add Random AI Law")

USER_VERB(add_freeform_ai_law, R_EVENT, "Add Custom AI law", "Add custom AI law.", VERB_CATEGORY_EVENT)
	var/input = clean_input("Please enter anything you want the AI to do. Anything. Serious.", "What?", "", user = client)
	if(!input)
		return

	log_admin("Admin [key_name(client)] has added a new AI law - [input]")
	message_admins("Admin [key_name_admin(client)] has added a new AI law - [input]")

	var/show_log = alert(client, "Show ion message?", "Message", "Yes", "No")
	var/announce_ion_laws = (show_log == "Yes" ? 1 : -1)

	new /datum/event/ion_storm(botEmagChance = 0, announceEvent = announce_ion_laws, ionMessage = input)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Add Custom AI Law") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(create_centcom_report, R_SERVER|R_EVENT, "Create Communications Report", "Send an IC announcement to the game world.", VERB_CATEGORY_EVENT)
	//the stuff on the list is |"report type" = "report title"|, if that makes any sense
	var/list/MsgType = list("Central Command Report" = "Nanotrasen Update",
		"Syndicate Communique" = "Syndicate Message",
		"Space Wizard Federation Message" = "Sorcerous Message",
		"Enemy Communications" = "Unknown Message",
		"Custom" = "Cryptic Message")

	var/list/MsgSound = list("Beep" = 'sound/misc/notice2.ogg',
		"Enemy Communications Intercepted" = 'sound/AI/intercept.ogg',
		"New Command Report Created" = 'sound/AI/commandreport.ogg')

	var/type = input(client, "Pick a type of report to send", "Report Type", "") as anything in MsgType

	if(type == "Custom")
		type = clean_input("What would you like the report type to be?", "Report Type", "Encrypted Transmission", user = client)

	var/subtitle = input(client, "Pick a title for the report.", "Title", MsgType[type]) as text|null
	if(!subtitle)
		return
	var/message = input(client, "Please enter anything you want. Anything. Serious.", "What's the message?") as message|null
	if(!message)
		return

	switch(alert(client, "Should this be announced to the general population?", null,"Yes","No", "Cancel"))
		if("Yes")
			var/beepsound = input(client, "What sound should the announcement make?", "Announcement Sound", "") as anything in MsgSound
			var/should_translate = alert(client, "Should it be auto-translated for all human mobs?", "Translation", "Yes", "No")
			if(should_translate != "Yes")
				should_translate = null // We can just do it like this since force_translation just needs any value to not be false/null
			GLOB.major_announcement.Announce(
				message,
				new_title = type,
				new_subtitle = subtitle,
				new_sound = MsgSound[beepsound],
				force_translation = should_translate
			)
			print_command_report(message, subtitle)
		if("No")
			//same thing as the blob stuff - it's not public, so it's classified, dammit
			GLOB.command_announcer.autosay("A classified message has been printed out at all communication consoles.")
			print_command_report(message, "Classified: [subtitle]")
		else
			return

	log_admin("[key_name(client)] has created a communications report: [message]")
	message_admins("[key_name_admin(client)] has created a communications report", 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Create Comms Report") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(toggle_build_mode_self, R_EVENT, "Toggle Build Mode Self", "Toggle Build Mode on yourself.", VERB_CATEGORY_EVENT)
	if(client.mob)
		togglebuildmode(client.mob)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Build Mode") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(object_talk, R_EVENT, "oSay", "Display a message to everyone who can hear the target", VERB_CATEGORY_EVENT, msg as text)
	var/mob/living/mob = client.mob
	if(mob.control_object)
		if(!msg)
			return
		for(var/mob/V in hearers(mob.control_object))
			V.show_message("<b>[mob.control_object.name]</b> says: \"" + msg + "\"", 2)
		log_admin("[key_name(client)] used oSay on [mob.control_object]: [msg]")
		message_admins("[key_name_admin(client)] used oSay on [mob.control_object]: [msg]")

	SSblackbox.record_feedback("tally", "admin_verb", 1, "oSay") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(drop_bomb, R_EVENT, "Drop Bomb", "Cause an explosion of varying strength at your location.", VERB_CATEGORY_EVENT)
	var/turf/epicenter = client.mob.loc
	var/list/choices = list("Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb")
	var/choice = tgui_input_list(client, "What size explosion would you like to produce?", "Drop Bomb", choices)
	switch(choice)
		if(null)
			return 0
		if("Small Bomb")
			explosion(epicenter, 1, 2, 3, 3, cause = "[client.ckey]: Drop Bomb command")
		if("Medium Bomb")
			explosion(epicenter, 2, 3, 4, 4, cause = "[client.ckey]: Drop Bomb command")
		if("Big Bomb")
			explosion(epicenter, 3, 5, 7, 5, cause = "[client.ckey]: Drop Bomb command")
		if("Custom Bomb")
			var/devastation_range = tgui_input_number(client, "Devastation range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(devastation_range))
				return
			var/heavy_impact_range = tgui_input_number(client, "Heavy impact range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(heavy_impact_range))
				return
			var/light_impact_range = tgui_input_number(client, "Light impact range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(light_impact_range))
				return
			var/flash_range = tgui_input_number(client, "Flash range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(flash_range))
				return
			explosion(epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range, 1, 1, cause = "[client.ckey]: Drop Bomb command")
	log_admin("[key_name(client)] created an admin explosion at [epicenter.loc]")
	message_admins(SPAN_ADMINNOTICE("[key_name_admin(client)] created an admin explosion at [epicenter.loc]"))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Drop Bomb") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(give_spell, R_EVENT, "Give Spell", VERB_NO_DESCRIPTION, VERB_CATEGORY_HIDDEN, mob/T)
	var/list/spell_list = list()
	var/type_length = length("/datum/spell") + 2
	for(var/A in GLOB.spells)
		spell_list[copytext("[A]", type_length)] = A
	var/datum/spell/S = input(client, "Choose the spell to give to that guy", "ABRAKADABRA") as null|anything in spell_list
	if(!S)
		return
	S = spell_list[S]
	if(T.mind)
		T.mind.AddSpell(new S)
	else
		T.AddSpell(new S)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Give Spell") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(client)] gave [key_name(T)] the spell [S].")
	message_admins("[key_name_admin(client)] gave [key_name(T)] the spell [S].", 1)

USER_VERB(give_disease, R_EVENT, "Give Disease", VERB_NO_DESCRIPTION, VERB_CATEGORY_HIDDEN, mob/T)
	var/datum/disease/given_disease = null

	if(tgui_input_list(client, "Create own disease", "Would you like to create your own disease?", list("Yes","No")) == "Yes")
		given_disease = AdminCreateVirus(client)
	else
		given_disease = tgui_input_list(client, "ACHOO", "Choose the disease to give to that guy", GLOB.diseases)

	if(!given_disease)
		return

	if(!istype(given_disease, /datum/disease/advance))
		given_disease = new given_disease
	T.ForceContractDisease(given_disease)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Give Disease") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(client)] gave [key_name(T)] the disease [given_disease].")
	message_admins(SPAN_ADMINNOTICE("[key_name_admin(client)] gave [key_name(T)] the disease [given_disease]."))

USER_VERB(disease_outbreak, R_EVENT, "Disease Outbreak", "Creates a disease and infects a random player with it.", VERB_CATEGORY_EVENT)
	var/datum/disease/given_disease = null
	if(tgui_input_list(client, "Create own disease", "Would you like to create your own disease?", list("Yes","No")) == "Yes")
		given_disease = AdminCreateVirus(client)
	else
		given_disease = tgui_input_list(client, "ACHOO", "Choose the disease to give to that guy", GLOB.diseases)
	if(!given_disease)
		return

	if(!istype(given_disease, /datum/disease/advance))
		given_disease = new given_disease

	for(var/thing in shuffle(GLOB.human_list))
		var/mob/living/carbon/human/H = thing
		if(H.stat == DEAD || !is_station_level(H.z))
			continue
		if(!H.HasDisease(given_disease))
			H.ForceContractDisease(given_disease)
			break
	if(istype(given_disease, /datum/disease/advance))
		var/datum/disease/advance/given_advanced_disease = given_disease
		var/list/name_symptoms = list()
		for(var/datum/symptom/S in given_advanced_disease.symptoms)
			name_symptoms += S.name
		message_admins("[key_name_admin(client)] has triggered a custom virus outbreak of [given_advanced_disease.name]! It has these symptoms: [english_list(name_symptoms)] and these base stats [english_map(given_advanced_disease.base_properties)]")
	else
		message_admins("[key_name_admin(client)] has triggered a custom virus outbreak of [given_disease.name]!")

USER_VERB(admin_explosion, R_DEBUG|R_EVENT, "Explosion", "Create a custom explosion.", VERB_CATEGORY_EVENT, atom/O as obj|mob|turf in view())
	var/devastation = input(client, "Range of total devastation. -1 to none", "Input")  as num|null
	if(devastation == null) return
	var/heavy = input(client, "Range of heavy impact. -1 to none", "Input")  as num|null
	if(heavy == null) return
	var/light = input(client, "Range of light impact. -1 to none", "Input")  as num|null
	if(light == null) return
	var/flash = input(client, "Range of flash. -1 to none", "Input")  as num|null
	if(flash == null) return
	var/flames = input(client, "Range of flames. -1 to none", "Input")  as num|null
	if(flames == null) return

	if((devastation != -1) || (heavy != -1) || (light != -1) || (flash != -1) || (flames != -1))
		if((devastation > 20) || (heavy > 20) || (light > 20) || (flames > 20))
			if(alert(client, "Are you sure you want to do this? It will laaag.", "Confirmation", "Yes", "No") == "No")
				return

		explosion(O, devastation, heavy, light, flash, null, null,flames, cause = "[client.ckey]: Explosion command")
		log_admin("[key_name(client)] created an explosion ([devastation],[heavy],[light],[flames]) at ([O.x],[O.y],[O.z])")
		message_admins("[key_name_admin(client)] created an explosion ([devastation],[heavy],[light],[flames]) at ([O.x],[O.y],[O.z])")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "EXPL") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		return
	else
		return

USER_VERB(admin_emp, R_DEBUG|R_EVENT, "EM Pulse", "Cause an electromagnetic pulse.", VERB_CATEGORY_EVENT, atom/O as obj|mob|turf in view())
	var/heavy = input(client, "Range of heavy pulse.", "Input")  as num|null
	if(heavy == null) return
	var/light = input(client, "Range of light pulse.", "Input")  as num|null
	if(light == null) return

	if(heavy || light)

		empulse(O, heavy, light)
		log_admin("[key_name(client)] created an EM pulse ([heavy], [light]) at ([O.x],[O.y],[O.z])")
		message_admins("[key_name_admin(client)] created an EM pulse ([heavy], [light]) at ([O.x],[O.y],[O.z])", 1)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "EMP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

		return
	else
		return

USER_VERB(gib_mob, R_ADMIN|R_EVENT, "Gib", "Gibs a chosen mob.", VERB_CATEGORY_ADMIN, mob/M as mob in GLOB.mob_list)
	var/confirm = alert(client, "You sure?", "Confirm", "Yes", "No")
	if(confirm != "Yes") return
	//Due to the delay here its easy for something to have happened to the mob
	if(!M)	return

	log_admin("[key_name(client)] has gibbed [key_name(M)]")
	message_admins("[key_name_admin(client)] has gibbed [key_name_admin(M)]", 1)

	if(isobserver(M))
		gibs(M.loc)
		return

	M.gib()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Gib") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(gib_self, R_ADMIN|R_EVENT, "Gibself", "Gibself.", VERB_CATEGORY_EVENT)
	var/mob/mob = client.mob
	var/confirm = alert(client, "You sure?", "Confirm", "Yes", "No")
	if(confirm == "Yes")
		if(isobserver(mob)) // so they don't spam gibs everywhere
			return
		else
			mob.gib()

		log_admin("[key_name(client)] used gibself.")
		message_admins(SPAN_NOTICE("[key_name_admin(client)] used gibself."), 1)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Gibself") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(everyone_random, R_SERVER|R_EVENT, "Make Everyone Random", \
		"Make everyone have a random appearance. You can only use this before rounds!", \
		VERB_CATEGORY_EVENT)
	if(SSticker && SSticker.mode)
		to_chat(client, "Nope you can't do this, the game's already started. This only works before rounds!")
		return

	if(SSticker.random_players)
		SSticker.random_players = 0
		message_admins("Admin [key_name_admin(client)] has disabled \"Everyone is Special\" mode.", 1)
		to_chat(client, "Disabled.")
		return


	var/notifyplayers = alert(client, "Do you want to notify the players?", "Options", "Yes", "No", "Cancel")
	if(notifyplayers == "Cancel")
		return

	log_admin("Admin [key_name(client)] has forced the players to have random appearances.")
	message_admins("Admin [key_name_admin(client)] has forced the players to have random appearances.", 1)

	if(notifyplayers == "Yes")
		to_chat(world, SPAN_NOTICE("<b>Admin [client.key] has forced the players to have completely random identities!</b>"))

	to_chat(client, "<i>Remember: you can always disable the randomness by using the verb again, assuming the round hasn't started yet</i>.")

	SSticker.random_players = 1
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Everyone Random") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(toggle_random_events, R_SERVER|R_EVENT, "Toggle random events on/off", \
		"Toggles random events such as meteors, black holes, blob (but not space dust) on/off", \
		VERB_CATEGORY_EVENT)

	if(tgui_alert(client, "[GLOB.configuration.event.enable_random_events ? "Disable" : "Enable"] random events?", "Confirm", list("Yes", "No")) != "Yes")
		return

	if(!GLOB.configuration.event.enable_random_events)
		GLOB.configuration.event.enable_random_events = TRUE
		to_chat(client, "Random events enabled")
		message_admins("Admin [key_name_admin(client)] has enabled random events.")
	else
		GLOB.configuration.event.enable_random_events = FALSE
		to_chat(client, "Random events disabled")
		message_admins("Admin [key_name_admin(client)] has disabled random events.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Random Events") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(toggle_ert_calling, R_EVENT, "Toggle ERT", "Toggle the station's ability to call a response team.", VERB_CATEGORY_EVENT)
	if(SSticker.mode.ert_disabled)
		SSticker.mode.ert_disabled = FALSE
		to_chat(client, SPAN_NOTICE("ERT has been <b>Enabled</b>."))
		log_admin("Admin [key_name(client)] has enabled ERT calling.")
		message_admins("Admin [key_name_admin(client)] has enabled ERT calling.", 1)
	else
		SSticker.mode.ert_disabled = TRUE
		to_chat(client, SPAN_WARNING("ERT has been <b>Disabled</b>."))
		log_admin("Admin [key_name(client)] has disabled ERT calling.")
		message_admins("Admin [key_name_admin(client)] has disabled ERT calling.", 1)

USER_VERB(show_tip, R_EVENT, "Show Custom Tip", \
		"Sends a tip (that you specify) to all players. After all, you're the experienced player here.", \
		VERB_CATEGORY_EVENT)
	var/input = input(client, "Please specify your tip that you want to send to the players.", "Tip", "") as message|null
	if(!input)
		return

	if(SSticker.current_state < GAME_STATE_PREGAME)
		return

	SSticker.selected_tip = input

	// If we've already tipped, then send it straight away.
	if(SSticker.tipped)
		SSticker.send_tip_of_the_round()
		message_admins("[key_name_admin(client)] sent a custom Tip of the round.")
		log_admin("[key_name(client)] sent \"[input]\" as the Tip of the Round.")
		return

	message_admins("[key_name_admin(client)] set the Tip of the round to \"[html_encode(SSticker.selected_tip)]\".")
	log_admin("[key_name(client)] sent \"[input]\" as the Tip of the Round.")

USER_VERB(modify_goals, R_EVENT, "Modify Station Goals", "Modify station goals.", VERB_CATEGORY_EVENT)
	client.holder.modify_goals()

/datum/admins/proc/modify_goals()
	if(SSticker.current_state < GAME_STATE_PLAYING)
		to_chat(usr, SPAN_WARNING("This verb can only be used if the round has started."))
		return

	var/list/dat = list("<!DOCTYPE html>")
	for(var/datum/station_goal/S in SSticker.mode.station_goals)
		dat += "[S.name][S.completed ? " (C)" : ""] - <a href='byond://?src=[S.UID()];announce=1'>Announce</a> | <a href='byond://?src=[S.UID()];remove=1'>Remove</a>"
	dat += ""
	dat += "<a href='byond://?src=[UID()];add_station_goal=1'>Add New Goal</a>"
	dat += ""
	dat += "<b>Secondary goals</b>"
	for(var/datum/station_goal/secondary/SG in SSticker.mode.secondary_goals)
		dat += "[SG.admin_desc][SG.completed ? " (C)" : ""] for [SG.requester_name || SG.department] - <a href='byond://?src=[SG.UID()];announce=1'>Announce</a> | <a href='byond://?src=[SG.UID()];remove=1'>Remove</a> | <a href='byond://?src=[SG.UID()];mark_complete=1'>Mark complete</a> | <a href='byond://?src=[SG.UID()];reset_progress=1'>Reset progress</a>"
	dat += "<a href='byond://?src=[UID()];add_secondary_goal=1'>Add New Secondary Goal</a>"

	usr << browse(dat.Join("<br>"), "window=goals;size=400x400")

USER_VERB(create_crate, R_SPAWN, "Create Crate", \
		"Spawn a crate from a supplypack datum. Append a period to the text in order to exclude subtypes of paths matching the input.", \
		VERB_CATEGORY_EVENT,
		object as text)
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

	var/chosen = input(client, "Select a supply crate type", "Create Crate", matches[1]) as null|anything in matches
	if(!chosen)
		return
	var/datum/supply_packs/the_pack = new chosen()

	var/spawn_location = get_turf(client.mob)
	if(!spawn_location)
		return
	var/obj/structure/closet/crate/crate = the_pack.create_package(spawn_location)
	crate.admin_spawned = TRUE
	for(var/atom/A in crate.contents)
		A.admin_spawned = TRUE
	qdel(the_pack)

	log_admin("[key_name(client)] created a '[chosen]' crate at ([COORD(client.mob)])")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Create Crate") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(global_narrate, R_SERVER|R_EVENT, "Global Narrate", "Narrate text to the whole game world.", VERB_CATEGORY_EVENT)
	var/msg = clean_input("Message:", "Enter the text you wish to appear to everyone:", user = client)

	if(!msg)
		return
	msg = admin_pencode_to_html(msg)
	to_chat(world, "[msg]")
	log_admin("GlobalNarrate: [key_name(client)] : [msg]")
	message_admins(SPAN_BOLDNOTICE("GlobalNarrate: [key_name_admin(client)]: [msg]<BR>"), 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Global Narrate")

USER_VERB(admin_robotize, R_SPAWN, "Make Robot", "Turn the target into a borg.", VERB_CATEGORY_EVENT, mob/M in GLOB.mob_list)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert(client, "Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(client)] has robotized [M.key].")
		spawn(10)
			M:Robotize()

	else
		alert(client, "Invalid mob")

USER_VERB(admin_animalize, R_SPAWN, "Make Simple Animal", "Turn the target into a simple animal.", VERB_CATEGORY_EVENT, mob/M in GLOB.mob_list)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert(client, "Wait until the game starts")
		return

	if(!M)
		alert(client, "That mob doesn't seem to exist, close the panel and try again.")
		return

	if(isnewplayer(M))
		alert(client, "The mob must not be a new_player.")
		return

	log_admin("[key_name(client)] has animalized [M.key].")
	spawn(10)
		M.Animalize()

USER_VERB(admin_make_pai, R_SPAWN, "Make pAI", "Specify a location to spawn a pAI device, then specify a key to play that pAI", VERB_CATEGORY_EVENT, turf/T in GLOB.mob_list)
	var/list/available = list()
	for(var/mob/C in GLOB.mob_list)
		if(C.key)
			available.Add(C)
	var/mob/choice = input(client, "Choose a player to play the pAI", "Spawn pAI") in available
	if(!choice)
		return 0
	if(!isobserver(choice))
		var/confirm = input(client, "[choice.key] isn't ghosting right now. Are you sure you want to yank [choice.p_them()] out of [choice.p_their()] body and place [choice.p_them()] in this pAI?", "Spawn pAI Confirmation", "No") in list("Yes", "No")
		if(confirm != "Yes")
			return 0
	var/obj/item/paicard/card = new(T)
	var/mob/living/silicon/pai/pai = new(card)
	var/raw_name = clean_input("Enter your pAI name:", "pAI Name", "Personal AI", choice, user = client)
	var/new_name = reject_bad_name(raw_name, 1)
	if(new_name)
		pai.name = new_name
		pai.real_name = new_name
	else
		to_chat(client, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")
	pai.real_name = pai.name
	pai.key = choice.key
	card.setPersonality(pai)
	for(var/datum/pai_save/candidate in GLOB.paiController.pai_candidates)
		if(candidate.owner.ckey == choice.ckey)
			GLOB.paiController.pai_candidates.Remove(candidate)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make pAI") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(admin_alienize, R_SPAWN, "Make Alien", "Turn the target mob into an alien.", VERB_CATEGORY_EVENT, mob/M in GLOB.mob_list)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert(client, "Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(client)] has alienized [M.key].")
		spawn(10)
			M:Alienize()
			SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Alien") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		log_admin("[key_name(client)] made [key_name(M)] into an alien.")
		message_admins(SPAN_NOTICE("[key_name_admin(client)] made [key_name(M)] into an alien."), 1)
	else
		alert(client, "Invalid mob")

USER_VERB(admin_slimezie, R_SPAWN, "Make slime", "Turn the target mob into a slime.", VERB_CATEGORY_EVENT, mob/M in GLOB.mob_list)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert(client, "Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(client)] has slimeized [M.key].")
		spawn(10)
			M:slimeize()
			SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Slime") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		log_admin("[key_name(client)] made [key_name(M)] into a slime.")
		message_admins(SPAN_NOTICE("[key_name_admin(client)] made [key_name(M)] into a slime."), 1)
	else
		alert(client, "Invalid mob")

USER_VERB(admin_super, R_SPAWN, "Make Superhero", "Turn the target mob into a superhero.", VERB_CATEGORY_EVENT, mob/M in GLOB.mob_list)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert(client, "Wait until the game starts")
		return
	if(ishuman(M))
		var/type = input(client, "Pick the Superhero","Superhero") as null|anything in GLOB.all_superheroes
		var/datum/superheroes/S = GLOB.all_superheroes[type]
		if(S)
			S.create(M)
		log_admin("[key_name(client)] has turned [M.key] into a Superhero.")
		message_admins(SPAN_NOTICE("[key_name_admin(client)] made [key_name(M)] into a Superhero."), 1)
	else
		alert(client, "Invalid mob")

USER_VERB_VISIBILITY(grant_full_access, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(grant_full_access, R_EVENT, "Grant Full Access", "Gives mob all-access.", VERB_CATEGORY_ADMIN, mob/M in GLOB.mob_list)
	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert(client, "Wait until the game starts")
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
		alert(client, "Invalid mob")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Grant Full Access") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(client)] has granted [M.key] full access.")
	message_admins(SPAN_NOTICE("[key_name_admin(client)] has granted [M.key] full access."), 1)

USER_VERB(toggle_ai_role, R_EVENT, "Toggle AI", "People can't be AI", VERB_CATEGORY_EVENT)
	GLOB.configuration.jobs.allow_ai = !(GLOB.configuration.jobs.allow_ai)
	if(!GLOB.configuration.jobs.allow_ai)
		to_chat(world, "<B>The AI job is no longer chooseable.</B>")
	else
		to_chat(world, "<B>The AI job is chooseable now.</B>")
	message_admins("[key_name_admin(client)] toggled AI allowed.")
	log_admin("[key_name(client)] toggled AI allowed.")
	world.update_status()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle AI") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(spawn_atom, R_SPAWN, "Spawn", \
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
		chosen = tgui_input_list(client, "Select an Atom Type", "Spawn Atom", matches)
		if(!chosen)
			return

	if(ispath(chosen,/turf))
		var/turf/T = get_turf(client.mob.loc)
		T.ChangeTurf(chosen)
	else
		var/atom/A = new chosen(client.mob.loc)
		A.admin_spawned = TRUE

	log_admin("[key_name(client)] spawned [chosen] at ([client.mob.x],[client.mob.y],[client.mob.z])")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Spawn Atom") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB_VISIBILITY(trigger_event, VERB_VISIBILITY_FLAG_MOREDEBUG)
USER_VERB(trigger_event, R_EVENT, "Trigger Event", "Trigger Event", VERB_CATEGORY_EVENT, event_type in SSevents.allEvents)
	if(ispath(event_type))
		new event_type(new /datum/event_meta(EVENT_LEVEL_MAJOR))
		message_admins("[key_name_admin(client)] has triggered an event. ([event_type])", 1)

USER_VERB(event_manager_panel, R_EVENT, "Event Manager Panel", "Event Manager Panel", VERB_CATEGORY_EVENT)
	if(SSevents)
		SSevents.Interact(client)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Event Manager") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_VERB(set_holiday, R_SERVER, "Set Holiday", \
		"Force-set the Holiday variable to make the game think it's a certain day.", \
		VERB_CATEGORY_EVENT, \
		T as text|null)
	var/list/choice = list()
	for(var/H in subtypesof(/datum/holiday))
		choice += "[H]"

	choice += "--CANCEL--"

	var/selected = input(client, "What holiday would you like to force?","Holiday Forcing","--CANCEL--") in choice

	if(selected == "--CANCEL--")
		return

	var/selected2path = text2path(selected)
	if(!ispath(selected2path) || !selected2path)	return

	var/datum/holiday/H = new selected2path
	if(!istype(H))	return

	H.celebrate()
	if(!SSholiday.holidays)
		SSholiday.holidays = list()
	SSholiday.holidays[H.name] = H

	//update our hub status
	world.update_status()

	message_admins(SPAN_NOTICE("ADMIN: Event: [key_name_admin(client)] force-set Holiday to \"[H]\""))
	log_admin("[key_name(client)] force-set Holiday to \"[H]\"")
