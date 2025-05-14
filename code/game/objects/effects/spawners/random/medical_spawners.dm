/obj/effect/spawner/random/medical
	icon_state = "medkit"
	record_spawn = TRUE

/obj/effect/spawner/random/medical
	name = "miscellaneous medical supplies spawner"
	loot = list(
		// Individual healing items
		list(
			/obj/item/reagent_containers/patch/styptic,
			/obj/item/reagent_containers/pill/salicylic,
			/obj/item/reagent_containers/patch/silver_sulf,
			/obj/item/healthanalyzer,
			/obj/item/healthanalyzer/advanced,
			/obj/item/reagent_containers/applicator/brute,
			/obj/item/reagent_containers/applicator/burn,
			/obj/item/reagent_containers/syringe/charcoal,
			/obj/item/reagent_containers/hypospray/autoinjector/epinephrine,
			/obj/item/reagent_containers/pill/salbutamol,
			/obj/item/stack/medical/bruise_pack,
			/obj/item/stack/medical/ointment,
		) = 3,

		// Surgical Tools
		list(
			/obj/item/bonegel,
			/obj/item/bonesetter,
			/obj/item/cautery,
			/obj/item/circular_saw,
			/obj/item/fix_o_vein,
			/obj/item/hemostat,
			/obj/item/retractor,
			/obj/item/scalpel,
			/obj/item/surgical_drapes,
			/obj/item/surgicaldrill,
		) = 2,

		// Kits
		list(
			/obj/item/storage/firstaid/regular,
			/obj/item/storage/firstaid/regular/doctor,
			/obj/item/storage/firstaid/fire,
			/obj/item/storage/firstaid/toxin,
			/obj/item/storage/firstaid/o2,
			/obj/item/storage/firstaid/brute,
			/obj/item/storage/firstaid/adv,
			/obj/item/storage/firstaid/machine,
			/obj/item/storage/firstaid/surgery,
		) = 1,
	)
