/// Allow an admin to observe someone.
/// mentors are allowed to use this verb while living, but with some stipulations:
/// if they attempt to do anything that would stop their orbit, they will immediately be returned to their body.
USER_VERB(admin_observe, R_ADMIN|R_MOD|R_MENTOR, "Aobserve", "Admin-observe a player mob.", VERB_CATEGORY_ADMIN)
	if(isnewplayer(client.mob))
		to_chat(client, SPAN_WARNING("You cannot aobserve while in the lobby. Please join or observe first."))
		return

	var/mob/target

	target = tgui_input_list(client, "Select a mob to observe", "Aobserve", GLOB.player_list)
	if(isnull(target))
		return
	if(target == client)
		to_chat(client, SPAN_WARNING("You can't observe yourself!"))
		return

	if(isobserver(target))
		to_chat(client, SPAN_WARNING("[target] is a ghost, and cannot be observed."))
		return

	if(isnewplayer(target))
		to_chat(client, SPAN_WARNING("[target] is in the lobby, and cannot be observed."))
		return

	SSuser_verbs.invoke_verb(client, /datum/user_verb/admin_observe_target, target)
