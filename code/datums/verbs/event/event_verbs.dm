ADMIN_VERB(global_narrate, R_SERVER|R_EVENT, "Global Narrate", "Narrate text to the whole game world.", VERB_CATEGORY_EVENT)
	var/msg = clean_input("Message:", "Enter the text you wish to appear to everyone:")

	if(!msg)
		return
	msg = admin_pencode_to_html(msg)
	to_chat(world, "[msg]")
	log_admin("GlobalNarrate: [key_name(user)] : [msg]")
	message_admins("<span class='boldnotice'>GlobalNarrate: [key_name_admin(user)]: [msg]<BR></span>", 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Global Narrate")

ADMIN_VERB(add_random_ai_law, R_EVENT, "Add Random AI Law", "Add a random law to the AI.", VERB_CATEGORY_EVENT)
	var/confirm = alert(user, "You sure?", "Confirm", "Yes", "No")
	if(confirm != "Yes") return
	log_admin("[key_name(user)] has added a random AI law.")
	message_admins("[key_name_admin(user)] has added a random AI law.")

	var/show_log = alert(user, "Show ion message?", "Message", "Yes", "No")
	var/announce_ion_laws = (show_log == "Yes" ? 1 : -1)

	new /datum/event/ion_storm(botEmagChance = 0, announceEvent = announce_ion_laws)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Add Random AI Law")

ADMIN_VERB(modify_station_traits, R_ADMIN, "Modify Station Traits", "Open the station traits panel.", VERB_CATEGORY_EVENT)
	var/static/datum/ui_module/station_traits_panel/station_traits_panel = new
	station_traits_panel.ui_interact(user)

ADMIN_VERB(drop_bomb, R_EVENT, "Drop Bomb", "Cause an explosion of varying strength at your location.", VERB_CATEGORY_EVENT)
	var/turf/epicenter = user.mob.loc
	var/list/choices = list("Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb")
	var/choice = tgui_input_list(user, "What size explosion would you like to produce?", "Drop Bomb", choices)
	switch(choice)
		if(null)
			return 0
		if("Small Bomb")
			explosion(epicenter, 1, 2, 3, 3, cause = "[user.ckey]: Drop Bomb command")
		if("Medium Bomb")
			explosion(epicenter, 2, 3, 4, 4, cause = "[user.ckey]: Drop Bomb command")
		if("Big Bomb")
			explosion(epicenter, 3, 5, 7, 5, cause = "[user.ckey]: Drop Bomb command")
		if("Custom Bomb")
			var/devastation_range = tgui_input_number(user, "Devastation range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(devastation_range))
				return
			var/heavy_impact_range = tgui_input_number(user, "Heavy impact range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(heavy_impact_range))
				return
			var/light_impact_range = tgui_input_number(user, "Light impact range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(light_impact_range))
				return
			var/flash_range = tgui_input_number(user, "Flash range (in tiles):", "Custom Bomb", max_value = 255)
			if(isnull(flash_range))
				return
			explosion(epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range, 1, 1, cause = "[user.ckey]: Drop Bomb command")
	log_admin("[key_name(user)] created an admin explosion at [epicenter.loc]")
	message_admins("<span class='adminnotice'>[key_name_admin(user)] created an admin explosion at [epicenter.loc]</span>")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Drop Bomb") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB(give_spell, R_EVENT, "Give Spell", VERB_NO_DESCRIPTION, VERB_CATEGORY_HIDDEN, mob/T)
	var/list/spell_list = list()
	var/type_length = length("/datum/spell") + 2
	for(var/A in GLOB.spells)
		spell_list[copytext("[A]", type_length)] = A
	var/datum/spell/S = input(user, "Choose the spell to give to that guy", "ABRAKADABRA") as null|anything in spell_list
	if(!S)
		return
	S = spell_list[S]
	if(T.mind)
		T.mind.AddSpell(new S)
	else
		T.AddSpell(new S)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Give Spell") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(user)] gave [key_name(T)] the spell [S].")
	message_admins("[key_name_admin(user)] gave [key_name(T)] the spell [S].", 1)

ADMIN_VERB(give_disease, R_EVENT, "Give Disease", VERB_NO_DESCRIPTION, VERB_CATEGORY_HIDDEN, mob/T)
	var/datum/disease/given_disease = null

	if(tgui_input_list(user, "Create own disease", "Would you like to create your own disease?", list("Yes","No")) == "Yes")
		given_disease = AdminCreateVirus(user)
	else
		given_disease = tgui_input_list(user, "ACHOO", "Choose the disease to give to that guy", GLOB.diseases)

	if(!given_disease)
		return

	if(!istype(given_disease, /datum/disease/advance))
		given_disease = new given_disease
	T.ForceContractDisease(given_disease)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Give Disease") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(user)] gave [key_name(T)] the disease [given_disease].")
	message_admins("<span class='adminnotice'>[key_name_admin(user)] gave [key_name(T)] the disease [given_disease].</span>")

ADMIN_VERB(disease_outbreak, R_EVENT, "Disease Outbreak", "Creates a disease and infects a random player with it.", VERB_CATEGORY_EVENT)
	var/datum/disease/given_disease = null
	if(tgui_input_list(user, "Create own disease", "Would you like to create your own disease?", list("Yes","No")) == "Yes")
		given_disease = AdminCreateVirus(user)
	else
		given_disease = tgui_input_list(user, "ACHOO", "Choose the disease to give to that guy", GLOB.diseases)
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
		message_admins("[key_name_admin(user)] has triggered a custom virus outbreak of [given_advanced_disease.name]! It has these symptoms: [english_list(name_symptoms)] and these base stats [english_map(given_advanced_disease.base_properties)]")
	else
		message_admins("[key_name_admin(user)] has triggered a custom virus outbreak of [given_disease.name]!")

ADMIN_VERB(create_rnd_restore_disk, R_ADMIN, "Create RnD Backup Restore Disk", "Create RnD Backup Restore Disk", VERB_CATEGORY_EVENT)
	var/list/targets = list()

	for(var/rnc_uid in SSresearch.backups)
		var/datum/rnd_backup/B = SSresearch.backups[rnc_uid]

		targets["[B.last_name] - [B.last_timestamp]"] = rnc_uid

	var/choice = input(src, "Select a backup to restore", "RnD Backup Restore") as null|anything in targets
	if(!choice || !(choice in targets))
		return

	var/actual_target = targets[choice]
	if(!(actual_target in SSresearch.backups))
		return

	var/datum/rnd_backup/B = SSresearch.backups[actual_target]
	if(tgui_alert("Are you sure you want to restore this RnD backup? The disk will spawn below your character.", "Are you sure?", list("Yes", "No")) != "Yes")
		return

	B.to_backup_disk(get_turf(user.mob))

ADMIN_VERB(toggle_build_mode_self, R_EVENT, "Toggle Build Mode Self", "Toggle Build Mode on yourself.", VERB_CATEGORY_EVENT)
	if(user.mob)
		togglebuildmode(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Toggle Build Mode")

/client/proc/cmd_admin_robotize(mob/M in GLOB.mob_list)
	set category = "Event"
	set name = "Make Robot"

	if(!check_rights(R_SPAWN))
		return

	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(src)] has robotized [M.key].")
		spawn(10)
			M:Robotize()

	else
		alert("Invalid mob")

/client/proc/cmd_admin_animalize(mob/M in GLOB.mob_list)
	set category = "Event"
	set name = "Make Simple Animal"

	if(!check_rights(R_SPAWN))
		return

	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Wait until the game starts")
		return

	if(!M)
		alert("That mob doesn't seem to exist, close the panel and try again.")
		return

	if(isnewplayer(M))
		alert("The mob must not be a new_player.")
		return

	log_admin("[key_name(src)] has animalized [M.key].")
	spawn(10)
		M.Animalize()


/client/proc/makepAI(turf/T in GLOB.mob_list)
	set category = "Event"
	set name = "Make pAI"
	set desc = "Specify a location to spawn a pAI device, then specify a key to play that pAI"

	if(!check_rights(R_SPAWN))
		return

	var/list/available = list()
	for(var/mob/C in GLOB.mob_list)
		if(C.key)
			available.Add(C)
	var/mob/choice = input("Choose a player to play the pAI", "Spawn pAI") in available
	if(!choice)
		return 0
	if(!isobserver(choice))
		var/confirm = input("[choice.key] isn't ghosting right now. Are you sure you want to yank [choice.p_them()] out of [choice.p_their()] body and place [choice.p_them()] in this pAI?", "Spawn pAI Confirmation", "No") in list("Yes", "No")
		if(confirm != "Yes")
			return 0
	var/obj/item/paicard/card = new(T)
	var/mob/living/silicon/pai/pai = new(card)
	var/raw_name = clean_input("Enter your pAI name:", "pAI Name", "Personal AI", choice)
	var/new_name = reject_bad_name(raw_name, 1)
	if(new_name)
		pai.name = new_name
		pai.real_name = new_name
	else
		to_chat(usr, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")
	pai.real_name = pai.name
	pai.key = choice.key
	card.setPersonality(pai)
	for(var/datum/pai_save/candidate in GLOB.paiController.pai_candidates)
		if(candidate.owner.ckey == choice.ckey)
			GLOB.paiController.pai_candidates.Remove(candidate)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make pAI") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_alienize(mob/M in GLOB.mob_list)
	set category = "Event"
	set name = "Make Alien"

	if(!check_rights(R_SPAWN))
		return

	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(src)] has alienized [M.key].")
		spawn(10)
			M:Alienize()
			SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Alien") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		log_admin("[key_name(usr)] made [key_name(M)] into an alien.")
		message_admins("<span class='notice'>[key_name_admin(usr)] made [key_name(M)] into an alien.</span>", 1)
	else
		alert("Invalid mob")

/client/proc/cmd_admin_slimeize(mob/M in GLOB.mob_list)
	set category = "Event"
	set name = "Make slime"

	if(!check_rights(R_SPAWN))
		return

	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(src)] has slimeized [M.key].")
		spawn(10)
			M:slimeize()
			SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Slime") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		log_admin("[key_name(usr)] made [key_name(M)] into a slime.")
		message_admins("<span class='notice'>[key_name_admin(usr)] made [key_name(M)] into a slime.</span>", 1)
	else
		alert("Invalid mob")

/client/proc/cmd_admin_super(mob/M in GLOB.mob_list)
	set category = "Event"
	set name = "Make Superhero"

	if(!check_rights(R_SPAWN))
		return

	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		var/type = input("Pick the Superhero","Superhero") as null|anything in GLOB.all_superheroes
		var/datum/superheroes/S = GLOB.all_superheroes[type]
		if(S)
			S.create(M)
		log_admin("[key_name(src)] has turned [M.key] into a Superhero.")
		message_admins("<span class='notice'>[key_name_admin(usr)] made [key_name(M)] into a Superhero.</span>", 1)
	else
		alert("Invalid mob")

/client/proc/cmd_admin_add_freeform_ai_law()
	set category = "Event"
	set name = "Add Custom AI law"

	if(!check_rights(R_EVENT))
		return

	var/input = clean_input("Please enter anything you want the AI to do. Anything. Serious.", "What?", "")
	if(!input)
		return

	log_admin("Admin [key_name(usr)] has added a new AI law - [input]")
	message_admins("Admin [key_name_admin(usr)] has added a new AI law - [input]")

	var/show_log = alert(src, "Show ion message?", "Message", "Yes", "No")
	var/announce_ion_laws = (show_log == "Yes" ? 1 : -1)

	new /datum/event/ion_storm(botEmagChance = 0, announceEvent = announce_ion_laws, ionMessage = input)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Add Custom AI Law") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_create_centcom_report()
	set category = "Event"
	set name = "Create Communications Report"

	if(!check_rights(R_SERVER|R_EVENT))
		return

//the stuff on the list is |"report type" = "report title"|, if that makes any sense
	var/list/MsgType = list("Central Command Report" = "Nanotrasen Update",
		"Syndicate Communique" = "Syndicate Message",
		"Space Wizard Federation Message" = "Sorcerous Message",
		"Enemy Communications" = "Unknown Message",
		"Custom" = "Cryptic Message")

	var/list/MsgSound = list("Beep" = 'sound/misc/notice2.ogg',
		"Enemy Communications Intercepted" = 'sound/AI/intercept.ogg',
		"New Command Report Created" = 'sound/AI/commandreport.ogg')

	var/type = input(usr, "Pick a type of report to send", "Report Type", "") as anything in MsgType

	if(type == "Custom")
		type = clean_input("What would you like the report type to be?", "Report Type", "Encrypted Transmission")

	var/subtitle = input(usr, "Pick a title for the report.", "Title", MsgType[type]) as text|null
	if(!subtitle)
		return
	var/message = input(usr, "Please enter anything you want. Anything. Serious.", "What's the message?") as message|null
	if(!message)
		return

	switch(alert("Should this be announced to the general population?", null,"Yes","No", "Cancel"))
		if("Yes")
			var/beepsound = input(usr, "What sound should the announcement make?", "Announcement Sound", "") as anything in MsgSound

			GLOB.major_announcement.Announce(
				message,
				new_title = type,
				new_subtitle = subtitle,
				new_sound = MsgSound[beepsound]
			)
			print_command_report(message, subtitle)
		if("No")
			//same thing as the blob stuff - it's not public, so it's classified, dammit
			GLOB.command_announcer.autosay("A classified message has been printed out at all communication consoles.")
			print_command_report(message, "Classified: [subtitle]")
		else
			return

	log_admin("[key_name(src)] has created a communications report: [message]")
	message_admins("[key_name_admin(src)] has created a communications report", 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Create Comms Report") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_explosion(atom/O as obj|mob|turf in view())
	set category = "Event"
	set name = "Explosion"

	if(!check_rights(R_DEBUG|R_EVENT))
		return

	var/devastation = input("Range of total devastation. -1 to none", "Input")  as num|null
	if(devastation == null) return
	var/heavy = input("Range of heavy impact. -1 to none", "Input")  as num|null
	if(heavy == null) return
	var/light = input("Range of light impact. -1 to none", "Input")  as num|null
	if(light == null) return
	var/flash = input("Range of flash. -1 to none", "Input")  as num|null
	if(flash == null) return
	var/flames = input("Range of flames. -1 to none", "Input")  as num|null
	if(flames == null) return

	if((devastation != -1) || (heavy != -1) || (light != -1) || (flash != -1) || (flames != -1))
		if((devastation > 20) || (heavy > 20) || (light > 20) || (flames > 20))
			if(alert(src, "Are you sure you want to do this? It will laaag.", "Confirmation", "Yes", "No") == "No")
				return

		explosion(O, devastation, heavy, light, flash, null, null,flames, cause = "[ckey]: Explosion command")
		log_admin("[key_name(usr)] created an explosion ([devastation],[heavy],[light],[flames]) at ([O.x],[O.y],[O.z])")
		message_admins("[key_name_admin(usr)] created an explosion ([devastation],[heavy],[light],[flames]) at ([O.x],[O.y],[O.z])")
		BLACKBOX_LOG_ADMIN_VERB("EXPL")
		return
	else
		return

/client/proc/cmd_admin_emp(atom/O as obj|mob|turf in view())
	set category = "Event"
	set name = "EM Pulse"

	if(!check_rights(R_DEBUG|R_EVENT))
		return

	var/heavy = input("Range of heavy pulse.", "Input")  as num|null
	if(heavy == null) return
	var/light = input("Range of light pulse.", "Input")  as num|null
	if(light == null) return

	if(heavy || light)

		empulse(O, heavy, light)
		log_admin("[key_name(usr)] created an EM pulse ([heavy], [light]) at ([O.x],[O.y],[O.z])")
		message_admins("[key_name_admin(usr)] created an EM pulse ([heavy], [light]) at ([O.x],[O.y],[O.z])", 1)
		BLACKBOX_LOG_ADMIN_VERB("EMP")

		return
	else
		return

/client/proc/cmd_admin_gib_self()
	set name = "Gibself"
	set category = "Event"

	if(!check_rights(R_ADMIN|R_EVENT))
		return

	var/confirm = alert(src, "You sure?", "Confirm", "Yes", "No")
	if(confirm == "Yes")
		if(isobserver(mob)) // so they don't spam gibs everywhere
			return
		else
			mob.gib()

		log_admin("[key_name(usr)] used gibself.")
		message_admins("<span class='notice'>[key_name_admin(usr)] used gibself.</span>", 1)
		BLACKBOX_LOG_ADMIN_VERB("Gibself")

/client/proc/everyone_random()
	set category = "Event"
	set name = "Make Everyone Random"
	set desc = "Make everyone have a random appearance. You can only use this before rounds!"

	if(!check_rights(R_SERVER|R_EVENT))
		return

	if(SSticker && SSticker.mode)
		to_chat(usr, "Nope you can't do this, the game's already started. This only works before rounds!")
		return

	if(SSticker.random_players)
		SSticker.random_players = 0
		message_admins("Admin [key_name_admin(usr)] has disabled \"Everyone is Special\" mode.", 1)
		to_chat(usr, "Disabled.")
		return


	var/notifyplayers = alert(src, "Do you want to notify the players?", "Options", "Yes", "No", "Cancel")
	if(notifyplayers == "Cancel")
		return

	log_admin("Admin [key_name(src)] has forced the players to have random appearances.")
	message_admins("Admin [key_name_admin(usr)] has forced the players to have random appearances.", 1)

	if(notifyplayers == "Yes")
		to_chat(world, "<span class='notice'><b>Admin [usr.key] has forced the players to have completely random identities!</b></span>")

	to_chat(usr, "<i>Remember: you can always disable the randomness by using the verb again, assuming the round hasn't started yet</i>.")

	SSticker.random_players = 1
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Everyone Random") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggle_random_events()
	set category = "Event"
	set name = "Toggle random events on/off"

	set desc = "Toggles random events such as meteors, black holes, blob (but not space dust) on/off"
	if(!check_rights(R_SERVER|R_EVENT))
		return

	if(!GLOB.configuration.event.enable_random_events)
		GLOB.configuration.event.enable_random_events = TRUE
		to_chat(usr, "Random events enabled")
		message_admins("Admin [key_name_admin(usr)] has enabled random events.")
	else
		GLOB.configuration.event.enable_random_events = FALSE
		to_chat(usr, "Random events disabled")
		message_admins("Admin [key_name_admin(usr)] has disabled random events.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Random Events") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggle_ert_calling()
	set category = "Event"
	set name = "Toggle ERT"

	set desc = "Toggle the station's ability to call a response team."
	if(!check_rights(R_EVENT))
		return

	if(SSticker.mode.ert_disabled)
		SSticker.mode.ert_disabled = FALSE
		to_chat(usr, "<span class='notice'>ERT has been <b>Enabled</b>.</span>")
		log_admin("Admin [key_name(src)] has enabled ERT calling.")
		message_admins("Admin [key_name_admin(usr)] has enabled ERT calling.", 1)
	else
		SSticker.mode.ert_disabled = TRUE
		to_chat(usr, "<span class='warning'>ERT has been <b>Disabled</b>.</span>")
		log_admin("Admin [key_name(src)] has disabled ERT calling.")
		message_admins("Admin [key_name_admin(usr)] has disabled ERT calling.", 1)

/client/proc/show_tip()
	set category = "Event"
	set name = "Show Custom Tip"
	set desc = "Sends a tip (that you specify) to all players. After all \
		you're the experienced player here."

	if(!check_rights(R_EVENT))
		return

	var/input = input(usr, "Please specify your tip that you want to send to the players.", "Tip", "") as message|null
	if(!input)
		return

	if(SSticker.current_state < GAME_STATE_PREGAME)
		return

	SSticker.selected_tip = input

	// If we've already tipped, then send it straight away.
	if(SSticker.tipped)
		SSticker.send_tip_of_the_round()
		message_admins("[key_name_admin(usr)] sent a custom Tip of the round.")
		log_admin("[key_name(usr)] sent \"[input]\" as the Tip of the Round.")
		return

	message_admins("[key_name_admin(usr)] set the Tip of the round to \"[html_encode(SSticker.selected_tip)]\".")
	log_admin("[key_name(usr)] sent \"[input]\" as the Tip of the Round.")

/client/proc/modify_goals()
	set category = "Event"
	set name = "Modify Station Goals"

	if(!check_rights(R_EVENT))
		return

	holder.modify_goals()

/datum/admins/proc/modify_goals()
	if(SSticker.current_state < GAME_STATE_PLAYING)
		to_chat(usr, "<span class='warning'>This verb can only be used if the round has started.</span>")
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

/datum/admins/proc/toggle_ai()
	set category = "Event"
	set desc="People can't be AI"
	set name="Toggle AI"

	if(!check_rights(R_EVENT))
		return


	GLOB.configuration.jobs.allow_ai = !(GLOB.configuration.jobs.allow_ai)
	if(!GLOB.configuration.jobs.allow_ai)
		to_chat(world, "<B>The AI job is no longer chooseable.</B>")
	else
		to_chat(world, "<B>The AI job is chooseable now.</B>")
	message_admins("[key_name_admin(usr)] toggled AI allowed.")
	log_admin("[key_name(usr)] toggled AI allowed.")
	world.update_status()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle AI") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB_VISIBILITY(trigger_event, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(trigger_event, R_EVENT, "Trigger Event", "Trigger Event", VERB_CATEGORY_EVENT, event_type in SSevents.allEvents)
	if(ispath(event_type))
		new event_type(new /datum/event_meta(EVENT_LEVEL_MAJOR))
		message_admins("[key_name_admin(usr)] has triggered an event. ([event_type])", 1)

ADMIN_VERB(event_manager_panel, R_EVENT, "Event Manager Panel", "Event Manager Panel", VERB_CATEGORY_EVENT)
	if(SSevents)
		SSevents.Interact(usr)
	BLACKBOX_LOG_ADMIN_VERB("Event Manager")
