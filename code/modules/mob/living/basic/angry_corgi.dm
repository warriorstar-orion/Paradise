/mob/living/basic/angry_corgi
	name = "angry corgi"
	icon_state = "corgi"
	ai_controller = /datum/ai_controller/basic_controller/simple_hostile
	faction = list("angry_corgi")
	melee_damage_lower = 8
	melee_damage_upper = 12
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'

/mob/living/carbon/human/skrell/angry_skrell
	ai_controller = /datum/ai_controller/carbon_controller/carbon_hostile
	faction = list("angry_skrell")

/mob/living/carbon/human/angry_human
	ai_controller = /datum/ai_controller/carbon_controller/carbon_hostile
	faction = list("angry_human")
