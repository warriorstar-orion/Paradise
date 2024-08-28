/datum/ai_controller/carbon_controller
	movement_delay = 0.4 SECONDS

/datum/ai_controller/carbon_controller/TryPossessPawn(atom/new_pawn)
	if(!iscarbon(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE

	return ..() //Run parent at end

/datum/ai_controller/carbon_controller/able_to_run()
	. = ..()
	if(!isliving(pawn))
		return
	var/mob/living/living_pawn = pawn
	var/incap_flags = NONE
	if(!(ai_traits & CAN_ACT_WHILE_DEAD) && (living_pawn.incapacitated(incap_flags) || living_pawn.stat))
		return FALSE
	// if(ai_traits & PAUSE_DURING_DO_AFTER && LAZYLEN(living_pawn.do_afters))
	// 	return FALSE

// /datum/ai_controller/basic_controller/proc/update_speed(mob/living/basic/basic_mob)
// 	SIGNAL_HANDLER
// 	movement_delay = basic_mob.cached_multiplicative_slowdown
