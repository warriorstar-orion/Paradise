/client/proc/cleanup_admin_observe(mob/dead/observer/ghost)
	if(!istype(ghost) || !ghost.mob_observed)
		return FALSE

	// un-follow them
	ghost.cleanup_observe()
	// if it's a mentor, make sure they go back to their body.
	if(HAS_TRAIT(mob.mind, TRAIT_MENTOR_OBSERVING))
		// handler will handle removing the trait
		mob.stop_orbit()
	log_admin("[key_name(src)] has de-activated Aobserve")
	BLACKBOX_LOG_ADMIN_VERB("Aobserve")
	return TRUE

ADMIN_VERB_ONLY_CONTEXT_MENU(admin_observe_target, R_ADMIN|R_MOD|R_MENTOR, "\[Admin\] Aobserve", mob/target as mob)
	if(isnewplayer(user.mob))
		to_chat(src, "<span class='warning'>You cannot aobserve while in the lobby. Please join or observe first.</span>")
		return

	if(isnewplayer(target))
		to_chat(src, "<span class='warning'>[target] is currently in the lobby.</span>")
		return

	if(isobserver(target))
		to_chat(src, "<span class='warning'>You can't observe a ghost.</span>")
		return

	var/mob/dead/observer/observer = user.mob
	if(istype(observer) && target == locateUID(observer.mob_observed))
		user.cleanup_admin_observe(user.mob)
		return
	user.cleanup_admin_observe(user.mob)

	if(isnull(target) || target == user.mob)
		// let the default one find the target if there isn't one
		SSadmin_verbs.invoke_verb(user, /datum/admin_verb/admin_observe)
		return

	// observers don't need to ghost, so we don't need to worry about adding any traits
	if(isobserver(user.mob))
		var/mob/dead/observer/ghost = user.mob
		BLACKBOX_LOG_ADMIN_VERB("Aobserve")
		ghost.do_observe(target)
		return

	log_admin("[key_name(user)] has Aobserved out of their body to follow [target]")
	user.do_aghost()
	var/mob/dead/observer/ghost = user.mob

	var/full_admin = check_rights_client(R_ADMIN|R_MOD, FALSE, user)
	if(!full_admin)
		// if they're a me and they're alive, add the MENTOR_OBSERVINGtrait to ensure that they can only go back to their body.
		// we need to handle this here because when you aghost, your mob gets set to the ghost. Oops!
		ADD_TRAIT(user.mob.mind, TRAIT_MENTOR_OBSERVING, MENTOR_OBSERVING)
		RegisterSignal(ghost, COMSIG_ATOM_ORBITER_STOP, TYPE_PROC_REF(/client, on_mentor_observe_end), override = TRUE)
		to_chat(user, "<span class='notice'>You have temporarily observed [target], either move or observe again to un-observe.</span>")
		log_admin("[key_name(user)] has mobserved out of their body to follow [target].")
	else
		log_admin("[key_name(user)] is aobserving [target].")

	ghost.do_observe(target)

/client/proc/on_mentor_observe_end(atom/movable/us, atom/movable/orbited)
	SIGNAL_HANDLER  // COMSIG_ATOM_ORBITER_STOP
	if(!isobserver(mob))
		log_and_message_admins("A mentor somehow managed to end observing while not being a ghost. Please investigate and notify coders.")
		return
	var/mob/dead/observer/ghost = mob

	// just to be safe
	ghost.cleanup_observe()

	REMOVE_TRAIT(mob.mind, TRAIT_MENTOR_OBSERVING, MENTOR_OBSERVING)
	UnregisterSignal(mob, COMSIG_ATOM_ORBITER_STOP)

	if(!ghost.reenter_corpse())
		// tell everyone since this is kinda nasty.
		log_debug("Mentor [key_name_mentor(src)] was unable to re-enter their body after mentor observing.")
		log_and_message_admins("[key_name_mentor(src)] was unable to re-enter their body after mentor observing.")
		to_chat(src, "<span class='userdanger'>Unable to return you to your body after mentor ghosting. If your body still exists, please contact a coder, and you should probably ahelp.</span>")

/client/proc/make_sound(obj/O in view()) // -- TLE
	set name = "\[Admin\] Make Sound"
	set desc = "Display a message to everyone who can hear the target"

	if(!check_rights(R_EVENT))
		return

	if(O)
		var/message = clean_input("What do you want the message to be?", "Make Sound")
		if(!message)
			return
		for(var/mob/V in hearers(O))
			V.show_message(admin_pencode_to_html(message), 2)
		log_admin("[key_name(usr)] made [O] at [O.x], [O.y], [O.z] make a sound")
		message_admins("<span class='notice'>[key_name_admin(usr)] made [O] at [O.x], [O.y], [O.z] make a sound</span>")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Sound") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/change_human_appearance_admin(mob/living/carbon/human/H in GLOB.mob_list)
	set name = "\[Admin\] C.M.A. - Admin"
	set desc = "Allows you to change the mob appearance"

	if(!check_rights(R_EVENT))
		return

	if(!istype(H))
		if(isbrain(H))
			var/mob/living/brain/B = H
			if(istype(B.container, /obj/item/mmi/robotic_brain/positronic))
				var/obj/item/mmi/robotic_brain/positronic/C = B.container
				var/obj/item/organ/internal/brain/mmi_holder/posibrain/P = C.loc
				if(ishuman(P.owner))
					H = P.owner
			else
				return
		else
			return

	if(holder)
		log_and_message_admins("is altering the appearance of [H].")
		H.change_appearance(APPEARANCE_ALL, usr, usr, check_species_whitelist = 0)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "CMA - Admin") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/change_human_appearance_self(mob/living/carbon/human/H in GLOB.mob_list)
	set name = "\[Admin\] C.M.A. - Self"
	set desc = "Allows the mob to change its appearance"

	if(!check_rights(R_EVENT))
		return

	if(!istype(H))
		if(isbrain(H))
			var/mob/living/brain/B = H
			if(istype(B.container, /obj/item/mmi/robotic_brain/positronic))
				var/obj/item/mmi/robotic_brain/positronic/C = B.container
				var/obj/item/organ/internal/brain/mmi_holder/posibrain/P = C.loc
				if(ishuman(P.owner))
					H = P.owner
			else
				return
		else
			return

	if(!H.client)
		to_chat(usr, "Only mobs with clients can alter their own appearance.")
		return

	switch(alert("Do you wish for [H] to be allowed to select non-whitelisted races?","Alter Mob Appearance","Yes","No","Cancel"))
		if("Yes")
			log_and_message_admins("has allowed [H] to change [H.p_their()] appearance, without whitelisting of races.")
			H.change_appearance(APPEARANCE_ALL, H.loc, check_species_whitelist = 0)
		if("No")
			log_and_message_admins("has allowed [H] to change [H.p_their()] appearance, with whitelisting of races.")
			H.change_appearance(APPEARANCE_ALL, H.loc, check_species_whitelist = 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "CMA - Self") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/man_up(mob/T as mob in GLOB.player_list)
	set name = "\[Admin\] Man Up"
	set desc = "Tells mob to man up and deal with it."

	if(!check_rights(R_ADMIN))
		return

	to_chat(T, chat_box_notice_thick("<span class='notice'><b><font size=4>Man up.<br> Deal with it.</font></b><br>Move on.</span>"))
	SEND_SOUND(T, sound('sound/voice/manup1.ogg'))

	log_admin("[key_name(usr)] told [key_name(T)] to man up and deal with it.")
	message_admins("[key_name_admin(usr)] told [key_name(T)] to man up and deal with it.")

/client/proc/update_mob_sprite(mob/living/carbon/human/H as mob)
	set name = "\[Admin\] Update Mob Sprite"
	set desc = "Should fix any mob sprite update errors."

	if(!check_rights(R_ADMIN))
		return

	if(istype(H))
		H.regenerate_icons()

/client/proc/cmd_admin_drop_everything(mob/M as mob in GLOB.mob_list)
	set name = "\[Admin\] Drop Everything"

	if(!check_rights(R_DEBUG|R_ADMIN))
		return

	var/confirm = alert(src, "Make [M] drop everything?", "Message", "Yes", "No")
	if(confirm != "Yes")
		return

	for(var/obj/item/W in M)
		M.drop_item_to_ground(W)

	log_admin("[key_name(usr)] made [key_name(M)] drop everything!")
	message_admins("[key_name_admin(usr)] made [key_name_admin(M)] drop everything!", 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Drop Everything") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_subtle_message(mob/M as mob in GLOB.mob_list)
	set name = "\[Admin\] Subtle Message"

	if(!ismob(M))
		return

	if(!check_rights(R_EVENT))
		return

	var/msg = clean_input("Message:", "Subtle PM to [M.key]")

	if(!msg)
		return

	msg = admin_pencode_to_html(msg)

	if(usr)
		if(usr.client)
			if(usr.client.holder)
				to_chat(M, "<b>You hear a voice in your head... <i>[msg]</i></b>")

	log_admin("SubtlePM: [key_name(usr)] -> [key_name(M)] : [msg]")
	message_admins("<span class='boldnotice'>Subtle Message: [key_name_admin(usr)] -> [key_name_admin(M)] : [msg]</span>", 1)
	M.create_log(MISC_LOG, "Subtle Message: [msg]", "From: [key_name_admin(usr)]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Subtle Message") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_direct_narrate(mob/M)	// Targetted narrate -- TLE
	set name = "\[Admin\] Direct Narrate"

	if(!check_rights(R_SERVER|R_EVENT))
		return

	if(!M)
		M = input("Direct narrate to who?", "Active Players") as null|anything in get_mob_with_client_list()

	if(!M)
		return

	var/msg = clean_input("Message:", "Enter the text you wish to appear to your target:")

	if(!msg)
		return
	msg = admin_pencode_to_html(msg)

	to_chat(M, msg)
	log_admin("DirectNarrate: [key_name(usr)] to ([key_name(M)]): [msg]")
	message_admins("<span class='boldnotice'>Direct Narrate: [key_name_admin(usr)] to ([key_name_admin(M)]): [msg]<br></span>", 1)
	M.create_log(MISC_LOG, "Direct Narrate: [msg]", "From: [key_name_admin(usr)]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Direct Narrate") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_headset_message(mob/M in GLOB.mob_list)
	set name = "\[Admin\] Headset Message"

	admin_headset_message(M)

/client/proc/admin_headset_message(mob/M in GLOB.mob_list, sender = null)
	var/mob/living/carbon/human/H = M

	if(!check_rights(R_EVENT))
		return

	if(!istype(H))
		to_chat(usr, "This can only be used on instances of type /mob/living/carbon/human")
		return
	if(!istype(H.l_ear, /obj/item/radio/headset) && !istype(H.r_ear, /obj/item/radio/headset))
		to_chat(usr, "The person you are trying to contact is not wearing a headset")
		return

	if(!sender)
		sender = input("Who is the message from?", "Sender") as null|anything in list("Centcomm", "Syndicate")
		if(!sender)
			return

	message_admins("[key_name_admin(src)] has started answering [key_name_admin(H)]'s [sender] request.")
	var/input = clean_input("Please enter a message to reply to [key_name(H)] via their headset.", "Outgoing message from [sender]", "")
	if(!input)
		message_admins("[key_name_admin(src)] decided not to answer [key_name_admin(H)]'s [sender] request.")
		return

	log_admin("[key_name(src)] replied to [key_name(H)]'s [sender] message with the message [input].")
	message_admins("[key_name_admin(src)] replied to [key_name_admin(H)]'s [sender] message with: \"[input]\"")
	H.create_log(MISC_LOG, "Headset Message: [input]", "From: [key_name_admin(src)]")
	to_chat(H, "<span class = 'specialnotice bold'>Incoming priority transmission from [sender == "Syndicate" ? "your benefactor" : "Central Command"].  Message as follows[sender == "Syndicate" ? ", agent." : ":"]</span><span class = 'specialnotice'> [input]</span>")
	SEND_SOUND(H, 'sound/effects/headset_message.ogg')

ADMIN_VERB_ONLY_CONTEXT_MENU(jump_to_turf, R_ADMIN, "\[Admin\] Jump to Turf", turf/T in world)
	if(isobj(user.mob.loc))
		var/obj/O = user.mob.loc
		O.force_eject_occupant(user.mob)
	log_admin("[key_name(user)] jumped to [T.x], [T.y], [T.z] in [T.loc]")
	if(!isobserver(user.mob))
		message_admins("[key_name_admin(user.mob)] jumped to [T.x], [T.y], [T.z] in [T.loc]", 1)
	admin_forcemove(user.mob, T)
	BLACKBOX_LOG_ADMIN_VERB("Jump To Turf")

ADMIN_VERB_VISIBILITY(admin_rejuvenate, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB_ONLY_CONTEXT_MENU(admin_rejuvenate, R_REJUVINATE, "\[Admin\] Rejuvenate", mob/living/M as mob in GLOB.mob_list)
	if(!istype(M))
		alert("Cannot revive a ghost")
		return
	M.revive()

	log_admin("[key_name(user)] healed / revived [key_name(M)]")
	message_admins("<span class='warning'>Admin [key_name_admin(user)] healed / revived [key_name_admin(M)]!</span>", 1)
	BLACKBOX_LOG_ADMIN_VERB("Rejuvenate")

ADMIN_VERB_ONLY_CONTEXT_MENU(admin_delete, R_ADMIN, "\[Admin\] Delete", atom/A as obj|mob|turf in view())
	user.admin_delete(A)

/client/proc/admin_delete(datum/D)
	if(istype(D) && !D.can_vv_delete())
		to_chat(src, "[D] rejected your deletion")
		return
	var/atom/A = D
	var/coords = istype(A) ? "at ([A.x], [A.y], [A.z])" : ""
	if(alert(src, "Are you sure you want to delete:\n[D]\n[coords]?", "Confirmation", "Yes", "No") == "Yes")
		log_admin("[key_name(usr)] deleted [D] [coords]")
		message_admins("[key_name_admin(usr)] deleted [D] [coords]", 1)
		BLACKBOX_LOG_ADMIN_VERB("Delete")
		if(isturf(D))
			var/turf/T = D
			T.ChangeTurf(T.baseturf)
		else
			qdel(D)

ADMIN_VERB_ONLY_CONTEXT_MENU(admin_check_contents, R_ADMIN, "\[Admin\] Check Contents", mob/living/M as mob)
	var/list/L = M.get_contents()
	for(var/t in L)
		to_chat(user, "[t]")

	BLACKBOX_LOG_ADMIN_VERB("Check Contents")

ADMIN_VERB_ONLY_CONTEXT_MENU(machine_upgrade, R_DEBUG, "\[Admin\] Tweak Component Ratings", obj/machinery/M as obj in world)
	if(!istype(M))
		to_chat(user, "<span class='danger'>This can only be used on subtypes of /obj/machinery.</span>")
		return

	var/new_rating = input("Enter new rating:","Num") as num
	if(!isnull(new_rating) && M.component_parts)
		for(var/obj/item/stock_parts/P in M.component_parts)
			P.rating = new_rating
		M.RefreshParts()

		message_admins("[key_name_admin(user)] has set the component rating of [M] to [new_rating]")
		log_admin("[key_name(user)] has set the component rating of [M] to [new_rating]")

	BLACKBOX_LOG_ADMIN_VERB("Machine Upgrade")

ADMIN_VERB_AND_CONTEXT_MENU(teleport_mob, R_ADMIN, "Teleport Mob", "Teleport a mob to your location.", VERB_CATEGORY_ADMIN, mob/M in GLOB.mob_list)
	if(!istype(M))
		return

	if(isobj(M.loc))
		var/obj/O = M.loc
		O.force_eject_occupant(M)
	admin_forcemove(M, get_turf(user.mob))
	log_admin("[key_name(user)] teleported [key_name(M)]")
	message_admins("[key_name_admin(user)] teleported [key_name_admin(M)]", 1)
	BLACKBOX_LOG_ADMIN_VERB("Get Mob")

ADMIN_VERB_AND_CONTEXT_MENU(teleport_ckey, R_ADMIN, "Teleport Client", "Teleport a mob to your location by client.", VERB_CATEGORY_ADMIN)
	var/list/keys = list()
	for(var/mob/M in GLOB.player_list)
		keys += M.client
	var/selection = input("Please, select a player!", "Admin Jumping", null, null) as null|anything in sortKey(keys)
	if(!selection)
		return
	var/mob/M = selection:mob

	if(!M)
		return
	log_admin("[key_name(usr)] teleported [key_name(M)]")
	message_admins("[key_name_admin(usr)] teleported [key_name(M)]", 1)
	if(M)
		if(isobj(M.loc))
			var/obj/O = M.loc
			O.force_eject_occupant(M)
		admin_forcemove(M, get_turf(usr))
		admin_forcemove(usr, M.loc)
		BLACKBOX_LOG_ADMIN_VERB("Get Key")

ADMIN_VERB_ONLY_CONTEXT_MENU(admin_freeze, R_ADMIN, "\[Admin\] Freeze", atom/movable/M)
	M.admin_Freeze(user)

/// Allows right clicking mobs to send an admin PM to their client.
/// Forwards the selected mob's client to cmd_admin_pm.
ADMIN_VERB_ONLY_CONTEXT_MENU(admin_pm_target, R_ADMIN|R_MENTOR, "\[Admin\] Admin PM Mob", mob/M as mob)
	if(!ismob(M) || !M.client)
		return
	user.cmd_admin_pm(M.client, null)
	BLACKBOX_LOG_ADMIN_VERB("Admin PM Mob")

ADMIN_VERB_ONLY_CONTEXT_MENU(select_equipment, R_EVENT, "\[Admin\] Select equipment", mob/living/carbon/human/M in GLOB.human_list)
	if(!ishuman(M) && !isobserver(M))
		alert("Invalid mob")
		return

	var/dresscode = user.robust_dress_shop()

	if(!dresscode)
		return

	var/delete_pocket
	var/mob/living/carbon/human/H
	if(isobserver(M))
		H = M.change_mob_type(/mob/living/carbon/human, null, null, TRUE)
	else
		H = M
		if(H.l_store || H.r_store || H.s_store) //saves a lot of time for admins and coders alike
			if(alert("Should the items in their pockets be dropped? Selecting \"No\" will delete them.", "Robust quick dress shop", "Yes", "No") == "No")
				delete_pocket = TRUE

	for(var/obj/item/I in H.get_equipped_items(delete_pocket))
		qdel(I)
	if(dresscode != "Naked")
		H.equipOutfit(dresscode)

	H.regenerate_icons()

	BLACKBOX_LOG_ADMIN_VERB("Select Equipment")
	log_admin("[key_name(user)] changed the equipment of [key_name(M)] to [dresscode].")
	message_admins("<span class='notice'>[key_name_admin(user)] changed the equipment of [key_name_admin(M)] to [dresscode].</span>", 1)
