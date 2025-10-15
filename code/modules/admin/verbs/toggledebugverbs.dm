// Would be nice to make this a permanent admin pref so we don't need to click it each time
ADMIN_VERB(enable_debug_verbs, R_DEBUG, "Debug verbs", "Enable all debug verbs.", VERB_CATEGORY_DEBUG)
	SSadmin_verbs.update_visibility_flag(user, VERB_VISIBILITY_FLAG_MOREDEBUG, TRUE)
	BLACKBOX_LOG_ADMIN_VERB("Debug Verbs")

ADMIN_VERB_VISIBILITY(disable_debug_verbs, VERB_VISIBILITY_FLAG_MOREDEBUG)
ADMIN_VERB(disable_debug_verbs, R_DEBUG, "Debug verbs", "Disable all debug verbs.", VERB_CATEGORY_DEBUG)
	SSadmin_verbs.update_visibility_flag(user, VERB_VISIBILITY_FLAG_MOREDEBUG, FALSE)
	BLACKBOX_LOG_ADMIN_VERB("Debug Verbs")
