// Carrot
/obj/item/seeds/carrot
	name = "pack of carrot seeds"
	desc = "These seeds grow into carrots."
	icon_state = "seed-carrot"
	species = "carrot"
	plantname = "Carrots"
	product = /obj/item/weapon/reagent_containers/food/snacks/grown/carrot
	maturation = 10
	production = 1
	yield = 5
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	mutatelist = list(/obj/item/seeds/carrot/parsnip)
	reagents_add = list("oculine" = 0.5, "vitamin" = 0.08, "nutriment" = 0.1)

/obj/item/weapon/reagent_containers/food/snacks/grown/carrot
	seed = /obj/item/seeds/carrot
	name = "carrot"
	desc = "It's good for the eyes!"
	icon_state = "carrot"
	filling_color = "#FFA500"
	bitesize_mod = 2

/obj/item/weapon/reagent_containers/food/snacks/grown/carrot/attackby(obj/item/I, mob/user, params)
	if(I.is_sharp())
		user << "<span class='notice'>You sharpen the carrot into a shiv with [I].</span>"
		var/obj/item/weapon/kitchen/knife/carrotshiv/Shiv = new /obj/item/weapon/kitchen/knife/carrotshiv
		if(!remove_item_from_storage(user))
			user.unEquip(src)
		user.put_in_hands(Shiv)
		qdel(src)
	else
		return ..()

// Parsnip
/obj/item/seeds/carrot/parsnip
	name = "pack of parsnip seeds"
	desc = "These seeds grow into parsnips."
	icon_state = "seed-parsnip"
	species = "parsnip"
	plantname = "Parsnip"
	product = /obj/item/weapon/reagent_containers/food/snacks/grown/parsnip
	icon_dead = "carrot-dead"
	mutatelist = list()
	reagents_add = list("vitamin" = 0.1, "nutriment" = 0.1)

/obj/item/weapon/reagent_containers/food/snacks/grown/parsnip
	seed = /obj/item/seeds/carrot/parsnip
	name = "parsnip"
	desc = "Closely related to carrots."
	icon_state = "parsnip"
	bitesize_mod = 2


// White-Beet
/obj/item/seeds/whitebeet
	name = "pack of white-beet seeds"
	desc = "These seeds grow into sugary beet producing plants."
	icon_state = "seed-whitebeet"
	species = "whitebeet"
	plantname = "White-Beet Plants"
	product = /obj/item/weapon/reagent_containers/food/snacks/grown/whitebeet
	lifespan = 60
	endurance = 50
	yield = 6
<<<<<<< HEAD
	oneharvest = 1
=======
>>>>>>> masterTGbranch
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_dead = "whitebeet-dead"
	mutatelist = list(/obj/item/seeds/redbeet)
	reagents_add = list("vitamin" = 0.08, "sugar" = 0.4, "nutriment" = 0.1)

/obj/item/weapon/reagent_containers/food/snacks/grown/whitebeet
	seed = /obj/item/seeds/whitebeet
	name = "white-beet"
	desc = "You can't beat white-beet."
	icon_state = "whitebeet"
	filling_color = "#F4A460"
	bitesize_mod = 2

// Red Beet
/obj/item/seeds/redbeet
	name = "pack of redbeet seeds"
	desc = "These seeds grow into red beet producing plants."
	icon_state = "seed-redbeet"
	species = "redbeet"
	plantname = "Red-Beet Plants"
	product = /obj/item/weapon/reagent_containers/food/snacks/grown/redbeet
	lifespan = 60
	endurance = 50
	yield = 6
<<<<<<< HEAD
	oneharvest = 1
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_dead = "whitebeet-dead"
	reagents_add = list("vitamin" = 0.1, "nutriment" = 0.1)
=======
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_dead = "whitebeet-dead"
	genes = list(/datum/plant_gene/trait/maxchem)
	reagents_add = list("vitamin" = 0.05, "nutriment" = 0.05)
>>>>>>> masterTGbranch

/obj/item/weapon/reagent_containers/food/snacks/grown/redbeet
	seed = /obj/item/seeds/redbeet
	name = "red beet"
	desc = "You can't beat red beet."
	icon_state = "redbeet"
	bitesize_mod = 2
