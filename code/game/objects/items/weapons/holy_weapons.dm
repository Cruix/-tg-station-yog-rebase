/obj/item/weapon/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian, its very presence disrupts and dampens the powers of Nar-Sie's followers."
	icon_state = "nullrod"
	item_state = "nullrod"
	force = 18
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	w_class = WEIGHT_CLASS_TINY
	var/reskinned = FALSE

/obj/item/weapon/nullrod/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is killing [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to get closer to god!</span>")
	return (BRUTELOSS|FIRELOSS)

/obj/item/weapon/nullrod/attack_self(mob/user)
	if(reskinned)
		return
	if(user.mind && (user.mind.assigned_role == "Chaplain"))
		reskin_holy_weapon(user)

/obj/item/weapon/nullrod/proc/reskin_holy_weapon(mob/M)
	var/obj/item/weapon/nullrod/holy_weapon

	if(SSreligion.holy_weapon)
		holy_weapon = new SSreligion.holy_weapon
		M << "<span class='notice'>The null rod suddenly morphs into your religions already chosen holy weapon.</span>"
	else
		var/list/holy_weapons_list = typesof(/obj/item/weapon/nullrod)
		var/list/display_names = list()
		for(var/V in holy_weapons_list)
			var/atom/A = V
			display_names += initial(A.name)

		var/choice = input(M,"What theme would you like for your holy weapon?","Holy Weapon Theme") as null|anything in display_names
		if(!src || !choice || M.stat || !in_range(M, src) || M.restrained() || !M.canmove || reskinned)
			return

		var/index = display_names.Find(choice)
		var/A = holy_weapons_list[index]

		holy_weapon = new A

		SSreligion.holy_weapon = holy_weapon.type

		feedback_set_details("chaplain_weapon","[choice]")


	if(holy_weapon)
		holy_weapon.reskinned = TRUE
		M.unEquip(src)
		M.put_in_active_hand(holy_weapon)
		qdel(src)

/obj/item/weapon/nullrod/godhand
	icon_state = "disintegrate"
	item_state = "disintegrate"
	name = "god hand"
	desc = "This hand of yours glows with an awesome power!"
	flags = ABSTRACT | NODROP | DROPDEL
<<<<<<< HEAD
	w_class = 5
=======
	w_class = WEIGHT_CLASS_HUGE
>>>>>>> masterTGbranch
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	attack_verb = list("punched", "cross countered", "pummeled")

<<<<<<< HEAD
/obj/item/weapon/nullrod/genesis
	icon_state = "disintegrate"
	item_state = "disintegrate"
	name = "genesis"
	flags = ABSTRACT | NODROP
	w_class = 5
	damtype = BURN
	hitsound = 'sound/weapons/sear.ogg'
	attack_verb = list("sears", "commands", "instructs")
	var/message
	var/cooldown

/obj/item/weapon/nullrod/genesis/New()
	..()
	var/diety = ticker.Bible_deity_name
	if(!diety)
		desc = "It is the will of man that tells you to do these things, so you must!"
		return
	desc = "It is the plan of [diety] that gives me the power to tell you what to do, so do it!"
	message = "Obey [diety]."


/obj/item/weapon/nullrod/genesis/attack_self(mob/living/user)
	..()

	var/genesis = input(usr, "Enter the message you want to deliever", "")

	if(!genesis)
		return

	if(length(genesis) > 55)
		user << "<span class='alert'>That message is too long! Genesis cannot deliever that!</span>"
		return

	message = genesis
	user << "<span class='alert'>Genesis will now deliever the message: [genesis]</span>"


/obj/item/weapon/nullrod/genesis/attack(mob/M, mob/living/carbon/human/user)
	if(cooldown > world.time - 25)
		if(user.a_intent == HELP)
			user << "Genesis is not ready."
			return
		..()
		return

	if(user == M)
		..()
		return


	switch (user.a_intent)
		if(HARM)
			M << 'sound/weapons/sear.ogg'
			M << "<span class='genesisred'>[message]</span><br>"
			..()

		if(DISARM || GRAB)
			M << "<span class='genesisred'>[message]</span><br>"
			if(!M.jitteriness)
				M.Jitter(15)

		if(HELP)
			M << 'sound/effects/pray.ogg'
			M << "<span class='genesisgreen'>[message]</span><br>"

	log_game("[user] has sent a genesis message to [M] stating: [message]")
	cooldown = world.time
	user << "Message delivered."



/obj/item/weapon/nullrod/genesis/dropped(mob/user)
	visible_message("<span class='danger'>[src] screeches at the top of their lungs as they ascend!</span>")
	qdel(src)

/obj/item/weapon/nullrod/genesis/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is saying good bye to \the [src.name]! It looks like \he's trying to sing her away!s</span>")
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		spawn(75) // gib three times, spill organs, drop genesis
			gibs(H.loc, H.viruses, H.dna)
			H.adjustBruteLoss(1000)
			H.spill_organs(1)
			for(var/obj/item/W in H)
				H.unEquip(W)
			gibs(H.loc, H.viruses, H.dna)
			spawn(3)
				gibs(H.loc, H.viruses, H.dna)
				dropped(user)

	user.Stun(50)

	user.say("So shut your eyes while mother sings")
	playsound(loc, 'sound/effects/splat.ogg', 50, 1)
	sleep(15)
	user.say("Of wonderful sights that be,")
	playsound(loc, 'sound/effects/splat.ogg', 70, 1)
	sleep(15)
	user.say("And you shall see the beautiful things")
	playsound(loc, 'sound/effects/splat.ogg', 80, 1)
	sleep(15)
	user.say("As you rock in the misty sea,")
	playsound(loc, 'sound/effects/splat.ogg', 90, 1)
	sleep(15)
	user.say("Where the old shoe rocked the fishermen three")
	playsound(loc, 'sound/effects/splat.ogg', 110, 1)
	sleep(15)
	user.say("Wynken, Blynken, and Nod")
	return (BRUTELOSS)

=======
>>>>>>> masterTGbranch
/obj/item/weapon/nullrod/staff
	icon_state = "godstaff-red"
	item_state = "godstaff-red"
	name = "red holy staff"
	desc = "It has a mysterious, protective aura."
	w_class = WEIGHT_CLASS_HUGE
	force = 5
	slot_flags = SLOT_BACK
	block_chance = 50
	var/shield_icon = "shield-red"

/obj/item/weapon/nullrod/staff/worn_overlays(isinhands)
	. = list()
	if(isinhands)
		. += image(icon = 'icons/effects/effects.dmi', icon_state = "[shield_icon]")

/obj/item/weapon/nullrod/staff/blue
	name = "blue holy staff"
	icon_state = "godstaff-blue"
	item_state = "godstaff-blue"
	shield_icon = "shield-old"

/obj/item/weapon/nullrod/claymore
	icon_state = "claymore"
	item_state = "claymore"
	name = "holy claymore"
	desc = "A weapon fit for a crusade!"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = SLOT_BACK|SLOT_BELT
	block_chance = 30
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/nullrod/claymore/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance, damage, attack_type)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight
	return ..()

/obj/item/weapon/nullrod/claymore/darkblade
	icon_state = "cultblade"
	item_state = "cultblade"
	name = "dark blade"
	desc = "Spread the glory of the dark gods!"
	slot_flags = SLOT_BELT
	hitsound = 'sound/hallucinations/growl1.ogg'

/obj/item/weapon/nullrod/claymore/chainsaw_sword
	icon_state = "chainswordon"
	item_state = "chainswordon"
	name = "sacred chainsaw sword"
	desc = "Suffer not a heretic to live."
	slot_flags = SLOT_BELT
	attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'

/obj/item/weapon/nullrod/claymore/glowing
	icon_state = "swordon"
	item_state = "swordon"
	name = "force weapon"
	desc = "The blade glows with the power of faith. Or possibly a battery."
	slot_flags = SLOT_BELT

/obj/item/weapon/nullrod/claymore/katana
	name = "hanzo steel"
	desc = "Capable of cutting clean through a holy claymore."
	icon_state = "katana"
	item_state = "katana"
	slot_flags = SLOT_BELT | SLOT_BACK

/obj/item/weapon/nullrod/claymore/multiverse
	name = "extradimensional blade"
	desc = "Once the harbinger of an interdimensional war, its sharpness fluctuates wildly."
	icon_state = "multiverse"
	item_state = "multiverse"
	slot_flags = SLOT_BELT

/obj/item/weapon/nullrod/claymore/multiverse/attack(mob/living/carbon/M, mob/living/carbon/user)
	force = rand(1, 30)
	..()

/obj/item/weapon/nullrod/claymore/saber
	name = "light energy sword"
	hitsound = 'sound/weapons/blade1.ogg'
	icon_state = "swordblue"
	item_state = "swordblue"
	desc = "If you strike me down, I shall become more robust than you can possibly imagine."
	slot_flags = SLOT_BELT

/obj/item/weapon/nullrod/claymore/saber/red
	name = "dark energy sword"
	icon_state = "swordred"
	item_state = "swordred"
	desc = "Woefully ineffective when used on steep terrain."

/obj/item/weapon/nullrod/claymore/saber/pirate
	name = "nautical energy sword"
	icon_state = "cutlass1"
	item_state = "cutlass1"
	desc = "Convincing HR that your religion involved piracy was no mean feat."

/obj/item/weapon/nullrod/sord
	name = "\improper UNREAL SORD"
	desc = "This thing is so unspeakably HOLY you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	slot_flags = SLOT_BELT
	force = 4.13
	throwforce = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/nullrod/scythe
	icon_state = "scythe1"
	item_state = "scythe1"
	name = "reaper scythe"
	desc = "Ask not for whom the bell tolls..."
	w_class = WEIGHT_CLASS_BULKY
	armour_penetration = 35
	slot_flags = SLOT_BACK
	sharpness = IS_SHARP
	attack_verb = list("chopped", "sliced", "cut", "reaped")

/obj/item/weapon/nullrod/scythe/vibro
	icon_state = "hfrequency0"
	item_state = "hfrequency1"
	name = "high frequency blade"
	desc = "Bad references are the DNA of the soul."
	attack_verb = list("chopped", "sliced", "cut", "zandatsu'd")
	hitsound = 'sound/weapons/rapierhit.ogg'
<<<<<<< HEAD
=======


/obj/item/weapon/nullrod/scythe/spellblade
	icon_state = "spellblade"
	item_state = "spellblade"
	icon = 'icons/obj/guns/magic.dmi'
	name = "dormant spellblade"
	desc = "The blade grants the wielder nearly limitless power...if they can figure out how to turn it on, that is."
	hitsound = 'sound/weapons/rapierhit.ogg'
>>>>>>> masterTGbranch

/obj/item/weapon/nullrod/scythe/talking
	icon_state = "talking_sword"
	item_state = "talking_sword"
	name = "possessed blade"
	desc = "When the station falls into chaos, it's nice to have a friend by your side."
	attack_verb = list("chopped", "sliced", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	var/possessed = FALSE

/obj/item/weapon/nullrod/scythe/talking/attack_self(mob/living/user)
	if(possessed)
		return

	user << "You attempt to wake the spirit of the blade..."

	possessed = TRUE

	var/list/mob/dead/observer/candidates = pollCandidates("Do you want to play as the spirit of [user.real_name]'s blade?", ROLE_PAI, null, FALSE, 100)
	var/mob/dead/observer/theghost = null

	if(candidates.len)
		theghost = pick(candidates)
		var/mob/living/simple_animal/shade/S = new(src)
		S.real_name = name
		S.name = name
		S.ckey = theghost.ckey
		S.status_flags |= GODMODE
		var/input = stripped_input(S,"What are you named?", ,"", MAX_NAME_LEN)

		if(src && input)
			name = input
			S.real_name = input
			S.name = input
	else
		user << "The blade is dormant. Maybe you can try again later."
		possessed = FALSE

/obj/item/weapon/nullrod/scythe/talking/Destroy()
	for(var/mob/living/simple_animal/shade/S in contents)
		S << "You were destroyed!"
		qdel(S)
	return ..()

/obj/item/weapon/nullrod/hammmer
	icon_state = "hammeron"
	item_state = "hammeron"
	name = "relic war hammer"
	desc = "This war hammer cost the chaplain forty thousand space dollars."
	slot_flags = SLOT_BELT
	w_class = WEIGHT_CLASS_HUGE
	attack_verb = list("smashed", "bashed", "hammered", "crunched")

/obj/item/weapon/nullrod/chainsaw
	name = "chainsaw hand"
	desc = "Good? Bad? You're the guy with the chainsaw hand."
	icon_state = "chainsaw_on"
	item_state = "mounted_chainsaw"
	w_class = WEIGHT_CLASS_HUGE
	flags = NODROP | ABSTRACT
	sharpness = IS_SHARP
	attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'

/obj/item/weapon/nullrod/clown
	icon = 'icons/obj/wizard.dmi'
	icon_state = "honkrender"
	item_state = "render"
	name = "clown dagger"
	desc = "Used for absolutely hilarious sacrifices."
	hitsound = 'sound/items/bikehorn.ogg'
	sharpness = IS_SHARP
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/nullrod/whip
	name = "holy whip"
	desc = "What a terrible night to be on Space Station 13."
	icon_state = "chain"
	item_state = "chain"
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed")
	hitsound = 'sound/weapons/chainhit.ogg'

/obj/item/weapon/nullrod/fedora
	name = "atheist's fedora"
	desc = "The brim of the hat is as sharp as your wit. The edge would hurt almost as much as disproving the existence of God."
	icon_state = "fedora"
	item_state = "fedora"
	slot_flags = SLOT_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	force = 0
	throw_speed = 4
	throw_range = 7
	throwforce = 30
	sharpness = IS_SHARP
	attack_verb = list("enlightened", "redpilled")

/obj/item/weapon/nullrod/armblade
	name = "dark blessing"
	desc = "Particularly twisted dieties grant gifts of dubious value."
	icon_state = "arm_blade"
	item_state = "arm_blade"
	flags = ABSTRACT | NODROP
	w_class = WEIGHT_CLASS_HUGE
	sharpness = IS_SHARP

/obj/item/weapon/nullrod/carp
	name = "carp-sie plushie"
	desc = "An adorable stuffed toy that resembles the god of all carp. The teeth look pretty sharp. Activate it to receive the blessing of Carp-Sie."
	icon = 'icons/obj/toy.dmi'
	icon_state = "carpplushie"
	item_state = "carp_plushie"
	force = 15
	attack_verb = list("bitten", "eaten", "fin slapped")
	hitsound = 'sound/weapons/bite.ogg'
	var/used_blessing = FALSE

/obj/item/weapon/nullrod/carp/attack_self(mob/living/user)
	if(used_blessing)
		return
	if(user.mind && (user.mind.assigned_role != "Chaplain"))
		return
	user << "You are blessed by Carp-Sie. Wild space carp will no longer attack you."
	user.faction |= "carp"
	used_blessing = TRUE

/obj/item/weapon/nullrod/claymore/bostaff //May as well make it a "claymore" and inherit the blocking
	name = "monk's staff"
	desc = "A long, tall staff made of polished wood. Traditionally used in ancient old-Earth martial arts, it is now used to harass the clown."
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	block_chance = 40
	slot_flags = SLOT_BACK
	sharpness = IS_BLUNT
	hitsound = "swing_hit"
	attack_verb = list("smashed", "slammed", "whacked", "thwacked")
	icon = 'icons/obj/weapons.dmi'
	icon_state = "bostaff0"
	item_state = "bostaff0"

/obj/item/weapon/nullrod/tribal_knife
	icon_state = "crysknife"
	item_state = "crysknife"
	name = "arrhythmic knife"
	w_class = WEIGHT_CLASS_HUGE
	desc = "They say fear is the true mind killer, but stabbing them in the head works too. Honour compels you to not sheathe it once drawn."
	sharpness = IS_SHARP
	slot_flags = null
	flags = HANDSLOW
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/nullrod/pitchfork
	icon_state = "pitchfork0"
	name = "unholy pitchfork"
	w_class = WEIGHT_CLASS_NORMAL
	desc = "Holding this makes you look absolutely devilish."
	attack_verb = list("poked", "impaled", "pierced", "jabbed")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP

/obj/item/weapon/nullrod/tribal_knife/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/weapon/nullrod/tribal_knife/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/weapon/nullrod/tribal_knife/process()
	slowdown = rand(-2, 2)

