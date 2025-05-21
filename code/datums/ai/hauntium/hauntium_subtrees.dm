/datum/ai_planning_subtree/haunted/select_behaviors(datum/ai_controller/controller, seconds_per_tick)
	var/aggro_radius = controller.blackboard[BB_HAUNT_AGGRO_RADIUS]
	var/obj/item/item_pawn = controller.pawn

	if(ismob(item_pawn.loc)) //We're being held, maybe escape?
		if(controller.blackboard[BB_LIKES_EQUIPPER])//don't unequip from people it's okay with
			return
		if(SPT_PROB(HAUNTED_ITEM_ESCAPE_GRASP_CHANCE, seconds_per_tick))
			controller.queue_behavior(/datum/ai_behavior/item_escape_grasp)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(!SPT_PROB(HAUNTED_ITEM_ATTACK_HAUNT_CHANCE, seconds_per_tick))
		return

	var/list/to_haunt_list = controller.blackboard[BB_TO_HAUNT_LIST]

	for(var/mob/living/haunt_target as anything in to_haunt_list)
		if(to_haunt_list[haunt_target] <= 0)
			controller.remove_thing_from_blackboard_key(BB_TO_HAUNT_LIST, haunt_target)
			continue

		if(get_dist(haunt_target, item_pawn) <= aggro_radius)
			controller.set_blackboard_key(BB_HAUNT_TARGET, haunt_target)
			controller.queue_behavior(
				/datum/ai_behavior/item_move_close_and_attack/ghostly/haunted, BB_HAUNT_TARGET, BB_HAUNTED_THROW_ATTEMPT_COUNT)
			return SUBTREE_RETURN_FINISH_PLANNING

	// We couldn't find anyone to attack, start looking around and increasing our haunt counts
	controller.queue_behavior(/datum/ai_behavior/haunted_find_victims)

/datum/ai_behavior/haunted_find_victims

/datum/ai_behavior/haunted_find_victims/setup(datum/ai_controller/controller)
	if(isnull(controller.blackboard[BB_HAUNT_AGGRO_RADIUS]))
		return FALSE
	return TRUE

/datum/ai_behavior/haunted_find_victims/perform(seconds_per_tick, datum/ai_controller/controller)
	var/atom/pawn = controller.pawn
	var/aggro_radius = controller.blackboard[BB_HAUNT_AGGRO_RADIUS]
	// We were given an aggro radius, we'll start attacking people nearby
	for(var/mob/living/victim in view(aggro_radius, pawn))
		if(victim.stat != CONSCIOUS)
			continue
		if(victim.mob_biotypes & MOB_SPIRIT)
			continue
		if(victim.invisibility >= INVISIBILITY_REVENANT)
			continue
		// This gives all mobs in view "5" haunt level
		// For reference picking one up gives "2"
		controller.add_blackboard_key_assoc(BB_TO_HAUNT_LIST, victim, 5)

	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
