ADMIN_VERB(execute_sdql2_query, R_PROCCALL, "SDQL2 Query", "Run an SDQL query", VERB_CATEGORY_DEBUG)
	if(!check_rights_client(R_PROCCALL, FALSE, user))  //Shouldn't happen... but just to be safe.
		message_admins("<span class='danger'>ERROR: Non-admin [key_name_admin(user)] attempted to execute a SDQL query!</span>")
		log_admin("Non-admin [key_name(user)] attempted to execute a SDQL query!")
		return

	var/query_text = input("SDQL2 query") as message

	if(!query_text || length(query_text) < 1)
		return

	user.run_sdql2_query(query_text)

ADMIN_VERB(load_sdql2_query, R_PROCCALL, "Load SDQL2 Query", "Load SDQL2 Query from data directory.", VERB_CATEGORY_DEBUG)
	var/list/choices = flist("data/sdql/")
	var/choice = input(src, "Choose an SDQL script to run:", "Load SDQL Query", null) as null|anything in choices
	if(isnull(choice))
		return

	var/script_text = return_file_text("data/sdql/[choice]")
	script_text = input(user, "SDQL2 query", "", script_text) as message

	if(!script_text || length(script_text) < 1)
		return

	user.run_sdql2_query(script_text)
