/*
 * Tiny babby plant critter plus procs.
 */

//Mob defines.
#define GESTALT_ALERT "gestalt screen alert"
#define NYMPH_ALERT "nymph screen alert"

/mob/living/simple_animal/diona
	name = "diona nymph"
	icon = 'icons/mob/monkey.dmi'
	icon_state = "nymph"
	icon_living = "nymph"
	icon_dead = "nymph_dead"
	icon_resting = "nymph_sleep"
	pass_flags = PASSTABLE | PASSMOB
	mob_biotypes = MOB_ORGANIC | MOB_PLANT
	mob_size = MOB_SIZE_SMALL
	ventcrawler = VENTCRAWLER_ALWAYS
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

	maxHealth = 50
	health = 50

	voice_name = "diona nymph"
	speak_emote = list("chirrups")
	emote_hear = list("chirrups")
	emote_see = list("chirrups")

	response_help  = "pets"
	response_disarm = "pushes"
	response_harm   = "kicks"

	melee_damage_lower = 5
	melee_damage_upper = 8
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'

	speed = 0
	turns_per_move = 4

	var/list/donors = list()
	holder_type = /obj/item/holder/diona

	var/evolve_donors = 5 //amount of blood donors needed before evolving
	var/awareness_donors = 3 //amount of blood donors needed for understand language
	var/nutrition_need = 500 //amount of nutrition needed before evolving

	var/datum/action/innate/diona/merge/merge_action = new()
	var/datum/action/innate/diona/evolve/evolve_action = new()
	var/datum/action/innate/diona/steal_blood/steal_blood_action = new()

/mob/living/simple_animal/diona/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wears_collar)

/datum/action/innate/diona/merge
	name = "Merge with gestalt"
	button_icon = 'icons/mob/human_races/r_diona.dmi'
	button_icon_state = "preview"

/datum/action/innate/diona/merge/Activate()
	var/mob/living/simple_animal/diona/user = owner
	user.merge()

/datum/action/innate/diona/evolve
	name = "Evolve"
	button_icon = 'icons/obj/cloning.dmi'
	button_icon_state = "pod_cloning"

/datum/action/innate/diona/evolve/Activate()
	var/mob/living/simple_animal/diona/user = owner
	user.evolve()

/datum/action/innate/diona/steal_blood
	name = "Steal blood"
	button_icon = 'icons/goonstation/objects/iv.dmi'
	button_icon_state = "bloodbag"

/datum/action/innate/diona/steal_blood/Activate()
	var/mob/living/simple_animal/diona/user = owner
	user.steal_blood()

/mob/living/simple_animal/diona/Initialize(mapload)
	. = ..()

	if(name == initial(name)) //To stop Pun-Pun becoming generic.
		name = "[name] ([rand(1, 1000)])"
		real_name = name
	add_language("Rootspeak")
	merge_action.Grant(src)
	evolve_action.Grant(src)
	steal_blood_action.Grant(src)

/mob/living/simple_animal/diona/UnarmedAttack(atom/A)
	if(isdiona(A) && (src in A.contents)) //can't attack your gestalt
		visible_message("[src] wiggles around a bit.")
	else
		..()

/mob/living/simple_animal/diona/run_resist()
	if(!split())
		..()

/mob/living/simple_animal/diona/attack_hand(mob/living/carbon/human/M)
	//Let people pick the little buggers up.
	if(M.a_intent == INTENT_HELP)
		if(isdiona(M))
			to_chat(M, "You feel your being twine with that of [src] as it merges with your biomass.")
			to_chat(src, "You feel your being twine with that of [M] as you merge with its biomass.")
			throw_alert(GESTALT_ALERT, /atom/movable/screen/alert/nymph, new_master = src) //adds a screen alert that can call resist
			M.throw_alert(NYMPH_ALERT, /atom/movable/screen/alert/gestalt, new_master = src)
			forceMove(M)
		else if(isrobot(M))
			M.visible_message("<span class='notice'>[M] playfully boops [src] on the head!</span>", "<span class='notice'>You playfully boop [src] on the head!</span>")
		else
			get_scooped(M)
	else
		..()

/mob/living/simple_animal/diona/proc/merge()
	if(stat != CONSCIOUS)
		return FALSE

	var/list/choices = list()
	for(var/mob/living/carbon/human/H in view(1,src))
		if(!(Adjacent(H)) || !isdiona(H))
			continue
		choices += H

	if(!length(choices))
		to_chat(src, "<span class='warning'>No suitable diona nearby.</span>")
		return FALSE

	var/mob/living/M = tgui_input_list(src, "Who do you wish to merge with?", "Nymph Merging", choices)

	if(!M || !src || !(Adjacent(M)) || stat != CONSCIOUS) //input can take a while, so re-validate
		return FALSE

	if(isdiona(M))
		to_chat(M, "You feel your being twine with that of [src] as it merges with your biomass.")
		M.status_flags |= PASSEMOTES
		to_chat(src, "You feel your being twine with that of [M] as you merge with its biomass.")
		forceMove(M)
		throw_alert(GESTALT_ALERT, /atom/movable/screen/alert/nymph, new_master = src) //adds a screen alert that can call resist
		M.throw_alert(NYMPH_ALERT, /atom/movable/screen/alert/gestalt, new_master = src)
		return TRUE
	else
		return FALSE

/mob/living/simple_animal/diona/proc/split(forced = FALSE)
	if((stat != CONSCIOUS && !forced) || !isdiona(loc))
		return FALSE
	var/mob/living/carbon/human/D = loc
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	to_chat(loc, "You feel a pang of loss as [src] splits away from your biomass.")
	to_chat(src, "You wiggle out of the depths of [loc]'s biomass and plop to the ground.")
	forceMove(T)

	var/hasMobs = FALSE
	for(var/atom/A in D.contents)
		if(ismob(A) || istype(A, /obj/item/holder))
			hasMobs = TRUE
	if(!hasMobs)
		D.status_flags &= ~PASSEMOTES
		D.clear_alert(NYMPH_ALERT)

	clear_alert(GESTALT_ALERT)
	return TRUE

/mob/living/simple_animal/diona/proc/evolve()
	if(stat != CONSCIOUS)
		return FALSE

	if(length(donors) < evolve_donors)
		to_chat(src, "<span class='warning'>You need more blood in order to ascend to a new state of consciousness...</span>")
		return FALSE

	if(nutrition < nutrition_need)
		to_chat(src, "<span class='warning'>You need to binge on weeds in order to have the energy to grow...</span>")
		return FALSE

	if(isdiona(loc) && !split()) //if it's merged with diona, needs to able to split before evolving
		return FALSE

	visible_message("<span class='danger'>[src] begins to shift and quiver, and erupts in a shower of shed bark as it splits into a tangle of nearly a dozen new dionaea.</span>","<span class='danger'>You begin to shift and quiver, feeling your awareness splinter. All at once, we consume our stored nutrients to surge with growth, splitting into a tangle of at least a dozen new dionaea. We have attained our gestalt form.</span>")

	if(master_commander)
		to_chat(src, "<span class='userdanger'>As you evolve, your mind grows out of it's restraints. You are no longer loyal to [master_commander]!</span>")

	var/mob/living/carbon/human/diona/adult = new(get_turf(loc))
	adult.set_species(/datum/species/diona)

	if(istype(loc, /obj/item/holder/diona))
		var/obj/item/holder/diona/L = loc
		forceMove(L.loc)
		qdel(L)

	for(var/datum/language/L in languages)
		adult.add_language(L.name)
	adult.regenerate_icons()

	adult.name = "diona ([rand(100,999)])"
	adult.real_name = adult.name
	adult.ckey = ckey
	adult.real_name = adult.dna.species.get_random_name()	//I hate this being here of all places but unfortunately dna is based on real_name!
	// [Nymph -> Diona] is from xenobio (or botany) and does not give vampires usuble blood and cannot be converted by cult.
	ADD_TRAIT(adult.mind, TRAIT_XENOBIO_SPAWNED_HUMAN, ROUNDSTART_TRAIT)

	for(var/obj/item/W in contents)
		drop_item_to_ground(W)

	qdel(src)
	return TRUE

// Consumes plant matter other than weeds to evolve
/mob/living/simple_animal/diona/proc/consume(obj/item/food/grown/G)
	if(nutrition >= nutrition_need) // Prevents griefing by overeating plant items without evolving.
		to_chat(src, "<span class='warning'>You're too full to consume this! Perhaps it's time to grow bigger...</span>")
	else
		if(do_after_once(src, 20, target = G))
			visible_message("[src] ravenously consumes [G].", "You ravenously devour [G].")
			playsound(loc, 'sound/items/eatfood.ogg', 30, FALSE, frequency = 1.5)
			if(G.reagents.get_reagent_amount("nutriment") + G.reagents.get_reagent_amount("plantmatter") < 1)
				adjust_nutrition(2)
			else
				adjust_nutrition((G.reagents.get_reagent_amount("nutriment") + G.reagents.get_reagent_amount("plantmatter")) * 2)
			qdel(G)

/mob/living/simple_animal/diona/proc/steal_blood()
	if(stat != CONSCIOUS)
		return FALSE

	var/list/choices = list()
	for(var/mob/living/carbon/human/H in oview(1,src))
		if(Adjacent(H) && H.dna && !(NO_BLOOD in H.dna.species.species_traits))
			choices += H

	if(!length(choices))
		to_chat(src, "<span class='warning'>No suitable blood donors nearby.</span>")
		return FALSE

	var/mob/living/carbon/human/M = tgui_input_list(src, "Who do you wish to take a sample from?", "Blood Sampling", choices)

	if(!M || !src || !(Adjacent(M)) || stat != CONSCIOUS) //input can take a while, so re-validate
		return FALSE

	if(!M.dna || (NO_BLOOD in M.dna.species.species_traits))
		to_chat(src, "<span class='warning'>That donor has no blood to take.</span>")
		return FALSE

	if(donors.Find(M.real_name))
		to_chat(src, "<span class='warning'>That donor offers you nothing new.</span>")
		return FALSE

	visible_message("<span class='danger'>[src] flicks out a feeler and neatly steals a sample of [M]'s blood.</span>","<span class='danger'>You flick out a feeler and neatly steal a sample of [M]'s blood.</span>")
	donors += M.real_name
	for(var/datum/language/L in M.languages)
		if(!(L.flags & HIVEMIND))
			languages |= L

	spawn(25)
		update_progression()

/mob/living/simple_animal/diona/proc/update_progression()
	if(stat != CONSCIOUS || !length(donors))
		return FALSE

	if(length(donors) == evolve_donors)
		to_chat(src, "<span class='noticealien'>You feel ready to move on to your next stage of growth.</span>")
	else if(length(donors) == awareness_donors)
		universal_understand = TRUE
		to_chat(src, "<span class='noticealien'>You feel your awareness expand, and realize you know how to understand the creatures around you.</span>")
	else
		to_chat(src, "<span class='noticealien'>The blood seeps into your small form, and you draw out the echoes of memories and personality from it, working them into your budding mind.</span>")


/mob/living/simple_animal/diona/put_in_hands(obj/item/W)
	W.forceMove(get_turf(src))
	W.layer = initial(W.layer)
	W.plane = initial(W.plane)
	W.dropped()

/mob/living/simple_animal/diona/put_in_active_hand(obj/item/W)
	to_chat(src, "<span class='warning'>You don't have any hands!</span>")
	return

/mob/living/simple_animal/diona/npc_safe(mob/user)
	if(!jobban_isbanned(user, ROLE_NYMPH))
		return TRUE
	return FALSE

#undef GESTALT_ALERT
#undef NYMPH_ALERT
