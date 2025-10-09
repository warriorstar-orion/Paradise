GLOBAL_LIST_EMPTY(open_logging_views)

ADMIN_VERB(logging_view, R_ADMIN, "Logging View", "Opens the detailed logging viewer", VERB_CATEGORY_ADMIN, list/mob/mobs_to_add = null, clear_view = FALSE)
	var/datum/log_viewer/cur_view = GLOB.open_logging_views[user.ckey]
	if(!cur_view)
		cur_view = new /datum/log_viewer()
		GLOB.open_logging_views[user.ckey] = cur_view
	else if(clear_view)
		cur_view.clear_all()

	if(length(mobs_to_add))
		cur_view.add_mobs(mobs_to_add)

	cur_view.show_ui(user.mob)

ADMIN_VERB(player_panel, R_ADMIN|R_MOD, "Player Panel", "Opens the player panel.", VERB_CATEGORY_ADMIN)
	user.holder.player_panel_new()
	BLACKBOX_LOG_ADMIN_VERB("Player Panel")

ADMIN_VERB(ban_panel, R_BAN, "Ban Panel", "Opens the ban panel.", VERB_CATEGORY_ADMIN)
	user.holder.DB_ban_panel()
	BLACKBOX_LOG_ADMIN_VERB("Ban Panel")

ADMIN_VERB(game_panel, R_ADMIN, "Game Panel", "Opens the game panel.", VERB_CATEGORY_ADMIN)
	user.holder.Game()
	BLACKBOX_LOG_ADMIN_VERB("Game Panel")

ADMIN_VERB(secrets_panel, R_ADMIN, "Secrets", "Opens the secrets panel.", VERB_CATEGORY_ADMIN)
	user.holder.Secrets()
	BLACKBOX_LOG_ADMIN_VERB("Secrets")

ADMIN_VERB(check_antagonists, R_ADMIN, "Check Antagonists", "Open the Antagonists panel.", VERB_CATEGORY_ADMIN)
	user.holder.check_antagonists()
	log_admin("[key_name(user)] checked antagonists")
	BLACKBOX_LOG_ADMIN_VERB("Check Antags")

ADMIN_VERB(check_antagonists_tgui, R_ADMIN, "TGUI - Antagonists", "Open the TGUI Antagonists panel.", VERB_CATEGORY_ADMIN)
	var/datum/ui_module/admin = get_admin_ui_module(/datum/ui_module/admin/antagonist_menu)
	admin.ui_interact(user)
	log_admin("[key_name(user)] checked antagonists")
	BLACKBOX_LOG_ADMIN_VERB("Check Antags2")

ADMIN_VERB(open_law_manager, R_ADMIN, "Manage Silicon Laws", "Open the law manager.", VERB_CATEGORY_ADMIN)
	var/mob/living/silicon/S = input(user, "Select silicon.", "Manage Silicon Laws") as null|anything in GLOB.silicon_mob_list
	if(!S) return

	var/datum/ui_module/law_manager/L = new(S)
	L.ui_interact(user.mob)
	log_and_message_admins("has opened [S]'s law manager.")
	BLACKBOX_LOG_ADMIN_VERB("Manage Silicon Laws")

ADMIN_VERB_VISIBILITY(show_traitor_panel, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(show_traitor_panel, R_ADMIN|R_MOD, "Show Traitor Panel", "Edit mob's memory and role", VERB_CATEGORY_ADMIN, mob/M in GLOB.mob_list)
	if(!istype(M))
		to_chat(user, "This can only be used on instances of type /mob")
		return
	if(!M.mind)
		to_chat(user, "This mob has no mind!")
		return

	M.mind.edit_memory()
	BLACKBOX_LOG_ADMIN_VERB("Show Traitor Panel")

/// Just a simple verb so admins can do manual lookups
ADMIN_VERB(ccbdb_lookup_ckey, R_ADMIN, "Global Ban DB Lookup", "Lookup global bans by ckey.", VERB_CATEGORY_ADMIN)
	var/input_ckey = input(user, "Please enter a ckey to lookup", "Global Ban DB Lookup")
	user.holder.create_ccbdb_lookup(input_ckey)
	BLACKBOX_LOG_ADMIN_VERB("CCBDB Lookup")

ADMIN_VERB(library_manager, R_ADMIN, "Manage Library", "Manage Flagged Books and Perform Maintenance on the Library System", VERB_CATEGORY_ADMIN)
	var/datum/ui_module/library_manager/L = new()
	L.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Manage Library")

ADMIN_VERB(view_msays, R_ADMIN|R_MENTOR, "Msays", "View current round Msays.", VERB_CATEGORY_ADMIN)
	user.display_says(GLOB.msays, "msay")

ADMIN_VERB(view_devsays, R_ADMIN|R_DEV_TEAM, "Devsays", "View current round Devsays.", VERB_CATEGORY_ADMIN)
	user.display_says(GLOB.devsays, "devsay")

ADMIN_VERB(view_asays, R_ADMIN, "Asays", "View current round Asays.", VERB_CATEGORY_ADMIN)
	user.display_says(GLOB.asays, "asay")

ADMIN_VERB(view_staffsays, R_ADMIN|R_DEV_TEAM, "Staffsays", "View current round Staffsays.", VERB_CATEGORY_ADMIN)
	user.display_says(GLOB.staffsays, "staffsay")

ADMIN_VERB(check_new_players, R_MENTOR|R_MOD|R_ADMIN, "Check New Players", "Perform a player account age check.", VERB_CATEGORY_ADMIN)
	var/age = input(user, "Show accounts younger then ____ days", "Age check") as num|null
	var/playtime_hours = input(user, "Show accounts with less than ____ hours", "Playtime check") as num|null
	if(isnull(age))
		age = -1
	if(isnull(playtime_hours))
		playtime_hours = -1
	if(age <= 0 && playtime_hours <= 0)
		return

	var/missing_ages = 0
	var/msg = ""
	var/is_admin = check_rights(R_ADMIN, 0)
	for(var/client/C in GLOB.clients)
		if(C?.holder?.fakekey && !check_rights(R_ADMIN, FALSE))
			continue // Skip those in stealth mode if an admin isnt viewing the panel

		if(!isnum(C.player_age))
			missing_ages = 1
			continue
		if(C.player_age < age)
			if(is_admin)
				msg += "[key_name_admin(C.mob)]: [C.player_age] days old<br>"
			else
				msg += "[key_name_mentor(C.mob)]: [C.player_age] days old<br>"

		var/client_hours = C.get_exp_type_num(EXP_TYPE_LIVING) + C.get_exp_type_num(EXP_TYPE_GHOST)
		client_hours /= 60 // minutes to hours
		if(client_hours < playtime_hours)
			if(is_admin)
				msg += "[key_name_admin(C.mob)]: [client_hours] living + ghost hours<br>"
			else
				msg += "[key_name_mentor(C.mob)]: [client_hours] living + ghost hours<br>"

	if(missing_ages)
		to_chat(user, "Some accounts did not have proper ages set in their clients.  This function requires database to be present")

	if(msg != "")
		user << browse(msg, "window=Player_age_check")
	else
		to_chat(user, "No matches for that age range found.")

ADMIN_VERB(investigate_show, R_ADMIN, "Investigate Round Objects", "View Investigation panel.", VERB_CATEGORY_ADMIN, subject in GLOB.investigate_log_wrapper)
	// Should never happen
	if(!(subject in GLOB.investigate_log_wrapper))
		return

	var/list/entries = GLOB.investigate_log_wrapper[subject]

	var/datum/browser/B = new(usr, "investigatelog", "Investigate ([subject])", 800, 400)
	B.set_content(entries.Join("<br>"))
	B.open()

ADMIN_VERB(edit_admin_permissions, R_PERMISSIONS, "Permissions Panel", "Edit admin permissions", VERB_CATEGORY_ADMIN)
	user.holder.edit_admin_permissions()

ADMIN_VERB(open_zlevel_manager, R_ADMIN, "Z-Level Manager", "Opens the Z-Level Manager.", VERB_CATEGORY_ADMIN)
	if(!SSmapping || !SSmapping.initialized)
		to_chat(user, "<span class='notice'>SSmapping has not initialized yet, Z-Level Manager is not available yet.</span>")
		return

	message_admins("[key_name_admin(user)] is using the Z-Level Manager")
	var/datum/ui_module/admin/z_level_manager/ZLM = get_admin_ui_module(/datum/ui_module/admin/z_level_manager)
	ZLM.ui_interact(user)
