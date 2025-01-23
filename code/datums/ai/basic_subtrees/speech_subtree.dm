/datum/ai_planning_subtree/random_speech
	//The chance of an emote occurring each second
	var/speech_chance = 0
	///Hearable emotes
	var/list/emote_hear = list()
	///Unlike speak_emote, the list of things in this variable only show by themselves with no spoken text. IE: Ian barks, Ian yaps
	var/list/emote_see = list()
	///Possible lines of speech the AI can have
	var/list/speak = list()
	///The sound effects associated with this speech, if any
	var/list/sound = list()

/datum/ai_planning_subtree/random_speech/New()
	. = ..()
	if(speak)
		speak = string_assoc_list(speak)
	if(sound)
		sound = string_assoc_list(sound)
	if(emote_hear)
		emote_hear = string_assoc_list(emote_hear)
	if(emote_see)
		emote_see = string_assoc_list(emote_see)

/datum/ai_planning_subtree/random_speech/select_behaviors(datum/ai_controller/controller, seconds_per_tick)
	if(!SPT_PROB(speech_chance, seconds_per_tick))
		return
	speak(controller)

/// Actually perform an action
/datum/ai_planning_subtree/random_speech/proc/speak(datum/ai_controller/controller)
	var/audible_emotes_length = emote_hear?.len
	var/non_audible_emotes_length = emote_see?.len
	var/speak_lines_length = speak?.len

	var/total_choices_length = audible_emotes_length + non_audible_emotes_length + speak_lines_length

	var/random_number_in_range = rand(1, total_choices_length)
	var/sound_to_play = length(sound) > 0 ? pick(sound) : null

	if(random_number_in_range <= audible_emotes_length)
		controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_hear), sound_to_play)
	else if(random_number_in_range <= (audible_emotes_length + non_audible_emotes_length))
		controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_see))
	else
		controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(speak), sound_to_play)

/datum/ai_planning_subtree/random_speech/dog
	speech_chance = 1

/datum/ai_planning_subtree/random_speech/dog/select_behaviors(datum/ai_controller/controller, seconds_per_tick)
	if(!istype(controller.pawn, /mob/living/basic/pet/dog))
		return

	// Stay in sync with dog fashion.
	var/mob/living/basic/pet/dog/dog_pawn = controller.pawn
	dog_pawn.update_dog_speech(src)

	return ..()

/datum/ai_planning_subtree/random_speech/blackboard //literal tower of babel, subtree form
	speech_chance = 1

/datum/ai_planning_subtree/random_speech/blackboard/select_behaviors(datum/ai_controller/controller, seconds_per_tick)
	var/list/speech_lines = controller.blackboard[BB_BASIC_MOB_SPEAK_LINES]
	if(isnull(speech_lines))
		return ..()

	// Note to future developers: this behaviour a singleton so this probably doesn't work as you would expect
	// The whole speech tree really needs to be refactored because this isn't how we use AI data these days
	speak = speech_lines[BB_EMOTE_SAY] || list()
	emote_see = speech_lines[BB_EMOTE_SEE] || list()
	emote_hear = speech_lines[BB_EMOTE_HEAR] || list()
	sound = speech_lines[BB_EMOTE_SOUND] || list()
	speech_chance = speech_lines[BB_SPEAK_CHANCE] ? speech_lines[BB_SPEAK_CHANCE] : initial(speech_chance)

	return ..()
