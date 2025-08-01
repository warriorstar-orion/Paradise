/*********************Mining Hammer****************/
/obj/item/kinetic_crusher
	name = "proto-kinetic crusher"
	desc = "An early design of the proto-kinetic accelerator, it is little more than a combination of various mining tools cobbled together, forming a high-tech club. \
	While it is an effective mining tool, it did little to aid any but the most skilled and/or suicidal miners against local fauna."
	icon = 'icons/obj/mining.dmi'
	base_icon_state = "crusher"
	lefthand_file = 'icons/mob/inhands/weapons_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons_righthand.dmi'
	icon_state = "crusher"
	item_state = "crusher0"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 5
	throw_speed = 4
	armour_penetration_flat = 10
	materials = list(MAT_METAL = 1150, MAT_GLASS = 2075)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("smashed", "crushed", "cleaved", "chopped", "pulped")
	sharp = TRUE
	actions_types = list(/datum/action/item_action/toggle_light)
	var/list/trophies = list()
	var/charged = TRUE
	var/charge_time = 15
	var/detonation_damage = 50
	var/backstab_bonus = 30
	var/light_on = FALSE
	var/brightness_on = 5
	var/adaptive_damage_bonus = 0
	/// Amount of force typically assigned when wielded
	var/base_force_wielded = 20
	/// Tracker for the current amount of force used when the item is wielded.
	/// Note that this isn't wired to anything, and must be updated with AddComponent to have value.
	var/force_wielded = 20

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/parry, _stamina_constant = 2, _stamina_coefficient = 0.7, _parryable_attack_types = MELEE_ATTACK, _parry_cooldown = (10 / 3) SECONDS, _requires_two_hands = TRUE) // 2.3333 seconds of cooldown for 30% uptime
	AddComponent(/datum/component/two_handed, force_wielded = force_wielded, force_unwielded = force)

/obj/item/kinetic_crusher/Destroy()
	QDEL_LIST_CONTENTS(trophies)
	return ..()

/obj/item/kinetic_crusher/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Mark a large creature with the destabilizing force, then hit them in melee to do <b>[force + detonation_damage]</b> damage.</span>"
	. += "<span class='notice'>Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.</span>"
	if(length(trophies))
		. += "<span class='notice'>You can use a crowbar on it to remove its attached trophies.</span>"
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		. += "<span class='notice'>It has \a [T] attached, which causes [T.effect_desc()].</span>"

/obj/item/kinetic_crusher/attackby__legacy__attackchain(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = I
		T.add_to(src, user)
	else
		return ..()

/obj/item/kinetic_crusher/crowbar_act(mob/user, obj/item/I)
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = I.tool_volume))
		return
	if(LAZYLEN(trophies))
		to_chat(user, "<span class='notice'>You remove [src]'s trophies.</span>")
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.remove_from(src, user)
	else
		to_chat(user, "<span class='warning'>There are no trophies on [src].</span>")

/obj/item/kinetic_crusher/attack__legacy__attackchain(mob/living/target, mob/living/carbon/user)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		to_chat(user, "<span class='warning'>[src] is too heavy to use with one hand. You fumble and drop everything.</span>")
		user.drop_r_hand()
		user.drop_l_hand()
		return
	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	if(!C)
		C = target.apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	var/temp_force_bonus = 0
	var/datum/status_effect/adaptive_learning/A = target.has_status_effect(STATUS_EFFECT_ADAPTIVELEARNING)
	if(!A && adaptive_damage_bonus)
		A = target.apply_status_effect(STATUS_EFFECT_ADAPTIVELEARNING)
	if(A)
		temp_force_bonus = A.bonus_damage
		A.bonus_damage = min((A.bonus_damage + adaptive_damage_bonus), 20)
	force += temp_force_bonus
	..()
	force -= temp_force_bonus
	for(var/t in trophies)
		if(!QDELETED(target))
			var/obj/item/crusher_trophy/T = t
			T.on_melee_hit(target, user)
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/kinetic_crusher/proc/get_turf_for_projectile(atom/user)
	if(ismob(user) && isturf(user.loc))
		return user.loc

/obj/item/kinetic_crusher/afterattack__legacy__attackchain(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return
	if(user.has_status_effect(STATUS_EFFECT_DASH) && user.a_intent == INTENT_HELP)
		if(user.throw_at(target, range = 3, speed = 3, spin = FALSE, diagonals_first = TRUE))
			playsound(src, 'sound/effects/stealthoff.ogg', 50, TRUE, 1)
			user.visible_message("<span class='warning'>[user] dashes!</span>")
		else
			to_chat(user, "<span class='warning'>Something prevents you from dashing!</span>")
		user.remove_status_effect(STATUS_EFFECT_DASH)
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = get_turf_for_projectile(user)
		if(!isturf(proj_turf))
			return
		var/obj/item/projectile/destabilizer/D = new /obj/item/projectile/destabilizer(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		var/modifiers = params2list(clickparams)
		D.preparePixelProjectile(target, user, modifiers)
		D.firer = user
		D.firer_source_atom = src
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, 1)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, PROC_REF(Recharge)), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		if(!C)
			C = L.apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = BOMB)
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, 1) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

/obj/item/kinetic_crusher/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_icon()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, 1)

/obj/item/kinetic_crusher/ui_action_click(mob/user, actiontype)
	light_on = !light_on
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_brightness(user)
	update_icon()

/obj/item/kinetic_crusher/proc/update_brightness(mob/user = null)
	if(light_on)
		set_light(brightness_on)
	else
		set_light(0)

/obj/item/kinetic_crusher/update_icon_state()
	item_state = "crusher[HAS_TRAIT(src, TRAIT_WIELDED)]"

/obj/item/kinetic_crusher/update_overlays()
	. = ..()
	if(!charged)
		. += "[icon_state]_uncharged"
	if(light_on)
		. += "[icon_state]_lit"
	update_action_buttons()

//destablizing force
/obj/item/projectile/destabilizer
	name = "destabilizing force"
	icon_state = "pulse1"
	nodamage = TRUE
	damage = 0 //We're just here to mark people. This is still a melee weapon.
	flag = BOMB
	range = 6
	log_override = TRUE
	var/obj/item/kinetic_crusher/hammer_synced

/obj/item/projectile/destabilizer/Destroy()
	hammer_synced = null
	return ..()

/obj/item/projectile/destabilizer/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		var/had_effect = (L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)) //used as a boolean
		var/datum/status_effect/crusher_mark/CM = L.apply_status_effect(STATUS_EFFECT_CRUSHERMARK, hammer_synced)
		if(hammer_synced)
			for(var/t in hammer_synced.trophies)
				var/obj/item/crusher_trophy/T = t
				T.on_mark_application(target, CM, had_effect)
	var/target_turf = get_turf(target)
	if(ismineralturf(target_turf))
		if(is_ancient_rock(target_turf))
			visible_message("<span class='notice'>This rock appears to be resistant to all mining tools except pickaxes!</span>")
		else
			var/turf/simulated/mineral/M = target_turf
			new /obj/effect/temp_visual/kinetic_blast(M)
			M.gets_drilled(firer)
	..()

//trophies
/obj/item/crusher_trophy
	name = "tail spike"
	desc = "A strange spike with no usage."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "tail_spike"
	var/bonus_value = 10 //if it has a bonus effect, this is how much that effect is
	var/denied_type = /obj/item/crusher_trophy

/obj/item/crusher_trophy/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Causes [effect_desc()] when attached to a kinetic crusher.</span>"

/obj/item/crusher_trophy/proc/effect_desc()
	return "errors"

/obj/item/crusher_trophy/attackby__legacy__attackchain(obj/item/A, mob/living/user)
	if(istype(A, /obj/item/kinetic_crusher))
		add_to(A, user)
	else
		..()

/obj/item/crusher_trophy/proc/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	for(var/t in H.trophies)
		var/obj/item/crusher_trophy/T = t
		if(istype(T, denied_type) || istype(src, T.denied_type))
			to_chat(user, "<span class='warning'>You can't seem to attach [src] to [H]. Maybe remove a few trophies?</span>")
			return FALSE
	if(!user.unequip(src))
		return
	forceMove(H)
	H.trophies += src
	to_chat(user, "<span class='notice'>You attach [src] to [H].</span>")
	return TRUE

/obj/item/crusher_trophy/proc/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	forceMove(get_turf(H))
	H.trophies -= src
	return TRUE

/obj/item/crusher_trophy/Destroy()
	if(istype(loc, /obj/item/kinetic_crusher))
		var/obj/item/kinetic_crusher/crusher = loc
		crusher.trophies -= src
	return ..()

/obj/item/crusher_trophy/proc/on_melee_hit(mob/living/target, mob/living/user) //the target and the user
	return

/obj/item/crusher_trophy/proc/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user) //the projectile fired and the user
	return

/obj/item/crusher_trophy/proc/on_mark_application(mob/living/target, datum/status_effect/crusher_mark/mark, had_mark) //the target, the mark applied, and if the target had a mark before
	return

/obj/item/crusher_trophy/proc/on_mark_detonation(mob/living/target, mob/living/user) //the target and the user
	return

//goliath
/obj/item/crusher_trophy/goliath_tentacle
	name = "goliath tentacle"
	desc = "A sliced-off goliath tentacle. Suitable as a trophy for a kinetic crusher."
	icon_state = "goliath_tentacle"
	denied_type = /obj/item/crusher_trophy/goliath_tentacle
	bonus_value = 2
	var/missing_health_ratio = 0.1
	var/missing_health_desc = 10

/obj/item/crusher_trophy/goliath_tentacle/effect_desc()
	return "mark detonation to do <b>[bonus_value]</b> more damage for every <b>[missing_health_desc]</b> health you are missing"

/obj/item/crusher_trophy/goliath_tentacle/on_mark_detonation(mob/living/target, mob/living/user)
	var/missing_health = user.health - user.maxHealth
	missing_health *= missing_health_ratio //bonus is active at all times, even if you're above 90 health
	missing_health *= bonus_value //multiply the remaining amount by bonus_value
	if(missing_health > 0)
		target.adjustBruteLoss(missing_health) //and do that much damage


/obj/item/crusher_trophy/goliath_tentacle/ancient
	name = "ancient goliath tentacle"
	desc = "A HUGE sliced-off goliath tentacle. Suitable as a trophy for a kinetic crusher."
	icon_state = "ancient_goliath_tentacle"
	bonus_value = 4

//watcher
/obj/item/crusher_trophy/watcher_wing
	name = "watcher wing"
	desc = "A wing ripped from a watcher. Suitable as a trophy for a kinetic crusher."
	icon_state = "watcher_wing"
	denied_type = /obj/item/crusher_trophy/watcher_wing
	bonus_value = 5

/obj/item/crusher_trophy/watcher_wing/effect_desc()
	return "mark detonation to prevent certain creatures from using certain attacks for <b>[bonus_value*0.1]</b> second\s"

/obj/item/crusher_trophy/watcher_wing/on_mark_detonation(mob/living/target, mob/living/user)
	if(ishostile(target))
		var/mob/living/simple_animal/hostile/H = target
		if(H.ranged) //briefly delay ranged attacks
			if(H.ranged_cooldown >= world.time)
				H.ranged_cooldown += bonus_value
			else
				H.ranged_cooldown = bonus_value + world.time

//magmawing watcher
/obj/item/crusher_trophy/blaster_tubes/magma_wing
	name = "magmawing watcher wing"
	desc = "A still-searing wing from a magmawing watcher. Suitable as a trophy for a kinetic crusher."
	icon_state = "magma_wing"
	gender = NEUTER
	bonus_value = 5

/obj/item/crusher_trophy/blaster_tubes/magma_wing/effect_desc()
	return "mark detonation to make the next destabilizer shot deal <b>[bonus_value]</b> damage"

/obj/item/crusher_trophy/blaster_tubes/magma_wing/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user)
	if(deadly_shot)
		marker.name = "heated [marker.name]"
		marker.icon_state = "lava"
		marker.damage = bonus_value
		marker.nodamage = FALSE
		deadly_shot = FALSE

//icewing watcher
/obj/item/crusher_trophy/watcher_wing/ice_wing
	name = "icewing watcher wing"
	desc = "A carefully preserved frozen wing from an icewing watcher. Suitable as a trophy for a kinetic crusher."
	icon_state = "ice_wing"
	bonus_value = 8

//legion
/obj/item/crusher_trophy/legion_skull
	name = "legion skull"
	desc = "A dead and lifeless legion skull. Suitable as a trophy for a kinetic crusher."
	icon_state = "legion_skull"
	denied_type = /obj/item/crusher_trophy/legion_skull
	bonus_value = 3

/obj/item/crusher_trophy/legion_skull/effect_desc()
	return "a kinetic crusher to recharge <b>[bonus_value*0.1]</b> second\s faster"

/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time -= bonus_value

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time += bonus_value

//blood-drunk hunter
/obj/item/crusher_trophy/miner_eye
	name = "eye of a blood-drunk hunter"
	desc = "Its pupil is collapsed and turned to mush. Suitable as a trophy for a kinetic crusher."
	icon_state = "hunter_eye"
	denied_type = /obj/item/crusher_trophy/miner_eye

/obj/item/crusher_trophy/miner_eye/effect_desc()
	return "mark detonation to grant stun immunity and <b>75%</b> damage reduction for <b>1</b> second"

/obj/item/crusher_trophy/miner_eye/on_mark_detonation(mob/living/target, mob/living/user)
	user.apply_status_effect(STATUS_EFFECT_BLOODDRUNK)

//legion

/obj/item/crusher_trophy/empowered_legion_skull
	name = "empowered legion skull"
	desc = "A powerful looking skull with glowing red eyes."
	icon_state = "ashen_skull"
	denied_type = /obj/item/crusher_trophy/empowered_legion_skull

/obj/item/crusher_trophy/empowered_legion_skull/effect_desc()
	return "mark detonation grants the ability to dash a short distance on help intent"

/obj/item/crusher_trophy/empowered_legion_skull/on_mark_detonation(mob/living/target, mob/living/user)
	user.apply_status_effect(STATUS_EFFECT_DASH)

//ash drake
/obj/item/crusher_trophy/tail_spike
	desc = "A spike taken from an ash drake's tail. Suitable as a trophy for a kinetic crusher."
	denied_type = /obj/item/crusher_trophy/tail_spike
	bonus_value = 5

/obj/item/crusher_trophy/tail_spike/effect_desc()
	return "mark detonation to do <b>[bonus_value]</b> damage to nearby creatures and push them back"

/obj/item/crusher_trophy/tail_spike/on_mark_detonation(mob/living/target, mob/living/user)
	for(var/mob/living/L in oview(2, user))
		if(L.stat == DEAD)
			continue
		playsound(L, 'sound/magic/fireball.ogg', 20, 1)
		new /obj/effect/temp_visual/fire(L.loc)
		addtimer(CALLBACK(src, PROC_REF(pushback), L, user), 1) //no free backstabs, we push AFTER module stuff is done
		L.adjustFireLoss(bonus_value)

/obj/item/crusher_trophy/tail_spike/proc/pushback(mob/living/target, mob/living/user)
	if(!QDELETED(target) && !QDELETED(user) && (!target.anchored || ismegafauna(target))) //megafauna will always be pushed
		step(target, get_dir(user, target))

//bubblegum
/obj/item/crusher_trophy/demon_claws
	name = "demon claws"
	desc = "A set of blood-drenched claws from a massive demon's hand. Suitable as a trophy for a kinetic crusher."
	icon_state = "demon_claws"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/demon_claws
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)

/obj/item/crusher_trophy/demon_claws/effect_desc()
	return "melee hits to do <b>[bonus_value * 0.2]</b> more damage and heal you for <b>[bonus_value * 0.1]</b>, with <b>5X</b> effect on mark detonation"

/obj/item/crusher_trophy/demon_claws/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.force += bonus_value * 0.2
		H.force_wielded += bonus_value * 0.2
		// don't update force since KCs have 0 force by default
		H.AddComponent(/datum/component/two_handed, force_wielded = H.force_wielded, force_unwielded = H.force)
		H.detonation_damage += bonus_value * 0.8

/obj/item/crusher_trophy/demon_claws/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.force -= bonus_value * 0.2
		H.force_wielded -= bonus_value * 0.2
		H.AddComponent(/datum/component/two_handed, force_wielded = H.force_wielded, force_unwielded = H.force)
		H.detonation_damage -= bonus_value * 0.8

/obj/item/crusher_trophy/demon_claws/on_melee_hit(mob/living/target, mob/living/user)
	user.heal_ordered_damage(bonus_value * 0.1, damage_heal_order)

/obj/item/crusher_trophy/demon_claws/on_mark_detonation(mob/living/target, mob/living/user)
	user.heal_ordered_damage(bonus_value * 0.4, damage_heal_order)

//colossus
/obj/item/crusher_trophy/blaster_tubes
	name = "blaster tubes"
	desc = "The blaster tubes from a colossus's arm. Suitable as a trophy for a kinetic crusher."
	icon_state = "blaster_tubes"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/blaster_tubes
	bonus_value = 15
	var/deadly_shot = FALSE

/obj/item/crusher_trophy/blaster_tubes/effect_desc()
	return "mark detonation to make the next destabilizer shot deal <b>[bonus_value]</b> damage but move slower"

/obj/item/crusher_trophy/blaster_tubes/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user)
	if(deadly_shot)
		marker.name = "deadly [marker.name]"
		marker.icon_state = "chronobolt"
		marker.damage = bonus_value
		marker.nodamage = FALSE
		marker.speed = 2
		deadly_shot = FALSE

/obj/item/crusher_trophy/blaster_tubes/on_mark_detonation(mob/living/target, mob/living/user)
	deadly_shot = TRUE
	addtimer(CALLBACK(src, PROC_REF(reset_deadly_shot)), 300, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/item/crusher_trophy/blaster_tubes/proc/reset_deadly_shot()
	deadly_shot = FALSE

//hierophant
/obj/item/crusher_trophy/vortex_talisman
	name = "vortex talisman"
	desc = "A glowing trinket that was originally the Hierophant's beacon. Suitable as a trophy for a kinetic crusher."
	icon_state = "vortex_talisman"
	denied_type = /obj/item/crusher_trophy/vortex_talisman

/obj/item/crusher_trophy/vortex_talisman/effect_desc()
	return "mark detonation to create a homing hierophant chaser"

/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/effect/temp_visual/hierophant/chaser/chaser = new(get_turf(user), user, target, 3, TRUE)
	chaser.monster_damage_boost = FALSE // Weaker due to no cooldown
	chaser.damage = 20 //But also stronger due to AI / mining mob resistance

/obj/item/crusher_trophy/adaptive_intelligence_core
	name = "adaptive intelligence core"
	desc = "Seems to be one of the cores from a massive robot. Suitable as a trophy for a kinetic crusher."
	icon_state = "adaptive_core"
	denied_type = /obj/item/crusher_trophy/adaptive_intelligence_core
	bonus_value = 2

/obj/item/crusher_trophy/adaptive_intelligence_core/effect_desc()
	return "melee hits deal <b>[bonus_value]</b> more damage per hit after hitting a target, up to <b>[bonus_value * 10]</b> extra damage to that target"

/obj/item/crusher_trophy/adaptive_intelligence_core/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.adaptive_damage_bonus += bonus_value

/obj/item/crusher_trophy/adaptive_intelligence_core/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.adaptive_damage_bonus -= bonus_value
