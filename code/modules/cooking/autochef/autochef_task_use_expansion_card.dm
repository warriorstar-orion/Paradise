RESTRICT_TYPE(/datum/autochef_task/use_expansion_card)

/datum/autochef_task/use_expansion_card
	var/obj/item/autochef_expansion_card/card
	var/expected_result_type

/datum/autochef_task/use_expansion_card/to_string()
	return "[type]: [card.type] current_state=[autochef_act_to_string(current_state)]"

/datum/autochef_task/use_expansion_card/New(obj/machinery/autochef/autochef_, obj/item/autochef_expansion_card/card_, expected_result_type_)
	log_debug("[__PROC__]: expected_result_type=[expected_result_type_]")
	autochef = autochef_
	card = card_
	expected_result_type = expected_result_type_

/datum/autochef_task/use_expansion_card/resume()
	current_state = card.perform_step(src, autochef, expected_result_type)
	if(current_state == AUTOCHEF_ACT_COMPLETE && length(card.contents))
		autochef.move_output_from_container(card)
		return

/datum/autochef_task/use_expansion_card/finalize()
	return

/datum/autochef_task/use_expansion_card/reset()
	return
