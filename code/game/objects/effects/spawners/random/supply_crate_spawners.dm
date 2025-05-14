/obj/effect/spawner/random/supply_crate
	name = "supply crate spawner"
	spawn_loot_chance = 20

/obj/effect/spawner/random/supply_crate/make_item(spawn_loc, type_path_to_make)
	var/datum/supply_packs/supply_pack = SSeconomy.supply_packs["[type_path_to_make]"]
	if(supply_pack && isturf(spawn_loc))
		. = supply_pack.create_package(spawn_loc)

		if(record_spawn)
			record_item(type_path_to_make)

	else
		log_debug("could not spawn supply crate from spawner with type path [type_path_to_make] to loc [spawn_loc]")

/obj/effect/spawner/random/supply_crate/emergency
	loot = list(
		/datum/supply_packs/emergency/atmostank,
		/datum/supply_packs/emergency/firefighting,
		/datum/supply_packs/emergency/flares,
		/datum/supply_packs/emergency/glowstick/emergency,
		/datum/supply_packs/emergency/internals,
	)

/obj/effect/spawner/random/supply_crate/engi_atmos
	loot = list(
		/datum/supply_packs/engineering/canister/air,
		/datum/supply_packs/engineering/canister/nitrogen,
		/datum/supply_packs/engineering/canister/oxygen,
		/datum/supply_packs/engineering/engiequipment,
		/datum/supply_packs/engineering/engine,
		/datum/supply_packs/engineering/engine/coil,
		/datum/supply_packs/engineering/engine/collector,
		/datum/supply_packs/engineering/engine/field_gen,
		/datum/supply_packs/engineering/engine/grounding,
		/datum/supply_packs/engineering/foamtank,
		/datum/supply_packs/engineering/fueltank,
		/datum/supply_packs/engineering/inflatable,
		/datum/supply_packs/engineering/radiation,
		/datum/supply_packs/engineering/solar,
		/datum/supply_packs/engineering/vending/clothingvendor,
	)

/obj/effect/spawner/random/supply_crate/misc
	loot = list(
		/datum/supply_packs/misc/artscrafts,
		/datum/supply_packs/misc/barberkit,
		/datum/supply_packs/misc/carpet,
		/datum/supply_packs/misc/paper,
		/datum/supply_packs/misc/posters,
		/datum/supply_packs/misc/toilet,
		/datum/supply_packs/misc/vending/clothingvendor,
		/datum/supply_packs/misc/vending/clothingvendor/cargo,
	)

/obj/effect/spawner/random/supply_crate/janitorial
	loot = list(
		/datum/supply_packs/misc/janitor,
		/datum/supply_packs/misc/janitor/janicart,
		/datum/supply_packs/misc/janitor/janitank,
		/datum/supply_packs/misc/janitor/lightbulbs,
		/datum/supply_packs/misc/hightank,
	)

/// Most other supply crate loot spawners are capped at items that
/// cost less than 150 credits (as of writing this). However that
/// basically wipes out all of the medical supply packs so we
/// deepen our pockets a bit more for this one.
/obj/effect/spawner/random/supply_crate/medical
	spawn_loot_chance = 15
	loot = list(
		/datum/supply_packs/medical/vending,
		/datum/supply_packs/medical/vending/clothingvendor,
		/datum/supply_packs/medical/firstaid,
		/datum/supply_packs/medical/firstaidmachine,
		/datum/supply_packs/medical/firstaibrute,
		/datum/supply_packs/medical/firstaidburns,
		/datum/supply_packs/medical/firstaidtoxins,
		/datum/supply_packs/medical/firstaidoxygen,
	)

/obj/effect/spawner/random/supply_crate/organic
	loot = list(
		/datum/supply_packs/organic/chicken,
		/datum/supply_packs/organic/cow,
		/datum/supply_packs/organic/goat,
		/datum/supply_packs/organic/hydroponics/beekeeping_fullkit,
		/datum/supply_packs/organic/hydroponics/beekeeping_suits,
		/datum/supply_packs/organic/hydroponics/hydrotank,
		/datum/supply_packs/organic/hydroponics/seeds,
		/datum/supply_packs/organic/nian_caterpillar,
		/datum/supply_packs/organic/pig,
		/datum/supply_packs/organic/turkey,
		/datum/supply_packs/organic/vending/hydro_refills,
	)
