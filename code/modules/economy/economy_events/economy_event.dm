/datum/event/economic_event
	name = "Economic News"
	endWhen = 50			// this will be set randomly, later
	announceWhen = 15
	var/datum/event_news/economic/news_story

/datum/event/economic_event/start()
	var/topic_type = pickweight(GLOB.weighted_randomevent_locations)
	var/datum/trade_destination/topic = GLOB.trade_destinations[topic_type]

	if(length(topic.viable_random_events))
		endWhen = rand(60, 300)
		var/event_type = pick(topic.viable_random_events)

		if(!event_type)
			return

		news_story = new event_type(topic)

/datum/event/economic_event/announce()
	var/datum/feed_message/message = news_story.build_newscaster_message()

	GLOB.news_network.get_channel_by_name("Nyx Daily")?.add_message(message)
	for(var/nc in GLOB.allNewscasters)
		var/obj/machinery/newscaster/NC = nc
		NC.alert_news(message.title)
