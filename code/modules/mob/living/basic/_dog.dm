//Dogs.

/mob/living/basic/pet/dog
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	speak_emote = list("barks", "woofs")
	faction = list(FACTION_NEUTRAL)
	ai_controller = /datum/ai_controller/basic_controller/dog
	// The dog attack pet command can raise melee attack above 0
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	melee_attack_cooldown = 0.8 SECONDS
	///icon state of the collar we can wear
	var/collar_icon_state
	///icon state of our cult icon
	var/cult_icon_state

///Updates dog speech and emotes
/mob/living/basic/pet/dog/proc/update_dog_speech(datum/ai_planning_subtree/random_speech/speech)
	speech.speak = string_assoc_list(list("YAP", "Woof!", "Bark!", "AUUUUUU"))
	speech.emote_hear = string_assoc_list(list("barks!", "woofs!", "yaps.","pants."))
	speech.emote_see = string_assoc_list(list("shakes [p_their()] head.", "chases [p_their()] tail.","shivers."))
