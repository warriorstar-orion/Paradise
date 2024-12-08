/// The default starting step. Doesn't do anything, just holds the item.
/datum/cooking/recipe_step/start
	class = CWJ_START
	var/required_container

/datum/cooking/recipe_step/start/New(required_container_)
	required_container = required_container_
