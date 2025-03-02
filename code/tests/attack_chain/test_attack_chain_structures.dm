/datum/game_test/attack_chain_structures/Run()
	var/datum/test_puppeteer/player = new(src)
	player.puppet.name = "Player"

	player.puppet.mind.add_antag_datum(/datum/antagonist/cultist)
	var/dagger = player.spawn_obj_in_hand(/obj/item/melee/cultblade/dagger)

	var/forge = player.spawn_obj_nearby(/obj/structure/cult/functional/forge)
	player.click_on(forge)
	TEST_ASSERT_LAST_CHATLOG(player, "You unsecure the daemon forge from the floor")
	qdel(dagger)
	qdel(forge)

	var/obj/structure/ai_core/core = player.spawn_obj_nearby(/obj/structure/ai_core)
	player.spawn_obj_in_hand(/obj/item/circuitboard/aicore)
	player.click_on(core)
	TEST_ASSERT_LAST_CHATLOG(player, "You place the circuit board inside the frame")
	qdel(core)

	var/shell = player.spawn_obj_nearby(/obj/structure/constructshell)
	var/obj/item/soulstone/soulstone = player.spawn_obj_in_hand(/obj/item/soulstone)
	soulstone.purified = TRUE
	player.click_on(shell)
	TEST_ASSERT_LAST_CHATLOG(player, "An overwhelming feeling of dread comes over you")
	qdel(soulstone)
	qdel(shell)
	player.rejuvenate()

	var/obj/structure/computerframe/frame = player.spawn_obj_nearby(/obj/structure/computerframe)
	player.spawn_obj_in_hand(/obj/item/circuitboard/computer/sat_control)
	player.click_on(frame)
	TEST_ASSERT_LAST_CHATLOG(player, "You place the circuit board (Satellite Network Control) inside the computer frame")
	qdel(frame)

	var/barricade = player.spawn_obj_nearby(/obj/structure/barricade/wooden)
	var/wood = player.spawn_obj_in_hand(/obj/item/stack/sheet/wood)
	player.click_on(barricade)
	TEST_ASSERT_LAST_CHATLOG(player, "You need at least five wooden planks to make a wall")
	qdel(barricade)
	qdel(wood)

	var/firelock_frame = player.spawn_obj_nearby(/obj/structure/firelock_frame)
	var/obj/item/firelock_electronics/electronics = player.spawn_obj_in_hand(/obj/item/firelock_electronics)
	electronics.toolspeed = 0
	player.click_on(firelock_frame)
	TEST_ASSERT_LAST_CHATLOG(player, "You insert and secure the firelock electronics")
	qdel(firelock_frame)

	var/machine_frame = player.spawn_obj_nearby(/obj/structure/machine_frame)
	var/obj/item/stack/cable_coil/coil = player.spawn_obj_in_hand(/obj/item/stack/cable_coil)
	coil.amount = 5
	coil.toolspeed = 0
	player.click_on(machine_frame)
	TEST_ASSERT_LAST_CHATLOG(player, "You add cables to the frame.")
