/**
 * # Pet Command: Follow
 * Tells a pet to follow you until you tell it to do something else
 */
/datum/pet_command/follow
	command_name = "Follow"
	command_desc = "Command your pet to accompany you."
	radial_icon = 'icons/testing/turf_analysis.dmi'
	radial_icon_state = "red_arrow"
	speech_commands = list("heel", "follow")
	// callout_type = /datum/callout_option/move
	///the behavior we use to follow
	var/follow_behavior = /datum/ai_behavior/pet_follow_friend

/datum/pet_command/follow/set_command_active(mob/living/parent, mob/living/commander)
	. = ..()
	set_command_target(parent, commander)

/datum/pet_command/follow/execute_action(datum/ai_controller/controller)
	controller.queue_behavior(follow_behavior, BB_CURRENT_PET_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING
