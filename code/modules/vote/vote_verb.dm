/client/verb/vote()
	set category = "OOC"
	set name = "Vote"

	if(SSvote.active_vote)
		SSvote.active_vote.ui_interact(usr)
	else
		to_chat(usr, "There is no active vote")
