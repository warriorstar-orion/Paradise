USER_CONTEXT_MENU(select_equipment, R_EVENT, "\[Admin\] Select equipment", mob/living/carbon/human/M in GLOB.human_list)
	if(!ishuman(M) && !isobserver(M))
		alert(client, "Invalid mob")
		return

	var/dresscode = client.robust_dress_shop()

	if(!dresscode)
		return

	var/delete_pocket
	var/mob/living/carbon/human/H
	if(isobserver(M))
		H = M.change_mob_type(/mob/living/carbon/human, null, null, TRUE)
	else
		H = M
		if(H.l_store || H.r_store || H.s_store) //saves a lot of time for admins and coders alike
			if(alert(client, "Should the items in their pockets be dropped? Selecting \"No\" will delete them.", "Robust quick dress shop", "Yes", "No") == "No")
				delete_pocket = TRUE

	for(var/obj/item/I in H.get_equipped_items(delete_pocket))
		qdel(I)
	if(dresscode != "Naked")
		H.equipOutfit(dresscode)

	H.regenerate_icons()

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Select Equipment") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(client)] changed the equipment of [key_name(M)] to [dresscode].")
	message_admins(SPAN_NOTICE("[key_name_admin(client)] changed the equipment of [key_name_admin(M)] to [dresscode]."), 1)

USER_CONTEXT_MENU(change_human_appearance, R_EVENT, "\[Admin\] C.M.A. - Admin", mob/living/carbon/human/H in GLOB.mob_list)
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

	if(client.holder)
		log_and_message_admins("is altering the appearance of [H].")
		H.change_appearance(APPEARANCE_ALL, client.mob, client.mob, check_species_whitelist = 0)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "CMA - Admin") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_CONTEXT_MENU(change_human_appearance_self, R_EVENT, "\[Admin\] C.M.A. - Self",mob/living/carbon/human/H in GLOB.mob_list)
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
		to_chat(client, "Only mobs with clients can alter their own appearance.")
		return

	switch(alert(client, "Do you wish for [H] to be allowed to select non-whitelisted races?","Alter Mob Appearance","Yes","No","Cancel"))
		if("Yes")
			log_and_message_admins("has allowed [H] to change [H.p_their()] appearance, without whitelisting of races.")
			H.change_appearance(APPEARANCE_ALL, H.loc, check_species_whitelist = 0)
		if("No")
			log_and_message_admins("has allowed [H] to change [H.p_their()] appearance, with whitelisting of races.")
			H.change_appearance(APPEARANCE_ALL, H.loc, check_species_whitelist = 1)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "CMA - Self") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_CONTEXT_MENU(make_sound, R_EVENT, "\[Admin\] Make Sound", obj/O in view())
	if(O)
		var/message = clean_input("What do you want the message to be?", "Make Sound", user = client)
		if(!message)
			return
		for(var/mob/V in hearers(O))
			V.show_message(admin_pencode_to_html(message), 2)
		log_admin("[key_name(client)] made [O] at [O.x], [O.y], [O.z] make a sound")
		message_admins(SPAN_NOTICE("[key_name_admin(client)] made [O] at [O.x], [O.y], [O.z] make a sound"))
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Sound") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

USER_CONTEXT_MENU(subtle_message, R_EVENT, "\[Admin\] Subtle Message", mob/M as mob in GLOB.mob_list)
	if(!ismob(M))
		return

	var/msg = clean_input("Message:", "Subtle PM to [M.key]", user = client)

	if(!msg)
		return

	msg = admin_pencode_to_html(msg)

	if(client.holder)
		to_chat(M, "<b>You hear a voice in your head... <i>[msg]</i></b>")

	log_admin("SubtlePM: [key_name(client)] -> [key_name(M)] : [msg]")
	message_admins(SPAN_BOLDNOTICE("Subtle Message: [key_name_admin(client)] -> [key_name_admin(M)] : [msg]"), 1)
	M.create_log(MISC_LOG, "Subtle Message: [msg]", "From: [key_name_admin(client)]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Subtle Message") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
