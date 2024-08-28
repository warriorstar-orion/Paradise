///sent from ai controllers when a behavior is inserted into the queue: (list/new_arguments)
#define AI_CONTROLLER_BEHAVIOR_QUEUED(type) "ai_controller_behavior_queued_[type]"

/// Signal sent when a blackboard key is set to a new value
#define COMSIG_AI_BLACKBOARD_KEY_SET(blackboard_key) "ai_blackboard_key_set_[blackboard_key]"

///Signal sent before a blackboard key is cleared
#define COMSIG_AI_BLACKBOARD_KEY_PRECLEAR(blackboard_key) "ai_blackboard_key_pre_clear_[blackboard_key]"

/// Signal sent when a blackboard key is cleared
#define COMSIG_AI_BLACKBOARD_KEY_CLEARED(blackboard_key) "ai_blackboard_key_clear_[blackboard_key]"

//from base of atom/attack_basic_mob(): (/mob/user)
#define COMSIG_ATOM_ATTACK_BASIC_MOB "attack_basic_mob"

///Signal sent when a bot is reset
#define COMSIG_BOT_RESET "bot_reset"

///Called on /basic when updating its speed, from base of /mob/living/basic/update_basic_mob_varspeed(): ()
#define POST_BASIC_MOB_UPDATE_VARSPEED "post_basic_mob_update_varspeed"

///From base of mob/update_movespeed():area
#define COMSIG_MOB_MOVESPEED_UPDATED "mob_update_movespeed"

/// from mob/proc/dropItemToGround()
#define COMSIG_MOB_DROPPING_ITEM "mob_dropping_item"

// /mob/living/simple_animal/hostile signals
///before attackingtarget has happened, source is the attacker and target is the attacked
#define COMSIG_HOSTILE_PRE_ATTACKINGTARGET "hostile_pre_attackingtarget"

///after attackingtarget has happened, source is the attacker and target is the attacked, extra argument for if the attackingtarget was successful
#define COMSIG_HOSTILE_POST_ATTACKINGTARGET "hostile_post_attackingtarget"

//from base of atom/attack_basic_mob(): (/mob/user)
#define COMSIG_ATOM_ATTACK_BASIC_MOB "attack_basic_mob"

///from base of /mob/verb/pointed: (atom/A)
#define COMSIG_MOB_POINTED "mob_pointed"

///sent from ai controllers when they possess a pawn: (datum/ai_controller/source_controller)
#define COMSIG_AI_CONTROLLER_POSSESSED_PAWN "ai_controller_possessed_pawn"
///sent from ai controllers when they pick behaviors: (list/datum/ai_behavior/old_behaviors, list/datum/ai_behavior/new_behaviors)
#define COMSIG_AI_CONTROLLER_PICKED_BEHAVIORS "ai_controller_picked_behaviors"
