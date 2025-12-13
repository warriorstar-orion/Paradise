USER_VERB(list_ssds_afks, R_ADMIN, "List SSDs and AFKs", "List SSDs and AFK players", VERB_CATEGORY_ADMIN)
	/* ======== SSD Section ========= */
	var/msg = "<html><meta charset='utf-8'><head><title>SSD & AFK Report</title></head><body>"
	msg += "SSD Players:<br><TABLE border='1'>"
	msg += "<tr><td><b>Key</b></td><td><b>Real Name</b></td><td><b>Job</b></td><td><b>Mins SSD</b></td><td><b>Special Role</b></td><td><b>Area</b></td><td><b>PPN</b></td><td><b>Cryo</b></td></tr>"
	var/mins_ssd
	var/job_string
	var/key_string
	var/role_string
	var/obj_count = 0
	var/obj_string = ""
	for(var/thing in GLOB.human_list)
		var/mob/living/carbon/human/H = thing
		if(!isLivingSSD(H))
			continue
		mins_ssd = round((world.time - H.last_logout) / 600)
		if(H.job)
			job_string = H.job
		else
			job_string = "-"
		key_string = H.key
		if(job_string in GLOB.command_positions)
			job_string = "<U>" + job_string + "</U>"
		role_string = "-"
		obj_count = 0
		obj_string = ""
		if(H.mind)
			if(H.mind.special_role)
				role_string = "<U>[H.mind.special_role]</U>"
			if(!H.key && H.mind.key)
				key_string = H.mind.key
			for(var/datum/objective/O in GLOB.all_objectives)
				if(O.target == H.mind)
					obj_count++
			if(obj_count > 0)
				obj_string = "<BR><U>Obj Target</U>"
		msg += "<TR><TD>[key_string]</TD><TD>[H.real_name]</TD><TD>[job_string]</TD><TD>[mins_ssd]</TD><TD>[role_string][obj_string]</TD>"
		msg += "<TD>[get_area(H)]</TD><TD>[ADMIN_PP(H,"PP")]</TD>"
		if(istype(H.loc, /obj/machinery/cryopod))
			msg += "<TD><A href='byond://?_src_=holder;cryossd=[H.UID()]'>De-Spawn</A></TD>"
		else
			msg += "<TD><A href='byond://?_src_=holder;cryossd=[H.UID()]'>Cryo</A></TD>"
		msg += "</TR>"
	msg += "</TABLE><br></BODY></HTML>"

	/* ======== AFK Section ========= */
	msg += "AFK Players:<BR><TABLE border='1'>"
	msg += "<TR><TD><B>Key</B></TD><TD><B>Real Name</B></TD><TD><B>Job</B></TD><TD><B>Mins AFK</B></TD><TD><B>Special Role</B></TD><TD><B>Area</B></TD><TD><B>PPN</B></TD><TD><B>Cryo</B></TD></TR>"
	var/mins_afk
	for(var/thing in GLOB.human_list)
		var/mob/living/carbon/human/H = thing
		if(H.client == null || H.stat == DEAD) // No clientless or dead
			continue
		mins_afk = round(H.client.inactivity / 600)
		if(mins_afk < 5)
			continue
		if(H.job)
			job_string = H.job
		else
			job_string = "-"
		key_string = H.key
		if(job_string in GLOB.command_positions)
			job_string = "<U>" + job_string + "</U>"
		role_string = "-"
		obj_count = 0
		obj_string = ""
		if(H.mind)
			if(H.mind.special_role)
				role_string = "<U>[H.mind.special_role]</U>"
			if(!H.key && H.mind.key)
				key_string = H.mind.key
			for(var/datum/objective/O in GLOB.all_objectives)
				if(O.target == H.mind)
					obj_count++
			if(obj_count > 0)
				obj_string = "<BR><U>Obj Target</U>"
		msg += "<TR><TD>[key_string]</TD><TD>[H.real_name]</TD><TD>[job_string]</TD><TD>[mins_afk]</TD><TD>[role_string][obj_string]</TD>"
		msg += "<TD>[get_area(H)]</TD><TD>[ADMIN_PP(H,"PP")]</TD>"
		if(istype(H.loc, /obj/machinery/cryopod))
			msg += "<TD><A href='byond://?_src_=holder;cryossd=[H.UID()];cryoafk=1'>De-Spawn</A></TD>"
		else
			msg += "<TD><A href='byond://?_src_=holder;cryossd=[H.UID()];cryoafk=1'>Cryo</A></TD>"
		msg += "</TR>"
	msg += "</TABLE></BODY></HTML>"
	client << browse(msg, "window=Player_ssd_afk_check;size=600x300")
