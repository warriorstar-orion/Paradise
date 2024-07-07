// DM API for "rustdmm" map loader/initializer

/* check_grep:ignore */ /var/__rustdmm

/proc/__detect_rustdmm()
	if(world.system_type == UNIX)
#ifdef CIBUILDING
		// CI override, use librustdmm_ci.so if possible.
		if(fexists("./tools/ci/librustdmm_ci.so"))
			return __rustdmm = "tools/ci/librustdmm_ci.so"
#endif
		// First check if it's built in the usual place.
		if(fexists("./rustdmm/target/i686-unknown-linux-gnu/release/librustdmm.so"))
			return __rustdmm = "./rustdmm/target/i686-unknown-linux-gnu/release/librustdmm.so"
		// Then check in the current directory.
		if(fexists("./librustdmm.so"))
			return __rustdmm = "./librustdmm.so"
		// And elsewhere.
		return __rustdmm = "librustdmm.so"
	else
		// First check if it's built in the usual place.
		if(fexists("./rustdmm/target/i686-pc-windows-msvc/debug/rustdmm.dll"))
			return __rustdmm = "./rustdmm/target/i686-pc-windows-msvc/debug/rustdmm.dll"
		// Then check in the current directory.
		if(fexists("./rustdmm.dll"))
			return __rustdmm = "./rustdmm.dll"
		// And elsewhere.
		return __rustdmm = "rustdmm.dll"

#define RUSTDMM (__rustdmm || __detect_rustdmm())

#define RUSTDMM_CALL(func, args...) call_ext(RUSTDMM, "byond:[#func]_ffi")(args)

#define RUSTDMM_CALL_TEST_THING(args...) RUSTDMM_CALL(test_thing, args)

#define RUSTDMM_CALL_TEST_READ(args...) RUSTDMM_CALL(test_read, args)

// #define RUSTDMM_CALL_TEST_FIND_VAREDITS(args...) RUSTDMM_CALL(test_find_varedits, args)

#define RUSTDMM_CALL_TEST_APPLY_VAREDITS(args...) RUSTDMM_CALL(test_apply_varedits, args)

// #define RUSTDMM_CALL_HAS_UNIQUE_AREA(args...) RUSTDMM_CALL(has_unique_area, args)

// #define RUSTDMM_CALL_ADD_UNIQUE_AREA(args...) RUSTDMM_CALL(add_unique_area, args)

// /proc/rustdmm_find_varedits(atom/A)
// 	return RUSTDMM_CALL_TEST_FIND_VAREDITS(A, "[A.type]")

/datum/rustmap_manager

/datum/rustmap_manager/proc/import_map(map_path)


GLOBAL_DATUM_INIT(rustmap_manager, /datum/rustmap_manager, new)

/datum/rustdmm_varedits
	var/list/edits

/proc/rustdmm_apply_varedits(atom/A)
	return RUSTDMM_CALL_TEST_APPLY_VAREDITS(A, "[A.type]")

/datum/rustdmm_load_rect
	var/bottom_left = 0
	var/top_right = 0
	var/smoothing_bottom_left = 0
	var/smoothing_top_right = 0

// /proc/rustdmm_has_unique_area(area/A)
// 	return RUSTDMM_CALL_HAS_UNIQUE_AREA(A)

// /proc/rustdmm_add_unique_area(area/A)
// 	return RUSTDMM_CALL_ADD_UNIQUE_AREA(A)

/proc/rustdmm_test_read(z_level)
	GLOB.space_manager.add_dirt(z_level)
	var/datum/rustdmm_load_rect/rect = RUSTDMM_CALL_TEST_READ(
		"_maps/map_files/RandomRuins/SpaceRuins/rustdmm_test_map.dmm", 10, 10, z_level)
	GLOB.space_manager.remove_dirt(z_level)
	var/datum/milla_safe/late_setup_level/milla = new()
	milla.invoke_async(
		block(rect.bottom_left, rect.top_right),
		block(rect.smoothing_bottom_left, rect.smoothing_top_right))

	return rect

/proc/rustdmm_load_station(map_path, z_level)
	var/datum/rustdmm_load_rect/rect = RUSTDMM_CALL_TEST_READ(map_path, 1, 1, z_level)

	return rect
