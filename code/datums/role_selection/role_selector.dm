/datum/role_selector
	var/list/candidates = list()
	var/probability_of_antag_role_restriction = 100

/datum/role_selector/proc/Debug(text)
	log_chat_debug(text)

/datum/role_selector/proc/add_candidate(mob/new_player/player = null)
	var/datum/role_candidate/candidate = new()
	if(player)
		candidate.load_from_player(player)

	candidates[candidate] = player ? player : FALSE

/datum/role_selector/proc/assign_role(datum/role_candidate/candidate, datum/job/job, latejoin = FALSE)
	if(!job)
		return FALSE

	var/eligible = candidate.get_job_eligibility(job)
	var/available = latejoin ? job.is_position_available() : job.is_spawn_position_available()
	// Debug("Running AR, Player: [player], Rank: [rank], LJ: [latejoin]")

	if(eligible && available)
		candidate.assigned_job_title = job.title
		// candidate.role_alt_title = GetPlayerAltTitle(player, job.title)
		// Debug("Player: [player] is now Rank: [rank], JCP:[job.current_positions], JTP:[job.total_positions], JSP:[job.spawn_positions]")
		// player.mind.assigned_role = rank
		// player.mind.role_alt_title = GetPlayerAltTitle(player, rank)

		// JOB OBJECTIVES OH SHIT
		// player.mind.job_objectives.Cut()
		// for(var/objectiveType in job.required_objectives)
		// 	new objectiveType(player.mind)

		// unassigned -= player
		job.current_positions++
		SSblackbox.record_feedback("nested tally", "manifest", 1, list(job.title, (latejoin ? "latejoin" : "roundstart")))
		return 1

	// Debug("AR has failed, Player: [player], Rank: [rank]")
	return 0

/datum/role_selector/proc/find_job_candidates(datum/job/job, level, flag)
	// Debug("Running FOC, Job: [job], Level: [level], Flag: [flag]")
	var/list/candidates = list()
	for(var/datum/role_candidate/candidate in candidates)
		var/eligible = candidate.get_job_eligibility(job)
		if(!eligible)
			continue
		// // Debug(" - Player: [player] Banned: [jobban_isbanned(player, job.title)] Old Enough: [!job.player_old_enough(player.client)] AvInPlaytime: [job.get_exp_restrictions(player.client)] Flag && Be Special: [flag] && [player.client.prefs.be_special] Job Department: [player.client.prefs.active_character.SSjobs.GetJobDepartment(job, level)] Job Flag: [job.flag] Job Department Flag = [job.department_flag]")
		// if(jobban_isbanned(player, job.title))
		// 	// Debug("FOC isbanned failed, Player: [player]")
		// 	continue
		// if(!job.player_old_enough(player.client))
		// 	// Debug("FOC player not old enough, Player: [player]")
		// 	continue
		// if(job.get_exp_restrictions(player.client))
		// 	// Debug("FOC player not enough playtime, Player: [player]")
		// 	continue
		// if(job.barred_by_disability(player.client))
		// 	// Debug("FOC player has disability rendering them ineligible for job, Player: [player]")
		// 	continue
		// if(job.barred_by_missing_limbs(player.client))
		// 	// Debug("FOC player has missing limbs rendering them ineligible for job, Player: [player]")
		// 	continue
		if(flag && !(flag in candidate.be_special))
		// if(flag && !(flag in player.client.prefs.be_special))
			// Debug("FOC flag failed, Player: [player], Flag: [flag], ")
			continue
		if(job.title in candidate.restricted_roles)
		// if(player.mind && (job.title in player.mind.restricted_roles))
			// Debug("FOC incompatbile with antagonist role, Player: [player]")
			continue
		if(job.title in SSticker.mode.single_antag_positions)
		// if(player.mind && (job.title in SSticker.mode.single_antag_positions))
			if(!prob(probability_of_antag_role_restriction))
				// Debug("Failed probability of getting a second antagonist position in this job, Player: [player], Job:[job.title]")
				continue
			else
				probability_of_antag_role_restriction /= 10
		if(candidate.active_character.GetJobDepartment(job, level) & job.flag)
			// Debug("FOC pass, Player: [player], Level:[level]")
			candidates += candidate
	return candidates

/datum/role_selector/proc/assign_random_job(mob/new_player/player)
	Debug("GRJ Giving random job, Player: [player]")
	for(var/datum/job/job in shuffle(SSjobs.occupations))
		if(!job)
			continue

		if(istype(job, SSjobs.GetJob("Assistant"))) // We don't want to give him assistant, that's boring!
			continue

		if(job.title in GLOB.command_positions) //If you want a command position, select it!
			continue

		if(job.admin_only) // No admin positions either.
			continue

		if(jobban_isbanned(player, job.title))
			Debug("GRJ isbanned failed, Player: [player], Job: [job.title]")
			continue

		if(!job.player_old_enough(player.client))
			Debug("GRJ player not old enough, Player: [player]")
			continue

		if(job.get_exp_restrictions(player.client))
			Debug("GRJ player not enough playtime, Player: [player]")
			continue

		if(job.barred_by_disability(player.client))
			Debug("GRJ player has disability rendering them ineligible for job, Player: [player]")
			continue

		if(job.barred_by_missing_limbs(player.client))
			Debug("GRJ player has missing limbs rendering them ineligible for job, Player: [player]")
			continue

		if(player.mind && (job.title in player.mind.restricted_roles))
			Debug("GRJ incompatible with antagonist role, Player: [player], Job: [job.title]")
			continue
		if(player.mind && (job.title in SSticker.mode.single_antag_positions))
			if(!prob(probability_of_antag_role_restriction))
				Debug("Failed probability of getting a second antagonist position in this job, Player: [player], Job:[job.title]")
				continue
			else
				probability_of_antag_role_restriction /= 10
		if((job.current_positions < job.spawn_positions) || job.spawn_positions == -1)
			Debug("GRJ Random job given, Player: [player], Job: [job]")
			assign_role(player, job.title)
			unassigned -= player
			break

///This proc is called before the level loop of assign_all_roles() and will try to select a head, ignoring ALL non-head preferences for every level until it locates a head or runs out of levels to check
/datum/role_selector/proc/fill_head_position()
	for(var/level = 1 to 3)
		for(var/command_position in GLOB.command_positions)
			var/datum/job/job = SSjobs.GetJob(command_position)
			if(!job)
				continue
			var/list/candidates = find_job_candidates(job, level)
			if(!candidates.len)
				continue

			var/list/filteredCandidates = list()

			for(var/mob/V in candidates)
				// Log-out during round-start? What a bad boy, no head position for you!
				if(!V.client)
					continue
				filteredCandidates += V

			if(!filteredCandidates.len)
				continue

			var/mob/new_player/candidate = pick(filteredCandidates)
			if(assign_role(candidate, command_position))
				return 1

	return 0

///This proc is called at the start of the level loop of assign_all_roles() and will cause head jobs to be checked before any other jobs of the same level
/datum/role_selector/proc/check_command_positions(level)
	for(var/command_position in GLOB.command_positions)
		var/datum/job/job = SSjobs.GetJob(command_position)
		if(!job)
			continue
		var/list/candidates = find_job_candidates(job, level)
		if(!candidates.len)
			continue
		var/mob/new_player/candidate = pick(candidates)
		assign_role(candidate, command_position)


/datum/role_selector/proc/fill_ai_position()
	if(!GLOB.configuration.jobs.allow_ai)
		return FALSE

	var/ai_selected = 0
	var/datum/job/job = SSjobs.GetJob("AI")
	if(!job)
		return 0

	for(var/i = job.total_positions, i > 0, i--)
		for(var/level = 1 to 3)
			var/list/candidates = list()
			candidates = find_job_candidates(job, level)
			if(candidates.len)
				var/mob/new_player/candidate = pick(candidates)
				if(assign_role(candidate, "AI"))
					ai_selected++
					break

		if(ai_selected)
			return 1

		return 0


/** Proc assign_all_roles
*  fills var "assigned_role" for all ready players.
*  This proc must not have any side effect besides of modifying "assigned_role".
**/
/datum/role_selector/proc/assign_all_roles()
	// Lets roughly time this
	var/watch = start_watch()
	//Setup new player list and get the jobs list
	Debug("Running DO")
	SSjobs.SetupOccupations()
	// if(!length(SSjobs.occupations))
	// 	SSjobs.SetupOccupations()

	//Holder for Triumvirate is stored in the ticker, this just processes it
	if(SSticker)
		for(var/datum/job/ai/A in SSjobs.occupations)
			if(SSticker.triai)
				A.spawn_positions = 3

	//Get the players who are ready
	for(var/mob/new_player/player in GLOB.player_list)
		if(player.ready && player.mind && !player.mind.assigned_role)
			add_candidate(player)

	// Debug("DO, Len: [unassigned.len]")
	// if(!length(unassigned))
	if(!length(candidates))
		return FALSE

	//Shuffle players and jobs
	candidates = shuffle(candidates)
	// unassigned = shuffle(unassigned)

	// HandleFeedbackGathering()

	//People who wants to be assistants, sure, go on.
	Debug("DO, Running Assistant Check 1")
	var/datum/job/ast = SSjobs.GetJob("Assistant")
	var/list/assistant_candidates = find_job_candidates(ast, 3)
	Debug("AC1, Candidates: [assistant_candidates.len]")
	for(var/datum/role_candidate/candidate in assistant_candidates)
		assign_role(candidate, ast)
	// for(var/mob/new_player/player in assistant_candidates)
	// 	Debug("AC1 pass, Player: [player]")
	// 	assign_role(player, "Assistant")
	// 	assistant_candidates -= player
	Debug("DO, AC1 end")

	//Select one head
	Debug("DO, Running Head Check")
	fill_head_position()
	Debug("DO, Head Check end")

	//Check for an AI
	Debug("DO, Running AI Check")
	fill_ai_position()
	Debug("DO, AI Check end")

	//Other jobs are now checked
	Debug("DO, Running Standard Check")


	// New job giving system by Donkie
	// This will cause lots of more loops, but since it's only done once it shouldn't really matter much at all.
	// Hopefully this will add more randomness and fairness to job giving.

	// Loop through all levels from high to low
	var/list/shuffledoccupations = shuffle(occupations)
	for(var/level = 1 to 3)
		//Check the head jobs first each level
		check_command_positions(level)

		// Loop through all unassigned players
		for(var/mob/new_player/player in unassigned)

			// Loop through all jobs
			for(var/datum/job/job in shuffledoccupations) // SHUFFLE ME BABY
				if(!job)
					continue

				if(jobban_isbanned(player, job.title))
					Debug("DO isbanned failed, Player: [player], Job:[job.title]")
					continue

				if(!job.player_old_enough(player.client))
					Debug("DO player not old enough, Player: [player], Job:[job.title]")
					continue

				if(job.get_exp_restrictions(player.client))
					Debug("DO player not enough playtime, Player: [player], Job:[job.title]")
					continue

				if(job.barred_by_disability(player.client))
					Debug("DO player has disability rendering them ineligible for job, Player: [player], Job:[job.title]")
					continue

				if(job.barred_by_missing_limbs(player.client))
					Debug("DO player has missing limbs rendering them ineligible for job, Player: [player], Job:[job.title]")
					continue

				if(player.mind && (job.title in player.mind.restricted_roles))
					Debug("DO incompatible with antagonist role, Player: [player], Job:[job.title]")
					continue
				if(player.mind && (job.title in SSticker.mode.single_antag_positions))
					if(!prob(probability_of_antag_role_restriction))
						Debug("Failed probability of getting a second antagonist position in this job, Player: [player], Job:[job.title]")
						continue
					else
						probability_of_antag_role_restriction /= 10
				// If the player wants that job on this level, then try give it to him.
				if(player.client.prefs.active_character.SSjobs.GetJobDepartment(job, level) & job.flag)

					// If the job isn't filled
					if(job.is_spawn_position_available())
						Debug("DO pass, Player: [player], Level:[level], Job:[job.title]")
						Debug(" - Job Flag: [job.flag] Job Department: [player.client.prefs.active_character.SSjobs.GetJobDepartment(job, level)] Job Current Pos: [job.current_positions] Job Spawn Positions = [job.spawn_positions]")
						assign_role(player, job.title)
						unassigned -= player
						break

	// Hand out random jobs to the people who didn't get any in the last check
	// Also makes sure that they got their preference correct
	for(var/mob/new_player/player in unassigned)
		if(player.client.prefs.active_character.alternate_option == GET_RANDOM_JOB)
			assign_random_job(player)

	Debug("DO, Standard Check end")

	Debug("DO, Running AC2")

	// Antags, who have to get in, come first
	for(var/mob/new_player/player in unassigned)
		if(player.mind.special_role)
			if(player.client.prefs.active_character.alternate_option != BE_ASSISTANT)
				assign_random_job(player)
				if(player in unassigned)
					assign_role(player, "Assistant")
			else
				assign_role(player, "Assistant")

	// Then we assign what we can to everyone else.
	for(var/mob/new_player/player in unassigned)
		if(player.client.prefs.active_character.alternate_option == BE_ASSISTANT)
			Debug("AC2 Assistant located, Player: [player]")
			assign_role(player, "Assistant")
		else if(player.client.prefs.active_character.alternate_option == RETURN_TO_LOBBY)
			player.ready = FALSE
			unassigned -= player

	log_debug("Dividing Occupations took [stop_watch(watch)]s")
	return TRUE


GENERAL_PROTECT_DATUM(/datum/role_selector)
