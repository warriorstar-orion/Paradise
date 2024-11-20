/obj/effect/turf_decal/floor_markings
	icon_state = "blank"
	painter_category = DECAL_PAINTER_CATEGORY_TILES

#define FLOOR_MARKINGS_HELPER(name, icon_path)						\
	/obj/effect/turf_decal/floor_markings/##name {					\
		icon = icon_path;											\
		icon_state = "tile_full"									\
	}																\
	/obj/effect/turf_decal/floor_markings/##name/directional {		\
		icon_state = "tile_directional"								\
	}																\
	/obj/effect/turf_decal/floor_markings/##name/corner {			\
		icon_state = "tile_corner"									\
	}																\
	/obj/effect/turf_decal/floor_markings/##name/checker {			\
		icon_state = "tile_opposing_corners"						\
	}																\
	/obj/effect/turf_decal/floor_markings/##name/mono {				\
		icon_state = "tile_mono"									\
	}																\
	/obj/effect/turf_decal/floor_markings/##name/half {				\
		icon_state = "tile_half"									\
	}

FLOOR_MARKINGS_HELPER(departmental/security, 'icons/turf/decals/floormarkings/departmental/security_decals.dmi')
FLOOR_MARKINGS_HELPER(departmental/medical, 'icons/turf/decals/floormarkings/departmental/medical_decals.dmi')
FLOOR_MARKINGS_HELPER(departmental/virology, 'icons/turf/decals/floormarkings/departmental/virology_decals.dmi')
FLOOR_MARKINGS_HELPER(departmental/engineering, 'icons/turf/decals/floormarkings/departmental/chemistry_decals.dmi')
FLOOR_MARKINGS_HELPER(departmental/science, 'icons/turf/decals/floormarkings/departmental/science_decals.dmi')
FLOOR_MARKINGS_HELPER(departmental/cargo, 'icons/turf/decals/floormarkings/departmental/cargo_decals.dmi')
FLOOR_MARKINGS_HELPER(jobs/bar, 'icons/turf/decals/floormarkings/jobs/bar_decals.dmi')
FLOOR_MARKINGS_HELPER(dark, 'icons/turf/decals/floormarkings/departmental/dark_decals.dmi')
FLOOR_MARKINGS_HELPER(neutral, 'icons/turf/decals/floormarkings/departmental/neutral_decals.dmi')
FLOOR_MARKINGS_HELPER(white, 'icons/turf/decals/floormarkings/departmental/white_decals.dmi')
