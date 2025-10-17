/datum/ai_planning_subtree/evaluate_threats
	var/max_range = 11
	var/warn_limit = 0.37
	var/aggress_limit = 0.75

	var/warn_behavior = /datum/ai_behavior/warn_threat
	var/aggress_behavior = /datum/ai_behavior/aggress_threat

/datum/ai_planning_subtree/evaluate_threats/select_behaviors(datum/ai_controller/controller, seconds_per_tick)
	// we've already chosen a target
	if(controller.blackboard_key_exists(BB_BASIC_MOB_CURRENT_TARGET))
		return

	var/datum/targeting_strategy/targeting_strategy = GET_TARGETING_STRATEGY(controller.blackboard[BB_TARGETING_STRATEGY])

	var/list/hearers = list()
	for(var/mob/living/hearer in get_hearers_in_view(max_range, controller.pawn))
		if(hearer == controller.pawn)
			continue
		if(!targeting_strategy.can_attack(controller.pawn, hearer))
			continue

		hearers |= hearer

	if(controller.blackboard_key_exists(BB_THREAT_LEVELS))
		var/list/threats = controller.blackboard[BB_THREAT_LEVELS]
		for(var/threat_uid in threats)
			var/heat = threats[threat_uid]
			if(heat <= 0)
				controller.remove_from_blackboard_lazylist_key(BB_THREAT_LEVELS, threat_uid)

	var/atom/max_threat
	var/max_value = 0

	for(var/mob/living/hearer in hearers)
		var/threat_level = get_threat_level(controller, controller.pawn, hearer)
		if(threat_level > max_value)
			max_value = threat_level
			max_threat = hearer

		controller.set_blackboard_key_assoc_lazylist(BB_THREAT_LEVELS, hearer.UID(), threat_level)

	var/result = "nothing"
	if(max_value >= aggress_limit)
		result = "aggress"
		controller.set_blackboard_key(BB_THREAT_AGGRESS_TARGET, max_threat)
		controller.queue_behavior(aggress_behavior, BB_THREAT_AGGRESS_TARGET)
		. = SUBTREE_RETURN_FINISH_PLANNING
	else if(max_value >= warn_limit)
		result = "warn"
		controller.set_blackboard_key(BB_THREAT_WARN_TARGET, max_threat)
		controller.queue_behavior(warn_behavior, BB_THREAT_WARN_TARGET)

	log_debug("[__PROC__] threat=[max_threat] val=[max_value] hearers.len=[length(hearers)] result=[result] world.time=[world.time]")

/datum/ai_planning_subtree/evaluate_threats/proc/get_threat_level(datum/ai_controller/controller, atom/appraiser, atom/target)
	// very simple distance based but doesn't have to be. could be higher if the
	// threat is close to a nest/tendril, could be lower if their weapons are
	// weaker, etc. etc. plenty of room for creativity here in subtyping.
	//
	// we also pass in the controller so if you wanted to store some metadata on
	// each threat e.g. how quickly are they moving, how long are they standing
	// in one place, if they've attacked you before, etc., you can grab that off
	// the blackboard
	var/d = get_dist(appraiser, target)
	if(d < 3)
		return 1
	return 1 - (d/max_range)

/datum/ai_controller/basic_controller/threat_level
	ai_traits = AI_FLAG_STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/evaluate_threats,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/pig,
	)

/datum/ai_behavior/warn_threat
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	action_cooldown = 2 SECONDS

/datum/ai_behavior/warn_threat/perform(seconds_per_tick, datum/ai_controller/controller, threat_key)
	. = ..()
	var/atom/threat = controller.blackboard[threat_key]

	var/mob/living/living_pawn = controller.pawn
	if(istype(living_pawn))
		living_pawn.custom_emote(EMOTE_VISIBLE, "growls warily at [threat].")
		controller.queue_behavior(/datum/ai_behavior/stop_and_stare, threat_key)

	return AI_BEHAVIOR_SUCCEEDED | AI_BEHAVIOR_INSTANT

/datum/ai_behavior/aggress_threat
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	action_cooldown = 2 SECONDS

/datum/ai_behavior/aggress_threat/perform(seconds_per_tick, datum/ai_controller/controller, threat_key)
	. = ..()
	var/atom/threat = controller.blackboard[threat_key]

	var/mob/living/living_pawn = controller.pawn
	if(istype(living_pawn))
		living_pawn.custom_emote(EMOTE_VISIBLE, "snarls viciously at [threat]!")

	controller.clear_blackboard_key(BB_THREAT_WARN_TARGET)
	controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, threat)

	return AI_BEHAVIOR_SUCCEEDED | AI_BEHAVIOR_INSTANT

/datum/ai_behavior/aggress_threat/finish_action(datum/ai_controller/controller, succeeded, threat_key)
	. = ..()
	controller.clear_blackboard_key(threat_key)

/mob/living/basic/pig/threat_pig
	ai_controller = /datum/ai_controller/basic_controller/threat_level
