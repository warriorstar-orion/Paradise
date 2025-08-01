RESTRICT_TYPE(/datum/ai_controller)

/**
 * AI controllers are a datumized form of AI that simulates the input a player
 * would otherwise give to a atom. What this means is that these datums have
 * ways of interacting with a specific atom and control it. They posses a
 * "blackboard" with the information the AI knows and has, and will plan actions
 * it will try to perform  through multiple modular subtrees with behaviors.
*/
/datum/ai_controller
	/// The atom this controller is controlling.
	var/atom/pawn

	/**
	 * This is a list of variables the AI uses and can be mutated by actions.
	 *
	 * When an action is performed you pass this list and any relevant keys for
	 * the variables it can mutate.
	 *
	 * DO NOT set values in the blackboard directly, and especially not if
	 * you're adding a datum reference to this! Use the setters, this is
	 * important for reference handing.
	 */
	var/list/blackboard = list()

	/// Bitfield of traits for this AI to handle extra behavior.
	var/ai_traits = NONE
	/// Current actions planned to be performed by the AI in the upcoming plan.
	var/list/planned_behaviors
	/// Current actions being performed by the AI.
	var/list/current_behaviors
	/// Current actions and their respective last time ran as an assoc list.
	var/list/behavior_cooldowns = list()
	/// Current status of AI (OFF/ON)
	var/ai_status
	/// Current movement target of the AI, generally set by decision making.
	var/atom/current_movement_target
	/// Identifier for what last touched our movement target, so it can be cleared conditionally
	var/movement_target_source
	/// Stored arguments for behaviors given during their initial creation
	var/list/behavior_args = list()
	/// Tracks recent pathing attempts, if we fail too many in a row we fail our current plans.
	var/consecutive_pathing_attempts
	/// Can the AI remain in control if there is a client?
	var/continue_processing_when_client = FALSE
	/// Distance to give up on target.
	var/max_target_distance = 14
	/// Cooldown for new plans, to prevent AI from going nuts if it can't think of new plans and looping on end
	COOLDOWN_DECLARE(failed_planning_cooldown)
	/// All subtrees this AI has available. Will run them in order, so make sure
	/// they're in the order you want them to run. On initialization of this
	/// type, it will start as a typepath(s) and get converted to references of
	/// ai_subtrees found in SSai_controllers when init_subtrees() is called
	var/list/planning_subtrees

	/// The idle behavior this AI performs when it has no actions.
	var/datum/idle_behavior/idle_behavior = null

	// Movement related things here
	/// Reference to the movement datum we use. Is a type on initialize but becomes a ref afterwards.
	var/datum/ai_movement/ai_movement
	/// Delay between movements. This is on the controller so we can keep the movement datum singleton
	var/movement_delay = 0.2 SECONDS

	// TODO: Move the variables below into the blackboard at some point.

	/// AI paused time
	var/paused_until = 0
	/// Can this AI idle?
	var/can_idle = TRUE
	/// What distance should we be checking for interesting things when considering idling/deidling? Defaults to AI_DEFAULT_INTERESTING_DIST
	var/interesting_dist = AI_DEFAULT_INTERESTING_DIST
	/// TRUE if we're able to run, FALSE if we aren't
	/// Should not be set manually, override get_able_to_run() instead
	/// Make sure you hook update_able_to_run() in setup_able_to_run() to whatever parameters changing that you added
	/// Otherwise we will not pay attention to them changing
	var/able_to_run = FALSE
	/// are we currently on failed planning timeout?
	var/on_failed_planning_timeout = FALSE


/datum/ai_controller/New(atom/new_pawn)
	change_ai_movement_type(ai_movement)
	init_subtrees()

	if(idle_behavior)
		idle_behavior = new idle_behavior()

	if(!isnull(new_pawn)) // unit tests need the ai_controller to exist in isolation due to list schenanigans i hate it here
		possess_pawn(new_pawn)

/datum/ai_controller/Destroy(force)
	set_ai_status(AI_STATUS_OFF)
	unpossess_pawn(FALSE)
	set_movement_target(type, null)
	if(ai_movement.moving_controllers[src])
		ai_movement.stop_moving_towards(src)

	LAZYCLEARLIST(planned_behaviors)
	LAZYCLEARLIST(planning_subtrees)
	LAZYCLEARLIST(current_behaviors)

	return ..()

/// Sets the current movement target, with an optional param to override the movement behavior
/datum/ai_controller/proc/set_movement_target(source, atom/target, datum/ai_movement/new_movement)
	if(current_movement_target)
		UnregisterSignal(current_movement_target, list(COMSIG_MOVABLE_MOVED, COMSIG_PARENT_PREQDELETED))
	if(!isnull(target) && !isatom(target))
		stack_trace("[pawn]'s current movement target is [target.type], not an atom")
		cancel_actions()
		return
	movement_target_source = source
	current_movement_target = target
	if(!isnull(current_movement_target))
		RegisterSignal(current_movement_target, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement_target_move))
		RegisterSignal(current_movement_target, COMSIG_PARENT_PREQDELETED, PROC_REF(on_movement_target_delete))
	if(new_movement)
		change_ai_movement_type(new_movement)

/// Overrides the current ai_movement of this controller with a new one
/datum/ai_controller/proc/change_ai_movement_type(datum/ai_movement/new_movement)
	ai_movement = SSai_movement.movement_types[new_movement]

/// Completely replaces the planning_subtrees with a new set based on argument provided.
/// List provided must contain specifically typepaths
/datum/ai_controller/proc/replace_planning_subtrees(list/typepaths_of_new_subtrees)
	planning_subtrees = typepaths_of_new_subtrees
	init_subtrees()

/// Loops over the subtrees in planning_subtrees and looks at the ai_controllers to grab a reference
/// Ensure planning_subtrees are typepaths and not instances/references before executing this!
/datum/ai_controller/proc/init_subtrees()
	if(!LAZYLEN(planning_subtrees))
		return
	var/list/temp_subtree_list = list()
	for(var/subtree in planning_subtrees)
		var/subtree_instance = SSai_controllers.ai_subtrees[subtree]
		temp_subtree_list += subtree_instance
	planning_subtrees = temp_subtree_list

/// Proc to move from one pawn to another. This will destroy the target's existing controller.
/datum/ai_controller/proc/possess_pawn(atom/new_pawn)
	SHOULD_CALL_PARENT(TRUE)

	if(!istype(new_pawn))
		qdel(src)
		CRASH("[src] attempted to attach to null pawn!")

	if(pawn) // Reset any old signals
		unpossess_pawn(FALSE)

	if(istype(new_pawn.ai_controller)) // Existing AI, kill it.
		QDEL_NULL(new_pawn.ai_controller)

	if(try_possess_pawn(new_pawn) & AI_CONTROLLER_INCOMPATIBLE)
		qdel(src)
		CRASH("[src] attached to [new_pawn] but these are not compatible!")

	pawn = new_pawn
	pawn.ai_controller = src

	var/turf/pawn_turf = get_turf(pawn)
	if(pawn_turf)
		SSai_controllers.ai_controllers_by_zlevel[pawn_turf.z] += src

	SEND_SIGNAL(src, COMSIG_AI_CONTROLLER_POSSESSED_PAWN)

	reset_ai_status()
	RegisterSignal(pawn, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_changed_z_level))
	RegisterSignal(pawn, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_changed))
	RegisterSignal(pawn, COMSIG_MOB_LOGIN, PROC_REF(on_sentience_gained))
	RegisterSignal(pawn, COMSIG_PARENT_QDELETING, PROC_REF(on_pawn_qdeleted))
	update_able_to_run()
	setup_able_to_run()

/datum/ai_controller/proc/on_movement_target_move(datum/source)
	SIGNAL_HANDLER // COMSIG_MOVABLE_MOVED
	check_target_max_distance()

/datum/ai_controller/proc/on_movement_target_delete(atom/source)
	SIGNAL_HANDLER // COMSIG_PARENT_PREQDELETED
	set_movement_target(source = type, target = null)

/datum/ai_controller/proc/check_target_max_distance()
	if(get_dist(current_movement_target, pawn) > max_target_distance)
		cancel_actions()

/// Sets the AI on or off based on current conditions, call to reset after you've manually disabled it somewhere
/datum/ai_controller/proc/reset_ai_status()
	set_ai_status(get_expected_ai_status())

/**
 * Gets the AI status we expect the AI controller to be on at this current
 * moment. Returns` AI_STATUS_OFF` if it's inhabited by a client and shouldn't be,
 * if it's dead and cannot act while dead, or is on a z level without clients.
 * Returns AI_STATUS_ON otherwise.
 */
/datum/ai_controller/proc/get_expected_ai_status()
	. = AI_STATUS_ON

	if(!ismob(pawn))
		return

	var/mob/living/mob_pawn = pawn
	if(!continue_processing_when_client && mob_pawn.client)
		. = AI_STATUS_OFF

	if(ai_traits & AI_FLAG_CAN_ACT_WHILE_DEAD)
		return

	if(mob_pawn.stat == DEAD)
		. = AI_STATUS_OFF

	var/turf/pawn_turf = get_turf(mob_pawn)
#ifdef GAME_TESTS
	if(!pawn_turf)
		CRASH("AI controller [src] controlling pawn ([pawn]) is not on a turf.")
#endif
	if(!SSmobs.clients_by_zlevel || !length(SSmobs.clients_by_zlevel[pawn_turf.z]) || on_failed_planning_timeout)
		. = AI_STATUS_OFF

/// Called when the AI controller pawn changes z levels.
/// We check if there's any clients on the new one and wake up the AI if there is.
/datum/ai_controller/proc/on_changed_z_level(atom/source, turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	SIGNAL_HANDLER // COMSIG_MOVABLE_Z_CHANGED

	if(ismob(pawn))
		var/mob/mob_pawn = pawn
		if(mob_pawn?.client && !continue_processing_when_client)
			return
	if(old_turf)
		SSai_controllers.ai_controllers_by_zlevel[old_turf.z] -= src
	if(new_turf)
		SSai_controllers.ai_controllers_by_zlevel[new_turf.z] += src
		var/new_level_clients = length(SSmobs.clients_by_zlevel[new_turf.z])
		if(new_level_clients)
			set_ai_status(AI_STATUS_IDLE)
		else
			set_ai_status(AI_STATUS_OFF)

/// Abstract proc for initializing the pawn to the new controller
/datum/ai_controller/proc/try_possess_pawn(atom/new_pawn)
	return

/// Proc for deinitializing the pawn to the old controller
/datum/ai_controller/proc/unpossess_pawn(destroy)
	if(isnull(pawn))
		return // instantiated without an applicable pawn, fine

	UnregisterSignal(pawn, list(COMSIG_MOB_LOGIN, COMSIG_MOB_LOGOUT, COMSIG_MOB_STATCHANGE, COMSIG_PARENT_QDELETING))
	if(ai_movement.moving_controllers[src])
		ai_movement.stop_moving_towards(src)
	var/turf/pawn_turf = get_turf(pawn)
	if(pawn_turf)
		SSai_controllers.ai_controllers_by_zlevel[pawn_turf.z] -= src
	if(ai_status)
		SSai_controllers.ai_controllers_by_status[ai_status] -= src
	pawn.ai_controller = null
	pawn = null
	if(destroy)
		qdel(src)

/datum/ai_controller/proc/setup_able_to_run()
	// paused_until is handled by PauseAi() manually
	RegisterSignals(pawn, list(SIGNAL_ADDTRAIT(TRAIT_AI_PAUSED), SIGNAL_REMOVETRAIT(TRAIT_AI_PAUSED)), PROC_REF(update_able_to_run))

/datum/ai_controller/proc/clear_able_to_run()
	UnregisterSignal(pawn, list(SIGNAL_ADDTRAIT(TRAIT_AI_PAUSED), SIGNAL_REMOVETRAIT(TRAIT_AI_PAUSED)))

/datum/ai_controller/proc/update_able_to_run()
	SIGNAL_HANDLER
	var/run_flags = get_able_to_run()
	if(run_flags & AI_UNABLE_TO_RUN)
		able_to_run = FALSE
		GLOB.move_manager.stop_looping(pawn) //stop moving
	else
		able_to_run = TRUE
	set_ai_status(get_expected_ai_status(), run_flags)

/// Returns TRUE if the ai controller can actually run at the moment, FALSE otherwise
/datum/ai_controller/proc/get_able_to_run()
	if(HAS_TRAIT(pawn, TRAIT_AI_PAUSED))
		return AI_UNABLE_TO_RUN
	if(world.time < paused_until)
		return AI_UNABLE_TO_RUN
	return NONE

/datum/ai_controller/proc/ai_can_interact()
	SHOULD_CALL_PARENT(TRUE)
	return !QDELETED(pawn)

///Interact with objects
/datum/ai_controller/proc/ai_interact(target, intent, list/modifiers)
	if(!ai_can_interact())
		return FALSE

	var/atom/final_target = isdatum(target) ? target : blackboard[target] //incase we got a blackboard key instead

	if(QDELETED(final_target))
		return FALSE
	var/params = list2params(modifiers)
	var/mob/living/living_pawn = pawn
	if(isnull(intent))
		living_pawn.ClickOn(final_target, params)
		return TRUE

	var/old_intent = living_pawn.a_intent
	living_pawn.a_intent = intent
	living_pawn.ClickOn(final_target, params)
	living_pawn.a_intent = old_intent
	return TRUE

/// Runs any actions that are currently running
/datum/ai_controller/process(seconds_per_tick)
	// AI controllers were implemented on /tg/ after the deltatime conversion:
	// https://github.com/tgstation/tgstation/pull/52981
	// The practical side-effect of this is that the values we call "seconds_per_tick"
	// in the AI controller implementation are actually the managing subsystem's `wait`.
	seconds_per_tick /= (1 SECONDS)

	if(!able_to_run)
		GLOB.move_manager.stop_looping(pawn) //stop moving
		return //this should remove them from processing in the future through event-based stuff.

	if(!LAZYLEN(current_behaviors) && idle_behavior)
		idle_behavior.perform_idle_behavior(seconds_per_tick, src) //Do some stupid shit while we have nothing to do
		return

	for(var/datum/ai_behavior/current_behavior as anything in current_behaviors)
		// Convert the current behaviour action cooldown to realtime seconds from deciseconds.current_behavior
		// Then pick the max of this and the seconds_per_tick passed to ai_controller.process()
		// Action cooldowns cannot happen faster than seconds_per_tick, so seconds_per_tick should be the value used in this scenario.
		var/action_seconds_per_tick = max(current_behavior.get_cooldown(src) * 0.1, seconds_per_tick)

		if(current_behavior.behavior_flags & AI_BEHAVIOR_REQUIRE_MOVEMENT) //Might need to move closer
			if(isnull(current_movement_target))
				fail_behavior(current_behavior)
				return

			// Stops pawns from performing such actions that should require the target to be adjacent.
			var/atom/movable/moving_pawn = pawn
			var/can_reach = !(current_behavior.behavior_flags & AI_BEHAVIOR_REQUIRE_REACH) || moving_pawn.can_reach_nested_adjacent(current_movement_target)
			if(can_reach && current_behavior.required_distance >= get_dist(moving_pawn, current_movement_target)) // Are we close enough to engage?
				if(ai_movement.moving_controllers[src] == current_movement_target) // We are close enough, if we're moving stop.
					ai_movement.stop_moving_towards(src)

				if(behavior_cooldowns[current_behavior] > world.time) // Still on cooldown
					continue
				process_behavior(action_seconds_per_tick, current_behavior)
				return

			else if(ai_movement.moving_controllers[src] != current_movement_target) // We're too far, if we're not already moving start doing it.
				ai_movement.start_moving_towards(src, current_movement_target, current_behavior.required_distance) // Then start moving

			if(current_behavior.behavior_flags & AI_BEHAVIOR_MOVE_AND_PERFORM) // If we can move and perform then do so.
				if(behavior_cooldowns[current_behavior] > world.time) // Still on cooldown
					continue
				process_behavior(action_seconds_per_tick, current_behavior)
				return
		else // No movement required
			if(behavior_cooldowns[current_behavior] > world.time) // Still on cooldown
				continue
			process_behavior(action_seconds_per_tick, current_behavior)
			return

/// Determines whether the AI can currently make a new plan.
/datum/ai_controller/proc/able_to_plan()
	. = TRUE
	if(QDELETED(pawn))
		return FALSE
	for(var/datum/ai_behavior/current_behavior as anything in current_behaviors)
		if(!(current_behavior.behavior_flags & AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION)) // We have a behavior that blocks planning
			return FALSE

/// This is where you decide what actions are taken by the AI.
/datum/ai_controller/proc/select_behaviors(seconds_per_tick)
	SHOULD_NOT_SLEEP(TRUE)

	if(!COOLDOWN_FINISHED(src, failed_planning_cooldown))
		return FALSE

	LAZYINITLIST(current_behaviors)
	LAZYCLEARLIST(planned_behaviors)

	if(LAZYLEN(planning_subtrees))
		for(var/datum/ai_planning_subtree/subtree as anything in planning_subtrees)
			if(subtree.select_behaviors(src, seconds_per_tick) == SUBTREE_RETURN_FINISH_PLANNING)
				break

	for(var/datum/ai_behavior/current_behavior as anything in current_behaviors)
		if(LAZYACCESS(planned_behaviors, current_behavior))
			continue
		var/list/arguments = list(src, FALSE)
		var/list/stored_arguments = behavior_args[type]
		if(stored_arguments)
			arguments += stored_arguments
		current_behavior.finish_action(arglist(arguments))

/// This proc handles changing AI status, and starts/stops processing if required.
/datum/ai_controller/proc/set_ai_status(new_ai_status)
	if(ai_status == new_ai_status)
		return FALSE // no change

	// remove old status, if we've got one
	if(ai_status)
		SSai_controllers.ai_controllers_by_status[ai_status] -= src
	ai_status = new_ai_status
	SSai_controllers.ai_controllers_by_status[new_ai_status] += src
	switch(ai_status)
		if(AI_STATUS_ON)
			START_PROCESSING(SSai_behaviors, src)
		if(AI_STATUS_OFF, AI_STATUS_IDLE)
			STOP_PROCESSING(SSai_behaviors, src)
			cancel_actions()

/datum/ai_controller/proc/pause_ai(time)
	paused_until = world.time + time

/datum/ai_controller/proc/modify_cooldown(datum/ai_behavior/behavior, new_cooldown)
	behavior_cooldowns[behavior] = new_cooldown

/// Call this to add a behavior to the stack.
/datum/ai_controller/proc/queue_behavior(behavior_type, ...)
	var/datum/ai_behavior/behavior = GET_AI_BEHAVIOR(behavior_type)
	if(!behavior)
		CRASH("Behavior [behavior_type] not found.")
	var/list/arguments = args.Copy()
	arguments[1] = src

	// It's still in the plan, don't add it again to current_behaviors
	// but do keep it in the planned behavior list so its not cancelled
	if(LAZYACCESS(current_behaviors, behavior))
		LAZYADDASSOC(planned_behaviors, behavior, TRUE)
		return

	if(!behavior.setup(arglist(arguments)))
		return
	LAZYADDASSOC(current_behaviors, behavior, TRUE)
	LAZYADDASSOC(planned_behaviors, behavior, TRUE)
	arguments.Cut(1, 2)
	if(length(arguments))
		behavior_args[behavior_type] = arguments
	else
		behavior_args -= behavior_type
	SEND_SIGNAL(src, AI_CONTROLLER_BEHAVIOR_QUEUED(behavior_type), arguments)

/datum/ai_controller/proc/process_behavior(seconds_per_tick, datum/ai_behavior/behavior)
	var/list/arguments = list(seconds_per_tick, src)
	var/list/stored_arguments = behavior_args[behavior.type]
	if(stored_arguments)
		arguments += stored_arguments

	var/process_flags = behavior.perform(arglist(arguments))
	if(process_flags & AI_BEHAVIOR_DELAY)
		behavior_cooldowns[behavior] = world.time + behavior.get_cooldown(src)
	if(process_flags & AI_BEHAVIOR_FAILED)
		arguments[1] = src
		arguments[2] = FALSE
		behavior.finish_action(arglist(arguments))
	else if(process_flags & AI_BEHAVIOR_SUCCEEDED)
		arguments[1] = src
		arguments[2] = TRUE
		behavior.finish_action(arglist(arguments))

/datum/ai_controller/proc/cancel_actions()
	if(!LAZYLEN(current_behaviors))
		return
	for(var/datum/ai_behavior/current_behavior as anything in current_behaviors)
		fail_behavior(current_behavior)

/datum/ai_controller/proc/fail_behavior(datum/ai_behavior/current_behavior)
	var/list/arguments = list(src, FALSE)
	var/list/stored_arguments = behavior_args[current_behavior.type]
	if(stored_arguments)
		arguments += stored_arguments
	current_behavior.finish_action(arglist(arguments))

/// Turn the controller on or off based on if you're alive.
/// We only register to this if the flag is present so don't need to check again.
/datum/ai_controller/proc/on_stat_changed(mob/living/source, new_stat)
	SIGNAL_HANDLER // COMSIG_MOB_STATCHANGE
	reset_ai_status()
	update_able_to_run()

/datum/ai_controller/proc/on_sentience_gained()
	SIGNAL_HANDLER // COMSIG_MOB_LOGIN
	UnregisterSignal(pawn, COMSIG_MOB_LOGIN)
	if(!continue_processing_when_client)
		set_ai_status(AI_STATUS_OFF) // Can't do anything while player is connected
	RegisterSignal(pawn, COMSIG_MOB_LOGOUT, PROC_REF(on_sentience_lost))

/datum/ai_controller/proc/on_sentience_lost()
	SIGNAL_HANDLER // COMSIG_MOB_LOGOUT
	UnregisterSignal(pawn, COMSIG_MOB_LOGOUT)
	set_ai_status(AI_STATUS_IDLE)
	RegisterSignal(pawn, COMSIG_MOB_LOGIN, PROC_REF(on_sentience_gained))

/// Turn the controller off if the pawn has been qdeleted.
/datum/ai_controller/proc/on_pawn_qdeleted()
	SIGNAL_HANDLER // COMSIG_PARENT_QDELETING
	set_ai_status(AI_STATUS_OFF)
	set_movement_target(type, null)
	if(ai_movement.moving_controllers[src])
		ai_movement.stop_moving_towards(src)

/// Use this proc to define how your controller defines what access the pawn has for the sake of pathfinding.
/// Return the access list you want to use.
/datum/ai_controller/proc/get_access()
	return

/// Returns the minimum required distance to preform one of our current behaviors.
/// Honestly this should just be cached or something but fuck you
/datum/ai_controller/proc/get_minimum_distance()
	var/minimum_distance = max_target_distance
	// right now I'm just taking the shortest minimum distance of our current behaviors, at some point in the future
	// we should let whatever sets the current_movement_target also set the min distance and max path length
	// (or at least cache it on the controller)
	for(var/datum/ai_behavior/iter_behavior as anything in current_behaviors)
		if(iter_behavior.required_distance < minimum_distance)
			minimum_distance = iter_behavior.required_distance
	return minimum_distance

/datum/ai_controller/proc/planning_failed()
	on_failed_planning_timeout = TRUE
	set_ai_status(get_expected_ai_status())
	addtimer(CALLBACK(src, PROC_REF(resume_planning)), AI_FAILED_PLANNING_COOLDOWN)

/datum/ai_controller/proc/resume_planning()
	on_failed_planning_timeout = FALSE
	set_ai_status(get_expected_ai_status())

/// Returns true if we have a blackboard key with the provided key and it is not qdeleting.
/datum/ai_controller/proc/blackboard_key_exists(key)
	var/datum/key_value = blackboard[key]
	if(isdatum(key_value))
		return !QDELETED(key_value)
	if(islist(key_value))
		return length(key_value) > 0
	return !!key_value

/**
 * Used to manage references to datum by AI controllers
 *
 * * tracked_datum - something being added to an ai blackboard
 * * key - the associated key
 */
#define TRACK_AI_DATUM_TARGET(tracked_datum, key) do { \
	if(isdatum(tracked_datum)) { \
		var/datum/_tracked_datum = tracked_datum; \
		if(!HAS_TRAIT_FROM(_tracked_datum, TRAIT_AI_TRACKING, "[UID()]_[key]")) { \
			RegisterSignal(_tracked_datum, COMSIG_PARENT_QDELETING, PROC_REF(sig_remove_from_blackboard), override = TRUE); \
			ADD_TRAIT(_tracked_datum, TRAIT_AI_TRACKING, "[UID()]_[key]"); \
		}; \
	}; \
} while(FALSE)

/**
 * Used to clear previously set reference handing by AI controllers
 *
 * * tracked_datum - something being removed from an ai blackboard
 * * key - the associated key
 */
#define CLEAR_AI_DATUM_TARGET(tracked_datum, key) do { \
	if(isdatum(tracked_datum)) { \
		var/datum/_tracked_datum = tracked_datum; \
		REMOVE_TRAIT(_tracked_datum, TRAIT_AI_TRACKING, "[UID()]_[key]"); \
		if(!HAS_TRAIT(_tracked_datum, TRAIT_AI_TRACKING)) { \
			UnregisterSignal(_tracked_datum, COMSIG_PARENT_QDELETING); \
		}; \
	}; \
} while(FALSE)

/// Used for above to track all the keys that have registered a signal
#define TRAIT_AI_TRACKING "tracked_by_ai"

/**
 * Sets the key to the passed "thing".
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/set_blackboard_key(key, thing)
	// Assume it is an error when trying to set a value overtop a list
	if(islist(blackboard[key]))
		CRASH("set_blackboard_key attempting to set a blackboard value to key [key] when it's a list!")
	// Don't do anything if it's already got this value
	if(blackboard[key] == thing)
		return

	// Clear existing values
	if(!isnull(blackboard[key]))
		clear_blackboard_key(key)

	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] = thing
	post_blackboard_key_set(key)

/**
 * Helper to force a key to be a certain thing no matter what's already there
 *
 * Useful for if you're overriding a list with a new list entirely,
 * as otherwise it would throw a runtime error from trying to override a list
 *
 * Not necessary to use if you aren't dealing with lists, as set_blackboard_key will clear the existing value
 * in that case already, but may be useful for clarity.
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/override_blackboard_key(key, thing)
	if(blackboard[key] == thing)
		return

	clear_blackboard_key(key)
	set_blackboard_key(key, thing)

/**
 * Sets the key at index thing to the passed value
 *
 * Assumes the key value is already a list, if not throws an error.
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/set_blackboard_key_assoc(key, thing, value)
	if(!islist(blackboard[key]))
		CRASH("set_blackboard_key_assoc called on non-list key [key]!")
	// Don't do anything if it's already got this value
	if(blackboard[key][thing] == value)
		return

	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] = value
	post_blackboard_key_set(key)

/**
 * Similar to [proc/set_blackboard_key_assoc] but operates under the assumption the key is a lazylist (so it will create a list)
 * More dangerous / easier to override values, only use when you want to use a lazylist
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/set_blackboard_key_assoc_lazylist(key, thing, value)
	LAZYINITLIST(blackboard[key])
	// Don't do anything if it's already got this value
	if(blackboard[key][thing] == value)
		return

	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] = value
	post_blackboard_key_set(key)

/**
 * Called after we set a blackboard key, forwards signal information.
 */
/datum/ai_controller/proc/post_blackboard_key_set(key)
	if(isnull(pawn))
		return
	SEND_SIGNAL(pawn, COMSIG_AI_BLACKBOARD_KEY_SET(key), key)

/**
 * Adds the passed "thing" to the associated key
 *
 * Works with lists or numbers, but not lazylists.
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/add_blackboard_key(key, thing)
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] += thing

/**
 * Similar to [proc/add_blackboard_key], but performs an insertion rather than an add
 * Throws an error if the key is not a list already, intended only for use with lists
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/insert_blackboard_key(key, thing)
	if(!islist(blackboard[key]))
		CRASH("insert_blackboard_key called on non-list key [key]!")
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] |= thing

/**
 * Adds the passed "thing" to the associated key, assuming key is intended to be a lazylist (so it will create a list)
 * More dangerous / easier to override values, only use when you want to use a lazylist
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/add_blackboard_key_lazylist(key, thing)
	LAZYINITLIST(blackboard[key])
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] += thing

/**
 * Similar to [proc/insert_blackboard_key_lazylist], but performs an insertion / or rather than an add
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/insert_blackboard_key_lazylist(key, thing)
	LAZYINITLIST(blackboard[key])
	TRACK_AI_DATUM_TARGET(thing, key)
	blackboard[key] |= thing

/**
 * Adds the value to the inner list at key with the inner key set to "thing"
 * Throws an error if the key is not a list already, intended only for use with lists
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/add_blackboard_key_assoc(key, thing, value)
	if(!islist(blackboard[key]))
		CRASH("add_blackboard_key_assoc called on non-list key [key]!")
	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] += value

/**
 * Similar to [proc/add_blackboard_key_assoc], assuming key is intended to be a lazylist (so it will create a list)
 * More dangerous / easier to override values, only use when you want to use a lazylist
 *
 * * key - A blackboard key, with its value set to a list
 * * thing - a value which becomes the inner list value's key
 * * value - what to set the inner list's value to
 */
/datum/ai_controller/proc/add_blackboard_key_assoc_lazylist(key, thing, value)
	LAZYINITLIST(blackboard[key])
	TRACK_AI_DATUM_TARGET(thing, key)
	TRACK_AI_DATUM_TARGET(value, key)
	blackboard[key][thing] += value

/**
 * Clears the passed key, resetting it to null
 *
 * Not intended for use with list keys - use [proc/remove_thing_from_blackboard_key] if you are removing a value from a list at a key
 *
 * * key - A blackboard key
 */
/datum/ai_controller/proc/clear_blackboard_key(key)
	if(isnull(blackboard[key]))
		return
	if(pawn && (SEND_SIGNAL(pawn, COMSIG_AI_BLACKBOARD_KEY_PRECLEAR(key))))
		return
	CLEAR_AI_DATUM_TARGET(blackboard[key], key)
	blackboard[key] = null
	if(isnull(pawn))
		return
	SEND_SIGNAL(pawn, COMSIG_AI_BLACKBOARD_KEY_CLEARED(key))

/**
 * Remove the passed thing from the associated blackboard key
 *
 * Intended for use with lists, if you're just clearing a reference from a key use [proc/clear_blackboard_key]
 *
 * * key - A blackboard key
 * * thing - a value to set the blackboard key to.
 */
/datum/ai_controller/proc/remove_thing_from_blackboard_key(key, thing)
	var/associated_value = blackboard[key]
	if(thing == associated_value)
		stack_trace("remove_thing_from_blackboard_key was called un-necessarily in a situation where clear_blackboard_key would suffice. ")
		clear_blackboard_key(key)
		return

	if(!islist(associated_value))
		CRASH("remove_thing_from_blackboard_key called with an invalid \"thing\" argument ([thing]). \
			(The associated value of the passed key is not a list and is also not the passed thing, meaning it is clearing an unintended value.)")

	for(var/inner_key in associated_value)
		if(inner_key == thing)
			// flat list
			CLEAR_AI_DATUM_TARGET(thing, key)
			associated_value -= thing
			return
		else if(associated_value[inner_key] == thing)
			// assoc list
			CLEAR_AI_DATUM_TARGET(thing, key)
			associated_value -= inner_key
			return

	CRASH("remove_thing_from_blackboard_key called with an invalid \"thing\" argument ([thing]). \
		(The passed value is not tracked in the passed list.)")

/// Removes a tracked object from a lazylist.
/datum/ai_controller/proc/remove_from_blackboard_lazylist_key(key, thing)
	var/lazylist = blackboard[key]
	if(isnull(lazylist))
		return
	for(var/key_index in lazylist)
		if(thing == key_index || lazylist[key_index] == thing)
			CLEAR_AI_DATUM_TARGET(thing, key)
			lazylist -= key_index
			break
	if(!LAZYLEN(lazylist))
		clear_blackboard_key(key)

/// Signal proc to go through every key and remove the datum from all keys it finds.
/datum/ai_controller/proc/sig_remove_from_blackboard(datum/source)
	SIGNAL_HANDLER // COMSIG_PARENT_QDELETING

	var/list/list/remove_queue = list(blackboard)
	var/index = 1
	while(index <= length(remove_queue))
		var/list/next_to_clear = remove_queue[index]
		for(var/inner_value in next_to_clear)
			var/associated_value = next_to_clear[inner_value]
			// We are a lists of lists, add the next value to the queue so we can handle references in there
			// (But we only need to bother checking the list if it's not empty.)
			if(islist(inner_value) && length(inner_value))
				UNTYPED_LIST_ADD(remove_queue, inner_value)

			// We found the value that's been deleted. Clear it out from this list
			else if(inner_value == source)
				next_to_clear -= inner_value

			// We are an assoc lists of lists, the list at the next value so we can handle references in there
			// (But again, we only need to bother checking the list if it's not empty.)
			if(islist(associated_value) && length(associated_value))
				UNTYPED_LIST_ADD(remove_queue, associated_value)

			// We found the value that's been deleted, it was an assoc value. Clear it out entirely
			else if(associated_value == source)
				next_to_clear -= inner_value
				SEND_SIGNAL(pawn, COMSIG_AI_BLACKBOARD_KEY_CLEARED(inner_value))

		index += 1

#undef TRACK_AI_DATUM_TARGET
#undef CLEAR_AI_DATUM_TARGET
#undef TRAIT_AI_TRACKING
