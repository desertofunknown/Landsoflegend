mob
	Bump(atom/a)
		if(isobj(a))
			var/obj/O = a
			if(O.density && O.icon_state == "gate" && src.client == null && src.Humanoid)
				if(O.Type != "Busy")
					O.GateFunctions("Open")
			if(O.density && O.Type == "Hole" && O.GoesTo)
				src.overlays -= /obj/Misc/Swim/
				src.InWater = 0
				var/Fall = 100 - src.Agility
				if(src.client == null && src.Humanoid)
					Fall = 0
				var/Falls = prob(Fall)
				if(Falls)
					view(6,src) << "<font color = yellow>[src] falls down a Hole!<br>"
					src.Move(O.GoesTo)
					src.overlays -= /obj/Misc/Bubbles/
					src.overlays -= /obj/Misc/Swim/
					src.InWater = 0
					if(src.Dead == 0)
						src.HitObject()
				else
					if(src.client == null)
						view(6,src) << "<font color = yellow>[src] avoids the Hole!<br>"
					src.Move(O.loc)
		if(src.UnderTK)
			if(a.density && a != src.LastHit)
				src.LastHit = a
				var/mob/M = src.UnderTK
				view(6,src) << "<font color = red>[M] slams [src] into a [a]!"
				M.Sleep -= 3
				var/Dmg = M.Intelligence / 5
				if(ismob(a))
					var/mob/Z = a
					if(Z.Stunned == 0)
						var/Stun = prob(25)
						if(Stun && Z.Fainted == 0)
							Z.Stunned = 1
							Z.CanMove = 0
							Z.Stun()
							view(6,src) << "<font color=red>[Z] has been stunned!<br>"
				if(M.client)
					if(M.client.eye != M)
						M.Sleep -= 5
				if(src.Stunned == 0)
					var/Stun = prob(25)
					if(Stun && src.Fainted == 0)
						src.Stunned = 1
						src.CanMove = 0
						src.Stun()
						view(6,src) << "<font color=red>[src] has been stunned!<br>"
					if(src.Humanoid)
						if(src.Weapon)
							var/Drop = prob(100 - src.Agility * 2)
							if(Drop)
								var/obj/I = src.Weapon
								view(src) << "<font color = red>[src] loses hold of their [I]!<br>"
								src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
								I.Move(src.loc)
								I.overlays = null
								I.suffix = null
								I.icon_state = I.CarryState
								src.Weight -= I.Weight
								src.Weapon = null
								if(src.client)
									src.client.screen -= I
								if(I.Delete)
									del(I)
						if(src.Weapon2)
							var/Drop = prob(100 - src.Agility * 2)
							if(Drop)
								var/obj/I = src.Weapon2
								view(src) << "<font color = red>[src] loses hold of their [I]!<br>"
								src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
								src.overlays-=image(I.icon,"[I.icon_state] left",I.ItemLayer)
								I.Move(src.loc)
								I.overlays = null
								I.suffix = null
								I.icon_state = I.CarryState
								src.Weight -= I.Weight
								src.Weapon2 = null
								if(src.client)
									src.client.screen -= I
								if(I.Delete)
									del(I)
						if(src.LeftLeg && src.Race != "Snakeman")
							var/Harm = 33
							if(src.WLeftFoot)
								var/obj/O = src.WLeftFoot
								Harm -= O.Defence
							var/Harms = prob(Harm)
							if(Harms)
								src.Blood -= Dmg / 1.5
								src.LeftLeg -= Dmg
								if(src.LeftLeg <= 10)
									src.LeftLeg = 10
								src.AddGore("LeftLeg",src.Race)
								src.Pain += Dmg / 2
								src.Bleed()
								view(6,src) << "<font color=red>[src]'s Left Leg is hurt!"
						if(src.RightLeg && src.Race != "Snakeman")
							var/Harm = 33
							if(src.WRightFoot)
								var/obj/O = src.WRightFoot
								Harm -= O.Defence
							var/Harms = prob(Harm)
							if(Harms)
								src.Blood -= Dmg / 1.5
								src.RightLeg -= Dmg
								if(src.RightLeg <= 10)
									src.RightLeg = 10
								src.AddGore("RightLeg",src.Race)
								src.Pain += Dmg / 2
								src.Bleed()
								view(6,src) << "<font color=red>[src]'s Right Leg is hurt!"
						if(src.LeftArm)
							var/Harm = 33
							if(src.WLeftHand)
								var/obj/O = src.WLeftHand
								Harm -= O.Defence
							var/Harms = prob(Harm)
							if(Harms)
								src.Blood -= Dmg / 1.5
								src.LeftArm -= Dmg
								if(src.LeftArm <= 10)
									src.LeftArm = 10
								src.AddGore("LeftArm",src.Race)
								src.Pain += Dmg / 2
								src.Bleed()
								view(6,src) << "<font color=red>[src]'s Left Arm is hurt!"
						if(src.RightArm)
							var/Harm = 33
							if(src.WRightHand)
								var/obj/O = src.WRightHand
								Harm -= O.Defence
							var/Harms = prob(Harm)
							if(Harms)
								src.Blood -= Dmg / 1.5
								src.RightArm -= Dmg
								if(src.RightArm <= 10)
									src.RightArm = 10
								src.AddGore("RightArm",src.Race)
								src.Pain += Dmg / 2
								src.Bleed()
								view(6,src) << "<font color=red>[src]'s Right Arm is hurt!"
					else
						var/Harm = prob(50)
						if(Harm)
							view(6,src) << "<font color=red>[src] is hurt by [M]'s powers!"
							src.HP -= Dmg
							src.Blood -= Dmg / 1.5
							src.Pain += Dmg / 2
							src.Bleed()
							if(src.HP <= 0)
								view(6,src) << "<font color=red>[src] has been killed by [src.UnderTK]!<br>"
								src.Death()
								M.overlays -= /obj/Misc/SpellEffects/Dispel
		if(src.client && usr.Function == "Pull")
			if(ismob(a))
				var/mob/M = a
				if(M.client && M.suffix == null && M.Sleeping == 0)
					step(M,src.dir)
				if(M.Owner == usr)
					step(M,src.dir)
			if(isobj(a))
				var/obj/O = a
				if(O.suffix == null && O.Target == null)
					step(O,src.dir)
			if(isturf(a))
				..()
		if(src.client == null)
			if(isobj(a))
				var/obj/O = a
				if(O.suffix == null)
					step(O,src.dir)
				if(O != src.Target)
					step_rand(src)
			if(isturf(a))
				var/turf/T = a
				if(T != src.Target)
					step_rand(src)
			if(ismob(a))
				var/mob/M = a
				if(M != src.Target)
					step_rand(src)
	Click()
		if(src != usr)
			if(usr.Function == "Examine")
				if(usr.CanExamine)
					var/CanSee = 0
					if(usr.RightEye)
						CanSee = 1
					if(usr.LeftEye)
						CanSee = 1
					if(CanSee)
						usr << "<font color = teal>You take a good look at [src].<br>"
						for(var/obj/Items/Armour/Back/B in src)
							if(B.Type == "Conceals" && B.suffix == "Equip")
								usr << "<font color = teal>[src] appears to be wearing a [B], so you've little idea what else they might be wearing."
								return
						for(var/obj/Items/Armour/A in src)
							if(A.suffix == "Equip")
								usr << "<font color = teal>[src] appears to be wearing a [A]."
						for(var/obj/Items/Weapons/W in src)
							if(W.suffix == "Equip")
								usr << "<font color = teal>[src] appears to be holding a [W]."
						if(src.Bleed)
							var/ChanceBlood = 0 + usr.Intelligence * 2 + usr.FirstAidSkill
							var/ChanceToSpotBlood = 0
							ChanceToSpotBlood = prob(ChanceBlood)
							if(ChanceToSpotBlood)
								usr << "<font color = red><br>[src] appears to be [src.Bleed] bleeding.<br>"
							if(ChanceToSpotBlood == 0)
								usr << "<font color = red><br>[src] appears to be bleeding, but your not sure how bad<br>"
						var/ChanceStr = 0
						var/StrMsg = null
						ChanceStr = prob(usr.Intelligence * 3)
						if(ChanceStr)
							if(src.Strength <= usr.Strength / 1.1)
								StrMsg = "<font color = blue><br>[src] looks a tiny bit weaker than you.<br>"
							if(src.Strength <= usr.Strength / 1.2)
								StrMsg = "<font color = blue><br>[src] looks a little weaker than you.<br>"
							if(src.Strength <= usr.Strength / 1.5)
								StrMsg = "<font color = blue><br>[src] looks alot weaker than you.<br>"
							if(src.Strength <= usr.Strength / 2)
								StrMsg = "<font color = blue><br>[src] looks terribly weaker than you.<br>"
							if(src.Strength <= usr.Strength / 3)
								StrMsg = "<font color = blue><br>[src] looks pathetic compared to your strength.<br>"
							if(usr.Strength <= src.Strength / 1.1)
								StrMsg = "<font color = blue><br>[src] looks a tiny bit stronger than you.<br>"
							if(usr.Strength <= src.Strength / 1.2)
								StrMsg = "<font color = blue><br>[src] looks a little bit stronger than you.<br>"
							if(usr.Strength <= src.Strength / 1.5)
								StrMsg = "<font color = blue><br>[src] looks a alot stronger than you.<br>"
							if(usr.Strength <= src.Strength / 2)
								StrMsg = "<font color = blue><br>[src] looks immensely stronger than you.<br>"
							if(usr.Strength <= src.Strength / 3)
								StrMsg = "<font color = blue><br>[src] looks mighty compared to your strength.<br>"
							usr << "[StrMsg]"
						else
							usr << "<font color = blue><br>Your not sure how strong [src] is compared to you.<br>"
						var/ChanceEnd = 0
						var/EndMsg = null
						ChanceEnd = prob(usr.Intelligence * 3)
						if(ChanceEnd)
							if(src.Endurance <= usr.Endurance / 1.1)
								EndMsg = "<font color = blue><br>[src] looks a tiny bit less endurant than you.<br>"
							if(src.Endurance <= usr.Endurance / 1.2)
								EndMsg = "<font color = blue><br>[src] looks a little less endurant than you.<br>"
							if(src.Endurance <= usr.Endurance / 1.5)
								EndMsg = "<font color = blue><br>[src] looks alot less endurant than you.<br>"
							if(src.Endurance <= usr.Endurance / 2)
								EndMsg = "<font color = blue><br>[src] looks terribly less endurant than you.<br>"
							if(src.Endurance <= usr.Endurance / 3)
								EndMsg = "<font color = blue><br>[src] looks flimsy compared to your endurance.<br>"
							if(usr.Endurance <= src.Endurance / 1.1)
								EndMsg = "<font color = blue><br>[src] looks a tiny bit more endurant than you.<br>"
							if(usr.Endurance <= src.Endurance / 1.2)
								EndMsg = "<font color = blue><br>[src] looks a little bit more endurant than you.<br>"
							if(usr.Endurance <= src.Endurance / 1.5)
								EndMsg = "<font color = blue><br>[src] looks a alot more endurant than you.<br>"
							if(usr.Endurance <= src.Endurance / 2)
								EndMsg = "<font color = blue><br>[src] looks immensely more endurant than you.<br>"
							if(usr.Endurance <= src.Endurance / 3)
								EndMsg = "<font color = blue><br>[src] looks as tough as a mountain compared to your endurance.<br>"
							usr << "[EndMsg]"
						else
							usr << "<font color = blue><br>Your not sure how endurant [src] is compared to you.<br>"
						var/ChanceAgil = 0
						var/AgilMsg = null
						ChanceAgil = prob(usr.Intelligence * 3)
						if(ChanceAgil)
							if(src.Agility <= usr.Agility / 1.1)
								AgilMsg = "<font color = blue><br>[src] looks a tiny bit less agile than you.<br>"
							if(src.Agility <= usr.Agility / 1.2)
								AgilMsg = "<font color = blue><br>[src] looks a little less agile than you.<br>"
							if(src.Agility <= usr.Agility / 1.5)
								AgilMsg = "<font color = blue><br>[src] looks alot less agile than you.<br>"
							if(src.Agility <= usr.Agility / 2)
								AgilMsg = "<font color = blue><br>[src] looks terribly less agile than you.<br>"
							if(src.Agility <= usr.Agility / 3)
								AgilMsg = "<font color = blue><br>[src] looks slow compared to your agility.<br>"
							if(usr.Agility <= src.Agility / 1.1)
								AgilMsg = "<font color = blue><br>[src] looks a tiny bit more agile than you.<br>"
							if(usr.Agility <= src.Agility / 1.2)
								AgilMsg = "<font color = blue><br>[src] looks a little bit more agile than you.<br>"
							if(usr.Agility <= src.Agility / 1.5)
								AgilMsg = "<font color = blue><br>[src] looks a alot more agile than you.<br>"
							if(usr.Agility <= src.Agility / 2)
								AgilMsg = "<font color = blue><br>[src] looks immensely more agile than you.<br>"
							if(usr.Agility <= src.Agility / 3)
								AgilMsg = "<font color = blue><br>[src] looks super-agile compared to you.<br>"
							usr << "[AgilMsg]"
						else
							usr << "<font color = blue><br>Your not sure how agile [src] is compared to you.<br>"
						var/ChanceInt = 0
						var/IntMsg = null
						ChanceInt = prob(usr.Intelligence * 3)
						if(ChanceInt)
							if(src.Intelligence <= usr.Intelligence / 1.1)
								IntMsg = "<font color = blue><br>[src] looks a tiny bit less intelligent than you.<br>"
							if(src.Intelligence <= usr.Intelligence / 1.2)
								IntMsg = "<font color = blue><br>[src] looks a little less intelligent than you.<br>"
							if(src.Intelligence <= usr.Intelligence / 1.5)
								IntMsg = "<font color = blue><br>[src] looks alot less intelligent than you.<br>"
							if(src.Intelligence <= usr.Intelligence / 2)
								IntMsg = "<font color = blue><br>[src] looks terribly less intelligent than you.<br>"
							if(src.Intelligence <= usr.Intelligence / 3)
								IntMsg = "<font color = blue><br>[src] looks stupid compared to your intelligence.<br>"
							if(usr.Intelligence <= src.Intelligence / 1.1)
								IntMsg = "<font color = blue><br>[src] looks a tiny bit more intelligent than you.<br>"
							if(usr.Intelligence <= src.Intelligence / 1.2)
								IntMsg = "<font color = blue><br>[src] looks a little bit more intelligent than you.<br>"
							if(usr.Intelligence <= src.Intelligence / 1.5)
								IntMsg = "<font color = blue><br>[src] looks a alot more intelligent than you.<br>"
							if(usr.Intelligence <= src.Intelligence / 2)
								IntMsg = "<font color = blue><br>[src] looks immensely more intelligent than you.<br>"
							if(usr.Intelligence <= src.Intelligence / 3)
								IntMsg = "<font color = blue><br>[src] looks like a Genius compared to your intelligence.<br>"
							usr << "[IntMsg]"
						else
							usr << "<font color = blue><br>Your not sure how intelligent [src] is compared to you.<br>"
					usr.CanExamine = 0
					var/GainInt = prob(22 - usr.Intelligence / 3)
					if(GainInt && usr.Intelligence <= usr.IntCap && usr.Intelligence <= WorldIntCap && usr.Intelligence <= usr.IntelligenceMax)
						usr.Intelligence += usr.IntelligenceMulti / 4
					spawn(100)
						if(usr)
							usr.CanExamine = 1
					return
				else
					usr << "<font color = blue>Must wait a little while before Examining again.<br>"
					return
			if(usr.Function == "Combat")
				var/Display = 1
				if(usr.Target)
					if(usr.Target == src)
						Display = 0
					var/mob/m = usr.Target
					usr.client.images -= m.TargetIcon
				if(usr.Target != src)
					usr.Target = src
					if(usr.name != "Unknown")
						src.HateList += usr.name
					usr << "<b>You target [src]!<br>"
					for(var/mob/M in view(usr))
						if(M.Race == src.Race && M.Target == null && M.client == null && usr.Race == src.Race)
							var/NotEnemy = 1
							if(src.Faction in M.HateList)
								NotEnemy = 0
							if(NotEnemy == 1)
								M.Target = usr
								if(usr.name != "Unknown")
									M.HateList += usr.name
				if(src.client && Display)
					view(usr) << "<font color = yellow> ([usr.OrginalName])[usr] readies for combat while facing in [src]'s direction!<br>"
				if(src.client)
					usr.Log_player("([usr.key])[usr] - [usr.OrginalName] Targets [src] to Attack.")
				usr.client.images += src.TargetIcon
			if(usr.Function == "Pull")
				if(src.Fainted)
					if(src in range(1,usr))
						if(usr.Pull == src)
							usr.Pull = null
							if(src.Pull == usr)
								src.Pull = null
							view(usr) << "<b>[usr] stops pulling [src]<br>"
							return
						if(src.suffix == null)
							if(usr.Pull == null)
								usr.Pull = src
								src.Pull = usr
								usr.Pull()
								view(usr) << "<b>[usr] starts pulling [src]<br>"
								return
		if(usr.Function == "Interact" && usr.Ref)
			var/obj/O = usr.Ref
			if(O in usr)
				if(O.Dura >= 1 && usr.Job == null && O.suffix == "Equip" && src == usr && O.ObjectType == "Dagger" && usr.Hair && O.Type == "CutsHair")
					view(usr) << "<font color = yellow>[usr] cuts their hair!<br>"
					usr.overlays -= usr.Hair
					usr.Hair = null
					if(usr.Gender == "Female")
						var/obj/Misc/Hairs/Long/H = new
						usr.Hair = H
						if(usr.WHead == null)
							usr.overlays += usr.Hair
					return
				if(O.Dura >= 1 && usr.Job == null && O.suffix == "Equip" && src == usr && O.ObjectType == "Dagger" && usr.Beard)
					if(usr.Race == "Stahlite")
						usr << "<font color = red>Your character would rather die a thousand painful deaths than shave his own beard off, shame on you...<br>"
						return
					view(usr) << "<font color = yellow>[usr] shaves their beard off using a [O]!<br>"
					usr.overlays -= usr.Beard
					usr.Beard = null
					return
		if(src in range(1,usr))
			if(usr.Function == "Interact" && usr.Ref == null && src.client == null)
				if(usr.name in src.HateList)
					if(usr.Faction == src.Faction)
						var/CanPay = 0
						for(var/obj/Items/Currency/GoldCoin/C in usr)
							if(C.Type >= 9)
								CanPay = 1
								var/CoinsAlready = 0
								for(var/obj/Items/Currency/GoldCoin/G in src)
									CoinsAlready = 1
								if(CoinsAlready == 0)
									var/obj/Items/Currency/GoldCoin/G = new
									G.Type = 10
									C.Type -= 10
									G.CoinAdjust()
									C.CoinAdjust()
									G.Move(src)
									G.suffix = "Carried"
									G.name = "[G.Type] Gold Coins"
									C.name = "[C.Type] Gold Coins"
								else
									for(var/obj/Items/Currency/GoldCoin/G in src)
										G.Type += 10
										C.Type -= 10
										G.CoinAdjust()
										C.CoinAdjust()
										C.name = "[C.Type] Gold Coins"
										G.name = "[G.Type] Gold Coins"
								if(C.Type <= 0)
									del(C)
						if(CanPay)
							hearers(8,usr) << "<font color = yellow>[usr] pays [src] a fee of ten Gold Coins as part of a fine.<br>"
							src.HateList -= usr.name
							if(src.Target == usr)
								src.Target = null
							if(usr.Target == src)
								usr.Target = null
							return
						else
							usr << "<font color = red>You dont have enough coins to pay off your fine!<br>"
							return
		if(usr.Function == "Interact" && usr.Ref == null && src.client)
			if(src != usr)
				if(usr in range(1,src))
					if(src.Age <= 10 && usr.Age <= 10)
						range(8,usr) << "<font color = yellow>([usr.OrginalName])[usr] Asks [src], a [src.Age] year old [src.Gender], to Mate. But they are both far too young!<br>"
						usr << "<font color = teal>[src] and you, must be at least 11 to Mate!<br>"
						return
					if(src.Age <= 10)
						range(8,usr) << "<font color = yellow>([usr.OrginalName])[usr] Asks [src], a [src.Age] year old [src.Gender], to Mate. But [src] is far too young!<br>"
						usr << "<font color = teal>[src] must be at least 11 to Mate!<br>"
						return
					if(usr.Age <= 10)
						range(8,usr) << "<font color = yellow>([usr.OrginalName])[usr] Asks [src], a [src.Age] year old [src.Gender], to Mate. But [src] is far too young!<br>"
						usr << "<font color = teal>[src] must be at least 11 to Mate!<br>"
						return
					var/Mate = 0
					if(src.Gender == "Male" && usr.Gender == "Female" && usr.PregType == "Womb")
						Mate = 1
					if(src.Gender == "Female" && usr.Gender == "Male" && src.PregType == "Womb")
						Mate = 1
					if(Mate && src.client)
						var/list/menu = new()
						menu += "Yes"
						menu += "No"
						var/Result = input(src,"([usr.OrginalName])[usr] has offered to Mate with you, do you accept?", "Choose", null) in menu
						if(Result == "Yes")
							range(8,usr) << "<font color = yellow>[src] accepts [usr] in their offer to Mate, and....off they go.<br>"
							if(usr.Gender == "Female" && usr.Preg == 0)
								if(usr.PregType == "Womb")
									usr.Preg = 2
								else
									if(usr.Race == "Frogman")
										var/mob/NPC/Misc/FrogEgg/E = new
										Players += E
										E.Move(usr.loc)
										E.FatherStrength = src.Strength / 8
										E.FatherAgility = src.Agility / 8
										E.FatherEndurance = src.Endurance / 8
										E.Strength += usr.Strength / 8
										E.Endurance += usr.Endurance / 8
										E.Agility += usr.Agility / 8
										E.Preg = 2
									if(usr.Race == "Snakeman")
										var/mob/NPC/Misc/SnakeEgg/E = new
										Players += E
										E.Move(usr.loc)
										E.FatherStrength = src.Strength / 8
										E.FatherAgility = src.Agility / 8
										E.FatherEndurance = src.Endurance / 8
										E.Strength += usr.Strength / 8
										E.Endurance += usr.Endurance / 8
										E.Agility += usr.Agility / 8
										E.Preg = 2
									usr.Preg = 3
									usr.BirthTimer()
								usr.FatherStrength = src.Strength / 8
								usr.FatherAgility = src.Agility / 8
								usr.FatherEndurance = src.Endurance / 8
								return
							if(src.Gender == "Female" && src.Preg == 0 && src.client)
								if(src.PregType == "Womb")
									src.Preg = 2
								else
									if(src.Race == "Frogman")
										var/mob/NPC/Misc/FrogEgg/E = new
										Players += E
										E.Move(usr.loc)
										E.FatherStrength = usr.Strength / 8
										E.FatherAgility = usr.Agility / 8
										E.FatherEndurance = usr.Endurance / 8
										E.Strength += src.Strength / 8
										E.Endurance += src.Endurance / 8
										E.Agility += src.Agility / 8
										E.Preg = 2
									if(src.Race == "Snakeman")
										var/mob/NPC/Misc/SnakeEgg/E = new
										Players += E
										E.Move(usr.loc)
										E.FatherStrength = usr.Strength / 8
										E.FatherAgility = usr.Agility / 8
										E.FatherEndurance = usr.Endurance / 8
										E.Strength += src.Strength / 8
										E.Endurance += src.Endurance / 8
										E.Agility += src.Agility / 8
										E.Preg = 2
									src.Preg = 3
									src.BirthTimer()
								src.FatherStrength = usr.Strength / 8
								src.FatherAgility = usr.Agility / 8
								src.FatherEndurance = usr.Endurance / 8
								return
						if(Result == "No")
							range(8,usr) << "<font color = yellow>[usr] Asked [src] to Mate, but sadly, was rejected.<br>"
							return
					else
						range(8,usr) << "<font color = yellow>[usr] asked to Mate with [src], but [src] was either the same sex as them, or reproduced in a different way.<br>"
						return

	NPC
		Fuel = 100
		Misc
			NewBorn
			FrogEgg
				icon = 'misc.dmi'
				icon_state = "frog egg"
				Race = "Frogman"
				density = 0
			SnakeEgg
				icon = 'misc.dmi'
				icon_state = "snake egg"
				Race = "Snakeman"
				density = 0
		Good
			Human_Merchant
				icon = 'human.dmi'
				icon_state = "N"
				Type = "Merchant"
				name = "{NPC} Merchant"
				Race = "Human"

				Head = 110
				Torso = 110
				LeftArm = 110
				RightArm = 110
				LeftLeg = 110
				RightLeg = 110

				Skull = 110
				Brain = 110
				LeftEye = 110
				RightEye = 110
				LeftEar = 110
				RightEar = 110
				Teeth = 110
				Nose = 110
				Tongue = 110
				Throat = 110

				Heart = 110
				LeftLung = 110
				RightLung = 110
				Spleen = 110
				Intestine = 110
				LeftKidney = 110
				RightKidney = 110
				Liver = 110
				Bladder = 110
				Stomach = 110

				Strength = 25
				Agility = 25
				Endurance = 25
				Intelligence = 25

				StrengthMulti = 0.2
				AgilityMulti = 0.2
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.2

				SwordSkill = 25
				AxeSkill = 25
				SpearSkill = 25
				BluntSkill = 25
				RangedSkill = 25
				DaggerSkill = 25
				UnarmedSkill = 25

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.3
				DaggerSkillMulti = 0.3
				UnarmedSkillMulti = 0.3

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				Click()
					if(usr.Function == "Interact" && src in range(2,usr))
						if(usr.Faction in src.HateList)
							return
						if(usr.name in src.HateList)
							return
						var/CanUnderstand = 0
						var/obj/Speaking = null
						if(usr.CurrentLanguage)
							Speaking = usr.CurrentLanguage
						for(var/obj/L in src.LangKnow)
							if(L.name == Speaking.name)
								if(L.SpeakPercent > Speaking.SpeakPercent / 1.5)
									CanUnderstand = 1
									src.CurrentLanguage = usr.CurrentLanguage
						if(CanUnderstand)
							src.Speak("Greetings and welcome to my shop!",7)
							for(var/obj/I in usr)
								if(I in src.Selling)
									var/Val = 1
									if(I.Material == "Wood")
										Val += 1
									if(I.Material == "Stone")
										Val += 1
									if(I.Material == "Iron")
										Val += 10
									if(I.Material == "Copper")
										Val += 5
									if(I.Material == "Silver")
										Val += 15
									if(I.Material == "Gold")
										Val += 20
									if(I.Quality)
										Val += I.Quality / 1.5
									if(I.Defence)
										Val += I.Defence / 2
									var/RoundedVal = round(Val)
									src.Speak("Ah, I see you've chosen a [I], a fine choice indeed! That item has a total Value of about [RoundedVal] Gold Coins.",7)
									var/list/menu = new()
									menu += "Buy"
									menu += "Dont Buy"
									var/Result = input(usr,"[src] says - Would you like to purchase the [I] for [RoundedVal] Gold Coins?", "Choose", null) in menu
									if(Result == "Dont Buy")
										return
									if(Result == "Buy")
										for(var/obj/Items/Currency/GoldCoin/Gold in usr)
											if(Gold.Type >= RoundedVal)
												var/CoinsAlready = 0
												for(var/obj/Items/Currency/GoldCoin/C in src)
													CoinsAlready = 1
												if(CoinsAlready == 0)
													var/obj/Items/Currency/GoldCoin/Coin = new
													Coin.Type = RoundedVal
													Gold.Type -= RoundedVal
													Coin.CoinAdjust()
													Gold.CoinAdjust()
													Gold.Move(src)
													Coin.suffix = "Carried"
													Coin.name = "[Coin.Type] Gold Coins"
													Gold.name = "[Gold.Type] Gold Coins"
												else
													for(var/obj/Items/Currency/GoldCoin/Coin in src)
														Coin.Type += RoundedVal
														Gold.Type -= RoundedVal
														Coin.CoinAdjust()
														Gold.CoinAdjust()
														Gold.name = "[Gold.Type] Gold Coins"
														Coin.name = "[Coin.Type] Gold Coins"
												if(Gold.Type == 0)
													del(Gold)
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.CreateInventory()
												src.Selling -= I
												if(I.ObjectTag == "Weapon")
													I.CanBeCrafted = 1
												if(I.ObjectTag == "Armour")
													I.CanBeCrafted = 1
												src.Speak("Thank you, come again!.",7)
											else
												src.Speak("You dont have [RoundedVal] Gold Coins so you cant buy the [I].",7)
						else
							usr << "<font color = yellow>[src] seems to have no idea what your saying.<br>"
						return
				New()
					spawn(10)
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.Regen()
						var/Gen = rand(1,2)
						if(Gen == 1)
							src.Gender = "Male"
						if(Gen == 2)
							src.Gender = "Female"
							src.icon = 'human(F).dmi'
							src.GiveHair()
						var/obj/Items/Armour/UpperBody/LeatherVest/V = new
						src.WUpperBody = V
						V.suffix = "Equip"
						V.Move(src)
						var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.Move(src)
						var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
						src.WLeftFoot = LBL
						LBL.suffix = "Equip"
						LBL.Move(src)
						var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
						src.WRightFoot = LBR
						LBR.suffix = "Equip"
						LBR.Move(src)
						var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
						src.WLeftHand = LGL
						LGL.suffix = "Equip"
						LGL.Move(src)
						var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
						src.WRightHand = LGR
						LGR.suffix = "Equip"
						LGR.Move(src)
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
						src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
						src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
						src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						src.overlays+=image(V.icon,V.icon_state,V.ItemLayer)
						src.GiveRaceLanguages()
						src.Selling = list()
						for(var/obj/Items/It in oview(7,src))
							var/Add = 1
							if(It in src.Selling)
								Add = 0
							if(Add)
								src.Selling += It
			Human_Villager_Black
				icon = 'human black.dmi'
				icon_state = "N"
				Type = "Town"
				Race = "Human"

				Head = 110
				Torso = 110
				LeftArm = 110
				RightArm = 110
				LeftLeg = 110
				RightLeg = 110

				Skull = 110
				Brain = 110
				LeftEye = 110
				RightEye = 110
				LeftEar = 110
				RightEar = 110
				Teeth = 110
				Nose = 110
				Tongue = 110
				Throat = 110

				Heart = 110
				LeftLung = 110
				RightLung = 110
				Spleen = 110
				Intestine = 110
				LeftKidney = 110
				RightKidney = 110
				Liver = 110
				Bladder = 110
				Stomach = 110

				Strength = 8
				Agility = 8
				Endurance = 8
				Intelligence = 6

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.2

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.5
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.3
				DaggerSkillMulti = 0.3
				UnarmedSkillMulti = 0.3

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.Regen()
					src.AnimalAI()
					src.GiveName()
					var/Gen = rand(1,2)
					if(Gen == 1)
						src.Gender = "Male"
					if(Gen == 2)
						src.Gender = "Female"
						src.icon = 'human black(F).dmi'
						src.GiveHair()
					var/obj/Items/Armour/Chest/DesertRobe/LV = new
					src.WChest = LV
					LV.suffix = "Equip"
					LV.Move(src)
					var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.Move(src)
					var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
					src.WLeftFoot = LBL
					LBL.suffix = "Equip"
					LBL.Move(src)
					var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
					src.WRightFoot = LBR
					LBR.suffix = "Equip"
					LBR.Move(src)
					var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
					src.WLeftHand = LGL
					LGL.suffix = "Equip"
					LGL.Move(src)
					var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
					src.WRightHand = LGR
					LGR.suffix = "Equip"
					LGR.Move(src)
					for(var/obj/Items/Z in src)
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer
					src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
					src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
					src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
					src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
					var/obj/Items/Currency/GoldCoin/Gold = new
					Gold.Move(src)
					Gold.suffix = "Carried"
					Gold.Type = rand(2,5)
					Gold.name = "[Gold.Type] Gold Coins"
					Gold.CoinAdjust()
			Human_Villager_Black
				icon = 'human black.dmi'
				icon_state = "N"
				Type = "Town"
				Race = "Human"

				Head = 110
				Torso = 110
				LeftArm = 110
				RightArm = 110
				LeftLeg = 110
				RightLeg = 110

				Skull = 110
				Brain = 110
				LeftEye = 110
				RightEye = 110
				LeftEar = 110
				RightEar = 110
				Teeth = 110
				Nose = 110
				Tongue = 110
				Throat = 110

				Heart = 110
				LeftLung = 110
				RightLung = 110
				Spleen = 110
				Intestine = 110
				LeftKidney = 110
				RightKidney = 110
				Liver = 110
				Bladder = 110
				Stomach = 110

				Strength = 8
				Agility = 8
				Endurance = 8
				Intelligence = 6

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.2

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.5
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.3
				DaggerSkillMulti = 0.3
				UnarmedSkillMulti = 0.3

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.Regen()
					src.AnimalAI()
					src.GiveName()
					var/Gen = rand(1,2)
					if(Gen == 1)
						src.Gender = "Male"
					if(Gen == 2)
						src.Gender = "Female"
						src.icon = 'human black(F).dmi'
						src.GiveHair()
					var/obj/Items/Armour/Chest/DesertRobe/LV = new
					src.WChest = LV
					LV.suffix = "Equip"
					LV.Move(src)
					var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.Move(src)
					var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
					src.WLeftFoot = LBL
					LBL.suffix = "Equip"
					LBL.Move(src)
					var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
					src.WRightFoot = LBR
					LBR.suffix = "Equip"
					LBR.Move(src)
					var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
					src.WLeftHand = LGL
					LGL.suffix = "Equip"
					LGL.Move(src)
					var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
					src.WRightHand = LGR
					LGR.suffix = "Equip"
					LGR.Move(src)
					for(var/obj/Items/Z in src)
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer
					src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
					src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
					src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
					src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
			Human_Villager
				icon = 'human.dmi'
				icon_state = "N"
				Type = "Town"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 7
				Agility = 7
				Endurance = 7
				Intelligence = 7

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.35

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.5
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.3
				DaggerSkillMulti = 0.3
				UnarmedSkillMulti = 0.3

				Blood = 100
				BloodMax = 100
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.Regen()
					src.AnimalAI()
					src.GiveName()
					var/Gen = rand(1,2)
					if(Gen == 1)
						src.Gender = "Male"
					if(Gen == 2)
						src.Gender = "Female"
						src.icon = 'human(F).dmi'
					src.GiveHair()
					var/obj/Items/Weapons/Blunts/Shovel/S = new
					S.Material = "Iron"
					S.RandomItemQuality()
					src.Weapon = S
					S.suffix = "Equip"
					S.Move(src)
					var/obj/Items/Armour/UpperBody/LeatherVest/LV = new
					src.WChest = LV
					LV.suffix = "Equip"
					LV.Move(src)
					var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.Move(src)
					var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
					src.WLeftFoot = LBL
					LBL.suffix = "Equip"
					LBL.Move(src)
					var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
					src.WRightFoot = LBR
					LBR.suffix = "Equip"
					LBR.Move(src)
					var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
					src.WLeftHand = LGL
					LGL.suffix = "Equip"
					LGL.Move(src)
					var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
					src.WRightHand = LGR
					LGR.suffix = "Equip"
					LGR.Move(src)
					for(var/obj/Items/Z in src)
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer
					src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
					src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
					src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
					src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					var/obj/Items/Currency/GoldCoin/Gold = new
					Gold.Move(src)
					Gold.suffix = "Carried"
					Gold.Type = rand(2,5)
					Gold.name = "[Gold.Type] Gold Coins"
					Gold.CoinAdjust()
			Human_Guardsman_Patrol
				name = "Human Guardsman"
				icon = 'human.dmi'
				icon_state = "N"
				Type = "Town"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 50
				Agility = 50
				Endurance = 50
				Intelligence = 50

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 50
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 50

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/Gen = rand(1,2)
					if(Gen == 1)
						src.Gender = "Male"
					if(Gen == 2)
						src.Gender = "Female"
						src.icon = 'human(F).dmi'
					src.GiveHair()
					if(src.Hair)
						src.overlays -= src.Hair
					var/obj/Items/Weapons/Spears/Spear/S = new
					var/obj/Items/Armour/Head/PlateHelmet/H = new
					var/obj/Items/Armour/Chest/ChainShirt/R = new
					var/obj/Items/Armour/Legs/ChainLeggings/L = new
					var/obj/Items/Armour/UpperBody/ChestPlate/C = new
					var/obj/Items/Armour/Shoulders/PlatePauldrons/P = new
					var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
					var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
					var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
					var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new
					var/obj/Items/Armour/Shields/Shield/IS = new

					R.Move(src)
					C.Move(src)
					LG.Move(src)
					RG.Move(src)
					LB.Move(src)
					RB.Move(src)
					S.Move(src)
					H.Move(src)
					P.Move(src)
					L.Move(src)
					IS.Move(src)

					L.Material = "Iron"
					L.RandomItemQuality()
					R.Material = "Iron"
					R.RandomItemQuality()
					H.Material = "Iron"
					H.RandomItemQuality()
					LG.Material = "Iron"
					LG.RandomItemQuality()
					LB.Material = "Iron"
					LB.RandomItemQuality()
					RG.Material = "Iron"
					RG.RandomItemQuality()
					RB.Material = "Iron"
					RB.RandomItemQuality()
					IS.Material = "Iron"
					IS.RandomItemQuality()
					P.Material = "Iron"
					P.RandomItemQuality()
					C.Material = "Iron"
					C.RandomItemQuality()


					R.suffix = "Equip"
					C.suffix = "Equip"
					LG.suffix = "Equip"
					RG.suffix = "Equip"
					LB.suffix = "Equip"
					RB.suffix = "Equip"
					P.suffix = "Equip"
					H.suffix = "Equip"
					S.suffix = "Equip"
					L.suffix = "Equip"
					IS.suffix = "Equip"
					IS.EquipState = "[IS.EquipState] left"

					S.Material = "Iron"
					S.RandomItemQuality()

					src.WChest = R
					src.WUpperBody = C
					src.WShoulders = P
					src.WLeftHand = LG
					src.WRightHand = RG
					src.WLeftFoot = LB
					src.WRightFoot = RB
					src.WHead = H
					src.WLegs = L
					src.Weapon = S
					src.Weapon2 = IS
					for(var/obj/Items/Z in src)
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer
					src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
					src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
					src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
					src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
					src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
					src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
					src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
					src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
					src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)

					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.NormalAI()
					src.Regen()
					src.GiveName()

			Altherian_Priest_of_Wisdom
				icon = 'elf.dmi'
				Type = "Town"
				icon_state = "N"
				Race = "Alther"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 55
				Agility = 65
				Endurance = 55
				Intelligence = 60

				StrengthMulti = 0.3
				AgilityMulti = 0.5
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.5

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 60
				ShieldSkill = 5

				SwordSkillMulti = 0.4
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.3
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 120
				BloodMax = 120
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Altherian Empire"

				HateList = list("Illithid Cultists","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Human Empire Unholy")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							src.GiveHair("NoBald")
							var/Gen = rand(1,2)
							if(Gen == 1)
								src.Gender = "Male"
							if(Gen == 2)
								src.Gender = "Female"
								src.icon = 'elf(F).dmi'
							var/obj/Items/Armour/Chest/KingsRobe/R = new
							var/obj/Items/Armour/Legs/ChainLeggings/L = new
							var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
							var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new

							R.Move(src)
							LB.Move(src)
							RB.Move(src)
							L.Move(src)

							R.Material = "Cloth"
							R.Defence = 3
							L.Material = "Iron"
							L.RandomItemQuality()
							RB.Material = "Iron"
							RB.RandomItemQuality()
							LB.Material = "Iron"
							LB.RandomItemQuality()


							R.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"
							L.suffix = "Equip"

							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer

							src.WChest = R
							src.WLeftFoot = LB
							src.WRightFoot = RB
							src.WLegs = L

							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)

							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
							src.GiveName()
							src.Ressurect()
							src.name = "[src.name] The Priest"
			Altherian_Guardsman
				icon = 'elf.dmi'
				icon_state = "N"
				Race = "Alther"

				Head = 80
				Torso = 80
				LeftArm = 80
				RightArm = 80
				LeftLeg = 80
				RightLeg = 80

				Skull = 80
				Brain = 80
				LeftEye = 80
				RightEye = 80
				LeftEar = 80
				RightEar = 80
				Teeth = 80
				Nose = 80
				Tongue = 80
				Throat = 80

				Heart = 80
				LeftLung = 80
				RightLung = 80
				Spleen = 80
				Intestine = 80
				LeftKidney = 80
				RightKidney = 80
				Liver = 80
				Bladder = 80
				Stomach = 80

				Strength = 45
				Agility = 55
				Endurance = 45
				Intelligence = 60

				StrengthMulti = 0.2
				AgilityMulti = 0.4
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.4

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 50
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 50

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.3
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Altherian Empire"

				HateList = list("Illithid Cultists","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Human Empire Unholy")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/Gen = rand(1,2)
							if(Gen == 1)
								src.Gender = "Male"
							if(Gen == 2)
								src.Gender = "Female"
								src.icon = 'elf(F).dmi'
							src.GiveHair("NoBald")
							var/obj/Items/Weapons/Spears/Spear/S = new
							var/obj/Items/Armour/Chest/ChainShirt/R = new
							var/obj/Items/Armour/Legs/ChainLeggings/L = new
							var/obj/Items/Armour/UpperBody/ChestPlate/C = new
							var/obj/Items/Armour/Shoulders/PlatePauldrons/P = new
							var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
							var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
							var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
							var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new
							var/obj/Items/Armour/Shields/Shield/IS = new

							R.Move(src)
							C.Move(src)
							LG.Move(src)
							RG.Move(src)
							LB.Move(src)
							RB.Move(src)
							S.Move(src)
							P.Move(src)
							L.Move(src)
							IS.Move(src)

							R.Material = "Iron"
							R.RandomItemQuality()
							LG.Material = "Iron"
							LG.RandomItemQuality()
							L.Material = "Iron"
							L.RandomItemQuality()
							RG.Material = "Iron"
							RG.RandomItemQuality()
							RB.Material = "Iron"
							RB.RandomItemQuality()
							IS.Material = "Iron"
							IS.RandomItemQuality()
							P.Material = "Iron"
							P.RandomItemQuality()
							C.Material = "Iron"
							C.RandomItemQuality()
							LB.Material = "Iron"
							LB.RandomItemQuality()


							R.suffix = "Equip"
							C.suffix = "Equip"
							LG.suffix = "Equip"
							RG.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"
							P.suffix = "Equip"
							S.suffix = "Equip"
							L.suffix = "Equip"
							IS.suffix = "Equip"
							IS.EquipState = "[IS.EquipState] left"

							S.Material = "Iron"
							S.RandomItemQuality()

							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer

							src.WChest = R
							src.WUpperBody = C
							src.WShoulders = P
							src.WLeftHand = LG
							src.WRightHand = RG
							src.WLeftFoot = LB
							src.WRightFoot = RB
							src.WLegs = L
							src.Weapon = S
							src.Weapon2 = IS

							src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
							src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)

							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
							src.GiveName()
			Altherian_Merchant
				icon = 'elf.dmi'
				icon_state = "N"
				Type = "Merchant"
				name = "{NPC} Merchant"
				Race = "Alther"

				Head = 110
				Torso = 110
				LeftArm = 110
				RightArm = 110
				LeftLeg = 110
				RightLeg = 110

				Skull = 110
				Brain = 110
				LeftEye = 110
				RightEye = 110
				LeftEar = 110
				RightEar = 110
				Teeth = 110
				Nose = 110
				Tongue = 110
				Throat = 110

				Heart = 110
				LeftLung = 110
				RightLung = 110
				Spleen = 110
				Intestine = 110
				LeftKidney = 110
				RightKidney = 110
				Liver = 110
				Bladder = 110
				Stomach = 110

				Strength = 20
				Agility = 30
				Endurance = 20
				Intelligence = 25

				StrengthMulti = 0.2
				AgilityMulti = 0.2
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.2

				SwordSkill = 25
				AxeSkill = 25
				SpearSkill = 25
				BluntSkill = 25
				RangedSkill = 25
				DaggerSkill = 25
				UnarmedSkill = 25

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.3
				DaggerSkillMulti = 0.3
				UnarmedSkillMulti = 0.3

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/
				Faction = "Altherian Empire"

				HateList = list("Illithid Cultists","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Human Empire Unholy")
				Click()
					if(usr.Function == "Interact" && src in range(2,usr))
						if(usr.Faction in src.HateList)
							return
						if(usr.name in src.HateList)
							return
						var/CanUnderstand = 0
						var/obj/Speaking = null
						if(usr.CurrentLanguage)
							Speaking = usr.CurrentLanguage
						for(var/obj/L in src.LangKnow)
							if(L.name == Speaking.name)
								if(L.SpeakPercent > Speaking.SpeakPercent / 1.5)
									CanUnderstand = 1
									src.CurrentLanguage = usr.CurrentLanguage
						if(CanUnderstand)
							src.Speak("Greetings and welcome to my shop!",7)
							for(var/obj/I in usr)
								if(I in src.Selling)
									var/Val = 1
									if(I.Material == "Wood")
										Val += 1
									if(I.Material == "Stone")
										Val += 1
									if(I.Material == "Iron")
										Val += 10
									if(I.Material == "Copper")
										Val += 5
									if(I.Material == "Silver")
										Val += 15
									if(I.Material == "Gold")
										Val += 20
									if(I.Quality)
										Val += I.Quality / 1.5
									if(I.Defence)
										Val += I.Defence / 2
									var/RoundedVal = round(Val)
									src.Speak("Ah, I see you've chosen a [I], a fine choice indeed! That item has a total Value of about [RoundedVal] Gold Coins.",7)
									var/list/menu = new()
									menu += "Buy"
									menu += "Dont Buy"
									var/Result = input(usr,"[src] says - Would you like to purchase the [I] for [RoundedVal] Gold Coins?", "Choose", null) in menu
									if(Result == "Dont Buy")
										return
									if(Result == "Buy")
										for(var/obj/Items/Currency/GoldCoin/Gold in usr)
											if(Gold.Type >= RoundedVal)
												var/CoinsAlready = 0
												for(var/obj/Items/Currency/GoldCoin/C in src)
													CoinsAlready = 1
												if(CoinsAlready == 0)
													var/obj/Items/Currency/GoldCoin/Coin = new
													Coin.Type = RoundedVal
													Gold.Type -= RoundedVal
													Coin.CoinAdjust()
													Gold.CoinAdjust()
													Coin.Move(src)
													Coin.suffix = "Carried"
													Coin.name = "[Coin.Type] Gold Coins"
													Gold.name = "[Gold.Type] Gold Coins"
												else
													for(var/obj/Items/Currency/GoldCoin/Coin in src)
														Coin.Type += RoundedVal
														Gold.Type -= RoundedVal
														Coin.CoinAdjust()
														Gold.CoinAdjust()
														Gold.name = "[Gold.Type] Gold Coins"
														Coin.name = "[Coin.Type] Gold Coins"
												if(Gold.Type == 0)
													del(Gold)
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.CreateInventory()
												src.Selling -= I
												if(I.ObjectTag == "Weapon")
													I.CanBeCrafted = 1
												if(I.ObjectTag == "Armour")
													I.CanBeCrafted = 1
												src.Speak("Thank you, come again!.",7)
											else
												src.Speak("You dont have [RoundedVal] Gold Coins so you cant buy the [I].",7)
						else
							usr << "<font color = yellow>[src] seems to have no idea what your saying.<br>"
						return
				New()
					spawn(10)
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.Regen()
						var/Gen = rand(1,2)
						if(Gen == 1)
							src.Gender = "Male"
						if(Gen == 2)
							src.Gender = "Female"
							src.icon = 'elf(F).dmi'
							src.GiveHair()
						var/obj/Items/Armour/UpperBody/LeatherVest/V = new
						src.WUpperBody = V
						V.suffix = "Equip"
						V.Move(src)
						var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.Move(src)
						var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
						src.WLeftFoot = LBL
						LBL.suffix = "Equip"
						LBL.Move(src)
						var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
						src.WRightFoot = LBR
						LBR.suffix = "Equip"
						LBR.Move(src)
						var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
						src.WLeftHand = LGL
						LGL.suffix = "Equip"
						LGL.Move(src)
						var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
						src.WRightHand = LGR
						LGR.suffix = "Equip"
						LGR.Move(src)
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
						src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
						src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
						src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						src.overlays+=image(V.icon,V.icon_state,V.ItemLayer)
						src.GiveRaceLanguages()
						src.Selling = list()
						for(var/obj/Items/It in oview(7,src))
							var/Add = 1
							if(It in src.Selling)
								Add = 0
							if(Add)
								src.Selling += It
			Altherian_Ancient_Patrol
				icon = 'elf.dmi'
				icon_state = "N"
				Type = "Town"
				Race = "Alther"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 50
				Agility = 65
				Endurance = 45
				Intelligence = 50

				StrengthMulti = 0.2
				AgilityMulti = 0.4
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.4

				SwordSkill = 60
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 60
				ShieldSkill = 6

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.3
				ShieldSkillMulti = 0.2

				luminosity = 4

				Blood = 100
				BloodMax = 100
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Altherian Empire"

				HateList = list("Illithid Cultists","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Human Empire Unholy")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/Gen = rand(1,2)
					if(Gen == 1)
						src.Gender = "Male"
					if(Gen == 2)
						src.Gender = "Female"
						src.icon = 'elf(F).dmi'
					src.GiveHair("NoBald")
					var/obj/Items/Weapons/Swords/LongSword/S = new
					var/obj/Items/Armour/Chest/ChainShirt/R = new
					var/obj/Items/Armour/Legs/ChainLeggings/L = new
					var/obj/Items/Armour/UpperBody/ChestPlate/C = new
					var/obj/Items/Armour/Shoulders/PlatePauldrons/P = new
					var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
					var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
					var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
					var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new
					var/obj/Items/Armour/Back/ClothCape/CA = new
					var/obj/Items/Armour/Shields/Torch/T = new

					R.Move(src)
					C.Move(src)
					LG.Move(src)
					RG.Move(src)
					LB.Move(src)
					RB.Move(src)
					S.Move(src)
					P.Move(src)
					L.Move(src)
					CA.Move(src)

					R.Material = "Gold"
					R.RandomItemQuality()
					LG.Material = "Gold"
					LG.RandomItemQuality()
					L.Material = "Gold"
					L.RandomItemQuality()
					RG.Material = "Gold"
					RG.RandomItemQuality()
					RB.Material = "Gold"
					RB.RandomItemQuality()
					P.Material = "Gold"
					P.RandomItemQuality()
					C.Material = "Gold"
					C.RandomItemQuality()
					LB.Material = "Gold"
					LB.RandomItemQuality()


					R.suffix = "Equip"
					C.suffix = "Equip"
					LG.suffix = "Equip"
					RG.suffix = "Equip"
					LB.suffix = "Equip"
					RB.suffix = "Equip"
					P.suffix = "Equip"
					S.suffix = "Equip"
					L.suffix = "Equip"
					CA.suffix = "Equip"

					S.Material = "Iron"
					S.RandomItemQuality()
					T.EquipState = "torch lit equip"
					T.Type = "Torch Lit"
					T.EquipState = "[T.EquipState] left"
					src.Weapon2 = T

					for(var/obj/Items/Z in src)
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer

					src.WChest = R
					src.WUpperBody = C
					src.WShoulders = P
					src.WLeftHand = LG
					src.WRightHand = RG
					src.WLeftFoot = LB
					src.WRightFoot = RB
					src.WLegs = L
					src.WBack = CA
					src.Weapon = S

					src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
					src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
					src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
					src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
					src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
					src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
					src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
					src.overlays+=image(CA.icon,CA.icon_state,CA.ItemLayer)

					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.InquisitiveAI()
					src.Regen()
					src.GiveName()
			Altherian_Guardsman_Patrol
				icon = 'elf.dmi'
				icon_state = "N"
				Type = "Town"
				Race = "Alther"

				Head = 80
				Torso = 80
				LeftArm = 80
				RightArm = 80
				LeftLeg = 80
				RightLeg = 80

				Skull = 80
				Brain = 80
				LeftEye = 80
				RightEye = 80
				LeftEar = 80
				RightEar = 80
				Teeth = 80
				Nose = 80
				Tongue = 80
				Throat = 80

				Heart = 80
				LeftLung = 80
				RightLung = 80
				Spleen = 80
				Intestine = 80
				LeftKidney = 80
				RightKidney = 80
				Liver = 80
				Bladder = 80
				Stomach = 80

				Strength = 45
				Agility = 55
				Endurance = 45
				Intelligence = 60

				StrengthMulti = 0.2
				AgilityMulti = 0.4
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.4

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 50
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 50

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.3
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Altherian Empire"

				HateList = list("Illithid Cultists","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Human Empire Unholy")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					src.GiveHair("NoBald")
					var/Gen = rand(1,2)
					if(Gen == 1)
						src.Gender = "Male"
					if(Gen == 2)
						src.Gender = "Female"
						src.icon = 'elf(F).dmi'
					var/obj/Items/Weapons/Spears/Spear/S = new
					var/obj/Items/Armour/Chest/ChainShirt/R = new
					var/obj/Items/Armour/Legs/ChainLeggings/L = new
					var/obj/Items/Armour/UpperBody/ChestPlate/C = new
					var/obj/Items/Armour/Shoulders/PlatePauldrons/P = new
					var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
					var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
					var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
					var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new
					var/obj/Items/Armour/Shields/Shield/IS = new

					R.Move(src)
					C.Move(src)
					LG.Move(src)
					RG.Move(src)
					LB.Move(src)
					RB.Move(src)
					S.Move(src)
					P.Move(src)
					L.Move(src)
					IS.Move(src)

					R.Material = "Iron"
					R.RandomItemQuality()
					LG.Material = "Iron"
					LG.RandomItemQuality()
					L.Material = "Iron"
					L.RandomItemQuality()
					RG.Material = "Iron"
					RG.RandomItemQuality()
					RB.Material = "Iron"
					RB.RandomItemQuality()
					IS.Material = "Iron"
					IS.RandomItemQuality()
					P.Material = "Iron"
					P.RandomItemQuality()
					C.Material = "Iron"
					C.RandomItemQuality()
					LB.Material = "Iron"
					LB.RandomItemQuality()


					R.suffix = "Equip"
					C.suffix = "Equip"
					LG.suffix = "Equip"
					RG.suffix = "Equip"
					LB.suffix = "Equip"
					RB.suffix = "Equip"
					P.suffix = "Equip"
					S.suffix = "Equip"
					L.suffix = "Equip"
					IS.suffix = "Equip"
					IS.EquipState = "[IS.EquipState] left"

					S.Material = "Iron"
					S.RandomItemQuality()

					for(var/obj/Items/Z in src)
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer

					src.WChest = R
					src.WUpperBody = C
					src.WShoulders = P
					src.WLeftHand = LG
					src.WRightHand = RG
					src.WLeftFoot = LB
					src.WRightFoot = RB
					src.WLegs = L
					src.Weapon = S
					src.Weapon2 = IS

					src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
					src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
					src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
					src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
					src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
					src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
					src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
					src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)

					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.NormalAI()
					src.Regen()
					src.GiveName()
			Human_Black_Guardsman_Patrol
				icon = 'human black.dmi'
				icon_state = "N"
				Race = "Human"
				Type = "Town"

				Head = 110
				Torso = 110
				LeftArm = 110
				RightArm = 110
				LeftLeg = 110
				RightLeg = 110

				Skull = 110
				Brain = 110
				LeftEye = 110
				RightEye = 110
				LeftEar = 110
				RightEar = 110
				Teeth = 110
				Nose = 110
				Tongue = 110
				Throat = 110

				Heart = 110
				LeftLung = 110
				RightLung = 110
				Spleen = 110
				Intestine = 110
				LeftKidney = 110
				RightKidney = 110
				Liver = 110
				Bladder = 110
				Stomach = 110

				Strength = 55
				Agility = 55
				Endurance = 55
				Intelligence = 45

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.2

				SwordSkill = 60
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 5

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 120
				BloodMax = 120
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/Gen = rand(1,2)
							if(Gen == 1)
								src.Gender = "Male"
								var/obj/Items/Armour/Head/Turban/T = new
								T.Move(src)
								T.suffix = "Equip"
								src.WHead = T
								T.icon_state = T.EquipState
								T.layer = T.ItemLayer
								src.overlays+=image(T.icon,T.icon_state,T.ItemLayer)
							if(Gen == 2)
								src.Gender = "Female"
								src.icon = 'human black(F).dmi'
								src.GiveHair()
							var/obj/Items/Weapons/Swords/Scimitar/S = new
							var/obj/Items/Armour/Chest/DesertRobe/R = new
							var/obj/Items/Armour/Legs/ChainLeggings/L = new
							var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
							var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
							var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
							var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new

							R.Move(src)
							LG.Move(src)
							RG.Move(src)
							LB.Move(src)
							RB.Move(src)
							S.Move(src)
							L.Move(src)

							LG.Material = "Iron"
							LG.RandomItemQuality()
							L.Material = "Iron"
							L.RandomItemQuality()
							RG.Material = "Iron"
							RG.RandomItemQuality()
							RB.Material = "Iron"
							RB.RandomItemQuality()
							LB.Material = "Iron"
							LB.RandomItemQuality()


							R.suffix = "Equip"
							LG.suffix = "Equip"
							RG.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"
							S.suffix = "Equip"
							L.suffix = "Equip"

							S.Material = "Iron"
							S.RandomItemQuality()

							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer

							src.WChest = R
							src.WLeftHand = LG
							src.WRightHand = RG
							src.WLeftFoot = LB
							src.WRightFoot = RB
							src.WLegs = L
							src.Weapon = S

							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)

							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.NormalAI()
							src.Regen()
							src.GiveName()
			Human_Black_Guardsman
				icon = 'human black.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 110
				Torso = 110
				LeftArm = 110
				RightArm = 110
				LeftLeg = 110
				RightLeg = 110

				Skull = 110
				Brain = 110
				LeftEye = 110
				RightEye = 110
				LeftEar = 110
				RightEar = 110
				Teeth = 110
				Nose = 110
				Tongue = 110
				Throat = 110

				Heart = 110
				LeftLung = 110
				RightLung = 110
				Spleen = 110
				Intestine = 110
				LeftKidney = 110
				RightKidney = 110
				Liver = 110
				Bladder = 110
				Stomach = 110

				Strength = 55
				Agility = 55
				Endurance = 55
				Intelligence = 45

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.2

				SwordSkill = 60
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 5

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 120
				BloodMax = 120
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/Gen = rand(1,2)
							if(Gen == 1)
								src.Gender = "Male"
								var/obj/Items/Armour/Head/Turban/T = new
								T.Move(src)
								T.suffix = "Equip"
								src.WHead = T
								T.icon_state = T.EquipState
								T.layer = T.ItemLayer
								src.overlays+=image(T.icon,T.icon_state,T.ItemLayer)
							if(Gen == 2)
								src.Gender = "Female"
								src.icon = 'human black(F).dmi'
								src.GiveHair()
							var/obj/Items/Weapons/Swords/Scimitar/S = new
							var/obj/Items/Armour/Chest/DesertRobe/R = new
							var/obj/Items/Armour/Legs/ChainLeggings/L = new
							var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
							var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
							var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
							var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new
							R.Move(src)
							LG.Move(src)
							RG.Move(src)
							LB.Move(src)
							RB.Move(src)
							S.Move(src)
							L.Move(src)

							LG.Material = "Iron"
							LG.RandomItemQuality()
							L.Material = "Iron"
							L.RandomItemQuality()
							RG.Material = "Iron"
							RG.RandomItemQuality()
							RB.Material = "Iron"
							RB.RandomItemQuality()
							LB.Material = "Iron"
							LB.RandomItemQuality()

							R.suffix = "Equip"
							LG.suffix = "Equip"
							RG.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"
							S.suffix = "Equip"
							L.suffix = "Equip"

							S.Material = "Iron"
							S.RandomItemQuality()

							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer

							src.WChest = R
							src.WLeftHand = LG
							src.WRightHand = RG
							src.WLeftFoot = LB
							src.WRightFoot = RB
							src.WLegs = L
							src.Weapon = S

							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)

							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
							src.GiveName()
			Human_Guardsman
				icon = 'human.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 50
				Agility = 50
				Endurance = 50
				Intelligence = 50

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 50
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 50

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/Gen = rand(1,2)
							if(Gen == 1)
								src.Gender = "Male"
							if(Gen == 2)
								src.Gender = "Female"
								src.icon = 'human(F).dmi'
							src.GiveHair()
							if(src.Hair)
								src.overlays -= src.Hair
							var/obj/Items/Weapons/Spears/Spear/S = new
							var/obj/Items/Armour/Head/PlateHelmet/H = new
							var/obj/Items/Armour/Chest/ChainShirt/R = new
							var/obj/Items/Armour/Legs/ChainLeggings/L = new
							var/obj/Items/Armour/UpperBody/ChestPlate/C = new
							var/obj/Items/Armour/Shoulders/PlatePauldrons/P = new
							var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
							var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
							var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
							var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new
							var/obj/Items/Armour/Shields/Shield/IS = new

							R.Move(src)
							C.Move(src)
							LG.Move(src)
							RG.Move(src)
							LB.Move(src)
							RB.Move(src)
							S.Move(src)
							H.Move(src)
							P.Move(src)
							L.Move(src)
							IS.Move(src)

							R.Material = "Iron"
							R.RandomItemQuality()
							H.Material = "Iron"
							H.RandomItemQuality()
							LG.Material = "Iron"
							LG.RandomItemQuality()
							L.Material = "Iron"
							L.RandomItemQuality()
							RG.Material = "Iron"
							RG.RandomItemQuality()
							RB.Material = "Iron"
							RB.RandomItemQuality()
							IS.Material = "Iron"
							IS.RandomItemQuality()
							P.Material = "Iron"
							P.RandomItemQuality()
							C.Material = "Iron"
							C.RandomItemQuality()
							LB.Material = "Iron"
							LB.RandomItemQuality()


							R.suffix = "Equip"
							C.suffix = "Equip"
							LG.suffix = "Equip"
							RG.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"
							P.suffix = "Equip"
							H.suffix = "Equip"
							S.suffix = "Equip"
							L.suffix = "Equip"
							IS.suffix = "Equip"
							IS.EquipState = "[IS.EquipState] left"

							S.Material = "Iron"
							S.RandomItemQuality()

							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer

							src.WChest = R
							src.WUpperBody = C
							src.WShoulders = P
							src.WLeftHand = LG
							src.WRightHand = RG
							src.WLeftFoot = LB
							src.WRightFoot = RB
							src.WHead = H
							src.WLegs = L
							src.Weapon = S
							src.Weapon2 = IS

							src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
							src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
							src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)

							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
							src.GiveName()
			Stahlite_Guardsman_Patrol
				icon = 'dwarf.dmi'
				Type = "Town"
				icon_state = "N"
				Race = "Stahlite"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 65
				Agility = 40
				Endurance = 65
				Intelligence = 50

				StrengthMulti = 0.2
				AgilityMulti = 0.2
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.2

				SwordSkill = 5
				AxeSkill = 35
				SpearSkill = 25
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 50

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2
				ShieldSkillMulti = 0.2

				Soul = 0


				Blood = 130
				BloodMax = 130
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Stahlite Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/obj/Misc/Beards/StahliteBeard/Z = new
					src.Beard = Z
					src.overlays += src.Beard
					var/obj/Items/Weapons/Axes/BattleAxe/A = new
					A.Material = "Gold"
					A.RandomItemQuality()
					src.Weapon = A
					A.suffix = "Equip"
					A.Move(src)
					var/obj/Items/Armour/Chest/SmallChainShirt/IC = new
					IC.Material = "Gold"
					IC.RandomItemQuality()
					IC.Defence = 10
					src.WChest = IC
					IC.suffix = "Equip"
					IC.Move(src)
					var/obj/Items/Armour/Legs/SmallChainLeggings/LL = new
					LL.Material = "Gold"
					LL.RandomItemQuality()
					LL.Defence = 10
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.Move(src)
					var/obj/Items/Armour/UpperBody/SmallChestPlate/C = new
					C.Material = "Gold"
					C.RandomItemQuality()
					C.Defence = 10
					src.WUpperBody = C
					C.suffix = "Equip"
					C.Move(src)
					var/obj/Items/Armour/Head/SmallDwarvenHelmet3/H = new
					H.Material = "Gold"
					H.RandomItemQuality()
					H.Defence = 10
					src.WHead = H
					H.suffix = "Equip"
					H.Move(src)
					var/obj/Items/Armour/LeftArm/SmallPlateGauntletLeft/LG = new
					LG.Material = "Gold"
					LG.RandomItemQuality()
					LG.Defence = 10
					src.WLeftHand = LG
					LG.suffix = "Equip"
					LG.Move(src)
					var/obj/Items/Armour/RightArm/SmallPlateGauntletRight/RG = new
					RG.Material = "Gold"
					RG.RandomItemQuality()
					RG.Defence = 10
					src.WLeftHand = RG
					RG.suffix = "Equip"
					RG.Move(src)
					var/obj/Items/Armour/RightFoot/SmallPlateBootRight/RB = new
					RB.Material = "Gold"
					RB.RandomItemQuality()
					RB.Defence = 10
					src.WLeftHand = RB
					RB.suffix = "Equip"
					RB.Move(src)
					var/obj/Items/Armour/LeftFoot/SmallPlateBootLeft/LB = new
					LB.Material = "Gold"
					LB.RandomItemQuality()
					LB.Defence = 10
					src.WLeftHand = LB
					LB.suffix = "Equip"
					LB.Move(src)
					var/obj/Items/Armour/Waist/SmallPlateBelt/B = new
					B.Material = "Gold"
					B.RandomItemQuality()
					B.Defence = 10
					src.WLeftHand = B
					B.suffix = "Equip"
					B.Move(src)
					var/obj/Items/Armour/Shoulders/SmallPlatePauldrons/S = new
					S.Material = "Gold"
					S.RandomItemQuality()
					S.Defence = 10
					src.WShoulders = S
					S.suffix = "Equip"
					S.Move(src)
					for(var/obj/Items/Q in src)
						Q.Dura = 100
						Q.layer = Q.ItemLayer
						Q.icon_state = Q.EquipState
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					src.overlays+=image(IC.icon,IC.icon_state,IC.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
					src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
					src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
					src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
					src.overlays+=image(LG.icon,LB.icon_state,LB.ItemLayer)
					src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
					src.overlays+=image(B.icon,B.icon_state,B.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.NormalAI()
					src.Regen()
					src.GiveName()
			Stahlite_Merchant
				icon = 'dwarf.dmi'
				icon_state = "N"
				name = "{NPC} Merchant"
				Type = "Merchant"
				Race = "Stahlite"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 30
				Agility = 25
				Endurance = 30
				Intelligence = 60

				StrengthMulti = 0.2
				AgilityMulti = 0.2
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.2

				SwordSkill = 5
				AxeSkill = 50
				SpearSkill = 25
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 25
				ShieldSkill = 50

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 130
				BloodMax = 130
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Stahlite Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire")
				Click()
					if(usr.Function == "Interact" && src in range(2,usr))
						if(usr.Faction in src.HateList)
							return
						if(usr.name in src.HateList)
							return
						var/CanUnderstand = 0
						var/obj/Speaking = null
						if(usr.CurrentLanguage)
							Speaking = usr.CurrentLanguage
						for(var/obj/L in src.LangKnow)
							if(L.name == Speaking.name)
								if(L.SpeakPercent > Speaking.SpeakPercent / 1.5)
									CanUnderstand = 1
									src.CurrentLanguage = usr.CurrentLanguage
						if(CanUnderstand)
							src.Speak("Welcome, you wont find better wares anywhere else!",7)
							for(var/obj/I in usr)
								if(I in src.Selling)
									var/Val = 1
									if(I.Material == "Wood")
										Val += 1
									if(I.Material == "Stone")
										Val += 1
									if(I.Material == "Iron")
										Val += 10
									if(I.Material == "Copper")
										Val += 5
									if(I.Material == "Silver")
										Val += 15
									if(I.Material == "Gold")
										Val += 20
									if(I.Quality)
										Val += I.Quality / 1.5
									if(I.Defence)
										Val += I.Defence / 2
									var/RoundedVal = round(Val)
									src.Speak("Ah, I see you've chosen a [I], a fine choice my friend! That item has a total Value of about [RoundedVal] Gold Coins.",7)
									var/list/menu = new()
									menu += "Buy"
									menu += "Dont Buy"
									var/Result = input(usr,"[src] says - Would you like to purchase the [I] for [RoundedVal] Gold Coins?", "Choose", null) in menu
									if(Result == "Dont Buy")
										return
									if(Result == "Buy")
										for(var/obj/Items/Currency/GoldCoin/Gold in usr)
											if(Gold.Type >= RoundedVal)
												var/CoinsAlready = 0
												for(var/obj/Items/Currency/GoldCoin/C in src)
													CoinsAlready = 1
												if(CoinsAlready == 0)
													var/obj/Items/Currency/GoldCoin/Coin = new
													Coin.Type = RoundedVal
													Gold.Type -= RoundedVal
													Coin.CoinAdjust()
													Gold.CoinAdjust()
													Coin.Move(src)
													Coin.suffix = "Carried"
													Coin.name = "[Coin.Type] Gold Coins"
													Gold.name = "[Gold.Type] Gold Coins"
												else
													for(var/obj/Items/Currency/GoldCoin/Coin in src)
														Coin.Type += RoundedVal
														Gold.Type -= RoundedVal
														Coin.CoinAdjust()
														Gold.CoinAdjust()
														Gold.name = "[Gold.Type] Gold Coins"
														Coin.name = "[Coin.Type] Gold Coins"
												if(Gold.Type == 0)
													del(Gold)
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.CreateInventory()
												src.Selling -= I
												if(I.ObjectTag == "Weapon")
													I.CanBeCrafted = 1
												if(I.ObjectTag == "Armour")
													I.CanBeCrafted = 1
												src.Speak("Remember, best wares in all the land!.",7)
											else
												src.Speak("You dont have [RoundedVal] Gold Coins so you cant buy the [I], what ya trying to do, rip me off?! Shame on you...",7)
						else
							usr << "<font color = yellow>[src] glares, seeming to have no idea what your saying.<br>"
						return
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/obj/Misc/Beards/StahliteBeard/Z = new
							src.Beard = Z
							src.overlays += src.Beard
							var/obj/Items/Armour/Chest/SmallChainShirt/IC = new
							IC.Material = "Iron"
							IC.RandomItemQuality()
							IC.Defence = 10
							src.WChest = IC
							IC.suffix = "Equip"
							IC.Move(src)
							var/obj/Items/Armour/Legs/SmallChainLeggings/LL = new
							LL.Material = "Iron"
							LL.RandomItemQuality()
							LL.Defence = 10
							src.WLegs = LL
							LL.suffix = "Equip"
							LL.Move(src)
							var/obj/Items/Armour/UpperBody/SmallChestPlate/C = new
							C.Material = "Iron"
							C.RandomItemQuality()
							C.Defence = 10
							src.WUpperBody = C
							C.suffix = "Equip"
							C.Move(src)
							var/obj/Items/Armour/Head/SmallDwarvenHelmet3/H = new
							H.Material = "Iron"
							H.RandomItemQuality()
							H.Defence = 10
							src.WHead = H
							H.suffix = "Equip"
							H.Move(src)
							var/obj/Items/Armour/LeftArm/SmallPlateGauntletLeft/LG = new
							LG.Material = "Iron"
							LG.RandomItemQuality()
							LG.Defence = 10
							src.WLeftHand = LG
							LG.suffix = "Equip"
							LG.Move(src)
							var/obj/Items/Armour/RightArm/SmallPlateGauntletRight/RG = new
							RG.Material = "Iron"
							RG.RandomItemQuality()
							RG.Defence = 10
							src.WLeftHand = RG
							RG.suffix = "Equip"
							RG.Move(src)
							var/obj/Items/Armour/RightFoot/SmallPlateBootRight/RB = new
							RB.Material = "Iron"
							RB.RandomItemQuality()
							RB.Defence = 10
							src.WLeftHand = RB
							RB.suffix = "Equip"
							RB.Move(src)
							var/obj/Items/Armour/LeftFoot/SmallPlateBootLeft/LB = new
							LB.Material = "Iron"
							LB.RandomItemQuality()
							LB.Defence = 10
							src.WLeftHand = LB
							LB.suffix = "Equip"
							LB.Move(src)
							var/obj/Items/Armour/Waist/SmallPlateBelt/B = new
							B.Material = "Iron"
							B.RandomItemQuality()
							B.Defence = 10
							src.WLeftHand = B
							B.suffix = "Equip"
							B.Move(src)
							var/obj/Items/Armour/Shoulders/SmallPlatePauldrons/S = new
							S.Material = "Iron"
							S.RandomItemQuality()
							S.Defence = 10
							src.WShoulders = S
							S.suffix = "Equip"
							S.Move(src)
							for(var/obj/Items/Q in src)
								Q.Dura = 100
								Q.layer = Q.ItemLayer
								Q.icon_state = Q.EquipState
							src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
							src.overlays+=image(IC.icon,IC.icon_state,IC.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
							src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LG.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(B.icon,B.icon_state,B.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.Regen()
							src.GiveRaceLanguages()
							src.Selling = list()
							for(var/obj/Items/It in orange(7,src))
								var/Add = 1
								if(It in src.Selling)
									Add = 0
								if(Add)
									src.Selling += It
			Stahlite_Guardsman
				icon = 'dwarf.dmi'
				icon_state = "N"
				Race = "Stahlite"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 65
				Agility = 40
				Endurance = 65
				Intelligence = 60

				StrengthMulti = 0.2
				AgilityMulti = 0.2
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.2

				SwordSkill = 5
				AxeSkill = 50
				SpearSkill = 25
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50
				ShieldSkill = 50

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2
				ShieldSkillMulti = 0.2

				Soul = 0

				Blood = 130
				BloodMax = 130
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Stahlite Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/obj/Misc/Beards/StahliteBeard/Z = new
							src.Beard = Z
							src.overlays += src.Beard
							var/obj/Items/Weapons/Axes/BattleAxe/A = new
							A.Material = "Iron"
							A.RandomItemQuality()
							src.Weapon = A
							A.suffix = "Equip"
							A.Move(src)
							var/obj/Items/Armour/Chest/SmallChainShirt/IC = new
							IC.Material = "Iron"
							IC.RandomItemQuality()
							IC.Defence = 10
							src.WChest = IC
							IC.suffix = "Equip"
							IC.Move(src)
							var/obj/Items/Armour/Legs/SmallChainLeggings/LL = new
							LL.Material = "Iron"
							LL.RandomItemQuality()
							LL.Defence = 10
							src.WLegs = LL
							LL.suffix = "Equip"
							LL.Move(src)
							var/obj/Items/Armour/UpperBody/SmallChestPlate/C = new
							C.Material = "Iron"
							C.RandomItemQuality()
							C.Defence = 10
							src.WUpperBody = C
							C.suffix = "Equip"
							C.Move(src)
							var/obj/Items/Armour/Head/SmallDwarvenHelmet3/H = new
							H.Material = "Iron"
							H.RandomItemQuality()
							H.Defence = 10
							src.WHead = H
							H.suffix = "Equip"
							H.Move(src)
							var/obj/Items/Armour/LeftArm/SmallPlateGauntletLeft/LG = new
							LG.Material = "Iron"
							LG.RandomItemQuality()
							LG.Defence = 10
							src.WLeftHand = LG
							LG.suffix = "Equip"
							LG.Move(src)
							var/obj/Items/Armour/RightArm/SmallPlateGauntletRight/RG = new
							RG.Material = "Iron"
							RG.RandomItemQuality()
							RG.Defence = 10
							src.WLeftHand = RG
							RG.suffix = "Equip"
							RG.Move(src)
							var/obj/Items/Armour/RightFoot/SmallPlateBootRight/RB = new
							RB.Material = "Iron"
							RB.RandomItemQuality()
							RB.Defence = 10
							src.WLeftHand = RB
							RB.suffix = "Equip"
							RB.Move(src)
							var/obj/Items/Armour/LeftFoot/SmallPlateBootLeft/LB = new
							LB.Material = "Iron"
							LB.RandomItemQuality()
							LB.Defence = 10
							src.WLeftHand = LB
							LB.suffix = "Equip"
							LB.Move(src)
							var/obj/Items/Armour/Waist/SmallPlateBelt/B = new
							B.Material = "Iron"
							B.RandomItemQuality()
							B.Defence = 10
							src.WLeftHand = B
							B.suffix = "Equip"
							B.Move(src)
							var/obj/Items/Armour/Shoulders/SmallPlatePauldrons/S = new
							S.Material = "Iron"
							S.RandomItemQuality()
							S.Defence = 10
							src.WShoulders = S
							S.suffix = "Equip"
							S.Move(src)
							for(var/obj/Items/Q in src)
								Q.Dura = 100
								Q.layer = Q.ItemLayer
								Q.icon_state = Q.EquipState
							src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
							src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
							src.overlays+=image(IC.icon,IC.icon_state,IC.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
							src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LG.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(B.icon,B.icon_state,B.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
							src.GiveName()
			Human_Inquisitor
				icon = 'human.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 55
				Agility = 45
				Endurance = 55
				Intelligence = 55

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 55
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 55

				SwordSkillMulti = 0.5
				AxeSkillMulti = 0.5
				SpearSkillMulti = 0.5
				BluntSkillMulti = 0.5
				RangedSkillMulti = 0.5
				DaggerSkillMulti = 0.5
				UnarmedSkillMulti = 0.5

				Blood = 170
				BloodMax = 170
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/obj/Items/Weapons/Blunts/InquisitorsMaul/SW = new
							var/obj/Items/Armour/Head/InquisitorsHelmet/H = new
							var/obj/Items/Armour/Chest/ChainShirt/R = new
							var/obj/Items/Armour/Legs/ChainLeggings/L = new
							var/obj/Items/Armour/UpperBody/InquisitorsChestPlate/C = new
							var/obj/Items/Armour/Shoulders/InquisitorsPauldrons/S = new
							var/obj/Items/Armour/LeftArm/InquisitorsLeftGauntlet/LG = new
							var/obj/Items/Armour/RightArm/InquisitorsRightGauntlet/RG = new
							var/obj/Items/Armour/LeftFoot/InquisitorsLeftBoot/LB = new
							var/obj/Items/Armour/RightFoot/InquisitorsRightBoot/RB = new

							R.Move(src)
							C.Move(src)
							LG.Move(src)
							RG.Move(src)
							LB.Move(src)
							RB.Move(src)
							S.Move(src)
							H.Move(src)
							SW.Move(src)
							L.Move(src)

							R.Material = "Iron"
							R.RandomItemQuality()
							L.Material = "Iron"
							L.RandomItemQuality()


							R.suffix = "Equip"
							C.suffix = "Equip"
							LG.suffix = "Equip"
							RG.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"
							S.suffix = "Equip"
							H.suffix = "Equip"
							SW.suffix = "Equip"
							L.suffix = "Equip"

							src.WChest = R
							src.WUpperBody = C
							src.WShoulders = S
							src.WLeftHand = LG
							src.WRightHand = RG
							src.WLeftFoot = LB
							src.WRightFoot = RB
							src.WHead = H
							src.WLegs = L
							src.Weapon = SW
							for(var/obj/Items/Z in src)
								if(Z.Defence)
									Z.Defence = Z.Defence / 2
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer
							src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
							src.overlays+=image(SW.icon,SW.icon_state,SW.ItemLayer)
							src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)

							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.InquisitiveGuardAI()
							src.Regen()
							src.GiveName()
							src.name = "[src.name] The Inquisitor"
							var/obj/Items/Currency/GoldCoin/Gold = new
							Gold.Move(src)
							Gold.suffix = "Carried"
							Gold.Type = rand(10,25)
							Gold.name = "[Gold.Type] Gold Coins"
							Gold.CoinAdjust()
			Human_Inquisitor_Patroler
				name = "Human Inquisitor"
				icon = 'human.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 55
				Agility = 45
				Endurance = 55
				Intelligence = 55

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 55
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 55

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.2
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.2

				Blood = 170
				BloodMax = 170
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				luminosity = 4

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/obj/Items/Weapons/Blunts/InquisitorsMaul/SW = new
					var/obj/Items/Armour/Head/InquisitorsHelmet/H = new
					var/obj/Items/Armour/Chest/ChainShirt/R = new
					var/obj/Items/Armour/Legs/ChainLeggings/L = new
					var/obj/Items/Armour/UpperBody/InquisitorsChestPlate/C = new
					var/obj/Items/Armour/Shoulders/InquisitorsPauldrons/S = new
					var/obj/Items/Armour/LeftArm/InquisitorsLeftGauntlet/LG = new
					var/obj/Items/Armour/RightArm/InquisitorsRightGauntlet/RG = new
					var/obj/Items/Armour/LeftFoot/InquisitorsLeftBoot/LB = new
					var/obj/Items/Armour/RightFoot/InquisitorsRightBoot/RB = new
					var/obj/Items/Armour/Shields/Torch/T = new

					R.Move(src)
					C.Move(src)
					LG.Move(src)
					RG.Move(src)
					LB.Move(src)
					RB.Move(src)
					S.Move(src)
					H.Move(src)
					SW.Move(src)
					L.Move(src)
					T.Move(src)

					R.Material = "Iron"
					R.RandomItemQuality()
					L.Material = "Iron"
					L.RandomItemQuality()


					R.suffix = "Equip"
					C.suffix = "Equip"
					LG.suffix = "Equip"
					RG.suffix = "Equip"
					LB.suffix = "Equip"
					RB.suffix = "Equip"
					S.suffix = "Equip"
					H.suffix = "Equip"
					SW.suffix = "Equip"
					L.suffix = "Equip"
					T.suffix = "Equip"

					src.WChest = R
					src.WUpperBody = C
					src.WShoulders = S
					src.WLeftHand = LG
					src.WRightHand = RG
					src.WLeftFoot = LB
					src.WRightFoot = RB
					src.WHead = H
					src.WLegs = L
					src.Weapon = SW
					T.EquipState = "torch lit equip"
					T.Type = "Torch Lit"
					T.EquipState = "[T.EquipState] left"
					src.Weapon2 = T
					for(var/obj/Items/Z in src)
						if(Z.Defence)
							Z.Defence = Z.Defence / 2
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer
					src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
					src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
					src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
					src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
					src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
					src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
					src.overlays+=image(SW.icon,SW.icon_state,SW.ItemLayer)
					src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
					src.overlays+=image(T.icon,T.icon_state,T.ItemLayer)

					src.GuardLoc = src.loc
					src.GuardDir = src.dir
					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.Regen()
					src.GiveName()
					src.name = "[src.name] The Inquisitor"
					var/obj/Items/Currency/GoldCoin/Gold = new
					Gold.Move(src)
					Gold.suffix = "Carried"
					Gold.Type = rand(10,25)
					Gold.name = "[Gold.Type] Gold Coins"
					Gold.CoinAdjust()
					spawn(10)
						var/Found = 0
						for(var/mob/NPC/Good/Human_Priest_Patroler/P in view(4,src))
							Found = 1
							src.Owner = P
						if(Found)
							src.FollowAI()
						else
							src.InquisitiveAI()
			Human_Priest_Patroler
				name = "Human Priest of Order"
				icon = 'human.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 60
				Agility = 50
				Endurance = 60
				Intelligence = 60

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 60
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 60

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.3
				DaggerSkillMulti = 0.3
				UnarmedSkillMulti = 0.3

				luminosity = 4

				Blood = 200
				BloodMax = 200
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/obj/Items/Weapons/Blunts/InquisitorsStaff/SW = new
					var/obj/Items/Armour/Head/PriestHelmet/H = new
					var/obj/Items/Armour/Chest/PriestRobe/R = new
					var/obj/Items/Armour/UpperBody/PriestsChestPlate/C = new
					var/obj/Items/Armour/Waist/PriestBelt/B = new
					var/obj/Items/Armour/Shoulders/PriestsPauldrons/S = new
					var/obj/Items/Armour/LeftArm/PriestsLeftGauntlet/LG = new
					var/obj/Items/Armour/RightArm/PriestsRightGauntlet/RG = new
					var/obj/Items/Armour/LeftFoot/PriestsLeftBoot/LB = new
					var/obj/Items/Armour/RightFoot/PriestsRightBoot/RB = new
					var/obj/Items/Armour/Shields/Torch/T = new

					R.loc = src
					C.loc = src
					B.loc = src
					LG.loc = src
					RG.loc = src
					LB.loc = src
					RB.loc = src
					S.loc = src
					H.loc = src
					SW.loc = src
					T.loc = src

					R.suffix = "Equip"
					C.suffix = "Equip"
					B.suffix = "Equip"
					LG.suffix = "Equip"
					RG.suffix = "Equip"
					LB.suffix = "Equip"
					RB.suffix = "Equip"
					S.suffix = "Equip"
					H.suffix = "Equip"
					SW.suffix = "Equip"
					T.suffix = "Equip"

					src.WChest = R
					src.WUpperBody = C
					src.WShoulders = S
					src.WLeftHand = LG
					src.WRightHand = RG
					src.WLeftFoot = LB
					src.WRightFoot = RB
					src.WWaist = B
					src.WHead = H
					src.Weapon = SW
					T.EquipState = "torch lit equip"
					T.Type = "Torch Lit"
					T.EquipState = "[T.EquipState] left"
					src.Weapon2 = T
					for(var/obj/Items/Z in src)
						if(Z.Defence)
							Z.Defence = Z.Defence / 2
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer
					src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
					src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
					src.overlays+=image(B.icon,B.icon_state,B.ItemLayer)
					src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
					src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
					src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
					src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
					src.overlays+=image(SW.icon,SW.icon_state,SW.ItemLayer)
					src.overlays+=image(T.icon,T.icon_state,T.ItemLayer)

					src.GuardLoc = src.loc
					src.GuardDir = src.dir
					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.InquisitiveAI()
					src.Regen()
					src.GiveName()
					src.name = "[src.name] The Priest"
					var/obj/Items/Currency/GoldCoin/Gold = new
					Gold.loc = src
					Gold.suffix = "Carried"
					Gold.Type = rand(10,25)
					Gold.name = "[Gold.Type] Gold Coins"
					Gold.CoinAdjust()
			Chuck_Norris
				icon = 'human.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 125
				Torso = 125
				LeftArm = 125
				RightArm = 125
				LeftLeg = 125
				RightLeg = 125

				Skull = 125
				Brain = 125
				LeftEye = 125
				RightEye = 125
				LeftEar = 125
				RightEar = 125
				Teeth = 125
				Nose = 125
				Tongue = 125
				Throat = 125

				Heart = 125
				LeftLung = 125
				RightLung = 125
				Spleen = 125
				Intestine = 125
				LeftKidney = 125
				RightKidney = 125
				Liver = 125
				Bladder = 125
				Stomach = 125

				Strength = 100
				Agility = 100
				Endurance = 100
				Intelligence = 100

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 50
				AxeSkill = 50
				SpearSkill = 50
				BluntSkill = 50
				RangedSkill = 50
				DaggerSkill = 50
				UnarmedSkill = 50

				SwordSkillMulti = 0.5
				AxeSkillMulti = 0.5
				SpearSkillMulti = 0.5
				BluntSkillMulti = 0.5
				RangedSkillMulti = 0.5
				DaggerSkillMulti = 0.5
				UnarmedSkillMulti = 0.5

				Blood = 250
				BloodMax = 250
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "None"
				HateList = list()
				New()
					spawn(10)
						if(src)
							src.GiveRaceLanguages()
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/obj/Items/Armour/Chest/PriestRobe/R = new
							var/obj/Items/Armour/LeftFoot/PriestsLeftBoot/LB = new
							var/obj/Items/Armour/RightFoot/PriestsRightBoot/RB = new

							R.loc = src
							LB.loc = src
							RB.loc = src

							R.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"

							src.WChest = R
							src.WLeftFoot = LB
							src.WRightFoot = RB
							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer
							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)

							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.NormalAI()
							src.Regen()
							var/obj/Misc/Beards/HumanoidBeard/B = new
							src.Beard = B
							if(src.WHead == null)
								src.overlays += src.Beard
			Human_Monk_of_Order
				icon = 'human.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 50
				Agility = 50
				Endurance = 50
				Intelligence = 50

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50

				SwordSkillMulti = 0.5
				AxeSkillMulti = 0.5
				SpearSkillMulti = 0.5
				BluntSkillMulti = 0.5
				RangedSkillMulti = 0.5
				DaggerSkillMulti = 0.5
				UnarmedSkillMulti = 0.5

				Blood = 200
				BloodMax = 200
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					spawn(10)
						if(src)
							src.GiveRaceLanguages()
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/obj/Items/Armour/Chest/PriestRobe/R = new
							var/obj/Items/Armour/LeftFoot/PriestsLeftBoot/LB = new
							var/obj/Items/Armour/RightFoot/PriestsRightBoot/RB = new

							R.loc = src
							LB.loc = src
							RB.loc = src

							R.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"

							src.WChest = R
							src.WLeftFoot = LB
							src.WRightFoot = RB
							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer
							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)

							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.InquisitiveAI()
							src.Regen()
							src.GiveName()
							src.Ressurect()
							src.name = "[src.name] The Monk"
			Human_Priest_of_Order
				icon = 'human.dmi'
				icon_state = "N"
				Race = "Human"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 60
				Agility = 50
				Endurance = 60
				Intelligence = 60

				StrengthMulti = 0.3
				AgilityMulti = 0.3
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.3

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 60
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 60

				SwordSkillMulti = 0.5
				AxeSkillMulti = 0.5
				SpearSkillMulti = 0.5
				BluntSkillMulti = 0.5
				RangedSkillMulti = 0.5
				DaggerSkillMulti = 0.5
				UnarmedSkillMulti = 0.5

				Blood = 200
				BloodMax = 200
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Human Empire"

				HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Human Empire Unholy","Human Empire Outlaw")
				New()
					spawn(10)
						if(src)
							src.GiveRaceLanguages()
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/obj/Items/Weapons/Blunts/InquisitorsStaff/SW = new
							var/obj/Items/Armour/Head/PriestHelmet/H = new
							var/obj/Items/Armour/Chest/PriestRobe/R = new
							var/obj/Items/Armour/UpperBody/PriestsChestPlate/C = new
							var/obj/Items/Armour/Waist/PriestBelt/B = new
							var/obj/Items/Armour/Shoulders/PriestsPauldrons/S = new
							var/obj/Items/Armour/LeftArm/PriestsLeftGauntlet/LG = new
							var/obj/Items/Armour/RightArm/PriestsRightGauntlet/RG = new
							var/obj/Items/Armour/LeftFoot/PriestsLeftBoot/LB = new
							var/obj/Items/Armour/RightFoot/PriestsRightBoot/RB = new

							R.loc = src
							C.loc = src
							B.loc = src
							LG.loc = src
							RG.loc = src
							LB.loc = src
							RB.loc = src
							S.loc = src
							H.loc = src
							SW.loc = src

							R.suffix = "Equip"
							C.suffix = "Equip"
							B.suffix = "Equip"
							LG.suffix = "Equip"
							RG.suffix = "Equip"
							LB.suffix = "Equip"
							RB.suffix = "Equip"
							S.suffix = "Equip"
							H.suffix = "Equip"
							SW.suffix = "Equip"

							src.WChest = R
							src.WUpperBody = C
							src.WShoulders = S
							src.WLeftHand = LG
							src.WRightHand = RG
							src.WLeftFoot = LB
							src.WRightFoot = RB
							src.WWaist = B
							src.WHead = H
							src.Weapon = SW
							for(var/obj/Items/Z in src)
								if(Z.Defence)
									Z.Defence = Z.Defence / 2
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer
							src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(B.icon,B.icon_state,B.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
							src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
							src.overlays+=image(SW.icon,SW.icon_state,SW.ItemLayer)

							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
							src.GiveName()
							src.Ressurect()
							src.name = "[src.name] The Priest"
							var/obj/Items/Currency/GoldCoin/Gold = new
							Gold.loc = src
							Gold.suffix = "Carried"
							Gold.Type = rand(10,25)
							Gold.name = "[Gold.Type] Gold Coins"
							Gold.CoinAdjust()
		Evil
			Demonic
				see_in_dark = 6
				ArchDemon
					name = "{NPC} Arch Demon"
					icon = 'Arch Demon.dmi'

					Humanoid = 1

					Head = 200
					Torso = 200
					LeftArm = 200
					RightArm = 200
					LeftLeg = 200
					RightLeg = 200

					Skull = 200
					Brain = 200
					LeftEye = 200
					RightEye = 200
					LeftEar = 200
					RightEar = 200
					Teeth = 200
					Nose = 200
					Tongue = 200
					Throat = 200

					Heart = 200
					LeftLung = 200
					RightLung = 200
					Spleen = 200
					Intestine = 200
					LeftKidney = 200
					RightKidney = 200
					Liver = 200
					Bladder = 200
					Stomach = 200

					Strength = 100
					Agility = 100
					Endurance = 100
					Intelligence = 50

					StrengthMulti = 2
					AgilityMulti = 2
					EnduranceMulti = 2
					IntelligenceMulti = 2

					SwordSkill = 100
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 100

					SwordSkillMulti = 1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Blood = 666
					BloodMax = 666
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Soul = 0

					Faction = "Demonic Legions"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()

						var/obj/Misc/Languages/Demonic/L = new
						L.SpeakPercent = 100
						L.WritePercent = 100
						src.LangKnow += L
						src.CurrentLanguage = L
				GreaterDemon
					name = "{NPC} Greater Demon"
					icon = 'demon3.dmi'
					icon_state = "N"

					Humanoid = 1

					Head = 125
					Torso = 125
					LeftArm = 125
					RightArm = 125
					LeftLeg = 125
					RightLeg = 125

					Skull = 125
					Brain = 125
					LeftEye = 125
					RightEye = 125
					LeftEar = 125
					RightEar = 125
					Teeth = 125
					Nose = 125
					Tongue = 125
					Throat = 125

					Heart = 125
					LeftLung = 125
					RightLung = 125
					Spleen = 125
					Intestine = 125
					LeftKidney = 125
					RightKidney = 125
					Liver = 125
					Bladder = 125
					Stomach = 125

					Strength = 80
					Agility = 80
					Endurance = 80
					Intelligence = 20

					StrengthMulti = 1
					AgilityMulti = 1
					EnduranceMulti = 1
					IntelligenceMulti = 1

					SwordSkill = 75
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 50

					SwordSkillMulti = 1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Blood = 300
					BloodMax = 300
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Soul = 0

					Faction = "Demonic Legions"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Weapons/Swords/DemonicSword/D = new
						src.Weapon = D
						D.suffix = "Equip"
						D.icon_state = D.EquipState
						src.overlays += D

						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()

						var/obj/Misc/Languages/Demonic/L = new
						L.SpeakPercent = 100
						L.WritePercent = 100
						src.LangKnow += L
						src.CurrentLanguage = L
				Demon
					name = "{NPC} Demon"
					icon = 'demon2.dmi'
					icon_state = "N"

					Humanoid = 1

					Head = 125
					Torso = 125
					LeftArm = 125
					RightArm = 125
					LeftLeg = 125
					RightLeg = 125

					Skull = 125
					Brain = 125
					LeftEye = 125
					RightEye = 125
					LeftEar = 125
					RightEar = 125
					Teeth = 125
					Nose = 125
					Tongue = 125
					Throat = 125

					Heart = 125
					LeftLung = 125
					RightLung = 125
					Spleen = 125
					Intestine = 125
					LeftKidney = 125
					RightKidney = 125
					Liver = 125
					Bladder = 125
					Stomach = 125

					Strength = 70
					Agility = 60
					Endurance = 70
					Intelligence = 10

					StrengthMulti = 0.5
					AgilityMulti = 0.4
					EnduranceMulti = 0.5
					IntelligenceMulti = 0.5

					SwordSkill = 60
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 50

					SwordSkillMulti = 0.5
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Blood = 200
					BloodMax = 200
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Soul = 0

					Faction = "Demonic Legions"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Weapons/Swords/DemonicSword/D = new
						src.Weapon = D
						D.suffix = "Equip"
						D.icon_state = D.EquipState
						src.overlays += D

						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()

						var/obj/Misc/Languages/Demonic/L = new
						L.SpeakPercent = 100
						L.WritePercent = 100
						src.LangKnow += L
						src.CurrentLanguage = L
			Undead
				see_in_dark = 6
				Corpse_Devourer_Cacoon
					icon = 'misc.dmi'
					icon_state = "devourer cacoon"

					Race = "Undead"

					density = 0

					Humanoid = 0

					Type = "Egg"

					BloodColour = /obj/Misc/Gore/GreenBloodSplat/
					BloodWallColour = /obj/Misc/Gore/GreenWallBloodSplat/

					HP = 200
					HPMAX = 200

					Soul = 0

					Faction = "Undead"
					Click()
						if(usr.Function == "Combat")
							usr.Target = src
							usr << "<b>You target [src]!<br>"

						if(usr.Function == "Pull")
							if(src in range(1,usr))
								if(usr.Pull == src)
									usr.Pull = null
									if(src.Pull == usr)
										src.Pull = null
									view(usr) << "<b>[usr] stops pulling [src]<br>"
									return
								if(src.suffix == null)
									if(usr.Pull == null)
										usr.Pull = src
										src.Pull = usr
										usr.Pull()
										view(usr) << "<b>[usr] starts pulling [src]<br>"
										return
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.DeadIcon = 'misc.dmi'
						src.DeadState = "devourer cacoon dead"
						src.BloodFlow()
						src.DevourerCacoonHatch()
				Corpse_Devourer
					name = "{NPC} Corpse Devourer"
					icon = 'creatures.dmi'
					icon_state = "corpse devourer"

					Race = "Undead"

					Humanoid = 0

					Strength = 25
					Agility = 25
					Endurance = 35
					Intelligence = 5

					StrengthMulti = 0.2
					AgilityMulti = 0.2
					EnduranceMulti = 0.2
					IntelligenceMulti = 0.05

					SwordSkill = 25
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 25

					SwordSkillMulti = 0.3
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					BloodColour = /obj/Misc/Gore/GreenBloodSplat/
					BloodWallColour = /obj/Misc/Gore/GreenWallBloodSplat/

					SpreadsAffliction = "Undead Bite"

					HP = 300
					HPMAX = 300

					Soul = 0

					Faction = "Undead"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "devourer corpse"
						src.Attack()
						src.BloodFlow()
						src.DevourerAI()
				Mummy
					name = "{NPC} Mummy"
					Fuel = 100
					icon = 'mummy.dmi'
					icon_state = "N"

					Race = "Skeleton"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 0
					LeftEye = 0
					RightEye = 0
					LeftEar = 0
					RightEar = 0
					Teeth = 100
					Nose = 0
					Tongue = 0
					Throat = 0

					Heart = 0
					LeftLung = 0
					RightLung = 0
					Spleen = 0
					Intestine = 0
					LeftKidney = 0
					RightKidney = 0
					Liver = 0
					Bladder = 0
					Stomach = 0

					Strength = 20
					Agility = 20
					Endurance = 40
					Intelligence = 20

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.2
					IntelligenceMulti = 0.1

					SwordSkill = 20
					AxeSkill = 20
					SpearSkill = 20
					BluntSkill = 20
					RangedSkill = 20
					DaggerSkill = 20
					UnarmedSkill = 25

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.3

					Soul = 0

					Blood = 0
					BloodMax = 0

					Faction = "Undead"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.Attack()
						src.NormalAI()
				Undead_Skeleton_Lord
					name = "{NPC} Undead Skeleton Lord"
					Fuel = 0
					icon = 'skeleton.dmi'
					icon_state = "N"

					Race = "Skeleton"
					Type = "Skeleton"

					Head = 50
					Torso = 75
					LeftArm = 75
					RightArm = 75
					LeftLeg = 75
					RightLeg = 75

					Skull = 50
					Brain = 0
					LeftEye = 0
					RightEye = 0
					LeftEar = 0
					RightEar = 0
					Teeth = 50
					Nose = 0
					Tongue = 0
					Throat = 0

					Heart = 0
					LeftLung = 0
					RightLung = 0
					Spleen = 0
					Intestine = 0
					LeftKidney = 0
					RightKidney = 0
					Liver = 0
					Bladder = 0
					Stomach = 0

					Strength = 20
					Agility = 17
					Endurance = 20
					Intelligence = 20

					StrengthMulti = 0.2
					AgilityMulti = 0.2
					EnduranceMulti = 0.2
					IntelligenceMulti = 0.2

					SwordSkill = 20
					AxeSkill = 20
					SpearSkill = 20
					BluntSkill = 20
					RangedSkill = 20
					DaggerSkill = 20
					UnarmedSkill = 20

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.2

					Soul = 0

					Blood = 0
					BloodMax = 0

					Faction = "Undead"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Weapons/Swords/LongSword/SW = new
						var/obj/Items/Armour/Chest/ChainShirt/R = new
						var/obj/Items/Armour/Legs/ChainLeggings/L = new
						var/obj/Items/Armour/LeftFoot/PlateBootLeft/BL = new
						var/obj/Items/Armour/RightFoot/PlateBootRight/BR = new
						var/obj/Items/Armour/LeftArm/PlateGauntletLeft/GL = new
						var/obj/Items/Armour/RightArm/PlateGauntletRight/GR = new
						var/obj/Items/Armour/UpperBody/ChestPlate/ICP = new

						R.loc = src
						SW.loc = src
						L.loc = src
						BL.loc = src
						BR.loc = src
						GL.loc = src
						GR.loc = src
						ICP.loc = src

						R.Material = "Iron"
						R.RandomItemQuality()
						GL.Material = "Iron"
						GL.RandomItemQuality()
						BL.Material = "Iron"
						BL.RandomItemQuality()
						L.Material = "Iron"
						L.RandomItemQuality()
						GR.Material = "Iron"
						GR.RandomItemQuality()
						BR.Material = "Iron"
						BR.RandomItemQuality()
						ICP.Material = "Iron"
						ICP.RandomItemQuality()

						R.suffix = "Equip"
						SW.suffix = "Equip"
						L.suffix = "Equip"
						BL.suffix = "Equip"
						BR.suffix = "Equip"
						GL.suffix = "Equip"
						GR.suffix = "Equip"
						ICP.suffix = "Equip"

						SW.Material = "Iron"
						SW.RandomItemQuality()

						R.Dura = 25
						SW.Dura = 25
						L.Dura = 25
						BR.Dura = 25
						GL.Dura = 25
						GR.Dura = 25
						ICP.Dura = 25

						src.WLegs = L
						src.Weapon = SW
						src.WChest = R
						src.WRightFoot = BR
						src.WLeftFoot = BL
						src.WRightHand = GR
						src.WLeftHand = GL
						src.WUpperBody = ICP
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
						src.overlays+=image(SW.icon,SW.icon_state,SW.ItemLayer)
						src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
						src.overlays+=image(BR.icon,BR.icon_state,BR.ItemLayer)
						src.overlays+=image(BL.icon,BL.icon_state,BL.ItemLayer)
						src.overlays+=image(GR.icon,GR.icon_state,GR.ItemLayer)
						src.overlays+=image(GL.icon,GL.icon_state,GL.ItemLayer)
						src.overlays+=image(ICP.icon,ICP.icon_state,ICP.ItemLayer)

						src.Attack()
						src.NormalAI()
						var/obj/Items/Currency/GoldCoin/Gold = new
						Gold.loc = src
						Gold.suffix = "Carried"
						Gold.Type = rand(10,25)
						Gold.name = "[Gold.Type] Gold Coins"
						Gold.CoinAdjust()
				Lich
					name = "{NPC} Lich"
					Fuel = 0
					icon = 'lich.dmi'
					icon_state = "N"

					Race = "Skeleton"

					Head = 50
					Torso = 50
					LeftArm = 50
					RightArm = 50
					LeftLeg = 50
					RightLeg = 50

					Skull = 50
					Brain = 0
					LeftEye = 0
					RightEye = 0
					LeftEar = 0
					RightEar = 0
					Teeth = 50
					Nose = 0
					Tongue = 0
					Throat = 0

					Heart = 0
					LeftLung = 0
					RightLung = 0
					Spleen = 0
					Intestine = 0
					LeftKidney = 0
					RightKidney = 0
					Liver = 0
					Bladder = 0
					Stomach = 0

					Strength = 15
					Agility = 15
					Endurance = 40
					Intelligence = 50

					StrengthMulti = 0.15
					AgilityMulti = 0.15
					EnduranceMulti = 0.15
					IntelligenceMulti = 0.5

					SwordSkill = 12
					AxeSkill = 12
					SpearSkill = 12
					BluntSkill = 12
					RangedSkill = 12
					DaggerSkill = 12
					UnarmedSkill = 12

					SwordSkillMulti = 0.12
					AxeSkillMulti = 0.12
					SpearSkillMulti = 0.12
					BluntSkillMulti = 0.12
					RangedSkillMulti = 0.12
					DaggerSkillMulti = 0.12
					UnarmedSkillMulti = 0.12

					Soul = 0

					Blood = 0
					BloodMax = 0

					Faction = "Undead"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						spawn(10)
							if(src)
								src.GuardLoc = src.loc
								src.GuardDir = src.dir
								src.GuardAI()
								src.EvilRessurect()
								var/image/I = new('Target.dmi',src)
								src.TargetIcon = I
								var/obj/Items/Armour/Chest/Robe/CP = new

								CP.loc = src

								CP.suffix = "Equip"

								src.WBack = CP

								CP.icon_state = CP.EquipState

								src.overlays+=image(CP.icon,CP.icon_state,CP.ItemLayer)
								src.Attack()
				Undead_Skeleton
					name = "{NPC} Undead Skeleton"
					Fuel = 0
					icon = 'skeleton.dmi'
					icon_state = "N"

					Race = "Skeleton"
					Type = "Skeleton"

					Head = 25
					Torso = 50
					LeftArm = 50
					RightArm = 50
					LeftLeg = 50
					RightLeg = 50

					Skull = 25
					Brain = 0
					LeftEye = 0
					RightEye = 0
					LeftEar = 0
					RightEar = 0
					Teeth = 50
					Nose = 0
					Tongue = 0
					Throat = 0

					Heart = 0
					LeftLung = 0
					RightLung = 0
					Spleen = 0
					Intestine = 0
					LeftKidney = 0
					RightKidney = 0
					Liver = 0
					Bladder = 0
					Stomach = 0

					Strength = 10
					Agility = 7
					Endurance = 10
					Intelligence = 10

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 9
					AxeSkill = 9
					SpearSkill = 9
					BluntSkill = 9
					RangedSkill = 9
					DaggerSkill = 9
					UnarmedSkill = 9

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Soul = 0

					Blood = 0
					BloodMax = 0

					Faction = "Undead"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.Attack()
						src.NormalAI()
				Undead_Skeleton_Warrior
					name = "{NPC} Undead Skeleton Warrior"
					Fuel = 0
					icon = 'skeleton.dmi'
					icon_state = "N"

					Race = "Skeleton"
					Type = "Skeleton"

					Head = 25
					Torso = 50
					LeftArm = 50
					RightArm = 50
					LeftLeg = 50
					RightLeg = 50

					Skull = 25
					Brain = 0
					LeftEye = 0
					RightEye = 0
					LeftEar = 0
					RightEar = 0
					Teeth = 50
					Nose = 0
					Tongue = 0
					Throat = 0

					Heart = 0
					LeftLung = 0
					RightLung = 0
					Spleen = 0
					Intestine = 0
					LeftKidney = 0
					RightKidney = 0
					Liver = 0
					Bladder = 0
					Stomach = 0

					Strength = 15
					Agility = 11
					Endurance = 15
					Intelligence = 10

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 12
					AxeSkill = 12
					SpearSkill = 12
					BluntSkill = 12
					RangedSkill = 12
					DaggerSkill = 12
					UnarmedSkill = 12

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Soul = 0

					Blood = 0
					BloodMax = 0

					Faction = "Undead"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Weapons/Swords/LongSword/SW = new
						var/obj/Items/Armour/Chest/ChainShirt/R = new
						var/obj/Items/Armour/Legs/ChainLeggings/L = new

						SW.loc = src
						R.loc = src
						L.loc = src

						R.suffix = "Equip"
						SW.suffix = "Equip"
						L.suffix = "Equip"
						SW.Material = "Iron"
						SW.RandomItemQuality()
						L.Material = "Iron"
						L.RandomItemQuality()

						R.Dura = 25
						SW.Dura = 25
						L.Dura = 25

						R.Material = "Iron"
						R.RandomItemQuality()

						src.WLegs = L
						src.Weapon = SW
						src.WChest = R
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
						src.overlays+=image(SW.icon,SW.icon_state,SW.ItemLayer)
						src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)

						src.Attack()
						src.NormalAI()
						var/obj/Items/Currency/GoldCoin/Gold = new
						Gold.loc = src
						Gold.suffix = "Carried"
						Gold.Type = rand(1,5)
						Gold.name = "[Gold.Type] Gold Coins"
						Gold.CoinAdjust()


			Misc
				Troll
					layer = 7.1
					Race = "Troll"
					Type = "HatesLight"
					Troll_TR
						name = "{NPC} Troll"
						icon = 'creatures.dmi'
						icon_state = "troll TR"
						New()
							src.pixel_y = 32
					Troll_TL
						name = "{NPC} Troll"
						icon = 'creatures.dmi'
						icon_state = "troll TL"
						New()
							src.pixel_x = -32
							src.pixel_y = 32
					Troll_BL
						name = "{NPC} Troll"
						icon = 'creatures.dmi'
						icon_state = "troll BL"
						New()
							pixel_x = -32
					Troll
						name = "{NPC} Troll"
						icon = 'creatures.dmi'
						icon_state = "troll BR"

						Humanoid = 0

						Strength = 35
						Agility = 20
						Endurance = 40
						Intelligence = 1

						StrengthMulti = 0.3
						AgilityMulti = 0.2
						EnduranceMulti = 0.3
						IntelligenceMulti = 0.3

						SwordSkill = 5
						AxeSkill = 5
						SpearSkill = 5
						BluntSkill = 5
						RangedSkill = 5
						DaggerSkill = 5
						UnarmedSkill = 35

						SwordSkillMulti = 0.1
						AxeSkillMulti = 0.1
						SpearSkillMulti = 0.1
						BluntSkillMulti = 0.1
						RangedSkillMulti = 0.1
						DaggerSkillMulti = 0.1
						UnarmedSkillMulti = 0.3

						Blood = 200
						BloodMax = 200
						BloodColour = /obj/Misc/Gore/BloodSplat/
						BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

						HP = 400
						HPMAX = 400

						Soul = 0

						Faction = "Goblin Hordes"

						HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
						New()
							spawn(1)
								var/image/I = new('Target.dmi',src)
								src.TargetIcon = I
								src.DeadIcon = 'corpses.dmi'
								src.DeadState = "troll corpse left"
								src.Attack()
								src.BloodFlow()
								var/mob/NPC/Evil/Misc/Troll/Troll_BL/T1 = new
								var/mob/NPC/Evil/Misc/Troll/Troll_TL/T2 = new
								var/mob/NPC/Evil/Misc/Troll/Troll_TR/T3 = new
								src.overlays += T1
								src.overlays += T2
								src.overlays += T3
								src.NormalAI()
				Drake
					layer = 7.1
					Race = "Dragon"
					Drake_TR
						name = "{NPC} Drake"
						icon = 'creatures.dmi'
						icon_state = "drake tr"
						New()
							src.pixel_y = 32
					Drake_TL
						name = "{NPC} Drake"
						icon = 'creatures.dmi'
						icon_state = "drake tl"
						New()
							src.pixel_x = -32
							src.pixel_y = 32
					Drake_BL
						name = "{NPC} Drake"
						icon = 'creatures.dmi'
						icon_state = "drake bl"
						New()
							pixel_x = -32
					Drake
						name = "{NPC} Drake"
						icon = 'creatures.dmi'
						icon_state = "drake br"

						Humanoid = 0

						Strength = 75
						Agility = 70
						Endurance = 75
						Intelligence = 20

						StrengthMulti = 0.3
						AgilityMulti = 0.3
						EnduranceMulti = 0.3
						IntelligenceMulti = 0.3

						SwordSkill = 70
						AxeSkill = 5
						SpearSkill = 5
						BluntSkill = 5
						RangedSkill = 5
						DaggerSkill = 5
						UnarmedSkill = 5

						SwordSkillMulti = 0.3
						AxeSkillMulti = 0.1
						SpearSkillMulti = 0.1
						BluntSkillMulti = 0.1
						RangedSkillMulti = 0.1
						DaggerSkillMulti = 0.1
						UnarmedSkillMulti = 0.3

						Claws = 100

						Blood = 500
						BloodMax = 500
						BloodColour = /obj/Misc/Gore/BloodSplat/
						BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

						HP = 1000
						HPMAX = 1000

						Soul = 0

						Faction = "Dragons"

						HateList = list("Illithid Cultists","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Spider Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes","None","Cyclops Hordes")
						New()
							spawn(1)
								var/image/I = new('Target.dmi',src)
								src.TargetIcon = I

								src.DeadIcon = 'corpses.dmi'
								src.DeadState = "drake corpse left"
								src.Attack()
								src.BloodFlow()
								var/mob/NPC/Evil/Misc/Drake/Drake_BL/D1 = new
								var/mob/NPC/Evil/Misc/Drake/Drake_TL/D2 = new
								var/mob/NPC/Evil/Misc/Drake/Drake_TR/D3 = new
								src.overlays += D1
								src.overlays += D2
								src.overlays += D3
								src.NormalAI()
				GiantSnake
					GiantSnake_Top
						icon = 'creatures.dmi'
						icon_state = "giant snake top"
						pixel_y = 32
						layer = 8
					GiantSnake_Bottom
						name = "{NPC} Giant Snake"
						icon = 'creatures.dmi'
						icon_state = "giant snake bottom"
						Type = "DesertArea"
						Race = "GiantSnake"

						Humanoid = 0

						Strength = 20
						Agility = 35
						Endurance = 20
						Intelligence = 5

						StrengthMulti = 0.1
						AgilityMulti = 0.2
						EnduranceMulti = 0.1
						IntelligenceMulti = 0.1

						SwordSkill = 40
						AxeSkill = 5
						SpearSkill = 5
						BluntSkill = 5
						RangedSkill = 5
						DaggerSkill = 5
						UnarmedSkill = 5

						SwordSkillMulti = 0.2
						AxeSkillMulti = 0.2
						SpearSkillMulti = 0.2
						BluntSkillMulti = 0.2
						RangedSkillMulti = 0.2
						DaggerSkillMulti = 0.2
						UnarmedSkillMulti = 0.4

						Claws = 100

						Soul = 0

						HP = 325
						HPMAX = 325

						Blood = 150
						BloodMax = 150
						BloodColour = /obj/Misc/Gore/BloodSplat/
						BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

						Faction = "Snakeman Empire"

						HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Goblin Hordes","Spider Hordes","Dangerous Beasts","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
						New()
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/G = rand(1,2)
							if(G == 1)
								src.Gender = "Male"
							if(G == 2)
								src.Gender = "Female"
							src.DeadIcon = 'corpses.dmi'
							src.DeadState = "giant snake corpse left"
							src.Attack()
							src.BloodFlow()
							src.Regen()
							src.NormalAI()
							var/mob/NPC/Evil/Misc/GiantSnake/GiantSnake_Top/T = new
							src.overlays += T
				Yeti
					layer = 7.1
					Yeti_Top
						icon = 'yeti.dmi'
						icon_state = "Top"
						pixel_y = 32
						layer = 8
					Yeti_Right
						icon = 'yeti.dmi'
						icon_state = "Right"
						pixel_y = 32
						pixel_x = 32
						layer = 8
					Yeti_Left
						icon = 'yeti.dmi'
						icon_state = "Left"
						pixel_y = 32
						pixel_x = -32
						layer = 8
					Yeti_Bottom
						name = "{NPC} Yeti"
						icon = 'yeti.dmi'
						icon_state = "Bottom"
						Type = "SnowArea"
						Race = "Yeti"

						Humanoid = 0

						Strength = 35
						Agility = 25
						Endurance = 35
						Intelligence = 5

						StrengthMulti = 0.3
						AgilityMulti = 0.2
						EnduranceMulti = 0.3
						IntelligenceMulti = 0.1

						SwordSkill = 35
						AxeSkill = 5
						SpearSkill = 5
						BluntSkill = 5
						RangedSkill = 5
						DaggerSkill = 5
						UnarmedSkill = 5

						SwordSkillMulti = 0.2
						AxeSkillMulti = 0.2
						SpearSkillMulti = 0.2
						BluntSkillMulti = 0.2
						RangedSkillMulti = 0.2
						DaggerSkillMulti = 0.2
						UnarmedSkillMulti = 0.4

						Claws = 100

						Soul = 0

						HP = 400
						HPMAX = 400

						Blood = 200
						BloodMax = 200
						BloodColour = /obj/Misc/Gore/BloodSplat/
						BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

						Faction = "Dangerous Beasts"

						HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
						New()
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							var/G = rand(1,2)
							if(G == 1)
								src.Gender = "Male"
							if(G == 2)
								src.Gender = "Female"
							src.DeadIcon = 'corpses.dmi'
							src.DeadState = "yeti corpse left"
							src.Attack()
							src.BloodFlow()
							src.Regen()
							src.NormalAI()
							var/mob/NPC/Evil/Misc/Yeti/Yeti_Top/T = new
							src.overlays += T
							var/mob/NPC/Evil/Misc/Yeti/Yeti_Right/R = new
							src.overlays += R
							var/mob/NPC/Evil/Misc/Yeti/Yeti_Left/L = new
							src.overlays += L
							src.Noise()
				Gremlin
					name = "{NPC} Gremlin"
					icon = 'creatures.dmi'
					icon_state = "gremlin"
					Race = "Gremlin"

					see_in_dark = 5

					Humanoid = 0

					Strength = 2.5
					Agility = 30
					Endurance = 2.5
					Intelligence = 2.5

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 10

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.2

					Claws = 100

					Soul = 0

					HP = 50
					HPMAX = 50

					Blood = 20
					BloodMax = 20
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Gremlin Hordes"

					HateList = list("Lizardman Tribes","Kobold Hordes","Goblin Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/G = rand(1,2)
						if(G == 1)
							src.Gender = "Male"
						if(G == 2)
							src.Gender = "Female"
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						spawn(10)
							if(src.Type == "Leader")
								src.NormalAI()
								return
							var/FoundLeader = 0
							for(var/mob/NPC/M in view(4,src))
								if(M.Type == "Leader")
									src.Owner = M
									FoundLeader = 1
							if(FoundLeader)
								src.FollowAI()
							else
								src.NormalAI()
				Kobold
					name = "{NPC} Kobold"
					icon = 'Kobold.dmi'
					icon_state = "N"
					Race = "Kobold"

					see_in_dark = 4

					Head = 30
					Torso = 30
					LeftArm = 30
					RightArm = 30
					LeftLeg = 30
					RightLeg = 30

					Skull = 30
					Brain = 30
					LeftEye = 30
					RightEye = 30
					LeftEar = 30
					RightEar = 30
					Teeth = 30
					Nose = 30
					Tongue = 30
					Throat = 30

					Heart = 30
					LeftLung = 30
					RightLung = 30
					Spleen = 30
					Intestine = 30
					LeftKidney = 30
					RightKidney = 30
					Liver = 30
					Bladder = 30
					Stomach = 30

					Strength = 5
					Agility = 15
					Endurance = 5
					Intelligence = 5

					StrengthMulti = 0.1
					AgilityMulti = 0.2
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 10
					UnarmedSkill = 5

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.2

					Soul = 0

					Blood = 35
					BloodMax = 35
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Kobold Hordes"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Goblin Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/G = rand(1,2)
						if(G == 1)
							src.Gender = "Male"
						if(G == 2)
							src.Gender = "Female"
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						var/obj/Items/Weapons/Daggers/Dagger/D = new
						D.Delete = 1
						D.Material = "Iron"
						D.RandomItemQuality()
						src.Weapon = D
						D.suffix = "Equip"
						D.loc = src
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
						var/obj/Items/Currency/GoldCoin/Gold = new
						Gold.loc = src
						Gold.suffix = "Carried"
						Gold.Type = rand(1,2)
						Gold.name = "[Gold.Type] Gold Coins"
						Gold.CoinAdjust()
						spawn(10)
							if(src.Type == "Leader")
								src.NormalAI()
								return
							var/FoundLeader = 0
							for(var/mob/NPC/M in view(4,src))
								if(M.Type == "Leader")
									src.Owner = M
									FoundLeader = 1
							if(FoundLeader)
								src.FollowAI()
							else
								src.NormalAI()
				Orc
					name = "{NPC} Orc"
					icon = 'orc.dmi'
					icon_state = "N"
					Race = "Orc"

					see_in_dark = 3

					Head = 125
					Torso = 125
					LeftArm = 125
					RightArm = 125
					LeftLeg = 125
					RightLeg = 125

					Skull = 125
					Brain = 125
					LeftEye = 125
					RightEye = 125
					LeftEar = 125
					RightEar = 125
					Teeth = 125
					Nose = 125
					Tongue = 125
					Throat = 125

					Heart = 125
					LeftLung = 125
					RightLung = 125
					Spleen = 125
					Intestine = 125
					LeftKidney = 125
					RightKidney = 125
					Liver = 125
					Bladder = 125
					Stomach = 125

					Strength = 20
					Agility = 15
					Endurance = 25
					Intelligence = 5

					StrengthMulti = 0.2
					AgilityMulti = 0.1
					EnduranceMulti = 0.25
					IntelligenceMulti = 0.1

					SwordSkill = 15
					AxeSkill = 15
					SpearSkill = 5
					BluntSkill = 15
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 15

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.2

					Blood = 125
					BloodMax = 125
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Orc Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Goblin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/G = rand(1,2)
						if(G == 1)
							src.Gender = "Male"
						if(G == 2)
							src.Gender = "Female"
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						var/obj/Items/Weapons/Daggers/Dagger/D = new
						D.Material = "Iron"
						D.RandomItemQuality()
						src.Weapon = D
						D.suffix = "Equip"
						D.loc = src
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
						spawn(10)
							if(src.Type == "Leader")
								src.NormalAI()
								return
							var/FoundLeader = 0
							for(var/mob/NPC/M in view(4,src))
								if(M.Type == "Leader")
									src.Owner = M
									FoundLeader = 1
							if(FoundLeader)
								src.FollowAI()
							else
								src.NormalAI()
				Goblin
					name = "{NPC} Goblin"
					icon = 'goblin.dmi'
					icon_state = "N"
					Race = "Goblin"
					Type = "HatesLight"

					see_in_dark = 4

					Head = 40
					Torso = 40
					LeftArm = 40
					RightArm = 40
					LeftLeg = 40
					RightLeg = 40

					Skull = 40
					Brain = 40
					LeftEye = 40
					RightEye = 40
					LeftEar = 40
					RightEar = 40
					Teeth = 40
					Nose = 40
					Tongue = 40
					Throat = 40

					Heart = 40
					LeftLung = 40
					RightLung = 40
					Spleen = 40
					Intestine = 40
					LeftKidney = 40
					RightKidney = 40
					Liver = 40
					Bladder = 40
					Stomach = 40

					Strength = 5
					Agility = 10
					Endurance = 5
					Intelligence = 5

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 5

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.2

					Blood = 45
					BloodMax = 45
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Soul = 0

					Faction = "Goblin Hordes"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/G = rand(1,2)
						if(G == 1)
							src.Gender = "Male"
						if(G == 2)
							src.Gender = "Female"
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						var/obj/Items/Weapons/Daggers/Dagger/D = new
						D.Material = "Iron"
						D.RandomItemQuality()
						src.Weapon = D
						D.suffix = "Equip"
						D.loc = src
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
						var/obj/Items/Currency/GoldCoin/Gold = new
						Gold.loc = src
						Gold.suffix = "Carried"
						Gold.Type = rand(1,3)
						Gold.name = "[Gold.Type] Gold Coins"
						Gold.CoinAdjust()
						spawn(10)
							if(src.Type == "Leader")
								src.NormalAI()
								return
							var/FoundLeader = 0
							for(var/mob/NPC/M in view(4,src))
								if(M.Type == "Leader")
									src.Owner = M
									FoundLeader = 1
							if(FoundLeader)
								src.FollowAI()
							else
								src.NormalAI()
				Human_Heretic
					icon = 'human.dmi'
					icon_state = "N"
					Type = "Bandits"
					Race = "Human"

					Head = 50
					Torso = 50
					LeftArm = 50
					RightArm = 50
					LeftLeg = 50
					RightLeg = 50

					Skull = 50
					Brain = 50
					LeftEye = 50
					RightEye = 50
					LeftEar = 50
					RightEar = 50
					Teeth = 50
					Nose = 50
					Tongue = 50
					Throat = 50

					Heart = 50
					LeftLung = 50
					RightLung = 50
					Spleen = 50
					Intestine = 50
					LeftKidney = 50
					RightKidney = 50
					Liver = 50
					Bladder = 50
					Stomach = 50

					Strength = 7
					Agility = 7
					Endurance = 7
					Intelligence = 5

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 7
					AxeSkill = 7
					SpearSkill = 7
					BluntSkill = 7
					RangedSkill = 7
					DaggerSkill = 7
					UnarmedSkill = 7

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.2

					Soul = 0

					Blood = 50
					BloodMax = 50
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Human Empire Unholy"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Snakeman Empire","Human Empire Outlaw","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/G = rand(1,2)
						if(G == 1)
							src.Gender = "Male"
						if(G == 2)
							src.Gender = "Female"
							src.icon = 'Human(F).dmi'
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
						src.GiveName()
						src.GiveHair()
						src.name = "[src.name] The Heretic"
						var/obj/Items/Weapons/Daggers/Dagger/D = new
						D.Material = "Iron"
						D.RandomItemQuality()
						src.Weapon = D
						D.suffix = "Equip"
						D.loc = src
						var/obj/Items/Armour/UpperBody/LeatherVest/LV = new
						src.WChest = LV
						LV.suffix = "Equip"
						LV.loc = src
						var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.loc = src
						var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
						src.WLeftFoot = LBL
						LBL.suffix = "Equip"
						LBL.loc = src
						var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
						src.WRightFoot = LBR
						LBR.suffix = "Equip"
						LBR.loc = src
						var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
						src.WLeftHand = LGL
						LGL.suffix = "Equip"
						LGL.loc = src
						var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
						src.WRightHand = LGR
						LGR.suffix = "Equip"
						LGR.loc = src
						var/obj/Items/Armour/Back/ClothCape/CC = new
						src.WBack = CC
						CC.suffix = "Equip"
						CC.loc = src
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
						src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
						src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
						src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
						src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
						src.overlays+=image(CC.icon,CC.icon_state,CC.ItemLayer)
				Human_Bandit
					icon = 'human.dmi'
					icon_state = "N"
					Type = "Bandits"
					Race = "Human"

					Head = 65
					Torso = 65
					LeftArm = 65
					RightArm = 65
					LeftLeg = 65
					RightLeg = 65

					Skull = 65
					Brain = 65
					LeftEye = 65
					RightEye = 65
					LeftEar = 65
					RightEar = 65
					Teeth = 65
					Nose = 65
					Tongue = 65
					Throat = 65

					Heart = 65
					LeftLung = 65
					RightLung = 65
					Spleen = 65
					Intestine = 65
					LeftKidney = 65
					RightKidney = 65
					Liver = 65
					Bladder = 65
					Stomach = 65

					Strength = 10
					Agility = 10
					Endurance = 10
					Intelligence = 5

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 10
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 10

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.2

					Soul = 0

					Blood = 60
					BloodMax = 60
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Human Empire Outlaw"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Snakeman Empire","Human Empire Unholy","Ratling Hordes","None")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/G = rand(1,2)
						if(G == 1)
							src.Gender = "Male"
						if(G == 2)
							src.Gender = "Female"
							src.icon = 'Human(F).dmi'
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.GiveName()
						src.GiveHair()
						src.name = "[src.name] The Bandit"
						var/obj/Items/Weapons/Swords/Sabre/S = new
						S.Material = "Iron"
						S.RandomItemQuality()
						src.Weapon = S
						S.suffix = "Equip"
						S.loc = src
						var/obj/Items/Armour/Chest/ChainShirt/CS = new
						CS.Material = "Iron"
						CS.RandomItemQuality()
						src.WChest = CS
						CS.suffix = "Equip"
						CS.loc = src
						var/obj/Items/Armour/UpperBody/LeatherVest/LV = new
						src.WChest = LV
						LV.suffix = "Equip"
						LV.loc = src
						var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.loc = src
						var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
						src.WLeftFoot = LBL
						LBL.suffix = "Equip"
						LBL.loc = src
						var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
						src.WRightFoot = LBR
						LBR.suffix = "Equip"
						LBR.loc = src
						var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
						src.WLeftHand = LGL
						LGL.suffix = "Equip"
						LGL.loc = src
						var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
						src.WRightHand = LGR
						LGR.suffix = "Equip"
						LGR.loc = src
						for(var/obj/Items/Q in src)
							Q.layer = Q.ItemLayer
							Q.icon_state = Q.EquipState
						src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
						src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
						src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
						src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
						src.overlays+=image(CS.icon,CS.icon_state,CS.ItemLayer)
						src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
						var/obj/Items/Currency/GoldCoin/Gold = new
						Gold.loc = src
						Gold.suffix = "Carried"
						Gold.Type = rand(2,5)
						Gold.name = "[Gold.Type] Gold Coins"
						Gold.CoinAdjust()
						spawn(10)
							if(src.Type == "Leader")
								src.NormalAI()
								return
							var/FoundLeader = 0
							for(var/mob/NPC/M in view(4,src))
								if(M.Type == "Leader")
									src.Owner = M
									FoundLeader = 1
							if(FoundLeader)
								src.FollowAI()
							else
								src.NormalAI()
				Wolfman_Warrior
					name = "{NPC} Wolfman Warrior"
					icon = 'wolfman white.dmi'
					icon_state = "N"
					Race = "Wolfman"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 55
					Agility = 55
					Endurance = 55
					Intelligence = 1

					StrengthMulti = 0.2
					AgilityMulti = 0.1
					EnduranceMulti = 0.2
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 50

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.3
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.3

					Soul = 0

					Blood = 110
					BloodMax = 110
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Dangerous Beasts"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Spider Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes")
					New()
						spawn(10)
							if(src)
								var/image/I = new('Target.dmi',src)
								src.TargetIcon = I
								src.GuardLoc = src.loc
								src.GuardDir = src.dir
								src.DeadIcon = src.icon
								src.Attack()
								src.BloodFlow()
								src.GuardAI()
				Wolfman_Shaman
					name = "{NPC} Wolfman Shaman"
					icon = 'wolfman white.dmi'
					icon_state = "N"
					Race = "Wolfman"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 55
					Agility = 55
					Endurance = 55
					Intelligence = 1

					StrengthMulti = 0.3
					AgilityMulti = 0.2
					EnduranceMulti = 0.3
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 50

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.3
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.3

					Soul = 0

					Blood = 135
					BloodMax = 135
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Dangerous Beasts"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Spider Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes")
					New()
						spawn(10)
							if(src)
								var/image/I = new('Target.dmi',src)
								src.TargetIcon = I
								src.GuardLoc = src.loc
								src.GuardDir = src.dir
								src.DeadIcon = src.icon
								src.Attack()
								src.BloodFlow()
								src.GuardAI()
								src.Regen()
								src.Ressurect()
				Cyclops_Shaman
					name = "{NPC} Cyclops Shaman"
					icon = 'cyclops.dmi'
					icon_state = "N"
					Race = "Cyclops"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 60
					Agility = 40
					Endurance = 60
					Intelligence = 1

					StrengthMulti = 0.3
					AgilityMulti = 0.2
					EnduranceMulti = 0.3
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 50
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 60

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.3
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.3

					Soul = 0

					Blood = 175
					BloodMax = 175
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Cyclops Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Spider Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes")
					New()
						spawn(10)
							if(src)
								var/image/I = new('Target.dmi',src)
								src.TargetIcon = I
								var/obj/Items/Armour/LeftFoot/GiantChainBootLeft/GBL = new
								GBL.Material = "Iron"
								GBL.RandomItemQuality()
								src.WLeftFoot = GBL
								GBL.suffix = "Equip"
								GBL.loc = src
								var/obj/Items/Armour/RightFoot/GiantChainBootRight/GBR = new
								GBR.Material = "Iron"
								GBR.RandomItemQuality()
								src.WRightFoot = GBR
								GBR.suffix = "Equip"
								GBR.loc = src
								var/obj/Items/Armour/RightArm/GiantChainGloveRight/GGR = new
								GGR.Material = "Iron"
								GGR.RandomItemQuality()
								src.WRightHand = GGR
								GGR.suffix = "Equip"
								GGR.loc = src
								var/obj/Items/Armour/LeftArm/GiantChainGloveLeft/GGL = new
								GGL.Material = "Iron"
								GGL.RandomItemQuality()
								src.WLeftHand = GGL
								GGL.suffix = "Equip"
								GGL.loc = src
								var/obj/Items/Armour/Chest/GiantChainShirt/IS = new
								IS.Material = "Iron"
								IS.RandomItemQuality()
								src.WChest = IS
								IS.suffix = "Equip"
								IS.loc = src
								var/obj/Items/Armour/UpperBody/GiantLeatherVest/LV = new
								src.WChest = LV
								LV.suffix = "Equip"
								LV.loc = src
								var/obj/Items/Armour/Legs/GiantChainLeggings/LL = new
								LL.Material = "Iron"
								LL.RandomItemQuality()
								src.WLegs = LL
								LL.suffix = "Equip"
								LL.loc = src
								for(var/obj/Items/Q in src)
									Q.layer = Q.ItemLayer
									Q.icon_state = Q.EquipState
								src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
								src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
								src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)
								src.overlays+=image(GGR.icon,GGR.icon_state,GGR.ItemLayer)
								src.overlays+=image(GGL.icon,GGL.icon_state,GGL.ItemLayer)
								src.overlays+=image(GBR.icon,GBR.icon_state,GBR.ItemLayer)
								src.overlays+=image(GBL.icon,GBL.icon_state,GBL.ItemLayer)
								src.GuardLoc = src.loc
								src.GuardDir = src.dir
								src.DeadIcon = src.icon
								src.Attack()
								src.BloodFlow()
								src.GuardAI()
								src.Regen()
								src.Ressurect()
				Cyclops_Guardsman_Patrol
					icon = 'cyclops.dmi'
					icon_state = "N"
					Type = "Town"
					Race = "Cyclops"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 65
					Agility = 45
					Endurance = 65
					Intelligence = 1

					StrengthMulti = 0.3
					AgilityMulti = 0.2
					EnduranceMulti = 0.3
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 50
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 50

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.3
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.3

					Soul = 0

					Blood = 160
					BloodMax = 160
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Cyclops Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Spider Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Armour/LeftFoot/GiantChainBootLeft/GBL = new
						GBL.Material = "Iron"
						GBL.RandomItemQuality()
						src.WLeftFoot = GBL
						GBL.suffix = "Equip"
						GBL.loc = src
						var/obj/Items/Armour/RightFoot/GiantChainBootRight/GBR = new
						GBR.Material = "Iron"
						GBR.RandomItemQuality()
						src.WRightFoot = GBR
						GBR.suffix = "Equip"
						GBR.loc = src
						var/obj/Items/Armour/RightArm/GiantChainGloveRight/GGR = new
						GGR.Material = "Iron"
						GGR.RandomItemQuality()
						src.WRightHand = GGR
						GGR.suffix = "Equip"
						GGR.loc = src
						var/obj/Items/Armour/LeftArm/GiantChainGloveLeft/GGL = new
						GGL.Material = "Iron"
						GGL.RandomItemQuality()
						src.WLeftHand = GGL
						GGL.suffix = "Equip"
						GGL.loc = src
						var/obj/Items/Armour/Chest/GiantChainShirt/IS = new
						IS.Material = "Iron"
						IS.RandomItemQuality()
						src.WChest = IS
						IS.suffix = "Equip"
						IS.loc = src
						var/obj/Items/Armour/UpperBody/GiantLeatherVest/LV = new
						src.WChest = LV
						LV.suffix = "Equip"
						LV.loc = src
						var/obj/Items/Armour/Legs/GiantChainLeggings/LL = new
						LL.Material = "Iron"
						LL.RandomItemQuality()
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.loc = src
						var/obj/Items/Armour/Head/GiantChainCoif/CC = new
						CC.Material = "Iron"
						CC.RandomItemQuality()
						src.WHead = CC
						CC.suffix = "Equip"
						CC.loc = src
						var/obj/Items/Weapons/Blunts/Maul/M = new
						M.Material = "Iron"
						M.RandomItemQuality()
						src.Weapon = M
						M.suffix = "Equip"
						M.loc = src
						for(var/obj/Items/Q in src)
							Q.layer = Q.ItemLayer
							Q.icon_state = Q.EquipState
						src.overlays+=image(M.icon,M.icon_state,M.ItemLayer)
						src.overlays+=image(CC.icon,CC.icon_state,CC.ItemLayer)
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
						src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)
						src.overlays+=image(GGR.icon,GGR.icon_state,GGR.ItemLayer)
						src.overlays+=image(GGL.icon,GGL.icon_state,GGL.ItemLayer)
						src.overlays+=image(GBR.icon,GBR.icon_state,GBR.ItemLayer)
						src.overlays+=image(GBL.icon,GBL.icon_state,GBL.ItemLayer)
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
						src.Regen()
						src.GiveName()
				Cyclops_Guardsman
					icon = 'cyclops.dmi'
					icon_state = "N"
					Race = "Cyclops"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 65
					Agility = 45
					Endurance = 65
					Intelligence = 1

					StrengthMulti = 0.3
					AgilityMulti = 0.2
					EnduranceMulti = 0.3
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 50
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 50

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.3
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.3

					Soul = 0

					Blood = 160
					BloodMax = 160
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Cyclops Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Spider Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes")
					New()
						spawn(10)
							if(src)
								var/image/I = new('Target.dmi',src)
								src.TargetIcon = I
								var/obj/Items/Armour/LeftFoot/GiantChainBootLeft/GBL = new
								GBL.Material = "Iron"
								GBL.RandomItemQuality()
								src.WLeftFoot = GBL
								GBL.suffix = "Equip"
								GBL.loc = src
								var/obj/Items/Armour/RightFoot/GiantChainBootRight/GBR = new
								GBR.Material = "Iron"
								GBR.RandomItemQuality()
								src.WRightFoot = GBR
								GBR.suffix = "Equip"
								GBR.loc = src
								var/obj/Items/Armour/RightArm/GiantChainGloveRight/GGR = new
								GGR.Material = "Iron"
								GGR.RandomItemQuality()
								src.WRightHand = GGR
								GGR.suffix = "Equip"
								GGR.loc = src
								var/obj/Items/Armour/LeftArm/GiantChainGloveLeft/GGL = new
								GGL.Material = "Iron"
								GGL.RandomItemQuality()
								src.WLeftHand = GGL
								GGL.suffix = "Equip"
								GGL.loc = src
								var/obj/Items/Armour/Chest/GiantChainShirt/IS = new
								IS.Material = "Iron"
								IS.RandomItemQuality()
								src.WChest = IS
								IS.suffix = "Equip"
								IS.loc = src
								var/obj/Items/Armour/UpperBody/GiantLeatherVest/LV = new
								src.WChest = LV
								LV.suffix = "Equip"
								LV.loc = src
								var/obj/Items/Armour/Legs/GiantChainLeggings/LL = new
								LL.Material = "Iron"
								LL.RandomItemQuality()
								src.WLegs = LL
								LL.suffix = "Equip"
								LL.loc = src
								var/obj/Items/Armour/Head/GiantChainCoif/CC = new
								CC.Material = "Iron"
								CC.RandomItemQuality()
								src.WHead = CC
								CC.suffix = "Equip"
								CC.loc = src
								var/obj/Items/Weapons/Blunts/Maul/M = new
								M.Material = "Iron"
								M.RandomItemQuality()
								src.Weapon = M
								M.suffix = "Equip"
								M.loc = src
								for(var/obj/Items/Q in src)
									Q.layer = Q.ItemLayer
									Q.icon_state = Q.EquipState
								src.overlays+=image(M.icon,M.icon_state,M.ItemLayer)
								src.overlays+=image(CC.icon,CC.icon_state,CC.ItemLayer)
								src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
								src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
								src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)
								src.overlays+=image(GGR.icon,GGR.icon_state,GGR.ItemLayer)
								src.overlays+=image(GGL.icon,GGL.icon_state,GGL.ItemLayer)
								src.overlays+=image(GBR.icon,GBR.icon_state,GBR.ItemLayer)
								src.overlays+=image(GBL.icon,GBL.icon_state,GBL.ItemLayer)
								src.GuardLoc = src.loc
								src.GuardDir = src.dir
								src.DeadIcon = src.icon
								src.Attack()
								src.BloodFlow()
								src.GuardAI()
								src.Regen()
								src.GiveName()
				Lizardman
					icon = 'lizardman.dmi'
					icon_state = "N"
					name = "{NPC} Lizardman"
					Race = "Lizardman"
					Head = 115
					Torso = 115
					LeftArm = 115
					RightArm = 115
					LeftLeg = 115
					RightLeg = 115

					Skull = 115
					Brain = 115
					LeftEye = 115
					RightEye = 115
					LeftEar = 115
					RightEar = 115
					Teeth = 115
					Nose = 115
					Tongue = 115
					Throat = 115

					Heart = 115
					LeftLung = 115
					RightLung = 115
					Spleen = 115
					Intestine = 115
					LeftKidney = 115
					RightKidney = 115
					Liver = 115
					Bladder = 115
					Stomach = 115

					Strength = 10
					Agility = 15
					Endurance = 15
					Intelligence = 1

					StrengthMulti = 0.13
					AgilityMulti = 0.13
					EnduranceMulti = 0.13
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 15
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 15
					ShieldSkill = 15

					SwordSkillMulti = 0.13
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.13
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.13

					Soul = 0

					Blood = 75
					BloodMax = 75
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/
					CanRegenLimbs = 1
					Claws = 100

					Faction = "Lizardman Tribes"

					HateList = list("Cyclops Hordes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Giant Hordes","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Spider Hordes","Goblin Hordes","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
				Evil_Cyclops
					icon = 'cyclops.dmi'
					icon_state = "N"
					Race = "Cyclops"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 20
					Agility = 15
					Endurance = 20
					Intelligence = 1

					StrengthMulti = 0.3
					AgilityMulti = 0.2
					EnduranceMulti = 0.3
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 25

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.2
					SpearSkillMulti = 0.2
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.4

					Soul = 0

					Blood = 125
					BloodMax = 125
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Cyclops Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Spider Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
						src.GiveName()
						src.name = "[src.name] The Cyclops"
						var/obj/Items/Armour/UpperBody/GiantLeatherVest/LV = new
						src.WChest = LV
						LV.suffix = "Equip"
						LV.loc = src
						var/obj/Items/Armour/Legs/GiantLeatherLeggings/LL = new
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.loc = src
						for(var/obj/Items/Q in src)
							Q.layer = Q.ItemLayer
							Q.icon_state = Q.EquipState
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
				Spider_Egg
					icon = 'misc.dmi'
					icon_state = "spider eggs"
					Race = "GiantSpider"
					density = 0

					Humanoid = 0

					Type = "Egg"

					Blood = 100
					BloodMax = 100
					BloodColour = /obj/Misc/Gore/GreenBloodSplat/
					BloodWallColour = /obj/Misc/Gore/GreenWallBloodSplat/

					HP = 100
					HPMAX = 100

					Soul = 0

					Faction = "Spider Hordes"
					Click()
						if(usr.Function == "Combat")
							usr.Target = src
							usr << "<b>You target [src]!<br>"

						if(usr.Function == "Pull")
							if(src in range(1,usr))
								if(usr.Pull == src)
									usr.Pull = null
									if(src.Pull == usr)
										src.Pull = null
									view(usr) << "<b>[usr] stops pulling [src]<br>"
									return
								if(src.suffix == null)
									if(usr.Pull == null)
										usr.Pull = src
										src.Pull = usr
										usr.Pull()
										view(usr) << "<b>[usr] starts pulling [src]<br>"
										return
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.DeadIcon = 'misc.dmi'
						src.DeadState = "spider egg dead"
						src.BloodFlow()
						src.SpiderEggHatch()
				Sea_Monster
					name = "{NPC} Sea Monster"
					icon = 'creatures.dmi'
					icon_state = "sea monster"

					Race = "Sea Monster"

					Humanoid = 0

					Strength = 20
					Agility = 30
					Endurance = 20
					Intelligence = 1

					StrengthMulti = 0.1
					AgilityMulti = 0.3
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.05

					SwordSkill = 25
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 5

					SwordSkillMulti = 0.2
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					Blood = 135
					BloodMax = 135
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					HP = 200
					HPMAX = 200

					Soul = 0

					Faction = "Dangerous Beasts"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "sea monster corpse"
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
				Baby_Giant_Spider
					name = "{NPC} Baby Giant Spider"
					icon = 'creatures.dmi'
					icon_state = "baby giant spider"
					Race = "GiantSpider"

					Humanoid = 0

					Strength = 5
					Agility = 10
					Endurance = 5
					Intelligence = 0.5

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 5

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					Blood = 35
					BloodMax = 35
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					HP = 40
					HPMAX = 40

					Soul = 0

					Faction = "Spider Hordes"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "baby giant spider corpse"
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
						spawn(1500)
							if(src)
								view(src) << "<font color = purple>[src] begins to grow larger and more deadly!<br>"
								var/mob/NPC/Evil/Misc/Giant_Spider/GS = new
								GS.loc = src.loc
								del(src)
				Swamp_Monster
					name = "{NPC} Swamp Monster"
					icon = 'creatures.dmi'
					icon_state = "swamp monster"
					Race = "Monster"
					Type = "SwampArea"

					Humanoid = 0

					Strength = 18
					Agility = 12
					Endurance = 25
					Intelligence = 2

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 22
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 22

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					Blood = 200
					BloodMax = 200
					BloodColour = /obj/Misc/Gore/GreenBloodSplat/
					BloodWallColour = /obj/Misc/Gore/GreenWallBloodSplat/

					HP = 200
					HPMAX = 200

					Soul = 0

					Faction = "Dangerous Beasts"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Spider Hordes","Cyclops Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "swamp monster corpse"
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
				Scorpion
					name = "{NPC} Scorpion"
					icon = 'creatures.dmi'
					icon_state = "scorpion"
					Race = "Scorpion"
					Type = "DesertArea"

					Humanoid = 0

					Strength = 7
					Agility = 7
					Endurance = 15
					Intelligence = 2

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 20
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 10

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					Blood = 50
					BloodMax = 50
					BloodColour = /obj/Misc/Gore/GreenBloodSplat/
					BloodWallColour = /obj/Misc/Gore/GreenWallBloodSplat/

					HP = 75
					HPMAX = 75

					Soul = 0

					Faction = "Dangerous Beasts"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Spider Hordes","Cyclops Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "scorpion corpse"
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
				Large_Scorpion
					name = "{NPC} Large Scorpion"
					icon = 'creatures.dmi'
					icon_state = "large scorpion"
					Race = "LargeScorpion"
					Type = "DesertArea"

					Humanoid = 0

					Strength = 17
					Agility = 17
					Endurance = 25
					Intelligence = 2

					StrengthMulti = 0.1
					AgilityMulti = 0.1
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 20
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 20

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					Blood = 100
					BloodMax = 100
					BloodColour = /obj/Misc/Gore/GreenBloodSplat/
					BloodWallColour = /obj/Misc/Gore/GreenWallBloodSplat/

					HP = 150
					HPMAX = 150

					Soul = 0

					Faction = "Dangerous Beasts"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Spider Hordes","Cyclops Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "large scorpion corpse"
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
				Giant_Spider
					name = "{NPC} Giant Spider"
					icon = 'creatures.dmi'
					icon_state = "giant spider"
					Race = "GiantSpider"

					Humanoid = 0

					Strength = 10
					Agility = 15
					Endurance = 10
					Intelligence = 2

					StrengthMulti = 0.1
					AgilityMulti = 0.2
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 15
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 15

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					Blood = 60
					BloodMax = 60
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					HP = 100
					HPMAX = 100

					Soul = 0

					Faction = "Spider Hordes"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "giant spider corpse"
						src.Attack()
						src.BloodFlow()
						src.SpiderAI()

			Chaos
				Sewer_Rat
					name = "{NPC} Sewer Rat"
					icon = 'creatures.dmi'
					icon_state = "rat"

					Humanoid = 0

					Strength = 4
					Agility = 6
					Endurance = 4
					Intelligence = 2

					StrengthMulti = 0.1
					AgilityMulti = 0.2
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 5

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Blood = 30
					BloodMax = 30
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					HP = 15
					HPMAX = 15

					Soul = 0

					Faction = "Ratling Hordes"
					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/G = rand(1,2)
						if(G == 1)
							src.Gender = "Male"
						if(G == 2)
							src.Gender = "Female"

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "dead rat"
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
				Ratling_Merchant
					icon = 'ratling.dmi'
					icon_state = "N"
					Type = "Merchant"
					name = "{NPC} Merchant"
					Race = "Ratling"

					Head = 110
					Torso = 110
					LeftArm = 110
					RightArm = 110
					LeftLeg = 110
					RightLeg = 110

					Skull = 110
					Brain = 110
					LeftEye = 110
					RightEye = 110
					LeftEar = 110
					RightEar = 110
					Teeth = 110
					Nose = 110
					Tongue = 110
					Throat = 110

					Heart = 110
					LeftLung = 110
					RightLung = 110
					Spleen = 110
					Intestine = 110
					LeftKidney = 110
					RightKidney = 110
					Liver = 110
					Bladder = 110
					Stomach = 110

					Strength = 25
					Agility = 25
					Endurance = 25
					Intelligence = 25

					StrengthMulti = 0.2
					AgilityMulti = 0.2
					EnduranceMulti = 0.2
					IntelligenceMulti = 0.2

					SwordSkill = 25
					AxeSkill = 25
					SpearSkill = 25
					BluntSkill = 25
					RangedSkill = 25
					DaggerSkill = 25
					UnarmedSkill = 25

					SwordSkillMulti = 0.3
					AxeSkillMulti = 0.3
					SpearSkillMulti = 0.3
					BluntSkillMulti = 0.3
					RangedSkillMulti = 0.3
					DaggerSkillMulti = 0.3
					UnarmedSkillMulti = 0.3

					Blood = 110
					BloodMax = 110
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/
					Faction = "Ratling Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw")
					Click()
						if(usr.Function == "Interact" && src in range(2,usr))
							if(usr.Faction in src.HateList)
								return
							if(usr.name in src.HateList)
								return
							var/CanUnderstand = 0
							var/obj/Speaking = null
							if(usr.CurrentLanguage)
								Speaking = usr.CurrentLanguage
							for(var/obj/L in src.LangKnow)
								if(L.name == Speaking.name)
									if(L.SpeakPercent > Speaking.SpeakPercent / 1.5)
										CanUnderstand = 1
										src.CurrentLanguage = usr.CurrentLanguage
							if(CanUnderstand)
								src.Speak("Yes yes? Want to buy things?! Give, give shinies!",7)
								for(var/obj/I in usr)
									if(I in src.Selling)
										var/Val = 1
										if(I.Material == "Wood")
											Val += 1
										if(I.Material == "Stone")
											Val += 1
										if(I.Material == "Iron")
											Val += 10
										if(I.Material == "Copper")
											Val += 5
										if(I.Material == "Silver")
											Val += 15
										if(I.Material == "Gold")
											Val += 20
										if(I.Quality)
											Val += I.Quality / 1.5
										if(I.Defence)
											Val += I.Defence / 2
										var/RoundedVal = round(Val)
										src.Speak("You choose [I], good good! Give [RoundedVal] shinies!.",7)
										var/list/menu = new()
										menu += "Buy"
										menu += "Dont Buy"
										var/Result = input(usr,"[src] says - Buy [I] for [RoundedVal] shinies?", "Choose", null) in menu
										if(Result == "Dont Buy")
											return
										if(Result == "Buy")
											for(var/obj/Items/Currency/GoldCoin/Gold in usr)
												if(Gold.Type >= RoundedVal)
													var/CoinsAlready = 0
													for(var/obj/Items/Currency/GoldCoin/C in src)
														CoinsAlready = 1
													if(CoinsAlready == 0)
														var/obj/Items/Currency/GoldCoin/Coin = new
														Coin.Type = RoundedVal
														Gold.Type -= RoundedVal
														Coin.CoinAdjust()
														Gold.CoinAdjust()
														Coin.loc = src
														Coin.suffix = "Carried"
														Coin.name = "[Coin.Type] Gold Coins"
														Gold.name = "[Gold.Type] Gold Coins"
													else
														for(var/obj/Items/Currency/GoldCoin/Coin in src)
															Coin.Type += RoundedVal
															Gold.Type -= RoundedVal
															Coin.CoinAdjust()
															Gold.CoinAdjust()
															Gold.name = "[Gold.Type] Gold Coins"
															Coin.name = "[Coin.Type] Gold Coins"
													if(Gold.Type == 0)
														del(Gold)
													usr.DeleteInventoryMenu()
													if(usr.InvenUp)
														usr.CreateInventory()
													src.Selling -= I
													if(I.ObjectTag == "Weapon")
														I.CanBeCrafted = 1
													if(I.ObjectTag == "Armour")
														I.CanBeCrafted = 1
													src.Speak("Come, come again! Bring more shiney!.",7)
												else
													src.Speak("No have [RoundedVal] shinies so you no buy the [I].",7)
							else
								usr << "<font color = yellow>[src] seems to have no idea what your saying.<br>"
							return
					New()
						spawn(10)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.Regen()
							var/Gen = rand(1,2)
							if(Gen == 1)
								src.Gender = "Male"
							if(Gen == 2)
								src.Gender = "Female"
								src.icon = 'human(F).dmi'
								src.GiveHair()
							src.GiveRaceLanguages()
							src.Selling = list()
							for(var/obj/Items/It in orange(7,src))
								var/Add = 1
								if(It in src.Selling)
									Add = 0
								if(Add)
									src.Selling += It
				Ratling_Assassin
					name = "{NPC} Ratling Assassin"
					icon = 'ratling.dmi'
					icon_state = "N"
					Race = "Ratling"

					Head = 35
					Torso = 35
					LeftArm = 35
					RightArm = 35
					LeftLeg = 35
					RightLeg = 35

					Skull = 35
					Brain = 35
					LeftEye = 35
					RightEye = 35
					LeftEar = 35
					RightEar = 35
					Teeth = 35
					Nose = 35
					Tongue = 35
					Throat = 35

					Heart = 35
					LeftLung = 35
					RightLung = 35
					Spleen = 35
					Intestine = 35
					LeftKidney = 35
					RightKidney = 35
					Liver = 35
					Bladder = 35
					Stomach = 35

					Strength = 5
					Agility = 10
					Endurance = 5
					Intelligence = 2

					StrengthMulti = 0.1
					AgilityMulti = 0.15
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 5
					ShieldSkill = 5

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.1
					ShieldSkillMulti = 0.1

					Soul = 0

					Blood = 40
					BloodMax = 40
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Ratling Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Weapons/Daggers/Dagger/D = new
						var/obj/Items/Weapons/Daggers/Dagger/D2 = new
						var/obj/Items/Armour/Back/SmallClothCloak/CC = new

						D.loc = src
						D2.loc = src
						CC.loc = src


						D.suffix = "Equip"
						D2.suffix = "Equip"
						CC.suffix = "Equip"

						D.Material = "Iron"
						D.RandomItemQuality()
						D2.Material = "Iron"
						D2.RandomItemQuality()

						src.Weapon = D
						src.Weapon2 = D2
						src.WBack = CC
						for(var/obj/Items/Q in src)
							Q.layer = Q.ItemLayer
							Q.icon_state = Q.EquipState
						src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
						src.overlays+=image(D2.icon,"[D2.icon_state] left",D2.ItemLayer)
						src.overlays+=image(CC.icon,CC.icon_state,CC.ItemLayer)

						src.GuardLoc = src.loc
						src.GuardDir = src.dir
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
						src.Regen()
				Ratling_Priest
					name = "{NPC} Ratling Priest"
					icon = 'ratling.dmi'
					icon_state = "N"
					Race = "Ratling"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 40
					Agility = 65
					Endurance = 40
					Intelligence = 40

					StrengthMulti = 0.15
					AgilityMulti = 0.2
					EnduranceMulti = 0.15
					IntelligenceMulti = 0.2

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 40
					ShieldSkill = 5

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.3
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.4
					DaggerSkillMulti = 0.4
					UnarmedSkillMulti = 0.4
					ShieldSkillMulti = 0.4

					Soul = 0

					Blood = 110
					BloodMax = 110
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Ratling Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Weapons/Daggers/Dagger/D = new
						var/obj/Items/Armour/Back/SmallClothCloak/CC = new

						D.loc = src
						CC.loc = src


						D.suffix = "Equip"
						CC.suffix = "Equip"

						D.Material = "Iron"
						D.RandomItemQuality()

						src.Weapon = D
						src.WBack = CC
						for(var/obj/Items/Q in src)
							Q.layer = Q.ItemLayer
							Q.icon_state = Q.EquipState
						src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
						src.overlays+=image(CC.icon,CC.icon_state,CC.ItemLayer)
						src.GuardLoc = src.loc
						src.GuardDir = src.dir
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.GuardAI()
						src.Regen()
						src.Ressurect()
						var/obj/Items/Currency/GoldCoin/Gold = new
						Gold.loc = src
						Gold.suffix = "Carried"
						Gold.Type = rand(10,25)
						Gold.name = "[Gold.Type] Gold Coins"
						Gold.CoinAdjust()
				Ratling_Invader
					icon = 'ratling.dmi'
					icon_state = "N"
					Race = "Ratling"
					name = "{NPC} Ratling"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 15
					Agility = 20
					Endurance = 10
					Intelligence = 10

					StrengthMulti = 0.15
					AgilityMulti = 0.2
					EnduranceMulti = 0.15
					IntelligenceMulti = 0.2

					SwordSkill = 10
					AxeSkill = 5
					SpearSkill = 10
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 10
					ShieldSkill = 10

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.3
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.2
					DaggerSkillMulti = 0.2
					UnarmedSkillMulti = 0.2
					ShieldSkillMulti = 0.2

					Soul = 0

					Blood = 75
					BloodMax = 75
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Ratling Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Armour/UpperBody/BoneChestPlate/C = new
						var/obj/Items/Armour/Shoulders/SkullPauldrons/P = new
						var/obj/Items/Armour/LeftArm/BoneLeftGauntlet/LG = new
						var/obj/Items/Armour/RightArm/BoneRightGauntlet/RG = new
						var/obj/Items/Armour/LeftFoot/BoneBootLeft/LB = new
						var/obj/Items/Armour/RightFoot/BoneBootRight/RB = new
						var/obj/Items/Weapons/Swords/LongSword/M = new
						var/obj/Items/Armour/Shields/WoodenBuckler/IS = new

						M.loc = src
						IS.loc = src

						M.Material = "Iron"
						M.RandomItemQuality()
						M.suffix = "Equip"
						IS.suffix = "Equip"
						IS.EquipState = "[IS.EquipState] left"
						src.Weapon = M
						src.Weapon2 = IS

						C.loc = src
						LG.loc = src
						RG.loc = src
						LB.loc = src
						RB.loc = src
						P.loc = src

						C.suffix = "Equip"
						LG.suffix = "Equip"
						RG.suffix = "Equip"
						LB.suffix = "Equip"
						RB.suffix = "Equip"
						P.suffix = "Equip"

						src.WUpperBody = C
						src.WShoulders = P
						src.WLeftHand = LG
						src.WRightHand = RG
						src.WLeftFoot = LB
						src.WRightFoot = RB

						for(var/obj/Items/Q in src)
							Q.layer = Q.ItemLayer
							Q.icon_state = Q.EquipState

						src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
						src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
						src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
						src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
						src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
						src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
						src.overlays+=image(M.icon,M.icon_state,M.ItemLayer)
						src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)

						src.GuardLoc = src.loc
						src.GuardDir = src.dir
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.NormalAI()
						src.Regen()
				Ratling_Guardsman
					icon = 'ratling.dmi'
					icon_state = "N"
					Race = "Ratling"

					Head = 100
					Torso = 100
					LeftArm = 100
					RightArm = 100
					LeftLeg = 100
					RightLeg = 100

					Skull = 100
					Brain = 100
					LeftEye = 100
					RightEye = 100
					LeftEar = 100
					RightEar = 100
					Teeth = 100
					Nose = 100
					Tongue = 100
					Throat = 100

					Heart = 100
					LeftLung = 100
					RightLung = 100
					Spleen = 100
					Intestine = 100
					LeftKidney = 100
					RightKidney = 100
					Liver = 100
					Bladder = 100
					Stomach = 100

					Strength = 45
					Agility = 60
					Endurance = 40
					Intelligence = 45

					StrengthMulti = 0.15
					AgilityMulti = 0.2
					EnduranceMulti = 0.15
					IntelligenceMulti = 0.2

					SwordSkill = 10
					AxeSkill = 5
					SpearSkill = 40
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 40
					ShieldSkill = 40

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.3
					BluntSkillMulti = 0.2
					RangedSkillMulti = 0.4
					DaggerSkillMulti = 0.4
					UnarmedSkillMulti = 0.4
					ShieldSkillMulti = 0.4

					Soul = 0

					Blood = 75
					BloodMax = 75
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					Faction = "Ratling Hordes"

					HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						var/obj/Items/Armour/Head/SkullHelmet/H = new
						var/obj/Items/Armour/UpperBody/BoneChestPlate/C = new
						var/obj/Items/Armour/Shoulders/SkullPauldrons/P = new
						var/obj/Items/Armour/LeftArm/BoneLeftGauntlet/LG = new
						var/obj/Items/Armour/RightArm/BoneRightGauntlet/RG = new
						var/obj/Items/Armour/LeftFoot/BoneBootLeft/LB = new
						var/obj/Items/Armour/RightFoot/BoneBootRight/RB = new
						var/obj/Items/Weapons/Spears/Spear/S = new
						var/obj/Items/Armour/Shields/WoodenBuckler/IS = new

						S.loc = src
						IS.loc = src

						S.Material = "Iron"
						S.RandomItemQuality()
						S.suffix = "Equip"
						IS.suffix = "Equip"
						IS.EquipState = "[IS.EquipState] left"
						src.Weapon = S
						src.Weapon2 = IS

						C.loc = src
						LG.loc = src
						RG.loc = src
						LB.loc = src
						RB.loc = src
						H.loc = src
						P.loc = src

						C.suffix = "Equip"
						LG.suffix = "Equip"
						RG.suffix = "Equip"
						LB.suffix = "Equip"
						RB.suffix = "Equip"
						P.suffix = "Equip"
						H.suffix = "Equip"

						src.WUpperBody = C
						src.WShoulders = P
						src.WLeftHand = LG
						src.WRightHand = RG
						src.WLeftFoot = LB
						src.WRightFoot = RB
						src.WHead = H

						for(var/obj/Items/Q in src)
							Q.layer = Q.ItemLayer
							Q.icon_state = Q.EquipState

						src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
						src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
						src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
						src.overlays+=image(LB.icon,LB.icon_state,LB.ItemLayer)
						src.overlays+=image(RB.icon,RB.icon_state,RB.ItemLayer)
						src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
						src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
						src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
						src.overlays+=image(IS.icon,IS.icon_state,IS.ItemLayer)

						src.GuardLoc = src.loc
						src.GuardDir = src.dir
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.GuardAI()
						src.Regen()
						src.GiveName()
				Large_Flesh_Beasts
					layer = 7.1
					Race = "Large Flesh Beast"
					Large_Flesh_Beast_TR
						name = "Large Flesh Beast"
						icon = 'creatures.dmi'
						icon_state = "flesh beast TR"
						New()
							src.pixel_y = 32
							src.pixel_x = 32
					Large_Flesh_Beast_TL
						name = "Large Flesh Beast"
						icon = 'creatures.dmi'
						icon_state = "flesh beast TL"
						New()
							src.pixel_y = 32
					Large_Flesh_Beast_BR
						name = "Large Flesh Beast"
						icon = 'creatures.dmi'
						icon_state = "flesh beast BR"
						New()
							src.pixel_x = 32
					Large_Flesh_Beast
						name = "{NPC} Large Flesh Beast"
						icon = 'creatures.dmi'
						icon_state = "flesh beast BL"

						Humanoid = 0

						Strength = 45
						Agility = 25
						Endurance = 60
						Intelligence = 2

						StrengthMulti = 0.3
						AgilityMulti = 0.2
						EnduranceMulti = 0.4
						IntelligenceMulti = 0.1

						SwordSkill = 45
						AxeSkill = 5
						SpearSkill = 5
						BluntSkill = 5
						RangedSkill = 5
						DaggerSkill = 5
						UnarmedSkill = 5

						SwordSkillMulti = 0.4
						AxeSkillMulti = 0.1
						SpearSkillMulti = 0.1
						BluntSkillMulti = 0.1
						RangedSkillMulti = 0.1
						DaggerSkillMulti = 0.1
						UnarmedSkillMulti = 0.1

						Claws = 100

						Blood = 400
						BloodMax = 400
						BloodColour = /obj/Misc/Gore/BloodSplat/
						BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

						HP = 500
						HPMAX = 500

						Soul = 0

						Faction = "Chaos"

						HateList = list("Illithid Cultists","Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","None","Human Empire Unholy","Human Empire Outlaw")
						New()
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I

							src.DeadIcon = 'corpses.dmi'
							src.DeadState = "flesh beast corpse left"
							src.Attack()
							src.BloodFlow()
							src.FleshAI()
							src.FleshBurst()
				Illithid_Elder_God
					name = "{NPC} Illithid Elder God"
					icon = 'elder god.dmi'
					Race = "Chaos"

					Humanoid = 0

					Strength = 25
					Agility = 50
					Endurance = 25
					Intelligence = 100

					StrengthMulti = 0.1
					AgilityMulti = 0.3
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 33

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.3

					Claws = 100

					Blood = 100
					BloodMax = 100

					HP = 150
					HPMAX = 150

					Soul = 0

					Faction = "Illithid Cultists"
					CanEat = 1
					HungerMulti = 0.5
					Hunger = 100
					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","None","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.Attack()
						src.ElderGodAI()
						src.HungerTick()
						var/obj/Misc/Languages/Ancient/L = new
						L.SpeakPercent = 100
						L.WritePercent = 100
						src.LangKnow += L
						src.CurrentLanguage = L
						src.Ressurect()
				Chaos_Entity
					name = "{NPC} Chaos Entity"
					icon = 'creatures.dmi'
					icon_state = "chaos"

					Race = "Chaos"

					Humanoid = 0

					Strength = 1
					Agility = 50
					Endurance = 10
					Intelligence = 10

					StrengthMulti = 0.1
					AgilityMulti = 0.3
					EnduranceMulti = 0.1
					IntelligenceMulti = 0.1

					SwordSkill = 5
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 10

					SwordSkillMulti = 0.1
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.3

					Claws = 100

					Blood = 0
					BloodMax = 0

					HP = 50
					HPMAX = 50

					Soul = 0

					Faction = "Chaos"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","None","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.Attack()
						src.ChaosAI()
				Flesh_Beast
					name = "{NPC} Flesh Beast"
					icon = 'creatures.dmi'
					icon_state = "flesh beast"

					Race = "Chaos"

					Humanoid = 0

					Strength = 30
					Agility = 15
					Endurance = 40
					Intelligence = 1

					StrengthMulti = 0.2
					AgilityMulti = 0.1
					EnduranceMulti = 0.3
					IntelligenceMulti = 0.05

					SwordSkill = 30
					AxeSkill = 5
					SpearSkill = 5
					BluntSkill = 5
					RangedSkill = 5
					DaggerSkill = 5
					UnarmedSkill = 5

					SwordSkillMulti = 0.3
					AxeSkillMulti = 0.1
					SpearSkillMulti = 0.1
					BluntSkillMulti = 0.1
					RangedSkillMulti = 0.1
					DaggerSkillMulti = 0.1
					UnarmedSkillMulti = 0.1

					Claws = 100

					Blood = 200
					BloodMax = 200
					BloodColour = /obj/Misc/Gore/BloodSplat/
					BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

					HP = 250
					HPMAX = 250

					Soul = 0

					Faction = "Chaos"

					HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Undead","Human Empire","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","None","Human Empire Unholy","Human Empire Outlaw")
					New()
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I

						src.DeadIcon = 'corpses.dmi'
						src.DeadState = "flesh beast corpse"
						src.Attack()
						src.BloodFlow()
						src.BloodTrail()
						src.FleshAI()

		Neutral
			Snakeman_Guardian_Patrol
				name = "{NPC} Snakeman Guardian"
				icon = 'snakeman.dmi'
				icon_state = "N"
				Type = "Town"
				Race = "Snakeman"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 45
				Agility = 60
				Endurance = 45
				Intelligence = 1

				StrengthMulti = 0.3
				AgilityMulti = 0.2
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.1

				SwordSkill = 50
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.3

				Soul = 0

				Blood = 125
				BloodMax = 125
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Snakeman Empire"
				HateList = list("Gremlin Hordes","Stahlite Empire","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				New()
					var/image/I = new('Target.dmi',src)
					var/obj/Items/Weapons/Swords/Scimitar/S = new
					var/obj/Items/Armour/Chest/ChainShirt/R = new
					var/obj/Items/Armour/UpperBody/ChestPlate/C = new
					var/obj/Items/Armour/Shoulders/PlatePauldrons/P = new
					var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
					var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new

					R.loc = src
					C.loc = src
					LG.loc = src
					RG.loc = src
					S.loc = src
					P.loc = src

					R.Material = "Copper"
					R.RandomItemQuality()
					LG.Material = "Copper"
					LG.RandomItemQuality()
					RG.Material = "Copper"
					RG.RandomItemQuality()
					P.Material = "Copper"
					P.RandomItemQuality()
					C.Material = "Copper"
					C.RandomItemQuality()


					R.suffix = "Equip"
					C.suffix = "Equip"
					LG.suffix = "Equip"
					RG.suffix = "Equip"
					P.suffix = "Equip"
					S.suffix = "Equip"

					S.Material = "Copper"
					S.RandomItemQuality()

					for(var/obj/Items/Z in src)
						Z.Dura = 100
						Z.icon_state = Z.EquipState
						Z.layer = Z.ItemLayer

					src.WChest = R
					src.WUpperBody = C
					src.WShoulders = P
					src.WLeftHand = LG
					src.WRightHand = RG
					src.Weapon = S

					src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
					src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
					src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
					src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
					src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.TargetIcon = I
					src.DeadIcon = src.icon
					src.Attack()
					src.BloodFlow()
					src.NormalAI()
					src.Regen()
			Snakeman_Merchant
				icon = 'snakeman.dmi'
				icon_state = "N"
				Type = "Merchant"
				name = "{NPC} Merchant"
				Race = "Snakeman"

				Head = 110
				Torso = 110
				LeftArm = 110
				RightArm = 110

				Skull = 110
				Brain = 110
				LeftEye = 110
				RightEye = 110
				LeftEar = 110
				RightEar = 110
				Teeth = 110
				Nose = 110
				Tongue = 110
				Throat = 110

				Heart = 110
				LeftLung = 110
				RightLung = 110
				Spleen = 110
				Intestine = 110
				LeftKidney = 110
				RightKidney = 110
				Liver = 110
				Bladder = 110
				Stomach = 110

				Strength = 30
				Agility = 30
				Endurance = 25
				Intelligence = 25

				StrengthMulti = 0.2
				AgilityMulti = 0.2
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.2

				SwordSkill = 25
				AxeSkill = 25
				SpearSkill = 25
				BluntSkill = 25
				RangedSkill = 25
				DaggerSkill = 25
				UnarmedSkill = 25

				SwordSkillMulti = 0.3
				AxeSkillMulti = 0.3
				SpearSkillMulti = 0.3
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.3
				DaggerSkillMulti = 0.3
				UnarmedSkillMulti = 0.3

				Blood = 110
				BloodMax = 110
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/
				Faction = "Snakeman Empire"
				HateList = list("Gremlin Hordes","Stahlite Empire","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				Click()
					if(usr.Function == "Interact" && src in range(2,usr))
						if(usr.Faction in src.HateList)
							return
						if(usr.name in src.HateList)
							return
						var/CanUnderstand = 0
						var/obj/Speaking = null
						if(usr.CurrentLanguage)
							Speaking = usr.CurrentLanguage
						for(var/obj/L in src.LangKnow)
							if(L.name == Speaking.name)
								if(L.SpeakPercent > Speaking.SpeakPercent / 1.5)
									CanUnderstand = 1
									src.CurrentLanguage = usr.CurrentLanguage
						if(CanUnderstand)
							src.Speak("Greetings and welcome to my shop!",7)
							for(var/obj/I in usr)
								if(I in src.Selling)
									var/Val = 1
									if(I.Material == "Wood")
										Val += 1
									if(I.Material == "Stone")
										Val += 1
									if(I.Material == "Iron")
										Val += 10
									if(I.Material == "Copper")
										Val += 5
									if(I.Material == "Silver")
										Val += 15
									if(I.Material == "Gold")
										Val += 20
									if(I.Quality)
										Val += I.Quality / 1.5
									if(I.Defence)
										Val += I.Defence / 2
									var/RoundedVal = round(Val)
									src.Speak("Ah, I see you've chosen a [I], a fine choice indeed! That item has a total Value of about [RoundedVal] Gold Coins.",7)
									var/list/menu = new()
									menu += "Buy"
									menu += "Dont Buy"
									var/Result = input(usr,"[src] says - Would you like to purchase the [I] for [RoundedVal] Gold Coins?", "Choose", null) in menu
									if(Result == "Dont Buy")
										return
									if(Result == "Buy")
										for(var/obj/Items/Currency/GoldCoin/Gold in usr)
											if(Gold.Type >= RoundedVal)
												var/CoinsAlready = 0
												for(var/obj/Items/Currency/GoldCoin/C in src)
													CoinsAlready = 1
												if(CoinsAlready == 0)
													var/obj/Items/Currency/GoldCoin/Coin = new
													Coin.Type = RoundedVal
													Gold.Type -= RoundedVal
													Coin.CoinAdjust()
													Gold.CoinAdjust()
													Coin.loc = src
													Coin.suffix = "Carried"
													Coin.name = "[Coin.Type] Gold Coins"
													Gold.name = "[Gold.Type] Gold Coins"
												else
													for(var/obj/Items/Currency/GoldCoin/Coin in src)
														Coin.Type += RoundedVal
														Gold.Type -= RoundedVal
														Coin.CoinAdjust()
														Gold.CoinAdjust()
														Gold.name = "[Gold.Type] Gold Coins"
														Coin.name = "[Coin.Type] Gold Coins"
												if(Gold.Type == 0)
													del(Gold)
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.CreateInventory()
												src.Selling -= I
												if(I.ObjectTag == "Weapon")
													I.CanBeCrafted = 1
												if(I.ObjectTag == "Armour")
													I.CanBeCrafted = 1
												src.Speak("Thank you, come again!.",7)
											else
												src.Speak("You dont have [RoundedVal] Gold Coins so you cant buy the [I].",7)
						else
							usr << "<font color = yellow>[src] seems to have no idea what your saying.<br>"
						return
				New()
					spawn(10)
						var/image/I = new('Target.dmi',src)
						src.TargetIcon = I
						src.DeadIcon = src.icon
						src.Attack()
						src.BloodFlow()
						src.Regen()
						var/Gen = rand(1,2)
						if(Gen == 1)
							src.Gender = "Male"
						if(Gen == 2)
							src.Gender = "Female"
							src.icon = 'human(F).dmi'
							src.GiveHair()
						var/obj/Items/Armour/UpperBody/LeatherVest/V = new
						src.WUpperBody = V
						V.suffix = "Equip"
						V.loc = src
						var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.loc = src
						var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
						src.WLeftFoot = LBL
						LBL.suffix = "Equip"
						LBL.loc = src
						var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
						src.WRightFoot = LBR
						LBR.suffix = "Equip"
						LBR.loc = src
						var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
						src.WLeftHand = LGL
						LGL.suffix = "Equip"
						LGL.loc = src
						var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
						src.WRightHand = LGR
						LGR.suffix = "Equip"
						LGR.loc = src
						for(var/obj/Items/Z in src)
							Z.Dura = 100
							Z.icon_state = Z.EquipState
							Z.layer = Z.ItemLayer
						src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
						src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
						src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
						src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						src.overlays+=image(V.icon,V.icon_state,V.ItemLayer)
						src.GiveRaceLanguages()
						src.Selling = list()
						for(var/obj/Items/It in oview(7,src))
							var/Add = 1
							if(It in src.Selling)
								Add = 0
							if(Add)
								src.Selling += It
			Snakeman_Guardian
				name = "{NPC} Snakeman Guardian"
				icon = 'snakeman.dmi'
				icon_state = "N"
				Race = "Snakeman"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 45
				Agility = 60
				Endurance = 45
				Intelligence = 1

				StrengthMulti = 0.3
				AgilityMulti = 0.2
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.1

				SwordSkill = 50
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 50

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.3

				Soul = 0

				Blood = 125
				BloodMax = 125
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Snakeman Empire"
				HateList = list("Gremlin Hordes","Stahlite Empire","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				New()
					spawn(10)
						if(src)
							var/image/I = new('Target.dmi',src)
							var/obj/Items/Weapons/Swords/Scimitar/S = new
							var/obj/Items/Armour/Chest/ChainShirt/R = new
							var/obj/Items/Armour/UpperBody/ChestPlate/C = new
							var/obj/Items/Armour/Shoulders/PlatePauldrons/P = new
							var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
							var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new

							R.loc = src
							C.loc = src
							LG.loc = src
							RG.loc = src
							S.loc = src
							P.loc = src

							R.Material = "Copper"
							R.RandomItemQuality()
							LG.Material = "Copper"
							LG.RandomItemQuality()
							RG.Material = "Copper"
							RG.RandomItemQuality()
							P.Material = "Copper"
							P.RandomItemQuality()
							C.Material = "Copper"
							C.RandomItemQuality()


							R.suffix = "Equip"
							C.suffix = "Equip"
							LG.suffix = "Equip"
							RG.suffix = "Equip"
							P.suffix = "Equip"
							S.suffix = "Equip"

							S.Material = "Copper"
							S.RandomItemQuality()

							for(var/obj/Items/Z in src)
								Z.Dura = 100
								Z.icon_state = Z.EquipState
								Z.layer = Z.ItemLayer

							src.WChest = R
							src.WUpperBody = C
							src.WShoulders = P
							src.WLeftHand = LG
							src.WRightHand = RG
							src.Weapon = S

							src.overlays+=image(C.icon,C.icon_state,C.ItemLayer)
							src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
							src.overlays+=image(LG.icon,LG.icon_state,LG.ItemLayer)
							src.overlays+=image(RG.icon,RG.icon_state,RG.ItemLayer)
							src.overlays+=image(P.icon,P.icon_state,P.ItemLayer)
							src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
							src.TargetIcon = I
							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
			Snakeman_Priest
				name = "{NPC} Snakeman Priest"
				icon = 'snakeman.dmi'
				icon_state = "N"
				Race = "Snakeman"

				Head = 100
				Torso = 100
				LeftArm = 100
				RightArm = 100
				LeftLeg = 100
				RightLeg = 100

				Skull = 100
				Brain = 100
				LeftEye = 100
				RightEye = 100
				LeftEar = 100
				RightEar = 100
				Teeth = 100
				Nose = 100
				Tongue = 100
				Throat = 100

				Heart = 100
				LeftLung = 100
				RightLung = 100
				Spleen = 100
				Intestine = 100
				LeftKidney = 100
				RightKidney = 100
				Liver = 100
				Bladder = 100
				Stomach = 100

				Strength = 50
				Agility = 60
				Endurance = 45
				Intelligence = 1

				StrengthMulti = 0.3
				AgilityMulti = 0.2
				EnduranceMulti = 0.3
				IntelligenceMulti = 0.1

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 50
				UnarmedSkill = 5

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.2
				SpearSkillMulti = 0.2
				BluntSkillMulti = 0.3
				RangedSkillMulti = 0.2
				DaggerSkillMulti = 0.2
				UnarmedSkillMulti = 0.3

				Soul = 0

				Blood = 135
				BloodMax = 135
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				Faction = "Snakeman Empire"
				HateList = list("Gremlin Hordes","Stahlite Empire","Kobold Hordes","Dragons","Undead","Chaos","Demonic Legions","Dangerous Beasts","Ratling Hordes","Cyclops Hordes","Goblin Hordes","Spider Hordes")
				New()
					spawn(10)
						if(src)
							var/obj/Items/Weapons/Daggers/Dagger/D = new
							var/obj/Items/Armour/Back/ClothCloak/CC = new

							D.loc = src
							CC.loc = src


							D.suffix = "Equip"
							CC.suffix = "Equip"

							D.Material = "Copper"
							D.RandomItemQuality()

							src.Weapon = D
							src.WBack = CC
							for(var/obj/Items/Q in src)
								Q.layer = Q.ItemLayer
								Q.icon_state = Q.EquipState
							src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
							src.overlays+=image(CC.icon,CC.icon_state,CC.ItemLayer)
							var/image/I = new('Target.dmi',src)
							src.TargetIcon = I
							src.GuardLoc = src.loc
							src.GuardDir = src.dir
							src.DeadIcon = src.icon
							src.Attack()
							src.BloodFlow()
							src.GuardAI()
							src.Regen()
							src.Ressurect()
			Snake
				name = "{NPC} Snake"
				icon = 'creatures.dmi'
				icon_state = "snake"

				Humanoid = 0

				Strength = 3
				Agility = 6
				Endurance = 3
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.1
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 20
				BloodMax = 20
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 10
				HPMAX = 10

				Soul = 0

				Faction = "Snakeman Empire"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead snake"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			Rat
				name = "{NPC} Rat"
				icon = 'creatures.dmi'
				icon_state = "rat"

				Humanoid = 0

				Strength = 2
				Agility = 7
				Endurance = 2
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.1
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 15
				BloodMax = 15
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 5
				HPMAX = 5

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead rat"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			Chicken
				name = "{NPC} Chicken"
				icon = 'creatures.dmi'
				icon_state = "chicken"

				Humanoid = 0

				Strength = 2
				Agility = 5
				Endurance = 2
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.1
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 25
				BloodMax = 25
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 15
				HPMAX = 15

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead chicken"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			ArcticRabbit
				name = "{NPC} Arctic Rabbit"
				icon = 'creatures.dmi'
				icon_state = "arctic rabbit"
				Type = "SnowArea"

				Humanoid = 0

				Strength = 3
				Agility = 5
				Endurance = 3
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.1
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 25
				BloodMax = 25
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 15
				HPMAX = 15

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead arctic rabbit"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			Rabbit
				name = "{NPC} Rabbit"
				icon = 'creatures.dmi'
				icon_state = "rabbit"

				Humanoid = 0

				Strength = 2
				Agility = 5
				Endurance = 2
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.1
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 25
				BloodMax = 25
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 15
				HPMAX = 15

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead rabbit"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			ArcticFox
				name = "{NPC} Arctic Fox"
				icon = 'creatures.dmi'
				icon_state = "arctic fox"
				Type = "SnowArea"

				Humanoid = 0

				Strength = 5
				Agility = 7
				Endurance = 5
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.15
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 35
				BloodMax = 35
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 35
				HPMAX = 35

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead arctic fox"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			Fox
				name = "{NPC} Fox"
				icon = 'creatures.dmi'
				icon_state = "fox"

				Humanoid = 0

				Strength = 5
				Agility = 7
				Endurance = 5
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.15
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 35
				BloodMax = 35
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 35
				HPMAX = 35

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead fox"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			PolarBear
				name = "{NPC} Polar Bear"
				icon = 'creatures.dmi'
				icon_state = "polar bear"
				Type = "SnowArea"

				Humanoid = 0

				Strength = 15
				Agility = 10
				Endurance = 20
				Intelligence = 1

				StrengthMulti = 0.2
				AgilityMulti = 0.1
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.01

				SwordSkill = 10
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Claws = 100

				Blood = 60
				BloodMax = 60
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 100
				HPMAX = 100

				Soul = 0

				Faction = "Dangerous Beasts"

				HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I

					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead polar bear"
					src.Attack()
					src.BloodFlow()
					src.NormalAI()
			BlackWolf
				name = "{NPC} Black Wolf"
				icon = 'creatures.dmi'
				icon_state = "black wolf"

				Humanoid = 0

				Strength = 7
				Agility = 10
				Endurance = 7
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.1
				EnduranceMulti = 0.1
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Claws = 100

				Blood = 35
				BloodMax = 35
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 50
				HPMAX = 50

				Soul = 0

				Faction = "Dangerous Beasts"

				HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I

					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead black wolf"
					src.Attack()
					src.BloodFlow()
					src.NormalAI()
			Bear
				name = "{NPC} Bear"
				icon = 'creatures.dmi'
				icon_state = "bear"

				Humanoid = 0

				Strength = 15
				Agility = 10
				Endurance = 20
				Intelligence = 1

				StrengthMulti = 0.2
				AgilityMulti = 0.1
				EnduranceMulti = 0.2
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.2
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Claws = 100

				Blood = 50
				BloodMax = 50
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 100
				HPMAX = 100

				Soul = 0

				Faction = "Dangerous Beasts"

				HateList = list("Lizardman Tribes","Gremlin Hordes","Kobold Hordes","Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Undead","Human Empire","Chaos","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I

					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"

					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead bear"
					src.Attack()
					src.BloodFlow()
					src.NormalAI()
			Deer
				name = "{NPC} Deer"
				icon = 'creatures.dmi'
				icon_state = "deer"

				Humanoid = 0

				Strength = 10
				Agility = 10
				Endurance = 5
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.2
				EnduranceMulti = 0.15
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 50
				BloodMax = 50
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 75
				HPMAX = 75

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					var/C
					if(G == 1)
						src.Gender = "Male"
						C = "dead deer m"
					if(G == 2)
						src.Gender = "Female"
						src.icon_state = "deer f"
						C = "dead deer f"
					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "[C]"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()
			Horse
				name = "{NPC} Horse"
				icon = 'creatures.dmi'
				icon_state = "horse"

				Humanoid = 0

				Strength = 20
				Agility = 15
				Endurance = 20
				Intelligence = 1

				StrengthMulti = 0.1
				AgilityMulti = 0.2
				EnduranceMulti = 0.15
				IntelligenceMulti = 0.01

				SwordSkill = 5
				AxeSkill = 5
				SpearSkill = 5
				BluntSkill = 5
				RangedSkill = 5
				DaggerSkill = 5
				UnarmedSkill = 5

				SwordSkillMulti = 0.1
				AxeSkillMulti = 0.1
				SpearSkillMulti = 0.1
				BluntSkillMulti = 0.1
				RangedSkillMulti = 0.1
				DaggerSkillMulti = 0.1
				UnarmedSkillMulti = 0.1

				Blood = 75
				BloodMax = 75
				BloodColour = /obj/Misc/Gore/BloodSplat/
				BloodWallColour = /obj/Misc/Gore/WallBloodSplat/

				HP = 125
				HPMAX = 125

				Soul = 0

				Faction = "Neutral"
				New()
					var/image/I = new('Target.dmi',src)
					src.TargetIcon = I
					var/G = rand(1,2)
					if(G == 1)
						src.Gender = "Male"
					if(G == 2)
						src.Gender = "Female"
					src.DeadIcon = 'corpses.dmi'
					src.DeadState = "dead [src.icon_state]"
					src.Attack()
					src.BloodFlow()
					src.AnimalAI()