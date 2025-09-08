RESTRICT_TYPE(/datum/autochef_task/use_expansion_card)

/datum/autochef_task/use_expansion_card
	var/obj/item/autochef_expansion_card/card
	var/expected_result_type

/datum/autochef_task/use_expansion_card/New(obj/machinery/autochef/autochef_, obj/item/autochef_expansion_card/card_, expected_result_type_)
	autochef = autochef_
	card = card_
	expected_result_type = expected_result_type_

/datum/autochef_task/use_expansion_card/resume()
	var/result = card.perform_step(autochef, expected_result_type)
	if(length(card.contents))
		move_output_from_container(card)
	else
		// something happened here, we should have *something*
		return AUTOCHEF_ACT_FAILED

	return result

/datum/autochef_task/use_expansion_card/finalize()
	return

/datum/autochef_task/use_expansion_card/reset()
	return
