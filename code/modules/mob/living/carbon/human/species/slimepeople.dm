#define SLIMEPERSON_COLOR_SHIFT_TRIGGER 0.1
#define SLIMEPERSON_ICON_UPDATE_PERIOD 200 // 20 seconds
#define SLIMEPERSON_BLOOD_SCALING_FACTOR 5 // Used to adjust how much of an effect the blood has on the rate of color change. Higher is slower.

#define SLIMEPERSON_HUNGERCOST 50
#define SLIMEPERSON_MINHUNGER 250
#define SLIMEPERSON_REGROWTHDELAY 450 // 45 seconds


/datum/species/slime
	name = "Slime People"
	name_plural = "Slime People"
	max_age = 130
	language = "Bubblish"

	blurb = "Slime People are gelatinous and translucent beings hailing from the tropical world of Xarxis 5 and surrounding Xarxis Republic. \
	Relatively recent entrants to the galactic scene, the Xarxis Republic, and slime people by extension, were discovered in the mid-2400s by a TSF survery fleet..<br/><br/> \
	Today, the Xarxis Republic is a member state of the Trans-Solar Federation, having become an Associate State following first contact, and later moving through several stages of integration.  \
	While a great deal of Slime People prefer the comforts and traditions of their home system and the Federation, a number have decided to take their chances in the wider sector, in \
	search of adventure, profit, and freedom among the stars."

	icobase = 'icons/mob/human_races/r_slime.dmi'
	remains_type = /obj/effect/decal/remains/slime
	inherent_factions = list("slime")

	// More sensitive to the cold
	cold_level_1 = 280
	cold_level_2 = 240
	cold_level_3 = 200
	coldmod = 3

	brain_mod = 1.5

	male_cough_sounds = list('sound/effects/slime_squish.ogg')
	female_cough_sounds = list('sound/effects/slime_squish.ogg')

	species_traits = list(LIPS, NO_CLONESCAN, EXOTIC_COLOR)
	inherent_traits = list(TRAIT_WATERBREATH, TRAIT_NO_BONES)
	clothing_flags = HAS_UNDERWEAR | HAS_UNDERSHIRT | HAS_SOCKS
	bodyflags = HAS_SKIN_COLOR | NO_EYES
	dietflags = DIET_CARN
	reagent_tag = PROCESS_ORG

	flesh_color = "#5fe8b1"
	blood_color = "#0064C8"
	exotic_blood = "slimejelly"

	butt_sprite = "slime"
	//Has default darksight of 2.

	vision_organ = null
	has_organ = list(
		"brain" = /obj/item/organ/internal/brain/slime
		)
	mutantears = null
	suicide_messages = list(
		"is melting into a puddle!",
		"is ripping out their own core!",
		"is turning a dull, brown color and melting into a puddle!")

	var/reagent_skin_coloring = FALSE
	var/static_bodyflags = HAS_SKIN_COLOR | NO_EYES

	plushie_type = /obj/item/toy/plushie/slimeplushie

/datum/species/slime/on_species_gain(mob/living/carbon/human/H)
	..()
	var/datum/action/innate/regrow/grow = new()
	grow.Grant(H)
	var/datum/action/innate/slimecolor/recolor = new()
	recolor.Grant(H)
	RegisterSignal(H, COMSIG_HUMAN_UPDATE_DNA, PROC_REF(blend))
	blend(H)


/datum/species/slime/on_species_loss(mob/living/carbon/human/H)
	..()
	for(var/datum/action/innate/i in H.actions)
		if(istype(i, /datum/action/innate/slimecolor))
			i.Remove(H)
		if(istype(i, /datum/action/innate/regrow))
			i.Remove(H)
	UnregisterSignal(H, COMSIG_HUMAN_UPDATE_DNA)


/datum/species/slime/proc/blend(mob/living/carbon/human/H)
	var/new_color = BlendRGB(H.skin_colour, "#acacac", 0.5) // Blends this to make it work better
	if(H.dna.species.blood_color != new_color) // Put here, so if it's a roundstart, dyed, or CMA'd slime, their blood changes to match skin
		H.dna.species.blood_color = new_color

/datum/species/slime/handle_life(mob/living/carbon/human/H)
	// Slowly shifting to the color of the reagents
	if(reagent_skin_coloring && H.reagents.total_volume > SLIMEPERSON_COLOR_SHIFT_TRIGGER)
		var/blood_amount = H.blood_volume
		var/r_color = mix_color_from_reagents(H.reagents.reagent_list)
		var/new_body_color = BlendRGB(r_color, H.skin_colour, (blood_amount*SLIMEPERSON_BLOOD_SCALING_FACTOR)/((blood_amount*SLIMEPERSON_BLOOD_SCALING_FACTOR)+(H.reagents.total_volume)))
		H.skin_colour = new_body_color
		if(world.time % SLIMEPERSON_ICON_UPDATE_PERIOD > SLIMEPERSON_ICON_UPDATE_PERIOD - 20) // The 20 is because this gets called every 2 seconds, from the mob controller
			for(var/organname in H.bodyparts_by_name)
				var/obj/item/organ/external/E = H.bodyparts_by_name[organname]
				if(istype(E) && E.dna && istype(E.dna.species, /datum/species/slime))
					E.sync_colour_to_human(H)
			H.update_hair()
			H.update_body()
			blend(H)
	..()

/datum/species/slime/can_hear(mob/living/carbon/human/H) // fucking snowflakes
	. = FALSE
	if(!HAS_TRAIT(H, TRAIT_DEAF))
		. = TRUE

/datum/action/innate/slimecolor
	name = "Toggle Recolor"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "greenglow"

/datum/action/innate/slimecolor/Activate()
	var/mob/living/carbon/human/H = owner
	var/datum/species/slime/S = H.dna.species
	if(S.reagent_skin_coloring)
		S.reagent_skin_coloring = FALSE
		to_chat(H, "You adjust your internal chemistry to filter out pigments from things you consume.")
	else
		S.reagent_skin_coloring = TRUE
		to_chat(H, "You adjust your internal chemistry to permit pigments in chemicals you consume to tint you.")

/datum/action/innate/regrow
	name = "Regrow limbs"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "greenglow"

/datum/action/innate/regrow/Activate()
	var/mob/living/carbon/human/H = owner
	if(H.nutrition < SLIMEPERSON_MINHUNGER)
		to_chat(H, "<span class='warning'>You're too hungry to regenerate a limb!</span>")
		return

	var/list/missing_limbs = list()
	for(var/l in H.bodyparts_by_name)
		var/obj/item/organ/external/E = H.bodyparts_by_name[l]
		if(!istype(E))
			var/list/limb_list = H.dna.species.has_limbs[l]
			var/obj/item/organ/external/limb = limb_list["path"]
			var/parent_organ = initial(limb.parent_organ)
			var/obj/item/organ/external/parentLimb = H.bodyparts_by_name[parent_organ]
			if(!istype(parentLimb))
				continue
			missing_limbs[initial(limb.name)] = l

	if(!length(missing_limbs))
		to_chat(H, "<span class='warning'>You're not missing any limbs!</span>")
		return

	var/limb_select = tgui_input_list(H, "Choose a limb to regrow", "Limb Regrowth", missing_limbs)
	if(!limb_select) // If the user hit cancel on the popup, return
		return
	var/chosen_limb = missing_limbs[limb_select]

	H.visible_message("<span class='notice'>[H] begins to hold still and concentrate on [H.p_their()] missing [limb_select]...</span>", "<span class='notice'>You begin to focus on regrowing your missing [limb_select]... (This will take [round(SLIMEPERSON_REGROWTHDELAY/10)] seconds, and you must hold still.)</span>")
	if(do_after(H, SLIMEPERSON_REGROWTHDELAY, FALSE, H, extra_checks = list(CALLBACK(H, TYPE_PROC_REF(/mob/living, IsStunned))), use_default_checks = FALSE)) // Override the check for weakness, only check for stunned
		if(H.incapacitated(extra_checks = list(CALLBACK(H, TYPE_PROC_REF(/mob/living, IsStunned))), use_default_checks = FALSE)) // Override the check for weakness, only check for stunned
			to_chat(H, "<span class='warning'>You cannot regenerate missing limbs in your current state.</span>")
			return

		if(H.nutrition < SLIMEPERSON_MINHUNGER)
			to_chat(H, "<span class='warning'>You're too hungry to regenerate a limb!</span>")
			return

		var/obj/item/organ/external/O = H.bodyparts_by_name[chosen_limb]

		var/stored_brute = 0
		var/stored_burn = 0
		if(istype(O))
			to_chat(H, "<span class='warning'>You distribute the damaged tissue around your body, out of the way of your new pseudopod!</span>")
			var/obj/item/organ/external/doomedStump = O
			stored_brute = doomedStump.brute_dam
			stored_burn = doomedStump.burn_dam
			qdel(O)

		var/limb_list = H.dna.species.has_limbs[chosen_limb]
		var/obj/item/organ/external/limb_path = limb_list["path"]
		// Parent check
		var/obj/item/organ/external/potential_parent = H.bodyparts_by_name[initial(limb_path.parent_organ)]
		if(!istype(potential_parent))
			to_chat(H, "<span class='danger'>You've lost the organ that you've been growing your new part on!</span>")
			return // No rayman for you
		// Grah this line will leave a "not used" warning, in spite of the fact that the new() proc WILL do the thing.
		// Bothersome.
		var/obj/item/organ/external/new_limb = new limb_path(H)
		new_limb.open = ORGAN_CLOSED // This is just so that the compiler won't think that new_limb is unused, because the compiler is horribly stupid.
		H.adjustBruteLoss(stored_brute)
		H.adjustFireLoss(stored_burn)
		H.update_body()
		H.updatehealth()
		H.UpdateDamageIcon()
		H.adjust_nutrition(-SLIMEPERSON_HUNGERCOST)
		H.visible_message("<span class='notice'>[H] finishes regrowing [H.p_their()] missing [new_limb]!</span>", "<span class='notice'>You finish regrowing your [limb_select]</span>")
		new_limb.add_limb_flags()
	else
		to_chat(H, "<span class='warning'>You need to hold still in order to regrow a limb!</span>")

#undef SLIMEPERSON_COLOR_SHIFT_TRIGGER
#undef SLIMEPERSON_ICON_UPDATE_PERIOD
#undef SLIMEPERSON_BLOOD_SCALING_FACTOR

#undef SLIMEPERSON_HUNGERCOST
#undef SLIMEPERSON_MINHUNGER
#undef SLIMEPERSON_REGROWTHDELAY
