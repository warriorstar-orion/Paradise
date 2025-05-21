/// Makes our item SUPER spooky!
/// Adds the haunted element and some other bonuses
/datum/component/haunted_item
	/// Our throwforce before being haunted
	var/pre_haunt_throwforce
	/// Optional message displayed when we're despawned / dehaunted
	var/despawn_message
	/// List of types that, if they hit our item, we will instantly stop the haunting
	var/list/types_which_dispell_us

/datum/component/haunted_item/Initialize(
	// What color should the haunted item be glowing? By default the color's white (passed into the haunted element).
	haunt_color,
	// How long should the haunt last? If null, it will last forever / until removed.
	haunt_duration,
	// How far should the haunted item look for targets when it's created? If null, it won't aggro anyone by default.
	aggro_radius,
	// Optional, what message should the item show when the haunt happens (when the component is applied)?
	spawn_message,
	// Optional, what message should the item show when the haunt ends (clear_haunting is called)?
	despawn_message,
	// How much throwforce does the haunted item get? Keep in mind it attacks by throwing itself
	throw_force_bonus = 3,
	// What's the max amount of throwforce that we should consider going to
	throw_force_max = 15,
	// See the types_which_dispell_us list. By default / if null, this will become the default static list.
	list/types_which_dispell_us,
)

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	var/obj/item/haunted_item = parent
	if(istype(haunted_item.ai_controller, /datum/ai_controller/haunted)) // already spooky
		return COMPONENT_INCOMPATIBLE

	haunted_item.make_haunted(MAGIC_TRAIT, haunt_color)
	if(isnull(haunted_item.ai_controller)) // failed to make spooky! don't go on
		return COMPONENT_INCOMPATIBLE

	if(!isnull(haunt_duration))
		addtimer(CALLBACK(src, PROC_REF(clear_haunting)), haunt_duration)

	if(!isnull(spawn_message))
		haunted_item.visible_message(spawn_message)

	if(!isnull(aggro_radius))
		haunted_item.ai_controller.set_blackboard_key(BB_HAUNT_AGGRO_RADIUS, aggro_radius)

	if(haunted_item.throwforce < throw_force_max)
		pre_haunt_throwforce = haunted_item.throwforce
		haunted_item.throwforce = min(haunted_item.throwforce + throw_force_bonus, throw_force_max)

	var/static/list/default_dispell_types = list(/obj/item/nullrod, /obj/item/storage/bible)
	src.types_which_dispell_us = types_which_dispell_us || default_dispell_types
	src.despawn_message = despawn_message

/datum/component/haunted_item/Destroy(force)
	var/obj/item/haunted_item = parent
	// Handle these two specifically in Destroy() instead of clear_haunting(),
	// because we want to make sure they always get dealt with no matter how the component is removed
	if(!isnull(pre_haunt_throwforce))
		haunted_item.throwforce = pre_haunt_throwforce
	haunted_item.remove_haunted(MAGIC_TRAIT)
	return ..()

/datum/component/haunted_item/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATTACK_BY, PROC_REF(on_hit_by_holy_tool))

/datum/component/haunted_item/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATTACK_BY)

/// Removes the haunting, showing any despawn message we have and qdeling our component
/datum/component/haunted_item/proc/clear_haunting()
	var/obj/item/haunted_item = parent

	if(!isnull(despawn_message))
		haunted_item.visible_message(despawn_message)

	qdel(src)

/// Signal proc for [COMSIG_ATOM_ATTACKBY], when we get smacked by holy stuff we should stop being ghostly.
/datum/component/haunted_item/proc/on_hit_by_holy_tool(obj/item/source, obj/item/attacking_item, mob/living/attacker, params)
	SIGNAL_HANDLER

	if(!is_type_in_list(attacking_item, types_which_dispell_us))
		return

	attacker.visible_message(
		"<span class='warning'>[attacker] dispells the ghostly energy from [source]!</span>",
		"<span class='warning'>You dispel the ghostly energy from [source]!</span>")
	clear_haunting()
	return COMPONENT_SKIP_AFTERATTACK

/**
 * Takes a given area and chance, applying the haunted_item component to objects in the area.
 *
 * Takes an epicenter, and within the range around it, runs a haunt_chance percent chance of
 * applying the haunted_item component to nearby objects.
 *
 * * epicenter - The center of the outburst area.
 * * range - The range of the outburst, centered around the epicenter.
 * * haunt_chance - The percent chance that an object caught in the epicenter will be haunted.
 * * duration - How long the haunting will remain for.
 */
/proc/haunt_outburst(epicenter, range = 4, haunt_chance = 50, duration = 1 MINUTES)
	for(var/obj/item/nearby_item in range(range, epicenter))
		// Don't throw around anchored things or dense things
		// (Or things not on a turf but I am not sure if range can catch that)
		if(nearby_item.anchored || nearby_item.density || nearby_item.move_resist == INFINITY || !isturf(nearby_item.loc))
			continue
		// Don't throw abstract things
		if(nearby_item.flags & ABSTRACT)
			continue
		// Don't throw things we can't see
		if(nearby_item.invisibility > SEE_INVISIBLE_LIVING)
			continue

		if(!prob(haunt_chance))
			continue
		nearby_item.AddComponent(/datum/component/haunted_item, \
			haunt_color = "#52336e", \
			haunt_duration = duration, \
			aggro_radius = range, \
			spawn_message = "<span class='notice'>[nearby_item] rises into the air and begins to float!</span>", \
			despawn_message = "<span class='notice'>[nearby_item] falls back to the ground, stationary once more.</span>", \
		)
