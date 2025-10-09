ADMIN_VERB(jump_to, R_ADMIN, "Jump to...", "Area, Mob, Key or Coordinate", VERB_CATEGORY_ADMIN)
	var/list/choices = list("Area", "Mob", "Key", "Coordinates")

	var/chosen = input(user, null, "Jump to...") as null|anything in choices
	if(!chosen)
		return

	var/jumping // Thing to jump to
	switch(chosen)
		if("Area")
			jumping = input(user, "Area to jump to", "Jump to Area") as null|anything in return_sorted_areas()
			if(jumping)
				return user.jumptoarea(jumping)
		if("Mob")
			jumping = input(user, "Mob to jump to", "Jump to Mob") as null|anything in GLOB.mob_list
			if(jumping)
				return user.jumptomob(jumping)
		if("Key")
			jumping = input(user, "Key to jump to", "Jump to Key") as null|anything in sortKey(GLOB.clients)
			if(jumping)
				return user.jumptokey(jumping)
		if("Coordinates")
			var/x = input(user, "X Coordinate", "Jump to Coordinates") as null|num
			if(!x)
				return
			var/y = input(user, "Y Coordinate", "Jump to Coordinates") as null|num
			if(!y)
				return
			var/z = input(user, "Z Coordinate", "Jump to Coordinates") as null|num
			if(!z)
				return
			return user.jumptocoord(x, y, z)

/client/proc/jumptoarea(area/A)
	if(!A || !check_rights(R_ADMIN))
		return

	var/list/turfs = list()
	for(var/turf/T in A)
		if(T.density)
			continue
		if(locate(/obj/structure/grille) in T) // Quick check to not spawn in windows
			continue
		turfs += T

	var/turf/T = safepick(turfs)
	if(!T)
		to_chat(src, "Nowhere to jump to!")
		return

	if(isobj(usr.loc))
		var/obj/O = usr.loc
		O.force_eject_occupant(usr)

	admin_forcemove(usr, T)
	log_admin("[key_name(usr)] jumped to [A]")
	if(!isobserver(usr))
		message_admins("[key_name_admin(usr)] jumped to [A]")
	BLACKBOX_LOG_ADMIN_VERB("Jump To Area")

/client/proc/jumptomob(mob/M)
	set name = "Jump to Mob"
	if(!M || !check_rights(R_ADMIN))
		return

	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	if(!isobserver(usr))
		message_admins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)
	if(isobj(usr.loc))
		var/obj/O = usr.loc
		O.force_eject_occupant(usr)
	if(src.mob)
		var/mob/A = src.mob
		var/turf/T = get_turf(M)
		if(T && isturf(T))
			BLACKBOX_LOG_ADMIN_VERB("Jump To Mob")
			admin_forcemove(A, M.loc)
		else
			to_chat(A, "This mob is not located in the game world.")

/client/proc/jumptocoord(tx as num, ty as num, tz as num)
	if(!isobserver(usr) && !check_rights(R_ADMIN)) // Only admins can jump without being a ghost
		return

	var/turf/T = locate(tx, ty, tz)
	if(T)
		if(isobj(usr.loc))
			var/obj/O = usr.loc
			O.force_eject_occupant(usr)
		admin_forcemove(usr, T)
		if(isobserver(usr))
			var/mob/dead/observer/O = usr
			O.manual_follow(T)
		BLACKBOX_LOG_ADMIN_VERB("Jump To Coordinate")
	if(!isobserver(usr))
		message_admins("[key_name_admin(usr)] jumped to coordinates [tx], [ty], [tz]")

/client/proc/jumptokey(client/C)
	if(!C?.mob || !check_rights(R_ADMIN))
		return
	var/mob/M = C.mob
	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	if(!isobserver(usr))
		message_admins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)
	if(isobj(usr.loc))
		var/obj/O = usr.loc
		O.force_eject_occupant(usr)
	admin_forcemove(usr, M.loc)
	BLACKBOX_LOG_ADMIN_VERB("Jump To Key")

/proc/admin_forcemove(mob/mover, atom/newloc)
	mover.forceMove(newloc)
	mover.on_forcemove(newloc)

/mob/proc/on_forcemove(atom/newloc)
	return
