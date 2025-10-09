// Atom investigate stuff
// All of this is stored in a global list because its faster than file IO and we arent ram constrained like TG -aa07
GLOBAL_LIST_EMPTY(investigate_log_wrapper)
GLOBAL_PROTECT(investigate_log_wrapper)

/atom/proc/investigate_log(message, subject)
	if(!message || !subject)
		return

	if(!(subject in GLOB.investigate_log_wrapper))
		GLOB.investigate_log_wrapper[subject] = list()

	GLOB.investigate_log_wrapper[subject] += "<small>[time_stamp()] [UID()] [ADMIN_COORDJMP(src)] </small> || [src] [message]"
