/obj/shipturf
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "swall3"
	pixel_step_size = 32
	var/turf/origin
	//var/image/tile_image

/obj/shipturf/New()
	..()
	var/matrix/ntransform = transform
	ntransform.Scale(1.5)
	origin = loc
	//tile_image = image('icons/obj/projectiles.dmi', src, "red_laser", 10)
	//tile_image.appearance_flags = RESET_TRANSFORM|TILE_BOUND
	//overlays += tile_image

/obj/shipturf/master
	var/list/attached = list()
	var/rotation = 0
	var/mode = 0
	var/speed = 8

/obj/shipturf/master/Click()
	usr.remote_control = src
	usr.reset_perspective(src)

/obj/shipturf/master/New()
	..()/*
	attached = list(list(null, new /obj/shipturf(locate(src.x, src.y+2, src.z)), null),
					list(new /obj/shipturf(get_step(src, NORTHWEST)), new /obj/shipturf(get_step(src, NORTH)), new /obj/shipturf(get_step(src, NORTHEAST))),
					list(new /obj/shipturf(get_step(src, WEST)), null,                                         new /obj/shipturf(get_step(src, EAST))),
					list(new /obj/shipturf(get_step(src, SOUTHWEST)), new /obj/shipturf(get_step(src, SOUTH)), new /obj/shipturf(get_step(src, SOUTHEAST))),
					list())
	*/
	attached = list(
					list(new /obj/shipturf(null, locate(src.x-1, src.y+6, src.z)), new /obj/shipturf(locate(src.x, src.y+6, src.z)), new /obj/shipturf(locate(src.x+1, src.y+6, src.z)), null),
					list(new /obj/shipturf(null, locate(src.x-1, src.y+5, src.z)), new /obj/shipturf(locate(src.x, src.y+5, src.z)), new /obj/shipturf(locate(src.x+1, src.y+5, src.z)), null),
					list(new /obj/shipturf(null, locate(src.x-1, src.y+4, src.z)), new /obj/shipturf(locate(src.x, src.y+4, src.z)), new /obj/shipturf(locate(src.x+1, src.y+4, src.z)), null),
					list(new /obj/shipturf(null, locate(src.x-1, src.y+3, src.z)), new /obj/shipturf(locate(src.x, src.y+3, src.z)), new /obj/shipturf(locate(src.x+1, src.y+3, src.z)), null),
					list(new /obj/shipturf(null, locate(src.x-1, src.y+2, src.z)), new /obj/shipturf(locate(src.x, src.y+2, src.z)), new /obj/shipturf(locate(src.x+1, src.y+2, src.z)), null),
					list(new /obj/shipturf(null, locate(src.x-2, src.y+1, src.z)), new /obj/shipturf(get_step(src, NORTHWEST)), new /obj/shipturf(get_step(src, NORTH)), new /obj/shipturf(get_step(src, NORTHEAST)), new /obj/shipturf(null, locate(src.x+2, src.y+1, src.z))),
					list(new /obj/shipturf(null, locate(src.x-2, src.y, src.z)), new /obj/shipturf(get_step(src, WEST)), null,                                         new /obj/shipturf(get_step(src, EAST)), new /obj/shipturf(null, locate(src.x+2, src.y, src.z))),
					list(new /obj/shipturf(null, locate(src.x-2, src.y-1, src.z)), new /obj/shipturf(get_step(src, SOUTHWEST)), new /obj/shipturf(get_step(src, SOUTH)), new /obj/shipturf(get_step(src, SOUTHEAST)), new /obj/shipturf(null, locate(src.x+2, src.y-1, src.z))),
					list(new /obj/shipturf(null, locate(src.x-2, src.y-2, src.z)), new /obj/shipturf(locate(src.x-1, src.y-2, src.z)), new /obj/shipturf(locate(src.x, src.y-2, src.z)), new /obj/shipturf(locate(src.x+1, src.y-2, src.z)), new /obj/shipturf(null, locate(src.x+2, src.y-2, src.z))),
					list(new /obj/shipturf(null, locate(src.x-2, src.y-3, src.z)), new /obj/shipturf(locate(src.x-1, src.y-3, src.z)), new /obj/shipturf(locate(src.x, src.y-3, src.z)), new /obj/shipturf(locate(src.x+1, src.y-3, src.z)), new /obj/shipturf(null, locate(src.x+2, src.y-3, src.z))),
					list(new /obj/shipturf(null, locate(src.x-2, src.y-4, src.z)), new /obj/shipturf(locate(src.x-1, src.y-4, src.z)), new /obj/shipturf(locate(src.x, src.y-4, src.z)), new /obj/shipturf(locate(src.x+1, src.y-4, src.z)), new /obj/shipturf(null, locate(src.x+2, src.y-4, src.z))),
					list(new /obj/shipturf(null, locate(src.x-2, src.y-5, src.z)), new /obj/shipturf(locate(src.x-1, src.y-5, src.z)), new /obj/shipturf(locate(src.x, src.y-5, src.z)), new /obj/shipturf(locate(src.x+1, src.y-5, src.z)), new /obj/shipturf(null, locate(src.x+2, src.y-5, src.z))),
					list(new /obj/shipturf(null, locate(src.x-2, src.y-6, src.z)), new /obj/shipturf(locate(src.x-1, src.y-6, src.z)), new /obj/shipturf(locate(src.x, src.y-6, src.z)), new /obj/shipturf(locate(src.x+1, src.y-6, src.z)), new /obj/shipturf(null, locate(src.x+2, src.y-6, src.z))))


/obj/shipturf/master/proc/setRot(rot)
	rotation = rot % 360
	var/matrix/M = matrix()
	M.Turn(rot)
	transform = M

	for(var/y1 in 1 to attached.len)
		var/list/L = attached[y1]
		for(var/x1 in 1 to L.len)
			var/obj/shipturf/st = attached[y1][x1]
			if(!st)
				continue
			st.transform = M
			var y = (round(attached.len/2) - y1 + 1)*32
			var x = (round(L.len/2) - x1 + 1)*32
			var newX = x*cos(rot) + y*sin(rot)
			var newY = -x*sin(rot) + y*cos(rot)
			st.loc = locate(src.x + round(newX, 32)/32, src.y + round(newY, 32)/32, src.z)
			st.pixel_x = (newX - round(newX, 32)) % 32 + pixel_x
			st.pixel_y = (newY - round(newY, 32)) % 32 + pixel_y


/obj/shipturf/master/proc/translate(x, y)
	src.loc = locate(src.x + x, src.y + y, src.z)
	for(var/L in attached)
		for(var/T in L)
			if(!T)
				continue
			var/obj/shipturf/st = T
			st.loc = locate(st.x + x, st.y + y, st.z)
			setRot(rotation)

/obj/shipturf/master/proc/strafe(x, y)
	pixel_y += round(speed * (-x*sin(rotation) + y*cos(rotation)), 1)
	pixel_x += round(speed * (x*cos(rotation) + y*sin(rotation)), 1)
	var xtrans = 0
	var ytrans = 0
	while(pixel_y > 16)
		ytrans++
		pixel_y -= 32
	while(pixel_y <= -16)
		ytrans--
		pixel_y += 32
	while(pixel_x > 16)
		xtrans++
		pixel_x -= 32
	while(pixel_x <= -16)
		xtrans--
		pixel_x += 32
	translate(xtrans, ytrans)

/obj/shipturf/master/relaymove(mob/user, direct)
	switch(direct)
		if(NORTH)
			strafe(0, 1)
		if(SOUTH)
			strafe(0,-1)
		if(EAST)
			if(mode)
				translate(1, 0)
			else
				setRot(rotation + 1)
		if(WEST)
			if(mode)
				translate(-1, 0)
			else
				setRot(rotation - 1)