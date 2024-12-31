//#define CWJ_DEBUG 1

//Check item use flags
#define CWJ_NO_STEPS  	  	1 //The used object has no valid recipe uses
#define CWJ_CHOICE_CANCEL 	2 //The user opted to cancel when given a choice
#define CWJ_SUCCESS 		3 //The user decided to use the item and the step was followed
#define CWJ_PARTIAL_SUCCESS	4 //The user decided to use the item but the qualifications for the step was not fulfilled
#define CWJ_COMPLETE		5 //The meal has been completed!
#define CWJ_LOCKOUT			6 //Someone tried starting the function while a prompt was running. Jerk.
#define CWJ_BURNT			7 //The meal was ruined by burning the food somehow.
#define CWJ_FOLLOW_STEP_SENTINEL 8 // The step was completed but doesn't need to pass any information about it back to the tracker.
#define CWJ_NO_RECIPES 9

#define CWJ_CHECK_INVALID	0
#define CWJ_CHECK_VALID		1
#define CWJ_CHECK_FULL		2 //For reagents, nothing can be added to
#define CWJ_CHECK_SILENT	3

//Cooking container types
#define PLATE 			"plate"
#define CUTTING_BOARD	"cutting board"
#define PAN				"pan"
#define POT				"pot"
#define BOWL			"bowl"
#define DF_BASKET		"deep fryer basket"
#define AF_BASKET		"air fryer basket"
#define OVEN			"oven"
#define GRILL			"grill grate"

// Cooking machine temperature settings.
#define J_LO	"Low"
#define J_MED	"Medium"
#define J_HI	"High"

// Burn times for cooking things on a stove.
// Anything put on a stove for this long becomes a burned mess.
#define CWJ_BURN_TIME_LOW		15 MINUTES
#define CWJ_BURN_TIME_MEDIUM	10 MINUTES
#define CWJ_BURN_TIME_HIGH		5 MINUTES

// Ignite times for reagents interacting with a stove.
// The stove will catch fire if left on too long with flammable reagents in any of its holders.
#define CWJ_IGNITE_TIME_LOW		40 MINUTES
#define CWJ_IGNITE_TIME_MEDIUM	30 MINUTES
#define CWJ_IGNITE_TIME_HIGH	20 MINUTES

//Food Quality Tiers
#define CWJ_QUALITY_GARBAGE			-2
#define CWJ_QUALITY_GROSS			-1.5
#define CWJ_QUALITY_MEH				0.5
#define CWJ_QUALITY_NORMAL			1
#define CWJ_QUALITY_GOOD			1.2
#define CWJ_QUALITY_VERY_GOOD		1.4
#define CWJ_QUALITY_CUISINE			1.6
#define CWJ_QUALITY_LEGENDARY		1.8
#define CWJ_QUALITY_ELDRITCH		2.0

#define CWJ_ADD_ITEM(item_type, options...)					new/datum/cooking/recipe_step/add_item(item_type, list(##options))
#define CWJ_ADD_PRODUCE(item_type, options...)				new/datum/cooking/recipe_step/add_produce(item_type, list(##options))
#define CWJ_ADD_REAGENT(reagent_name, amount, options...)	new/datum/cooking/recipe_step/add_reagent(reagent_name, amount, list(##options))
#define CWJ_USE_GRILL(temperature, time, options...)		new/datum/cooking/recipe_step/use_grill(temperature, time, list(##options))
#define CWJ_USE_OVEN(temperature, time, options...)			new/datum/cooking/recipe_step/use_oven(temperature, time, list(##options))
#define CWJ_USE_STOVE(temperature, time, options...)		new/datum/cooking/recipe_step/use_stove(temperature, time, list(##options))
#define CWJ_USE_ICE_CREAM_MIXER(time, options...)			new/datum/cooking/recipe_step/use_ice_cream_mixer(time, list(##options))

#define CWJ_CONTAINER_AVAILABLE		1
#define CWJ_CONTAINER_BUSY			2
