
/mob/proc/HasDisease(datum/disease/D)
	for(var/thing in viruses)
		var/datum/disease/DD = thing
		if(DD.IsSame(D))
			return TRUE
	return FALSE


/mob/proc/CanContractDisease(datum/disease/D)
	if(stat == DEAD && !D.allow_dead)
		return FALSE

	if(D.GetDiseaseID() in resistances)
		return FALSE

	if(HasDisease(D))
		return FALSE

	if(istype(D, /datum/disease/advance) && count_by_type(viruses, /datum/disease/advance) > 0)
		return FALSE

	if(!(type in D.viable_mobtypes))
		return -1 //for stupid fucking monkies

	return TRUE


/mob/proc/ContractDisease(datum/disease/D)
	if(!CanContractDisease(D))
		return 0
	AddDisease(D)
	return TRUE


/mob/proc/AddDisease(datum/disease/D, respect_carrier = FALSE)
	var/datum/disease/DD = new D.type(1, D, 0)
	viruses += DD
	DD.affected_mob = src
	GLOB.active_diseases += DD //Add it to the active diseases list, now that it's actually in a mob and being processed.

	//Copy properties over. This is so edited diseases persist.
	var/list/skipped = list("affected_mob","holder","carrier","stage","type","parent_type","vars","transformed")
	if(respect_carrier)
		skipped -= "carrier"
	for(var/V in DD.vars)
		if(V in skipped)
			continue
		if(istype(DD.vars[V],/list))
			var/list/L = D.vars[V]
			DD.vars[V] = L.Copy()
		else
			DD.vars[V] = D.vars[V]

	create_log(MISC_LOG, "has contacted the virus \"[DD]\"")
	DD.affected_mob.med_hud_set_status()


/mob/living/carbon/ContractDisease(datum/disease/D)
	if(!CanContractDisease(D))
		return 0

	if(src.mind && HAS_TRAIT(src.mind, TRAIT_GERMOPHOBE) && prob(85))
		return 0

	var/obj/item/clothing/Cl = null
	var/passed = 1

	var/head_ch = 100
	var/body_ch = 100
	var/hands_ch = 25
	var/feet_ch = 25

	if(D.spread_flags & CONTACT_HANDS)
		head_ch = 0
		body_ch = 0
		hands_ch = 100
		feet_ch = 0
	if(D.spread_flags & CONTACT_FEET)
		head_ch = 0
		body_ch = 0
		hands_ch = 0
		feet_ch = 100

	if(prob(15/D.permeability_mod))
		return

	if(satiety > 0 && prob(satiety/10)) // positive satiety makes it harder to contract the disease.
		return

	var/target_zone = pick(head_ch;1,body_ch;2,hands_ch;3,feet_ch;4)

	if(ishuman(src))
		var/mob/living/carbon/human/H = src

		switch(target_zone)
			if(1)
				if(isobj(H.head) && !istype(H.head, /obj/item/paper))
					Cl = H.head
					passed = prob((Cl.permeability_coefficient*100) - 1)
				if(passed && isobj(H.wear_mask))
					Cl = H.wear_mask
					passed = prob((Cl.permeability_coefficient*100) - 1)
			if(2)
				if(isobj(H.wear_suit))
					Cl = H.wear_suit
					passed = prob((Cl.permeability_coefficient*100) - 1)
				if(passed && isobj(H.w_uniform))
					Cl = H.w_uniform
					passed = prob((Cl.permeability_coefficient*100) - 1)
			if(3)
				if(isobj(H.wear_suit) && H.wear_suit.body_parts_covered&HANDS)
					Cl = H.wear_suit
					passed = prob((Cl.permeability_coefficient*100) - 1)

				if(passed && isobj(H.gloves))
					Cl = H.gloves
					passed = prob((Cl.permeability_coefficient*100) - 1)
			if(4)
				if(isobj(H.wear_suit) && H.wear_suit.body_parts_covered&FEET)
					Cl = H.wear_suit
					passed = prob((Cl.permeability_coefficient*100) - 1)

				if(passed && isobj(H.shoes))
					Cl = H.shoes
					passed = prob((Cl.permeability_coefficient*100) - 1)


	if(!passed && (D.spread_flags & AIRBORNE) && !internal)
		passed = (prob((50*D.permeability_mod) - 1))

	if(passed)
		AddDisease(D)
	return passed


/**
 * Forces the mob to contract a virus. If the mob can have viruses. Ignores clothing and other protection
 * Returns TRUE if it succeeds. False if it doesn't
 *
 * Arguments:
 * * D - the disease the mob will try to contract
 * * respect_carrier - if set to TRUE will not ignore the disease carrier flag
 * * notify_ghosts - will notify ghosts of infection if set to TRUE
 */
//Same as ContractDisease, except never overidden clothes checks
/mob/proc/ForceContractDisease(datum/disease/D, respect_carrier, notify_ghosts = FALSE)
	if(!CanContractDisease(D))
		return FALSE
	if(notify_ghosts)
		for(var/mob/ghost as anything in GLOB.dead_mob_list) //Announce outbreak to dchat
			to_chat(ghost, "<span class='deadsay'><b>Disease outbreak: </b>[src] ([ghost_follow_link(src, ghost)]) [D.carrier ? "is now a carrier of" : "has contracted"] [D]!</span>")
	AddDisease(D, respect_carrier)
	return TRUE


/mob/living/carbon/human/CanContractDisease(datum/disease/D)
	if(HAS_TRAIT(src, TRAIT_VIRUSIMMUNE) && !D.bypasses_immunity)
		return FALSE

	for(var/organ in D.required_organs)
		if(istext(organ) && get_int_organ_datum(organ))
			continue
		if(locate(organ) in internal_organs)
			continue
		if(locate(organ) in bodyparts)
			continue
		return FALSE
	return ..()

/mob/living/carbon/human/monkey/CanContractDisease(datum/disease/D)
	. = ..()
	if(. == -1)
		if(D.viable_mobtypes.Find(/mob/living/carbon/human))
			return 1 //this is stupid as fuck but because monkeys are only half the time actually subtypes of humans they need this

/mob/compressor_grind()
	gib()
