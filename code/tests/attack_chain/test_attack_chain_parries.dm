/datum/game_test/attack_chain_parries/Run()
	var/datum/test_puppeteer/attacker = new(src)
	attacker.puppet.name = "Attacker"
	var/datum/test_puppeteer/target = attacker.spawn_puppet_nearby()
	target.puppet.name = "Target"
