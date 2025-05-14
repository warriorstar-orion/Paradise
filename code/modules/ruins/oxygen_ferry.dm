/obj/effect/spawner/random/oxygen_ferry_canister
	name = "oxygen ferry canister spawner"
	icon_state = "canister"
	spawn_loot_chance = 30
	loot = list(
		/obj/machinery/atmospherics/portable/canister/oxygen/random_filled = 2,
		/obj/machinery/atmospherics/portable/canister/oxygen/broken
	)

/obj/effect/map_effect/marker/mapmanip/submap/extract/ruin/oxygen_ferry
	name = "Oxygen Ferry"

/obj/effect/map_effect/marker/mapmanip/submap/insert/ruin/oxygen_ferry
	name = "Oxygen Ferry"
