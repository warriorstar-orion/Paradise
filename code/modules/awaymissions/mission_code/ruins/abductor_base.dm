/obj/item/abductor_signal_chip
	name = "Abductor Signal Chip"
	desc = "An alien-looking piece of circuitry."
	icon = 'icons/obj/module.dmi'
	icon_state = "card_mini"

/obj/item/abductor_signal_chip/examine(mob/user)
	. = ..()
	if(user.mind?.assigned_role == "Explorer")
		// Only explorers recognize its purpose
		. += "Despite the alien appearance, it looks like it could slot into your docking signaller."
