/client/proc/robust_dress_shop(list/potential_minds)
	var/list/special_outfits = list(
		"Naked",
		"As Job...",
		"Custom..."
	)
	if(length(potential_minds))
		special_outfits += "Recover destroyed body..."

	var/list/outfits = list()
	var/list/paths = subtypesof(/datum/outfit) - typesof(/datum/outfit/job) - list(/datum/outfit/varedit, /datum/outfit/admin)
	for(var/path in paths)
		var/datum/outfit/O = path //not much to initalize here but whatever
		if(initial(O.can_be_admin_equipped))
			outfits[initial(O.name)] = path
	outfits = special_outfits + sortTim(outfits, GLOBAL_PROC_REF(cmp_text_asc))

	var/dresscode = input("Select outfit", "Robust quick dress shop") as null|anything in outfits
	if(isnull(dresscode))
		return

	if(outfits[dresscode])
		dresscode = outfits[dresscode]

	if(dresscode == "As Job...")
		var/list/job_paths = subtypesof(/datum/outfit/job)
		var/list/job_outfits = list()
		for(var/path in job_paths)
			var/datum/outfit/O = path
			if(initial(O.can_be_admin_equipped))
				job_outfits[initial(O.name)] = path
		job_outfits = sortTim(job_outfits, GLOBAL_PROC_REF(cmp_text_asc))

		dresscode = input("Select job equipment", "Robust quick dress shop") as null|anything in job_outfits
		dresscode = job_outfits[dresscode]
		if(isnull(dresscode))
			return

	if(dresscode == "Custom...")
		var/list/custom_names = list()
		for(var/datum/outfit/D in GLOB.custom_outfits)
			custom_names[D.name] = D
		var/selected_name = input("Select outfit", "Robust quick dress shop") as null|anything in custom_names
		dresscode = custom_names[selected_name]
		if(isnull(dresscode))
			return

	if(dresscode == "Recover destroyed body...")
		dresscode = input("Select body to rebuild", "Robust quick dress shop") as null|anything in potential_minds

	return dresscode

/client/proc/cmd_admin_toggle_block(mob/M, block)
	if(!check_rights(R_SPAWN))
		return

	if(SSticker.current_state < GAME_STATE_PLAYING)
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		M.dna.SetSEState(block,!M.dna.GetSEState(block))
		singlemutcheck(M, block, MUTCHK_FORCED)
		M.update_mutations()
		var/state = "[M.dna.GetSEState(block) ? "on" : "off"]"
		var/blockname = GLOB.assigned_blocks[block]
		message_admins("[key_name_admin(src)] has toggled [M.key]'s [blockname] block [state]!")
		log_admin("[key_name(src)] has toggled [M.key]'s [blockname] block [state]!")
	else
		alert("Invalid mob")
