/datum/spawn_pool/spaceloot
	id = "space_loot_spawn_pool"
	available_points = 1600

/obj/effect/spawner/random/pool/spaceloot
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "giftbox"
	spawn_pool_id = "space_loot_spawn_pool"
	record_spawn = TRUE

/obj/effect/spawner/random/pool/spaceloot/record_item(type_path_to_make)
	if(ispath(type_path_to_make, /obj/effect))
		return

	SSblackbox.record_feedback("tally", "space_loot_spawns", 1, "[type_path_to_make]")

/obj/effect/spawner/random/pool/spaceloot/dvorak_core_table
	point_value = 100
	guaranteed = TRUE
	loot = list(
		/obj/item/rcd/combat,
		/obj/item/gun/medbeam,
		/obj/item/gun/energy/wormhole_projector,
		/obj/item/storage/box/syndie_kit/oops_all_extraction_flares,
	)

/obj/effect/spawner/random/pool/spaceloot/dvorak_emp_loot
	point_value = 100
	guaranteed = TRUE
	loot = list(
		/obj/item/grenade/empgrenade = 8,
		/obj/item/gun/energy/ionrifle/carbine = 1,
		/obj/item/gun/energy/ionrifle = 1,
	)

/obj/effect/spawner/random/pool/spaceloot/dvorak_displaycase
	point_value = 100
	guaranteed = TRUE
	spawn_inside = /obj/structure/displaycase/dvoraks_treat
	loot = list(
		/obj/item/remote_ai_upload = 8,

		list(
			/obj/item/assembly/signaler/anomaly/pyro,
			/obj/item/assembly/signaler/anomaly/cryo,
			/obj/item/assembly/signaler/anomaly/grav,
			/obj/item/assembly/signaler/anomaly/flux,
			/obj/item/assembly/signaler/anomaly/bluespace,
			/obj/item/assembly/signaler/anomaly/vortex,
		) = 4,

		list(
			/obj/item/organ/internal/cyberimp/brain/sensory_enhancer,
			/obj/item/organ/internal/cyberimp/brain/hackerman_deck,
			/obj/item/storage/lockbox/experimental_weapon
		) = 1
	)

/obj/effect/spawner/random/pool/spaceloot/syndicate/common
	name = "syndicate depot loot, common"
	icon_state = "loot"
	point_value = 10
	loot = list(
		// Loot schema: costumes, toys, useless gimmick items
		/obj/item/clothing/mask/gas/syndicate,
		/obj/item/clothing/shoes/magboots/syndie,
		/obj/item/clothing/under/syndicate,
		/obj/item/coin/antagtoken/syndicate,
		/obj/item/deck/cards/syndicate,
		/obj/item/soap/syndie,
		/obj/item/storage/box/syndie_kit/space,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate,
		/obj/item/storage/secure/briefcase/syndie,
		/obj/item/storage/toolbox/syndicate,
		/obj/item/suppressor,
		/obj/item/toy/syndicateballoon,
	)

/obj/effect/spawner/random/pool/spaceloot/syndicate/common/depot
	spawn_inside = /obj/structure/closet/secure_closet/syndicate/depot
	spawn_loot_chance = 50

/obj/effect/spawner/random/pool/spaceloot/syndicate/stetchkin
	name = "syndicate depot loot, 20pct stetchkin"
	icon_state = "stetchkin"
	spawn_loot_chance = 80
	point_value = 25
	loot = list(/obj/item/gun/projectile/automatic/pistol)

/obj/effect/spawner/random/pool/spaceloot/syndicate/rare
	name = "syndicate depot loot, rare"
	icon_state = "doubleloot"
	point_value = 60
	// Basic stealth, utility and environmental gear.
	loot = list(
		/obj/item/ammo_box/magazine/m10mm,
		/obj/item/clothing/gloves/color/black/thief,
		/obj/item/clothing/shoes/chameleon/noslip,
		/obj/item/clothing/suit/jacket/bomber/syndicate,
		/obj/item/clothing/suit/storage/iaa/blackjacket/armored,
		/obj/item/clothing/under/chameleon,
		/obj/item/clothing/under/syndicate/silicon_cham,
		/obj/item/flash/cameraflash,
		/obj/item/gun/projectile/automatic/toy/pistol/riot,
		/obj/item/lighter/zippo/gonzofist,
		/obj/item/mod/control/pre_equipped/traitor,
		/obj/item/mod/module/chameleon,
		/obj/item/mod/module/holster/hidden,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/visor/night,
		/obj/item/reagent_containers/hypospray/autoinjector/nanocalcium,
		/obj/item/stack/sheet/mineral/gold{amount = 20},
		/obj/item/stack/sheet/mineral/plasma{amount = 20},
		/obj/item/stack/sheet/mineral/silver{amount = 20},
		/obj/item/stack/sheet/mineral/uranium{amount = 20},
		/obj/item/stamp/chameleon,
		/obj/item/storage/backpack/duffel/syndie/med/surgery,
		/obj/item/storage/backpack/satchel_flat,
		/obj/item/storage/belt/military,
		/obj/item/storage/box/syndie_kit/camera_bug,
		/obj/item/storage/firstaid/tactical,
	)

/obj/effect/spawner/random/pool/spaceloot/syndicate/rare/depot
	spawn_inside = /obj/structure/closet/secure_closet/syndicate/depot
	spawn_loot_chance = 50

/obj/effect/spawner/random/pool/spaceloot/syndicate/officer
	name = "syndicate depot loot, officer"
	point_value = 100
	// Primarily utility items with occasional low damage weaponry.
	loot = list(
		/obj/item/borg/upgrade/selfrepair,
		/obj/item/borg/upgrade/syndicate,
		/obj/item/clothing/glasses/hud/security/chameleon,
		/obj/item/clothing/glasses/thermal,
		/obj/item/clothing/shoes/magboots/elite,
		/obj/item/door_remote/omni/access_tuner,
		/obj/item/encryptionkey/binary,
		/obj/item/jammer,
		/obj/item/mod/module/power_kick,
		/obj/item/mod/module/stealth,
		/obj/item/mod/module/visor/thermal,
		/obj/item/pen/edagger,
		/obj/item/pinpointer/advpinpointer,
		/obj/item/stack/sheet/mineral/diamond{amount = 10},
		/obj/item/stack/sheet/mineral/uranium{amount = 10},
		/obj/item/storage/box/syndidonkpockets,
		/obj/item/storage/box/syndie_kit/stechkin,
	)

/obj/effect/spawner/random/pool/spaceloot/syndicate/officer/depot
	spawn_inside = /obj/structure/closet/secure_closet/syndicate/depot
	spawn_loot_chance = 40

/obj/effect/spawner/random/pool/spaceloot/syndicate/armory
	name = "syndicate depot loot, armory"
	// Combat orientated items that could give the player an advantage if an antag messes with them.
	point_value = 200
	loot = list(
		/obj/item/autosurgeon/organ/syndicate/oneuse/razorwire,
		/obj/item/chameleon,
		/obj/item/clothing/gloves/fingerless/rapid,
		/obj/item/CQC_manual,
		/obj/item/gun/medbeam,
		/obj/item/melee/energy/sword/saber,
		/obj/item/reagent_containers/hypospray/autoinjector/stimulants,
		/obj/item/shield/energy,
		/obj/item/storage/box/syndie_kit/teleporter,
		/obj/item/weaponcrafting/gunkit/universal_gun_kit,
		/obj/item/mod/control/pre_equipped/traitor_elite
	)

/obj/effect/spawner/random/pool/spaceloot/syndicate/armory/depot
	guaranteed = TRUE
	spawn_inside = /obj/structure/closet/secure_closet/syndicate/depot/armory

/obj/effect/spawner/random/pool/spaceloot/syndicate/mixed
	loot = list(
		/obj/effect/spawner/random/pool/spaceloot/syndicate/common = 15,
		/obj/effect/spawner/random/pool/spaceloot/syndicate/rare = 5,
		/obj/effect/spawner/random/pool/spaceloot/syndicate/officer = 1,
		/obj/effect/spawner/random/pool/spaceloot/syndicate/stetchkin = 1,
		/obj/effect/spawner/random/pool/spaceloot/syndicate/armory = 1,
	)

// Only two of these
/obj/effect/spawner/random/pool/spaceloot/zoo
	unique_picks = TRUE
	point_value = 20
	loot = list(
		/obj/item/gun/energy/floragun,
		/obj/item/gun/energy/temperature,
	)

/obj/effect/spawner/random/pool/spaceloot/modsuit_syndie
	point_value = 100
	spawn_loot_chance = 50
	loot = list(/mob/living/simple_animal/hostile/syndicate/ranged/space/autogib)

/obj/effect/spawner/random/pool/spaceloot/safe_contents/mixed
	unique_picks = TRUE
	guaranteed = TRUE
	loot = list(
		/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe1,
		/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe2,
		/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe3,
		/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe4,
		/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe5,
	)

/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe1
	spawn_all_loot = TRUE
	spawn_loot_double = FALSE
	guaranteed = TRUE
	loot = list(
		/obj/item/tank/internals/oxygen/red,
		/obj/item/clothing/mask/gas/syndicate,
		/obj/item/mod/control/pre_equipped/mining/asteroid,
		/obj/item/reagent_containers/drinks/bottle/rum,
		/obj/item/reagent_containers/drinks/bottle/rum,
		/obj/item/folder/syndicate/blue,
	)

/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe2
	spawn_all_loot = TRUE
	guaranteed = TRUE
	loot = list(
		/obj/item/gun/projectile/revolver/doublebarrel,
		/obj/item/stack/spacecash/c500,
		/obj/item/stack/sheet/mineral/gold{amount = 15},
	)

/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe3
	spawn_all_loot = TRUE
	guaranteed = TRUE
	loot = list(
		/obj/item/stack/spacecash/c500,
		/obj/item/circuitboard/teleporter_hub,
	)

/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe4
	spawn_all_loot = TRUE
	guaranteed = TRUE
	loot = list(
		/obj/item/stack/spacecash/c200,
		/obj/item/stack/sheet/mineral/gold/fifty,
		/obj/item/clothing/gloves/ring/plasma,
		/obj/item/banhammer,
	)

/obj/effect/spawner/random/pool/spaceloot/safe_contents/safe5
	spawn_all_loot = TRUE
	guaranteed = TRUE
	loot = list(
		/obj/item/circuitboard/teleporter,
		/obj/item/circuitboard/teleporter_hub,
		/obj/item/clothing/suit/hgpirate,
		/obj/item/reagent_containers/drinks/cans/beer/sleepy_beer,
		/obj/item/clothing/gloves/ring/gold,
		/obj/item/id_decal/gold,
		/obj/item/screwdriver,
		/obj/item/toy/plushie/carpplushie/gold,
	)
