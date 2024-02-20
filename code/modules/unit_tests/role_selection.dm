/datum/unit_test/role_selection

/datum/unit_test/role_selection/Run()
	var/datum/role_selector/selector = new()
	var/datum/game_mode/traitor/mode = new()

	var/medium_job_preferences_per_candidate = list(
		list(/datum/job/bartender),
		list(/datum/job/clown),
		list(/datum/job/chemist)
	)

	var/high_job_preferences_per_candidate = list(
		/datum/job/cargo_tech,
		/datum/job/chef,
		/datum/job/chief_engineer
	)

	for(var/i in 1 to 100)
		var/datum/role_candidate/candidate = new()
		candidate.active_character.alternate_option = pick(GET_RANDOM_JOB, BE_ASSISTANT)
		selector.candidates.Add(candidate)

		if(length(medium_job_preferences_per_candidate) >= i)
			for(var/med_jobpref in medium_job_preferences_per_candidate[i])
				candidate.active_character.SetJobPreferenceLevel(med_jobpref, 2)

		if(length(high_job_preferences_per_candidate) >= i)
			var/high_jobpref = high_job_preferences_per_candidate[i]
			candidate.active_character.SetJobPreferenceLevel(high_jobpref, 1)

		if(i < 5)
			candidate.special_role = SPECIAL_ROLE_TRAITOR
			candidate.restricted_roles = mode.restricted_jobs + mode.protected_jobs

	selector.assign_all_roles()

	log_chat_debug("unit_test/role_selection: [length(selector.assigned_candidates)] assigned candidates")
	log_chat_debug("unit_test/role_selection: [length(selector.candidates)] unassigned candidates remaining")

	for(var/i = 1 to length(selector.assigned_candidates))
		var/datum/role_candidate/candidate = selector.assigned_candidates[i]
		var/special_role = candidate.special_role ? "(special role `[candidate.special_role]`)" : ""
		log_chat_debug("role_selection: player=[i] `[candidate.active_character.real_name]` [special_role] assigned `[candidate.assigned_job_title]`")
