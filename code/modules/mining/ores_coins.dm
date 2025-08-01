#define GIBTONITE_QUALITY_LOW 1
#define GIBTONITE_QUALITY_MEDIUM 2
#define GIBTONITE_QUALITY_HIGH 3
#define PROBABILITY_REFINE_BY_FIRE 50
#define ORESTACK_OVERLAYS_MAX 10
//////////////////////////////
// MARK: ORES
//////////////////////////////
/obj/item/stack/ore
	name = "rock"
	icon = 'icons/obj/stacks/ores.dmi'
	lefthand_file = 'icons/mob/inhands/ore_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/ore_righthand.dmi'
	icon_state = "ore"
	singular_name = "ore chunk"
	var/points = 0 //How many points this ore gets you from the ore redemption machine
	var/refined_type = null //What this ore defaults to being refined into

/obj/item/stack/ore/Initialize(mapload, new_amount, merge = TRUE)
	. = ..()
	scatter_atom()

/obj/item/stack/ore/scatter_atom(x_offset, y_offset)
	pixel_x = rand(-8, 8) + x_offset
	pixel_y = rand(-8, 0) + y_offset

/obj/item/stack/ore/welder_act(mob/user, obj/item/I)
	. = TRUE
	if(!refined_type)
		to_chat(user, "<span class='notice'>You can't smelt [src] into anything useful!</span>")
		return
	if(!I.use_tool(src, user, 0, 15, volume = I.tool_volume))
		return
	new refined_type(drop_location(), amount)
	to_chat(user, "<span class='notice'>You smelt [src] into its refined form!</span>")
	qdel(src)

/obj/item/stack/ore/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume, global_overlay = TRUE)
	. = ..()
	if(isnull(refined_type))
		return
	else
		var/amountrefined = round((PROBABILITY_REFINE_BY_FIRE / 100) * amount, 1)
		if(amountrefined < 1)
			qdel(src)
		else
			new refined_type(get_turf(loc), amountrefined)
			qdel(src)

/obj/item/stack/ore/glass
	name = "sand pile"
	desc = "A coarse, dust mainly composed of quartz and silica-rich rock. Among its many uses, it can be refined into glass when fired at high tempratures."
	icon_state = "sand"
	item_state = "sand"
	singular_name = "sand pile"
	points = 1
	refined_type = /obj/item/stack/sheet/glass
	merge_type = /obj/item/stack/ore/glass
	materials = list(MAT_GLASS=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/glass/examine(mob/user)
	. = ..()
	. += "<span class='notice'>You can throw this into people's eyes!</span>"

GLOBAL_LIST_INIT(sand_recipes, list(\
		new /datum/stack_recipe("sandstone", /obj/item/stack/sheet/mineral/sandstone, 1, 1, 50)\
		))

/obj/item/stack/ore/glass/Initialize(mapload, new_amount, merge = TRUE)
	recipes = GLOB.sand_recipes
	. = ..()

/obj/item/stack/ore/glass/throw_impact(atom/hit_atom)
	if(..() || !ishuman(hit_atom))
		return
	var/mob/living/carbon/human/C = hit_atom
	if(C.head && C.head.flags_cover & HEADCOVERSEYES)
		visible_message("<span class='danger'>[C]'s headgear blocks the sand!</span>")
		return
	if(C.wear_mask && C.wear_mask.flags_cover & MASKCOVERSEYES)
		visible_message("<span class='danger'>[C]'s mask blocks the sand!</span>")
		return
	if(C.glasses && C.glasses.flags_cover & GLASSESCOVERSEYES)
		visible_message("<span class='danger'>[C]'s glasses block the sand!</span>")
		return
	C.EyeBlurry(12 SECONDS)
	C.apply_damage(15, STAMINA)//the pain from your eyes burning does stamina damage
	C.AdjustConfused(10 SECONDS)
	to_chat(C, "<span class='userdanger'>[src] gets into your eyes! The pain, it burns!</span>")
	qdel(src)

/obj/item/stack/ore/glass/ex_act(severity)
	if(severity == EXPLODE_NONE)
		return
	qdel(src)

/obj/item/stack/ore/glass/basalt
	name = "volcanic ash"
	desc = "A coarse, abrasive basaltic dust rich in silica and various elemental oxides. Commonly refined into glass or used as fertiliser."
	icon_state = "volcanic_sand"
	item_state = "volcanic_sand"
	singular_name = "volcanic ash pile"

/obj/item/stack/ore/glass/basalt/examine(mob/user)
	. = ..()
	. += "<span class='notice'>You could add some to a girder to make a false rock wall.</span>"

/obj/item/stack/ore/glass/basalt/ancient
	name = "ancient sand"
	desc = "Basultic sand mined from an exceptionally old and compacted formation."
	singular_name = "ancient sand pile"

/obj/item/stack/ore/iron
	name = "iron ore"
	desc = "Exceptionally common ore that can be refined into iron and steel."
	icon_state = "iron_ore"
	item_state = "iron_ore"
	singular_name = "iron ore chunk"
	points = 1
	refined_type = /obj/item/stack/sheet/metal
	materials = list(MAT_METAL = MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/plasma
	name = "plasma ore"
	desc = "The reason you're here."
	icon_state = "plasma_ore"
	item_state = "plasma_ore"
	origin_tech = "plasmatech=2;materials=2"
	singular_name = "plasma ore chunk"
	points = 15
	refined_type = /obj/item/stack/sheet/mineral/plasma
	materials = list(MAT_PLASMA=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/silver
	name = "silver ore"
	desc = "Metal ore rich in precious silver."
	icon_state = "silver_ore"
	item_state = "silver_ore"
	origin_tech = "materials=3"
	singular_name = "silver ore chunk"
	points = 16
	refined_type = /obj/item/stack/sheet/mineral/silver
	materials = list(MAT_SILVER=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/gold
	name = "gold ore"
	desc = "WE'RE RICH!"
	icon_state = "gold_ore"
	item_state = "gold_ore"
	origin_tech = "materials=4"
	singular_name = "gold ore chunk"
	points = 18
	refined_type = /obj/item/stack/sheet/mineral/gold
	materials = list(MAT_GOLD=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/uranium
	name = "uranium ore"
	desc = "Radioactive ore containing significant amounts of natural uranium."
	icon_state = "uranium_ore"
	item_state = "uranium_ore"
	origin_tech = "materials=5"
	singular_name = "uranium ore chunk"
	points = 30
	refined_type = /obj/item/stack/sheet/mineral/uranium
	materials = list(MAT_URANIUM=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/titanium
	name = "titanium ore"
	icon_state = "titanium_ore"
	item_state = "titanium_ore"
	singular_name = "titanium ore chunk"
	points = 50
	materials = list(MAT_TITANIUM=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/titanium

/obj/item/stack/ore/diamond
	name = "diamond ore"
	desc = "Rock formation containing diamond."
	icon_state = "diamond_ore"
	item_state = "diamond_ore"
	origin_tech = "materials=6"
	singular_name = "diamond ore chunk"
	points = 50
	refined_type = /obj/item/stack/sheet/mineral/diamond
	materials = list(MAT_DIAMOND=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/diamond/ten
	amount = 10

/obj/item/stack/ore/platinum
	name = "platinum ore"
	desc = "Rock formation containing platinum."
	icon_state = "platinum_ore"
	item_state = "platinum_ore"
	origin_tech = "materials=5"
	singular_name = "platinum ore chunk"
	points = 50
	refined_type = /obj/item/stack/sheet/mineral/platinum
	materials = list(MAT_PLATINUM = MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/palladium
	name = "palladium ore"
	desc = "Rock formation containing palladium."
	icon_state = "palladium_ore"
	item_state = "palladium_ore"
	origin_tech = "materials=5"
	singular_name = "palladium ore chunk"
	points = 50
	refined_type = /obj/item/stack/sheet/mineral/palladium
	materials = list(MAT_PALLADIUM = MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/iridium
	name = "iridium ore"
	desc = "Rock formation containing iridium."
	icon_state = "iridium_ore"
	item_state = "iridium_ore"
	origin_tech = "materials=5"
	singular_name = "iridium ore chunk"
	points = 50
	refined_type = /obj/item/stack/sheet/mineral/iridium
	materials = list(MAT_IRIDIUM = MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/brass
	name = "brass ore"
	desc = "Rock formation containing brass. This ore is not naturally occurring - if you see this, let development know."
	singular_name = "brass ore chunk"
	points = 1
	refined_type = /obj/item/stack/tile/brass
	materials = list(MAT_BRASS = MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/bananium
	name = "bananium ore"
	desc = "HONK!"
	icon_state = "bananium_ore"
	item_state = "bananium_ore"
	origin_tech = "materials=4"
	singular_name = "bananium ore chunk"
	points = 60
	refined_type = /obj/item/stack/sheet/mineral/bananium
	materials = list(MAT_BANANIUM=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/tranquillite
	name = "tranquillite ore"
	desc = "..."
	icon_state = "tranquillite_ore"
	item_state = "tranquillite_ore"
	origin_tech = "materials=4"
	singular_name = "transquillite ore chunk"
	points = 60
	refined_type = /obj/item/stack/sheet/mineral/tranquillite
	materials = list(MAT_TRANQUILLITE=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/ore/slag
	name = "slag"
	desc = "Completely useless."
	icon_state = "slag"
	singular_name = "slag chunk"

//////////////////////////////
// MARK: GIBTONITE
//////////////////////////////
/obj/item/gibtonite
	name = "gibtonite ore"
	desc = "Extremely explosive if struck with mining equipment, Gibtonite is often used by miners to speed up their work by using it as a mining charge. This material is illegal to possess by unauthorized personnel under Space Law."
	icon = 'icons/obj/mining.dmi'
	icon_state = "Gibtonite ore"
	item_state = "Gibtonite ore"
	w_class = WEIGHT_CLASS_BULKY
	throw_range = 0
	anchored = TRUE //Forces people to carry it by hand, no pulling!
	var/primed = 0
	var/det_time = 100
	var/quality = GIBTONITE_QUALITY_LOW //How pure this gibtonite is, determines the explosion produced by it and is derived from the det_time of the rock wall it was taken from, higher value = better
	var/attacher = "UNKNOWN"
	var/datum/wires/explosive/gibtonite/wires

/obj/item/gibtonite/examine(mob/user)
	. = ..()
	. += "<span class='notice'>You can use a mining scanner to stop an activated gibtonite crystal from detonating.</span>"
	. += "<span class='notice'>In addition to simply hitting it, you can add a remote signaller to the gibtonite and trigger it to make the crystal begin to detonate!</span>"

/obj/item/gibtonite/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/obj/item/gibtonite/Destroy()
	if(wires)
		SStgui.close_uis(wires)
		QDEL_NULL(wires)
	return ..()

/obj/item/gibtonite/attackby__legacy__attackchain(obj/item/I, mob/user, params)
	if(!wires && istype(I, /obj/item/assembly/igniter))
		user.visible_message("[user] attaches [I] to [src].", "<span class='notice'>You attach [I] to [src].</span>")
		wires = new(src)
		attacher = key_name(user)
		qdel(I)
		overlays += "Gibtonite_igniter"
		return

	if(wires && !primed)
		if(istype(I, /obj/item/wirecutters) || istype(I, /obj/item/multitool) || istype(I, /obj/item/assembly/signaler))
			wires.Interact(user)
			return

	if(istype(I, /obj/item/pickaxe) || istype(I, /obj/item/resonator) || I.force >= 10)
		GibtoniteReaction(user)
		return
	if(primed)
		if(istype(I, /obj/item/mining_scanner) || istype(I, /obj/item/t_scanner/adv_mining_scanner) || istype(I, /obj/item/multitool))
			primed = 0
			user.visible_message("The chain reaction was stopped! ...The ore's quality looks diminished.", "<span class='notice'>You stopped the chain reaction. ...The ore's quality looks diminished.</span>")
			icon_state = "Gibtonite ore"
			quality = GIBTONITE_QUALITY_LOW
			return
	..()

/obj/item/gibtonite/attack_ghost(mob/user)
	if(wires)
		wires.Interact(user)

/obj/item/gibtonite/attack_self__legacy__attackchain(mob/user)
	if(wires)
		wires.Interact(user)
	else
		..()

/obj/item/gibtonite/bullet_act(obj/item/projectile/P)
	GibtoniteReaction(P.firer)
	..()

/obj/item/gibtonite/ex_act()
	GibtoniteReaction(null, 1)

/obj/item/gibtonite/proc/GibtoniteReaction(mob/user, triggered_by = 0)
	if(!primed)
		playsound(src,'sound/effects/hit_on_shattered_glass.ogg',50,1)
		primed = 1
		icon_state = "Gibtonite active"
		var/turf/bombturf = get_turf(src)
		var/notify_admins = 0
		if(!is_mining_level(z))//Only annoy the admins ingame if we're triggered off the mining zlevel
			notify_admins = 1

		if(notify_admins)
			if(triggered_by == 1)
				message_admins("An explosion has triggered a [name] to detonate at [ADMIN_COORDJMP(bombturf)].")
			else if(triggered_by == 2)
				message_admins("A signal has triggered a [name] to detonate at [ADMIN_COORDJMP(bombturf)]. Igniter attacher: [key_name_admin(attacher)]")
			else
				message_admins("[key_name_admin(user)] has triggered a [name] to detonate at [ADMIN_COORDJMP(bombturf)].")
		if(triggered_by == 1)
			log_game("An explosion has primed a [name] for detonation at [AREACOORD(bombturf)]")
		else if(triggered_by == 2)
			log_game("A signal has primed a [name] for detonation at [AREACOORD(bombturf)]). Igniter attacher: [key_name(attacher)].")
		else
			user.visible_message("<span class='warning'>[user] strikes \the [src], causing a chain reaction!</span>", "<span class='danger'>You strike \the [src], causing a chain reaction.</span>")
			log_game("[key_name(user)] has primed a [name] for detonation at [AREACOORD(bombturf)])")
		spawn(det_time)
		if(primed)
			if(quality == GIBTONITE_QUALITY_HIGH)
				explosion(loc, 2, 4, 9, adminlog = notify_admins, cause = "Movable Gibtonite")
			if(quality == GIBTONITE_QUALITY_MEDIUM)
				explosion(loc, 1, 2, 5, adminlog = notify_admins, cause = "Movable Gibtonite")
			if(quality == GIBTONITE_QUALITY_LOW)
				explosion(loc, -1, 1, 3, adminlog = notify_admins, cause = "Movable Gibtonite")
			qdel(src)


/obj/item/stack/ore/ex_act(severity)
	if(!severity || severity >= EXPLODE_HEAVY)
		return
	qdel(src)


//////////////////////////////
// MARK: COINS
//////////////////////////////
/obj/item/coin
	icon = 'icons/obj/economy.dmi'
	name = "coin"
	icon_state = "coin__heads"
	flags = CONDUCT
	force = 1
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	var/string_attached
	var/list/sideslist = list("heads","tails")
	var/cmineral = null
	var/name_by_cmineral = TRUE
	var/cooldown = 0
	var/credits = 10

/obj/item/coin/Initialize(mapload)
	. = ..()
	icon_state = "coin_[cmineral]_[sideslist[1]]"
	if(cmineral && name_by_cmineral)
		name = "[cmineral] coin"
	update_appearance(UPDATE_NAME|UPDATE_ICON_STATE)
	AddComponent(/datum/component/surgery_initiator/robo)

/obj/item/coin/gold
	cmineral = "gold"
	icon_state = "coin_gold_heads"
	materials = list(MAT_GOLD = 400)
	credits = 160

/obj/item/coin/silver
	cmineral = "silver"
	icon_state = "coin_silver_heads"
	materials = list(MAT_SILVER = 400)
	credits = 40

/obj/item/coin/diamond
	cmineral = "diamond"
	icon_state = "coin_diamond_heads"
	materials = list(MAT_DIAMOND = 400)
	credits = 120

/obj/item/coin/iron
	cmineral = "iron"
	icon_state = "coin_iron_heads"
	materials = list(MAT_METAL = 400)
	credits = 20

/obj/item/coin/plasma
	cmineral = "plasma"
	desc = "You really shouldn't keep this in the same pocket as a lighter."
	icon_state = "coin_plasma_heads"
	materials = list(MAT_PLASMA = 400)
	credits = 80

/obj/item/coin/plasma/bullet_act(obj/item/projectile/P)
	if(!QDELETED(src) && !P.nodamage && (P.damage_type == BURN))
		log_and_set_aflame(P.firer, P)

/obj/item/coin/plasma/attackby__legacy__attackchain(obj/item/I, mob/living/user, params)
	if(!I.get_heat())
		return ..()
	log_and_set_aflame(user, I)

/obj/item/coin/plasma/proc/log_and_set_aflame(mob/user, obj/item/I)
	var/turf/T = get_turf(src)
	message_admins("Plasma coin ignited by [key_name_admin(user)]([ADMIN_QUE(user, "?")]) ([ADMIN_FLW(user, "FLW")]) in ([COORD(T)] - [ADMIN_JMP(T)]")
	log_game("Plasma coin ignited by [key_name(user)] in [COORD(T)]")
	investigate_log("was <font color='red'><b>ignited</b></font> by [key_name(user)]", INVESTIGATE_ATMOS)
	user.create_log(MISC_LOG, "Plasma coin ignited using [I]", src)
	fire_act()

/obj/item/coin/plasma/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume, global_overlay = TRUE)
	..()
	atmos_spawn_air(LINDA_SPAWN_HEAT | LINDA_SPAWN_TOXINS, 5) // 2 is the "correct" ammount, but its super lame. Im sure this wont have ramifications on the plasma market.
	qdel(src)

/obj/item/coin/uranium
	cmineral = "uranium"
	desc = "You probably shouldn't keep this in your front pocket."
	icon_state = "coin_uranium_heads"
	materials = list(MAT_URANIUM = 400)
	credits = 160

/obj/item/coin/uranium/Initialize(mapload)
	. = ..()
	var/datum/component/inherent_radioactivity/radioactivity = AddComponent(/datum/component/inherent_radioactivity, 50, 0, 0, 1.5)
	START_PROCESSING(SSradiation, radioactivity)

/obj/item/coin/clown
	cmineral = "bananium"
	icon_state = "coin_bananium_heads"
	materials = list(MAT_BANANIUM = 400)
	credits = 600 //makes the clown cri

/obj/item/coin/clown/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, src, 4 SECONDS, 100, 0, FALSE)

/obj/item/coin/mime
	cmineral = "tranquillite"
	icon_state = "coin_tranquillite_heads"
	materials = list(MAT_TRANQUILLITE = 400)
	credits = 600 //makes the mime cri

/obj/item/coin/adamantine
	cmineral = "adamantine"
	icon_state = "coin_adamantine_heads"
	credits = 400

/obj/item/coin/mythril
	cmineral = "mythril"
	icon_state = "coin_mythril_heads"
	credits = 400

/obj/item/coin/twoheaded
	cmineral = "iron"
	icon_state = "coin_iron_heads"
	desc = "Hey, this coin's the same on both sides!"
	sideslist = list("heads")
	credits = 20

/obj/item/coin/antagtoken
	name = "antag token"
	icon_state = "coin_valid_valid"
	cmineral = "valid"
	desc = "A novelty coin that helps the heart know what hard evidence cannot prove."
	sideslist = list("valid", "salad")
	credits = 20
	name_by_cmineral = FALSE

/obj/item/coin/antagtoken/syndicate
	name = "syndicate coin"
	credits = 160

/obj/item/coin/attackby__legacy__attackchain(obj/item/W as obj, mob/user as mob, params)
	if(istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/CC = W
		if(string_attached)
			to_chat(user, "<span class='notice'>There already is a string attached to this coin.</span>")
			return

		if(CC.use(1))
			overlays += image('icons/obj/economy.dmi',"coin_string_overlay")
			string_attached = 1
			to_chat(user, "<span class='notice'>You attach a string to the coin.</span>")
		else
			to_chat(user, "<span class='warning'>You need one length of cable to attach a string to the coin.</span>")
			return

	else if(istype(W,/obj/item/wirecutters))
		if(!string_attached)
			..()
			return

		var/obj/item/stack/cable_coil/CC = new/obj/item/stack/cable_coil(user.loc)
		CC.amount = 1
		CC.update_icon()
		overlays = list()
		string_attached = null
		to_chat(user, "<span class='notice'>You detach the string from the coin.</span>")
	else ..()

/obj/item/coin/wirecutter_act(mob/user, obj/item/I)
	if(string_attached)
		return
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = I.tool_volume))
		return
	var/typelist = list("iron" = /obj/item/clothing/gloves/ring,
						"silver" = /obj/item/clothing/gloves/ring/silver,
						"gold" = /obj/item/clothing/gloves/ring/gold,
						"plasma" = /obj/item/clothing/gloves/ring/plasma,
						"uranium" = /obj/item/clothing/gloves/ring/uranium)
	var/typekey = typelist[cmineral]
	if(ispath(typekey))
		to_chat(user, "<span class='notice'>You carefully cut a hole into [src] turning it into a ring.</span>")
		var/obj/item/clothing/gloves/ring/ring = new typekey()
		qdel(src)
		user.put_in_hands(ring)


/obj/item/coin/attack_self__legacy__attackchain(mob/user as mob)
	if(cooldown < world.time - 15)
		var/coinflip = pick(sideslist)
		cooldown = world.time
		flick("coin_[cmineral]_flip", src)
		icon_state = "coin_[cmineral]_[coinflip]"
		var/blind_sound
		if(cmineral != "tranquillite")
			playsound(user.loc, 'sound/items/coinflip.ogg', 50, TRUE)
			blind_sound = "<span class='notice'>You hear the clattering of loose change.</span>"
		if(do_after(user, 15, target = src))
			user.visible_message("<span class='notice'>[user] has flipped [src]. It lands on [coinflip].</span>", \
								"<span class='notice'>You flip [src]. It lands on [coinflip].</span>", \
								blind_sound)

#undef GIBTONITE_QUALITY_LOW
#undef GIBTONITE_QUALITY_MEDIUM
#undef GIBTONITE_QUALITY_HIGH
#undef PROBABILITY_REFINE_BY_FIRE
#undef ORESTACK_OVERLAYS_MAX
