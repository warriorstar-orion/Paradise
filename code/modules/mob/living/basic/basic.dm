///Simple animals 2.0, This time, let's really try to keep it simple. This basetype should purely be used as a base-level for implementing simplified behaviours for things such as damage and attacks. Everything else should be in components or AI behaviours.
/mob/living/basic
	name = "basic mob"
	icon = 'icons/mob/animal.dmi'
	health = 20
	maxHealth = 20
	gender = PLURAL
	living_flags = MOVES_ON_ITS_OWN
	status_flags = CANPUSH

	var/basic_mob_flags = NONE

	///Defines how fast the basic mob can move. This is not a multiplier
	var/speed = 1
	///How much stamina the mob recovers per second
	var/stamina_recovery = 5

	///How much armour they ignore, as a flat reduction from the targets armour value.
	var/armour_penetration = 0
	///How much wounding power it has
	//var/wound_bonus = CANT_WOUND
	///How much bare wounding power it has
	var/bare_wound_bonus = 0
	///If the attacks from this are sharp
	var/sharpness = NONE

	/// Override for the visual attack effect shown on 'do_attack_animation()'.
	var/attack_vis_effect
	///Played when someone punches the creature.
	var/attacked_sound = "punch" //This should be an element
	/// How often can you melee attack?
	var/melee_attack_cooldown = 2 SECONDS

	/// Variable maintained for compatibility with attack_animal procs until simple animals can be refactored away. Use element instead of setting manually.
	var/environment_smash = ENVIRONMENT_SMASH_STRUCTURES

	///When someone interacts with the simple animal.
	///Help-intent verb in present continuous tense.
	var/response_help_continuous = "pokes"
	///Help-intent verb in present simple tense.
	var/response_help_simple = "poke"
	///Disarm-intent verb in present continuous tense.
	var/response_disarm_continuous = "shoves"
	///Disarm-intent verb in present simple tense.
	var/response_disarm_simple = "shove"
	///Harm-intent verb in present continuous tense.
	var/response_harm_continuous = "hits"
	///Harm-intent verb in present simple tense.
	var/response_harm_simple = "hit"

	////////THIS SECTION COULD BE ITS OWN ELEMENT
	///Icon to use
	var/icon_living = ""
	///Icon when the animal is dead. Don't use animated icons for this.
	var/icon_dead = ""
	///We only try to show a gibbing animation if this exists.
	var/icon_gib = null

	var/obj/item/petcollar/pcollar = null
	/// If the mob has collar sprites, define them.
	var/collar_type
	/// If the mob can be renamed
	var/unique_pet = FALSE
	/// Can add collar to mob or not, use the set_can_collar if you want to change this on runtime
	var/can_collar = FALSE

	///If the mob can be spawned with a gold slime core. HOSTILE_SPAWN are spawned with plasma, FRIENDLY_SPAWN are spawned with blood.
	var/gold_core_spawnable = NO_SPAWN
	///Sentience type, for slime potions. SHOULD BE AN ELEMENT BUT I DONT CARE ABOUT IT FOR NOW
	var/sentience_type = SENTIENCE_ORGANIC

	/// Atmos effect - Yes, you can make creatures that require plasma or co2 to survive. N2O is a trace gas and handled separately, hence why it isn't here. It'd be hard to add it. Hard and me don't mix (Yes, yes make all the dick jokes you want with that.) - Errorage
	var/list/atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0) //Leaving something at 0 means it's off - has no maximum
	/// This damage is taken when atmos doesn't fit all the requirements above
	var/unsuitable_atmos_damage = 2

	///Minimal body temperature without receiving damage
	var/minimum_survivable_temperature = NPC_DEFAULT_MIN_TEMP
	///Maximal body temperature without receiving damage
	var/maximum_survivable_temperature = NPC_DEFAULT_MAX_TEMP
	///This damage is taken when the body temp is too cold. Set both this and unsuitable_heat_damage to 0 to avoid adding the basic_body_temp_sensitive element.
	var/unsuitable_cold_damage = 1
	///This damage is taken when the body temp is too hot. Set both this and unsuitable_cold_damage to 0 to avoid adding the basic_body_temp_sensitive element.
	var/unsuitable_heat_damage = 1

	/// Old simple_animal behavior that needs to be componentized
	var/can_hide = FALSE
	/// Allows a mob to pass unbolted doors while hidden
	var/pass_door_while_hidden = FALSE
	/// What kind of footstep this mob should have. Null if it shouldn't have any.
	var/footstep_type
	/// Can this simple mob crawl or not? If FALSE, it won't get immobilized by crawling
	var/can_crawl = FALSE

	//Interaction
	var/harm_intent_damage = 3
	/// Minimum force required to deal any damage
	var/force_threshold = 0

/mob/living/basic/Initialize(mapload)
	. = ..()

	if(gender == PLURAL)
		gender = pick(MALE,FEMALE)

	if(!real_name)
		real_name = name

	if(!loc)
		stack_trace("Basic mob [type] being instantiated in nullspace")

	if(can_hide)
		var/datum/action/innate/hide/hide = new()
		hide.Grant(src)
	if(pcollar)
		pcollar = new(src)
		regenerate_icons()
	if(footstep_type)
		AddComponent(/datum/component/footstep, footstep_type)
	add_strippable_element()

	apply_atmos_requirements()
	apply_temperature_requirements()

/mob/living/basic/proc/apply_atmos_requirements()
	if(unsuitable_atmos_damage == 0)
		return

	atmos_requirements = string_assoc_list(atmos_requirements)
	AddElement(/datum/element/atmos_requirements, atmos_requirements, unsuitable_atmos_damage)

/// Ensures this mob can take temperature damage if it's supposed to
/mob/living/basic/proc/apply_temperature_requirements(mapload)
	if((unsuitable_cold_damage == 0 && unsuitable_heat_damage == 0) || (minimum_survivable_temperature <= 0 && maximum_survivable_temperature >= INFINITY))
		return
	AddElement(/datum/element/body_temperature, minimum_survivable_temperature, maximum_survivable_temperature, unsuitable_cold_damage, unsuitable_heat_damage, mapload)

/mob/living/basic/get_default_say_verb()
	return length(speak_emote) ? pick(speak_emote) : ..()

/mob/living/basic/death(gibbed)
	. = ..()
	if(basic_mob_flags & DEL_ON_DEATH)
		ghostize(can_reenter_corpse = FALSE)
		qdel(src)
	else
		health = 0

/mob/living/basic/gib()
	if(icon_gib)
		flick(icon_gib, src)
	if(butcher_results)
		var/atom/Tsec = drop_location()
		for(var/path in butcher_results)
			for(var/i in 1 to butcher_results[path])
				new path(Tsec)
	if(pcollar)
		pcollar.forceMove(drop_location())
		pcollar = null
	..()

/mob/living/basic/examine(mob/user)
	. = ..()
	if(stat != DEAD)
		return
	. += "<span class='deadsay'>Upon closer examination, [p_they()] appear[p_s()] to be dead.</span>"

/mob/living/basic/proc/melee_attack(atom/target, list/modifiers, ignore_cooldown = FALSE)
	face_atom(target)
	if (!ignore_cooldown)
		changeNext_move(melee_attack_cooldown)
	if(SEND_SIGNAL(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, target, Adjacent(target), modifiers) & COMPONENT_HOSTILE_NO_ATTACK)
		return FALSE //but more importantly return before attack_animal called
	var/result = target.attack_basic_mob(src, modifiers)
	SEND_SIGNAL(src, COMSIG_HOSTILE_POST_ATTACKINGTARGET, target, result)
	return result

/mob/living/basic/resolve_unarmed_attack(atom/attack_target, list/modifiers)
	melee_attack(attack_target, modifiers)

/mob/living/basic/relaymove(mob/living/user, direction)
	if(user.incapacitated())
		return
	return relaydrive(user, direction)

/mob/living/basic/get_status_tab_items()
	. = ..()
	. += "Health: [round((health / maxHealth) * 100)]%"


/mob/living/basic/compare_sentience_type(compare_type)
	return sentience_type == compare_type

/**
 * Apply the appearance and properties this mob has when it dies
 * This is called by the mob pretending to be dead too so don't put loot drops in here or something
 */
/mob/living/basic/proc/look_dead()
	icon_state = icon_dead
	if(basic_mob_flags & FLIP_ON_DEATH)
		transform = transform.Turn(180)
	if(!(basic_mob_flags & REMAIN_DENSE_WHILE_DEAD))
		// ADD_TRAIT(src, TRAIT_UNDENSE, BASIC_MOB_DEATH_TRAIT)
		density = FALSE
	// SEND_SIGNAL(src, COMSIG_BASICMOB_LOOK_DEAD)

/mob/living/basic/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	. = ..()
	if(!.)
		return

	density = initial(density)
	health = maxHealth
	icon = initial(icon)
	icon_state = icon_living
	density = initial(density)
	flying = initial(flying)
	if(collar_type)
		collar_type = "[initial(collar_type)]"
		regenerate_icons()

	look_alive()

/// Apply the appearance and properties this mob has when it is alive
/mob/living/basic/proc/look_alive()
	icon_state = icon_living
	if(basic_mob_flags & FLIP_ON_DEATH)
		transform = transform.Turn(180)
	if(!(basic_mob_flags & REMAIN_DENSE_WHILE_DEAD))
		// REMOVE_TRAIT(src, TRAIT_UNDENSE, BASIC_MOB_DEATH_TRAIT)
		density = TRUE
	// SEND_SIGNAL(src, COMSIG_BASICMOB_LOOK_ALIVE)

/mob/living/basic/movement_delay()
	. = speed
	if(forced_look)
		. += DIRECTION_LOCK_SLOWDOWN
	. += GLOB.configuration.movement.animal_delay

/mob/living/basic/proc/add_strippable_element()
	if(!can_collar)
		return
	AddElement(/datum/element/strippable, create_strippable_list(list(/datum/strippable_item/pet_collar)))

/mob/living/basic/proc/add_collar(obj/item/petcollar/P, mob/user)
	if(!istype(P) || QDELETED(P) || pcollar)
		return
	if(user && !user.unEquip(P))
		return
	P.forceMove(src)
	P.equipped(src)
	pcollar = P
	regenerate_icons()
	if(user)
		to_chat(user, "<span class='notice'>You put [P] around [src]'s neck.</span>")
	if(P.tagname && !unique_pet)
		name = P.tagname
		real_name = P.tagname

/mob/living/basic/proc/remove_collar(atom/new_loc, mob/user)
	if(!pcollar)
		return

	var/obj/old_collar = pcollar

	unEquip(pcollar)

	if(user)
		user.put_in_hands(old_collar)

	return old_collar

/mob/living/basic/regenerate_icons()
	cut_overlays()
	if(pcollar && collar_type)
		add_overlay("[collar_type]collar")
		add_overlay("[collar_type]tag")
