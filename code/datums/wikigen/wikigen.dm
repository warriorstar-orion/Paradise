/datum/wikigen
	var/name = "Wiki Content Generator"
	var/output_path_prefix = "data/wikigen/"
	var/output_filename

/datum/wikigen/proc/write_to_output()
	var/content = generate()
	var/output_path = "[output_path_prefix][output_filename]"
	if(fexists(output_path))
		fdel(output_path)
	text2file(content, output_path)

/datum/wikigen/proc/generate()
	SHOULD_CALL_PARENT(FALSE)
