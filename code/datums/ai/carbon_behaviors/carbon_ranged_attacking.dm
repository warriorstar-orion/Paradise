/datum/ai_behavior/carbon_ranged_attack
	action_cooldown = 0.2 SECONDS // We gotta check unfortunately often because we're in a race condition with nextmove
	behavior_flags = AI_BEHAVIOR_REQUIRE_REACH | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	///do we finish this action after hitting once?
	var/terminate_after_action = FALSE
	required_distance = 10

/datum/ai_behavior/carbon_ranged_attack/setup(datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key)
	. = ..()
	if(!controller.blackboard[targeting_strategy_key])
		CRASH("No targeting strategy was supplied in the blackboard for [controller.pawn]")

	//Hiding location is priority
	var/atom/target = controller.blackboard[hiding_location_key] || controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE

	var/mob/living/carbon/carbon = controller.pawn
	carbon.a_intent = INTENT_HARM

/datum/ai_behavior/carbon_ranged_attack/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key)
	var/mob/living/carbon/carbon = controller.pawn
	if (world.time < carbon.next_move)
		return

	carbon.changeNext_move(CLICK_CD_MELEE) //We play fair

	. = ..()

	if(isnull(controller.blackboard[BB_TARGET_GUN_WORKED]))
		controller.set_blackboard_key(BB_TARGET_GUN_WORKED, TRUE)

	//targeting strategy will kill the action if not real anymore
	var/atom/target = controller.blackboard[target_key]
	var/datum/targeting_strategy/targeting_strategy = GET_TARGETING_STRATEGY(controller.blackboard[targeting_strategy_key])

	if(!targeting_strategy.can_attack(carbon, target))
		finish_action(controller, FALSE, target_key)
		return

	var/hiding_target = targeting_strategy.find_hidden_mobs(carbon, target) //If this is valid, theyre hidden in something!

	controller.set_blackboard_key(hiding_location_key, hiding_target)

	var/resolved_target = target || hiding_target

	var/obj/item/gun/gun = carbon.get_active_hand()
	if(!istype(gun))
		gun = carbon.get_inactive_hand()
		if(gun)
			carbon.swap_hand()

	var/can_shoot = gun?.can_shoot() || FALSE

	controller.set_blackboard_key(BB_TARGET_HAS_GUN, gun ? TRUE : FALSE)

	if(resolved_target && gun)
		if(prob(10)) // Artificial miss
			resolved_target = pick(oview(2, resolved_target))

		if(controller.blackboard[BB_TARGET_GUN_WORKED] && prob(95))
			// We attempt to attack even if we can't shoot so we get the effects of pulling the trigger
			carbon.face_atom(resolved_target)
			gun.afterattack__legacy__attackchain(resolved_target, carbon, FALSE)
			controller.set_blackboard_key(BB_TARGET_GUN_WORKED, can_shoot ? TRUE : prob(10)) // Only 20% likely to notice it didn't work
			if(can_shoot)
				controller.set_blackboard_key(BB_TARGET_GUN_WORKED, TRUE)

	if(terminate_after_action)
		finish_action(controller, TRUE, target_key)

/datum/ai_behavior/carbon_ranged_attack/finish_action(datum/ai_controller/controller, succeeded, target_key, targeting_strategy_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		controller.clear_blackboard_key(target_key)

/datum/ai_behavior/carbon_ranged_attack/interact_once
	terminate_after_action = TRUE

/datum/ai_behavior/carbon_ranged_attack/interact_once/finish_action(datum/ai_controller/controller, succeeded, target_key, targeting_strategy_key, hiding_location_key)
	. = ..()
	controller.clear_blackboard_key(target_key)
