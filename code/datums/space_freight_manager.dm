GLOBAL_DATUM_INIT(space_freight_manager, /datum/space_freight_manager, new)

/datum/space_freight_manager
	var/list/freight_landmarks = list()
	var/list/known_freights = list()

	var/list/spawn_weights = list(
		/datum/space_freight/food = 8,
		/datum/space_freight/gas = 5,
		/datum/space_freight/livestock = 5,
		/datum/space_freight/ore = 5,
		/datum/space_freight/biomedical = 2,
		/datum/space_freight/robotics = 2,
		/datum/space_freight/emergency = 2,
		/datum/space_freight/luxury_goods = 1,
		/datum/space_freight/weapons = 1,
	)

/datum/space_freight_manager/proc/generate_freights()
	var/list/landmarks = freight_landmarks.Copy()
	while(length(landmarks))
		var/obj/effect/landmark/freight_spawn/landmark = landmarks[landmarks.len]
		var/turf/T = get_turf(landmark)
		if(prob(landmark.spawn_chance))
			var/space_freight_type = pickweight(spawn_weights)
			known_freights.Add(new space_freight_type(T))
		else
			new /obj/structure/largecrate(T)
		landmarks.len--

/datum/space_freight_manager/proc/calculate_price(datum/space_freight/freight)
	. = freight.original_price
	for(var/datum/event/economic_event/event in SSevents.active_events_of_type(/datum/event/economic_event))
		var/datum/trade_destination/topic = event.news_story.topic
		if(istype(topic) && GLOB.trade_destinations[freight.destination] == topic)
			if(freight.trade_good_category in event.news_story.cheaper_goods)
				. *= rand(freight.sale_modifiers[1], freight.sale_modifiers[2])
			else if(freight.trade_good_category in event.news_story.pricier_goods)
				. *= rand(freight.hike_modifiers[1], freight.hike_modifiers[2])
