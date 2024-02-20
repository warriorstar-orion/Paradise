/// A datum representing all the information needed to perform roundstart job
/// selection, without actually needing clients.
/datum/role_candidate
	var/account_age_in_days
	var/is_admin = FALSE
	var/admin_rights = 0
	var/is_guest_key = FALSE

	var/datum/character_save/active_character
	var/datum/job_ban_holder/jbh
	var/assigned_job_title = null
	var/list/job_objectives = list()
	var/latejoin = FALSE
	var/exp

	var/list/be_special = list()
	var/list/restricted_roles = list()

/datum/role_candidate/New()
	active_character = new()
	jbh = new()

/datum/role_candidate/proc/is_assigned()
	return assigned_job_title != null

/datum/role_candidate/proc/is_jobbanned(datum/job/job)
	if(GLOB.configuration.jobs.guest_job_ban && is_guest_key)
		return "Guest Job-ban"

	if(job.title in jbh.job_bans)
		var/datum/job_ban/ban = jbh.job_bans[job.title]
		return ban.reason

/datum/role_candidate/proc/is_account_old_enough(datum/job/job)
	if(!GLOB.configuration.jobs.restrict_jobs_on_account_age)
		return 0
	if(!isnum(account_age_in_days))
		return 0
	if(!isnum(job.minimal_player_age))
		return 0

	return max(0, job.minimal_player_age - account_age_in_days)

/datum/role_candidate/proc/load_from_player(mob/new_player/player)
	active_character = player.client.prefs.active_character
	jbh.reload_jobbans(player.client)
	account_age_in_days = player.client.player_age
	be_special = player.client.prefs.be_special
	restricted_roles = player.mind.restricted_roles
	exp = player.client.prefs.exp
	if(player.client.holder)
		is_admin = TRUE
		admin_rights = player.client.holder.rights

/datum/role_candidate/proc/apply_to_player(mob/new_player/player)
	var/datum/job/job = SSjobs.GetJob(assigned_job_title)
	player.mind.assigned_role = assigned_job_title
	player.mind.role_alt_title = active_character.GetPlayerAltTitle(job)
	player.mind.job_objectives.Cut()

	for(var/objective_type in job.required_objectives)
		new objective_type(player.mind)

/datum/role_candidate/proc/get_job_eligibility(datum/job/job)
	if(!job)
		return FALSE
	if(job.job_banned_gamemode)
		return FALSE
	if(is_jobbanned(job))
		return FALSE
	if(!is_account_old_enough(job))
		return FALSE
	if(job.get_exp_restrictions(player.client))
		return FALSE
	if(job.barred_by_disability(player.client))
		return FALSE
	if(job.barred_by_missing_limbs(player.client))
		return FALSE

/datum/role_candidate/proc/get_job_exp_restrictions(datum/job/job)
	if(is_job_playable(job))
		return null

	var/list/play_records = params2list(C.prefs.exp)
	var/list/innertext = list()

	for(var/exp_type in exp_map)
		if(!(exp_type in play_records))
			innertext += "[get_exp_format(exp_map[exp_type])] as [exp_type]"
			continue
		// You may be saying "Jeez why so many text2num()"
		// The DB loads these as strings for some reason, and I also dont trust coders to use ints in the job lists properly
		if(text2num(exp_map[exp_type]) > text2num(play_records[exp_type]))
			var/diff = text2num(exp_map[exp_type]) - text2num(play_records[exp_type])
			innertext += "[get_exp_format(diff)] as [exp_type]"

	if(length(innertext))
		return innertext.Join(", ")

	return null

/datum/role_candidate/proc/check_admin_rights(rights_required)
	if(rights_required)
		if(rights_required & admin_rights)
			return TRUE
	else if(is_admin)
		return TRUE

	return FALSE

/datum/role_candidate/proc/is_job_playable(datum/job/job)
	if(!length(job.exp_map))
		return TRUE // No EXP map, playable
	if(!GLOB.configuration.jobs.enable_exp_restrictions)
		return TRUE // No restrictions, playable
	if(GLOB.configuration.jobs.enable_exp_admin_bypass && check_admin_rights(R_ADMIN))
		return TRUE // Admin user, playable

	// Now look through their EXP
	var/list/play_records = params2list(exp)
	var/success = TRUE

	// Check their requirements
	for(var/exp_type in job.exp_map)
		if(!(exp_type in play_records))
			success = FALSE
			continue
		if(text2num(exp_map[exp_type]) > text2num(play_records[exp_type]))
			success = FALSE

	return success

GENERAL_PROTECT_DATUM(/datum/role_candidate)
