/turf/closed/wall/mineral/cult
	name = "runed metal wall"
	desc = "A cold metal wall engraved with indecipherable symbols. Studying them causes your head to pound."
	icon = 'icons/turf/walls/cult_wall.dmi'
	icon_state = "cult"
	canSmoothWith = null
	var/alertthreshold

/turf/closed/wall/mineral/cult/New()
	PoolOrNew(/obj/effect/overlay/temp/cult/turf, src)
	..()

/turf/closed/wall/mineral/cult/break_wall()
	new/obj/item/stack/sheet/runed_metal(get_turf(src), 1)
	return (new /obj/structure/girder/cult(src))

/turf/closed/wall/mineral/cult/devastate_wall()
	new/obj/item/stack/sheet/runed_metal(get_turf(src), 1)

/turf/closed/wall/mineral/cult/narsie_act()
	return

/turf/closed/wall/mineral/cult/ratvar_act()
	. = ..()
	if(istype(src, /turf/closed/wall/mineral/cult)) //if we haven't changed type
		var/previouscolor = color
		color = "#FAE48C"
		animate(src, color = previouscolor, time = 8)
		addtimer(src, "update_atom_colour", 8)

/turf/closed/wall/mineral/cult/process()
	..()
	if(alertthreshold)
		alertthreshold--

/turf/closed/wall/mineral/cult/Bumped(atom/movable/C as mob)
	var/phasable=0
	if(istype(C,/mob/living/simple_animal/hostile/construct))
		var/mob/living/simple_animal/hostile/construct/construct = C
		if(!construct.phaser)
			return
		phasable = 2
		while(phasable>0)
			if(construct.pulling)
				construct.stop_pulling()
			src.density = 0
			src.alpha = 60
			src.opacity = 0
			sleep(10)
			phasable--
		src.density = 1
		src.alpha = initial(src.alpha)
		src.opacity = 1
	return

/turf/closed/wall/mineral/cult/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/tome) && iscultist(user))
		if(src.density == 1)
			user <<"<span class='notice'>Your tome passes through the wall as if it's thin air.</span>"
			alpha = 60
			density = 0
			opacity = 0
			var/messaged_admins
			for(var/turf/open/ST in orange(1, src))
				if(messaged_admins || alertthreshold)
					break
				if(istype(ST, /turf/open/space/))
					messaged_admins = TRUE
					message_admins("[src] <A href='?_src_=holder;jumpto=\ref[src]'>([x], [y], [z])</A> has been opened by [user]/[user.ckey] near a space vacuum.")
					log_game("[user]/[user.ckey] used their arcane tome to open a runed wall, which was adjacent to a space tile.")
					alertthreshold += 500
		else
			user <<"<span class='notice'>Your tome solidly connects with the wall.</span>"
			alpha = initial(src.alpha)
			density = 1
			opacity = 1
	return

/turf/closed/wall/mineral/cult/artificer
	name = "runed stone wall"
	desc = "A cold stone wall engraved with indecipherable symbols. Studying them causes your head to pound."

/turf/closed/wall/mineral/cult/artificer/break_wall()
	PoolOrNew(/obj/effect/overlay/temp/cult/turf, get_turf(src))
	return null //excuse me we want no runed metal here

/turf/closed/wall/mineral/cult/artificer/devastate_wall()
	PoolOrNew(/obj/effect/overlay/temp/cult/turf, get_turf(src))

//Clockwork wall: Causes nearby tinkerer's caches to generate components.
/turf/closed/wall/clockwork
	name = "clockwork wall"
	desc = "A huge chunk of warm metal. The clanging of machinery emanates from within."
	explosion_block = 2
	hardness = 10
	sheet_type = /obj/item/stack/tile/brass
	var/obj/effect/clockwork/overlay/wall/realappearence
	var/obj/structure/destructible/clockwork/cache/linkedcache

/turf/closed/wall/clockwork/New()
	..()
	PoolOrNew(/obj/effect/overlay/temp/ratvar/wall, src)
	PoolOrNew(/obj/effect/overlay/temp/ratvar/beam, src)
<<<<<<< HEAD:code/game/turfs/simulated/walls_misc.dm
	START_PROCESSING(SSobj, src)
	clockwork_construction_value += 5

/turf/closed/wall/clockwork/Destroy()
	STOP_PROCESSING(SSobj, src)
	clockwork_construction_value -= 5
=======
	realappearence = PoolOrNew(/obj/effect/clockwork/overlay/wall, src)
	realappearence.linked = src
	change_construction_value(5)

/turf/closed/wall/clockwork/examine(mob/user)
>>>>>>> masterTGbranch:code/game/turfs/simulated/wall/misc_walls.dm
	..()
	if((is_servant_of_ratvar(user) || isobserver(user)) && linkedcache)
		user << "<span class='brass'>It is linked, generating components in a cache!</span>"

<<<<<<< HEAD:code/game/turfs/simulated/walls_misc.dm
/turf/closed/wall/clockwork/process()
	if(prob(2))
		playsound(src, 'sound/magic/clockwork/fellowship_armory.ogg', rand(1, 5), 1, -4, 1, 1)
	for(var/obj/structure/clockwork/cache/C in orange(1, src))
		if(C.wall_generation_cooldown <= world.time)
			C.wall_generation_cooldown = world.time + CACHE_PRODUCTION_TIME
			generate_cache_component()
			playsound(src, 'sound/magic/clockwork/fellowship_armory.ogg', rand(15, 20), 1, -3, 1, 1)
			C.visible_message("<span class='warning'>Something clunks around inside of [C].</span>")

/turf/closed/wall/clockwork/ChangeTurf(path, defer_change = FALSE)
	if(path != type)
		change_construction_value(-5)
	return ..()
=======
/turf/closed/wall/clockwork/Destroy()
	be_removed()
	return ..()

/turf/closed/wall/clockwork/ChangeTurf(path, defer_change = FALSE)
	if(path != type)
		be_removed()
	return ..()

/turf/closed/wall/clockwork/proc/be_removed()
	if(linkedcache)
		linkedcache.linkedwall = null
		linkedcache = null
	change_construction_value(-5)
	qdel(realappearence)
	realappearence = null
>>>>>>> masterTGbranch:code/game/turfs/simulated/wall/misc_walls.dm

/turf/closed/wall/clockwork/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = I
		if(!WT.remove_fuel(0,user))
			return 0
<<<<<<< HEAD:code/game/turfs/simulated/walls_misc.dm
		playsound(src, 'sound/items/Welder.ogg', 100, 1)
=======
		playsound(src, WT.usesound, 100, 1)
>>>>>>> masterTGbranch:code/game/turfs/simulated/wall/misc_walls.dm
		user.visible_message("<span class='notice'>[user] begins slowly breaking down [src]...</span>", "<span class='notice'>You begin painstakingly destroying [src]...</span>")
		if(!do_after(user, 120*WT.toolspeed, target = src))
			return 0
		if(!WT.remove_fuel(1, user))
			return 0
		user.visible_message("<span class='notice'>[user] breaks apart [src]!</span>", "<span class='notice'>You break apart [src]!</span>")
		dismantle_wall()
		return 1
	return ..()

<<<<<<< HEAD:code/game/turfs/simulated/walls_misc.dm
/turf/closed/wall/clockwork/ratvar_act()
	for(var/mob/M in src)
		M.ratvar_act()

=======
>>>>>>> masterTGbranch:code/game/turfs/simulated/wall/misc_walls.dm
/turf/closed/wall/clockwork/narsie_act()
	..()
	if(istype(src, /turf/closed/wall/clockwork)) //if we haven't changed type
		var/previouscolor = color
		color = "#960000"
		animate(src, color = previouscolor, time = 8)
		addtimer(src, "update_atom_colour", 8)

/turf/closed/wall/clockwork/dismantle_wall(devastated=0, explode=0)
	if(devastated)
		devastate_wall()
		ChangeTurf(/turf/open/floor/plating)
	else
		playsound(src, 'sound/items/Welder.ogg', 100, 1)
		var/newgirder = break_wall()
		if(newgirder) //maybe we want a gear!
			transfer_fingerprints_to(newgirder)
		ChangeTurf(/turf/open/floor/clockwork)

	for(var/obj/O in src) //Eject contents!
		if(istype(O,/obj/structure/sign/poster))
			var/obj/structure/sign/poster/P = O
			P.roll_and_drop(src)
		else
			O.loc = src

/turf/closed/wall/clockwork/break_wall()
	new sheet_type(src)
	return new/obj/structure/destructible/clockwork/wall_gear(src)

/turf/closed/wall/clockwork/devastate_wall()
	for(var/i in 1 to 2)
		new/obj/item/clockwork/alloy_shards/large(src)
	for(var/i in 1 to 2)
		new/obj/item/clockwork/alloy_shards/medium(src)
	for(var/i in 1 to 3)
		new/obj/item/clockwork/alloy_shards/small(src)


/turf/closed/wall/vault
	icon = 'icons/turf/walls.dmi'
	icon_state = "rockvault"

/turf/closed/wall/ice
	icon = 'icons/turf/walls/icedmetal_wall.dmi'
	icon_state = "iced"
	desc = "A wall covered in a thick sheet of ice."
	canSmoothWith = null
	hardness = 35
	slicing_duration = 150 //welding through the ice+metal

/turf/closed/wall/rust
	name = "rusted wall"
	desc = "A rusted metal wall."
	icon = 'icons/turf/walls/rusty_wall.dmi'
	hardness = 45

/turf/closed/wall/r_wall/rust
	name = "rusted reinforced wall"
	desc = "A huge chunk of rusted reinforced metal."
	icon = 'icons/turf/walls/rusty_reinforced_wall.dmi'
	hardness = 15
