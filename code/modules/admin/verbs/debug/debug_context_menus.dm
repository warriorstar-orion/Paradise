USER_CONTEXT_MENU(call_proc_datum, R_PROCCALL, "\[Admin\] Atom ProcCall", datum/A as null|area|mob|obj|turf)
	if(istype(A, /datum/logging) || istype(A, /datum/log_record))
		message_admins(SPAN_USERDANGER("[key_name_admin(client)] attempted to proc call on a logging object. Inform the host <u>at once</u>."))
		log_admin("[key_name(client)] attempted to proc call on a logging object. Inform the host at once.")
		GLOB.discord_manager.send2discord_simple(DISCORD_WEBHOOK_ADMIN, "[key_name(client)] attempted to proc call on a logging object. Inform the host at once.")
		return

	var/procname = clean_input("Proc name, eg: fake_blood","Proc:", null, user = client)
	if(!procname)
		return

	if(!hascall(A,procname))
		to_chat(client, SPAN_WARNING("Error: callproc_datum(): target has no such call [procname]."))
		return

	var/list/lst = client.get_callproc_args()
	if(!lst)
		return

	if(!A || !IsValidSrc(A))
		to_chat(client, SPAN_WARNING("Error: callproc_datum(): owner of proc no longer exists."))
		return
	message_admins("[key_name_admin(client)] called [A]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")
	log_admin("[key_name(client)] called [A]'s [procname]() with [length(lst) ? "the arguments [list2params(lst)]":"no arguments"]")

	spawn()
		var/returnval = WrapAdminProcCall(A, procname, lst) // Pass the lst as an argument list to the proc
		to_chat(client, SPAN_NOTICE("[procname] returned: [!isnull(returnval) ? returnval : "null"]"))

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Atom Proc-Call") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
