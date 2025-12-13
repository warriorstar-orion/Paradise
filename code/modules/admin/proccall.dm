// Wrapper for proccalls where the datum is flagged as vareditted
/proc/WrapAdminProcCall(datum/target, procname, list/arguments)
	if(target && procname == "Del")
		to_chat(usr, "Calling Del() is not allowed")
		return

	if(target != GLOBAL_PROC && !target.CanProcCall(procname))
		to_chat(usr, "Proccall on [target.type]/proc/[procname] is disallowed!")
		return
	var/current_caller = GLOB.AdminProcCaller
	var/ckey = usr ? usr.client.ckey : GLOB.AdminProcCaller
	if(!ckey)
		CRASH("WrapAdminProcCall with no ckey: [target] [procname] [english_list(arguments)]")
	if(current_caller && current_caller != ckey)
		if(!GLOB.AdminProcCallSpamPrevention[ckey])
			to_chat(usr, SPAN_USERDANGER("Another set of admin called procs are still running, your proc will be run after theirs finish."))
			GLOB.AdminProcCallSpamPrevention[ckey] = TRUE
			UNTIL(!GLOB.AdminProcCaller)
			to_chat(usr, SPAN_USERDANGER("Running your proc"))
			GLOB.AdminProcCallSpamPrevention -= ckey
		else
			UNTIL(!GLOB.AdminProcCaller)
	GLOB.LastAdminCalledProc = procname
	if(target != GLOBAL_PROC)
		GLOB.LastAdminCalledTargetUID = target.UID()
	GLOB.AdminProcCaller = ckey	//if this runtimes, too bad for you
	++GLOB.AdminProcCallCount
	try
		. = world.WrapAdminProcCall(target, procname, arguments)
	catch(var/exception/e)
		to_chat(usr, SPAN_USERDANGER("Your proc call failed to execute, likely from runtimes. You <i>should</i> be out of safety mode. If not, god help you. Runtime Info: [e.file]:[e.line]: [e.name]"))

	if(--GLOB.AdminProcCallCount == 0)
		GLOB.AdminProcCaller = null

//adv proc call this, ya nerds
/world/proc/WrapAdminProcCall(datum/target, procname, list/arguments)
	if(target == GLOBAL_PROC)
		return call("/proc/[procname]")(arglist(arguments))
	else if(target != world)
		return call(target, procname)(arglist(arguments))
	else
		to_chat(usr, SPAN_BOLDANNOUNCEOOC("Call to world/proc/[procname] blocked: Advanced ProcCall detected."))
		message_admins("[key_name(usr)] attempted to call world/proc/[procname] with arguments: [english_list(arguments)]")
		log_admin("[key_name(usr)] attempted to call world/proc/[procname] with arguments: [english_list(arguments)]l")

/proc/IsAdminAdvancedProcCall()
#ifdef TESTING
	return FALSE
#else
	return usr && usr.client && GLOB.AdminProcCaller == usr.client.ckey
#endif

/client/proc/get_callproc_args()
	var/argnum = input("Number of arguments","Number:",0) as num|null
	if(argnum <= 0)
		return list() // to allow for calling with 0 args

	argnum = clamp(argnum, 1, 50)

	var/list/lst = list()
	//TODO: make a list to store whether each argument was initialised as null.
	//Reason: So we can abort the proccall if say, one of our arguments was a mob which no longer exists
	//this will protect us from a fair few errors ~Carn

	while(argnum--)
		var/list/value = vv_get_value(restricted_classes = list(VV_RESTORE_DEFAULT))
		var/class = value["class"]
		if(!class)
			return null

		lst += value["value"]
	return lst
