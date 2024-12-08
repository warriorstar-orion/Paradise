/obj/item/circuitboard/cooking/stove
	board_name = "Stovetop"
	build_path = /obj/machinery/cooking/stove
	board_type = "machine"
	origin_tech = list(TECH_BIO = 1)
	req_components = list(
		/obj/item/stock_parts/manipulator = 2, //Affects the food quality
	)

/obj/item/circuitboard/cooking/oven
	board_name = "Convection Oven"
	build_path = /obj/machinery/cooking/oven
	board_type = "machine"
	origin_tech = list(TECH_BIO = 1)
	req_components = list(
		/obj/item/stock_parts/micro_laser = 2, //Affects the food quality
	)

/obj/item/circuitboard/cooking/grill
	board_name = "Charcoal Grill"
	build_path = /obj/machinery/cooking/grill
	board_type = "machine"
	origin_tech = list(TECH_BIO = 1)
	req_components = list(
		/obj/item/stock_parts/micro_laser = 2, //Affects the food quality
		/obj/item/stock_parts/matter_bin = 2, //Affects wood hopper size
	)
