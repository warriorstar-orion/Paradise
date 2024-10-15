/obj/item/reagent_containers/food/snacks/examine(mob/user, extra_description = "")
	#ifdef CWJ_DEBUG
	extra_description += "<span class='notice'>\nThe food's level of quality is [food_quality]</span>" //Visual number should only be visible when debugging
	#endif
	if(cooking_description_modifier)
		extra_description += cooking_description_modifier
	extra_description += food_descriptor

	if (bitecount==0)
		extra_description += "<span class='notice'>\nThe [src] is unbitten.</span>"
	else if (bitecount==1)
		extra_description += "<span class='notice'>\nThe [src] was bitten by someone!</span>"
	else if (bitecount<=3)
		extra_description += "<span class='notice'>\nThe [src] was bitten [bitecount] time\s!</span>"
	else
		extra_description += "<span class='notice'>\nThe [src] was bitten multiple times!</span>"
	..(user, extra_description)
