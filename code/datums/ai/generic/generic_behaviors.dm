///Moves to target then finishes
/datum/ai_behavior/move_to_target
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/move_to_target/perform(seconds_per_tick, datum/ai_controller/controller)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/attack/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	if(!istype(living_pawn) || !isturf(living_pawn.loc))
		return AI_BEHAVIOR_DELAY

	var/atom/movable/attack_target = controller.blackboard[BB_ATTACK_TARGET]
	if(!attack_target || !can_see(living_pawn, attack_target, length = controller.blackboard[BB_VISION_RANGE]))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/mob/living/living_target = attack_target
	if(istype(living_target) && (living_target.stat == DEAD))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

	set_movement_target(controller, living_target)
	attack(controller, living_target)
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/attack/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.clear_blackboard_key(BB_ATTACK_TARGET)

/// A proc representing when the mob is pushed to actually attack the target. Again, subtypes can be used to represent different attacks from different animals, or it can be some other generic behavior
/datum/ai_behavior/attack/proc/attack(datum/ai_controller/controller, mob/living/living_target)
	var/mob/living/living_pawn = controller.pawn
	if(!istype(living_pawn))
		return
	living_pawn.ClickOn(living_target, list())

/// This behavior involves attacking a target.
/datum/ai_behavior/follow
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM

/datum/ai_behavior/follow/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	if(!istype(living_pawn) || !isturf(living_pawn.loc))
		return AI_BEHAVIOR_DELAY

	var/atom/movable/follow_target = controller.blackboard[BB_FOLLOW_TARGET]
	if(!follow_target || get_dist(living_pawn, follow_target) > controller.blackboard[BB_VISION_RANGE])
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/mob/living/living_target = follow_target
	if(istype(living_target) && (living_target.stat == DEAD))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

	set_movement_target(controller, living_target)
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/follow/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.clear_blackboard_key(BB_FOLLOW_TARGET)

/datum/ai_behavior/perform_emote

/datum/ai_behavior/perform_emote/perform(seconds_per_tick, datum/ai_controller/controller, emote, speech_sound)
	var/mob/living/living_pawn = controller.pawn
	if(!istype(living_pawn))
		return AI_BEHAVIOR_INSTANT
	living_pawn.manual_emote(emote)
	if(speech_sound) // Only audible emotes will pass in a sound
		playsound(living_pawn, speech_sound, 80, vary = TRUE)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/perform_speech

/datum/ai_behavior/perform_speech/perform(seconds_per_tick, datum/ai_controller/controller, speech, speech_sound)
	. = ..()

	var/mob/living/living_pawn = controller.pawn
	if(!istype(living_pawn))
		return AI_BEHAVIOR_INSTANT
	living_pawn.say(speech)
	if(speech_sound)
		playsound(living_pawn, speech_sound, 80, vary = TRUE)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/find_nearby

/datum/ai_behavior/find_nearby/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/list/possible_targets = list()
	for(var/atom/thing in view(2, controller.pawn))
		if(!thing.mouse_opacity)
			continue
		if(thing.IsObscured())
			continue
		if(isitem(thing))
			var/obj/item/item = thing
			if(item.flags & ABSTRACT)
				continue
		possible_targets += thing
	if(!possible_targets.len)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	controller.set_blackboard_key(target_key, pick(possible_targets))
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
