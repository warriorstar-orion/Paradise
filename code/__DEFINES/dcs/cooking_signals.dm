#define COMSIG_AUTOCHEF_BEGIN_RECIPE			"autochef_begin_recipe"
#define COMSIG_AUTOCHEF_COMPLETE_RECIPE			"autochef_complete_recipe"
#define COMSIG_AUTOCHEF_LOCATE_CONTAINER		"autochef_locate_container"
#define COMSIG_AUTOCHEF_LOCATE_INGREDIENTS		"autochef_locate_ingredients"

#define COMSIG_COOKING_CONTAINER_MODIFIED		"cooking_container_modified"

#define COMSIG_COOKING_RECIPE_BEGIN				"cooking_recipe_begin"
	#define COMPONENT_COOKING_NO_RECIPE			(1 << 0)

#define COMSIG_COOKING_RECIPE_STEP				"cooking_recipe_step"
#define COMSIG_COOKING_RECIPE_COMPLETE			"cooking_recipe_complete"

#define COMSIG_COOKING_MACHINE_STEP_BEGIN		"cooking_machine_step_begin"
#define COMSIG_COOKING_MACHINE_STEP_ERROR		"cooking_machine_step_error"
#define COMSIG_COOKING_MACHINE_STEP_FAILED		"cooking_machine_step_failed"
#define COMSIG_COOKING_MACHINE_STEP_SUCCESS		"cooking_machine_step_success"
