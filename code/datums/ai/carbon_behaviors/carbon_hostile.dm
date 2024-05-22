/// The most basic AI tree which just finds a guy and then runs at them to click them
/datum/ai_controller/carbon_controller/carbon_hostile
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/carbon_melee_attack_subtree,
	)
