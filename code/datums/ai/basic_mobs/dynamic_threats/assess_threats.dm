/// an attempt to provide a more flexible attack subtree
/// focused more on dynamic threats and threat response levels
/// over existing approaches
/datum/ai_planning_subtree/assess_threats
	var/current_target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/threat_monitor_key = BB_THREAT_MONITOR
	var/list/warn_range = 10
	var/list/attack_range = 5
	var/promote_to_target_behavior
	var/warn_behavior

/datum/ai_planning_subtree/assess_threats/select_behaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()

	// a distaction
	if(controller.blackboard_key_exists(current_target_key))
		return



