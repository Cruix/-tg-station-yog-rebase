/obj/machinery/computer/camera_advanced/ship
	var/obj/shipturf/master/ship

/obj/machinery/computer/camera_advanced/ship/New()
	..()
	qdel(jump_action)
	jump_action = null

/obj/machinery/computer/camera_advanced/ship/GrantActions(mob/living/carbon/user)
	off_action.target = user
	off_action.Grant(user)

/obj/machinery/computer/camera_advanced/ship/CreateEye()
	eyeobj = new /mob/camera/aiEye/remote/ship()
	var/mob/camera/aiEye/remote/ship/shipEye = eyeobj
	shipEye.loc = get_turf(ship)
	shipEye.origin = src
	shipEye.ship = ship
	ship.linkedEyes += shipEye

/obj/machinery/computer/camera_advanced/ship/attack_hand(mob/user)
	if(!ship)
		user << "span class='warning'>Console is not linked to a ship</span>"
		return
	..()

///////////
//Eye
///////////

/mob/camera/aiEye/remote/ship
	sprint = 4
	acceleration = 0
	var/obj/shipturf/master/ship
	var/maxDist = 3
	var/turn_with_ship = 1
	var/translate_with_ship = 1

/mob/camera/aiEye/remote/ship/setLoc(T)
	var/turf/new_turf = get_turf(T)
	if(new_turf && (get_dist(ship, new_turf) <= maxDist))
		return ..()
	else
		return

/mob/camera/aiEye/remote/ship/Destroy()
	if(ship)
		ship.linkedEyes -= src

/mob/camera/aiEye/remote/ship/relaymove(mob/user, direct)
	if(istype(origin, /obj/machinery/computer/camera_advanced/ship/helm))
		var/obj/machinery/computer/camera_advanced/ship/helm/helm = origin
		if(!ship || !helm.steermode)
			..()
		else
			switch(direct)
				if(NORTH)
					ship.strafe(0, 1)
				if(SOUTH)
					ship.strafe(0,-1)
				if(EAST)
					if(helm.strafemode)
						ship.translate(1, 0)
					else
						ship.setRot(ship.rotation + 1)
				if(WEST)
					if(helm.strafemode)
						ship.translate(-1, 0)
					else
						ship.setRot(ship.rotation - 1)
	else
		..()

/////////////////////////////////////
//HELM
/////////////////////////////////////

/obj/machinery/computer/camera_advanced/ship/helm
	off_action = new /datum/action/innate/camera_off/ship_helm
	var/datum/action/innate/ship_strafemode/strafe_action = new
	var/datum/action/innate/ship_steermode/steer_action = new

	var/steermode = 1
	var/strafemode = 1

/obj/machinery/computer/camera_advanced/ship/helm/GrantActions(mob/living/carbon/user)
	..()
	strafe_action.Grant(user)
	steer_action.Grant(user)

/////////

/datum/action/innate/ship_strafemode
	name = "Toggle Strafe Mode"

/datum/action/innate/ship_strafemode/Activate()
	if(!owner || !iscarbon(owner))
		return
	var/mob/living/carbon/C = owner
	var/mob/camera/aiEye/remote/ship/remote_eye = C.remote_control
	var/obj/machinery/computer/camera_advanced/ship/helm/origin = remote_eye.origin

	origin.strafemode = !origin.strafemode

//////////

/datum/action/innate/ship_steermode
	name = "Toggle Steer Mode"

/datum/action/innate/ship_steermode/Activate()
	if(!owner || !iscarbon(owner))
		return
	var/mob/living/carbon/C = owner
	var/mob/camera/aiEye/remote/ship/remote_eye = C.remote_control
	var/obj/machinery/computer/camera_advanced/ship/helm/origin = remote_eye.origin

	origin.steermode = !origin.steermode

//////////

/datum/action/innate/camera_off/ship_helm/Activate()
	if(!target || !iscarbon(target))
		return
	var/mob/living/carbon/C = target
	var/mob/camera/aiEye/remote/ship/remote_eye = C.remote_control
	var/obj/machinery/computer/camera_advanced/ship/helm/origin = remote_eye.origin
	origin.strafe_action.Remove(target)
	origin.steer_action.Remove(target)
	..()
