area
	luminosity = 0
	MapEdge
		name = "Dense"
	Cave
		name = "Cave"
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				var/Exit = prob(0.05)
				if(M.Type != "HatesLight")
					return(1)
				if(M.Type == "HatesLight" && Night == 1 && Exit == 1)
					return(1)
			else
				return(1)
	DragonDen
		name = "Dense"
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				if(M.Race != "Dragon")
					return(1)
			else
				return(1)
	SpiderInfest
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				var/Exit = prob(0.1)
				if(M.Race != "GiantSpider")
					return(1)
				if(M.Race == "GiantSpider" && Exit != 1)
					return
				if(M.Race == "GiantSpider" && Exit == 1)
					return(1)
			else
				return(1)
	Haunted
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				var/Exit = prob(0.1)
				if(M.Race != "Skeleton")
					return(1)
				if(M.Race == "Skeleton" && Exit != 1)
					return
				if(M.Race == "Skeleton" && Exit == 1)
					return(1)
				if(M.Owner)
					return(1)
			else
				return(1)
	Shop
		Exited(atom/a)
			if(ismob(a))
				var/mob/M = a
				var/Attack = 0
				for(var/mob/Z in view(7,M))
					if(Z.Type == "Merchant")
						for(var/obj/I in M)
							if(I in Z.Selling)
								Attack = 1
						if(M.Pull)
							if(isobj(M.Pull))
								var/obj/O = M.Pull
								for(var/obj/I in O)
									if(I in Z.Selling)
										Attack = 1
						if(Attack)
							view(7,Z) << "<font color = yellow>[Z] notices [M] stealing and alerts the guards!<br>"
							for(var/mob/G in hearers(7,M))
								if(G.Faction == Z.Faction)
									if(G.Target)
										if(ismob(G.Target))
											var/mob/T = G.Target
											if(T.client == null)
												G.Target = null
									if(G.Target == null)
										G.Target = M
									if(M.name != "Unknown")
										G.HateList += M.name
				return(1)
			else
				return(1)
	Swamp
		Type = "SwampArea"
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				if(M.Type != src.Type)
					return(1)
				else
					return
			else
				return(1)
	Desert
		Type = "DesertArea"
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				if(M.Type != src.Type)
					return(1)
				else
					return
			else
				return(1)
	SnowArea
		Type = "SnowArea"
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				if(M.Type != src.Type)
					return(1)
				else
					return
			else
				return(1)
	BanditCamp
		Type = "Bandits"
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				var/Leave = prob(1)
				if(M.Type != src.Type && Leave != 1)
					return(1)
				else
					return
			else
				return(1)
	Town
		Type = "Town"
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				if(M.Type != src.Type)
					return(1)
				else
					return
			else
				return(1)
	DeepWater
		Enter(atom/a)
			if(ismob(a))
				var/mob/M = a
				if(M.client == null)
					return
				else
					return(1)
			else
				return(1)
turf
	proc
		Regrow()
			spawn(rand(300,600))
				if(src.name == "Dead Grass")
					src.name = "Grass"
					src.icon_state = "grass"

	luminosity = 1
	icon = 'terrain.dmi'
/*
	DblClick()
		if(src.density == 0 && usr.Ref)
			if(src in range(1,usr))
				var/obj/O = usr.Ref
				var/MakeSpill = 0
				if(O.ObjectTag == "Berry" && O.Type == "Dye/Ink/Food")
					MakeSpill = 1
				if(MakeSpill)
					var/obj/Misc/LiquidSplatter/LS = new
					LS.Red = O.Red
					LS.Green = O.Green
					LS.Blue = O.Blue
					LS.icon += rgb(LS.Red,LS.Green,LS.Blue)
					LS.name = "[O.ObjectTag] Splatter"
					LS.loc = locate(src.x,src.y,src.z)
					view(usr) << "<font color = yellow>[usr] empties the [O] onto the [src].<br>"
					O.ObjectTag = null
					O.Type = null
					O.overlays = null
					O.Red = 0
					O.Green = 0
					O.Blue = 0
					if(usr.InvenUp)
						usr.DeleteInventoryMenu()
						usr.CreateInventory()
					return
*/
	Title
		icon = 'Title.bmp'
		luminosity = 10
		Type = "Title"
		density = 1
	Floors
		SolidStoneFloor
			icon_state = "stone floor"
			Type = "Dark"
			luminosity = 0
			ManMade = 1 // Makes it so the AddObjects proc wont place boulders onto it
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		Grass
			icon_state = "grass"
			Click()
				if(usr.Function == "Combat")
					if(src.density)
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		GrassSnow
			icon_state = "grass-snow"
			Click()
				if(usr.Function == "Combat")
					if(src.density)
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		GrassSand
			icon_state = "grass-sand"
			Click()
				if(usr.Function == "Combat")
					if(src.density)
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		Snow
			icon_state = "snow"
			Click()
				if(usr.Function == "Combat")
					if(src.density)
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		Sky
			icon_state = "clouds"
			Type = "Hole"
			Enter(var/atom/a)
				if(src.icon_state == "clouds")
					if(isobj(a))
						var/obj/O = a
						view(6,O) << "<font color = yellow>[O] falls down from the sky!<br>"
						O.loc = locate(src.x,src.y,1)
						oview(6,O) << "<font color = yellow>[O] falls down from the sky!<br>"
					if(ismob(a))
						var/mob/M = a
						view(6,M) << "<font color = yellow>[M] falls down from the sky!<br>"
						M.loc = locate(src.x,src.y,1)
						oview(6,M) << "<font color = yellow>[M] falls down from the sky!<br>"
						if(M.Dead == 0)
							M.HitObject()
						for(var/obj/Misc/Hole/H in range(0,M))
							M.Bump(H)
				else
					if(ismob(a))
						var/mob/M = a
						if(M.density && src.density)
							return
						for(var/mob/M2 in src)
							if(M2.density && M2 != M)
								return
						for(var/obj/O in src)
							if(O.density && M.density)
								return
				return(1)
		AstralPlanes
			icon_state = "astral plane"
		Ash
			icon_state = "ash floor"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)

		Dirt
			icon_state = "dirt"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		UnderWater
			icon_state = "underwater floor"
			Type = "Water"
			New()
				var/Bubs = prob(3)
				if(Bubs)
					src.overlays += /obj/Misc/Bubbles/
			Entered(var/atom/a)
				if(ismob(a))
					var/mob/M = a
					if(M.Dead == 0)
						M.overlays += /obj/Misc/Bubbles/
						M.InWater = 2
						if(M.LastLoc)
							var/NotWater = 1
							if(istype(M.LastLoc,src.type))
								NotWater = 0
							if(NotWater)
								M.Breathe()
			Exited(var/atom/a)
				if(ismob(a))
					var/mob/M = a
					M.overlays -= /obj/Misc/Bubbles/
					M.InWater = 0
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = locate(src.x,src.y,1)
				if(usr.OnFire && usr.Fuel)
					usr.OnFire = 0
					usr.Fuel = 0
					usr.overlays -= /obj/Misc/Fire/
					view() << "<font color = yellow>[usr] jumps into the water and puts them self out!<br>"
					return
				if(usr.Function == "Interact")
					if(src in range(1,usr))
						if(src.icon_state == "underwater floor" && usr.Fainted == 0)
							if(usr.CantDoTask == 0)
								usr.CantDoTask = 1
								var/Delay = rand(100,150)
								if(usr.LeftLeg == 0)
									Delay += 25
								if(usr.RightLeg == 0)
									Delay += 25
								if(usr.RightArm == 0)
									Delay += 25
								if(usr.LeftArm == 0)
									Delay += 25
								spawn(Delay)
									if(usr)
										usr.CantDoTask = 0
								view() << "<font color = yellow>[usr] begins to swims up!<br>"
								var/Sink = 0
								Sink += usr.Weight / 5
								Sink -= usr.Strength / 4
								Sink -= usr.SwimmingSkill / 4
								var/Sinks = prob(Sink)
								if(Sinks)
									view() << "<font color = yellow>[usr] sinks back down again!<br>"
									return
								usr.loc = locate(src.x,src.y,1)
								usr.overlays -= /obj/Misc/Bubbles/
								if(usr.Dead == 0)
									usr.InWater = 1
								for(var/turf/T in range(0,usr))
									if(T.icon_state != "water")
										usr.loc = locate(src.x,src.y,3)
										if(usr.Dead == 0)
											usr.overlays += /obj/Misc/Bubbles/
										view() << "<font color = yellow>[usr] swims down again after finding no exit!<br>"
							else
								usr << "<font color = red>Must wait before trying to swim up again!<br>"
								return
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		Blood
			icon_state = "blood"
			density = 1
			Type = "Blood"
		Swamp
			icon_state = "swampy water"
			Type = "Water"
			Click()
				for(var/obj/Items/Armour/Shields/Torch/T in usr)
					if(T.Type == "Torch Lit" && T.suffix == "Equip")
						view() << "<font color = yellow>[usr] places their Torch into the water!<br>"
						usr.overlays-=image(T.icon,T.icon_state,T.ItemLayer)
						T.CarryState = "torch"
						T.EquipState = "torch equip"
						T.icon_state = T.EquipState
						T.Type = "Torch"
						usr.overlays+=image(T.icon,T.icon_state,T.ItemLayer)
						return
				if(usr.OnFire && usr.Fuel)
					usr.OnFire = 0
					usr.Fuel = 0
					usr.overlays -= /obj/Misc/Fire/
					view() << "<font color = yellow>[usr] jumps into the water and puts them self out!<br>"
					return
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		Water
			icon_state = "water"
			Type = "Water"
			Enter(var/atom/a)
				if(ismob(a))
					var/mob/M = a
					if(src.ManMade && M.InWater)
						M.InWater = 0
						M.overlays -= /obj/Misc/Swim/
					if(src.density)
						return
					for(var/atom/A in src)
						if(A.density && M.density)
							return
				return(1)
			Entered(var/atom/a)
				if(ismob(a))
					var/mob/M = a
					if(M.Dead == 0)
						M.overlays += /obj/Misc/Swim/
						M.InWater = 1
					if(src.ManMade && M.InWater)
						M.InWater = 0
						M.overlays -= /obj/Misc/Swim/
			Exited(var/atom/a)
				if(ismob(a))
					var/mob/M = a
					M.overlays -= /obj/Misc/Swim/
					M.InWater = 0
			Click()
				for(var/obj/Items/Armour/Shields/Torch/T in usr)
					if(T.Type == "Torch Lit" && T.suffix == "Equip")
						view() << "<font color = yellow>[usr] places their Torch into the water!<br>"
						usr.overlays-=image(T.icon,T.icon_state,T.ItemLayer)
						T.CarryState = "torch"
						T.EquipState = "torch equip"
						T.icon_state = T.EquipState
						T.Type = "Torch"
						usr.overlays+=image(T.icon,T.icon_state,T.ItemLayer)
						return
				if(usr.OnFire && usr.Fuel)
					usr.OnFire = 0
					usr.Fuel = 0
					usr.overlays -= /obj/Misc/Fire/
					view() << "<font color = yellow>[usr] jumps into the water and puts them self out!<br>"
					return
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src.icon_state == "water")
						if(src in range(1,usr))
							view() << "<font color = yellow>[usr] dives down into the [src]!<br>"
							usr.overlays -= /obj/Misc/Swim/
							if(usr.Dead == 0)
								usr.InWater = 2
								spawn(1)
									if(usr && usr.InWater == 2)
										usr.Breathe()
							usr.loc = locate(src.x,src.y,3)
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		StoneRoad
			icon_state = "stone road3"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		DirtRoad
			icon_state = "dirt road"
			Dura = 33
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		Sand
			icon_state = "sand"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		WoodFloor
			icon_state = "wood floor"
			Fuel = 100
			Type = "Dark"
			luminosity = 0
			ManMade = 1 // Makes it so the AddObjects proc wont place boulders onto it
			Dura = 50
			Material = "Wood"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		RedCarpet
			icon_state = "red carpet"
			Type = "Dark"
			ManMade = 1 // Makes it so the AddObjects proc wont place boulders onto it
			Dura = 33
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		LightStoneSlab
			name = "Stone Slab"
			icon_state = "light slab stone floor"
			Type = "Dark"
			luminosity = 0
			Material = "Stone"
			ManMade = 1 // Makes it so the AddObjects proc wont place boulders onto it
			Dura = 100
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		StrangeCrystalSlab
			icon_state = "strange crystal slab"
			Type = "Dark"
			luminosity = 0
			ManMade = 1 // Makes it so the AddObjects proc wont place boulders onto it
			Dura = 400
			Material = "Stone"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		StoneSlab
			icon_state = "slab stone floor"
			Type = "Dark"
			luminosity = 0
			ManMade = 1 // Makes it so the AddObjects proc wont place boulders onto it
			Dura = 100
			Material = "Stone"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		SandStoneSlab
			icon_state = "slab sandstone floor"
			Type = "Dark"
			luminosity = 0
			Material = "Stone"
			Dura = 100
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
	Walls
		MapEdge
			density = 1
			opacity = 1
		SolidDarkStone
			icon_state = "dark stone"
			Type = "Solid Wall"
			density = 1
			opacity = 1
			Dura = 100
			ManMade = 1
			Material = "Stone"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		SolidStone
			icon_state = "stone"
			Type = "Solid Wall"
			density = 1
			opacity = 1
			Dura = 800
			ManMade = 1
			Material = "Stone"
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)

		BrickWall
			icon_state = "brick wall"
			density = 1
			opacity = 1
			Material = "Stone"
			Dura = 650
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		WoodenWall
			icon_state = "wood wall"
			density = 1
			opacity = 1
			Fuel = 100
			Material = "Wood"
			Dura = 300
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		BulkyBrickWall
			icon_state = "bulky brick wall"
			density = 1
			opacity = 1
			Material = "Stone"
			Dura = 700
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		StrangeCrystalWall
			icon_state = "strange crystal wall"
			density = 1
			opacity = 1
			Material = "Stone"
			Dura = 2000
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		BulkyBrickWindow
			icon_state = "bulky brick window"
			density = 1
		ReallyBulkyBrickWall
			icon_state = "really bulky wall"
			density = 1
			opacity = 1
			Material = "Stone"
			Dura = 800
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		ReallyBulkyLightBrickWall
			icon_state = "really bulky light stone wall"
			density = 1
			opacity = 1
			Material = "Stone"
			Dura = 800
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
		ReallyBulkySandStoneWall
			icon_state = "really bulky sandstone wall"
			density = 1
			opacity = 1
			Material = "Stone"
			Dura = 800
			Click()
				if(usr.Function == "Combat")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)
				if(usr.Function == "Interact")
					if(usr.Fainted)
						usr << "<font color =red>You have fainted and cant do that!<br>"
						return
					if(usr.Stunned)
						usr << "<font color =red>You are stunned and cant do that!<br>"
						return
					usr.WallDigAttack(src)