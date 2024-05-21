/mob/living/simple_animal/hostile/abductor/agent
	name = "Abductor Agent"
	desc = "A gray alien in an imposing mask."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "abductor_agent"

	loot = list(/obj/effect/mob_spawn/human/corpse/abductor)
	del_on_death = TRUE

	COOLDOWN_DECLARE(next_stun_attack)
	var/obj/item/abductor_baton/baton

/mob/living/simple_animal/hostile/abductor/agent/Initialize(mapload)
	. = ..()
	baton = new

/mob/living/simple_animal/hostile/abductor/agent/ListTargets()
	var/initial_result = ..()
	. = list()
	for(var/mob/possible_target in initial_result)
		var/mob/living/L = possible_target
		if(L && L.has_status_effect(STATUS_EFFECT_STUN))
			continue

		. += possible_target

/mob/living/simple_animal/hostile/abductor/agent/AttackingTarget()
	if(!COOLDOWN_FINISHED(src, next_stun_attack))
		return FALSE

	if(SEND_SIGNAL(target, COMSIG_HOSTILE_ATTACKINGTARGET, src) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return FALSE

	in_melee = TRUE
	var/mob/living/L = target
	if(!istype(L))
		return FALSE

	if(L.has_status_effect(STATUS_EFFECT_STUN))
		LoseAggro()
		return FALSE

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.check_shields(baton, 0, "[src]'s [baton.name]", MELEE_ATTACK))
			playsound(L, 'sound/weapons/genhit.ogg', 50, 1)
			return FALSE

	do_attack_animation(L)
	baton.StunAttack(L, src)
	playsound(loc, 'sound/weapons/egloves.ogg', 50, 1, -1) // this is in baton but baton's loc is in us
	COOLDOWN_START(src, next_stun_attack, 20 SECONDS)
	LoseAggro()

