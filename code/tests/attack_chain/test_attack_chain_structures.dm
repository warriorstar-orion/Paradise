/datum/game_test/attack_chain_structures
	testing_area_name = "test_attack_chain_structures.dmm"
	var/list/structure_instances_by_type = list()

/datum/game_test/attack_chain_structures/proc/teleport_to_first(datum/test_puppeteer/player, obj_type, dir=EAST)
	if(length(structure_instances_by_type[obj_type]))
		for(var/atom/object in structure_instances_by_type[obj_type])
			if(!QDELETED(object))
				player.puppet.forceMove(get_step(object, dir))
				return object
	TEST_FAIL("could not find [obj_type] to teleport puppet to")

/datum/game_test/attack_chain_structures/New()
	. = ..()
	for(var/turf/T in available_turfs)
		for(var/obj/structure/structure in T)
			LAZYOR(structure_instances_by_type[structure.type], structure)

/datum/game_test/attack_chain_structures/Run()
	var/datum/test_puppeteer/player = new(src)
	player.puppet.name = "Player"

	player.puppet.mind.add_antag_datum(/datum/antagonist/cultist)
	var/dagger = player.spawn_obj_in_hand(/obj/item/melee/cultblade/dagger)

	var/forge = teleport_to_first(player, /obj/structure/cult/functional/forge)
	player.click_on(forge)
	TEST_ASSERT_LAST_CHATLOG(player, "You unsecure [forge] from the floor")
	qdel(dagger)

	var/obj/structure/ai_core/core = teleport_to_first(player, /obj/structure/ai_core)
	player.spawn_obj_in_hand(/obj/item/circuitboard/aicore)
	player.click_on(core)
	TEST_ASSERT_LAST_CHATLOG(player, "You place the circuit board inside the frame")

	var/shell = teleport_to_first(player, /obj/structure/constructshell)
	var/obj/item/soulstone/soulstone = player.spawn_obj_in_hand(/obj/item/soulstone)
	soulstone.purified = TRUE
	player.click_on(shell)
	TEST_ASSERT_LAST_CHATLOG(player, "An overwhelming feeling of dread comes over you")
	qdel(soulstone)
	player.rejuvenate()

	var/obj/structure/computerframe/frame = teleport_to_first(player, /obj/structure/computerframe)
	var/obj/circuitboard = player.spawn_obj_in_hand(/obj/item/circuitboard/computer/sat_control)
	player.click_on(frame)
	TEST_ASSERT_LAST_CHATLOG(player, "You place [circuitboard] inside the computer frame")

	var/barricade = teleport_to_first(player, /obj/structure/barricade/wooden)
	var/wood = player.spawn_obj_in_hand(/obj/item/stack/sheet/wood)
	player.click_on(barricade)
	TEST_ASSERT_LAST_CHATLOG(player, "You need at least five wooden planks to make a wall")
	qdel(wood)

	var/firelock_frame = teleport_to_first(player, /obj/structure/firelock_frame)
	var/obj/item/firelock_electronics/electronics = player.spawn_obj_in_hand(/obj/item/firelock_electronics)
	electronics.toolspeed = 0
	player.click_on(firelock_frame)
	TEST_ASSERT_LAST_CHATLOG(player, "You insert and secure [electronics]")

	var/machine_frame = teleport_to_first(player, /obj/structure/machine_frame)
	var/obj/item/stack/cable_coil/coil = player.spawn_fast_tool(/obj/item/stack/cable_coil)
	coil.amount = 5
	player.click_on(machine_frame)
	TEST_ASSERT_LAST_CHATLOG(player, "You add cables to the frame.")

	var/obj/structure/largecrate/large_crate = teleport_to_first(player, /obj/structure/largecrate)
	large_crate.manifest = new /obj/item/paper/manifest(null)
	var/obj/item/paper/in_hand_paper = player.spawn_obj_in_hand(/obj/item/paper)
	player.click_on(large_crate)
	TEST_ASSERT_LAST_CHATLOG(player, "You tear the manifest off of the crate")
	qdel(in_hand_paper)

	var/obj/structure/displaycase/displaycase = teleport_to_first(player, /obj/structure/displaycase)
	var/obj/id_card = player.spawn_obj_in_hand(/obj/item/card/id/assistant)
	player.click_on(displaycase)
	TEST_ASSERT_LAST_CHATLOG(player, "You use [id_card] to open [displaycase]")
	player.put_away(id_card)
	var/obj/item/toy/crayon/crayon = player.spawn_obj_in_hand(/obj/item/toy/crayon)
	player.click_on(displaycase)
	TEST_ASSERT_LAST_CHATLOG(player, "You put [crayon] on display")
	player.retrieve(id_card)
	player.click_on(displaycase)
	TEST_ASSERT_LAST_CHATLOG(player, "You use [id_card] to close [displaycase]")
	player.put_away(id_card)
	var/obj/baton = player.spawn_obj_in_hand(/obj/item/melee/baton/loaded)
	player.set_intent("harm")
	player.click_on(displaycase)
	TEST_ASSERT_LAST_CHATLOG(player, "You hit [displaycase] with [baton]")
	qdel(baton)

	var/obj/structure/door_assembly/assembly = teleport_to_first(player, /obj/structure/door_assembly)
	var/obj/item/wrench/wrench = player.spawn_fast_tool(/obj/item/wrench)
	player.click_on(assembly)
	TEST_ASSERT_LAST_CHATLOG(player, "You unsecure [assembly].")
	player.put_away(wrench)
	var/obj/item/stack/cable_coil/cable = player.spawn_fast_tool(/obj/item/stack/cable_coil)
	player.click_on(assembly)
	TEST_ASSERT_LAST_CHATLOG(player, "You wire [assembly].")

	var/obj/structure/girder/girder = teleport_to_first(player, /obj/structure/girder/cult)
	player.puppet.mind.add_antag_datum(/datum/antagonist/cultist)
	dagger = player.spawn_obj_in_hand(/obj/item/melee/cultblade/dagger)
	player.click_on(girder)
	TEST_ASSERT_LAST_CHATLOG(player, "You demolish [girder].")
	qdel(dagger)

	girder = teleport_to_first(player, /obj/structure/girder)
	player.spawn_fast_tool(/obj/item/stack/sheet/metal{amount = 2})
	player.click_on(girder)
	TEST_ASSERT_LAST_CHATLOG(player, "You add the plating.")

	girder = teleport_to_first(player, /obj/structure/girder)
	var/obj/item/gun/energy/plasmacutter/cutter = player.spawn_fast_tool(/obj/item/gun/energy/plasmacutter)
	player.click_on(girder)
	TEST_ASSERT_LAST_CHATLOG(player, "You slice apart the girder.")
	qdel(cutter)
