/**
  * # Smart Fridge
  *
  * Stores items of a specified type.
  */
/obj/machinery/smartfridge
	name = "\improper SmartFridge"
	icon = 'icons/obj/vending.dmi'
	icon_state = "smartfridge"
	density = TRUE
	anchored = TRUE
	idle_power_consumption = 5
	active_power_consumption = 100
	face_while_pulling = TRUE
	/// The maximum number of items the fridge can hold. Multiplicated by the matter bin component's rating.
	var/max_n_of_items = 1500
	/// Associative list (/text => /number) tracking the amounts of a specific item held by the fridge.
	var/list/item_quants
	/// How long in ticks the fridge is electrified for. Decrements every process.
	var/seconds_electrified = 0
	/// Whether the fridge should randomly shoot held items at a nearby living target or not.
	var/shoot_inventory = FALSE
	/// Whether the fridge requires ID scanning. Used for the secure variant of the fridge.
	var/scan_id = TRUE
	/// Whether the fridge is considered secure. Used for wiring and display.
	var/is_secure = FALSE
	/// Whether the fridge can dry its' contents. Used for display.
	var/can_dry = FALSE
	/// Whether the fridge is currently drying. Used by [drying racks][/obj/machinery/smartfridge/drying_rack].
	var/drying = FALSE
	/// Whether the fridge's contents are visible on the world icon.
	var/visible_contents = TRUE
	/// Whether the fridge is electric and thus silicon controllable.
	var/silicon_controllable = TRUE
	/// The wires controlling the fridge.
	var/datum/wires/smartfridge/wires
	/// Typecache of accepted item types, init it in [/obj/machinery/smartfridge/Initialize].
	var/list/accepted_items_typecache
	/// Associative list (/obj/item => /number) representing the items the fridge should initially contain.
	var/list/starting_items
	/// The type of the circuitboard dropped on deconstruction. This is how to avoid getting subtypes into the board.
	var/board_type = /obj/machinery/smartfridge
	var/fill_level
	var/icon_addon
	var/icon_lightmask = "smartfridge"

	var/light_range_on = 1
	var/light_power_on = 0.5
	/// Do we drop contents on destroy?
	var/drop_contents_on_delete = TRUE

/obj/machinery/smartfridge/Initialize(mapload)
	. = ..()
	item_quants = list()
	// Reagents
	create_reagents()
	reagents.set_reacting(FALSE)
	// Components
	component_parts = list()

	var/obj/item/circuitboard/smartfridge/board = new(null)
	if(board_type)
		board.set_type(null, board_type)
	else
		board.set_type(null, type)
	component_parts += board
	component_parts += new /obj/item/stock_parts/matter_bin(null)
	RefreshParts()
	// Wires
	if(is_secure)
		wires = new/datum/wires/smartfridge/secure(src)
	else
		wires = new/datum/wires/smartfridge(src)
	//Add starting items
	if(starting_items)
		for(var/typekey in starting_items)
			var/amount = starting_items[typekey] || 1
			while(amount--)
				var/obj/item/I = new typekey(src)
				item_quants[I.name] += 1
	update_icon(UPDATE_OVERLAYS)
	// Accepted items
	accepted_items_typecache = typecacheof(list(
		/obj/item/food/grown,
		/obj/item/seeds,
		/obj/item/grown,
	))

/obj/machinery/smartfridge/RefreshParts()
	for(var/obj/item/stock_parts/matter_bin/B in component_parts)
		max_n_of_items = 1500 * B.rating

/obj/machinery/smartfridge/Destroy()
	SStgui.close_uis(wires)
	QDEL_NULL(wires)
	if(drop_contents_on_delete)
		for(var/atom/movable/A in contents)
			A.forceMove(loc)
	return ..()

/obj/machinery/smartfridge/process()
	if(stat & (BROKEN|NOPOWER))
		return
	if(seconds_electrified > 0)
		seconds_electrified--
	if(shoot_inventory && prob(2))
		throw_item()

/obj/machinery/smartfridge/power_change()
	. = ..()
	if(stat & (BROKEN|NOPOWER))
		set_light(0)
	else
		set_light(light_range_on, light_power_on)
	if(.)
		update_icon(UPDATE_OVERLAYS)

/obj/machinery/smartfridge/extinguish_light(force = FALSE)
	set_light(0)
	underlays.Cut()

/obj/machinery/smartfridge/update_overlays()
	. = ..()
	underlays.Cut()
	if(light)
		underlays += emissive_appearance(icon, "[icon_lightmask]_lightmask")
	if(panel_open)
		. += "[icon_state]_panel"
	if(stat & (BROKEN|NOPOWER))
		. += "[icon_state]_off"
		if(icon_addon)
			. += "[icon_addon]"
		if(stat & BROKEN)
			. += "[icon_state]_broken"
		return
	if(visible_contents)
		update_fridge_contents()
		if(fill_level)
			. += "[icon_state][fill_level]"
	if(icon_addon)
		. += "[icon_addon]"

/obj/machinery/smartfridge/proc/update_fridge_contents()
	switch(length(contents))
		if(0)
			fill_level = null
		if(1 to 25)
			fill_level = 1
		if(26 to 75)
			fill_level = 2
		if(76 to INFINITY)
			fill_level = 3

// Interactions
/obj/machinery/smartfridge/screwdriver_act(mob/living/user, obj/item/I)
	. = default_deconstruction_screwdriver(user, icon_state, icon_state, I)
	if(!.)
		return
	update_icon(UPDATE_OVERLAYS)

/obj/machinery/smartfridge/wrench_act(mob/living/user, obj/item/I)
	. = default_unfasten_wrench(user, I, time = 4 SECONDS)

/obj/machinery/smartfridge/crowbar_act(mob/living/user, obj/item/I)
	. = default_deconstruction_crowbar(user, I)

/obj/machinery/smartfridge/wirecutter_act(mob/living/user, obj/item/I)
	if(panel_open)
		attack_hand(user)
		return TRUE
	return ..()

/obj/machinery/smartfridge/multitool_act(mob/living/user, obj/item/I)
	if(panel_open)
		attack_hand(user)
		return TRUE
	return ..()

/obj/machinery/smartfridge/item_interaction(mob/living/user, obj/item/used, list/modifiers)
	if(istype(used, /obj/item/storage/part_replacer))
		. = ..()
		SStgui.update_uis(src)
		return

	if(istype(used, /obj/item/autochef_remote))
		return

	if(stat & (BROKEN|NOPOWER))
		to_chat(user, "<span class='notice'>[src] is unpowered and useless.</span>")
		return ITEM_INTERACT_COMPLETE

	if(load(used, user))
		user.visible_message(
			"<span class='notice'>[user] has added [used] to [src].</span>",
			"<span class='notice'>You add [used] to [src].</span>"
		)
		SStgui.update_uis(src)
		update_icon(UPDATE_OVERLAYS)
		return ITEM_INTERACT_COMPLETE

	if(istype(used, /obj/item/storage/bag) || istype(used, /obj/item/storage/box))
		var/obj/item/storage/P = used
		var/items_loaded = 0
		for(var/obj/G in P.contents)
			if(load(G, user))
				items_loaded++
		if(items_loaded)
			user.visible_message(
				"<span class='notice'>[user] loads [src] with [P].</span>",
				"<span class='notice'>You load [src] with [P].</span>"
			)
			SStgui.update_uis(src)
			update_icon(UPDATE_OVERLAYS)
		var/failed = length(P.contents)
		if(failed)
			to_chat(user, "<span class='notice'>[failed] item\s [failed == 1 ? "is" : "are"] refused.</span>")
		return ITEM_INTERACT_COMPLETE

	if(!istype(used, /obj/item/card/emag))
		to_chat(user, "<span class='notice'>\The [src] smartly refuses [used].</span>")
		return ITEM_INTERACT_COMPLETE

	return ..()

/obj/machinery/smartfridge/attack_ai(mob/user)
	if(!silicon_controllable)
		return FALSE
	return attack_hand(user)

/obj/machinery/smartfridge/attack_ghost(mob/user)
	return attack_hand(user)

/obj/machinery/smartfridge/attack_hand(mob/user)
	if(stat & (BROKEN|NOPOWER))
		return
	wires.Interact(user)
	ui_interact(user)
	return ..()

//Drag pill bottle to fridge to empty it into the fridge
/obj/machinery/smartfridge/MouseDrop_T(obj/over_object, mob/user)
	if(issilicon(user))
		return
	if(!istype(over_object, /obj/item/storage/pill_bottle)) //Only pill bottles, please
		return
	if(stat & (BROKEN|NOPOWER))
		to_chat(user, "<span class='notice'>\The [src] is unpowered and useless.</span>")
		return TRUE

	var/obj/item/storage/box/pillbottles/P = over_object
	if(!length(P.contents))
		to_chat(user, "<span class='notice'>\The [P] is empty.</span>")
		return TRUE

	var/items_loaded = 0
	for(var/obj/G in P.contents)
		if(load(G, user))
			items_loaded++
	if(items_loaded)
		user.visible_message("<span class='notice'>[user] empties \the [P] into \the [src].</span>", "<span class='notice'>You empty \the [P] into \the [src].</span>")
		update_icon(UPDATE_OVERLAYS)
	var/failed = length(P.contents)
	if(failed)
		to_chat(user, "<span class='notice'>[failed] item\s [failed == 1 ? "is" : "are"] refused.</span>")
	return TRUE

/obj/machinery/smartfridge/ui_state(mob/user)
	return GLOB.default_state

/obj/machinery/smartfridge/ui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Smartfridge", name)
		ui.open()

/obj/machinery/smartfridge/ui_data(mob/user)
	var/list/data = list()

	data["contents"] = null
	data["secure"] = is_secure
	data["can_dry"] = can_dry
	data["drying"] = drying

	var/list/items = list()
	for(var/i in 1 to length(item_quants))
		var/K = item_quants[i]
		var/count = item_quants[K]
		if(count > 0)
			items.Add(list(list("display_name" = capitalize(K), "vend" = i, "quantity" = count)))

	if(length(items))
		data["contents"] = items

	return data

/obj/machinery/smartfridge/ui_act(action, params)
	if(..())
		return

	. = TRUE

	var/mob/user = usr

	add_fingerprint(user)

	switch(action)
		if("vend")
			if(is_secure && !emagged && scan_id && !allowed(usr)) //secure fridge check
				to_chat(usr, "<span class='warning'>Access denied.</span>")
				return FALSE

			var/index = text2num(params["index"])
			var/amount = text2num(params["amount"])
			if(isnull(index) || !ISINDEXSAFE(item_quants, index) || !amount)
				return FALSE
			var/K = item_quants[index]
			var/count = item_quants[K]
			if(count == 0) // Sanity check, there are probably ways to press the button when it shouldn't be possible.
				return FALSE

			item_quants[K] = max(count - amount, 0)

			var/i = amount
			if(i == 1 && Adjacent(user) && !issilicon(user))
				for(var/obj/O in contents)
					if(O.name == K)
						if(!user.put_in_hands(O))
							O.forceMove(loc)
							adjust_item_drop_location(O)
						update_icon(UPDATE_OVERLAYS)
						break
			else
				for(var/obj/O in contents)
					if(O.name == K)
						O.forceMove(loc)
						adjust_item_drop_location(O)
						update_icon(UPDATE_OVERLAYS)
						i--
						if(i <= 0)
							return TRUE


/**
  * Tries to load an item if it is accepted by [/obj/machinery/smartfridge/proc/accept_check].
  *
  * Arguments:
  * * I - The item to load.
  * * user - The user trying to load the item.
  */
/obj/machinery/smartfridge/proc/load(obj/I, mob/user)
	if(accept_check(I))
		if(length(contents) >= max_n_of_items)
			to_chat(user, "<span class='notice'>\The [src] is full.</span>")
			return FALSE
		else
			if(isstorage(I.loc))
				var/obj/item/storage/S = I.loc
				if(!S.removal_allowed_check(user))
					return

				S.remove_from_storage(I, src)
			else if(ismob(I.loc))
				var/mob/M = I.loc
				if(M.get_active_hand() == I)
					if(M.transfer_item_to(I, src))
						// TODO: Use COMSIG_ATOM_ENTERED/EXITED to update item quantities
						// instead of having to fiddle with the values everywhere
						item_quants[I.name] += 1
						return TRUE
					else
						to_chat(user, "<span class='warning'>\The [I] is stuck to you!</span>")
						return FALSE
			else
				I.forceMove(src)

			item_quants[I.name] += 1
			return TRUE
	return FALSE

/**
  * Tries to shoot a random at a nearby living mob.
  */
/obj/machinery/smartfridge/proc/throw_item()
	var/obj/item/throw_item = null
	var/mob/living/target = locate() in view(7, src)
	if(!target)
		return FALSE

	for(var/O in item_quants)
		if(item_quants[O] <= 0) //Try to use a record that actually has something to dump.
			continue
		item_quants[O]--
		for(var/obj/I in contents)
			if(I.name == O)
				I.forceMove(loc)
				throw_item = I
				update_icon(UPDATE_OVERLAYS)
				break
	if(!throw_item)
		return FALSE

	INVOKE_ASYNC(throw_item, TYPE_PROC_REF(/atom/movable, throw_at), target, 16, 3, src)
	visible_message("<span class='warning'>[src] launches [throw_item.name] at [target.name]!</span>")
	return TRUE

/**
  * Returns whether the smart fridge can accept the given item.
  *
  * By default checks if the item is in [the typecache][/obj/machinery/smartfridge/var/accepted_items_typecache].
  * Arguments:
  * * O - The item to check.
  */
/obj/machinery/smartfridge/proc/accept_check(obj/item/O)
	return is_type_in_typecache(O, accepted_items_typecache)

/**
  * # Secure Fridge
  *
  * Secure variant of the [Smart Fridge][/obj/machinery/smartfridge].
  * Can be emagged and EMP'd to short the lock.
  */
/obj/machinery/smartfridge/secure
	is_secure = TRUE

/obj/machinery/smartfridge/secure/emag_act(mob/user)
	emagged = TRUE
	to_chat(user, "<span class='notice'>You short out the product lock on \the [src].</span>")
	return TRUE

/obj/machinery/smartfridge/secure/emp_act(severity)
	if(!emagged && prob(40 / severity))
		playsound(loc, 'sound/effects/sparks4.ogg', 60, TRUE)
		emagged = TRUE

/obj/machinery/smartfridge/food
	name = "\improper Food Storage"
	desc = "A fridge for storing and keeping your food cold."

/obj/machinery/smartfridge/food/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/kitchen,
		/obj/item/food,
		/obj/item/seeds,
		/obj/item/grown,
		/obj/item/reagent_containers/condiment))

// Syndicate Druglab Ruin
/obj/machinery/smartfridge/food/syndicate_druglab
	starting_items = list(
		/obj/item/food/boiledrice = 2,
		/obj/item/food/macncheese = 1,
		/obj/item/food/syndicake = 3,
		/obj/item/food/beans = 4,
		/obj/item/reagent_containers/glass/beaker/waterbottle/large = 7,
		/obj/item/reagent_containers/drinks/bottle/kahlua = 1,
		/obj/item/reagent_containers/drinks/bottle/orangejuice = 2)

///The Chefs smartfridge. This smartfridge will spawn with a random condiment, then 3 stacks of 3 plants (or fish meat) to give chef some extra starting variety, or new ideas on what to cook!
/obj/machinery/smartfridge/food/chef

/obj/machinery/smartfridge/food/chef/Initialize(mapload)
	starting_items = generate_starting_items()
	. = ..()

/obj/machinery/smartfridge/food/chef/proc/generate_starting_items()
	// These plants are blocked for being inedable, downright toxic, RND plants, botany plants, or wheat.
	var/list/static/forbidden_plants = list(
		/obj/item/food/grown/wheat,
		/obj/item/food/grown/meatwheat,
		/obj/item/food/grown/shell/gatfruit,
		/obj/item/food/grown/apple/poisoned,
		/obj/item/food/grown/cherry_bomb,
		/obj/item/food/grown/firelemon,
		/obj/item/food/grown/ambrosia/gaia,
		/obj/item/food/grown/mushroom/glowshroom,
		/obj/item/food/grown/mushroom/glowshroom/glowcap,
		/obj/item/food/grown/mushroom/glowshroom/shadowshroom,
		/obj/item/food/grown/cannabis, // I don't care about weed pizza, sorry.
		/obj/item/food/grown/cannabis/rainbow,
		/obj/item/food/grown/cannabis/death,
		/obj/item/food/grown/cannabis/white,
		/obj/item/food/grown/cannabis/ultimate,
		/obj/item/food/grown/tobacco,
		/obj/item/food/grown/pumpkin/blumpkin,
		/obj/item/food/grown/berries/poison,
		/obj/item/food/grown/berries/death,
		/obj/item/food/grown/berries/glow,
		/obj/item/food/grown/comfrey,
		/obj/item/food/grown/aloe,
		/obj/item/food/grown/kudzupod,
		/obj/item/food/grown/holymelon, // Lets not out vampires or cult by accident thanks
		/obj/item/food/grown/mushroom/reishi, // I would block out Amanita but it has 2 recipies, might be funny.
		/obj/item/food/grown/mushroom/angel,
		/obj/item/food/grown/random,
		/obj/item/food/grown/tea,
		/obj/item/food/grown/tea/astra,
		/obj/item/food/grown/coffee,
		/obj/item/food/grown/coffee/robusta,
		/obj/item/food/grown/grass,
		/obj/item/food/grown/grass/carpet,
		/obj/item/food/grown/harebell,
		/obj/item/food/grown/poppy,
		/obj/item/food/grown/lily,
		/obj/item/food/grown/geranium,
		/obj/item/food/grown/moonflower,
		/obj/item/food/grown/ash_flora/shavings,
		/obj/item/food/grown/ash_flora/mushroom_leaf,
		/obj/item/food/grown/ash_flora/mushroom_cap,
		/obj/item/food/grown/ash_flora/mushroom_stem,
		/obj/item/food/grown/ash_flora/cactus_fruit,
		/obj/item/food/grown/shell,
		/obj/item/food/grown/mushroom/fungus,
		/obj/item/food/grown/mushroom,
		/obj/item/food/grown/ash_flora,
	)
	var/list/output = list()
	for(var/I in 1 to 3)
		var/obj/item/food/chosen
		if(prob(95))
			chosen = pick(subtypesof(/obj/item/food/grown) - forbidden_plants)
		else // Fish / sushi stuff, or xenomeat rarely as a treat
			chosen = pick(/obj/item/food/catfishmeat, /obj/item/food/carpmeat, /obj/item/food/salmonmeat, /obj/item/food/shrimp, /obj/item/food/monstermeat/xenomeat)
		output[chosen] += 3
	// Adds 2 condiment bottles as bonus. No hotsauce or ketchup, as the chef starts with that
	for(var/G in 1 to 2)
		output += pick(
			/obj/item/reagent_containers/condiment/bbqsauce,
			/obj/item/reagent_containers/condiment/soysauce,
			/obj/item/reagent_containers/condiment/mayonnaise,
			/obj/item/reagent_containers/condiment/cherryjelly,
			/obj/item/reagent_containers/condiment/peanutbutter,
			/obj/item/reagent_containers/condiment/honey,
			/obj/item/reagent_containers/condiment/oliveoil,
			/obj/item/reagent_containers/condiment/frostoil,
			/obj/item/reagent_containers/condiment/wasabi,
			/obj/item/reagent_containers/condiment/vinegar,
		)
	return output

/**
  * # Seed Storage
  *
  * Seeds variant of the [Smart Fridge][/obj/machinery/smartfridge].
  * Formerly known as MegaSeed Servitor, but renamed to avoid confusion with the [vending machine][/obj/machinery/economy/vending/hydroseeds].
  */
/obj/machinery/smartfridge/seeds
	name = "\improper Seed Storage"
	desc = "When you need seeds fast!"
	icon_state = "seeds"
	board_type = /obj/machinery/smartfridge/seeds

/obj/machinery/smartfridge/seeds/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/seeds
	))

/**
  * # Food and Drink Cart
  *
  * Variant of the [Smart Fridge][/obj/machinery/smartfridge] that holds food and drinks in a mobile form
  */
/obj/machinery/smartfridge/foodcart
	name = "food and drink cart"
	desc = "A portable cart for hawking your food and drink wares around the station."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "foodcart"
	anchored = FALSE
	interact_offline = TRUE
	power_state = NO_POWER_USE
	visible_contents = FALSE
	face_while_pulling = FALSE
	silicon_controllable = FALSE


/obj/machinery/smartfridge/foodcart/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/food,
		/obj/item/reagent_containers/drinks,
		/obj/item/reagent_containers/condiment,
	))

/obj/machinery/smartfridge/foodcart/screwdriver_act(mob/living/user, obj/item/I)
	return

/obj/machinery/smartfridge/foodcart/crowbar_act(mob/living/user, obj/item/I)
	return

/obj/machinery/smartfridge/foodcart/exchange_parts()
	return

/obj/machinery/smartfridge/foodcart/deconstruct(disassembled = TRUE)
	if(!(flags & NODECONSTRUCT))
		new /obj/item/stack/sheet/metal(loc, 4)
	qdel(src)

/**
  * # Circuit Boards Storage
  *
  * Circuit variant of the [Smart Fridge][/obj/machinery/smartfridge].
  *
  */
/obj/machinery/smartfridge/secure/circuits
	name = "\improper Circuit Board Storage"
	desc = "A storage unit for circuits."
	icon_state = "circuits"
	icon_lightmask = "circuits"
	board_type = /obj/machinery/smartfridge/secure/circuits

/obj/machinery/smartfridge/secure/circuits/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/ai_module,
		/obj/item/circuitboard
	))

/obj/machinery/smartfridge/secure/circuits/update_fridge_contents()
	switch(length(contents))
		if(0)
			fill_level = null
		if(1 to 2)
			fill_level = 1
		if(3 to 5)
			fill_level = 2
		if(6 to INFINITY)
			fill_level = 3

/obj/machinery/smartfridge/secure/circuits/aiupload
	name = "\improper AI Laws Storage"
	desc = "A storage unit filled with circuits to be uploaded to an Artificial Intelligence."
	board_type = /obj/machinery/smartfridge/secure/circuits/aiupload

/obj/machinery/smartfridge/secure/circuits/aiupload/Initialize(mapload)
	. = ..()
	req_access = list(ACCESS_AI_UPLOAD)
	if(mapload && HAS_TRAIT(SSstation, STATION_TRAIT_UNIQUE_AI) && is_station_level(z))
		drop_contents_on_delete = FALSE
		return INITIALIZE_HINT_QDEL

/obj/machinery/smartfridge/secure/circuits/aiupload/experimental
	name = "\improper Experimental Laws Storage"
	starting_items = list(
		/obj/item/ai_module/cctv = 1,
		/obj/item/ai_module/hippocratic = 1,
		/obj/item/ai_module/maintain = 1,
		/obj/item/ai_module/paladin = 1,
		/obj/item/ai_module/peacekeeper = 1,
		/obj/item/ai_module/quarantine = 1,
		/obj/item/ai_module/robocop = 1
	)

/obj/machinery/smartfridge/secure/circuits/aiupload/experimental/Initialize(mapload)
	. = ..()
	req_access = list(ACCESS_RD)

/obj/machinery/smartfridge/secure/circuits/aiupload/highrisk
	name = "\improper High-Risk Laws Storage"
	starting_items = list(
		/obj/item/ai_module/freeform = 1,
		/obj/item/ai_module/freeformcore = 1,
		/obj/item/ai_module/nanotrasen_aggressive = 1,
		/obj/item/ai_module/one_crew_member = 1,
		/obj/item/ai_module/protect_station = 1,
		/obj/item/ai_module/purge = 1,
		/obj/item/ai_module/tyrant = 1
	)

/obj/machinery/smartfridge/secure/circuits/aiupload/highrisk/Initialize(mapload)
	. = ..()
	req_access = list(ACCESS_CAPTAIN)

/**
  * # Refrigerated Medicine Storage
  *
  * Medical variant of the [Smart Fridge][/obj/machinery/smartfridge].
  */
/obj/machinery/smartfridge/medbay
	name = "\improper Refrigerated Medicine Storage"
	desc = "A refrigerated storage unit for storing medicine and chemicals."
	board_type = /obj/machinery/smartfridge/medbay

/obj/machinery/smartfridge/medbay/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/reagent_containers/glass,
		/obj/item/reagent_containers/iv_bag,
		/obj/item/reagent_containers/applicator,
		/obj/item/storage/pill_bottle,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/patch,
		/obj/item/stack/medical
	))

/**
  * # Slime Extract Storage
  *
  * Secure, Xenobiology variant of the [Smart Fridge][/obj/machinery/smartfridge].
  */
/obj/machinery/smartfridge/secure/extract
	name = "\improper Slime Extract Storage"
	desc = "A refrigerated storage unit for slime extracts."
	board_type = /obj/machinery/smartfridge/secure/extract

/obj/machinery/smartfridge/secure/extract/Initialize(mapload)
	. = ..()
	req_access = list(ACCESS_RESEARCH)
	accepted_items_typecache = typecacheof(list(
		/obj/item/slime_extract
	))

/**
  * # Secure Refrigerated Medicine Storage
  *
  * Secure, Medical variant of the [Smart Fridge][/obj/machinery/smartfridge].
  */
/obj/machinery/smartfridge/secure/medbay
	name = "\improper Secure Refrigerated Medicine Storage"
	desc = "A refrigerated storage unit for storing medicine and chemicals."
	req_one_access = list(ACCESS_MEDICAL, ACCESS_CHEMISTRY)
	board_type = /obj/machinery/smartfridge/secure/medbay

/obj/machinery/smartfridge/secure/medbay/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/reagent_containers/glass,
		/obj/item/reagent_containers/iv_bag,
		/obj/item/reagent_containers/applicator,
		/obj/item/storage/pill_bottle,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/patch,
		/obj/item/stack/medical
	))

/**
  * # Smart Chemical Storage
  *
  * Secure, Chemistry variant of the [Smart Fridge][/obj/machinery/smartfridge].
  */
/obj/machinery/smartfridge/secure/chemistry
	name = "\improper Smart Chemical Storage"
	desc = "A refrigerated storage unit for medicine and chemical storage."
	board_type = /obj/machinery/smartfridge/secure/chemistry
	req_access = list(ACCESS_CHEMISTRY)

/obj/machinery/smartfridge/secure/chemistry/Initialize(mapload)
	. = ..()
	// Accepted items
	accepted_items_typecache = typecacheof(list(
		/obj/item/storage/pill_bottle,
		/obj/item/reagent_containers,
	))

/**
  * # Smart Chemical Storage (Preloaded)
  *
  * A [Smart Chemical Storage][/obj/machinery/smartfridge/secure/chemistry] but with some items already in.
  */
/obj/machinery/smartfridge/secure/chemistry/preloaded
	// I exist!

/obj/machinery/smartfridge/secure/chemistry/preloaded/Initialize(mapload)
	starting_items = list(
		/obj/item/reagent_containers/pill/epinephrine = 12,
		/obj/item/reagent_containers/pill/charcoal = 5,
		/obj/item/reagent_containers/glass/bottle/epinephrine = 1,
		/obj/item/reagent_containers/glass/bottle/charcoal = 1,
	)
	. = ..()

/**
  * # Smart Chemical Storage (Preloaded, Syndicate)
  *
  * A [Smart Chemical Storage (Preloaded)][/obj/machinery/smartfridge/secure/chemistry/preloaded] but with exclusive access to Syndicate.
  */
/obj/machinery/smartfridge/secure/chemistry/preloaded/syndicate
	req_access = list(ACCESS_SYNDICATE)

/**
  * # Disk Compartmentalizer
  *
  * Disk variant of the [Smart Fridge][/obj/machinery/smartfridge].
  */
/obj/machinery/smartfridge/disks
	name = "disk compartmentalizer"
	desc = "A machine capable of storing a variety of disks. Denoted by most as the DSU (disk storage unit)."
	icon_state = "disktoaster"
	icon_lightmask = "disktoaster"
	pass_flags = PASSTABLE
	board_type = /obj/machinery/smartfridge/disks

/obj/machinery/smartfridge/disks/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/disk
	))

/obj/machinery/smartfridge/disks/update_fridge_contents()
	switch(length(contents))
		if(0)
			fill_level = null
		if(1)
			fill_level = 1
		if(2)
			fill_level = 2
		if(3)
			fill_level = 3
		if(4 to INFINITY)
			fill_level = 4

/obj/machinery/smartfridge/id
	name = "identification card compartmentalizer"
	desc = "A machine capable of storing identification cards and PDAs. It's great for lost and terminated cards."
	icon_state = "idbox"
	icon_lightmask = TRUE
	pass_flags = PASSTABLE
	visible_contents = FALSE
	board_type = /obj/machinery/smartfridge/id

/obj/machinery/smartfridge/id/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/card/id,
		/obj/item/pda,
	))

/**
  * # Smart Virus Storage
  *
  * Secure, Virology variant of the [Smart Chemical Storage][/obj/machinery/smartfridge/secure/chemistry].
  *
  */
/obj/machinery/smartfridge/secure/chemistry/virology
	name = "\improper Smart Virus Storage"
	desc = "A refrigerated storage unit for volatile sample storage."
	board_type = /obj/machinery/smartfridge/secure/chemistry/virology
	icon_addon = "smartfridge_virology"
	req_access = list(ACCESS_VIROLOGY)

/obj/machinery/smartfridge/secure/chemistry/virology/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/glass/beaker,
	))

/**
  * # Smart Virus Storage (Preloaded)
  *
  * A [Smart Virus Storage][/obj/machinery/smartfridge/secure/chemistry/virology] but with some additional items.
  */
/obj/machinery/smartfridge/secure/chemistry/virology/preloaded
	// I exist!

/obj/machinery/smartfridge/secure/chemistry/virology/preloaded/Initialize(mapload)
	starting_items = list(
		/obj/item/reagent_containers/syringe/antiviral = 4,
		/obj/item/reagent_containers/glass/bottle/cold = 1,
		/obj/item/reagent_containers/glass/bottle/flu_virion = 1,
		/obj/item/reagent_containers/glass/bottle/mutagen = 1,
		/obj/item/reagent_containers/glass/bottle/plasma = 1,
		/obj/item/reagent_containers/glass/bottle/diphenhydramine = 1,
		/obj/item/storage/lockbox/vials = 2
	)
	. = ..()

/**
  * # Smart Virus Storage (Preloaded, Syndicate)
  *
  * A [Smart Virus Storage (Preloaded)][/obj/machinery/smartfridge/secure/chemistry/virology/preloaded] but with exclusive access to Syndicate.
  */
/obj/machinery/smartfridge/secure/chemistry/virology/preloaded/syndicate
	req_access = list(ACCESS_SYNDICATE)

/obj/machinery/smartfridge/secure/chemistry/virology/preloaded/syndicate/Initialize(mapload)
	starting_items = list(
		/obj/item/reagent_containers/syringe/antiviral = 4,
		/obj/item/reagent_containers/glass/bottle/cold = 1,
		/obj/item/reagent_containers/glass/bottle/flu_virion = 1,
		/obj/item/reagent_containers/glass/bottle/mutagen = 1,
		/obj/item/reagent_containers/glass/bottle/plasma = 1,
		/obj/item/reagent_containers/glass/bottle/reagent/synaptizine = 1,
		/obj/item/reagent_containers/glass/bottle/reagent/formaldehyde = 1
	)
	. = ..()

/**
  * # Drink Showcase
  *
  * Drink variant of the [Smart Fridge][/obj/machinery/smartfridge].
  */
/obj/machinery/smartfridge/drinks
	name = "\improper Drink Showcase"
	desc = "A refrigerated storage unit for tasty tasty alcohol."
	board_type = /obj/machinery/smartfridge/drinks

/obj/machinery/smartfridge/drinks/Initialize(mapload)
	. = ..()
	accepted_items_typecache = typecacheof(list(
		/obj/item/reagent_containers/glass,
		/obj/item/reagent_containers/drinks,
		/obj/item/reagent_containers/condiment,
	))

/**
  * # Drying Rack
  *
  * Variant of the [Smart Fridge][/obj/machinery/smartfridge] for drying stuff.
  * Doesn't have components.
  */
/obj/machinery/smartfridge/drying_rack
	name = "drying rack"
	desc = "A wooden contraption, used to dry plant products, food and leather."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "drying_rack"
	interact_offline = TRUE
	can_dry = TRUE
	visible_contents = FALSE
	light_range_on = null
	light_power_on = null
	silicon_controllable = FALSE


/obj/machinery/smartfridge/drying_rack/Initialize(mapload)
	. = ..()
	// Remove components, this is wood duh
	QDEL_LIST_CONTENTS(component_parts)
	component_parts = null
	// Accepted items
	accepted_items_typecache = typecacheof(list(
		/obj/item/food,
		/obj/item/stack/sheet/wetleather,
	))

/obj/machinery/smartfridge/drying_rack/on_deconstruction()
	new /obj/item/stack/sheet/wood(loc, 10)
	..()

/obj/machinery/smartfridge/drying_rack/RefreshParts()
	return

/obj/machinery/smartfridge/drying_rack/screwdriver_act(mob/living/user, obj/item/I)
	return

/obj/machinery/smartfridge/drying_rack/exchange_parts()
	return

/obj/machinery/smartfridge/drying_rack/spawn_frame()
	return

/obj/machinery/smartfridge/drying_rack/crowbar_act(mob/living/user, obj/item/I)
	. = default_deconstruction_crowbar(user, I, TRUE)

/obj/machinery/smartfridge/drying_rack/emp_act(severity)
	..()
	atmos_spawn_air(LINDA_SPAWN_HEAT)

/obj/machinery/smartfridge/drying_rack/ui_act(action, params)
	. = ..()

	switch(action)
		if("drying")
			drying = !drying
			update_icon(UPDATE_OVERLAYS)

/obj/machinery/smartfridge/drying_rack/update_overlays()
	if(drying)
		. += "drying_rack_drying"
	if(length(contents))
		. += "drying_rack_filled"

/obj/machinery/smartfridge/drying_rack/process()
	..()
	if(drying && rack_dry())//no need to update unless something got dried
		update_icon(UPDATE_OVERLAYS)

/obj/machinery/smartfridge/drying_rack/accept_check(obj/item/O)
	. = ..()
	// If it's a food, reject non driable ones
	if(istype(O, /obj/item/food))
		var/obj/item/food/S = O
		if(!S.dried_type)
			return FALSE

/**
  * Toggles the drying process.
  *
  * Arguments:
  * * forceoff - Whether to force turn off the drying rack.
  */
/obj/machinery/smartfridge/drying_rack/proc/toggle_drying(forceoff)
	if(drying || forceoff)
		drying = FALSE
	else
		drying = TRUE
	update_icon(UPDATE_OVERLAYS)

/**
  * Called in [/obj/machinery/smartfridge/drying_rack/process] to dry the contents.
  */
/obj/machinery/smartfridge/drying_rack/proc/rack_dry()
	for(var/obj/item/food/S in contents)
		if(S.dried_type == S.type)//if the dried type is the same as the object's type, don't bother creating a whole new item...
			S.color = "#ad7257"
			S.dry = TRUE
			item_quants[S.name]--
			S.forceMove(get_turf(src))
		else
			var/dried = S.dried_type
			new dried(loc)
			item_quants[S.name]--
			qdel(S)
			SStgui.update_uis(src)
		return TRUE
	for(var/obj/item/stack/sheet/wetleather/WL in contents)
		var/obj/item/stack/sheet/leather/L = new(loc)
		L.amount = WL.amount
		item_quants[WL.name]--
		qdel(WL)
		SStgui.update_uis(src)
		return TRUE
	return FALSE
