#define FREIGHT_ORDER_LOST 0

/datum/space_freight
	var/freight_uid
	var/freight_name
	var/freight_desc
	var/order_code
	var/order_state = FREIGHT_ORDER_LOST
	var/trade_good_category = TRADE_GOOD_DEFAULT
	var/original_price
	var/datum/trade_destination/origin
	var/datum/trade_destination/destination
	var/list/price_modifiers = list(100, 200)
	var/list/sale_modifiers = list(0.75, 0.8)
	var/list/hike_modifiers = list(1.05, 1.2)

/datum/space_freight/New(turf/source)
	var/obj/structure/freight/freight = new(source)
	freight.desc = "[freight.desc] [freight_desc]"
	freight.add_random_livery()
	freight.update_appearance(UPDATE_DESC)
	freight_uid = freight.UID()
	var/list/destinations = subtypesof(/datum/trade_destination)
	origin = pick_n_take(destinations)
	destination = pick_n_take(destinations)
	order_code = ""
	for(var/i in 1 to 20)
		order_code += "[rand(0, 9)]"
	freight.order_code = order_code
	original_price = rand(price_modifiers[1], price_modifiers[2])

/datum/space_freight/ui_data(mob/user)
	. = list()

	.["freight_uid"] = freight_uid
	.["freight_name"] = freight_name
	.["order_code"] = order_code
	.["order_state"] = order_state
	.["original_price"] = original_price
	var/datum/trade_origin = GLOB.trade_destinations[origin]
	.["origin"] = trade_origin.ui_data()
	var/datum/trade_dest = GLOB.trade_destinations[destination]
	.["destination"] = trade_dest.ui_data()

/datum/space_freight/food
	freight_name = "bulk food"
	trade_good_category = TRADE_GOOD_FOOD

/datum/space_freight/weapons
	freight_name = "wholesale weapons"
	trade_good_category = TRADE_GOOD_SECURITY
	price_modifiers = list(400, 800)
	sale_modifiers = list(0.8, 0.9)
	hike_modifiers = list(1.5, 2.0)

/datum/space_freight/luxury_goods
	freight_name = "luxury goods"
	trade_good_category = TRADE_GOOD_LUXURIES
	price_modifiers = list(500, 1000)
	sale_modifiers = list(0.7, 0.9)
	hike_modifiers = list(1.05, 1.2)

/datum/space_freight/ore
	freight_name = "bulk mineral"
	trade_good_category = TRADE_GOOD_MINERALS
	price_modifiers = list(200, 400)
	sale_modifiers = list(0.5, 0.95)
	hike_modifiers = list(1.0, 1.15)

/datum/space_freight/gas
	freight_name = "secure chemical"
	trade_good_category = TRADE_GOOD_GAS
	price_modifiers = list(200, 400)
	sale_modifiers = list(0.75, 0.95)
	hike_modifiers = list(1.0, 1.4)

/datum/space_freight/livestock
	freight_name = "livestock transit"
	trade_good_category = TRADE_GOOD_ANIMALS
	price_modifiers = list(200, 400)
	sale_modifiers = list(0.5, 0.95)
	hike_modifiers = list(1.0, 1.15)

/datum/space_freight/robotics
	freight_name = "robotics equipment"
	trade_good_category = TRADE_GOOD_ROBOTICS
	price_modifiers = list(300, 700)
	sale_modifiers = list(0.9, 0.75)
	hike_modifiers = list(1.0, 1.15)

/datum/space_freight/biomedical
	freight_name = "biomedical supplies"
	trade_good_category = TRADE_GOOD_BIOMEDICAL
	price_modifiers = list(300, 700)
	sale_modifiers = list(0.9, 0.95)
	hike_modifiers = list(1.0, 1.15)

/datum/space_freight/emergency
	freight_name = "emergency supplies"
	trade_good_category = TRADE_GOOD_EMERGENCY
	price_modifiers = list(300, 700)
	sale_modifiers = list(0.9, 0.95)
	hike_modifiers = list(1.0, 1.15)
