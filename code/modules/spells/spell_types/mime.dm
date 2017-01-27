/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall
	name = "Invisible wall"
	desc = "The mime's performance transmutates into physical reality."
	school = "mime"
	panel = "Mime"
	summon_type = list(/obj/effect/forcefield/mime)
	invocation_type = "emote"
	invocation_emote_self = "<span class='notice'>You form a wall in front of yourself.</span>"
	summon_lifespan = 300
	charge_max = 300
	clothes_req = 0
	range = 0
	cast_sound = null
	human_req = 1

	action_icon_state = "mime"
	action_background_icon_state = "bg_mime"

/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall/Click()
	if(usr && usr.mind)
		if(!usr.mind.miming)
			usr << "<span class='notice'>You must dedicate yourself to silence first.</span>"
			return
		invocation = "<B>[usr.real_name]</B> looks as if a wall is in front of [usr.p_them()]."
	else
		invocation_type ="none"
	..()


/obj/effect/proc_holder/spell/targeted/mime/speak
	name = "Speech"
	desc = "Make or break a vow of silence."
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 3000
	range = -1
	include_user = 1

	action_icon_state = "mime"
	action_background_icon_state = "bg_mime"

/obj/effect/proc_holder/spell/targeted/mime/speak/Click()
	if(!usr)
		return
	if(!ishuman(usr))
		return
	if(world.time < 15000) // 25 minutes
		usr << "<span class='warning'>It's too early into the shift to do this! Play your part!"
		return
	var/mob/living/carbon/human/H = usr
	if(H.mind.miming)
		still_recharging_msg = "<span class='warning'>You can't break your vow of silence that fast!</span>"
	else
		still_recharging_msg = "<span class='warning'>You'll have to wait before you can give your vow of silence again!</span>"
	..()

/obj/effect/proc_holder/spell/targeted/mime/speak/cast(list/targets,mob/user = usr)
	for(var/mob/living/carbon/human/H in targets)
		H.mind.miming=!H.mind.miming
		if(H.mind.miming)
			H << "<span class='notice'>You make a vow of silence.</span>"
		else
			H << "<span class='notice'>You break your vow of silence.</span>"

/obj/effect/proc_holder/spell/targeted/touch/mime
	name = "Invisible Touch"
	desc = "It dissapeared!"
	hand_path = "/obj/item/weapon/melee/touch_attack/nothing/roundstart" // there is a non roundstart version. can be found in godhand.dmi
	panel = "Mime"

	invocation_type = "emote"
	invocation_emote_self = "<span class='notice'>You blow on your finger.</span>"
	school = "mime"
	charge_max = 1000
	clothes_req = 0
	cooldown_min = 500

	action_icon_state = "nothing"


/obj/effect/proc_holder/spell/targeted/touch/mime/Click()
	if(usr && usr.mind)
		if(!usr.mind.miming)
			usr << "<span class='notice'>You've don't remember how to perform this... It probably takes dedication.</span>"
			return
	..()
