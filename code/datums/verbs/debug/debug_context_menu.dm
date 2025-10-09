ADMIN_VERB_ONLY_CONTEXT_MENU(call_proc_datum, R_PROCCALL, "\[Admin\] Atom ProcCall", datum/A as null|area|mob|obj|turf)
	if(istype(A, /datum/logging) || istype(A, /datum/log_record))
		message_admins("<span class='userdanger'>[key_name_admin(src)] attempted to proc call on a logging object. Inform the host <u>at once</u>.</span>")
		log_admin("[key_name(src)] attempted to proc call on a logging object. Inform the host at once.")
		GLOB.discord_manager.send2discord_simple(DISCORD_WEBHOOK_ADMIN, "[key_name(src)] attempted to proc call on a logging object. Inform the host at once.")
		return

	var/procname = clean_input("Proc name, eg: fake_blood","Proc:", null)
	if(!procname)
		return

	if(!hascall(A,procname))
		to_chat(usr, "<span class='warning'>Error: callproc_datum(): target has no such call [procname].</span>")
		return

	var/list/lst = user.get_callproc_args()
	if(!lst)
		return

	if(!A || !IsValidSrc(A))
		to_chat(user, "<span class='warning'>Error: callproc_datum(): owner of proc no longer exists.</span>")
		return
	message_admins("[key_name_admin(user)] called [A]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")
	log_admin("[key_name(user)] called [A]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")

	spawn()
		var/returnval = WrapAdminProcCall(A, procname, lst) // Pass the lst as an argument list to the proc
		to_chat(user, "<span class='notice'>[procname] returned: [!isnull(returnval) ? returnval : "null"]</span>")

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Atom Proc-Call") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
