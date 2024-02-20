/// A datum representing all the information needed to perform roundstart job
/// selection, without actually needing clients.
/datum/role_candidate
	var/account_age_in_days
	var/admin_rights = 0
	var/is_guest_key = FALSE

	var/datum/character_save/active_character
	var/datum/job_ban_holder/jbh
	var/assigned_job_title = null
	var/list/job_objectives = list()
	var/latejoin = FALSE

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
	be_special = player.client.prefs.be_special.Copy()
	restricted_roles = player.mind.restricted_roles.Copy()

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

GENERAL_PROTECT_DATUM(/datum/role_candidate)
