//Preset for spells
/datum/action/spell_action
	check_flags = 0
	background_icon_state = "bg_spell"
	var/recharge_text_color = "#FFFFFF"

/datum/action/spell_action/New(Target)
	..()
	var/datum/spell/S = target
	S.action = src
	name = S.name
	desc = S.desc
	button_icon = S.action_icon
	background_icon = S.action_background_icon
	button_icon_state = S.action_icon_state
	background_icon_state = S.action_background_icon_state
	build_all_button_icons()

/datum/action/spell_action/Destroy()
	var/datum/spell/S = target
	S.action = null
	return ..()

/datum/action/spell_action/should_draw_cooldown()
	var/datum/spell/S = target
	return S.cooldown_handler.should_draw_cooldown()

/datum/action/spell_action/Trigger(left_click)
	if(!..())
		return FALSE
	if(target)
		var/datum/spell/spell = target
		spell.Click()
		return TRUE

/datum/action/spell_action/AltTrigger()
	if(target)
		var/datum/spell/spell = target
		spell.AltClick(usr)
		return TRUE

/datum/action/spell_action/IsAvailable()
	if(!target)
		return FALSE
	var/datum/spell/spell = target

	if(owner)
		return spell.can_cast(owner)
	return FALSE

/datum/action/spell_action/update_button_status(atom/movable/screen/movable/action_button/current_button, force)
	current_button.cut_overlay(current_button.unavailable_effect_overlay)
	current_button.cut_overlay(current_button.button_text_image)

	if(should_draw_cooldown())
		var/datum/spell/S = target
		current_button.unavailable_effect_overlay.alpha = S.cooldown_handler.get_cooldown_alpha()

		var/text = S.cooldown_handler.cooldown_info()
		current_button.button_text_image.maptext = "<div style=\"font-size:6pt;color:[recharge_text_color];font:'Small Fonts';text-align:center;\" valign=\"bottom\">[text]</div>"
		current_button.add_overlay(current_button.unavailable_effect_overlay)
		current_button.add_overlay(current_button.button_text_image)
