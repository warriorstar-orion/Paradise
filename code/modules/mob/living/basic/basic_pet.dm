RESTRICT_TYPE(/mob/living/basic/pet)

// TODO: Actually add all this shit vvvvv

/// Basic mobs with the ability to be domesticated.
/// This includes adding a collar, following owners,
/// fetching, and other behavior.
/mob/living/basic/pet
	icon = 'icons/mob/pets.dmi'
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	blood_volume = BLOOD_VOLUME_NORMAL
	speed = 0 // same speed as a person.
	hud_type = /datum/hud/corgi

	// TODO: Collar/equipping support should be components
	// but is relegated to the /pet subtype for now

	/// The currently worn collar.
	var/obj/item/petcollar/pcollar = null
	/// If the mob has collar sprites, define them.
	var/collar_type
	/// If the mob can be renamed
	var/unique_pet = FALSE
	/// Can add collar to mob or not, use the set_can_collar if you want to change this on runtime
	var/can_collar = FALSE

/mob/living/basic/pet/Initialize(mapload)
	. = ..()
	if(pcollar)
		pcollar = new(src)
		regenerate_icons()

/mob/living/basic/pet/gib()
	. = ..()
	if(pcollar)
		pcollar.forceMove(drop_location())
		pcollar = null

/mob/living/basic/pet/attackby__legacy__attackchain(obj/item/O, mob/user, params)
	if(can_collar && istype(O, /obj/item/petcollar) && !pcollar)
		add_collar(O, user)
		return
	if(!istype(O, /obj/item/newspaper))
		return ..()
	var/obj/item/newspaper/paper = O
	if(stat != CONSCIOUS || !paper.rolled)
		return
	user.visible_message("<span class='notice'>[user] baps [name] on the nose with the rolled up [O].</span>")
	INVOKE_ASYNC(src, PROC_REF(spin), 7 DECISECONDS, 1)

/mob/living/basic/pet/revive(full_heal_flags, excess_healing, force_grab_ghost)
	. = ..()
	if(collar_type)
		collar_type = "[initial(collar_type)]"
		regenerate_icons()

/mob/living/basic/pet/proc/set_can_collar(new_value)
	can_collar = (new_value ? TRUE : FALSE)
	if(can_collar)
		add_strippable_element()
		return
	remove_collar(drop_location())
	RemoveElement(/datum/element/strippable)

/mob/living/basic/pet/proc/add_strippable_element()
	if(!can_collar)
		return
	AddElement(/datum/element/strippable, create_strippable_list(list(/datum/strippable_item/pet_collar)))

/mob/living/basic/pet/proc/add_collar(obj/item/petcollar/P, mob/user)
	if(!istype(P) || QDELETED(P) || pcollar)
		return
	if(user && !user.unequip(P))
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

/mob/living/basic/pet/proc/remove_collar(atom/new_loc, mob/user)
	if(!pcollar)
		return

	var/obj/old_collar = pcollar

	unequip(pcollar)

	if(user)
		user.put_in_hands(old_collar)

	return old_collar

/mob/living/basic/pet/update_overlays()
	. = ..()
	if(pcollar && collar_type)
		add_overlay("[collar_type]collar")
		add_overlay("[collar_type]tag")

///Proc to run on a successful taming attempt
/mob/living/basic/pet/proc/tamed(mob/living/tamer, atom/food)
	visible_message("<span class='notice'>[src] licks at [tamer] in a friendly manner!</span>")
