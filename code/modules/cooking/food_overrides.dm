/obj/item/food/examine(mob/user, extra_description = "")
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

/obj/item/food/proc/get_food_tier()
	if(food_quality < -9)
		food_tier = CWJ_QUALITY_GARBAGE
		food_descriptor = "It looks gross. Someone cooked this poorly."
		bite_descriptor = " Eating this makes you regret every decision that lead you to this moment."
	else if (food_quality >= 100)
		food_tier = CWJ_QUALITY_ELDRITCH
		food_descriptor = "What cruel twist of fate it must be, for this unparalleled artistic masterpiece can only be truly appreciated through its destruction. Does this dish's transient form belie the true nature of all things? You see the totality of existence reflected through \the [src]."
		bite_descriptor = " It's like reliving the happiest moments of your life, nothing is better than this!"
	else
		switch(food_quality)
			if(-9 to 0)
				food_tier = CWJ_QUALITY_GROSS
				food_descriptor = "It looks like an unappetizing a meal."
				bite_descriptor = " Your stomach turns as you chew."
			if(1 to 10)
				food_tier = CWJ_QUALITY_MEH
				food_descriptor = "The food is edible, but frozen dinners have been reheated with more skill."
				bite_descriptor = " It could be worse, but it certainly isn't good."
			if(11 to 20)
				food_tier = CWJ_QUALITY_NORMAL
				food_descriptor = "It looks adequately made."
				bite_descriptor = " It's food, alright."
			if(21 to 30)
				food_tier = CWJ_QUALITY_GOOD
				food_descriptor = "The quality of the food is is pretty good."
				bite_descriptor = " This ain't half bad!"
			if(31 to 50)
				food_tier = CWJ_QUALITY_VERY_GOOD
				food_descriptor = "This food looks very tasty."
				bite_descriptor = " So tasty!"
			if(61 to 70)
				food_tier = CWJ_QUALITY_CUISINE
				food_descriptor = "There's a special spark in this cooking, a measure of love and care unseen by the casual chef."
				bite_descriptor = " You can taste the attention to detail like a fine spice on top of the excellently prepared dish."
			if(81 to 99)
				food_tier = CWJ_QUALITY_LEGENDARY
				food_descriptor = "The quality of this food is legendary. Words fail to describe it further. It must be eaten"
				bite_descriptor = " This food is unreal, the textures blend perfectly with the flavor, could food get any better than this?"
