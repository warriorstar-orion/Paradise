//Not to be confused with /obj/item/reagent_containers/drinks/bottle


/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A small bottle."
	icon_state = "bottle"
	item_state = "atoxinbottle"
	possible_transfer_amounts = list(5, 10, 15, 25, 30, 40, 50)

/obj/item/reagent_containers/glass/bottle/on_reagent_change()
	update_icon(UPDATE_OVERLAYS)

/obj/item/reagent_containers/glass/bottle/update_overlays()
	. = ..()
	if(reagents.total_volume)
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]1")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(1 to 19)
				filling.icon_state = "[icon_state]1"
			if(20 to 39)
				filling.icon_state = "[icon_state]20"
			if(40 to 59)
				filling.icon_state = "[icon_state]40"
			if(60 to 79)
				filling.icon_state = "[icon_state]60"
			if(80 to 99)
				filling.icon_state = "[icon_state]80"
			if(100 to INFINITY)
				filling.icon_state = "[icon_state]100"

		filling.icon += mix_color_from_reagents(reagents.reagent_list)
		. += filling

	if(!is_open_container())
		. += "lid_[icon_state]"

/obj/item/reagent_containers/glass/bottle/decompile_act(obj/item/matter_decompiler/C, mob/user)
	if(!reagents.total_volume)
		C.stored_comms["glass"] += 3
		qdel(src)
		return TRUE
	return ..()

/obj/item/reagent_containers/glass/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle containing toxic compounds."
	list_reagents = list("toxin" = 30)

/obj/item/reagent_containers/glass/bottle/atropine
	name = "atropine bottle"
	desc = "A small bottle containing atropine, used for cardiac emergencies."
	list_reagents = list("atropine" = 30)

/obj/item/reagent_containers/glass/bottle/saline
	name = "saline-glucose bottle"
	desc = "A small bottle containing saline-glucose solution."
	list_reagents = list("salglu_solution" = 30)

/obj/item/reagent_containers/glass/bottle/salicylic
	name = "salicylic acid bottle"
	desc = "A small bottle containing medicine for pain and fevers."
	list_reagents = list("sal_acid" = 30)

/obj/item/reagent_containers/glass/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide. Bitter almonds?"
	list_reagents = list("cyanide" = 30)

/obj/item/reagent_containers/glass/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."
	list_reagents = list("mutagen" = 30)

/obj/item/reagent_containers/glass/bottle/ash
	name = "ash bottle"
	desc = "A small bottle of ash. The substance, not the person."
	list_reagents = list("ash" = 30)

/obj/item/reagent_containers/glass/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle of ammonia. Good for cleaning, but don't mix it with bleach."
	list_reagents = list("ammonia" = 30)

/obj/item/reagent_containers/glass/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle of diethylamine. Good for plants, bad for people."
	list_reagents = list("diethylamine" = 30)

/obj/item/reagent_containers/glass/bottle/saltpetre
	name = "saltpetre bottle"
	desc = "A small bottle of saltpetre. Used in botany and to make gunpowder."
	list_reagents = list("saltpetre" = 30)

/obj/item/reagent_containers/glass/bottle/facid
	name = "fluorosulfuric acid bottle"
	desc = "A small bottle. Contains a small amount of Fluorosulfuric Acid"
	list_reagents = list("facid" = 30)

/obj/item/reagent_containers/glass/bottle/adminordrazine
	name = "adminordrazine bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"
	list_reagents = list("adminordrazine" = 30)

/obj/item/reagent_containers/glass/bottle/capsaicin
	name = "capsaicin bottle"
	desc = "A small bottle. Contains hot sauce."
	list_reagents = list("capsaicin" = 30)

/obj/item/reagent_containers/glass/bottle/frostoil
	name = "frost oil bottle"
	desc = "A small bottle. Contains cold sauce."
	list_reagents = list("frostoil" = 30)

/obj/item/reagent_containers/glass/bottle/morphine
	name = "morphine bottle"
	desc = "A small bottle of morphine, a powerful painkiller."
	list_reagents = list("morphine" = 30)

/obj/item/reagent_containers/glass/bottle/ether
	name = "ether bottle"
	desc = "A small bottle of an ether, a strong anesthetic and sedative."
	list_reagents = list("ether" = 30)

/obj/item/reagent_containers/glass/bottle/charcoal
	name = "charcoal bottle"
	desc = "A small bottle. Contains charcoal."
	list_reagents = list("charcoal" = 30)

/obj/item/reagent_containers/glass/bottle/epinephrine
	name = "epinephrine bottle"
	desc = "A small bottle. Contains epinephrine - used to stabilize patients."
	list_reagents = list("epinephrine" = 30)

/obj/item/reagent_containers/glass/bottle/pancuronium
	name = "pancuronium bottle"
	desc = "A small bottle of pancuronium."
	list_reagents = list("pancuronium" = 30)

/obj/item/reagent_containers/glass/bottle/sulfonal
	name = "sulfonal bottle"
	desc = "A small bottle of Sulfonal."
	list_reagents = list("sulfonal" = 30)

/obj/item/reagent_containers/glass/bottle/love
	name = "love bottle"
	desc = "A small bottle of love."
	list_reagents = list("love" = 50)

//Reagent bottles

/obj/item/reagent_containers/glass/bottle/reagent
	name = "reagent bottle"
	desc = "A bottle for storing reagents."
	icon_state = "reagent_bottle"

/obj/item/reagent_containers/glass/bottle/reagent/oil
	name = "oil bottle"
	desc = "A reagent bottle. Contains oil."
	list_reagents = list("oil" = 50)
	pixel_x = -4
	pixel_y = 6

/obj/item/reagent_containers/glass/bottle/reagent/phenol
	name = "phenol bottle"
	desc = "A reagent bottle. Contains phenol."
	list_reagents = list("phenol" = 50)
	pixel_x = 6
	pixel_y = 6

/obj/item/reagent_containers/glass/bottle/reagent/acetone
	name = "acetone bottle"
	desc = "A reagent bottle. Contains acetone."
	list_reagents = list("acetone" = 50)
	pixel_x = -4

/obj/item/reagent_containers/glass/bottle/reagent/ammonia
	name = "ammonia bottle"
	desc = "A reagent bottle. Contains ammonia."
	list_reagents = list("ammonia" = 50)
	pixel_x = 6

/obj/item/reagent_containers/glass/bottle/reagent/diethylamine
	name = "diethylamine bottle"
	desc = "A reagent bottle. Contains diethylamine."
	list_reagents = list("diethylamine" = 50)
	pixel_x = -4
	pixel_y = -6

/obj/item/reagent_containers/glass/bottle/reagent/acid
	name = "acid bottle"
	desc = "A reagent bottle. Contains sulfuric acid."
	list_reagents = list("sacid" = 50)
	pixel_x = 6
	pixel_y = -6

/obj/item/reagent_containers/glass/bottle/reagent/formaldehyde
	name = "formaldehyde bottle"
	desc = "A reagent bottle. Contains formaldehyde."
	list_reagents = list("formaldehyde" = 50)

/obj/item/reagent_containers/glass/bottle/reagent/synaptizine
	name = "synaptizine bottle"
	desc = "A reagent bottle. Contains synaptizine."
	list_reagents = list("synaptizine" = 50)

/obj/item/reagent_containers/glass/bottle/reagent/morphine
	name = "morphine bottle"
	desc = "A reagent bottle. Contains morphine."
	list_reagents = list("morphine" = 50)

/obj/item/reagent_containers/glass/bottle/reagent/hydrocodone
	name = "hydrocodone bottle"
	desc = "A reagent bottle. Contains hydrocodone."
	list_reagents = list("hydrocodone" = 30)

/obj/item/reagent_containers/glass/bottle/reagent/insulin
	name = "insulin bottle"
	desc = "A reagent bottle. Contains insulin."
	list_reagents = list("insulin" = 50)

/obj/item/reagent_containers/glass/bottle/reagent/hairgrownium
	name = "hair grow gel"
	desc = "A bottle full of a stimulative hair growth formula."
	list_reagents = list("hairgrownium" = 50)

/obj/item/reagent_containers/glass/bottle/reagent/hair_dye
	name = "quantum hair dye bottle"
	desc = "A bottle of the ever-changing quantum hair dye."
	list_reagents = list("hair_dye" = 50)

/obj/item/reagent_containers/glass/bottle/reagent/omnizine
	name = "omnizine bottle"
	desc = "A reagent bottle. Contains Omnizine."
	list_reagents = list("omnizine" = 50)

/obj/item/reagent_containers/glass/bottle/reagent/lazarus_reagent
	name = "lazarus reagent bottle"
	desc = "A bottle of glowing fluid."
	list_reagents = list("lazarus_reagent" = 30)

/obj/item/reagent_containers/glass/bottle/thermite
	name = "thermite bottle"
	desc = "A small bottle of thermite, a substance that burns extremely hot."
	list_reagents = list("thermite" = 50)

////////////////////Traitor Poison Bottle//////////////////////////////

/obj/item/reagent_containers/glass/bottle/traitor
	desc = "It has a small skull and crossbones on it. Uh-oh!"

/obj/item/reagent_containers/glass/bottle/traitor/Initialize(mapload)
	. = ..()
	reagents.add_reagent(pick_list("chemistry_tools.json", "traitor_poison_bottle"), 40)

/obj/item/reagent_containers/glass/bottle/plasma
	name = "plasma dust bottle"
	desc = "A small bottle of plasma in dust form. Extremely toxic and reacts with micro-organisms inside blood."
	list_reagents = list("plasma_dust" = 30)

/obj/item/reagent_containers/glass/bottle/diphenhydramine
	name = "diphenhydramine bottle"
	desc = "A small bottle of diphenhydramine."
	list_reagents = list("diphenhydramine" = 30)

/obj/item/reagent_containers/glass/bottle/oculine
	name = "oculine bottle"
	desc = "A small bottle of combined eye and ear medication."
	list_reagents = list("oculine" = 30)

/obj/item/reagent_containers/glass/bottle/potassium_iodide
	name = "potassium iodide bottle"
	desc = "A small bottle of potassium iodide."
	list_reagents = list("potass_iodide" = 30)

/obj/item/reagent_containers/glass/bottle/flu_virion
	name = "Flu virion culture bottle"
	desc = "A small bottle. Contains H13N1 flu virion culture in synthblood medium."
	spawned_disease = /datum/disease/advance/flu

/obj/item/reagent_containers/glass/bottle/epiglottis_virion
	name = "Epiglottis virion culture bottle"
	desc = "A small bottle. Contains Epiglottis virion culture in synthblood medium."
	spawned_disease = /datum/disease/advance/voice_change

/obj/item/reagent_containers/glass/bottle/liver_enhance_virion
	name = "Liver enhancement virion culture bottle"
	desc = "A small bottle. Contains liver enhancement virion culture in synthblood medium."
	spawned_disease = /datum/disease/advance/heal

/obj/item/reagent_containers/glass/bottle/hullucigen_virion
	name = "Hullucigen virion culture bottle"
	desc = "A small bottle. Contains hullucigen virion culture in synthblood medium."
	spawned_disease = /datum/disease/advance/hullucigen

/obj/item/reagent_containers/glass/bottle/pierrot_throat
	name = "Pierrot's Throat culture bottle"
	desc = "A small bottle. Contains H0NI<42 virion culture in synthblood medium."
	spawned_disease = /datum/disease/pierrot_throat

/obj/item/reagent_containers/glass/bottle/cold
	name = "Rhinovirus culture bottle"
	desc = "A small bottle. Contains XY-rhinovirus culture in synthblood medium."
	spawned_disease = /datum/disease/advance/cold

/obj/item/reagent_containers/glass/bottle/retrovirus
	name = "Retrovirus culture bottle"
	desc = "A small bottle. Contains a retrovirus culture in a synthblood medium."
	spawned_disease = /datum/disease/dna_retrovirus

/obj/item/reagent_containers/glass/bottle/gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS+ culture in synthblood medium."//Or simply - General BullShit
	amount_per_transfer_from_this = 5
	spawned_disease = /datum/disease/gbs

/obj/item/reagent_containers/glass/bottle/fake_gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS- culture in synthblood medium."//Or simply - General BullShit
	spawned_disease = /datum/disease/fake_gbs

/obj/item/reagent_containers/glass/bottle/brainrot
	name = "Brainrot culture bottle"
	desc = "A small bottle. Contains Cryptococcus Cosmosis culture in synthblood medium."
	spawned_disease = /datum/disease/brainrot

/obj/item/reagent_containers/glass/bottle/magnitis
	name = "Magnitis culture bottle"
	desc = "A small bottle. Contains a small dosage of Fukkos Miracos."
	spawned_disease = /datum/disease/magnitis

/obj/item/reagent_containers/glass/bottle/wizarditis
	name = "Wizarditis culture bottle"
	desc = "A small bottle. Contains a sample of Rincewindus Vulgaris."
	spawned_disease = /datum/disease/wizarditis

/obj/item/reagent_containers/glass/bottle/anxiety
	name = "Severe Anxiety culture bottle"
	desc = "A small bottle. Contains a sample of Lepidopticides."
	spawned_disease = /datum/disease/anxiety

/obj/item/reagent_containers/glass/bottle/beesease
	name = "Beesease culture bottle"
	desc = "A small bottle. Contains a sample of invasive Apidae."
	spawned_disease = /datum/disease/beesease

/obj/item/reagent_containers/glass/bottle/fluspanish
	name = "Spanish flu culture bottle"
	desc = "A small bottle. Contains a sample of Inquisitius."
	spawned_disease = /datum/disease/fluspanish

/obj/item/reagent_containers/glass/bottle/tuberculosis
	name = "Fungal Tuberculosis culture bottle"
	desc = "A small bottle. Contains a sample of Fungal Tubercle bacillus."
	spawned_disease = /datum/disease/tuberculosis

/obj/item/reagent_containers/glass/bottle/regeneration
	name = "Regeneration culture bottle"
	desc = "A small bottle. Contains a sample of a virus that heals toxin damage."
	spawned_disease = /datum/disease/advance/heal

/obj/item/reagent_containers/glass/bottle/sensory_restoration
	name = "Sensory Restoration culture bottle"
	desc = "A small bottle. Contains a sample of a virus that heals sensory damage."
	spawned_disease = /datum/disease/advance/sensory_restoration

/obj/item/reagent_containers/glass/bottle/tuberculosiscure
	name = "BVAK bottle"
	desc = "A small bottle containing Bio Virus Antidote Kit."
	list_reagents = list("atropine" = 5, "epinephrine" = 5, "salbutamol" = 10, "spaceacillin" = 10)

/obj/item/reagent_containers/glass/bottle/zombiecure1
	name = "\improper Anti-Plague Sequence Alpha bottle"
	desc = "A small bottle containing 50 units of Anti-Plague Sequence Alpha. Prevents infection, cures level 1 infection."
	list_reagents = list("zombiecure1" = 50)

/obj/item/reagent_containers/glass/bottle/zombiecure2
	name = "\improper Anti-Plague Sequence Beta bottle"
	desc = "A small bottle containing 50 units of Anti-Plague Sequence Beta. Weakens zombies, heals low infections."
	list_reagents = list("zombiecure2" = 50)

/obj/item/reagent_containers/glass/bottle/zombiecure3
	name = "\improper Anti-Plague Sequence Gamma bottle"
	desc = "A small bottle containing 50 units of Anti-Plague Sequence Gamma. Lowers zombies healing. Heals stage 5 and slows stage 6 infections."
	list_reagents = list("zombiecure3" = 50)

/obj/item/reagent_containers/glass/bottle/zombiecure4
	name = "\improper Anti-Plague Sequence Omega bottle"
	desc = "A small bottle containing 50 units of Anti-Plague Sequence Omega. Cures all cases of the Necrotizing Plague. Also heals dead limbs."
	list_reagents = list("zombiecure4" = 50)
