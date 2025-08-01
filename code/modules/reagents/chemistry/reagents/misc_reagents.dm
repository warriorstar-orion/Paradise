/datum/reagent/oxygen
	name = "Oxygen"
	id = "oxygen"
	description = "A colorless, odorless gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0

/datum/reagent/nitrogen
	name = "Nitrogen"
	id = "nitrogen"
	description = "A colorless, odorless, tasteless gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0

/datum/reagent/hydrogen
	name = "Hydrogen"
	id = "hydrogen"
	description = "A colorless, odorless, nonmetallic, tasteless, highly combustible diatomic gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0

/datum/reagent/potassium
	name = "Potassium"
	id = "potassium"
	description = "A soft, low-melting solid that can easily be cut with a knife. Reacts violently with water."
	color = "#A0A0A0" // rgb: 160, 160, 160
	taste_description = "bad ideas"

/datum/reagent/sulfur
	name = "Sulfur"
	id = "sulfur"
	description = "A chemical element."
	color = "#BF8C00" // rgb: 191, 140, 0
	taste_description = "impulsive decisions"

/datum/reagent/sodium
	name = "Sodium"
	id = "sodium"
	description = "A chemical element."
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "horrible misjudgement"

/datum/reagent/phosphorus
	name = "Phosphorus"
	id = "phosphorus"
	description = "A chemical element."
	color = "#832828" // rgb: 131, 40, 40
	taste_description = "misguided choices"

/datum/reagent/carbon
	name = "Carbon"
	id = "carbon"
	description = "A chemical element."
	color = "#1C1300" // rgb: 30, 20, 0
	taste_description = "like a pencil or something"

/datum/reagent/carbon/reaction_turf(turf/T, volume)
	if(!(locate(/obj/effect/decal/cleanable/dirt) in T) && !isspaceturf(T)) // Only add one dirt per turf.  Was causing people to crash.
		new /obj/effect/decal/cleanable/dirt(T)

/datum/reagent/gold
	name = "Gold"
	id = "gold"
	description = "Gold is a dense, soft, shiny metal and the most malleable and ductile metal known."
	color = "#F7C430" // rgb: 247, 196, 48
	taste_description = "bling"


/datum/reagent/silver
	name = "Silver"
	id = "silver"
	description = "A lustrous metallic element regarded as one of the precious metals."
	color = "#D0D0D0" // rgb: 208, 208, 208
	taste_description = "sub-par bling"

/datum/reagent/aluminum
	name = "Aluminum"
	id = "aluminum"
	description = "A silvery white and ductile member of the boron group of chemical elements."
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_description = "metal"

/datum/reagent/silicon
	name = "Silicon"
	id = "silicon"
	description = "A tetravalent metalloid, silicon is less reactive than its chemical analog carbon."
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_description = "a CPU"

/datum/reagent/copper
	name = "Copper"
	id = "copper"
	description = "A highly ductile metal."
	color = "#6E3B08" // rgb: 110, 59, 8
	taste_description = "copper"

/datum/reagent/copper/reaction_obj(obj/O, volume)
	if(istype(O, /obj/item/stack/sheet/metal))
		var/obj/item/stack/sheet/metal/M = O
		volume = round(min(volume, M.amount), 1)
		new /obj/item/stack/tile/brass(get_turf(M), volume)
		M.use(volume)

/datum/reagent/chromium
	name = "Chromium"
	id = "chromium"
	description = "A catalytic chemical element."
	color = "#DCDCDC"
	taste_description = "bitterness"

/datum/reagent/iron
	name = "Iron"
	id = "iron"
	description = "Pure iron is a metal."
	color = "#525152" // rgb: 200, 165, 220
	taste_description = "metal"

/datum/reagent/iron/on_mob_life(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!(NO_BLOOD in H.dna.species.species_traits))
			if(H.blood_volume < BLOOD_VOLUME_NORMAL)
				H.blood_volume += 0.8
	return ..()

//foam
/datum/reagent/fluorosurfactant
	name = "Fluorosurfactant"
	id = "fluorosurfactant"
	description = "A perfluoronated sulfonic acid that forms a foam when mixed with water."
	reagent_state = LIQUID
	color = "#9E6B38" // rgb: 158, 107, 56
	taste_description = "extreme discomfort"

// metal foaming agent
// this is lithium hydride. Add other recipies (e.g. LiH + H2O -> LiOH + H2) eventually
/datum/reagent/ammonia
	name = "Ammonia"
	id = "ammonia"
	description = "A caustic substance commonly used in fertilizer or household cleaners."
	reagent_state = GAS
	color = "#404030" // rgb: 64, 64, 48
	taste_description = "floor cleaner"

/datum/reagent/diethylamine
	name = "Diethylamine"
	id = "diethylamine"
	description = "A secondary amine, useful as a plant nutrient and as building block for other compounds."
	reagent_state = LIQUID
	color = "#322D00"
	taste_description = "iron"

/datum/reagent/oil
	name = "Oil"
	id = "oil"
	description = "A decent lubricant for machines. High in benzene, naptha and other hydrocarbons."
	reagent_state = LIQUID
	color = "#3C3C3C"
	shock_reduction = 25
	view_true_health = TRUE
	metabolization_rate = 0.1
	taste_description = "motor oil"
	process_flags = SYNTHETIC
	/// What this becomes after burning.
	var/reagent_after_burning = "ash"

/datum/reagent/oil/reaction_temperature(exposed_temperature, exposed_volume)
	if(exposed_temperature <= T0C + 600)
		return

	// Let's say burning boiling oil doubles in volume, can our max volume contain that?
	var/boil_overflow = (holder.total_volume + volume) - holder.maximum_volume

	var/turf/T = get_turf(holder.my_atom)
	var/smoke_type = /datum/effect_system/smoke_spread

	if(boil_overflow > 0)
		holder.my_atom.visible_message("<span class='boldwarning'>The oil boils out and burns violently!</span>")
		// Log -> remove reagent -> fireflash, else the log fails or fireflash triggers a reaction again
		fire_flash_log(holder, id)
		holder.del_reagent(id)
		fireflash(T, clamp(boil_overflow / 40, 0, 8))

		smoke_type = /datum/effect_system/smoke_spread/bad
	else
		holder.my_atom.visible_message("<span class='notice'>The oil sizzles and burns down into residue.</span>")
		var/datum/reagents/old_holder = holder // We might not have space if we add first, so cache this and add after deleting
		holder.del_reagent(id)
		old_holder.add_reagent(reagent_after_burning, volume * 0.6)

	// Flavor reaction effects
	playsound(T, 'sound/goonstation/misc/drinkfizz.ogg', 80, TRUE)
	var/datum/effect_system/smoke_spread/BS = new smoke_type
	BS.set_up(1, FALSE, T)
	BS.start()

/datum/reagent/oil/reaction_turf(turf/T, volume)
	if(volume >= 3 && !isspaceturf(T) && !(locate(/obj/effect/decal/cleanable/blood/oil) in T))
		new /obj/effect/decal/cleanable/blood/oil(T)

/datum/reagent/oil/cooking
	name = "Cooking Oil"
	id = "cooking_oil"
	description = "You should probably pour this down the sink, where it belongs."
	color = "#fbba16"
	taste_description = "old french fries"
	reagent_after_burning = "cooking_oil_inert"

/datum/reagent/oil/cooking/reaction_turf(turf/T, volume)
	if(volume >= 3 && !isspaceturf(T) && !(locate(/obj/effect/decal/cleanable/blood/oil/cooking) in T))
		new /obj/effect/decal/cleanable/blood/oil/cooking(T)

/datum/reagent/oil/cooking/inert
	name = "Burned Cooking Oil"
	description = "It's full of char and mixed with so much crud it's probably useless."
	id = "cooking_oil_inert"

/datum/reagent/oil/cooking/inert/reaction_temperature(exposed_temperature, exposed_volume)
	// don't do anything
	return

/datum/reagent/iodine
	name = "Iodine"
	id = "iodine"
	description = "A purple gaseous element."
	reagent_state = GAS
	color = "#493062"
	taste_description = "chemtrail resistance"

/datum/reagent/carpet
	name = "Carpet"
	id = "carpet"
	description = "A covering of thick fabric used on floors. This type looks particularly gross."
	reagent_state = LIQUID
	color = "#701345"
	taste_description = "a carpet...what?"

/datum/reagent/carpet/reaction_turf(turf/simulated/T, volume)
	if((istype(T, /turf/simulated/floor/plating) || istype(T, /turf/simulated/floor/plasteel)))
		var/turf/simulated/floor/F = T
		F.ChangeTurf(/turf/simulated/floor/carpet)
	..()

/datum/reagent/bromine
	name = "Bromine"
	id = "bromine"
	description = "A red-brown liquid element."
	reagent_state = LIQUID
	color = "#4E3A3A"
	taste_description = "chemicals"

/datum/reagent/phenol
	name = "Phenol"
	id = "phenol"
	description = "Also known as carbolic acid, this is a useful building block in organic chemistry."
	reagent_state = LIQUID
	color = "#525050"
	taste_description = "acid"

/datum/reagent/ash
	name = "Ash"
	id = "ash"
	description = "Ashes to ashes, dust to dust."
	reagent_state = LIQUID
	color = "#191919"
	taste_description = "ash"

/datum/reagent/acetone
	name = "Acetone"
	id = "acetone"
	description = "Pure 100% nail polish remover, also works as an industrial solvent."
	reagent_state = LIQUID
	color = "#474747"
	taste_description = "nail polish remover"

/datum/reagent/acetone/on_mob_life(mob/living/M)
	var/update_flags = STATUS_UPDATE_NONE
	update_flags |= M.adjustToxLoss(1.5, FALSE)
	return ..() | update_flags

/datum/reagent/saltpetre
	name = "Saltpetre"
	id = "saltpetre"
	description = "Volatile."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	taste_description = "one third of an explosion"

/datum/reagent/colorful_reagent
	name = "Colorful Reagent"
	id = "colorful_reagent"
	description = "It's pure liquid colors. That's a thing now."
	reagent_state = LIQUID
	color = "#FFFFFF"
	taste_description = "the rainbow"

/datum/reagent/colorful_reagent/on_mob_life(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!(NO_BLOOD in H.dna.species.species_traits) && !H.dna.species.exotic_blood)
			H.dna.species.blood_color = "#[num2hex(rand(0, 255), 2)][num2hex(rand(0, 255), 2)][num2hex(rand(0, 255), 2)]"
	return ..()

/datum/reagent/colorful_reagent/reaction_mob(mob/living/simple_animal/M, method=REAGENT_TOUCH, volume)
	if(isanimal(M))
		M.color = pick(GLOB.random_color_list)
	..()

/datum/reagent/colorful_reagent/reaction_obj(obj/O, volume)
	O.color = pick(GLOB.random_color_list)

/datum/reagent/colorful_reagent/reaction_turf(turf/T, volume)
	T.color = pick(GLOB.random_color_list)

/datum/reagent/hair_dye
	name = "Quantum Hair Dye"
	id = "hair_dye"
	description = "A rather tubular and gnarly way of coloring totally bodacious hair. Duuuudddeee."
	reagent_state = LIQUID
	color = "#960096"
	taste_description = "the 2559 Autumn release of the Le Jeune Homme catalogue for professional hairdressers"

/datum/reagent/hair_dye/reaction_mob(mob/living/M, volume)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/head/head_organ = H.get_organ("head")
		if(!istype(head_organ))
			return ..()
		head_organ.facial_colour = rand_hex_color()
		head_organ.sec_facial_colour = rand_hex_color()
		head_organ.hair_colour = rand_hex_color()
		head_organ.sec_hair_colour = rand_hex_color()
		H.update_hair()
		H.update_fhair()
	..()

/datum/reagent/hairgrownium
	name = "Hairgrownium"
	id = "hairgrownium"
	description = "A mysterious chemical purported to help grow hair. Often found on late-night TV infomercials."
	reagent_state = LIQUID
	color = "#5DDA5D"
	penetrates_skin = TRUE
	taste_description = "someone's beard"

/datum/reagent/hairgrownium/reaction_mob(mob/living/M, volume)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/head/head_organ = H.get_organ("head")
		if(!istype(head_organ))
			return ..()
		head_organ.h_style = random_hair_style(H.gender, head_organ.dna.species.name)
		head_organ.f_style = random_facial_hair_style(H.gender, head_organ.dna.species.name)
		H.update_hair()
		H.update_fhair()
	..()

/datum/reagent/super_hairgrownium
	name = "Super Hairgrownium"
	id = "super_hairgrownium"
	description = "A mysterious and powerful chemical purported to cause rapid hair growth."
	reagent_state = LIQUID
	color = "#5DD95D"
	penetrates_skin = TRUE
	taste_description = "multiple beards"

/datum/reagent/super_hairgrownium/reaction_mob(mob/living/M, volume)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/head/head_organ = H.get_organ("head")
		if(!istype(head_organ))
			return ..()
		var/datum/sprite_accessory/tmp_hair_style = GLOB.hair_styles_full_list["Very Long Hair"]
		var/datum/sprite_accessory/tmp_facial_hair_style = GLOB.facial_hair_styles_list["Very Long Beard"]

		if(head_organ.dna.species.name in tmp_hair_style.species_allowed) //If 'Very Long Hair' is a style the person's species can have, give it to them.
			head_organ.h_style = "Very Long Hair"
		else //Otherwise, give them a random hair style.
			head_organ.h_style = random_hair_style(H.gender, head_organ.dna.species.name)
		if(head_organ.dna.species.name in tmp_facial_hair_style.species_allowed) //If 'Very Long Beard' is a style the person's species can have, give it to them.
			head_organ.f_style = "Very Long Beard"
		else //Otherwise, give them a random facial hair style.
			head_organ.f_style = random_facial_hair_style(H.gender, head_organ.dna.species.name)
		H.update_hair()
		H.update_fhair()
		if(!H.wear_mask || H.wear_mask && !istype(H.wear_mask, /obj/item/clothing/mask/fakemoustache))
			if(H.wear_mask)
				H.drop_item_to_ground(H.wear_mask)
			var/obj/item/clothing/mask/fakemoustache = new /obj/item/clothing/mask/fakemoustache
			H.equip_to_slot(fakemoustache, ITEM_SLOT_MASK)
			to_chat(H, "<span class='notice'>Hair bursts forth from your every follicle!")
	..()

/datum/reagent/hugs
	name = "Pure hugs"
	id = "hugs"
	description = "Hugs, in liquid form. Yes, the concept of a hug. As a liquid. This makes sense in the future."
	reagent_state = LIQUID
	color = "#FF97B9"
	taste_description = "<font color='pink'><b>hugs</b></font>"

/datum/reagent/love
	name = "Pure love"
	id = "love"
	description = "What is this emotion you humans call \"love?\" Oh, it's this? This is it? Huh, well okay then, thanks."
	reagent_state = LIQUID
	color = "#FF83A5"
	process_flags = ORGANIC | SYNTHETIC // That's the power of love~
	taste_description = "<font color='pink'><b>love</b></font>"

/datum/reagent/love/on_mob_add(mob/living/L)
	..()
	if(L.a_intent != INTENT_HELP)
		L.a_intent_change(INTENT_HELP)
	L.can_change_intents = FALSE //Now you have no choice but to be helpful.

/datum/reagent/love/on_mob_life(mob/living/M)
	if(prob(8))
		var/lovely_phrase = pick("appreciated", "loved", "pretty good", "really nice", "pretty happy with yourself, even though things haven't always gone as well as they could")
		to_chat(M, "<span class='notice'>You feel [lovely_phrase].</span>")

	else if(!M.restrained())
		for(var/mob/living/carbon/C in orange(1, M))
			if(C)
				if(C == M)
					continue
				if(!C.stat)
					M.visible_message("<span class='notice'>[M] gives [C] a [pick("hug","warm embrace")].</span>")
					playsound(get_turf(M), 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
					break
	return ..()

/datum/reagent/love/on_mob_delete(mob/living/M)
	M.can_change_intents = TRUE
	..()

/datum/reagent/love/reaction_mob(mob/living/M, method=REAGENT_TOUCH, volume)
	to_chat(M, "<span class='notice'>You feel loved!</span>")

/// Formerly known as Nitrogen tungstide hypochlorite before NT fired the chemists for trying to be funny
/datum/reagent/jestosterone
	name = "Jestosterone"
	id = "jestosterone"
	description = "Jestosterone is an odd chemical compound that induces a variety of annoying side-effects in the average person. It also causes mild intoxication, and is toxic to mimes."
	color = "#ff00ff" //Fuchsia, pity we can't do rainbow here
	process_flags = ORGANIC | SYNTHETIC
	taste_description = "a funny flavour"

/datum/reagent/jestosterone/on_new()
	..()
	var/mob/living/carbon/C = holder.my_atom
	if(!istype(C))
		return
	if(C.mind)
		if(C.mind.assigned_role == "Clown")
			to_chat(C, "<span class='notice'>Whatever that was, it feels great!</span>")
		else if(C.mind.assigned_role == "Mime")
			to_chat(C, "<span class='warning'>You feel nauseous.</span>")
			C.AdjustDizzy(volume STATUS_EFFECT_CONSTANT)
			ADD_TRAIT(C, TRAIT_COMIC_SANS, id)
			C.AddElement(/datum/element/waddling)
		else
			to_chat(C, "<span class='warning'>Something doesn't feel right...</span>")
			C.AdjustDizzy(volume STATUS_EFFECT_CONSTANT)
			ADD_TRAIT(C, TRAIT_COMIC_SANS, id)
			C.AddElement(/datum/element/waddling)
	C.AddComponent(/datum/component/squeak, null, null, null, null, null, TRUE, falloff_exponent = 20)

/datum/reagent/jestosterone/on_mob_life(mob/living/carbon/human/M)
	var/update_flags = STATUS_UPDATE_NONE
	if(prob(10))
		M.emote("giggle")
	if(!M.mind)
		return ..() | update_flags
	if(M.mind.assigned_role == "Clown")
		update_flags |= M.adjustBruteLoss(-1.5 * REAGENTS_EFFECT_MULTIPLIER, robotic = TRUE) //Screw those pesky clown beatings!
	else
		M.AdjustDizzy(20 SECONDS, 0, 100 SECONDS)
		M.Druggy(30 SECONDS)
		if(prob(10))
			M.EyeBlurry(10 SECONDS)
		if(prob(6))
			var/list/clown_message = list("You feel light-headed.",
			"You can't see straight.",
			"You feel about as funny as the station clown.",
			"Bright colours and rainbows cloud your vision.",
			"Your funny bone aches.",
			"What was that?!",
			"You can hear bike horns in the distance.",
			"You feel like <em>SHOUTING</em>!",
			"Sinister laughter echoes in your ears.",
			"Your legs feel like jelly.",
			"You feel like telling a pun.")
			to_chat(M, "<span class='warning'>[pick(clown_message)]</span>")
		if(M.mind.assigned_role == "Mime")
			if(M.dna.species.tox_mod <= 0) // If they can't take tox damage, make them take burn damage
				update_flags |= M.adjustFireLoss(1.5 * REAGENTS_EFFECT_MULTIPLIER, robotic = TRUE)
			else
				update_flags |= M.adjustToxLoss(1.5 * REAGENTS_EFFECT_MULTIPLIER)
	return ..() | update_flags

/datum/reagent/jestosterone/on_mob_delete(mob/living/M)
	..()
	if(M.mind?.assigned_role != "Clown")
		REMOVE_TRAIT(M, TRAIT_COMIC_SANS, id)
		M.RemoveElement(/datum/element/waddling)
		M.DeleteComponent(/datum/component/squeak)

/datum/reagent/mimestrogen
	name = "Mimestrogen"
	id = "mimestrogen"
	description = "Mimestrogen is an odd chemical compound that induces a variety of annoying side-effects in the average person. It also causes mild intoxication, and is toxic to clowns."
	color = "#353535" // Should be dark grey, there are already a fair number of white chemicals
	process_flags = ORGANIC | SYNTHETIC
	drink_desc = "The color of the glass' surroundings seem to drain as you look at it."
	taste_description = "an entertaining flavour"

/datum/reagent/mimestrogen/on_new()
	..()
	var/mob/living/carbon/C = holder.my_atom
	if(!istype(C))
		return
	if(C.mind)
		if(C.mind.assigned_role == "Mime")
			to_chat(C, "<span class='notice'>Whatever that was, it feels great!</span>")
		else if(C.mind.assigned_role == "Clown")
			to_chat(C, "<span class='warning'>You feel nauseous.</span>")
			C.AdjustDizzy(volume STATUS_EFFECT_CONSTANT)
			C.mind.miming = TRUE
			ADD_TRAIT(C, TRAIT_COLORBLIND, id)
		else
			to_chat(C, "<span class='warning'>Something doesn't feel right...</span>")
			C.AdjustDizzy(volume STATUS_EFFECT_CONSTANT)
			C.mind.miming = TRUE // Jestosterone gives comic sans which makes one more clown-like, comic sans also unlocks clown healing, minus Jestoserone. So, mind.miming makes one more like a mime and unlocks mime healing, minus Mimestrogen.
			ADD_TRAIT(C, TRAIT_COLORBLIND, id)

/datum/reagent/mimestrogen/on_mob_life(mob/living/carbon/human/M)
	var/update_flags = STATUS_UPDATE_NONE
	if(prob(10))
		M.emote("giggle")
	if(!M.mind)
		return ..() | update_flags
	if(M.mind.assigned_role == "Mime")
		update_flags |= M.adjustBruteLoss(-1.5 * REAGENTS_EFFECT_MULTIPLIER, robotic = TRUE)
	else
		M.AdjustDizzy(20 SECONDS, 0, 100 SECONDS)
		if(M.client)
			M.client.color = MATRIX_GREYSCALE
			M.update_client_colour() // TRAIT_COLORBLIND only makes you colourblind for the wires, this fully makes it greyscale
		if(prob(10))
			M.EyeBlurry(10 SECONDS)
		if(prob(6))
			var/static/list/mime_message = list("You feel light-headed.",
				"You can't see straight.",
				"You feel about as entertaining as the station mime.",
				"Muted colors and berets cloud your vision.",
				"Your voice box feels numb.",
				"What was that?!",
				"You can hear silence in the distance, somehow.",
				"You feel like miming.",
				"Silence permeates your ears.",
				"...",
				"You feel like miming a performance.")
			to_chat(M, "<span class='warning'>[pick(mime_message)]</span>")
		if(M.mind.assigned_role == "Clown")
			if(M.dna.species.tox_mod <= 0) // If they can't take tox damage, make them take burn damage
				update_flags |= M.adjustFireLoss(1.5 * REAGENTS_EFFECT_MULTIPLIER, robotic = TRUE)
			else
				update_flags |= M.adjustToxLoss(1.5 * REAGENTS_EFFECT_MULTIPLIER)
	return ..() | update_flags

/datum/reagent/mimestrogen/on_mob_delete(mob/living/M)
	..()
	if(M.mind?.assigned_role != "Mime")
		M.mind.miming = FALSE
		if(M.client)
			M.client.color = null
			REMOVE_TRAIT(M, TRAIT_COLORBLIND, id)
			M.update_client_colour() // You get stuck with permanent greyscale if it's not separated from client.color by at least one line
		else
			REMOVE_TRAIT(M, TRAIT_COLORBLIND, id)

/datum/reagent/royal_bee_jelly
	name = "Royal bee jelly"
	id = "royal_bee_jelly"
	description = "Royal Bee Jelly, if injected into a Queen Space Bee said bee will split into two bees."
	color = "#00ff80"
	taste_description = "sweetness"

/datum/reagent/royal_bee_jelly/on_mob_life(mob/living/M)
	if(prob(2))
		M.say(pick("Bzzz...","BZZ BZZ","Bzzzzzzzzzzz..."))
	return ..()

/datum/reagent/growthserum
	name = "Growth serum"
	id = "growthserum"
	description = "A commercial chemical designed to help older men in the bedroom." //not really it just makes you a giant
	color = "#ff0000"//strong red. rgb 255, 0, 0
	var/current_size = 1
	taste_description = "enhancement"

/datum/reagent/growthserum/on_mob_life(mob/living/carbon/H)
	var/newsize = current_size
	switch(volume)
		if(0 to 19)
			newsize = 1.1
		if(20 to 49)
			newsize = 1.2
		if(50 to 99)
			newsize = 1.25
		if(100 to 199)
			newsize = 1.3
		if(200 to INFINITY)
			newsize = 1.5

	H.resize = newsize/current_size
	current_size = newsize
	H.update_transform()
	return ..()

/datum/reagent/growthserum/on_mob_delete(mob/living/M)
	M.resize = 1/current_size
	M.update_transform()
	..()

/datum/reagent/pax
	name = "Pax"
	id = "pax"
	description = "A colorless liquid that suppresses violence in its subjects."
	color = "#AAAAAA55"
	taste_description = "water"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM

/datum/reagent/pax/on_mob_add(mob/living/M)
	..()
	ADD_TRAIT(M, TRAIT_PACIFISM, id)

/datum/reagent/pax/on_mob_delete(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_PACIFISM, id)
	..()

/datum/reagent/toxin/coffeepowder
	name = "Coffee Grounds"
	id = "coffeepowder"
	description = "Finely ground Coffee beans, used to make coffee."
	reagent_state = SOLID
	color = "#5B2E0D" // rgb: 91, 46, 13
	taste_description = "waste"

/datum/reagent/toxin/teapowder
	name = "Ground Tea Leaves"
	id = "teapowder"
	description = "Finely shredded Tea leaves, used for making tea."
	reagent_state = SOLID
	color = "#7F8400" // rgb: 127, 132, 0"
	taste_description = "the future"

//////////////////////////////////Hydroponics stuff///////////////////////////////

/datum/reagent/plantnutrient
	name = "Generic nutrient"
	id = "plantnutrient"
	description = "Some kind of nutrient. You can't really tell what it is. You should probably report it, along with how you obtained it."
	var/tox_prob = 0
	var/mutation_level = 0
	taste_description = "puke"

/datum/reagent/plantnutrient/on_mob_life(mob/living/M)
	var/update_flags = STATUS_UPDATE_NONE
	if(prob(tox_prob))
		update_flags |= M.adjustToxLoss(1*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	return ..() | update_flags

/datum/reagent/plantnutrient/eznutrient
	name = "E-Z-Nutrient"
	id = "eznutrient"
	description = "Cheap and boring nutrition for plants."
	color = "#504700" // RBG: 80, 70, 0
	tox_prob = 5
	taste_description = "obscurity and toil"

/datum/reagent/plantnutrient/mut
	name = "Mutrient"
	id = "mutrient"
	description = "Plant nutrient designed to trigger mild genetic drift."
	color = "#376400" // RBG: 50, 100, 0
	tox_prob = 10
	mutation_level = 10
	taste_description = "change"

/datum/reagent/plantnutrient/left4zednutrient
	name = "Left 4 Zed"
	id = "left4zednutrient"
	description = "Unstable nutrient that makes plants mutate strongly at the cost of minimal yield."
	color = "#2A1680" // RBG: 42, 128, 22
	tox_prob = 25
	mutation_level = 15
	taste_description = "evolution"

/datum/reagent/plantnutrient/robustharvestnutrient
	name = "Robust Harvest"
	id = "robustharvestnutrient"
	description = "Very potent nutrient that increases yield."
	color = "#9D9D00" // RBG: 157, 157, 0
	tox_prob = 15
	taste_description = "bountifulness"

///Alchemical Reagents

/datum/reagent/eyenewt
	name = "Eye of newt"
	id = "eyenewt"
	description = "A potent alchemic ingredient."
	reagent_state = LIQUID
	color = "#050519"

/datum/reagent/toefrog
	name = "Toe of frog"
	id = "toefrog"
	description = "A potent alchemic ingredient."
	reagent_state = LIQUID
	color = "#092D09"
	taste_description = "alchemy"

/datum/reagent/woolbat
	name = "Wool of bat"
	id = "woolbat"
	description = "A potent alchemic ingredient."
	reagent_state = LIQUID
	color = "#080808"
	taste_description = "alchemy"

/datum/reagent/tonguedog
	name = "Tongue of dog"
	id = "tonguedog"
	description = "A potent alchemic ingredient."
	reagent_state = LIQUID
	color = "#2D0909"
	taste_description = "alchemy"

/datum/reagent/triplepiss
	name = "Triplepiss"
	id = "triplepiss"
	description = "Ewwwwwwwww."
	reagent_state = LIQUID
	color = "#857400"
	taste_description = "alchemy"

/datum/reagent/spraytan
	name = "Spray Tan"
	id = "spraytan"
	description = "A substance applied to the skin to darken the skin."
	color = "#FFC080" // rgb: 255, 196, 128  Bright orange
	metabolization_rate = 10 * REAGENTS_METABOLISM // very fast, so it can be applied rapidly.  But this changes on an overdose
	overdose_threshold = 11 //Slightly more than one un-nozzled spraybottle.
	taste_description = "sour oranges"

/datum/reagent/spraytan/reaction_mob(mob/living/M, method=REAGENT_TOUCH, reac_volume, show_message = 1)
	if(ishuman(M))
		if(method == REAGENT_TOUCH)
			var/mob/living/carbon/human/N = M
			set_skin_color(N)

		if(method == REAGENT_INGEST)
			if(show_message)
				to_chat(M, "<span class='notice'>That tasted horrible.</span>")
	..()

/datum/reagent/spraytan/overdose_process(mob/living/M)
	metabolization_rate = 1 * REAGENTS_METABOLISM

	if(ishuman(M) && is_species(M, /datum/species/human))
		var/mob/living/carbon/human/N = M
		N.change_hair("Spiky")
		N.change_facial_hair("Shaved")
		N.change_hair_color("#000000")
		N.change_facial_hair_color("#000000")
		set_skin_color(N)
		if(prob(7))
			if(N.w_uniform)
				M.visible_message(pick("<span><b>[M]</b>'s collar pops up without warning.</span>", "<b>[M]</b> flexes [M.p_their()] arms."))
			else
				M.visible_message("<b>[M]</b> flexes [M.p_their()] arms.")
	if(prob(10))
		M.say(pick("Maybe he's born with it, maybe its Tangerine.", "Dude, Toasters are like...tanning beds for bread.", "They said I could become anything so I became beef jerky.", "I can't afford a leather couch so I became one.", "I've entered the bronze age!"))

	return list(0, STATUS_UPDATE_NONE)

/datum/reagent/spraytan/proc/set_skin_color(mob/living/carbon/human/H)
	if(H.dna.species.bodyflags & HAS_SKIN_TONE)
		H.change_skin_tone(min(-H.s_tone + 45, 220)) // adjusts our skin tone by 10 - makes it darker
	else if(H.dna.species.bodyflags & HAS_ICON_SKIN_TONE)
		switch(H.dna.species.name)
			if("Human")
				H.change_skin_tone(max(H.s_tone, 10)) // bronze - `icons/mob/human_races/human_skintones/r_human_bronzed.dmi`
			if("Vox")
				H.change_skin_tone(3) // brown - `icons/mob/human_races/vox/r_voxbrn.dmi`
			if("Nian")
				H.change_skin_tone(1) // default - `icons/mob/human_races/nian/r_moth.dmi`
			if("Grey")
				H.change_skin_tone(4) // red - `icons/mob/human_races/grey/r_grey_red.dmi`
	else if(H.dna.species.bodyflags & HAS_SKIN_COLOR) // take current alien color and darken it slightly
		H.change_skin_color("#9B7653")

/datum/reagent/admin_cleaner
	name = "WD-2381"
	color = "#da9eda"
	description = "Extra-bubbly cleaner designed to clear all objects. Or, well. Anything that isn't bolted down. Or is, for that matter. In other words: if you're seeing this, how'd you get your hands on it?"

/datum/reagent/admin_cleaner/organic
	name = "WD-2381-MOB"
	id = "admincleaner_mob"
	description = "A bottle of strange nanites that instantly devour bodies, both living and dead, as well as organs."

/datum/reagent/admin_cleaner/organic/reaction_mob(mob/living/M, method, volume, show_message)
	. = ..()
	if(method == REAGENT_TOUCH)
		M.dust()

/datum/reagent/admin_cleaner/organic/reaction_obj(obj/O, volume)
	if(is_organ(O))
		qdel(O)
	if(istype(O, /obj/effect/decal/cleanable/blood) || istype(O, /obj/effect/decal/cleanable/vomit))
		qdel(O)
	if(istype(O, /obj/item/mmi))
		qdel(O)

/datum/reagent/admin_cleaner/item
	name = "WD-2381-ITM"
	id = "admincleaner_item"
	description = "A bottle of strange nanites that instantly devour items, while curiously leaving everything else untouched."

/datum/reagent/admin_cleaner/item/reaction_obj(obj/O, volume)
	if(isitem(O) && !istype(O, /obj/item/grenade/clusterbuster/segment))
		qdel(O)

/datum/reagent/admin_cleaner/all
	name = "WD-2381-ALL"
	id = "admincleaner_all"
	description = "An incredibly dangerous set of nanites engineered by Syndicate Janitors which devour everything they touch."

/datum/reagent/admin_cleaner/all/reaction_obj(obj/O, volume)
	if(istype(O, /obj/item/grenade/clusterbuster/segment))
		// don't clear clusterbang segments
		// I'm allowed to make this hack because this is admin only anyway
		return
	if(!iseffect(O))
		qdel(O)

/datum/reagent/admin_cleaner/all/reaction_mob(mob/living/M, method, volume, show_message)
	. = ..()
	if(method == REAGENT_TOUCH)
		M.dust()



