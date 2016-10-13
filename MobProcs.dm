mob
	proc
		Death()
			for(var/obj/I in src)
				I.suffix = null
				I.overlays = null
				I.Move(locate(src.x,src.y,src.z))
				if(I.icon_state == "mystical ball glow")
					I.icon_state = "mystical ball"
				src.Weight -= I.Weight
				src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
				src.overlays-=image(I.icon,"[I.icon_state] left",I.ItemLayer)
				I.layer = 4
				if(I.CarryState)
					I.icon_state = I.CarryState
				if(I.Delete)
					del(I)
			if(src.OrginalName)
				src.name = src.OrginalName
				src.OrginalName = null
			if(src.StoredFaction)
				src.Faction = src.StoredFaction
				src.StoredFaction = null
			src.Ref = null
			src.Bleed = null
			src.WHead = null
			src.WBack = null
			src.WExtra = null
			src.WChest = null
			src.WUpperBody = null
			src.WShoulders = null
			src.WLeftHand = null
			src.WRightHand = null
			src.WLeftFoot = null
			src.WRightFoot = null
			src.WLegs = null
			src.WWaist = null
			src.Weapon = null
			src.Weapon2 = null
			src.MoveSpeed = 2
			if(src.client)
				src.ResetButtons()
			src.overlays = null
			src.Function = null
			src.luminosity = 0
			src.Fainted = 0
			src.Sleeping = 0
			src.invisibility  = 50
			src.see_invisible = 50
			src.Stunned = 0
			src.Fuel = 0
			src.OnFire = 0
			src.overlays -= /obj/Misc/Fire/
			src.Target = null
			src.CanMove = 1
			src.Blood = 0
			src.CanEat = 0
			src.Dead = 1
			src.CanSleep = 0
			src.CanEat = 0
			src.Pain = 0
			src.CanAttack = 0
			src.Pull = null
			src.density = 0
			if(src.Race != "Skeleton")
				var/obj/Items/Body/B = new
				B.icon = src.DeadIcon
				B.Humanoid = src.Humanoid
				B.Strength = src.Strength
				B.Agility = src.Agility
				B.Endurance = src.Endurance
				B.BloodMax = src.BloodMax
				B.Hair = src.Hair
				B.Beard = src.Beard
				B.Race = src.Race
				if(src.Beard)
					var/obj/Brd = src.Beard
					var/icon/BI = new(Brd.icon)
					BI.Turn(90)
					Brd.icon = BI
				if(src.Hair)
					var/obj/Hir = src.Hair
					var/icon/HI = new(Hir.icon)
					HI.Turn(90)
					Hir.icon = HI
				B.AddBodyWounds(src)
				B.overlays += src.Beard
				B.overlays += src.Hair
				B.LeftArm = src.LeftArm
				B.RightArm = src.RightArm
				B.Torso = src.Torso
				B.Head = src.Head
				B.LeftLeg = src.LeftLeg
				B.RightLeg = src.RightLeg
				B.Skull = src.Skull
				B.Brain = src.Brain
				B.LeftEye = src.LeftEye
				B.RightEye = src.RightEye
				B.LeftEar = src.LeftEar
				B.RightEar = src.RightEar
				B.Nose = src.Nose
				B.Teeth = src.Teeth
				B.Tongue = src.Tongue
				B.Throat = src.Throat
				B.Heart = src.Heart
				B.LeftLung = src.LeftLung
				B.RightLung = src.RightLung
				B.Spleen = src.Spleen
				B.Intestine = src.Intestine
				B.LeftKidney = src.LeftKidney
				B.RightKidney = src.RightKidney
				B.Liver = src.Liver
				B.Bladder = src.Bladder
				B.Stomach = src.Stomach
				B.BloodColour = src.BloodColour
				B.Faction = src.Faction

				src.Hair = null
				src.Beard = null
				src.BloodMax = 0
				src.see_in_dark = 8
				if(src.DeadState)
					B.icon_state = src.DeadState
					if(src.Race == "Large Flesh Beast")
						B.overlays += /obj/Misc/Gore/FleshBeastCorpse/
					if(src.Race == "Dragon")
						B.overlays += /obj/Misc/Gore/DrakeCorpse/
					if(src.Race == "Yeti")
						B.overlays += /obj/Misc/Gore/YetiCorpse/
					if(src.Race == "Troll")
						B.overlays += /obj/Misc/Gore/TrollCorpse/
					if(src.Race == "GiantSnake")
						B.overlays += /obj/Misc/Gore/GiantSnakeCorpse/
				else
					B.icon_state = src.icon_state
				B.name = "[src]'s Corpse"
				B.Owner = src
				if(src.client)
					B.Owner = src.name
					B.BodysKey = src.key
					B.BodyKeyCheck()
				B.Move(src.loc)
				var/icon/I = new(B.icon)
				I.Turn(90)
				B.icon = I
				if(src.Faction == "Undead")
					if(src.icon_state != "None")
						var/Rise = prob(50)
						if(Rise)
							spawn(rand(300,600))
								if(B && src && src.Dead && src.Brain >= 0)
									src.EvilRevive(B)
									src.Faction = "Undead"
									src.HateList = null
									src.HateList = list("Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
									view(src) << "<font color = purple>[B] rises from the dead!<br>"
									del(B)
									if(src.client == null)
										src.NormalAI()
			else
				src.Hair = null
				src.Strength = 0
				src.Agility = 0
				src.Endurance = 0
				src.BloodMax = 0
				var/obj/Items/Misc/Bones/B = new
				B.Move(src.loc)
				B.name = "[src]'s bones"
				var/obj/Items/Misc/Skull/S = new
				S.Move(src.loc)
				S.name = "[src]'s skull"
				S.SkeletonRaise()
			src << "<font color=red>You have died!<br>"
			if(src.Soul)
				src.icon = 'characters.dmi'
				src.icon_state = "ghost"
			else
				del(src)
			if(src.client)
				src.RemakeChoice()
			return
		RemakeChoice()
			var/list/menu = new()
			menu += "Remake"
			menu += "Remain Dead"
			var/Result = input(src,"You have died. - Remaking will allow you to keep all of your stats and all of your skills, but your name, gender, race and IC knowledge will be lost. You will however be able to choose your race again, along with a new name and gender. Remaining dead will simply leave you as a ghost until someone revives you or your body is destroyed. Relogging will open this option up again.", "Choose", null) in menu
			if(Result == "Remake")
				for(var/obj/HUD/H in src.client.screen)
					del(H)
				src.loc = locate(11,11,2)
				src.CanEatRawMeats = 0
				src.CanSwimWell = 0
				src.CanRegenLimbs = 0
				src.CanBreathe = 1
				src.CanTakeDamage = 1
				src.CanUseTK = 0
				src.Pain = 0
				src.LoggedIn = 0
				src.Dead = 0
				src.Age = 0
				src.Born = 0
				src.DieAge = 10000000
				src.DisableAttack = 1
				src.Fainted = 0
				src.Stunned = 0
				src.density = 0
				src.invisibility = 0
				src.CanMove = 0
				src.luminosity = 0
				src.icon = null
				src.Race = null
				src.Gender = null
				src.Faction = null
				var/player_sav = "players/[src.ckey].sav"
				if(length(file(player_sav)))
					fdel(player_sav)
		High(var/Dur)
			if(src.client == null)
				return
			if(Dur)
				Dur -= 1
				var/DIR = rand(1,4)
				if(DIR == 1)
					src.client.dir = NORTH
				if(DIR == 2)
					src.client.dir = SOUTH
				if(DIR == 3)
					src.client.dir = EAST
				if(DIR == 4)
					src.client.dir = WEST
			else
				src.client.dir = NORTH
				for(var/obj/HUD/GUI/ScreenOverlay/SO in src.client.screen)
					SO.icon_state = "blank screen"
				return
			spawn(100) src.High(Dur)
		AddGore(var/Area,var/VictimsRace)
			if(src.BloodMax >= 1 && src.Humanoid)
				if(Area == "RightLeg" && src.WoundRightLeg == null)
					var/obj/Misc/Gore/RightLegWound/RL = new
					var/LargeBeing = 0
					var/SmallBeing = 0
					if(VictimsRace == "Giant")
						LargeBeing = 1
					if(VictimsRace == "Cyclops")
						LargeBeing = 1
					if(VictimsRace == "Ratling")
						SmallBeing = 1
					if(VictimsRace == "Stahlite")
						SmallBeing = 1
					if(LargeBeing)
						RL.icon_state = "damage rleg large"
					if(SmallBeing)
						RL.icon_state = "damage rleg small"
					src.overlays += RL
					src.WoundRightLeg = RL
				if(Area == "LeftLeg" && src.WoundLeftLeg == null)
					var/obj/Misc/Gore/LeftLegWound/LL = new
					var/LargeBeing = 0
					var/SmallBeing = 0
					if(VictimsRace == "Giant")
						LargeBeing = 1
					if(VictimsRace == "Cyclops")
						LargeBeing = 1
					if(VictimsRace == "Ratling")
						SmallBeing = 1
					if(VictimsRace == "Stahlite")
						SmallBeing = 1
					if(LargeBeing)
						LL.icon_state = "damage lleg large"
					if(SmallBeing)
						LL.icon_state = "damage lleg small"
					src.overlays += LL
					src.WoundLeftLeg = LL
				if(Area == "LeftArm" && src.WoundLeftArm == null)
					var/obj/Misc/Gore/LeftArmWound/LA = new
					var/LargeBeing = 0
					var/SmallBeing = 0
					if(VictimsRace == "Giant")
						LargeBeing = 1
					if(VictimsRace == "Cyclops")
						LargeBeing = 1
					if(VictimsRace == "Ratling")
						SmallBeing = 1
					if(VictimsRace == "Stahlite")
						SmallBeing = 1
					if(LargeBeing)
						LA.icon_state = "damage larm large"
					if(SmallBeing)
						LA.icon_state = "damage larm small"
					src.overlays += LA
					src.WoundLeftArm = LA
				if(Area == "RightArm" && src.WoundRightArm == null)
					var/obj/Misc/Gore/RightArmWound/RA = new
					var/LargeBeing = 0
					var/SmallBeing = 0
					if(VictimsRace == "Giant")
						LargeBeing = 1
					if(VictimsRace == "Cyclops")
						LargeBeing = 1
					if(VictimsRace == "Ratling")
						SmallBeing = 1
					if(VictimsRace == "Stahlite")
						SmallBeing = 1
					if(LargeBeing)
						RA.icon_state = "damage rarm large"
					if(SmallBeing)
						RA.icon_state = "damage rarm small"
					src.overlays += RA
					src.WoundRightArm = RA
				if(Area == "Torso" && src.WoundTorso == null)
					var/obj/Misc/Gore/TorsoWound/TW = new
					var/LargeBeing = 0
					var/SmallBeing = 0
					if(VictimsRace == "Giant")
						LargeBeing = 1
					if(VictimsRace == "Cyclops")
						LargeBeing = 1
					if(VictimsRace == "Ratling")
						SmallBeing = 1
					if(VictimsRace == "Stahlite")
						SmallBeing = 1
					if(LargeBeing)
						TW.icon_state = "damage torso large"
					if(SmallBeing)
						TW.icon_state = "damage torso small"
					src.overlays += TW
					src.WoundTorso = TW
				if(Area == "Head" && src.WoundHead == null)
					var/obj/Misc/Gore/HeadWound/HW = new
					var/LargeBeing = 0
					var/SmallBeing = 0
					if(VictimsRace == "Giant")
						LargeBeing = 1
					if(VictimsRace == "Cyclops")
						LargeBeing = 1
					if(VictimsRace == "Ratling")
						SmallBeing = 1
					if(VictimsRace == "Stahlite")
						SmallBeing = 1
					if(LargeBeing)
						HW.icon_state = "damage head large"
					if(SmallBeing)
						HW.icon_state = "damage head small"
					src.overlays += HW
					src.WoundHead = HW
		MusicProc()
			src << sound('Main2.mid')
			spawn(3150)
				src << sound(null)
				src << sound('Main.mid',1)
		HairGrowth()
			var/CanGrowBeard = 0
			if(src.Gender == "Male" && src.Race != "Alther")
				if(src.Race == "Human")
					CanGrowBeard = 1
				if(src.Race == "Stahlite" && src.Gender != "Female")
					CanGrowBeard = 1
			if(CanGrowBeard)
				if(src.Beard && src.Age >= 15)
					var/obj/B = src.Beard
					if(B.icon_state == "beard 3")
						src.overlays -= B
						B.icon_state = "beard 4"
						if(src.WHead == null)
							src.overlays += B
					if(B.icon_state == "beard 2")
						src.overlays -= B
						B.icon_state = "beard 3"
						if(src.WHead == null)
							src.overlays += B
					if(B.icon_state == "beard 1")
						src.overlays -= B
						B.icon_state = "beard 2"
						if(src.WHead == null)
							src.overlays += B
					if(B.icon_state == "dwarf beard 2")
						src.overlays -= B
						B.icon_state = "dwarf beard 3"
						if(src.WHead == null)
							src.overlays += B
					if(B.icon_state == "dwarf beard 1")
						src.overlays -= B
						B.icon_state = "dwarf beard 2"
						if(src.WHead == null)
							src.overlays += B
				if(src.Beard == null && src.Race != "Stahlite")
					var/obj/Misc/Beards/HumanoidBeard/B = new
					src.Beard = B
					if(src.WHead == null)
						src.overlays += src.Beard
				if(src.Beard == null && src.Race == "Stahlite")
					var/obj/Misc/Beards/StahliteBeard/B = new
					src.Beard = B
					if(src.WHead == null)
						src.overlays += src.Beard
			if(src.Hair == null)
				if(src.Race == "Human" && Gender == "Female")
					var/obj/Misc/Hairs/Long/H = new
					src.Hair = H
					if(src.WHead == null)
						src.overlays += src.Hair
					return
				if(src.Race == "Human" && Gender == "Male")
					var/ChooseHair = rand(1,4)
					if(ChooseHair == 1)
						var/obj/Misc/Hairs/Middle/H = new
						src.Hair = H
						if(src.WHead == null)
							src.overlays += src.Hair
						return
					if(ChooseHair == 2)
						var/obj/Misc/Hairs/PotHead/H = new
						src.Hair = H
						if(src.WHead == null)
							src.overlays += src.Hair
						return
					if(ChooseHair == 3)
						var/obj/Misc/Hairs/HairLeft/H = new
						src.Hair = H
						if(src.WHead == null)
							src.overlays += src.Hair
						return
					if(ChooseHair == 4)
						var/obj/Misc/Hairs/HairRight/H = new
						src.Hair = H
						if(src.WHead == null)
							src.overlays += src.Hair
						return
				if(src.Race == "Stahlite" && Gender == "Female")
					var/obj/Misc/Hairs/SmallHairFemale/H = new
					src.Hair = H
					if(src.WHead == null)
						src.overlays += src.Hair
					return
				if(src.Race == "Giant" && Gender == "Male")
					var/obj/Misc/Hairs/GiantHairMale/H = new
					src.Hair = H
					if(src.WHead == null)
						src.overlays += src.Hair
					return
				if(src.Race == "Giant" && Gender == "Female")
					var/obj/Misc/Hairs/GiantHairFemale/H = new
					src.Hair = H
					if(src.WHead == null)
						src.overlays += src.Hair
					return
			if(src.Hair)
				var/obj/H = src.Hair
				if(H.icon_state == "side L 1")
					src.overlays -= H
					H.icon_state = "side L 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "side L 2")
					src.overlays -= H
					H.icon_state = "side L 3"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "side R 1")
					src.overlays -= H
					H.icon_state = "side R 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "side R 2")
					src.overlays -= H
					H.icon_state = "side R 3"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "middle 1")
					src.overlays -= H
					H.icon_state = "middle 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "middle 2")
					src.overlays -= H
					H.icon_state = "middle 3"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "pot head 1")
					src.overlays -= H
					H.icon_state = "pot head 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "pot head 2")
					src.overlays -= H
					H.icon_state = "pot head 3"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "combed back 1")
					src.overlays -= H
					H.icon_state = "combed back 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "combed back 2")
					src.overlays -= H
					H.icon_state = "combed back 3"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "long hair 1")
					src.overlays -= H
					H.icon_state = "long hair 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "long hair 2")
					src.overlays -= H
					H.icon_state = "long hair 3"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "giant hair male 1")
					src.overlays -= H
					H.icon_state = "giant hair male 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "giant hair male 2")
					src.overlays -= H
					H.icon_state = "giant hair male 3"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "giant hair female 1")
					src.overlays -= H
					H.icon_state = "giant hair female 2"
					if(src.WHead == null)
						src.overlays += H
					return
				if(H.icon_state == "giant hair female 2")
					src.overlays -= H
					H.icon_state = "giant hair female 3"
					if(src.WHead == null)
						src.overlays += H
					return
		Noise()
			if(src.Dead == 0)
				if(src.Race == "Frogman")
					view(5) << 'Frog.wav'
				if(src.Race == "Yeti")
					view(5) << 'Yeti.wav'
			spawn(350) Noise()
		EvilRessurect()
			if(src.Dead == 0 && src.Job == null && src.Target == null)
				for(var/obj/Items/Body/B in view(6,src))
					var/CanRes = 1
					if(B.LeftArm == 0 && B.RightArm == 0 && B.LeftLeg == 0 && B.RightLeg == 0)
						CanRes = 0
					if(B.Brain <= 20)
						CanRes = 0
					if(CanRes)
						var/mob/HasOwner = null
						if(B.Owner)
							if(ismob(B.Owner))
								HasOwner = B.Owner
							else
								for(var/mob/M in Players)
									if(M.name == B.Owner)
										HasOwner = M
						if(HasOwner)
							view(src) << "<font color = yellow>[src] begins to call upon their Un-Holy Powers, as they do the energies begin to revive [B] back to life!<br>"
							src.Job = "Revive"
							src.overlays += /obj/Misc/SpellEffects/Evil/
							spawn(1000)
								if(src)
									src.overlays -= /obj/Misc/SpellEffects/Evil/
									src.Job = null
									if(B)
										if(HasOwner)
											if(B in range(6,src))
												view(src) << "<font color = yellow>[HasOwner] is raised into un-death by [src]'s Un-Holy Powers!<br>"
												HasOwner.EvilRevive(B)
												del(B)
											else
												src.overlays -= /obj/Misc/SpellEffects/Evil/
										else
											src.overlays -= /obj/Misc/SpellEffects/Evil/
									else
										src.overlays -= /obj/Misc/SpellEffects/Evil/
			spawn(100) EvilRessurect()
		Ressurect()
			if(src.Dead == 0 && src.Job == null && src.Target == null)
				for(var/obj/Items/Body/B in view(6,src))
					var/mob/HasOwner = null
					if(B.Owner)
						if(ismob(B.Owner))
							HasOwner = B.Owner
						else
							for(var/mob/M in Players)
								if(M.name == B.Owner)
									HasOwner = M
					if(HasOwner)
						var/WillRevive = 1
						if(HasOwner.Faction in src.HateList)
							WillRevive = 0
						if(WillRevive && HasOwner.Faction != "Undead" && HasOwner.CanBeRevived != 0)
							view(src) << "<font color = yellow>[src] begins to call upon their healing powers, as they do the energies begin to revive [B] back to life!<br>"
							src.Job = "Revive"
							src.overlays += /obj/Misc/SpellEffects/Dispel/
							spawn(1000)
								if(src)
									src.overlays -= /obj/Misc/SpellEffects/Dispel/
									src.Job = null
									if(B)
										if(HasOwner)
											if(B in range(6,src))
												HasOwner.GoodRevive(B)
												HasOwner.Heal()
												del(B)
												if(HasOwner.Age >= HasOwner.DieAge)
													HasOwner.CanBeRevived -= 1
												view(src) << "<font color = yellow>[HasOwner] is raised from the dead by [src]'s healing powers!<br>"
											else
												src.overlays -= /obj/Misc/SpellEffects/Dispel/
										else
											src.overlays -= /obj/Misc/SpellEffects/Dispel/
									else
										src.overlays -= /obj/Misc/SpellEffects/Dispel/
			spawn(100) Ressurect()
		Update()
			if(src)
				if(src.client)
					if(src.Dead == 0)
						for(var/obj/HUD/GUI/BloodBar/B in src.client.screen)
							if(src.BloodMax)
								if(src.Dead)
									B.icon_state = "Dead"
									return
								if(src.Blood <= 0)
									src.Blood = 1
								var/Div = src.Blood / src.BloodMax
								var/Num = Div * 100
								var/Rounded = round(Num,10)
								B.icon_state = "[Rounded]"
								var/Blood = src.Bleed
								if(src.Bleed == null)
									Blood = "None"
								B.name = "Blood Tracker - [Blood]"
			spawn(10) Update()
		Breathe(var/TimeLeft)
			if(src.StoredFaction == "Undead")
				return
			if(src.Faction == "Undead")
				return
			if(src.CanBreathe == 0)
				return
			if(src.Dead)
				return
			if(src.InWater != 2)
				return
			if(TimeLeft == null)
				TimeLeft = 1200
				view() << "<font color = yellow>[src] holds their breath!<br>"
			if(TimeLeft != 0)
				TimeLeft -= 1
			if(TimeLeft == 700)
				view() << "<font color = yellow>[src] seems to be having trouble holding their breathe!<br>"
			if(TimeLeft == 200)
				view() << "<font color = yellow>[src] is in danger of drowning!<br>"
			if(TimeLeft == 0)
				view() << "<font color = yellow>[src] drowns.<br>"
				src.overlays -= /obj/Misc/Bubbles/
				src.Death()
				return
			spawn(1) Breathe(TimeLeft)
		CheckFlamable()
			var/Burn = 0
			for(var/obj/Items/I in src)
				if(I.Fuel && I.OnFire == 0)
					Burn = 1
			if(Burn)
				src.OnFire(1)
				src.overlays += /obj/Misc/Fire/
				src << "<font color = red>Some of your items that you carry catch on fire!<br>"
			else
				src.luminosity = 0
				src.OnFire = 0
		OnFire(var/Ignite = 0)
			if(Ignite == 0)
				var/msg = prob(25)
				if(msg)
					src << "<font color = red>You are burned by flames!<br>"
			if(src.OnFire)
				var/limb = rand(1,5)
				var/roll = prob(2)
				if(src.Humanoid)
					if(src.WChest)
						var/obj/O = src.WChest
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(src.WUpperBody)
						var/obj/O = src.WUpperBody
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(src.WHead)
						var/obj/O = src.WHead
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(src.WLeftHand)
						var/obj/O = src.WLeftHand
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(src.WRightHand)
						var/obj/O = src.WRightHand
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(src.WLeftFoot)
						var/obj/O = src.WLeftFoot
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(src.WRightFoot)
						var/obj/O = src.WRightFoot
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(src.WLegs)
						var/obj/O = src.WLegs
						if(O.Fuel)
							O.Dura -= rand(4,6)
							src.CheckArmourDura()
					if(limb == 1)
						if(src.Skull)
							src.Skull -= rand(1,3)
							src.Blood -= rand(2,3)
							src.Pain += rand(2,3)
							src.Bleed()
							if(src.Hair)
								var/BurnAway = prob(10)
								if(BurnAway)
									view(src) << "<font color =red>[src]'s hair burns away!<br>"
									src.overlays -= src.Hair
									src.Hair = null
							if(src.Beard)
								var/BurnAway = prob(10)
								if(BurnAway)
									view(src) << "<font color =red>[src]'s beard burns away!<br>"
									src.overlays -= src.Beard
									src.Beard = null
							if(src.Skull <= 15)
								src.Death()
								view(src) << "<font color =red>[src] has been burned to a cinder, they die instantly!<br>"
					if(limb == 2)
						if(src.LeftArm)
							src.LeftArm -= rand(2,3)
							src.Blood -= rand(2,3)
							src.Pain += rand(2,3)
							src.Bleed()
							if(src.LeftArm <= 25)
								if(src.Weapon2)
									var/obj/O = src.Weapon2
									src.overlays-=image(O.icon,"[O.icon_state] left",O.ItemLayer)
									O.overlays = null
									O.Move(src.loc)
									O.overlays = null
									O.suffix = null
									O.layer = 4
									O.icon_state = O.CarryState
									src.Weapon2 = null
									src.client.screen -= O
									src.Weight -= O.Weight
									view(src) << "<font color =red>[src]'s Right Arm is horribly burned, they drop their [src.Weapon2] in pain!<br>"
							if(src.LeftArm <= 0)
								src.LeftArm = 5
					if(limb == 3)
						if(src.RightArm)
							src.RightArm -= rand(2,3)
							src.Blood -= rand(2,3)
							src.Pain += rand(2,3)
							src.Bleed()
							if(src.RightArm <= 25)
								if(src.Weapon)
									var/obj/O = src.Weapon
									src.overlays-=image(O.icon,O.icon_state,O.ItemLayer)
									O.overlays = null
									O.Move(src.loc)
									O.overlays = null
									O.suffix = null
									O.layer = 4
									O.icon_state = O.CarryState
									src.Weapon = null
									src.client.screen -= O
									src.Weight -= O.Weight
									view(src) << "<font color =red>[src]'s Right Arm is horribly burned, they drop their [src.Weapon] in pain!<br>"
							if(src.RightArm <= 0)
								src.RightArm = 5
					if(limb == 4)
						if(src.LeftLeg)
							src.LeftLeg -= rand(2,3)
							src.Blood -= rand(2,3)
							src.Pain += rand(2,3)
							src.Bleed()
							if(src.LeftLeg <= 0)
								src.LeftLeg = 5
					if(limb == 5)
						if(src.RightLeg)
							src.RightLeg -= rand(2,3)
							src.Blood -= rand(2,3)
							src.Pain += rand(2,3)
							src.Bleed()
							if(src.RightLeg <= 0)
								src.RightLeg = 5
				else
					src.Blood -= rand(2,4)
					src.Pain += rand(4,5)
					src.Bleed()
				if(roll)
					if(src.Type != "Egg")
						src.OnFire = 0
						src.Fuel = 100
						src.luminosity = 0
						src.overlays -= /obj/Misc/Fire/
						view(src) << "<font color=red>[src] rolls on the ground and exstinguishes the flames!<br>"
						return
			else
				src.luminosity = 0
				src.overlays -= /obj/Misc/Fire/
				return
			if(Ignite)
				spawn(75) OnFire(Ignite)
		AnimalAI()
			var/Delay = rand(15,30)
			if(src.Fainted == 0 && src.Stunned == 0)
				if(src.InWater)
					Delay += 10
				if(src.CancelDefaultProc)
					return
				if(src.Dead)
					return
				else
					if(src.Target)
						if(ismob(src.Target))
							var/mob/M = src.Target
							if(M.z != src.z)
								var/Dis = get_dist(src,M)
								if(Dis >= 2)
									src.Target = null
								if(M.Dead)
									src.Target = null
							else
								src.Target = null
					if(src.Target == null)
						step_rand(src)
			spawn(Delay) AnimalAI()

		GuardAI()
			var/Delay = rand(20,40)
			if(src.InWater)
				Delay += 10
			if(src.CancelDefaultProc)
				return
			if(src.Dead)
				return
			if(src.Owner)
				return
			if(src.loc == src.GuardLoc)
				src.dir = src.GuardDir
			if(src.Fainted == 0 && src.Stunned == 0)
				if(src.Target == null)
					for(var/mob/M in oview(6,src))
						if(M.Dead == 0)
							if(M.Faction in src.HateList)
								src.Target = M
							if(M.name in src.HateList)
								src.Target = M
							if(M.Target)
								if(ismob(M.Target))
									var/mob/T = M.Target
									if(T.Faction == src.Faction && T.client == null)
										src.Target = M
				if(src.Target)
					Delay = 8
					step_towards(src,src.Target)
					if(ismob(src.Target))
						var/mob/M = src.Target
						var/Dis = get_dist(src,M)
						if(Dis >= 6)
							src.Target = null
						if(M.Dead)
							src.Target = null
						if(M.z != src.z)
							src.Target = null
				if(src.Target == null)
					step_towards(src,src.GuardLoc)
			spawn(Delay) GuardAI()

		FollowAI()
			if(src.CancelDefaultProc)
				return
			if(src.Dead)
				return
			if(src.Fainted == 0)
				if(src.Stunned == 0)
					if(src.Owner)
						var/mob/M = src.Owner
						if(M.Faction != src.Faction)
							return
						if(M.Dead)
							src.Owner = null
							src.NormalAI()
							return
						if(M.Target)
							src.Target = M.Target
							step_towards(src,src.Target)
						if(M.Target == null)
							src.Target = null
							step_towards(src,M)
					else
						src.NormalAI()
						return
			spawn(9) FollowAI()
		InquisitiveGuardAI(var/mob/Suspect)
			var/Delay = rand(20,40)
			if(src.InWater)
				Delay += 10
			if(src.CancelDefaultProc)
				return
			if(src.Dead)
				return
			if(src.Owner)
				return
			if(src.loc == src.GuardLoc)
				src.dir = src.GuardDir
			if(src.Fainted == 0 && src.Stunned == 0)
				if(isturf(src.Target))
					if(src.Target in range(1,src))
						if(Suspect in range(1,src))
							if(Suspect.WBack)
								var/obj/O = Suspect.WBack
								O.layer = O.ItemLayer
								Suspect.overlays-=image(O.icon,O.icon_state,O.ItemLayer)
								Suspect.WBack = null
								O.suffix = "Carried"
								O.overlays-=image(/obj/HUD/E/)
								O.overlays+=image(/obj/HUD/C/)
								O.icon_state = O.CarryState
								O.layer = 20
								Suspect.DeleteInventoryMenu()
								if(Suspect.OrginalName)
									Suspect.name = Suspect.OrginalName
									Suspect.OrginalName = null
								if(Suspect.StoredFaction)
									Suspect.Faction = Suspect.StoredFaction
									Suspect.StoredFaction = null
								view(6,src) << "<font color = yellow>[src] pulls off [Suspect]'s Cloak.<br>"
							src.Target = null
							Suspect = null
						else
							var/DIST = get_dist(src,Suspect)
							if(DIST <= 3)
								src.Target = Suspect.loc
							else if(Suspect)
								if(Suspect.WBack)
									Suspect << "<font color = teal>[src] points at you, and shouts for everyone to attack. You dident stop to let [src] remove your cloak."
									for(var/mob/M in oview(8,src))
										if(M.Target == null && M.Faction == src.Faction)
											M.Target = Suspect
									src.Target = Suspect
									Suspect = null
				if(src.Target == null)
					for(var/mob/M in oview(6,src))
						if(M.Dead == 0)
							if(M.Faction == "None" && Suspect == null)
								Suspect = M
								src.Target = M.loc
								M << "<font color = teal>[src] is coming to remove your cloak!<br>"
							if(M.Faction in src.HateList)
								src.Target = M
							if(M.name in src.HateList)
								src.Target = M
							if(M.Target)
								if(ismob(M.Target))
									var/mob/T = M.Target
									if(T.Faction == src.Faction && T.client == null)
										src.Target = M
				if(src.Target)
					Delay = 8
					step_towards(src,src.Target)
					if(ismob(src.Target))
						var/mob/M = src.Target
						var/Dis = get_dist(src,M)
						if(Dis >= 6)
							src.Target = null
						if(M.Dead)
							src.Target = null
						if(M.z != src.z)
							src.Target = null
				if(src.Target == null)
					step_towards(src,src.GuardLoc)
			spawn(Delay) InquisitiveGuardAI(Suspect)
		InquisitiveAI(var/mob/Suspect)
			var/Delay = rand(15,30)
			if(src.InWater)
				Delay += 10
			if(src.CancelDefaultProc)
				return
			if(src.Dead)
				return
			if(src.Fainted == 0 && src.Stunned == 0)
				src.LastLoc = src.loc
				if(isturf(src.Target))
					if(src.Target in range(1,src))
						if(Suspect in range(1,src))
							if(Suspect.WBack)
								view(6,src) << "<font color = yellow>[src] pulls off [Suspect]'s Cloak.<br>"
								var/obj/O = Suspect.WBack
								O.layer = O.ItemLayer
								Suspect.overlays-=image(O.icon,O.icon_state,O.ItemLayer)
								Suspect.WBack = null
								O.suffix = "Carried"
								O.overlays-=image(/obj/HUD/E/)
								O.overlays+=image(/obj/HUD/C/)
								O.icon_state = O.CarryState
								O.layer = 20
								Suspect.DeleteInventoryMenu()
								if(Suspect.OrginalName)
									Suspect.name = Suspect.OrginalName
									Suspect.OrginalName = null
								if(Suspect.StoredFaction)
									Suspect.Faction = Suspect.StoredFaction
									Suspect.StoredFaction = null
							src.Target = null
							Suspect = null
						else
							var/DIST = get_dist(src,Suspect)
							if(DIST <= 3)
								src.Target = Suspect.loc
							else if(Suspect)
								if(Suspect.WBack)
									Suspect << "<font color = teal>[src] points at you, and shouts for everyone to attack. You dident stop to let [src] remove your cloak."
									for(var/mob/M in oview(8,src))
										if(M.Target == null && M.Faction == src.Faction)
											M.Target = Suspect
									src.Target = Suspect
									Suspect = null
				if(src.Target == null)
					for(var/mob/M in oview(6,src))
						if(M.Dead == 0)
							if(M.Faction == "None" && Suspect == null)
								Suspect = M
								src.Target = M.loc
								M << "<font color = teal>[src] is coming to remove your cloak!<br>"
							if(M.Faction in src.HateList)
								src.Target = M
							if(M.Target)
								if(ismob(M.Target))
									var/mob/T = M.Target
									if(T.Faction == src.Faction && T.client == null)
										src.Target = M
				if(src.Target)
					Delay = 8
					step_towards(src,src.Target)
					if(ismob(src.Target))
						var/mob/M = src.Target
						var/Dis = get_dist(src,M)
						if(Dis >= 6)
							src.Target = null
						if(M.Dead)
							src.Target = null
						if(M.z != src.z)
							src.Target = null
				if(src.Target == null)
					step_rand(src)
			spawn(Delay) InquisitiveAI(Suspect)
		NormalAI()
			if(src.client)
				return
			var/Delay = rand(15,30)
			if(src.InWater)
				Delay += 10
			if(src.CancelDefaultProc)
				return
			if(src.Dead)
				return
			if(src.Fainted == 0 && src.Stunned == 0)
				src.LastLoc = src.loc
				if(src.Target == null)
					for(var/mob/M in oview(6,src))
						if(M.Dead == 0)
							if(M.Faction in src.HateList)
								src.Target = M
							if(M.Target)
								if(ismob(M.Target))
									var/mob/T = M.Target
									if(T.Faction == src.Faction && T.client == null)
										src.Target = M
				if(src.Target == null)
					step_rand(src)
				if(src.Target)
					Delay = 9
					step_towards(src,src.Target)
					if(ismob(src.Target))
						var/mob/M = src.Target
						var/Dis = get_dist(src,M)
						if(Dis >= 6)
							src.Target = null
						if(M.Dead)
							src.Target = null
						if(M.z != src.z)
							src.Target = null
			spawn(Delay) NormalAI()
		FindSuitableLocation()
			var/Found = 0
			while(Found == 0)
				src.loc = locate(rand(1,250),rand(1,300),1)
				for(var/turf/T in range(0,src))
					if(T.density == 0 && T.ManMade == 0)
						Found = 1
		Speak(var/T,var/SpeakRange,var/Target)
			var/obj/SL = src.CurrentLanguage
			for(var/mob/M in hearers(SpeakRange,src))
				var/NewText = null
				var/Text = null
				var/TextLength = lentext(T)
				var/Understands = 0
				if(src.CurrentLanguage)
					for(var/obj/Misc/Languages/HL in M.LangKnow)
						if(SL.name == HL.name)
							Understands = HL.SpeakPercent
							if(HL.SpeakPercent <= 100)
								var/NotSpeaker = 1
								if(HL in src.LangKnow)
									NotSpeaker = 0
								if(NotSpeaker)
									if(SL.SpeakPercent >= HL.SpeakPercent && HL.SpeakPercent <= 97)
										HL.SpeakPercent += M.Intelligence / 20
										if(M.Intelligence <= M.IntCap && M.Intelligence <= WorldIntCap && M.Intelligence <= M.IntelligenceMax)
											M.Intelligence += M.IntelligenceMulti / 10
				if(Understands == 0)
					M.LearnRaceLanguages("[src.CurrentLanguage]")
				while(TextLength >= 1)
					Text ="[copytext(T,(lentext(T)-TextLength)+1,(lentext(T)-TextLength)+2)]"
					var/Change = 0
					Change = prob(100 - Understands)
					if(Change)
						M.CheckText(Text)
						NewText+="[M.TextOutput]"
						M.TextOutput = null
					if(Change == 0)
						NewText+="[copytext(T,(lentext(T)-TextLength)+1,(lentext(T)-TextLength)+2)]"
					TextLength--
				if(src.OrginalName == null)
					M << "<font color=teal>[src] says in [SL.name]: [NewText]<br>"
				else
					M << "<font color=teal>([src.OrginalName])[src] says in [SL.name]: [NewText]<br>"
				if(Target)
					Target << "<font color=teal>[src] says in [SL.name]: [NewText]<br>"
		RaceRules()
			src << "<font color = blue>These are the guidelines to Role Playing with the Race you have selected, these guidelines do not effect your character stat wise.<br>"
			if(src.Race == "Alther")
				src << "<font color = blue>Race - Alther<br>"
				src << "<font color = blue>Altherions know all races<br>"
				src << "<font color = blue>Altherions can worship any good god, they start out worshipping the God of Harvest or Beasts.<br>"
				src << "<font color = blue>Altherions hate the following races by default, Undead, Cyclops, Ratlings<br>"
				src << "<font color = blue>Altherions have heard of, but do not know how to use, Elemental Magic, Blood Magic, Chaos Magic, Astral Magic, Necromancy.<br>"
				src << "<font color = blue>Altherions can use Nature Magic for various tasks<br>"
				src << "<font color = blue>Altherions know of all their settlements and all Human towns.<br>"
				src << "<font color = blue>Altherions are a very proud race, and have very strong opinions on things they belive in. They are easily offended and can be quite arrogant at times. They do not wish to harm living beings, but will kill if needed, they hate the Undead, Demonic and Chaos races and have made it their mission to destroy them.<br>."
				src << "<font color = blue>Altherions do not fear death, but do not seek it.<br>"
			if(src.Race == "Ratling")
				src << "<font color = blue>Race - Ratling<br>"
				src << "<font color = blue>Ratlings know the following races, Giants, Cyclops, Undead, Humans, Altherions, Ratlings, Flesh Beast<br>"
				src << "<font color = blue>Ratlings have heard of but not seen, Liches, Chaos Entity, Corpse Devourer<br>"
				src << "<font color = blue>Ratlings can worship any god, they start out worshipping the God of Death.<br>"
				src << "<font color = blue>Ratlings hate the following races by default, Undead, Cyclops, Humans, Altherions, Giants<br>"
				src << "<font color = blue>Ratlings have heard of, but do not know how to use, Blood Magic, Chaos Magic, Necromancy.<br>"
				src << "<font color = blue>Ratlings only know of the sewer they are born in, they do however know there are more sewers in other towns.<br>"
				src << "<font color = blue>Ratlings are very alert and paranoid, they often fight each other over sleeping/living space and food. They tend to hate the sun light and wear cloaks to conceal them selves at day time. They are cunning and quick to anger, but will not openly appear so, they would rather hate an enemy secretly and back stab them later.<br>."
				src << "<font color = blue>Ratlings fear death when outnumbered.<br>"
			if(src.Race == "Frogman")
				src << "<font color = blue>Race - Frogman<br>"
				src << "<font color = blue>Frogmen know the following races, Altherions, Ratlings, Humans, Frogmen<br>"
				src << "<font color = blue>Frogmen have heard of but not seen, Giants, Cyclops, Chaos Entity, Flesh Beast, Corpse Devourer<br>"
				src << "<font color = blue>Frogmen can worship any god, they start out worshipping the Gods of Harvest and Beasts.<br>"
				src << "<font color = blue>Frogmen hate the following races by default, Ratlings<br>"
				src << "<font color = blue>Frogmen have heard of, but do not know how to use, Elemental Magic, Nature Magic, Blood Magic<br>"
				src << "<font color = blue>Frogmen know the location of all their swamps and often fight over them.<br>"
				src << "<font color = blue>Frogmen are very alert and easy to scare, they are brave in numbers. They are usually a friendly primitive people, but fight over breeding grounds during the summer. They are quick to anger if offended and have strong opinions about anything they belive in.<br>."
				src << "<font color = blue>Frogmen fear death if alone, but do not fear it in numbers.<br>"
			if(src.Race == "Cyclops")
				src << "<font color = blue>Race - Cyclops<br>"
				src << "<font color = blue>Cyclops know the following races, Ratlings, Giants, Cyclops, Humans, Undead<br>"
				src << "<font color = blue>Cyclops have heard of but not seen, Altherions, Frogmen, Liches, Chaos Entity, Flesh Beast, Corpse Devourer<br>"
				src << "<font color = blue>Cyclops can worship the Blood and Death god, but start off worshipping the God of Destruction.<br>"
				src << "<font color = blue>Cyclops hate the following races by default, Undead, Giants, Humans<br>"
				src << "<font color = blue>Cyclops have heard of, but do not know how to use, Elemental Magic, Nature Magic, Blood Magic, Chaos Magic, and Necromancy<br>"
				src << "<font color = blue>Cyclops know the location of all their caves.<br>"
				src << "<font color = blue>Cyclops get angry at anything they do not understand, which is most things. They have a short temper and hate anything beautiful. They get pychotic if hurt or hungry, which means they hate everyone they meet, even other Cyclops.<br>"
				src << "<font color = blue>Cyclops dont understand the concept of death, and thus do not fear it.<br>"
			if(src.Race == "Giant")
				src << "<font color = blue>Race - Giant<br>"
				src << "<font color = blue>Giants know the following races, Giants, Cyclops, Undead, Humans<br>"
				src << "<font color = blue>Giants have heard of but not seen, Altherions, Frogmen, Ratlings, Chaos Entity, Flesh Beast, Corpse Devourer<br>"
				src << "<font color = blue>Giants can worship any god, they start out with no worship to any god.<br>"
				src << "<font color = blue>Giants hate the following races by default, Undead, Cyclops<br>"
				src << "<font color = blue>Giants have heard of, but do not know how to use, Elemental Magic, Nature Magic<br>"
				src << "<font color = blue>Giants know the location of all their towns, but do not know the location of their caves, except for the one they start in.<br>"
				src << "<font color = blue>Giants can be very moody. They get angry when hungry or tired, but are quite gentle most of the time<br>."
				src << "<font color = blue>Giants fear death and do not seek it. They can however enter a berzerk state and ignore the thought of pain/death<br>"
			if(src.Race == "Stahlite")
				src << "<font color = blue>Race - Stahlite<br>"
				src << "<font color = blue>Stahlites know the following races, Ratlings, Giants, Cyclops, Frogmen, Altherions, Humans, Undead, Chaos Entity<br>"
				src << "<font color = blue>Stahlites have heard of but not seen, Liches, Flesh Beast, Corpse Devourer<br>"
				src << "<font color = blue>Stahlites can worship any god, they start out worshipping the God of Crafts.<br>"
				src << "<font color = blue>Stahlites hate the following races by default, Ratlings, Undead, Cyclops, Giants<br>"
				src << "<font color = blue>Stahlites have heard of, but do not know how to use, Elemental Magic, Nature Magic, Blood Magic, Chaos Magic, and Necromancy<br>"
				src << "<font color = blue>Stahlites know the location of all their mines and fortresses.<br>"
				src << "<font color = blue>Stahlites do not fear pain, but are a little wary of death, unless drunk.<br>"
			if(src.Race == "Human")
				src << "<font color = blue>Race - Human<br>"
				src << "<font color = blue>Humans know the following races, Ratlings, Giants, Cyclops, Frogmen, Altherions, Undead<br>"
				src << "<font color = blue>Humans have heard of but not seen, Liches, Chaos Entity, Flesh Beast, Corpse Devourer<br>"
				src << "<font color = blue>Humans can worship any god, they start out with no worship to any god.<br>"
				src << "<font color = blue>Humans hate the following races by default, Ratlings, Undead, Cyclops<br>"
				src << "<font color = blue>Humans have heard of, but do not know how to use, Elemental Magic, Nature Magic, Blood Magic, Astral Magic, Chaos Magic, and Necromancy<br>"
				src << "<font color = blue>Humans know the location of all their towns and any fallen towns/chapels taken by the undead.<br>"
				src << "<font color = blue>Humans fear death and do not seek it.<br>"
			if(src.Race == "Wolfman")
				src << "<font color = blue>Race - Wolfman<br>"
				src << "<font color = blue>Wolfmen know the following races, Ratlings, Giants, Cyclops, Frogmen, Altherions, Humans, Stahlite, Undead<br>"
				src << "<font color = blue>Wolfmen have heard of but not seen, Liches, Chaos Entity, Flesh Beast, Corpse Devourer<br>"
				src << "<font color = blue>Wolfmen tend to worship the gods of Beasts, Destruction and very rarely, Death.<br>"
				src << "<font color = blue>Wolfmen hate the following races by default, Ratlings, Humans, Cyclops, Giants, Frogmen, Altherians, Stahlite. <br>"
				src << "<font color = blue>Wolfmen do not know of any magics, except Nature magic, of which they know very little about.<br>"
				src << "<font color = blue>Wolfmen only know the location of their own camps or caves and requently fight with other packs.<br>"
				src << "<font color = blue>Wolfmen do not fear death, and being in a pack sends them berzerk in battle.<br>"
			if(src.Race == "Snakeman")
				src << "<font color = blue>Race - Snakeman<br>"
				src << "<font color = blue>Snakeman know the following races, Wolfmen, Ratlings, Giants, Cyclops, Frogmen, Altherions, Humans, Stahlite, Undead<br>"
				src << "<font color = blue>Snakeman have heard of but not seen, Liches, Chaos Entity, Flesh Beast, Corpse Devourer<br>"
				src << "<font color = blue>Snakeman are obessed with prolonging their own lives, so they worship the Gods of Blood, Death and Wisdom..<br>"
				src << "<font color = blue>Snakeman hate the following races by default, Ratlings, Cyclops, Frogmen, Altherians.<br>"
				src << "<font color = blue>Snakeman know all the magics of the world, but are mainly intrested in ones that manipulate others, or prolong ones life.<br>"
				src << "<font color = blue>Snakeman know the location of the Humans, Altherians and Stahlite settlements, as well as their own. And also know of the Ratlings hiding locations.<br>"
				src << "<font color = blue>Snakeman fear death above all else, and go to great lengths to make sure they do not meet their demise.<br>"
			if(src.Race == "Illithid")
				src << "<font color = blue>Race - Illithid<br>"
				src << "<font color = blue>Illithid have heard of and seen every race.<br>"
				src << "<font color = blue>Illithid do not feel hate, but dis-like all other races except those that dwell in the oceans. They are on good terms with the Frogmen.<br>"
				src << "<font color = blue>Illithid know about all kinds of Magic in this world. They are especially skilled in Astral Magic and use it to manipulate and enslave others using psionic powers.<br>"
				src << "<font color = blue>Illithid know every location of every races settlements and hiding spots.<br>"
				src << "<font color = blue>Illithid do not openly seek death but embrace it in the name of their god if needed.<br>"
				src << "<font color = blue>Illithid are bent on enslaving all races, using them as labour to rebuild their once massive Empire. Arriving upon this world many hundreds of years ago using a great Astral Gate, the Illithid originally enslaved much of the known races. However, thanks to the few free Altheiran mages, they were stopped and stranded here. Having no means to power their Astral Gate, the Illithids must use slaves to gather minerals needed. Illithids also eat and collect brains for their Elder God.<br>"
				src << "<font color = blue>Illithid can use Telekinesis on objects and people while the Interact button is on and they click and drag, it will drain their Tiredness, at which point they can not continue. Upon being attacked, you will deflect the damage with your mind but be drained of tiredness based on the damage.<br>"
			src << "<font color = blue><b>Remember, these are just guidelines, you may role play your character in any direction, so long as the RolePlay is consistant and makes sense.<br>"
		CreateCharacter()
			src.DeleteAll()
			var/find_player = "players/[ckey].sav"
			if(length(file(find_player)))
				src << "<font color = teal>File [find_player] Deleted...<br>"
				fdel(find_player)
			var/N = input("Character Name - This must be a Role Play name, names with extensions like Sir, Lord, and Master are not allowed. An example of a good Role Play name would be Valmire Thelinos or Elsandra Malvoire")as null|text
			if(!N)
				N = "Nameless"
			for(var/mob/M in Players)
				if(M.name == N)
					N = "Nameless"
			src.LoggedIn = 1
			src.name = "[Safe_Guard(N)]"
			src.Head = 100
			src.Torso = 100
			src.LeftArm = 100
			src.RightArm = 100
			src.LeftLeg = 100
			src.RightLeg = 100
			src.Skull = 100
			src.Brain = 100
			src.LeftEye = 100
			src.RightEye = 100
			src.LeftEar = 100
			src.RightEar = 100
			src.Teeth = 100
			src.Nose = 100
			src.Tongue = 100
			src.Throat = 100
			src.RaceRules()
			src.Heart = 100
			src.LeftLung = 100
			src.RightLung = 100
			src.Spleen = 100
			src.Intestine = 100
			src.LeftKidney = 100
			src.RightKidney = 100
			src.Liver = 100
			src.Bladder = 100
			src.Stomach = 100
			src.CanMove = 1
			src.BloodColour = /obj/Misc/Gore/BloodSplat/
			src.BloodWallColour = /obj/Misc/Gore/WallBloodSplat/
			if(src.Race == "Illithid")
				src.HungerMulti = 1
				src.CanUseTK = 1
				src.DieAge = rand(200,500)
				src.MagicPotentcy = rand(50,150)
				src.loc = locate(286,173,3)
				src.icon = 'illithid.dmi'
				src.icon_state = "N"
				src.WeightMax = 100
				src.AstralMagic = 20
				src.Strength += 2.5
				src.Agility += 10
				src.Endurance += 2.5
				src.Intelligence += 25
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 25
				src.AgilityMax = 30
				src.EnduranceMax = 25
				src.IntelligenceMax = 80

				src.StrengthMulti = 0.05
				src.AgilityMulti = 0.2
				src.EnduranceMulti = 0.05
				src.IntelligenceMulti = 0.5

				src.SwordSkill += 10
				src.AxeSkill += 0
				src.SpearSkill += 10
				src.BluntSkill += 10
				src.RangedSkill += 10
				src.DaggerSkill += 10
				src.UnarmedSkill += 10
				src.ShieldSkill += 10

				src.SwordSkillMulti = 0.2
				src.AxeSkillMulti = 0.1
				src.SpearSkillMulti = 0.2
				src.BluntSkillMulti = 0.2
				src.RangedSkillMulti = 0.2
				src.DaggerSkillMulti = 0.2
				src.UnarmedSkillMulti = 0.2
				src.ShieldSkillMulti = 0.2

				src.CarpentrySkillMulti = 0.6
				src.MiningSkillMulti = 0.2
				src.MasonarySkillMulti = 0.6
				src.SmeltingSkillMulti = 0.6
				src.ForgingSkillMulti = 0.6
				src.WoodCuttingSkillMulti = 0.6
				src.AlchemySkillMulti = 1
				src.CookingSkillMulti = 0.6
				src.SkinningSkillMulti = 0.6
				src.LeatherCraftSkillMulti = 0.6
				src.FishingSkillMulti = 1
				src.BuildingSkillMulti = 1
				src.FarmingSkillMulti = 0.6
				src.WeavingSkillMulti = 0.6
				src.EngravingSkillMulti = 1
				src.FirstAidSkillMulti = 0.6
				src.ButcherySkillMulti = 0.6
				src.BoneCraftMulti = 0.6
				var/obj/Items/Armour/Chest/Robe/R = new
				R.overlays += image(/obj/HUD/E/)
				R.Defence = 2
				R.suffix = "Equip"
				R.icon_state = R.EquipState
				R.layer = 20
				R.Move(src)
				src.WChest = R
				src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
				var/obj/Items/Weapons/Spears/Trident/T = new
				T.Material = "Iron"
				T.Move(src)
				T.suffix = "Equip"
				T.overlays += image(/obj/HUD/E)
				T.icon_state = T.EquipState
				src.overlays+=image(T.icon,T.icon_state,T.ItemLayer)
				src.Weapon = T
				src.Blood = 85
				src.BloodMax = 85
				src.Faction = "Illithid Cultists"
				src.DarkVision = 4
				src.Born = Year - 100
				src.Age = Year - 100
				src.CanSwimWell = 1
				src.CanRegenLimbs = 1
				src.Claws = 100
				src.CanBreathe = 0
				src.see_in_dark = 3
				src.DarkVision = 3
				src.CanEatRawMeats = 2
			if(src.Race == "Alther")
				if(src.Gender == "Male")
					src.icon = 'elf.dmi'
				if(src.Gender == "Female")
					src.icon = 'elf(F).dmi'
				src.PregType = "Womb"
				src.HungerMulti = 1
				src.DieAge = rand(150,200)
				src.MagicPotentcy = rand(20,101)
				src.loc = locate(237,82,1)
				src.icon_state = "N"
				src.WeightMax = 90
				src.Strength += 4.5
				src.Agility += 10
				src.Endurance += 4
				src.Intelligence += 15
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 40
				src.AgilityMax = 60
				src.EnduranceMax = 40
				src.IntelligenceMax = 65
				var/PlayerBorn = 0
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Gender == "Female" && M.Preg == 2)
						if(src.client.address == M.client.address && M != src)
							world << "<font color = teal><b>([src.key])[src] - [src.OrginalName] was booted for Alt Key Interaction involving character creation!<br>"
							del(src)
							return
						PlayerBorn = 1
						src.Strength += M.Strength / 8
						src.Strength += M.FatherStrength
						src.Agility += M.Agility / 8
						src.Agility += M.FatherAgility
						src.Endurance += M.Endurance / 8
						src.Endurance += M.FatherEndurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						M.FatherEndurance = 0
						M.FatherAgility = 0
						M.FatherAgility = 0
						M.Preg = 3
						M.BirthTimer()
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] is born to [M]!<br>"
						break
				src.StrengthMulti = 0.09
				src.AgilityMulti = 0.2
				src.EnduranceMulti = 0.08
				src.IntelligenceMulti = 0.3

				src.SwordSkill += 10
				src.AxeSkill += 0
				src.SpearSkill += 10
				src.BluntSkill += 10
				src.RangedSkill += 10
				src.DaggerSkill += 10
				src.UnarmedSkill += 10
				src.ShieldSkill += 10

				src.SwordSkillMulti = 0.5
				src.AxeSkillMulti = 0.1
				src.SpearSkillMulti = 0.5
				src.BluntSkillMulti = 0.5
				src.RangedSkillMulti = 0.5
				src.DaggerSkillMulti = 0.5
				src.UnarmedSkillMulti = 0.5
				src.ShieldSkillMulti = 0.5

				src.CarpentrySkillMulti = 0.4
				src.MiningSkillMulti = 0.2
				src.MasonarySkillMulti = 0.8
				src.SmeltingSkillMulti = 0.8
				src.ForgingSkillMulti = 0.8
				src.WoodCuttingSkillMulti = 0.2
				src.AlchemySkillMulti = 0.8
				src.CookingSkillMulti = 0.6
				src.SkinningSkillMulti = 0.2
				src.LeatherCraftSkillMulti = 0.2
				src.FishingSkillMulti = 0.4
				src.BuildingSkillMulti = 0.8
				src.FarmingSkillMulti = 0.8
				src.WeavingSkillMulti = 0.8
				src.EngravingSkillMulti = 0.6
				src.FirstAidSkillMulti = 0.8
				src.ButcherySkillMulti = 0.2
				src.BoneCraftMulti = 0.2
				if(PlayerBorn == 0)
					var/obj/Items/Armour/UpperBody/LeatherVest/LV = new
					LV.overlays += image(/obj/HUD/E/)
					LV.Defence = 2
					LV.suffix = "Equip"
					LV.icon_state = LV.EquipState
					LV.layer = 20
					LV.Move(src)
					src.WUpperBody = LV
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
					var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
					LL.overlays += image(/obj/HUD/E/)
					LL.Defence = 2
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.icon_state = LL.EquipState
					LL.Move(src)
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
					LBL.overlays += image(/obj/HUD/E/)
					LBL.Defence = 2
					src.WLeftFoot = LBL
					LBL.icon_state = LBL.EquipState
					LBL.suffix = "Equip"
					LBL.Move(src)
					src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
					var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
					LBR.overlays += image(/obj/HUD/E/)
					LBR.Defence = 2
					src.WRightFoot = LBR
					LBR.suffix = "Equip"
					LBR.icon_state = LBR.EquipState
					LBR.Move(src)
					src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
					var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
					LGL.overlays += image(/obj/HUD/E/)
					LGL.Defence = 2
					src.WLeftHand = LGL
					LGL.suffix = "Equip"
					LGL.icon_state = LGL.EquipState
					LGL.Move(src)
					src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
					var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
					LGR.overlays += image(/obj/HUD/E/)
					LGR.Defence = 2
					src.WRightHand = LGR
					LGR.suffix = "Equip"
					LGR.icon_state = LGR.EquipState
					LGR.Move(src)
					src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
					LGR.suffix = "Equip"
					LGR.overlays += image(/obj/HUD/E/)
					var/obj/Items/Weapons/Daggers/Dagger/D = new
					D.Material = "Iron"
					D.RandomItemQuality()
					D.Move(src)
					D.suffix = "Equip"
					D.overlays += image(/obj/HUD/E)
					D.icon_state = D.EquipState
					src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
					src.Weapon = D
				src.GiveHair("NoBald")
				src.Blood = 85
				src.BloodMax = 85
				src.Faction = "Altherian Empire"
				src.DarkVision = 2
				src.Born = Year

			if(src.Race == "Stahlite")
				if(src.Gender == "Male")
					src.icon = 'dwarf.dmi'
					var/obj/Misc/Beards/StahliteBeard/Z = new
					src.Beard = Z
					src.overlays += src.Beard
				if(src.Gender == "Female")
					src.icon = 'dwarf(F).dmi'
					var/obj/Misc/Hairs/SmallHairFemale/Z = new
					src.Hair = Z
					src.overlays += src.Hair
				src.PregType = "Womb"
				src.loc = locate(11,233,1)
				src.HungerMulti = 1
				src.icon_state = "N"
				src.WeightMax = 110
				src.Strength += 10
				src.DieAge = rand(100,150)
				src.Agility += 4
				src.Endurance += 10
				src.Intelligence += 12.5
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 60
				src.AgilityMax = 40
				src.EnduranceMax = 65
				src.IntelligenceMax = 60
				var/PlayerBorn = 0
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Gender == "Female" && M.Preg == 2)
						if(src.client.address == M.client.address && M != src)
							world << "<font color = teal><b>([src.key])[src] - [src.OrginalName] was booted for Alt Key Interaction involving character creation!<br>"
							del(src)
							return
						PlayerBorn = 1
						src.Strength += M.Strength / 8
						src.Strength += M.FatherStrength
						src.Agility += M.Agility / 8
						src.Agility += M.FatherAgility
						src.Endurance += M.Endurance / 8
						src.Endurance += M.FatherEndurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						M.FatherEndurance = 0
						M.FatherAgility = 0
						M.FatherAgility = 0
						M.Preg = 3
						M.BirthTimer()
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] is born to [M]!<br>"
						break

				src.StrengthMulti = 0.2
				src.AgilityMulti = 0.08
				src.EnduranceMulti = 0.2
				src.IntelligenceMulti = 0.25

				src.SwordSkill += 0
				src.AxeSkill += 10
				src.SpearSkill += 0
				src.BluntSkill += 10
				src.RangedSkill += 8
				src.DaggerSkill += 0
				src.UnarmedSkill += 10
				src.ShieldSkill += 10

				src.SwordSkillMulti = 0.2
				src.AxeSkillMulti = 0.6
				src.SpearSkillMulti = 0.2
				src.BluntSkillMulti = 0.6
				src.RangedSkillMulti = 0.4
				src.DaggerSkillMulti = 0.2
				src.UnarmedSkillMulti = 0.4
				src.ShieldSkillMulti = 0.4
				src.ButcherySkillMulti = 0.6
				src.BoneCraftMulti = 0.4
				if(PlayerBorn == 0)
					var/obj/Items/Armour/Chest/SmallChainShirt/IC = new
					IC.Material = "Iron"
					IC.RandomItemQuality()
					IC.overlays += image(/obj/HUD/E/)
					IC.Defence = 4
					src.WChest = IC
					IC.suffix = "Equip"
					IC.Move(src)
					IC.icon_state = IC.EquipState
					src.overlays+=image(IC.icon,IC.icon_state,IC.ItemLayer)
					var/obj/Items/Armour/Legs/SmallChainLeggings/LL = new
					LL.Material = "Iron"
					LL.RandomItemQuality()
					LL.overlays += image(/obj/HUD/E/)
					LL.Defence = 4
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.Move(src)
					LL.icon_state = LL.EquipState
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					var/obj/Items/Weapons/Axes/PickAxe/A = new
					A.Material = "Iron"
					A.RandomItemQuality()
					A.Move(src)
					A.suffix = "Equip"
					A.overlays += image(/obj/HUD/E/)
					A.icon_state = A.EquipState
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
					src.Weapon = A
				src.CarpentrySkillMulti = 0.4
				src.MiningSkillMulti = 0.4
				src.MasonarySkillMulti = 0.8
				src.SmeltingSkillMulti = 0.8
				src.ForgingSkillMulti = 0.8
				src.WoodCuttingSkillMulti = 0.4
				src.AlchemySkillMulti = 0.2
				src.CookingSkillMulti = 0.8
				src.SkinningSkillMulti = 0.8
				src.LeatherCraftSkillMulti = 0.8
				src.FishingSkillMulti = 0.4
				src.BuildingSkillMulti = 0.8
				src.FarmingSkillMulti = 0.4
				src.WeavingSkillMulti = 0.8
				src.EngravingSkillMulti = 0.8
				src.FirstAidSkillMulti = 0.6
				src.Blood = 105
				src.BloodMax = 105
				src.Faction = "Stahlite Empire"
				src.see_in_dark = 3
				src.DarkVision = 3
				src.CanEatRawMeats = 1
				src.Born = Year

			if(src.Race == "Cyclops")
				src.icon = 'cyclops.dmi'
				src.loc = locate(215,234,1)
				src.PregType = "Womb"
				src.icon_state = "N"
				src.WeightMax = 115
				src.Strength += 11
				src.DieAge = rand(80,110)
				src.MagicPotentcy = rand(0,25)
				src.Agility += 4.5
				src.Endurance += 11
				src.Intelligence += 5
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 65
				src.AgilityMax = 40
				src.EnduranceMax = 65
				src.IntelligenceMax = 30
				var/PlayerBorn = 0
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Gender == "Female" && M.Preg == 2)
						if(src.client.address == M.client.address && M != src)
							world << "<font color = teal><b>([src.key])[src] - [src.OrginalName] was booted for Alt Key Interaction involving character creation!<br>"
							del(src)
							return
						PlayerBorn = 1
						src.Strength += M.Strength / 8
						src.Strength += M.FatherStrength
						src.Agility += M.Agility / 8
						src.Agility += M.FatherAgility
						src.Endurance += M.Endurance / 8
						src.Endurance += M.FatherEndurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						M.FatherEndurance = 0
						M.FatherAgility = 0
						M.FatherAgility = 0
						M.Preg = 3
						M.BirthTimer()
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] is born to [M]!<br>"
						break

				src.StrengthMulti = 0.22
				src.AgilityMulti = 0.09
				src.EnduranceMulti = 0.22
				src.IntelligenceMulti = 0.1

				src.SwordSkill += 0
				src.AxeSkill += 0
				src.SpearSkill += 0
				src.BluntSkill += 10
				src.RangedSkill += 0
				src.DaggerSkill += 0
				src.UnarmedSkill += 10
				src.ShieldSkill += 0

				src.SwordSkillMulti = 0.2
				src.AxeSkillMulti = 0.2
				src.SpearSkillMulti = 0.2
				src.BluntSkillMulti = 0.6
				src.RangedSkillMulti = 0.2
				src.DaggerSkillMulti = 0.2
				src.UnarmedSkillMulti = 0.2
				src.ShieldSkillMulti = 0.2
				if(PlayerBorn == 0)
					var/obj/Items/Armour/UpperBody/GiantLeatherVest/LV = new
					LV.overlays += image(/obj/HUD/E/)
					LV.Defence = 2
					src.WUpperBody = LV
					LV.suffix = "Equip"
					LV.Move(src)
					LV.icon_state = LV.EquipState
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
					var/obj/Items/Armour/Legs/GiantLeatherLeggings/LL = new
					LL.overlays += image(/obj/HUD/E/)
					LL.Defence = 2
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.Move(src)
					LL.icon_state = LL.EquipState
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					var/obj/Items/Weapons/Blunts/Hammer/H = new
					H.Material = "Iron"
					H.RandomItemQuality()
					H.Move(src)
					H.suffix = "Equip"
					H.overlays += image(/obj/HUD/E)
					H.icon_state = H.EquipState
					src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
					src.Weapon = H
				src.CarpentrySkillMulti = 0.6
				src.MiningSkillMulti = 0.4
				src.MasonarySkillMulti = 0.6
				src.SmeltingSkillMulti = 0.6
				src.ForgingSkillMulti = 0.6
				src.WoodCuttingSkillMulti = 0.8
				src.AlchemySkillMulti = 0.4
				src.CookingSkillMulti = 0.6
				src.SkinningSkillMulti = 0.6
				src.LeatherCraftSkillMulti = 0.6
				src.FishingSkillMulti = 0.6
				src.BuildingSkillMulti = 0.6
				src.FarmingSkillMulti = 0.4
				src.WeavingSkillMulti = 0.2
				src.EngravingSkillMulti = 0.2
				src.FirstAidSkillMulti = 0.6
				src.ButcherySkillMulti = 0.8
				src.BoneCraftMulti = 0.4
				src.HungerMulti = 1.5

				src.Blood = 105
				src.BloodMax = 105
				src.Faction = "Cyclops Hordes"
				src.see_in_dark = 3
				src.DarkVision = 3
				src.CanEatRawMeats = 1
				src.Born = Year
				src.GiveHair()

			if(src.Race == "Ratling")
				var/Colour = rand(1,4)
				if(Colour == 1)
					src.icon = 'ratling brown.dmi'
				if(Colour == 2)
					src.icon = 'ratling black.dmi'
				if(Colour == 3)
					src.icon = 'ratling.dmi'
				if(Colour == 4)
					src.icon = 'ratling white.dmi'
				src.loc = locate(27,80,3)
				src.icon_state = "N"
				src.PregType = "Womb"
				src.DieAge = rand(60,80)
				src.MagicPotentcy = rand(0,75)
				src.WeightMax = 85
				src.Strength += 3.5
				src.Agility += 12.5
				src.Endurance += 3.5
				src.Intelligence += 10
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 35
				src.AgilityMax = 75
				src.EnduranceMax = 35
				src.IntelligenceMax = 40
				src.Claws = 100
				var/PlayerBorn = 0
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Gender == "Female" && M.Preg == 2)
						if(src.client.address == M.client.address && M != src)
							world << "<font color = teal><b>([src.key])[src] - [src.OrginalName] was booted for Alt Key Interaction involving character creation!<br>"
							del(src)
							return
						PlayerBorn = 1
						src.Strength += M.Strength / 8
						src.Strength += M.FatherStrength
						src.Agility += M.Agility / 8
						src.Agility += M.FatherAgility
						src.Endurance += M.Endurance / 8
						src.Endurance += M.FatherEndurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						M.FatherEndurance = 0
						M.FatherAgility = 0
						M.FatherAgility = 0
						M.Preg = 3
						M.BirthTimer()
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] is born to [M]!<br>"
						break

				src.StrengthMulti = 0.07
				src.AgilityMulti = 0.25
				src.EnduranceMulti = 0.07
				src.IntelligenceMulti = 0.2

				src.SwordSkill += 4
				src.AxeSkill += 3
				src.SpearSkill += 7
				src.BluntSkill += 3
				src.RangedSkill += 10
				src.DaggerSkill += 10
				src.UnarmedSkill += 7
				src.ShieldSkill += 10

				src.SwordSkillMulti = 0.3
				src.AxeSkillMulti = 0.3
				src.SpearSkillMulti = 0.5
				src.BluntSkillMulti = 0.3
				src.RangedSkillMulti = 0.5
				src.DaggerSkillMulti = 0.6
				src.UnarmedSkillMulti = 0.4
				src.ShieldSkillMulti = 0.4

				src.CarpentrySkillMulti = 0.4
				src.MiningSkillMulti = 0.4
				src.MasonarySkillMulti = 0.8
				src.SmeltingSkillMulti = 0.6
				src.ForgingSkillMulti = 0.6
				src.WoodCuttingSkillMulti = 0.6
				src.AlchemySkillMulti = 0.8
				src.CookingSkillMulti = 0.2
				src.SkinningSkillMulti = 0.6
				src.LeatherCraftSkillMulti = 0.6
				src.FishingSkillMulti = 0.6
				src.BuildingSkillMulti = 0.6
				src.FarmingSkillMulti = 0.2
				src.WeavingSkillMulti = 0.2
				src.EngravingSkillMulti = 0.2
				src.FirstAidSkillMulti = 0.8
				src.ButcherySkillMulti = 0.6
				src.BoneCraftMulti = 1
				src.HungerMulti = 1

				if(PlayerBorn == 0)
					var/obj/Items/Weapons/Daggers/Dagger/D = new
					D.Material = "Iron"
					D.RandomItemQuality()
					D.Move(src)
					src.Weight += D.Weight
					D.suffix = "Equip"
					D.overlays += image(/obj/HUD/E)
					D.icon_state = D.EquipState
					src.overlays+=image(D.icon,D.icon_state,D.ItemLayer)
					src.Weapon = D

					var/obj/Items/Armour/Head/SkullHelmet/H = new
					var/obj/Items/Armour/UpperBody/BoneChestPlate/C = new
					var/obj/Items/Armour/Shoulders/SkullPauldrons/P = new
					var/obj/Items/Armour/LeftArm/BoneLeftGauntlet/LG = new
					var/obj/Items/Armour/RightArm/BoneRightGauntlet/RG = new
					var/obj/Items/Armour/LeftFoot/BoneBootLeft/LB = new
					var/obj/Items/Armour/RightFoot/BoneBootRight/RB = new
					src.CreateList += H
					src.CreateList += C
					src.CreateList += P
					src.CreateList += LG
					src.CreateList += RG
					src.CreateList += LB
					src.CreateList += RB


				src.Blood = 90
				src.BloodMax = 90
				src.see_in_dark = 4
				src.DarkVision = 4
				src.Faction = "Ratling Hordes"
				src.CanEatRawMeats = 2
				src.Born = Year

			if(src.Race == "Frogman")
				src.Noise()
				src.icon = 'frogman.dmi'
				src.DieAge = rand(65,90)
				src.icon_state = "N"
				src.PregType = "Egg"
				src.CanSwimWell = 1
				src.CanRegenLimbs = 1
				src.SwimmingSkill += 25
				src.loc = locate(287,228,1)
				src.MagicPotentcy = rand(0,75)
				src.WeightMax = 100
				src.Strength += 4
				src.Agility += 12.5
				src.Endurance += 4
				src.Intelligence += 7.5
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 45
				src.AgilityMax = 55
				src.EnduranceMax = 40
				src.IntelligenceMax = 45
				var/PlayerBorn = 0
				for(var/mob/NPC/M in Players)
					if(M.Race == src.Race && M.Preg == 2 && src != M)
						PlayerBorn = 1
						src.Strength += M.Strength
						src.Agility += M.Agility
						src.Endurance += M.Endurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] hatches from [M]!<br>"
						del(M)
						break
				src.StrengthMulti = 0.08
				src.AgilityMulti = 0.25
				src.EnduranceMulti = 0.08
				src.IntelligenceMulti = 0.15

				src.SwordSkill += 4
				src.AxeSkill += 4
				src.SpearSkill += 10
				src.BluntSkill += 4
				src.RangedSkill += 10
				src.DaggerSkill += 5
				src.UnarmedSkill += 10
				src.ShieldSkill += 10

				src.SwordSkillMulti = 0.3
				src.AxeSkillMulti = 0.2
				src.SpearSkillMulti = 0.5
				src.BluntSkillMulti = 0.2
				src.RangedSkillMulti = 0.5
				src.DaggerSkillMulti = 0.4
				src.UnarmedSkillMulti = 0.5
				src.ShieldSkillMulti = 0.5

				src.CarpentrySkillMulti = 0.6
				src.MiningSkillMulti = 0.2
				src.MasonarySkillMulti = 0.6
				src.SmeltingSkillMulti = 0.6
				src.ForgingSkillMulti = 0.6
				src.WoodCuttingSkillMulti = 0.8
				src.AlchemySkillMulti = 0.8
				src.CookingSkillMulti = 0.6
				src.SkinningSkillMulti = 0.6
				src.LeatherCraftSkillMulti = 0.6
				src.FishingSkillMulti = 1
				src.BuildingSkillMulti = 0.6
				src.FarmingSkillMulti = 0.4
				src.WeavingSkillMulti = 0.4
				src.EngravingSkillMulti = 0.4
				src.FirstAidSkillMulti = 0.6
				src.ButcherySkillMulti = 0.4
				src.BoneCraftMulti = 0.4
				src.HungerMulti = 1
				if(PlayerBorn == 0)
					var/obj/Items/Armour/UpperBody/LeatherVest/LV = new
					LV.overlays += image(/obj/HUD/E/)
					LV.Defence = 2
					LV.suffix = "Equip"
					LV.icon_state = LV.EquipState
					LV.layer = 20
					LV.Move(src)
					src.WUpperBody = LV
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
					var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
					LL.overlays += image(/obj/HUD/E/)
					LL.Defence = 2
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.icon_state = LL.EquipState
					LL.Move(src)
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
					LBL.overlays += image(/obj/HUD/E/)
					LBL.Defence = 2
					src.WLeftFoot = LBL
					LBL.icon_state = LBL.EquipState
					LBL.suffix = "Equip"
					LBL.Move(src)
					src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
					var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
					LBR.overlays += image(/obj/HUD/E/)
					LBR.Defence = 2
					src.WRightFoot = LBR
					LBR.suffix = "Equip"
					LBR.icon_state = LBR.EquipState
					LBR.Move(src)
					src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
					var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
					LGL.overlays += image(/obj/HUD/E/)
					LGL.Defence = 2
					src.WLeftHand = LGL
					LGL.suffix = "Equip"
					LGL.icon_state = LGL.EquipState
					LGL.Move(src)
					src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
					var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
					LGR.overlays += image(/obj/HUD/E/)
					LGR.Defence = 2
					src.WRightHand = LGR
					LGR.suffix = "Equip"
					LGR.icon_state = LGR.EquipState
					LGR.Move(src)
					src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
					src.Blood = 100
					src.BloodMax = 100
					src.Faction = "Frogmen Hordes"
					var/obj/Items/Weapons/Spears/Spear/S = new
					S.Material = "Iron"
					S.RandomItemQuality()
					S.Move(src)
					S.suffix = "Equip"
					S.overlays += image(/obj/HUD/E)
					S.icon_state = S.EquipState
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.Weapon = S
				src.DarkVision = 2
				src.Born = Year
				src.CanEatRawMeats = 1
				src.CanBreathe = 0

			if(src.Race == "Giant")
				if(src.Gender == "Male")
					src.icon = 'giant.dmi'
				if(src.Gender == "Female")
					src.icon = 'giant(F).dmi'
				src.icon_state = "N"
				src.PregType = "Womb"
				src.DieAge = rand(90,120)
				src.MagicPotentcy = rand(0,30)
				src.loc = locate(28,75,1)
				src.WeightMax = 125
				src.Strength += 12.5
				src.Agility += 3.5
				src.Endurance += 12.5
				src.Intelligence += 5
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 75
				src.AgilityMax = 35
				src.EnduranceMax = 75
				src.IntelligenceMax = 25
				var/PlayerBorn = 0
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Gender == "Female" && M.Preg == 2)
						if(src.client.address == M.client.address && M != src)
							world << "<font color = teal><b>([src.key])[src] - [src.OrginalName] was booted for Alt Key Interaction involving character creation!<br>"
							del(src)
							return
						PlayerBorn = 1
						src.Strength += M.Strength / 8
						src.Strength += M.FatherStrength
						src.Agility += M.Agility / 8
						src.Agility += M.FatherAgility
						src.Endurance += M.Endurance / 8
						src.Endurance += M.FatherEndurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						M.FatherEndurance = 0
						M.FatherAgility = 0
						M.FatherAgility = 0
						M.Preg = 3
						M.BirthTimer()
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] is born to [M]!<br>"
						break

				src.StrengthMulti = 0.25
				src.AgilityMulti = 0.07
				src.EnduranceMulti = 0.25
				src.IntelligenceMulti = 0.1

				src.SwordSkill += 0
				src.AxeSkill += 0
				src.SpearSkill += 0
				src.BluntSkill += 10
				src.RangedSkill += 0
				src.DaggerSkill += 0
				src.UnarmedSkill += 10
				src.ShieldSkill += 0

				src.SwordSkillMulti = 0.2
				src.AxeSkillMulti = 0.2
				src.SpearSkillMulti = 0.2
				src.BluntSkillMulti = 0.6
				src.RangedSkillMulti = 0.2
				src.DaggerSkillMulti = 0.2
				src.UnarmedSkillMulti = 0.5
				src.ShieldSkillMulti = 0.2
				if(PlayerBorn == 0)
					var/obj/Items/Armour/UpperBody/GiantLeatherVest/LV = new
					LV.overlays += image(/obj/HUD/E/)
					LV.Defence = 2
					src.WUpperBody = LV
					LV.suffix = "Equip"
					LV.Move(src)
					LV.icon_state = LV.EquipState
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
					var/obj/Items/Armour/Legs/GiantLeatherLeggings/LL = new
					LL.overlays += image(/obj/HUD/E/)
					LL.Defence = 2
					src.WLegs = LL
					LL.suffix = "Equip"
					LL.Move(src)
					LL.icon_state = LL.EquipState
					src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
					var/obj/Items/Weapons/Blunts/Hammer/H = new
					H.Material = "Iron"
					H.RandomItemQuality()
					H.Move(src)
					H.suffix = "Equip"
					H.overlays += image(/obj/HUD/E)
					H.icon_state = H.EquipState
					src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
					src.Weapon = H
				src.CarpentrySkillMulti = 0.6
				src.MiningSkillMulti = 0.4
				src.MasonarySkillMulti = 0.8
				src.SmeltingSkillMulti = 0.8
				src.ForgingSkillMulti = 0.8
				src.WoodCuttingSkillMulti = 0.8
				src.AlchemySkillMulti = 0.4
				src.CookingSkillMulti = 0.6
				src.SkinningSkillMulti = 0.6
				src.LeatherCraftSkillMulti = 0.6
				src.FishingSkillMulti = 0.6
				src.BuildingSkillMulti = 0.6
				src.FarmingSkillMulti = 0.6
				src.WeavingSkillMulti = 0.4
				src.EngravingSkillMulti = 0.4
				src.FirstAidSkillMulti = 0.4
				src.ButcherySkillMulti = 0.6
				src.BoneCraftMulti = 0.4
				src.HungerMulti = 1.5
				src.Faction = "Giant Hordes"
				src.Blood = 110
				src.BloodMax = 110
				src.DarkVision = 2
				src.Born = Year
				src.GiveHair()

			if(src.Race == "Wolfman")
				var/Colour = rand(1,4)
				if(Colour == 1)
					src.icon = 'wolfman gray.dmi'
				if(Colour == 2)
					src.icon = 'wolfman black.dmi'
				if(Colour == 3)
					src.icon = 'wolfman brown.dmi'
				if(Colour == 4)
					src.icon = 'wolfman white.dmi'
				src.icon_state = "N"
				src.PregType = "Womb"
				src.WeightMax = 150
				src.DieAge = rand(80,120)
				src.MagicPotentcy = rand(0,85)
				src.Strength += 7.5
				src.Agility += 7.5
				src.Endurance += 4
				src.Intelligence += 7.5
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year

				src.StrengthMax = 55
				src.AgilityMax = 55
				src.EnduranceMax = 45
				src.IntelligenceMax = 40

				src.StrengthMulti = 0.15
				src.AgilityMulti = 0.15
				src.EnduranceMulti = 0.08
				src.IntelligenceMulti = 0.15

				src.SwordSkill += 5
				src.AxeSkill += 5
				src.SpearSkill += 5
				src.BluntSkill += 5
				src.RangedSkill += 5
				src.DaggerSkill += 5
				src.UnarmedSkill += 15
				src.ShieldSkill += 5

				src.SwordSkillMulti = 0.1
				src.AxeSkillMulti = 0.1
				src.SpearSkillMulti = 0.2
				src.BluntSkillMulti = 0.1
				src.RangedSkillMulti = 0.1
				src.DaggerSkillMulti = 0.1
				src.UnarmedSkillMulti = 0.5
				src.ShieldSkillMulti = 0.2
				src.CarpentrySkillMulti = 0.2
				src.MiningSkillMulti = 0.2
				src.MasonarySkillMulti = 0.2
				src.SmeltingSkillMulti = 0.2
				src.ForgingSkillMulti = 0.2
				src.WoodCuttingSkillMulti = 0.4
				src.AlchemySkillMulti = 0.4
				src.CookingSkillMulti = 0.2
				src.SkinningSkillMulti = 1
				src.LeatherCraftSkillMulti = 1
				src.FishingSkillMulti = 1
				src.BuildingSkillMulti = 0.4
				src.FarmingSkillMulti = 0.4
				src.WeavingSkillMulti = 0.2
				src.EngravingSkillMulti = 0.2
				src.FirstAidSkillMulti = 1
				src.ButcherySkillMulti = 0.8
				src.BoneCraftMulti = 0.4
				src.HungerMulti = 1.5
				src.Faction = "Dangerous Beasts"
				src.Blood = 120
				src.BloodMax = 120
				src.Born = Year
				src.FindSuitableLocation()
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Gender == "Female" && M.Preg == 2)
						if(src.client.address == M.client.address && M != src)
							world << "<font color = teal><b>([src.key])[src] - [src.OrginalName] was booted for Alt Key Interaction involving character creation!<br>"
							del(src)
							return
						src.Strength += M.Strength / 8
						src.Strength += M.FatherStrength
						src.Agility += M.Agility / 8
						src.Agility += M.FatherAgility
						src.Endurance += M.Endurance / 8
						src.Endurance += M.FatherEndurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						M.FatherEndurance = 0
						M.FatherAgility = 0
						M.FatherAgility = 0
						M.Preg = 3
						M.BirthTimer()
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] is born to [M]!<br>"
						break
				src.see_in_dark = 5
				src.DarkVision = 5
				src.CanEatBodies = 1
				src.CanEatRawMeats = 2
				src.Claws = 100
			if(src.Race == "Snakeman")
				src.icon = 'snakeman.dmi'
				src.icon_state = "N"
				src.PregType = "Egg"
				src.WeightMax = 100
				src.DieAge = rand(75,100)
				src.MagicPotentcy = rand(0,101)
				src.Strength += 8.5
				src.Agility += 11
				src.Endurance += 3.75
				src.Intelligence += 10
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 50
				src.AgilityMax = 60
				src.EnduranceMax = 45
				src.IntelligenceMax = 50
				var/PlayerBorn = 0
				src.loc = locate(232,44,3)
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Preg == 2 && M != src)
						PlayerBorn = 1
						src.Strength += M.Strength
						src.Agility += M.Agility
						src.Endurance += M.Endurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] hatches from [M]!<br>"
						del(M)
						break
				src.StrengthMulti = 0.17
				src.AgilityMulti = 0.22
				src.EnduranceMulti = 0.075
				src.IntelligenceMulti = 0.2

				src.SwordSkill += 10
				src.AxeSkill += 5
				src.SpearSkill += 5
				src.BluntSkill += 5
				src.RangedSkill += 8
				src.DaggerSkill += 5
				src.UnarmedSkill += 8
				src.ShieldSkill += 10

				src.SwordSkillMulti = 0.44
				src.AxeSkillMulti = 0.2
				src.SpearSkillMulti = 0.2
				src.BluntSkillMulti = 0.2
				src.RangedSkillMulti = 0.4
				src.DaggerSkillMulti = 0.2
				src.UnarmedSkillMulti = 0.4
				src.ShieldSkillMulti = 0.44
				if(PlayerBorn == 0)
					var/obj/Items/Armour/UpperBody/LeatherVest/LV = new
					LV.overlays += image(/obj/HUD/E/)
					LV.Defence = 2
					LV.suffix = "Equip"
					LV.icon_state = LV.EquipState
					LV.layer = 20
					LV.Move(src)
					src.WUpperBody = LV
					src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
					var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
					LGL.overlays += image(/obj/HUD/E/)
					LGL.Defence = 2
					src.WLeftHand = LGL
					LGL.suffix = "Equip"
					LGL.icon_state = LGL.EquipState
					LGL.Move(src)
					src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
					var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
					LGR.overlays += image(/obj/HUD/E/)
					LGR.Defence = 2
					src.WRightHand = LGR
					LGR.suffix = "Equip"
					LGR.icon_state = LGR.EquipState
					LGR.Move(src)
					src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
					var/obj/Items/Weapons/Swords/Scimitar/S = new
					S.Material = "Copper"
					S.RandomItemQuality()
					S.Move(src)
					S.suffix = "Equip"
					S.overlays += image(/obj/HUD/E)
					S.icon_state = S.EquipState
					src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
					src.Weapon = S
				src.CarpentrySkillMulti = 1
				src.MiningSkillMulti = 0.2
				src.MasonarySkillMulti = 0.8
				src.SmeltingSkillMulti = 0.8
				src.ForgingSkillMulti = 0.8
				src.WoodCuttingSkillMulti = 1
				src.AlchemySkillMulti = 1
				src.CookingSkillMulti = 1
				src.SkinningSkillMulti = 0.8
				src.LeatherCraftSkillMulti = 0.8
				src.FishingSkillMulti = 0.8
				src.BuildingSkillMulti = 0.8
				src.FarmingSkillMulti = 0.8
				src.WeavingSkillMulti = 0.8
				src.EngravingSkillMulti = 0.6
				src.FirstAidSkillMulti = 0.8
				src.ButcherySkillMulti = 0.6
				src.BoneCraftMulti = 0.4
				src.HungerMulti = 1
				src.Faction = "Snakeman Empire"
				src.Blood = 100
				src.BloodMax = 100
				src.Born = Year
				src.see_in_dark = 5
				src.DarkVision = 5
				src.CanEatBodies = 1
				src.CanEatRawMeats = 2
			if(src.Race == "Human")
				var/Black = 0
				switch(alert("Choose skin color.",,"White","Black"))
					if("Black")
						Black = 1
				var/PlayerBorn = 0
				for(var/mob/M in Players)
					if(M.Race == src.Race && M.Gender == "Female" && M.Preg == 2)
						if(src.client.address == M.client.address && M != src)
							world << "<font color = teal><b>([src.key])[src] - [src.OrginalName] was booted for Alt Key Interaction involving character creation!<br>"
							del(src)
							return
						PlayerBorn = 1
						src.Strength += M.Strength / 8
						src.Strength += M.FatherStrength
						src.Agility += M.Agility / 8
						src.Agility += M.FatherAgility
						src.Endurance += M.Endurance / 8
						src.Endurance += M.FatherEndurance
						src.SkillCap += src.Endurance / 3 + src.Strength / 3 + src.Agility / 3
						src.StrCap = src.Strength + 3
						src.AgilCap = src.Agility + 3
						src.EndCap = src.Endurance + 3

						M.FatherEndurance = 0
						M.FatherAgility = 0
						M.FatherAgility = 0
						M.Preg = 3
						M.BirthTimer()
						src.loc = M.loc
						range(8,src) << "<font color = yellow>[src] is born to [M]!<br>"
						break
				if(Black == 0)
					if(src.Gender == "Male")
						src.icon = 'human.dmi'
					if(src.Gender == "Female")
						src.icon = 'human(F).dmi'
					var/Locs = rand(1,2)
					if(Locs == 1)
						src.loc = locate(28,75,1)
					if(Locs == 2)
						src.loc = locate(176,22,1)
					if(PlayerBorn == 0)
						var/obj/Items/Armour/UpperBody/LeatherVest/LV = new
						LV.overlays += image(/obj/HUD/E/)
						LV.Defence = 2
						LV.suffix = "Equip"
						LV.icon_state = LV.EquipState
						LV.layer = 20
						LV.Move(src)
						src.WUpperBody = LV
						src.overlays+=image(LV.icon,LV.icon_state,LV.ItemLayer)
						var/obj/Items/Armour/Legs/LeatherLeggings/LL = new
						LL.overlays += image(/obj/HUD/E/)
						LL.Defence = 2
						src.WLegs = LL
						LL.suffix = "Equip"
						LL.icon_state = LL.EquipState
						LL.Move(src)
						src.overlays+=image(LL.icon,LL.icon_state,LL.ItemLayer)
						var/obj/Items/Armour/LeftFoot/LeatherBootLeft/LBL = new
						LBL.overlays += image(/obj/HUD/E/)
						LBL.Defence = 2
						src.WLeftFoot = LBL
						LBL.icon_state = LBL.EquipState
						LBL.suffix = "Equip"
						LBL.Move(src)
						src.overlays+=image(LBL.icon,LBL.icon_state,LBL.ItemLayer)
						var/obj/Items/Armour/RightFoot/LeatherBootRight/LBR = new
						LBR.overlays += image(/obj/HUD/E/)
						LBR.Defence = 2
						src.WRightFoot = LBR
						LBR.suffix = "Equip"
						LBR.icon_state = LBR.EquipState
						LBR.Move(src)
						src.overlays+=image(LBR.icon,LBR.icon_state,LBR.ItemLayer)
						var/obj/Items/Armour/LeftArm/LeatherGloveLeft/LGL = new
						LGL.overlays += image(/obj/HUD/E/)
						LGL.Defence = 2
						src.WLeftHand = LGL
						LGL.suffix = "Equip"
						LGL.icon_state = LGL.EquipState
						LGL.Move(src)
						src.overlays+=image(LGL.icon,LGL.icon_state,LGL.ItemLayer)
						var/obj/Items/Armour/RightArm/LeatherGloveRight/LGR = new
						LGR.overlays += image(/obj/HUD/E/)
						LGR.Defence = 2
						src.WRightHand = LGR
						LGR.suffix = "Equip"
						LGR.icon_state = LGR.EquipState
						LGR.Move(src)
						src.overlays+=image(LGR.icon,LGR.icon_state,LGR.ItemLayer)
						var/obj/Items/Weapons/Axes/Hatchet/H = new
						H.Material = "Iron"
						H.RandomItemQuality()
						H.Move(src)
						H.suffix = "Equip"
						H.overlays += image(/obj/HUD/E)
						H.icon_state = H.EquipState
						src.overlays+=image(H.icon,H.icon_state,H.ItemLayer)
						src.Weapon = H
						src.GiveHair()
				if(Black)
					if(src.Gender == "Male")
						src.icon = 'human black.dmi'
					if(src.Gender == "Female")
						src.icon = 'human black(F).dmi'
					src.loc = locate(230,25,1)
					if(PlayerBorn == 0)
						var/obj/Items/Armour/Chest/DesertRobe/R = new
						R.overlays += image(/obj/HUD/E/)
						R.suffix = "Equip"
						R.icon_state = R.EquipState
						R.layer = 20
						R.Move(src)
						src.WChest = R
						src.overlays+=image(R.icon,R.icon_state,R.ItemLayer)
						var/obj/Items/Armour/Head/Turban/T = new
						T.overlays += image(/obj/HUD/E/)
						T.suffix = "Equip"
						T.icon_state = T.EquipState
						T.layer = 20
						T.Move(src)
						src.WHead = T
						src.overlays+=image(T.icon,T.icon_state,T.ItemLayer)
						var/obj/Items/Armour/Legs/ChainLeggings/L = new
						L.Material = "Iron"
						L.RandomItemQuality()
						L.overlays += image(/obj/HUD/E/)
						L.suffix = "Equip"
						L.icon_state = L.EquipState
						L.layer = 20
						L.Move(src)
						src.overlays+=image(L.icon,L.icon_state,L.ItemLayer)
						src.WLegs = L
						var/obj/Items/Weapons/Swords/Scimitar/S = new
						S.Material = "Copper"
						S.RandomItemQuality()
						S.Move(src)
						S.suffix = "Equip"
						S.overlays += image(/obj/HUD/E)
						S.icon_state = S.EquipState
						src.overlays+=image(S.icon,S.icon_state,S.ItemLayer)
						src.Weapon = S
						var/obj/Misc/Hairs/PotHead/Z = new
						src.Hair = Z
				src.icon_state = "N"
				src.PregType = "Womb"
				src.WeightMax = 100
				src.DieAge = rand(65,90)
				src.MagicPotentcy = rand(0,100)
				src.Strength += 5
				src.Agility += 5
				src.Endurance += 5
				src.Intelligence += 10
				src.StrCap = src.StrCap + 36 * Year
				src.EndCap = src.EndCap + 36 * Year
				src.AgilCap = src.AgilCap + 36 * Year
				src.IntCap = src.IntCap + 36 * Year
				src.SkillCap = src.SkillCap + 36 * Year
				src.StrengthMax = 50
				src.AgilityMax = 50
				src.EnduranceMax = 50
				src.IntelligenceMax = 50

				src.StrengthMulti = 0.1
				src.AgilityMulti = 0.1
				src.EnduranceMulti = 0.1
				src.IntelligenceMulti = 0.2

				src.SwordSkill += 10
				src.AxeSkill += 5
				src.SpearSkill += 5
				src.BluntSkill += 5
				src.RangedSkill += 10
				src.DaggerSkill += 5
				src.UnarmedSkill += 5
				src.ShieldSkill += 10

				src.SwordSkillMulti = 0.5
				src.AxeSkillMulti = 0.3
				src.SpearSkillMulti = 0.3
				src.BluntSkillMulti = 0.3
				src.RangedSkillMulti = 0.3
				src.DaggerSkillMulti = 0.3
				src.UnarmedSkillMulti = 0.3
				src.ShieldSkillMulti = 0.4
				src.CarpentrySkillMulti = 1
				src.MiningSkillMulti = 0.2
				src.MasonarySkillMulti = 0.8
				src.SmeltingSkillMulti = 0.8
				src.ForgingSkillMulti = 0.8
				src.WoodCuttingSkillMulti = 1
				src.AlchemySkillMulti = 1
				src.CookingSkillMulti = 1
				src.SkinningSkillMulti = 0.8
				src.LeatherCraftSkillMulti = 0.8
				src.FishingSkillMulti = 0.8
				src.BuildingSkillMulti = 0.8
				src.FarmingSkillMulti = 0.8
				src.WeavingSkillMulti = 0.8
				src.EngravingSkillMulti = 0.6
				src.FirstAidSkillMulti = 0.8
				src.ButcherySkillMulti = 0.6
				src.BoneCraftMulti = 0.2
				src.HungerMulti = 1
				src.Faction = "Human Empire"
				src.Blood = 100
				src.BloodMax = 100
				src.Born = Year
				src.DarkVision = 2
			src.CreateGUI()
			src.DisableAttack = 0
			src.Attack()
			src.BloodFlow()
			src.SleepTick()
			src.HungerTick()
			src.Regen()
			src.Update()
			src.DeadIcon = src.icon
			src.GiveRaceLanguages()
			if(src.Strength >= StrengthMax)
				src.Strength = StrengthMax
			if(src.Agility >= AgilityMax)
				src.Agility = AgilityMax
			if(src.Endurance >= EnduranceMax)
				src.Endurance = EnduranceMax
			if(src.Intelligence >= IntelligenceMax)
				src.Intelligence = IntelligenceMax
			for(var/obj/I in src)
				src.Weight += I.Weight
			for(var/obj/Items/Body/Bod in world)
				if(Bod.Owner == src.name)
					Bod.Owner = null
		DeleteAll()
			for(var/obj/O in src.client.screen)
				del(O)
		ResetSelections()
			for(var/obj/HUD/Text/T in src.client.screen)
				del(T)
			for(var/obj/HUD/RaceSelection/S in src.client.screen)
				if(S.Type != "DontChange")
					S.icon_state = "[S.Type] off"
			src.Gender = null
			src.Race = null
		PickUpObjects()
			for(var/obj/Items/Armour/Chest/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WChest == null && CanUse)
					src.WChest = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/Head/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WHead == null && CanUse)
					src.WHead = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/LeftArm/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WLeftHand == null && src.LeftArm && CanUse)
					src.WLeftHand = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/RightArm/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WRightHand == null && src.RightArm && CanUse)
					src.WRightHand = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/Legs/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WLegs == null && src.RightLeg && src.LeftLeg && CanUse)
					src.WLegs = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/LeftFoot/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WLeftFoot == null && src.LeftLeg && CanUse)
					src.WLeftFoot = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/RightFoot/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WRightFoot == null && src.RightLeg && CanUse)
					src.WRightFoot = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/Shields/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.Weapon2 == null && src.LeftArm && CanUse)
					src.Weapon2 = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = "[A.EquipState] left"
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,"[A.EquipState] left",A.ItemLayer)
			for(var/obj/Items/Armour/Shoulders/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WShoulders == null && CanUse)
					src.WShoulders = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Armour/UpperBody/A in range(0,src))
				var/CanUse = 1
				if(src.Race in A.CantRaces)
					CanUse = 0
				if(src.WUpperBody == null && CanUse)
					src.WUpperBody = A
					A.Move(src)
					A.suffix = "Equip"
					A.icon_state = A.EquipState
					A.layer = A.ItemLayer
					src.overlays+=image(A.icon,A.icon_state,A.ItemLayer)
			for(var/obj/Items/Weapons/W in range(0,src))
				var/CanUse = 1
				if(src.Race in W.CantRaces)
					CanUse = 0
				if(src.Weapon == null && src.RightArm && CanUse)
					src.Weapon = W
					W.Move(src)
					W.suffix = "Equip"
					W.icon_state = W.EquipState
					W.layer = W.ItemLayer
					src.overlays+=image(W.icon,W.icon_state,W.ItemLayer)
		SwitchChild(var/mob/Child)
			src.loc = Child.loc
			src.Hair = Child.Hair
			src.Strength = Child.Strength
			src.Agility = Child.Agility
			src.Endurance = Child.Endurance
			src.luminosity = 0
			src.see_in_dark = src.DarkVision
			src.invisibility  = 0
			src.see_invisible = 0
			src.Fuel = 100
			src.Target = null
			src.CanMove = 1
			src.Dead = 0
			src.BloodMax = Child.BloodMax
			src.Blood = src.BloodMax
			src.Bleed = null
			src.Bleed()
			src.BloodFlow()
			src.CanSleep = 1
			src.CanEat = 1
			src.Pain = 0
			src.CanAttack = 1
			src.density = 1
			src.LeftArm = Child.LeftArm
			src.RightArm = Child.RightArm
			src.Torso = Child.Torso
			src.Head = Child.Head
			src.LeftLeg = Child.LeftLeg
			src.RightLeg = Child.RightLeg
			src.Skull = Child.Skull
			src.Brain = Child.Brain
			src.LeftEye = Child.LeftEye
			src.RightEye = Child.RightEye
			src.LeftEar = Child.LeftEar
			src.RightEar = Child.RightEar
			src.Nose = Child.Nose
			src.Teeth = Child.Teeth
			src.Tongue = Child.Tongue
			src.Throat = Child.Throat
			src.Heart = Child.Heart
			src.LeftLung = Child.LeftLung
			src.RightLung = Child.RightLung
			src.Spleen = Child.Spleen
			src.Intestine = Child.Intestine
			src.LeftKidney = Child.LeftKidney
			src.RightKidney = Child.RightKidney
			src.Liver = Child.Liver
			src.Bladder = Child.Bladder
			src.Stomach = Child.Stomach
			src.Faction = Child.Faction
			src.GoreCheck()
			if(src.client)
				src.Update()
				if(src.CanEat)
					src.HungerTick()
				if(src.CanSleep)
					src.SleepTick()
			if(Child.Hair)
				var/obj/Hir = Child.Hair
				var/icon/I
				I = initial(Hir.icon)
				Hir.icon = I
				src.overlays += Hir
				src.Hair = Hir
			if(Child.Beard)
				var/obj/Brd = Child.Beard
				var/icon/I
				I = initial(Brd.icon)
				Brd.icon = I
				src.overlays += Brd
				src.Beard = Brd
			src.icon = Child.icon
			src.LimbLoss()
		GoodRevive(var/obj/Body)
			src.loc = Body.loc
			src.Hair = Body.Hair
			src.Strength = Body.Strength
			src.Agility = Body.Agility
			src.Endurance = Body.Endurance
			src.luminosity = 0
			src.see_in_dark = src.DarkVision
			src.invisibility  = 0
			src.see_invisible = 0
			src.Fuel = 100
			src.Target = null
			src.CanMove = 1
			src.Dead = 0
			src.BloodMax = Body.BloodMax
			if(src.BloodMax <= 1)
				src.BloodMax = 100
			src.Blood = src.BloodMax
			src.Bleed = null
			src.Bleed()
			src.BloodFlow()
			src.CanSleep = 1
			src.CanEat = 1
			src.Pain = 0
			src.CanAttack = 1
			src.density = 1
			src.LeftArm = Body.LeftArm
			src.RightArm = Body.RightArm
			src.Torso = Body.Torso
			src.Head = Body.Head
			src.LeftLeg = Body.LeftLeg
			src.RightLeg = Body.RightLeg
			src.Skull = Body.Skull
			src.Brain = Body.Brain
			src.LeftEye = Body.LeftEye
			src.RightEye = Body.RightEye
			src.LeftEar = Body.LeftEar
			src.RightEar = Body.RightEar
			src.Nose = Body.Nose
			src.Teeth = Body.Teeth
			src.Tongue = Body.Tongue
			src.Throat = Body.Throat
			src.Heart = Body.Heart
			src.LeftLung = Body.LeftLung
			src.RightLung = Body.RightLung
			src.Spleen = Body.Spleen
			src.Intestine = Body.Intestine
			src.LeftKidney = Body.LeftKidney
			src.RightKidney = Body.RightKidney
			src.Liver = Body.Liver
			src.Bladder = Body.Bladder
			src.Stomach = Body.Stomach
			src.Faction = Body.Faction
			src.GoreCheck()
			if(src.client)
				src.Update()
				if(src.CanEat)
					src.HungerTick()
				if(src.CanSleep)
					src.SleepTick()
			if(Body.Hair)
				var/obj/Hir = Body.Hair
				var/icon/I
				I = initial(Hir.icon)
				Hir.icon = I
				src.overlays += Hir
				src.Hair = Hir
			if(Body.Beard)
				var/obj/Brd = Body.Beard
				var/icon/I
				I = initial(Brd.icon)
				Brd.icon = I
				src.overlays += Brd
				src.Beard = Brd
			src.icon = Body.icon
			src.LimbLoss()
			var/icon/I = new(src.icon)
			I.Turn(270)
			src.icon = I
			if(src.client == null)
				src.CancelDefaultProc = 1
				spawn(50)
					if(src)
						src.CancelDefaultProc = 0
						src.PickUpObjects()
						src.NormalAI()
		EvilRevive(var/obj/Body)
			src.loc = Body.loc
			src.Hair = Body.Hair
			src.Strength = Body.Strength * 1.1
			src.Agility = Body.Agility / 2
			src.Endurance = Body.Endurance * 1.2
			if(Body.Faction != "Undead")
				src.UndeadReset()
			src.luminosity = 0
			src.see_in_dark = 6
			src.invisibility  = 0
			src.see_invisible = 0
			src.CanEatRawMeats = 2
			src.DieAge = 1000
			src.Fuel = 100
			src.Target = null
			src.CanEatBodies = 1
			src.CanMove = 1
			src.BloodMax = 0
			src.Blood = 0
			src.Bleed = null
			src.Bleed()
			src.Dead = 0
			src.CanSleep = 0
			src.CanEat= 1
			src.Pain = 0
			src.CanAttack = 1
			src.density = 1
			src.LeftArm = Body.LeftArm
			src.RightArm = Body.RightArm
			src.Torso = Body.Torso
			src.Head = Body.Head
			src.LeftLeg = Body.LeftLeg
			src.RightLeg = Body.RightLeg
			src.Skull = Body.Skull
			src.Brain = Body.Brain
			src.LeftEye = Body.LeftEye
			src.RightEye = Body.RightEye
			src.LeftEar = Body.LeftEar
			src.RightEar = Body.RightEar
			src.Nose = Body.Nose
			src.Teeth = Body.Teeth
			src.Tongue = Body.Tongue
			src.Throat = Body.Throat
			src.Heart = Body.Heart
			src.LeftLung = Body.LeftLung
			src.RightLung = Body.RightLung
			src.Spleen = Body.Spleen
			src.Intestine = Body.Intestine
			src.LeftKidney = Body.LeftKidney
			src.RightKidney = Body.RightKidney
			src.Liver = Body.Liver
			src.Bladder = Body.Bladder
			src.Stomach = Body.Stomach
			src.SpreadsAffliction = "Undead Bite"
			src.Faction = "Undead"
			src.MoveSpeed = 3
			src.UndeadProc()
			src.GoreCheck()
			if(src.client)
				src.Update()
				if(src.CanEat)
					src.HungerTick()
			if(src.client == null)
				src.CancelDefaultProc = 1
				spawn(50)
					if(src)
						src.CancelDefaultProc = 0
						src.PickUpObjects()
						src.HateList = list("Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
						src.NormalAI()
						src.name = "{NPC} Zombie"
			if(Body.Hair)
				var/obj/Hir = Body.Hair
				var/icon/I
				I = initial(Hir.icon)
				Hir.icon = I
				src.overlays += Hir
				src.Hair = Hir
			if(Body.Beard)
				var/obj/Brd = Body.Beard
				var/icon/I
				I = initial(Brd.icon)
				Brd.icon = I
				src.overlays += Brd
				src.Beard = Brd
			src.icon = Body.icon
			src.LimbLoss()
			var/icon/I = new(src.icon)
			I.Turn(270)
			src.icon = I
			src.icon += rgb(50,50,50)
		FleshBurst()
			spawn(10000)
				if(src)
					view(src) << "<font color=red>[src] begins to bubble and twitch violently as their innards tear open and spew disgusting fluids everywhere, suddenly three new born flesh beasts appear from the mess!<br>"
					var/mob/NPC/Evil/Chaos/Flesh_Beast/B1 = new
					B1.Move(src.loc)
					var/mob/NPC/Evil/Chaos/Flesh_Beast/B2 = new
					B2.Move(src.loc)
					var/mob/NPC/Evil/Chaos/Flesh_Beast/B3 = new
					B3.Move(src.loc)
					src.Death()
					return
		CheckText(var/T)
			var/txt = lowertext(T)
			if(txt == "a")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "e"
				if(Choose == 2)
					txt = "i"
				if(Choose == 3)
					txt = "c"
			if(txt == "b")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "d"
				if(Choose == 2)
					txt = "p"
				if(Choose == 3)
					txt = "dp"
			if(txt == "c")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "ch"
				if(Choose == 2)
					txt = "s"
				if(Choose == 3)
					txt = "sch"
			if(txt == "d")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "ge"
				if(Choose == 2)
					txt = "b"
				if(Choose == 3)
					txt = "ed"
			if(txt == "e")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "a"
				if(Choose == 2)
					txt = "ae"
				if(Choose == 3)
					txt = "ie"
			if(txt == "f")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "es"
				if(Choose == 2)
					txt = "ik"
				if(Choose == 3)
					txt = "as"
			if(txt == "g")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "d"
				if(Choose == 2)
					txt = "e"
				if(Choose == 3)
					txt = "d"
			if(txt == "h")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "f"
				if(Choose == 2)
					txt = "a"
				if(Choose == 3)
					txt = "n"
			if(txt == "i")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "y"
				if(Choose == 2)
					txt = "u"
				if(Choose == 3)
					txt = "ui"
			if(txt == "j")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "ge"
				if(Choose == 2)
					txt = "g"
				if(Choose == 3)
					txt = "i"
			if(txt == "k")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "ch"
				if(Choose == 2)
					txt = "v"
				if(Choose == 3)
					txt = "c"
			if(txt == "l")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "io"
				if(Choose == 2)
					txt = "ul"
				if(Choose == 3)
					txt = "j"
			if(txt == "m")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "n"
				if(Choose == 2)
					txt = "h"
				if(Choose == 3)
					txt = "hm"
			if(txt == "n")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "h"
				if(Choose == 2)
					txt = "m"
				if(Choose == 3)
					txt = "un"
			if(txt == "o")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "u"
				if(Choose == 2)
					txt = "os"
				if(Choose == 3)
					txt = "es"
			if(txt == "p")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "d"
				if(Choose == 2)
					txt = "b"
				if(Choose == 3)
					txt = "pe"
			if(txt == "q")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "e"
				if(Choose == 2)
					txt = "i"
				if(Choose == 3)
					txt = "c"
			if(txt == "r")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "er"
				if(Choose == 2)
					txt = "ar"
				if(Choose == 3)
					txt = "b"
			if(txt == "s")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "sh"
				if(Choose == 2)
					txt = "ch"
				if(Choose == 3)
					txt = "es"
			if(txt == "t")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "ew"
				if(Choose == 2)
					txt = "u"
				if(Choose == 3)
					txt = "te"
			if(txt == "u")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "o"
				if(Choose == 2)
					txt = "ew"
				if(Choose == 3)
					txt = "y"
			if(txt == "v")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "we"
				if(Choose == 2)
					txt = "a"
				if(Choose == 3)
					txt = "m"
			if(txt == "w")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "m"
				if(Choose == 2)
					txt = "we"
				if(Choose == 3)
					txt = "h"
			if(txt == "x")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "s"
				if(Choose == 2)
					txt = "es"
				if(Choose == 3)
					txt = "xs"
			if(txt == "y")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "i"
				if(Choose == 2)
					txt = "ir"
				if(Choose == 3)
					txt = "u"
			if(txt == "z")
				var/Choose = rand(1,3)
				if(Choose == 1)
					txt = "ze"
				if(Choose == 2)
					txt = "ge"
				if(Choose == 3)
					txt = "b"
			src.TextOutput = txt
		GiveName()
			var/Names = list("Belakor","Solvarious","Thulmor","Malar","Volor","Thelioua","Surakor","Morganus","Aroline","Atris","Breagani","Fonoi","Minasso","Niadella","Shaessan","Shasyr","Twisen","Yireve","Dama","Idali","Iorosa","Iusina","Tirarn","Vynnan","Yat","Ostelle","Aibrea","Anibeta","Anodela","Ausya","Delattan","Uanilla","Urris","Zeisor","Emer","Rueleve","Tondara")
			var/HasName1 = 0
			var/HasName2 = 0
			while(HasName1 == 0)
				for(var/N in Names)
					var/Choose = prob(1)
					if(Choose)
						HasName1 = N
			while(HasName2 == 0)
				for(var/N in Names)
					var/Choose = prob(1)
					if(Choose)
						HasName2 = N
			if(HasName1)
				if(HasName2)
					src.name = "{NPC} [HasName1] [HasName2]"
		FleshAI()
			src.LastLoc = src.loc
			if(src.Type >= 6)
				view(src) << "<font color =purple>[src] begins to bubble and swell, blood guts and pus spew everywhere as they expand to a massive size<br>"
				var/mob/NPC/Evil/Chaos/Large_Flesh_Beasts/Large_Flesh_Beast/C = new
				C.Owner = src.Owner
				C.Move(src.loc)
				C.name = src.name
				var/mob/NPC/Evil/Chaos/Large_Flesh_Beasts/Large_Flesh_Beast_BR/F1 = new
				var/mob/NPC/Evil/Chaos/Large_Flesh_Beasts/Large_Flesh_Beast_TL/F2 = new
				var/mob/NPC/Evil/Chaos/Large_Flesh_Beasts/Large_Flesh_Beast_TR/F3 = new
				C.overlays += F1
				C.overlays += F2
				C.overlays += F3
				C.Type = -999999999
				del(src)
				return
			if(src.Target == null)
				for(var/obj/Items/Body/B in oview(src.Vision,src))
					if(B.Owner == null && B.Race != src.Race)
						src.Target = B
			if(src.Target == null)
				for(var/mob/M in oview(src.Vision,src))
					if(M.Dead == 0)
						if(M.Faction != src.Faction)
							if(M.Faction in src.HateList)
								src.Target = M
			if(src.Target)
				if(src.Fainted == 0)
					if(Stunned == 0)
						step_towards(src,src.Target)
						if(ismob(src.Target))
							var/mob/M = src.Target
							var/Dis = get_dist(src,M)
							if(Dis >= 5)
								src.Target = null
							if(M.Dead)
								src.Target = null
						else
							if(src.Target in range(0,src))
								if(isobj(src.Target))
									view(src) << "<font color = red>[src] grasps hold of [src.Target] and begins to absorb it into their disgusting mass of bodies...<br>"
									src.Type += 1
									del(src.Target)
			if(src.Target == null)
				step_rand(src)
			spawn(9) FleshAI()
		ChaosAI()
			if(src.Target == null)
				for(var/obj/Items/Body/B in oview(src.Vision,src))
					if(B.Owner == null && B.Race != src.Race)
						src.Target = B
			if(src.Target == null)
				for(var/mob/M in oview(src.Vision,src))
					if(M.Dead == 0)
						if(M.Faction != src.Faction)
							if(M.Faction in src.HateList)
								src.Target = M
			if(src.Target)
				if(src.Fainted == 0)
					if(Stunned == 0)
						step_towards(src,src.Target)
						if(ismob(src.Target))
							var/mob/M = src.Target
							var/Dis = get_dist(src,M)
							if(Dis >= 5)
								src.Target = null
							if(M.Dead)
								src.Target = null
						else
							if(src.Target in range(0,src))
								if(isobj(src.Target))
									view(src) << "<font color = red>[src] decends upon [src.Target] and begins to smother it, suddenly the body begins to twist and mutate into a digusting bubbling mass of blood and guts!<br>"
									var/mob/NPC/Evil/Chaos/Flesh_Beast/B = new
									B.Move(src.loc)
									del(src.Target)
			if(src.Target == null)
				step_rand(src)
			spawn(9) ChaosAI()
		PlaceWantedPoster(var/mob/Wanted)
			if(src.Race == "Human")
				var/Town = 1
				if(Town == 1)
					for(var/turf/T in block(locate(2,67,1),locate(55,111,1)))
						if(T.icon_state == "bulky brick wall")
							for(var/turf/Floors/F in range(1,T))
								var/CanPlace = 1
								if(F.y == T.y - 1 && F.density == 0)
									for(var/obj/O in T.loc)
										CanPlace = 0
									if(CanPlace)
										var/Place = prob(1)
										if(Place)
											var/obj/Items/Books_Scrolls/WantedPoster/P = new
											P.Move(locate(F.x,F.y,F.z))
											world << "Poster at [P.x],[P.y]"
											return
		CallForHelp(var/mob/T)
			if(src.Faction == "Undead")
				return
			if(src.client)
				return
			if(src.Humanoid && src.Fainted == 0)
				view(src) << "<font color = yellow>[src] calls out for help!<br>"
				for(var/mob/NPC/N in range(8,src))
					var/Helps = 1
					if(N.Faction in src.HateList)
						Helps = 0
					if(Helps)
						if(N.Target == null)
							N.Target = T
		SpiderAI()
			var/N = prob(5)
			if(N)
				view(5) << 'Hiss.wav'
			if(src.Type >= 4)
				var/Lay = prob(2)
				if(Lay)
					view(src) << "<font color =purple>[src] fangs twitch and create a loud pitch noise as [src] lays low to the ground. Suddenly [src] begins to lay a massive egg that flops to the floor!<br>"
					src.Type -= 4
					var/mob/NPC/Evil/Misc/Spider_Egg/C = new
					C.Owner = src.Owner
					C.Move(src.loc)
			if(src.Target == null)
				for(var/obj/Items/Body/B in oview(src.Vision,src))
					if(B.Race != src.Race && B.Owner == null)
						src.Target = B
			if(src.Target == null)
				for(var/mob/M in oview(src.Vision,src))
					if(M.Dead == 0)
						if(M.Faction != src.Faction)
							if(M.Faction in src.HateList)
								src.Target = M
			if(src.Target)
				if(src.Fainted == 0)
					if(Stunned == 0)
						step_towards(src,src.Target)
						if(ismob(src.Target))
							var/mob/M = src.Target
							var/Dis = get_dist(src,M)
							if(Dis >= 5)
								src.Target = null
							if(M.Dead)
								src.Target = null
						else
							if(src.Target in range(0,src))
								if(isobj(src.Target))
									view(src) << "<font color = red>[src] grabs hold of [src.Target] and tears it to shreds, they then begin to eat the remains...<br>"
									src.Type += 1
									del(src.Target)
			if(src.Target == null)
				step_rand(src)
			spawn(9) SpiderAI()
		DevourerAI()
			if(src.Type >= 2)
				view(src) << "<font color =purple>[src] gurgles and splutters violently then spits out a large sack of goo, the sack lands on the ground and begins to harden!<br>"
				src.Type -= 2
				var/mob/NPC/Evil/Undead/Corpse_Devourer_Cacoon/C = new
				C.Owner = src.Owner
				C.Move(src.loc)
			if(src.Target == null)
				for(var/obj/Items/Body/B in oview(src.Vision,src))
					if(B.Owner == null && B.Race != src.Race)
						src.Target = B
			if(src.Target == null)
				for(var/mob/M in oview(src.Vision,src))
					if(M.Dead == 0)
						if(M.Faction != src.Faction)
							if(M.Faction in src.HateList)
								src.Target = M
			if(src.Target)
				if(src.Fainted == 0)
					if(Stunned == 0)
						step_towards(src,src.Target)
						if(ismob(src.Target))
							var/mob/M = src.Target
							var/Dis = get_dist(src,M)
							if(Dis >= 5)
								src.Target = null
							if(M.Dead)
								src.Target = null
						else
							if(src.Target in range(0,src))
								if(isobj(src.Target))
									view(src) << "<font color = red>[src] grabs hold of [src.Target] and tears it to shreds, they then begin to eat the remains...<br>"
									src.Type += 1
									del(src.Target)
			if(src.Target == null)
				step_rand(src)
			spawn(9) DevourerAI()
		SpiderEggHatch()
			spawn(5000)
				if(src)
					view(src) << "<font color = red>[src] begins to stir with life...<br>"
					src.icon_state = "spider egg stir"
					spawn(2500)
						if(src)
							view(src) << "<font color = red>[src] cracks and explodes open!<br>"
							view(src) << 'Hatch.wav'
							if(src)
								src.icon_state = "spider egg hatched"
								src.Dura = 10
								var/num = rand(1,2)
								while(num)
									num -= 1
									var/mob/NPC/Evil/Misc/Baby_Giant_Spider/C = new
									C.Owner = src.Owner
									C.Move(src.loc)
								spawn(1500)
									if(src)
										del(src)
								return
		DevourerCacoonHatch()
			spawn(5000)
				if(src)
					view(src) << "<font color = red>[src] begins to stir with life...<br>"
					src.icon_state = "devourer cacoon stir"
					spawn(5000)
						if(src)
							view(src) << "<font color = red>[src] cracks and explodes open!<br>"
							view(src) << 'Hatch.wav'
							flick("devourer hatch",src)
							spawn(18)
								if(src)
									src.icon_state = "devourer cacoon hatched"
									src.Dura = 10
									var/mob/NPC/Evil/Undead/Corpse_Devourer/C = new
									C.Owner = src.Owner
									C.Move(src.loc)
									spawn(1500)
										if(src)
											del(src)
									return

		BirthTimer()
			if(src.Preg == 3)
				src.PregTimer -= 1
				if(src.PregTimer <= 1)
					src.PregTimer = 0
					src.Preg = 0
					return
				spawn(10) BirthTimer()
		MortallyWounded()
			if(src.Dead)
				return
			if(src.MortalWound)
				if(src.Faction == "Undead")
					return
				var/Rec = prob(2)
				if(Rec)
					return
				var/Die = prob(1)
				if(Die)
					view(src) << "<font color = purple>[src] dies from Mortals Wounds to their Organs!<br>"
					src.Death()
					return
			else
				return
			spawn(50) src.MortallyWounded()
		Heal()
			if(src.Humanoid && src.Dead == 0)
				src.Head = 100
				src.Torso = 100
				src.LeftArm = 100
				src.RightArm = 100
				src.LeftLeg = 100
				src.RightLeg = 100
				src.Skull = 100
				src.Brain = 100
				src.LeftEye = 100
				src.RightEye = 100
				src.LeftEar = 100
				src.RightEar = 100
				src.Teeth = 100
				src.Nose = 100
				src.Tongue = 100
				src.Throat = 100
				src.Heart = 100
				src.LeftLung = 100
				src.RightLung = 100
				src.Spleen = 100
				src.Intestine = 100
				src.LeftKidney = 100
				src.RightKidney = 100
				src.Liver = 100
				src.Bladder = 100
				src.Stomach = 100
				src.CanSee = 1
				src.Pain = 0
				src.MortalWound = 0
				var/HasArms = 0
				if(src.RightArm)
					HasArms = 1
				if(src.LeftArm)
					HasArms = 1
				var/ClawList = list("Wolfman","Illithid","Ratling")
				if(HasArms)
					if(src.Race in ClawList)
						src.Claws = 100
				if(src.BloodMax)
					src.Blood = src.BloodMax
					src.Bleed()
				if(src.Faction != "Undead")
					src.MoveSpeed = 2
				else
					src.MoveSpeed = 3
				src.LimbLoss()
			else
				src.HP = src.HPMAX
		JailTime()
			spawn(5000)
				if(src)
					if(src.Jailed)
						src.loc = locate(28,97,1)
						src << "<font color = green>You have been released from jail!<br>"
						src.Jailed = 0
						src.overlays -= /obj/Misc/Sleeping/
						if(src.Sleeping)
							src.Sleeping = 0
							src.MovementCheck()
		CheckHole(var/obj/H,var/Action)
			if(Action == "Dig")
				for(var/obj/Misc/Hole/H2 in range(1,H))
					if(H != H2)
						if(H2.loc == locate(H.x + 1,H.y,H.z))
							if(H2.icon_state == "hole" && H.icon_state == "hole")
								H.icon_state = "hole left single"
								H2.icon_state = "hole right single"
								return
							if(H2.icon_state == "hole left single")
								H.icon_state = "hole left single"
								H2.icon_state = "hole middle"
								return
							if(H2.icon_state == "hole single top")
								H.icon_state = "hole left single"
								H2.icon_state = "hole top right"
								return
							if(H2.icon_state == "hole single bottom")
								H.icon_state = "hole left single"
								H2.icon_state = "hole bottom right"
								return
						if(H2.loc == locate(H.x - 1,H.y,H.z))
							if(H2.icon_state == "hole" && H.icon_state == "hole")
								H.icon_state = "hole right single"
								H2.icon_state = "hole left single"
								return
							if(H2.icon_state == "hole right single")
								H.icon_state = "hole right single"
								H2.icon_state = "hole middle"
								return
							if(H2.icon_state == "hole single top")
								H.icon_state = "hole right single"
								H2.icon_state = "hole top left"
								return
							if(H2.icon_state == "hole single bottom")
								H.icon_state = "hole right single"
								H2.icon_state = "hole bottom left"
								return
						if(H2.loc == locate(H.x,H.y + 1,H.z))
							if(H2.icon_state == "hole" && H.icon_state == "hole")
								H.icon_state = "hole single bottom"
								H2.icon_state = "hole single top"
								return
							if(H2.icon_state == "hole single bottom")
								H.icon_state = "hole single bottom"
								H2.icon_state = "hole side"
								return
							if(H2.icon_state == "hole right single")
								H.icon_state = "hole single bottom"
								H2.icon_state = "hole top right"
							if(H2.icon_state == "hole left single")
								H.icon_state = "hole single bottom"
								H2.icon_state = "hole top left"
								return
						if(H2.loc == locate(H.x,H.y - 1,H.z))
							if(H2.icon_state == "hole" && H.icon_state == "hole")
								H.icon_state = "hole single top"
								H2.icon_state = "hole single bottom"
								return
							if(H2.icon_state == "hole single top")
								H.icon_state = "hole single top"
								H2.icon_state = "hole side"
								return
							if(H2.icon_state == "hole right single")
								H.icon_state = "hole single top"
								H2.icon_state = "hole bottom right"
								return
							if(H2.icon_state == "hole left single")
								H.icon_state = "hole single top"
								H2.icon_state = "hole bottom left"
								return
			if(Action == "Fill")
				for(var/obj/Misc/Hole/H2 in range(1,H))
					if(H != H2)
						if(H2.loc == locate(H.x + 1,H.y,H.z))
							if(H2.icon_state == "hole right single" && H.icon_state == "hole left single")
								H2.icon_state = "hole"
								return
							if(H.icon_state == "hole left single" && H2.icon_state == "hole middle")
								H2.icon_state = "hole left single"
								return
							if(H2.icon_state == "hole top right" && H.icon_state == "hole left single")
								H2.icon_state = "hole single top"
								return
						if(H2.loc == locate(H.x - 1,H.y,H.z))
							if(H2.icon_state == "hole left single" && H.icon_state == "hole right single")
								H2.icon_state = "hole"
								return
							if(H.icon_state == "hole right single" && H2.icon_state == "hole middle")
								H2.icon_state = "hole right single"
								return
							if(H2.icon_state == "hole top left" && H.icon_state == "hole right single")
								H2.icon_state = "hole single top"
								return
							if(H2.icon_state == "hole bottom left" && H.icon_state == "hole right single")
								H2.icon_state = "hole single bottom"
								return
						if(H2.loc == locate(H.x,H.y + 1,H.z))
							if(H2.icon_state == "hole single top" && H.icon_state == "hole single bottom")
								H2.icon_state = "hole"
								return
							if(H.icon_state == "hole single bottom" && H2.icon_state == "hole side")
								H2.icon_state = "hole single bottom"
								return
							if(H2.icon_state == "hole top right" && H.icon_state == "hole single bottom")
								H2.icon_state = "hole single right"
								return
						if(H2.loc == locate(H.x,H.y - 1,H.z))
							if(H2.icon_state == "hole single bottom" && H.icon_state == "hole single top")
								H2.icon_state = "hole"
								return
							if(H.icon_state == "hole single top" && H2.icon_state == "hole side")
								H2.icon_state = "hole single top"
								return
							if(H2.icon_state == "hole bottom right" && H.icon_state == "hole single top")
								H2.icon_state = "hole right single"
								return
			return
		HitObject()
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
						var/obj/Z = src.WLeftFoot
						Harm -= Z.Defence
					var/Harms = prob(Harm)
					if(Harms)
						src.Blood -= 10
						src.LeftLeg -= 10
						if(src.LeftLeg <= 10)
							src.LeftLeg = 10
						src.AddGore("LeftLeg",src.Race)
						src.Pain += 10
						src.Bleed()
						view(6,src) << "<font color=red>[src]'s Left Leg is hurt!"
				if(src.RightLeg && src.Race != "Snakeman")
					var/Harm = 33
					if(src.WRightFoot)
						var/obj/Z = src.WRightFoot
						Harm -= Z.Defence
					var/Harms = prob(Harm)
					if(Harms)
						src.Blood -= 10
						src.RightLeg -= 10
						if(src.RightLeg <= 10)
							src.RightLeg = 10
						src.AddGore("RightLeg",src.Race)
						src.Pain += 10
						src.Bleed()
						view(6,src) << "<font color=red>[src]'s Right Leg is hurt!"
				if(src.LeftArm)
					var/Harm = 33
					if(src.WLeftHand)
						var/obj/Z = src.WLeftHand
						Harm -= Z.Defence
					var/Harms = prob(Harm)
					if(Harms)
						src.Blood -= 10
						src.LeftArm -= 10
						if(src.LeftArm <= 10)
							src.LeftArm = 10
						src.AddGore("LeftArm",src.Race)
						src.Pain += 10
						src.Bleed()
						view(6,src) << "<font color=red>[src]'s Left Arm is hurt!"
				if(src.RightArm)
					var/Harm = 33
					if(src.WRightHand)
						var/obj/Z = src.WRightHand
						Harm -= Z.Defence
					var/Harms = prob(Harm)
					if(Harms)
						src.Blood -= 10
						src.RightArm -= 10
						if(src.RightArm <= 10)
							src.RightArm = 10
						src.AddGore("RightArm",src.Race)
						src.Pain += 10
						src.Bleed()
						view(6,src) << "<font color=red>[src]'s Right Arm is hurt!"
			else
				var/Harm = prob(33)
				if(Harm)
					view(6,src) << "<font color=red>[src] is hurt by a fall!"
					src.HP -= 20
					src.Blood -= 20
					src.Pain += 20
					src.Bleed()
					if(src.HP <= 0)
						src.Death()
		WallDigAttack(var/turf/T)
			if(src.Function == "Interact")
				if(T.Type == "Solid Wall")
					if(T in range(1,src))
						if(T.density == 0)
							return
						var/CanDig = 0
						var/obj/W = null
						if(src.Weapon)
							W = src.Weapon
							if(W.Type == "PickAxe")
								CanDig = 1
						if(src.Weapon2 && CanDig == 0)
							W = src.Weapon2
							if(W.Type == "PickAxe")
								CanDig = 1
						if(CanDig)
							if(src.Job == null && src.CantDoTask == 0)
								view() << "<font color=yellow>[src] begins to dig away at the solid stone wall!<br>"
								W.Dura -= rand(0.5,1)
								src.Job = "Dig"
								src.CanMove = 0
								var/Time = 150 - src.MiningSkill * 1.5
								if(Time <= 20)
									Time = 20
								spawn(Time)
									if(src)
										if(T in range(1,src))
											if(src.Job == "Dig" && T.density && T.Dura >= 0 && src.CantDoTask == 0)
												src.Job = null
												src.MiningSkill += src.MiningSkillMulti
												src.GainStats(3)
												var/obj/Items/Resources/Stone/S = new
												S.Move(src.loc)
												if(T.OrePath)
													var/obj/O = new T.OrePath()
													O.Move(src.loc)
												view() << "<font color=yellow>A large chunk of stone falls away from the solid stone wall!<br>"
												T.Dura -= 200
												if(T.Dura <= 1)
													T.Dura = 0
													T.icon_state = "stone floor"
													T.Type = "Dark"
													T.density = 0
													Tiles += T
													T.opacity = 0
													T.luminosity = 0
												src.CheckWeaponDura(W)
												if(src.Fainted == 0)
													if(src.Stunned == 0)
														if(src.Sleeping == 0)
															var/Legs = 1
															if(src.RightLeg == 0)
																if(src.LeftLeg == 0)
																	Legs = 0
															if(Legs)
																src.CanMove = 1
			if(src.Function == "Combat")
				if(T in range(1,src))
					if(T.Dura == 0)
						return
					var/CanAttack = 0
					var/obj/W = null
					if(src.Weapon)
						W = src.Weapon
						if(W.suffix == "Equip")
							if(W.ObjectType == "Dagger")
								src << "<font color = red>A dagger wont be able to damage this wall!<br>"
								return
							if(W.Type == "Ranged")
								src << "<font color = red>A bow wont be able to damage this wall!<br>"
								return
							CanAttack = 1
					if(src.Weapon2)
						W = src.Weapon2
						if(W.suffix == "Equip")
							if(W.ObjectType == "Dagger")
								src << "<font color = red>A dagger wont be able to damage this wall!<br>"
								return
							if(W.Type == "Ranged")
								src << "<font color = red>A bow wont be able to damage this wall!<br>"
								return
							CanAttack = 1
					if(CanAttack)
						if(src.Job == null && src.CantDoTask == 0)
							src.DetermineWeaponSkill()
							view() << "<font color=red>[src] begins an attempt at destroying the [T]!<br>"
							src.Job = "Dig"
							src.CanMove = 0
							var/Time = 200 - src.Agility
							if(Time <= 20)
								Time = 20
							spawn(Time)
								if(src)
									if(T in range(1,src))
										if(src.Job == "Dig" && T.Dura >= 0 && src.CantDoTask == 0)
											src.Job = null
											src.GainStats(3)
											W.Dura -= rand(0.5,1)
											if(T.Material == "Stone")
												if(W.DamageType == "Pierce")
													W.Dura -= rand(2,4)
												if(W.DamageType == "Slash")
													W.Dura -= rand(2,4)
											if(T.Material == "Wood")
												W.Dura -= rand(0.5,1)
											W.Dura -= rand(0.1,1)
											src.CheckWeaponDura(W)
											view() << "<font color=red>[src]'s [W] damages the [T].<br>"
											T.Dura -= src.Strength / 2
											T.Dura -= src.CurrentSkillLevel / 4
											T.Dura -= W.Weight / 3
											T.Dura -= W.Quality / 3
											if(T.Dura <= 1)
												src.Log_player("<font color = red><b>([src.key])[src]-[src.x],[src.y],[src.z]-smashes a [T] down.<br>")
												T.Dura = 0
												T.icon_state = "dirt"
												T.name = "Dirt"
												T.Type = "Light"
												T.Material = null
												T.density = 0
												T.Fuel = 0
												Tiles += T
												T.opacity = 0
												if(Night == 0)
													T.luminosity = 1
												if(Night)
													T.luminosity = 0
											src.MovementCheck()
		Regen()
			if(src.Faction == "Undead")
				return
			if(src.Stunned == 0 && src.Dead != 1)
				if(src.Fainted == 0)
					if(src.MortalWound)
						var/Heal = prob(10)
						if(Heal)
							src.MortalWound = 0
					src.Pain -= 1
					src.Fuel += 1
					if(src.Fuel >= 100)
						src.Fuel = 100
					if(src.Pain <= 0)
						src.Pain = 0
					if(src.Humanoid)
						if(src.RightArm)
							src.RightArm += 0.08
							if(src.WoundRightArm)
								var/RemoveWound = prob(0.5)
								if(RemoveWound)
									src.overlays -= src.WoundRightArm
									src.WoundRightArm = null
							if(src.RightArm >= 100)
								src.RightArm = 100
						else if(src.CanRegenLimbs)
							var/Regen = prob(1)
							if(Regen)
								src.RightArm += 0.08
								src.LimbLoss()
								range(6,src) << "<font color = purple>[src]'s Right Arm grows back!<br>"
						if(src.LeftArm)
							src.LeftArm += 0.08
							if(src.WoundLeftArm)
								var/RemoveWound = prob(0.5)
								if(RemoveWound)
									src.overlays -= src.WoundLeftArm
									src.WoundLeftArm = null
							if(src.LeftArm >= 100)
								src.LeftArm = 100
						else if(src.CanRegenLimbs)
							var/Regen = prob(1)
							if(Regen)
								src.LeftArm += 0.08
								src.LimbLoss()
								range(6,src) << "<font color = purple>[src]'s Left Arm grows back!<br>"
						if(src.RightLeg)
							src.RightLeg += 0.08
							if(src.WoundRightLeg)
								var/RemoveWound = prob(0.5)
								if(RemoveWound)
									src.overlays -= src.WoundRightLeg
									src.WoundRightLeg = null
							if(src.RightLeg >= 100)
								src.RightLeg = 100
						else if(src.CanRegenLimbs)
							var/Regen = prob(1)
							if(Regen)
								src.RightLeg += 0.08
								src.LimbLoss()
								range(6,src) << "<font color = purple>[src]'s Right Leg grows back!<br>"
						if(src.LeftLeg)
							src.LeftLeg += 0.08
							if(src.WoundLeftLeg)
								var/RemoveWound = prob(0.5)
								if(RemoveWound)
									src.overlays -= src.WoundLeftLeg
									src.WoundLeftLeg = null
							if(src.LeftLeg >= 100)
								src.LeftLeg = 100
						else if(src.CanRegenLimbs)
							var/Regen = prob(1)
							if(Regen)
								src.LeftLeg += 0.08
								src.LimbLoss()
								range(6,src) << "<font color = purple>[src]'s Left Leg grows back!<br>"
						if(src.LeftEar)
							src.LeftEar += 0.06
							if(src.LeftEar >= 100)
								src.LeftEar = 100
						if(src.RightEar)
							src.RightEar += 0.06
							if(src.RightEar >= 100)
								src.RightEar = 100
						if(src.Nose)
							src.Nose += 0.06
							if(src.Nose >= 100)
								src.Nose = 100
						if(src.Intestine)
							src.Intestine += 0.03
							if(src.Intestine >= 100)
								src.Intestine = 100
						if(src.LeftLung)
							src.LeftLung += 0.03
							if(src.LeftLung >= 100)
								src.LeftLung = 100
						if(src.RightLung)
							src.RightLung += 0.03
							if(src.RightLung >= 100)
								src.RightLung = 100
						if(src.Bladder)
							src.Bladder += 0.06
							if(src.Bladder >= 100)
								src.Bladder = 100
						if(src.Stomach)
							src.Stomach += 0.04
							if(src.Stomach >= 100)
								src.Stomach = 100
						if(src.Spleen)
							src.Spleen += 0.03
							if(src.Spleen >= 100)
								src.Spleen = 100
						if(src.RightKidney)
							src.RightKidney += 0.03
							if(src.RightKidney >= 100)
								src.RightKidney = 100
						if(src.LeftKidney)
							src.LeftKidney += 0.03
							if(src.LeftKidney >= 100)
								src.LeftKidney = 100
						if(src.Brain)
							src.Brain += 0.03
							if(src.Brain >= 100)
								src.Brain = 100
						if(src.Heart)
							src.Heart += 0.03
							if(src.Heart >= 100)
								src.Heart = 100
						if(src.LeftEye)
							src.LeftEye += 0.03
							if(src.LeftEye >= 100)
								src.LeftEye = 100
						if(src.RightEye)
							src.RightEye += 0.03
							if(src.RightEye >= 100)
								src.RightEye = 100
						if(src.Throat)
							src.Throat += 0.06
							if(src.Throat >= 100)
								src.Throat = 100
						if(src.Skull)
							src.Skull += 0.08
							if(src.Skull >= 100)
								src.Skull = 100
						if(src.Liver)
							src.Liver += 0.03
							if(src.Liver >= 100)
								src.Liver = 100
						if(src.Tongue)
							src.Tongue += 0.06
							if(src.Tongue >= 100)
								src.Tongue = 100
						if(src.Teeth)
							src.Teeth += 0.03
							if(src.Teeth >= 100)
								src.Teeth = 100
						var/HasArms = 0
						if(src.RightArm)
							HasArms = 1
						if(src.LeftArm)
							HasArms = 1
						var/ClawList = list("Wolfman","Illithid","Ratling")
						if(HasArms)
							if(src.Race in ClawList)
								src.Claws += 0.1
								if(src.Claws >= 100)
									src.Claws = 100
						if(src.WoundHead)
							var/RemoveWound = prob(0.5)
							if(RemoveWound)
								src.overlays -= src.WoundHead
								src.WoundHead = null
						if(src.WoundTorso)
							var/RemoveWound = prob(0.5)
							if(RemoveWound)
								src.overlays -= src.WoundTorso
								src.WoundTorso = null
					else
						src.HP += 0.8
						if(src.HP >= src.HPMAX)
							src.HP = src.HPMAX
			spawn(25) Regen()
		Sleeping()
			if(src.CanSleep)
				if(src.Sleeping)
					if(src.Job)
						var/Legs = 1
						if(src.LeftLeg == 0)
							if(src.RightLeg == 0)
								Legs = 0
						if(Legs)
							if(src.Fainted == 0)
								if(src.Stunned == 0)
									src.CanMove = 1
						src.overlays -= /obj/Misc/Sleeping/
						src.Sleeping = 0
						return
					src.Sleep += 1
					if(src.Humanoid)
						if(src.RightArm)
							src.RightArm += 0.08
							if(src.RightArm >= 100)
								src.RightArm = 100
						if(src.LeftArm)
							src.LeftArm += 0.08
							if(src.LeftArm >= 100)
								src.LeftArm = 100
						if(src.RightLeg)
							src.RightLeg += 0.08
							if(src.RightLeg >= 100)
								src.RightLeg = 100
						if(src.LeftLeg)
							src.LeftLeg += 0.08
							if(src.LeftLeg >= 100)
								src.LeftLeg = 100
						if(src.LeftEar)
							src.LeftEar += 0.06
							if(src.LeftEar >= 100)
								src.LeftEar = 100
						if(src.RightEar)
							src.RightEar += 0.06
							if(src.RightEar >= 100)
								src.RightEar = 100
						if(src.Nose)
							src.Nose += 0.06
							if(src.Nose >= 100)
								src.Nose = 100
						if(src.Intestine)
							src.Intestine += 0.03
							if(src.Intestine >= 100)
								src.Intestine = 100
						if(src.LeftLung)
							src.LeftLung += 0.03
							if(src.LeftLung >= 100)
								src.LeftLung = 100
						if(src.RightLung)
							src.RightLung += 0.03
							if(src.RightLung >= 100)
								src.RightLung = 100
						if(src.Bladder)
							src.Bladder += 0.06
							if(src.Bladder >= 100)
								src.Bladder = 100
						if(src.Stomach)
							src.Stomach += 0.04
							if(src.Stomach >= 100)
								src.Stomach = 100
						if(src.Spleen)
							src.Spleen += 0.03
							if(src.Spleen >= 100)
								src.Spleen = 100
						if(src.RightKidney)
							src.RightKidney += 0.03
							if(src.RightKidney >= 100)
								src.RightKidney = 100
						if(src.LeftKidney)
							src.LeftKidney += 0.03
							if(src.LeftKidney >= 100)
								src.LeftKidney = 100
						if(src.Brain)
							src.Brain += 0.03
							if(src.Brain >= 100)
								src.Brain = 100
						if(src.Heart)
							src.Heart += 0.03
							if(src.Heart >= 100)
								src.Heart = 100
						if(src.LeftEye)
							src.LeftEye += 0.03
							if(src.LeftEye >= 100)
								src.LeftEye = 100
						if(src.RightEye)
							src.RightEye += 0.03
							if(src.RightEye >= 100)
								src.RightEye = 100
						if(src.Throat)
							src.Throat += 0.06
							if(src.Throat >= 100)
								src.Throat = 100
						if(src.Skull)
							src.Skull += 0.08
							if(src.Skull >= 100)
								src.Skull = 100
						if(src.Liver)
							src.Liver += 0.03
							if(src.Liver >= 100)
								src.Liver = 100
						if(src.Tongue)
							src.Tongue += 0.06
							if(src.Tongue >= 100)
								src.Tongue = 100
						if(src.Teeth)
							src.Teeth += 0.03
							if(src.Teeth >= 100)
								src.Teeth = 100
						var/HasArms = 0
						if(src.RightArm)
							HasArms = 1
						if(src.LeftArm)
							HasArms = 1
						var/ClawList = list("Wolfman","Illithid","Ratling")
						if(HasArms)
							if(src.Race in ClawList)
								src.Claws += 0.1
								if(src.Claws >= 100)
									src.Claws = 100
					if(src.Sleep >= 100)
						src.Sleep = 100
				else
					src.overlays -= /obj/Misc/Sleeping/
					if(src.Fainted)
						src.Sleeping = 0
						return
					if(src.Stunned)
						src.Sleeping = 0
						return
					var/Legs = 1
					if(src.LeftLeg == 0)
						if(src.RightLeg == 0)
							Legs = 0
					if(Legs)
						if(src.Job == null)
							src.CanMove = 1
			spawn(25) Sleeping()
		RemoveOwnedItems()
			for(var/mob/C in view(7,src))
				if(C.Type == "Merchant")
					if(src.Pull)
						if(isobj(src.Pull))
							var/obj/O = src.Pull
							for(var/obj/I in O)
								if(I in C.Selling)
									I.Move(src.loc)
									O.Weight -= I.Weight
									I.suffix = null
									I.overlays-=image(/obj/HUD/C/)
									I.overlays-=image(/obj/HUD/E/)
									I.layer = 4
									if(I.CarryState)
										I.icon_state = I.CarryState
					for(var/obj/I in src)
						if(I in C.Selling)
							I.Move(src.loc)
							src.Weight -= I.Weight
							I.suffix = null
							src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							src.overlays-=image(I.icon,"[I.icon_state]",I.ItemLayer)
							I.overlays-=image(/obj/HUD/C/)
							I.overlays-=image(/obj/HUD/E/)
							I.layer = 4
							if(I.CarryState)
								I.icon_state = I.CarryState
							if(I == src.Weapon)
								src.Weapon = null
							if(I == src.Weapon2)
								src.Weapon2 = null
							if(I == src.WHead)
								src.WHead = null
							if(I == src.WChest)
								src.WChest = null
							if(I == src.WUpperBody)
								src.WUpperBody = null
							if(I == src.WShoulders)
								src.WShoulders = null
							if(I == src.WLeftHand)
								src.WLeftHand = null
							if(I == src.WRightHand)
								src.WRightHand = null
							if(I == src.WLegs)
								src.WLegs = null
							if(I == src.WLeftFoot)
								src.WLeftFoot = null
							if(I == src.WRightFoot)
								src.WRightFoot = null
							if(I == src.WWaist)
								src.WWaist = null
							if(I == src.WBack)
								src.WBack = null
							if(I == src.WExtra)
								src.WExtra = null
		FireRanged(var/turf/T)
			if(src.CanFireRanged)
				if(T in range(1,src))
					return
				var/obj/W = null
				if(src.Weapon)
					W = src.Weapon
					if(W.ObjectType != "Ranged")
						return
				if(src.Weapon2)
					W = src.Weapon2
					if(W.ObjectType != "Ranged")
						return
				if(W == null)
					return
				var/obj/Q
				if(src.WExtra)
					Q = src.WExtra
				if(src.Dead)
					return
				var/Delay = 100
				Delay -= src.RangedSkill / 3
				Delay -= src.Agility
				if(src.Hunger <= 10)
					Delay += 25
				if(src.Sleep <= 10)
					Delay += 25
				if(Delay <= 10)
					Delay = 10
				if(Q && Q.Type == "Quiver" && T)
					var/DIS = get_dist(src,T)
					var/Cant = 0
					if(DIS >= 7)
						Cant = 1
					if(Cant == 0)
						var/obj/A
						for(var/obj/Z in Q)
							A = Z
							break
						if(A)
							src.Weight -= Q.Weight
							Q.Weight -= A.Weight
							src.Weight += Q.Weight
							A.Move(src.loc)
							A.overlays = null
							A.suffix = "Flying"
							A.Target = T
							var/DMG
							DMG += src.RangedSkill / 2
							DMG += src.Strength / 3
							DMG += A.Weight * 2
							DMG += rand(W.Quality / 3,W.Quality / 2)
							A.Type = DMG
							A.Owner = src
							A.RangedMove()
							src.CanFireRanged = 0
							spawn(Delay)
								if(src)
									src.CanFireRanged = 1
							src.CanMove = 0
							spawn(10)
								if(src)
									src.MovementCheck()
			else
				return
		UndeadReset()
			src.AgilityMulti = src.AgilityMulti / 2
			src.StrengthMulti = src.StrengthMulti * 1.5
			src.EnduranceMulti = src.EnduranceMulti * 1.5
			src.SmeltingSkillMulti = 0.05
			src.ForgingSkillMulti = 0.05
			if(src.SmeltingSkill)
				src.SmeltingSkill += src.SmeltingSkill / 2
			if(src.ForgingSkill)
				src.ForgingSkill += src.ForgingSkill / 2
			src.CreateList = null
			src.CreateList = list()
			src << "<font color = red>You forget about all the objects you once knew how to create!<br>"
		UndeadProc()
			if(src.Faction == "Undead" && src.Humanoid && src.Dead == 0)
				var/Twitch = prob(5)
				if(Twitch)
					view(src) << "<font color = yellow>[src]'s body begins to twitch violently for a moment as they drool at the mouth.<br>"
				if(src.Hair)
					var/FallOut = prob(1)
					if(FallOut)
						src.overlays -= src.Hair
						src.overlays -= src.Beard
						view(src) << "<font color = yellow>[src]'s hair begins to fall out!<br>"
			else
				return
			spawn(1200) UndeadProc()
		MakeSkeleton()
			view(src) << "<font color = yellow>[src]'s flesh begins to rot and fall away from their body, leaving behind an empty skeletal frame!<br>"
			src.icon = 'Skeleton.dmi'
			src.Agility = src.Agility * 2
			src.LimbLoss()
			src.Brain = 0
			src.LeftEar = 0
			src.RightEar = 0
			src.Nose = 0
			src.Teeth = 0
			src.Tongue = 0
			src.Throat = 0
			src.Heart = 0
			src.LeftLung = 0
			src.RightLung = 0
			src.Spleen = 0
			src.Intestine = 0
			src.LeftKidney = 0
			src.RightKidney = 0
			src.Liver = 0
			src.Bladder = 0
			src.Stomach = 0
			if(src.Hair)
				src.overlays -= src.Hair
				src.Hair = null
			if(src.Beard)
				src.overlays -= src.Beard
				src.Beard = null
		HungerTick()
			if(src.CanEat)
				src.Hunger -= src.HungerMulti
				if(src.Hunger <= 0)
					src.Hunger = 0
				if(src.Hunger <= 10)
					if(src.EatNotice == 0)
						src << "<font color=red>You feel very hungry!<br>"
						src.EatNotice = 1
						var/Ill = prob(10)
						if(Ill)
							var/AlreadyIll = 0
							if("Ill" in src.Afflictions)
								AlreadyIll = 1
							if(AlreadyIll == 0)
								src.Afflictions += "Ill"
								src.Illness(20)
						if(src.Faction == "Undead")
							var/NoList = list("Giant","Cyclops","Ratling","Stahlite","Snakeman")
							var/CanTurnSkelly = 1
							if(src.Race in NoList)
								CanTurnSkelly =0
							if(CanTurnSkelly)
								src.MakeSkeleton()
							src.Strength = src.Strength / 2
							src.Agility = src.Agility / 2
							src.Endurance = src.Endurance / 2
							src.CanEat = 0
							src << "<font color = purple>[src]'s stomach gurgles and splutters before exspelling itself out of [src]'s mouth in a liquidated form! They seem alot weaker now!<br>"
						spawn(1000)
							if(src)
								src.EatNotice = 0
				if(src.Hunger <= 20)
					if(src.EatNotice == 0)
						src << "<font color=green>You feel rather hungry...<br>"
						src.EatNotice = 1
						spawn(1000)
							if(src)
								src.EatNotice = 0
			else
				return
			spawn(2000) HungerTick()
		SleepTick()
			if(src.CanSleep)
				src.Sleep -= 1
				if(src.Sleep <= 0)
					src.Sleep = 0
				if(src.Sleep <= 10)
					if(src.SleepNotice == 0)
						src << "<font color=red>You feel very tired!<br>"
						src.SleepNotice = 1
						var/Ill = prob(10)
						if(Ill)
							var/AlreadyIll = 0
							if("Ill" in src.Afflictions)
								AlreadyIll = 1
							if(AlreadyIll == 0)
								src.Afflictions += "Ill"
								src.Illness(20)
						spawn(1000)
							if(src)
								src.SleepNotice = 0
				if(src.Sleep <= 20)
					if(src.SleepNotice == 0)
						src << "<font color=green>You feel rather tired...<br>"
						src.SleepNotice = 1
						spawn(1000)
							if(src)
								src.SleepNotice = 0
			else
				return
			spawn(2000) SleepTick()
		WhoProc()
			var/Num = 0
			for(var/mob/M in Players)
				if(M.client)
					var/ShowRace = ""
					var/ShowIP = ""
					if(src.Admin)
						ShowRace = "- [M.Race]"
						ShowIP = "- [M.client.address]"
					src << "([M.key])[M] - [M.OrginalName][ShowRace][ShowIP]"
					Num += 1
			src << "Total - [Num]"
			return
		OOCToggle()
			if(src.OOC)
				src.OOC = 0
				src << "Your OOC is now off!<br>"
				return
			if(src.OOC == 0)
				src.OOC = 1
				src << "Your OOC is now on!<br>"
				return
		ResetButtons()
			if(src)
				if(src.client)
					src.client.mouse_pointer_icon = 'Cursor.dmi'
					for(var/obj/HUD/B in src.client.screen)
						if(B.Type == "Interact")
							if(src.Target && B.icon_state == "int on")
								src << "<b>Target lost!<br>"
								var/mob/m = src.Target
								src.client.images -= m.TargetIcon
								if(m.client)
									if(src.Target in range(6,src))
										view(src) << "<font color = yellow> [src] stands down from combat while facing in [src.Target]'s direction!<br>"
								src.Target = null
							B.icon_state = "int off"
						if(B.Type == "PickUp")
							if(src.Target && B.icon_state == "pick on")
								src << "<b>Target lost!<br>"
								var/mob/m = src.Target
								src.client.images -= m.TargetIcon
								if(m.client)
									if(src.Target in range(6,src))
										view(src) << "<font color = yellow> [src] stands down from combat while facing in [src.Target]'s direction!<br>"
								src.Target = null
							B.icon_state = "pick off"
						if(B.Type == "Examine")
							if(src.Target && B.icon_state == "examine on")
								src << "<b>Target lost!<br>"
								var/mob/m = src.Target
								src.client.images -= m.TargetIcon
								if(m.client)
									if(src.Target in range(6,src))
										view(src) << "<font color = yellow> [src] stands down from combat while facing in [src.Target]'s direction!<br>"
								src.Target = null
							B.icon_state = "examine off"
						if(B.Type == "Pull")
							if(src.Target && B.icon_state == "pull on")
								src << "<b>Target lost!<br>"
								var/mob/m = src.Target
								src.client.images -= m.TargetIcon
								if(m.client)
									if(src.Target in range(6,src))
										view(src) << "<font color = yellow> [src] stands down from combat while facing in [src.Target]'s direction!<br>"
								src.Target = null
							B.icon_state = "pull off"
						if(B.Type == "Equip")
							B.icon_state = "equip button off"
						if(B.Type == "Skill")
							if(B.icon_state == "skills on")
								src.Delete("SkillDisplay","SkillDisplay")
								B.icon_state = "skills off"
						if(B.Type == "Build")
							if(B.icon_state == "build on")
								src.Delete("Building","Building")
								B.icon_state = "build off"
						if(B.Type == "Stats")
							if(B.icon_state == "stats on")
								src.Delete("InfoDisplay","InfoDisplay")
								B.icon_state = "stats off"
						if(B.Type == "Health")
							if(B.icon_state == "health on")
								src.Delete("HealthDisplay","HealthDisplay")
								B.icon_state = "health off"
						if(B.Type == "Combat")
							if(B.icon_state == "combat on")
								B.icon_state = "combat off"
			return
		CreateGUI()
			var/obj/HUD/GUI/ScreenOverlay/SO = new
			src.client.screen += SO

			var/obj/HUD/GUI/SW/SW = new
			src.client.screen += SW
			var/obj/HUD/GUI/NW/NW = new
			src.client.screen += NW
			var/obj/HUD/GUI/SE/SE = new
			src.client.screen += SE
			var/obj/HUD/GUI/NE/NE = new
			src.client.screen += NE
			var/obj/HUD/GUI/N/N = new
			src.client.screen += N
			var/obj/HUD/GUI/S/S = new
			src.client.screen += S
			var/obj/HUD/GUI/E/E = new
			src.client.screen += E
			var/obj/HUD/GUI/W/W = new
			src.client.screen += W

			var/obj/HUD/Buttons/Interact/Int = new
			src.client.screen += Int
			var/obj/HUD/Buttons/GameInfo/Help = new
			src.client.screen += Help
			var/obj/HUD/Buttons/PickUp/Pick = new
			src.client.screen += Pick
			var/obj/HUD/Buttons/Examine/Exa = new
			src.client.screen += Exa
			var/obj/HUD/Buttons/Inventory/Inv = new
			src.client.screen += Inv
			var/obj/HUD/Buttons/CombatMode/Com = new
			src.client.screen += Com
			var/obj/HUD/Buttons/Pull/Pul = new
			src.client.screen += Pul
			var/obj/HUD/Buttons/CharacterInfo/Info = new
			src.client.screen += Info
			var/obj/HUD/Buttons/HealthInfo/HInfo = new
			src.client.screen += HInfo
			var/obj/HUD/Buttons/SkillInfo/SInfo = new
			src.client.screen += SInfo
			var/obj/HUD/Buttons/OOC/OOC = new
			src.client.screen += OOC
			var/obj/HUD/Buttons/Say/Say = new
			src.client.screen += Say
			var/obj/HUD/Buttons/Build/B = new
			src.client.screen += B
			var/obj/HUD/Buttons/RolePlay/RP = new
			src.client.screen += RP
			var/obj/HUD/Buttons/LeftHand/Left = new
			src.client.screen += Left
			if(src.CurrentHand == "Left")
				Left.icon_state = "left hand on"
			var/obj/HUD/Buttons/RightHand/Right = new
			src.client.screen += Right
			if(src.CurrentHand == "Right")
				Right.icon_state = "right hand on"

			var/obj/HUD/GUI/BloodBar/BB = new
			src.client.screen += BB

			var/IsAdmin = 0
			for(var/obj/Misc/Admins/Z in Admins)
				if(Z.name == src.key)
					IsAdmin = 1
					src.Admin = Z.Value
			if(IsAdmin == 1)
				var/obj/HUD/AdminButtons/AdminButton/A = new
				src.client.screen += A
			else
				src.Admin = 0
			if(src.Race == "Illithid")
				var/obj/HUD/Buttons/IllithidPowers/IP = new
				src.client.screen += IP
			return
		Pull()
			if(src.Pull)
				var/atom/O = src.Pull
				if(O.suffix)
					src.Pull = null
					return
				if(O.Pull == src)
					if(O.OnFire)
						src.Pull = null
						O.Pull = null
						return
					if(src.Dead)
						src.Pull = null
						return
					if(O.suffix == null)
						if(ismob(O))
							var/mob/M = O
							if(src.Fainted)
								src.Pull = null
								M.Pull = null
								return
							if(M.Fainted == 0)
								src.Pull = null
								M.Pull = null
								return
							M.loc = src.LastLoc
							if(src.InWater == 0)
								M.InWater = 0
								M.overlays -= /obj/Misc/Bubbles/
								M.overlays -= /obj/Misc/Swim/
						if(isobj(O))
							var/obj/I = O
							I.Move(src.LastLoc)
				else
					src.Pull = null
					return
			else
				src.Pull = null
				return
			spawn(1) Pull()
		ElderGodAI()
			var/WillSpeak = prob(15)
			if(WillSpeak)
				for(var/mob/M in view(6,src))
					if(M != src)
						if(M.Race == "Illithid")
							var/Speaks = rand(1,5)
							if(Speaks == 1)
								Speaks = "Enslave the lesser beings of this world [M]..."
							if(Speaks == 2)
								Speaks = "Bring me nurishment..."
							if(Speaks == 3)
								Speaks = "May the star empower us..."
							if(Speaks == 4)
								Speaks = "Bring me brains, [M]!"
							if(Speaks == 5)
								Speaks = "May the void guide us all..."
							src.Speak(Speaks,6)
							break
			for(var/mob/M in view(6,src))
				if(M.Race != "Illithid")
					var/Resist = 0
					Resist = prob(0 + M.Intelligence)
					if(Resist)
						M << "<font color = red>You block [src]'s mental attack!<br>"
					else
						M << "<font color = red>[src] attacks your mind!<br>"
						M.Pain += rand(10,20)
						M.Brain -= rand(5,7)
						M.Brain -= src.Intelligence / 5
						M.CanMove = 0
						if(M.Fainted == 0)
							M.Stunned = 1
							M.Stun()
						if(M.Target == null && M.client == null)
							M.Target = src
						view(6,M) << "<font color=red>[M] has been stunned!<br>"
						var/Critical = prob(5 + src.Intelligence / 3)
						if(Critical)
							M.Brain -= rand(5,7)
							M.Brain -= src.Intelligence / 10
							view(6,M) << "<font color = yellow>[M]'s head becomes ruptured!<br>"
							M.Blood -= rand(15,30)
							M.Bleed()
							M.Splat()
						if(M.Brain <= 1 && M.Humanoid)
							view(6,M) << "<font color = yellow>[M]'s Brain begins to leak through their nose! Slowly they drop down to the ground, dead.<br>"
							M.Brain = 0
							M.Death()
			for(var/obj/Items/Foods/Brain/B in view(3,src))
				if(B.suffix == null)
					view(6,src) << "<font color=yellow>[src] pulls the [B] in and eats it!<br>"
					src.Hunger += 33
					if(src.Hunger >= 100)
						src.Hunger = 100
					del(B)
					break
			spawn(100) ElderGodAI()
		GiveHair(var/Bald)
			if(src.Gender == "Male")
				if(src.Race != "Giant" && src.Race != "Cyclops")
					var/H = rand(1,5)
					if(Bald == "NoBald" && H == 5)
						H = 4
					if(H == 1)
						var/obj/Misc/Hairs/HairLeft/Z = new
						src.Hair = Z
						src.overlays += src.Hair
					if(H == 2)
						var/obj/Misc/Hairs/HairRight/Z = new
						src.Hair = Z
						src.overlays += src.Hair
					if(H == 3)
						var/obj/Misc/Hairs/Middle/Z = new
						src.Hair = Z
						src.overlays += src.Hair
					if(H == 4)
						var/obj/Misc/Hairs/PotHead/Z = new
						src.Hair = Z
						src.overlays += src.Hair
				else
					var/H = rand(1,2)
					if(H == 1)
						var/obj/Misc/Hairs/GiantHairMale/Z = new
						src.Hair = Z
						src.overlays += src.Hair
			if(src.Gender == "Female")
				if(src.Race != "Giant" && src.Race != "Cyclops")
					var/obj/Misc/Hairs/Long/Z = new
					src.Hair = Z
					src.overlays += Z
				else
					var/obj/Misc/Hairs/GiantHairFemale/Z = new
					src.Hair = Z
					src.overlays += src.Hair
		BloodTrail()
			if(src.Fainted == 0 && src.Stunned == 0)
				var/obj/Misc/Gore/BloodTrail/B = new
				B.Move(src.LastLoc)
				B.dir = src.dir
			spawn(9) BloodTrail()
		DeleteInventoryMenu()
			for(var/obj/HUD/Menus/Buildings/O in src.client.screen)
				del(O)
			for(var/obj/HUD/Menus/Inventory/O in src.client.screen)
				del(O)
			for(var/obj/HUD/Text/T in src.client.screen)
				del(T)
			for(var/obj/Items/I in src.client.screen)
				src.client.screen -= I
				I.layer = 4
			return
		CreateAdminMenu()
			var/obj/BG = new/obj/HUD/Menus/Admin/BackGround(src.client)
			var/obj/TM = new/obj/HUD/Menus/Admin/TMiddle(src.client)
			var/obj/T = new/obj/HUD/Menus/Admin/Top(src.client)
			var/obj/TR = new/obj/HUD/Menus/Admin/TR(src.client)
			var/obj/TL = new/obj/HUD/Menus/Admin/TL(src.client)
			var/obj/L = new/obj/HUD/Menus/Admin/Left(src.client)
			var/obj/R = new/obj/HUD/Menus/Admin/Right(src.client)
			var/obj/BR = new/obj/HUD/Menus/Admin/BR(src.client)
			var/obj/BL = new/obj/HUD/Menus/Admin/BL(src.client)
			var/obj/B = new/obj/HUD/Menus/Admin/Bottom(src.client)

			var/obj/Summon = new/obj/HUD/AdminButtons/AdminSummon(src.client)
			var/obj/Teleport = new/obj/HUD/AdminButtons/AdminTeleport(src.client)
			var/obj/Create = new/obj/HUD/AdminButtons/AdminCreate(src.client)
			var/obj/Edit = new/obj/HUD/AdminButtons/AdminEdit(src.client)
			var/obj/Ban = new/obj/HUD/AdminButtons/AdminBan(src.client)
			var/obj/Mute = new/obj/HUD/AdminButtons/AdminMute(src.client)
			var/obj/ChangeDensity = new/obj/HUD/AdminButtons/AdminChangeDensity(src.client)
			var/obj/Invisibility = new/obj/HUD/AdminButtons/AdminInvisibility(src.client)
			var/obj/Reboot = new/obj/HUD/AdminButtons/AdminReboot(src.client)
			var/obj/Prison = new/obj/HUD/AdminButtons/AdminInprison(src.client)
			var/obj/EditStory = new/obj/HUD/AdminButtons/AdminEditStory(src.client)
			var/obj/Reward = new/obj/HUD/AdminButtons/AdminReward(src.client)
			var/obj/Announce = new/obj/HUD/AdminButtons/AdminAnnounce(src.client)
			var/obj/Heal = new/obj/HUD/AdminButtons/AdminHeal(src.client)
			var/obj/ServerOptions = new/obj/HUD/AdminButtons/AdminServerOptions(src.client)
			var/obj/GiveAdmin = new/obj/HUD/AdminButtons/AdminGiveAdmin(src.client)
			BG.screen_loc = "4,4 to 12,12"
			TM.screen_loc = "8,12"
			T.screen_loc = "4,12 to 12,12"
			TL.screen_loc = "4,12"
			TR.screen_loc = "12,12"
			L.screen_loc = "4,4 to 4,12"
			R.screen_loc = "12,12 to 12,4"
			BL.screen_loc = "4,4"
			BR.screen_loc = "12,4"
			B.screen_loc = "4,4 to 12,4"

			Summon.screen_loc = "5,11"
			Teleport.screen_loc = "7,11"
			Create.screen_loc = "9,11"
			Edit.screen_loc = "11,11"
			Ban.screen_loc = "5,9"
			Mute.screen_loc = "7,9"
			ChangeDensity.screen_loc = "9,9"
			if(src.AdminDelete)
				Edit.icon_state = "edit on"
			if(src.AdminEdit)
				Edit.icon_state = "edit on"
			if(src.density == 0)
				ChangeDensity.icon_state = "turn non-dense on"
			if(src.AdminInvis)
				Invisibility.icon_state = "turn invisible on"
			Invisibility.screen_loc = "11,9"
			Reboot.screen_loc = "5,7"
			Prison.screen_loc = "7,7"
			EditStory.screen_loc = "9,7"
			Reward.screen_loc = "11,7"
			Announce.screen_loc = "5,5"
			Heal.screen_loc = "7,5"
			ServerOptions.screen_loc = "9,5"
			GiveAdmin.screen_loc = "11,5"
			src.client.screen += BG
			src.client.screen += TM
			src.client.screen += T
			src.client.screen += TL
			src.client.screen += TR
			src.client.screen += L
			src.client.screen += R
			src.client.screen += BL
			src.client.screen += BR
			src.client.screen += B

			src.client.screen += Summon
			src.client.screen += Teleport
			src.client.screen += Create
			src.client.screen += Edit
			src.client.screen += Ban
			src.client.screen += Mute
			src.client.screen += ChangeDensity
			src.client.screen += Invisibility
			src.client.screen += Reboot
			src.client.screen += Prison
			src.client.screen += EditStory
			src.client.screen += Reward
			src.client.screen += Announce
			src.client.screen += Heal
			src.client.screen += ServerOptions
			src.client.screen += GiveAdmin
		CreateMasonaryMenu(var/obj/Stone)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseMasonary(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Masonary"
			O.Type = "Masonary"
			A.Type = "Masonary"
			B.Type = "Masonary"
			C.Type = "Masonary"
			D.Type = "Masonary"
			E.Type = "Masonary"
			F.Type = "Masonary"
			G.Type = "Masonary"
			src.Text("Masonary",src,4,10,0,10,"--Masonary Menu--")
			var/X = 3
			var/Y = 9
			if(Stone)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Stone.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateCarpentryMenu(var/obj/Wood)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseCarpentry(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Carpentry"
			O.Type = "Carpentry"
			A.Type = "Carpentry"
			B.Type = "Carpentry"
			C.Type = "Carpentry"
			D.Type = "Carpentry"
			E.Type = "Carpentry"
			F.Type = "Carpentry"
			G.Type = "Carpentry"
			src.Text("Carpentry",src,4,10,0,10,"--Carpentry Menu--")
			var/X = 3
			var/Y = 9
			if(Wood)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Wood.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateBoneMenu(var/obj/Bone)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseBone(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Bone"
			O.Type = "Bone"
			A.Type = "Bone"
			B.Type = "Bone"
			C.Type = "Bone"
			D.Type = "Bone"
			E.Type = "Bone"
			F.Type = "Bone"
			G.Type = "Bone"
			src.Text("Bone",src,4,10,0,10,"--Bone Menu--")
			var/X = 3
			var/Y = 9
			if(Bone)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Bone.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateLeatherMenu(var/obj/Leather)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseLeather(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Leather"
			O.Type = "Leather"
			A.Type = "Leather"
			B.Type = "Leather"
			C.Type = "Leather"
			D.Type = "Leather"
			E.Type = "Leather"
			F.Type = "Leather"
			G.Type = "Leather"
			src.Text("Leather",src,4,10,0,10,"--Leather Menu--")
			var/X = 3
			var/Y = 9
			if(Leather)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Leather.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateForgeMenu(var/obj/Ingot)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseForgeing(src.client)
			H.screen_loc = "2,2 to 12,13"
			O.screen_loc = "2,13"
			A.screen_loc = "12,13"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,13 to 12,13"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,13"
			G.screen_loc = "12,2 to 12,13"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Forge"
			O.Type = "Forge"
			A.Type = "Forge"
			B.Type = "Forge"
			C.Type = "Forge"
			D.Type = "Forge"
			E.Type = "Forge"
			F.Type = "Forge"
			G.Type = "Forge"
			src.Text("Forge",src,4,13,0,10,"--Forge Menu--")
			var/X = 3
			var/Y = 12
			if(Ingot)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Ingot.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateBuildMenu()
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)

			var/obj/B1 = new/obj/HUD/Menus/Buildings/BrickWall(src.client)
			var/obj/B2 = new/obj/HUD/Menus/Buildings/LargeBrickWall(src.client)
			var/obj/B3 = new/obj/HUD/Menus/Buildings/StoneSlab(src.client)
			var/obj/B4 = new/obj/HUD/Menus/Buildings/WoodenFloor(src.client)
			var/obj/B5 = new/obj/HUD/Menus/Buildings/WoodenWall(src.client)
			var/obj/B6 = new/obj/HUD/Menus/Buildings/StoneStairs(src.client)
			H.screen_loc = "2,2 to 8,6"
			O.screen_loc = "2,6"
			A.screen_loc = "8,6"
			B.screen_loc = "2,2"
			C.screen_loc = "8,2"
			D.screen_loc = "2,6 to 8,6"
			E.screen_loc = "2,2 to 8,2"
			F.screen_loc = "2,2 to 2,6"
			G.screen_loc = "8,2 to 8,6"

			B1.screen_loc = "3,5"
			B2.screen_loc = "5,5"
			B3.screen_loc = "7,5"
			B4.screen_loc = "3,3"
			B5.screen_loc = "5,3"
			B6.screen_loc = "7,3"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += B1
			src.client.screen += B2
			src.client.screen += B3
			src.client.screen += B4
			src.client.screen += B5
			src.client.screen += B6
			H.Type = "Building"
			O.Type = "Building"
			A.Type = "Building"
			B.Type = "Building"
			C.Type = "Building"
			D.Type = "Building"
			E.Type = "Building"
			F.Type = "Building"
			G.Type = "Building"
			B1.Type = "Building"
			B2.Type = "Building"
			B3.Type = "Building"
			B4.Type = "Building"
			B5.Type = "Building"
			B6.Type = "Building"
			src.Text("Building",src,2,6,55,10,"--Build Menu--")
			return
		CheckContainer(var/obj/Con)
			var/NearCon = 0
			if(Con in range(1,src))
				NearCon = 1
			if(NearCon == 0)
				if(src.Container)
					var/obj/C = src.Container
					if(C.ClosedState)
						C.icon_state = C.ClosedState
						C.overlays = null
						for(var/obj/Items/Misc/Lock/L in C)
							if(L.suffix == "Fitted")
								L.icon_state = "[L.Material] lock fitted chest"
								C.overlays += L
				src.Container = null
				src.DeleteInventoryMenu()
				return
			spawn(10) CheckContainer(Con)
		CheckBook(var/obj/Bk)
			var/NearBook = 0
			if(Bk.loc == src)
				NearBook = 1
			if(NearBook == 0)
				src.UsingBook = null
				src.Delete("Book")
				for(var/obj/Misc/Spells/S in src.client.screen)
					src.client.screen -= S
				for(var/obj/Misc/SpellText/T in src.client.screen)
					src.client.screen -= T
				return
			spawn(10) CheckBook(Bk)
		CreateContainerMenu(var/obj/Con)
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/Slot = new/obj/HUD/Menus/Inventory/Slot(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/T = new/obj/HUD/Menus/Inventory/Transfer(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/Close(src.client)
			H.screen_loc = "10,2 to 14,6"
			Slot.screen_loc = "11,3 to 13,5"
			O.screen_loc = "10,6"
			A.screen_loc = "14,6"
			B.screen_loc = "10,2"
			C.screen_loc = "14,2"
			T.screen_loc = "14,4"
			Cl.screen_loc = "14,3"
			D.screen_loc = "10,6 to 14,6"
			E.screen_loc = "10,2 to 14,2"
			F.screen_loc = "10,2 to 10,6"
			G.screen_loc = "14,2 to 14,6"
			if(src.Function == "Transfer")
				T.icon_state = "trade button on"

			src.client.screen += H
			src.client.screen += Slot
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += T
			src.client.screen += Cl

			src.Text("Container",src,11,6,1,10,"--Container--")
			src.Text("Weight",src,10,2,1,10,"Weight - [Con.Weight]/[Con.WeightMax]")
			src.CheckContainer(Con)
			return
		CreateInventoryMenu()
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/Slot = new/obj/HUD/Menus/Inventory/Slot(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Eat = new/obj/HUD/Menus/Inventory/Eat(src.client)
			var/obj/Equip = new/obj/HUD/Menus/Inventory/Equip(src.client)
			H.screen_loc = "1,8 to 7,15"
			Slot.screen_loc = "2,9 to 6,14"
			O.screen_loc = "1,15"
			A.screen_loc = "7,15"
			B.screen_loc = "1,8"
			C.screen_loc = "7,8"
			D.screen_loc = "2,15 to 6,15"
			E.screen_loc = "2,8 to 6,8"
			F.screen_loc = "1,9 to 1,14"
			G.screen_loc = "7,9 to 7,14"
			Eat.screen_loc = "7,10"
			Equip.screen_loc = "7,9"

			src.client.screen += H
			src.client.screen += Slot
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Eat
			src.client.screen += Equip

			src.Text("Inventory",src,1,15,13,10,"Inventory")
			src.Text("Weight",src,4,15,0,10,"Weight - [src.Weight]/[src.WeightMax]")
			return
		Delete(var/N,var/N2)
			for(var/obj/HUD/H in src.client.screen)
				if(H.Type == N)
					del(H)
			for(var/obj/HUD/Text/T in src.client.screen)
				if(T.Type == N2)
					del(T)
			return
		Book()
			var/obj/M = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/L = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/R = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/LM = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/RM = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/TLL = new/obj/HUD/Menus/Book/FrameTLL(src.client)
			var/obj/TML = new/obj/HUD/Menus/Book/FrameTML(src.client)
			var/obj/TRL = new/obj/HUD/Menus/Book/FrameTRL(src.client)
			var/obj/TLR = new/obj/HUD/Menus/Book/FrameTLR(src.client)
			var/obj/TMR = new/obj/HUD/Menus/Book/FrameTMR(src.client)
			var/obj/TRR = new/obj/HUD/Menus/Book/FrameTRR(src.client)
			var/obj/TTR = new/obj/HUD/Menus/Book/FrameTTR(src.client)
			var/obj/BBR = new/obj/HUD/Menus/Book/FrameBBR(src.client)
			var/obj/BRR = new/obj/HUD/Menus/Book/FrameBRR(src.client)
			var/obj/BMR = new/obj/HUD/Menus/Book/FrameBMR(src.client)
			var/obj/BLR = new/obj/HUD/Menus/Book/FrameBLR(src.client)
			var/obj/BRL = new/obj/HUD/Menus/Book/FrameBRL(src.client)
			var/obj/BML = new/obj/HUD/Menus/Book/FrameBML(src.client)
			var/obj/BLL = new/obj/HUD/Menus/Book/FrameBLL(src.client)
			var/obj/BBL = new/obj/HUD/Menus/Book/FrameBBL(src.client)
			var/obj/TTL = new/obj/HUD/Menus/Book/FrameTTL(src.client)
			M.screen_loc = "8,13 to 11,14"
			L.screen_loc = "8,13 to 8,14"
			R.screen_loc = "11,13 to 11,14"
			RM.screen_loc = "9,13 to 9,14"
			LM.screen_loc = "10,13 to 10,14"
			TLL.screen_loc = "7,15"
			TML.screen_loc = "8,15"
			TRL.screen_loc = "9,15"
			TLR.screen_loc = "10,15"
			TMR.screen_loc = "11,15"
			TRR.screen_loc = "12,15"
			TTR.screen_loc = "12,14"
			BBR.screen_loc = "12,13"
			BRR.screen_loc = "12,12"
			BMR.screen_loc = "11,12"
			BLR.screen_loc = "10,12"
			BRL.screen_loc = "9,12"
			BML.screen_loc = "8,12"
			BLL.screen_loc = "7,12"
			BBL.screen_loc = "7,13"
			TTL.screen_loc = "7,14"
			src.client.screen += M
			src.client.screen += L
			src.client.screen += R
			src.client.screen += LM
			src.client.screen += RM
			src.client.screen += TLL
			src.client.screen += TML
			src.client.screen += TRL
			src.client.screen += TLR
			src.client.screen += TMR
			src.client.screen += TRR
			src.client.screen += TTR
			src.client.screen += BBR
			src.client.screen += BRR
			src.client.screen += BMR
			src.client.screen += BLR
			src.client.screen += BRL
			src.client.screen += BML
			src.client.screen += BLL
			src.client.screen += BBL
			src.client.screen += TTL
			M.Type = "Book"
			L.Type = "Book"
			R.Type = "Book"
			RM.Type = "Book"
			LM.Type = "Book"
			TLL.Type = "Book"
			TML.Type = "Book"
			TRL.Type = "Book"
			TLR.Type = "Book"
			TMR.Type = "Book"
			TRR.Type = "Book"
			TTR.Type = "Book"
			BBR.Type = "Book"
			BRR.Type = "Book"
			BMR.Type = "Book"
			BLR.Type = "Book"
			BRL.Type = "Book"
			BML.Type = "Book"
			BLL.Type = "Book"
			BBL.Type = "Book"
			TTL.Type = "Book"
			if(src.UsingBook)
				src.CheckBook(src.UsingBook)
				var/obj/Book = src.UsingBook
				var/Num = 0
				var/X = 9
				var/Y = 14
				for(var/obj/Misc/Spells/S in Book.BookContents)
					if(Num != 4)
						if(Y != 12)
							Num += 1
							S.screen_loc = "[X],[Y]"
							src.client.screen += S
							var/obj/Misc/SpellText/T = new
							T.icon_state = "[S.icon_state] text"
							T.screen_loc = "[X - 1],[Y]"
							src.client.screen += T
							Y -= 1
						else
							Y = 14
							X = 11
							Num += 1
							S.screen_loc = "[X],[Y]"
							src.client.screen += S
							var/obj/Misc/SpellText/T = new
							T.icon_state = "[S.icon_state] text"
							T.screen_loc = "[X - 1],[Y]"
							src.client.screen += T
							Y -= 1
					else
						Book.FuturePages += S
		Box()
			var/obj/H = new/obj/HUD/Menus/Box(src.client)
			var/NameX = src.MouseLocationX + 1
			var/NameY = src.MouseLocationY - 1
			var/PurityX = src.MouseLocationX + 1
			var/PurityY = src.MouseLocationY - 3
			var/WeightLocX = src.MouseLocationX + 1
			var/WeightLocY = src.MouseLocationY - 2
			var/SlotLocX = src.MouseLocationX + 1
			var/SlotLocY = src.MouseLocationY - 3
			var/DuraLocX = src.MouseLocationX + 1
			var/DuraLocY = src.MouseLocationY - 4
			var/LocationX = src.MouseLocationX + 1
			var/LocationY = src.MouseLocationY - 1
			var/MiddleX = src.MouseLocationX + 5
			var/MiddleY = src.MouseLocationY - 5
			H.screen_loc = "[LocationX],[LocationY] to [MiddleX],[MiddleY]"
			H.Type = "ScrollMiddle"
			src.client.screen += H
			for(var/obj/Items/I in src)
				if(I.Xloc == src.MouseLocationX)
					if(I.Yloc == src.MouseLocationY)
						src.Text("BoxDelete",src,NameX,NameY,8,13,"[I.name]")
						src.Text("BoxDelete",src,WeightLocX,WeightLocY,8,13,"Weight-[I.Weight]")
						if(I.CraftPotential)
							src.Text("BoxDelete",src,PurityX,PurityY,8,13,"Potential-[I.CraftPotential]")
						if(I.Defence)
							src.Text("BoxDelete",src,SlotLocX,SlotLocY,8,13,"Defence-[I.Defence]")
						if(I.Quality)
							var/DMG = I.Quality
							src.Text("BoxDelete",src,SlotLocX,SlotLocY,8,13,"Damage-[DMG]")
						if(I.Dura)
							src.Text("BoxDelete",src,DuraLocX,DuraLocY,8,13,"Durability-[I.Dura]")
			return
		CreateContainerContents(var/obj/Con)
			src.CreateContainerMenu(Con)
			var/count = 0
			var/x = 11
			var/y = 5
			for(var/obj/Items/O in Con.contents)
				if(O && O.suffix != "Fitted")
					if(y >= 3)
						if(count < 3)
							count++
							O.layer = 20
							src.client.screen += O
							O.screen_loc = "[x],[y]"
							O.Xloc = x
							O.Yloc = y
							x++
						else
							count = 0
							count++
							y -= 1
							x = 11
							if(y >= 3)
								O.layer = 20
								src.client.screen += O
								O.screen_loc = "[x],[y]"
								O.Xloc = x
								O.Yloc = y
								x++
			return
		CreateInventory()
			for(var/obj/HUD/Menus/H in src.client.screen)
				if(H.Type != "Book")
					del(H)
			src.CreateInventoryMenu()
			var/count = 0
			var/x = 2
			var/y = 14
			for(var/obj/O in src.contents)
				if(O)
					if(y >= 9)
						if(count < 5)
							count++
							O.layer = 20
							O.screen_loc = "[x],[y]"
							src.client.screen += O
							O.Xloc = x
							O.Yloc = y
							x++
						else
							count = 0
							count++
							y -= 1
							x = 2
							if(y >= 9)
								O.layer = 20
								src.client.screen += O
								O.screen_loc = "[x],[y]"
								O.Xloc = x
								O.Yloc = y
								x++
			return
		AITalk(var/T,var/mob/Speaker)
			var/Facing = 0
			if(Speaker.loc == locate(src.x,src.y-1,src.z) && src.dir == SOUTH)
				Facing = 1
			if(Speaker.loc == locate(src.x,src.y+1,src.z) && src.dir == NORTH)
				Facing = 1
			if(Speaker.loc == locate(src.x+1,src.y,src.z) && src.dir == EAST)
				Facing = 1
			if(Speaker.loc == locate(src.x-1,src.y,src.z) && src.dir == WEST)
				Facing = 1
			if(Facing && T)
				var/Knows = null
				for(var/obj/Misc/Contact/C in src.KnowList)
					if(C.name == Speaker.name)
						Knows = C
				var/Type = null
				var/L = lowertext(T)
				var/Message = null
				if(findtext(L,"i am [Speaker.name]",1,0))
					Type = "Intro"
				if(findtext(L,"my names [Speaker.name]",1,0))
					Type = "Intro"
				if(findtext(L,"[Speaker.name] is my name",1,0))
					Type = "Intro"
				if(findtext(L,"i'm [Speaker.name]",1,0))
					Type = "Intro"
				if(findtext(L,"i am called [Speaker.name]",1,0))
					Type = "Intro"
				if(findtext(L,"names [Speaker.name]",1,0))
					Type = "Intro"
				if(findtext(L,"hello",1,0))
					Type = "Greeting"
				if(findtext(L,"hi",1,0))
					Type = "Greeting"
				if(findtext(L,"hey",1,0))
					Type = "Greeting"
				if(findtext(L,"who are you",1,0))
					Type = "Question - Identity"
				if(findtext(L,"whats your name",1,0))
					Type = "Question - Identity"
				if(findtext(L,"who are you",1,0))
					Type = "Question - Identity"
				if(findtext(L,"your history",1,0))
					Type = "Question - History"
				if(findtext(L,"about yourself",1,0))
					Type = "Question - History"
				if(findtext(L,"of yourself",1,0))
					Type = "Question - History"
				if(findtext(L,"know about you",1,0))
					Type = "Question - History"
				if(findtext(L,"know your history",1,0))
					Type = "Question - History"
				if(findtext(L,"me about you",1,0))
					Type = "Question - History"
				if(Type == "Intro")
					var/AskedForName = 0
					if(src.FollowUp == "Asking Name - Hello")
						AskedForName = 1
					if(src.FollowUp == "Asking Name - History")
						AskedForName = 1
					if(AskedForName)
						Message = "<font color = teal>[src] says: Its nice to meet you [Speaker]!<br>"
						var/obj/Misc/Contact/C = new
						C.name = Speaker.name
						C.Standing += 1
						src.KnowList += C
						if(src.FollowUp == "Asking Name")
							src.FollowUp = null
					if(Knows && Message == null)
						Message = "<font color = teal>[src] says: I know your name already [Speaker]<br>"
						src.SpeakingWith = Speaker
					if(Knows == null && Message == null)
						Message = "<font color = teal>[src] says: [Speaker.name]? Very well. I am [src]<br>"
						src.SpeakingWith = Speaker
						var/obj/Misc/Contact/C = new
						C.name = Speaker.name
						C.Standing += 1
						src.KnowList += C
						if(src.FollowUp == "Asking Name")
							src.FollowUp = null
				if(Type == "Question - History")
					if(src.FollowUp == "Asking Name")
						Message = "<font color = teal>[src] says: Yes yes, You have already asked about my history, now what is your name?<br>"
					if(Speaker.name in src.KnowList)
						Knows = Speaker.name
					if(Knows && Message == null)
						Message = "<font color = teal>[src] says: Well, I'm part of the [src.Faction].<br>"
						src.SpeakingWith = Speaker
					if(Knows == null && Message == null)
						Message = "<font color = teal>[src] says:First tell me your name, then maybe we can discuss such things.<br>"
						src.SpeakingWith = Speaker
						src.FollowUp = "Asking Name"
				if(Type == "Question - Identity")
					if(Knows && Message == null)
						Message = "<font color = teal>[src] says: Why do you ask my name [Speaker] when I,ve already told you it!<br>"
						src.SpeakingWith = Speaker
					if(Knows == null && Message == null)
						Message = "<font color = teal>[src] says:Whats your name first?<br>"
						src.SpeakingWith = Speaker
						src.FollowUp = "Asking Name"
				if(Type == "Greeting")
					if(src.FollowUp == "Asking Name")
						Message = "<font color = teal>[src] says: I asked for your name.<br>"
					if(Knows && Message == null)
						Message = "<font color = teal>[src] says: Hello [Knows]...<br>"
						src.SpeakingWith = Speaker
					if(Knows == null && Message == null)
						Message = "<font color = teal>[src] says: Hello...<br>"
						src.SpeakingWith = Speaker
				if(Message)
					view() << "[Message]"
		LearnRaceLanguages(var/Lang)
			src << "<font color = purple>You hear the basics of [Lang] and begin to understand it!<br>"
			if(Lang == "Common")
				var/obj/Misc/Languages/Common/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Demonic")
				var/obj/Misc/Languages/Demonic/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Ancient")
				var/obj/Misc/Languages/Ancient/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "DarkTongue")
				var/obj/Misc/Languages/DarkTongue/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Human")
				var/obj/Misc/Languages/Human/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Altherian")
				var/obj/Misc/Languages/Altherian/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Stahliteian")
				var/obj/Misc/Languages/Stahliteian/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Slithus")
				var/obj/Misc/Languages/Slithus/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Wolfen")
				var/obj/Misc/Languages/Wolfen/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Scutter")
				var/obj/Misc/Languages/Scutter/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
			if(Lang == "Ribbitus")
				var/obj/Misc/Languages/Ribbitus/L = new
				L.SpeakPercent = 1
				src.LangKnow += L
		GiveRaceLanguages()
			if(src.Race == "Cyclops")
				var/obj/Misc/Languages/Human/L = new
				L.SpeakPercent = 100
				L.WritePercent = 15
				src.CurrentLanguage = L
				src.LangKnow += L

			if(src.Race == "Giant")
				var/obj/Misc/Languages/Human/L = new
				L.SpeakPercent = 100
				L.WritePercent = 10
				src.CurrentLanguage = L
				src.LangKnow += L

			if(src.Race == "Human")
				var/obj/Misc/Languages/Human/L = new
				L.SpeakPercent = 100
				L.WritePercent = 100
				src.CurrentLanguage = L
				src.LangKnow += L

				var/obj/Misc/Languages/Altherian/L2 = new
				L2.SpeakPercent = 85
				L2.WritePercent = 50
				src.LangKnow += L2

				var/obj/Misc/Languages/Stahliteian/L3 = new
				L3.SpeakPercent = 85
				L3.WritePercent = 50
				src.LangKnow += L3

				var/obj/Misc/Languages/Slithus/L4 = new
				L4.SpeakPercent = 50
				L4.WritePercent = 25
				src.LangKnow += L4

				var/obj/Misc/Languages/Common/C = new
				C.SpeakPercent = 97
				C.WritePercent = 97
				src.CurrentLanguage = C
				src.LangKnow += C
			if(src.Race == "Alther")
				var/obj/Misc/Languages/Altherian/L = new
				L.SpeakPercent = 100
				L.WritePercent = 100
				src.CurrentLanguage = L
				src.LangKnow += L

				var/obj/Misc/Languages/Human/L2 = new
				L2.SpeakPercent = 85
				L2.WritePercent = 85
				src.LangKnow += L2

				var/obj/Misc/Languages/Stahliteian/L3 = new
				L3.SpeakPercent = 85
				L3.WritePercent = 85
				src.LangKnow += L3

				var/obj/Misc/Languages/Slithus/L4 = new
				L4.SpeakPercent = 50
				L4.WritePercent = 50
				src.LangKnow += L4

				var/obj/Misc/Languages/Common/C = new
				C.SpeakPercent = 97
				C.WritePercent = 97
				src.CurrentLanguage = C
				src.LangKnow += C

				var/obj/Misc/Languages/Ancient/A = new
				A.SpeakPercent = 50
				A.WritePercent = 33
				src.CurrentLanguage = A
				src.LangKnow += A
			if(src.Race == "Stahlite")
				var/obj/Misc/Languages/Stahliteian/L = new
				L.SpeakPercent = 100
				L.WritePercent = 100
				src.CurrentLanguage = L
				src.LangKnow += L

				var/obj/Misc/Languages/Human/L2 = new
				L2.SpeakPercent = 85
				L2.WritePercent = 85
				src.LangKnow += L2

				var/obj/Misc/Languages/Altherian/L3 = new
				L3.SpeakPercent = 85
				L3.WritePercent = 50
				src.LangKnow += L3

				var/obj/Misc/Languages/Slithus/L4 = new
				L4.SpeakPercent = 50
				L4.WritePercent = 33
				src.LangKnow += L4

				var/obj/Misc/Languages/Common/C = new
				C.SpeakPercent = 97
				C.WritePercent = 97
				src.CurrentLanguage = C
				src.LangKnow += C

				var/obj/Misc/Languages/Ancient/A = new
				A.SpeakPercent = 50
				A.WritePercent = 33
				src.CurrentLanguage = A
				src.LangKnow += A
			if(src.Race == "Snakeman")
				var/obj/Misc/Languages/Slithus/L = new
				L.SpeakPercent = 100
				L.WritePercent = 100
				src.CurrentLanguage = L
				src.LangKnow += L

				var/obj/Misc/Languages/Stahliteian/L2 = new
				L2.SpeakPercent = 50
				L2.WritePercent = 25
				src.LangKnow += L2

				var/obj/Misc/Languages/Human/L3 = new
				L3.SpeakPercent = 50
				L3.WritePercent = 25
				src.LangKnow += L3

				var/obj/Misc/Languages/Altherian/L4 = new
				L4.SpeakPercent = 50
				L4.WritePercent = 25
				src.LangKnow += L4

				var/obj/Misc/Languages/Common/C = new
				C.SpeakPercent = 97
				C.WritePercent = 97
				src.CurrentLanguage = C
				src.LangKnow += C

				var/obj/Misc/Languages/Ancient/A = new
				A.SpeakPercent = 40
				A.WritePercent = 20
				src.CurrentLanguage = A
				src.LangKnow += A
			if(src.Race == "Ratling")
				var/obj/Misc/Languages/Scutter/L = new
				L.SpeakPercent = 100
				L.WritePercent = 100
				src.CurrentLanguage = L
				src.LangKnow += L
			if(src.Race == "Illithid")
				var/obj/Misc/Languages/Slithus/L = new
				L.SpeakPercent = 50
				L.WritePercent = 50
				src.CurrentLanguage = L
				src.LangKnow += L

				var/obj/Misc/Languages/Ribbitus/L2 = new
				L2.SpeakPercent = 97
				L2.WritePercent = 50
				src.CurrentLanguage = L2
				src.LangKnow += L2

				var/obj/Misc/Languages/Ancient/L3 = new
				L3.SpeakPercent = 100
				L3.WritePercent = 100
				src.LangKnow += L3

				var/obj/Misc/Languages/Common/C = new
				C.SpeakPercent = 75
				C.WritePercent = 50
				src.CurrentLanguage = C
				src.LangKnow += C
			if(src.Race == "Frogman")
				var/obj/Misc/Languages/Ribbitus/L = new
				L.SpeakPercent = 100
				L.WritePercent = 100
				src.CurrentLanguage = L
				src.LangKnow += L

				var/obj/Misc/Languages/Human/L2 = new
				L2.SpeakPercent = 85
				L2.WritePercent = 50
				src.LangKnow += L2

				var/obj/Misc/Languages/Common/C = new
				C.SpeakPercent = 97
				C.WritePercent = 97
				src.CurrentLanguage = C
				src.LangKnow += C
			if(src.Race == "Wolfman")
				var/obj/Misc/Languages/Wolfen/L = new
				L.SpeakPercent = 100
				L.WritePercent = 100
				src.CurrentLanguage = L
				src.LangKnow += L

		CreateRaceSelection()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)

			var/obj/Human = new/obj/HUD/RaceSelection/Human(src.client)
			var/obj/Wolfman = new/obj/HUD/RaceSelection/Wolfman(src.client)
			var/obj/Alther = new/obj/HUD/RaceSelection/Alther(src.client)
			var/obj/Cyclops = new/obj/HUD/RaceSelection/Cyclops(src.client)
			var/obj/Frogman = new/obj/HUD/RaceSelection/Frogman(src.client)
			var/obj/Giant = new/obj/HUD/RaceSelection/Giant(src.client)
			var/obj/Ratling = new/obj/HUD/RaceSelection/Ratling(src.client)
			var/obj/Stahlite = new/obj/HUD/RaceSelection/Stahlite(src.client)
			var/obj/Snakeman = new/obj/HUD/RaceSelection/Snakeman(src.client)

			var/obj/Cancel = new/obj/HUD/RaceSelection/Cancel(src.client)
			var/obj/Accept = new/obj/HUD/RaceSelection/Accept(src.client)
			var/obj/Male = new/obj/HUD/RaceSelection/Male(src.client)
			var/obj/Female = new/obj/HUD/RaceSelection/Female(src.client)
			Scroll1.screen_loc = "2,15 to 14,15"
			ScrollLeft1.screen_loc = "1,15"
			ScrollLeft2.screen_loc = "1,2"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,2"
			H.screen_loc = "2,14 to 14,3"
			F.screen_loc = "2,3 to 2,14"
			G.screen_loc = "14,3 to 14,14"
			Scroll2.screen_loc = "2,2 to 14,2"

			Human.screen_loc = "2,14"
			Wolfman.screen_loc = "3,14"
			Alther.screen_loc = "4,14"
			Cyclops.screen_loc = "6,14"
			Stahlite.screen_loc = "14,14"
			Snakeman.screen_loc = "13,14"
			Frogman.screen_loc = "8,14"
			Giant.screen_loc = "10,14"
			Ratling.screen_loc = "12,14"

			Accept.screen_loc = "2,3"
			Cancel.screen_loc = "4,3"
			Male.screen_loc = "14,3"
			Female.screen_loc = "12,3"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2

			src.client.screen += Human
			src.client.screen += Wolfman
			src.client.screen += Alther
			src.client.screen += Snakeman
			src.client.screen += Cyclops
			src.client.screen += Frogman
			src.client.screen += Giant
			src.client.screen += Ratling
			src.client.screen += Stahlite

			src.client.screen += Accept
			src.client.screen += Cancel
			src.client.screen += Male
			src.client.screen += Female
			H.Type = "RaceSelection"
			F.Type = "RaceSelection"
			G.Type = "RaceSelection"
			Scroll1.Type = "RaceSelection"
			Scroll2.Type = "RaceSelection"
			ScrollLeft1.Type = "RaceSelection"
			ScrollLeft2.Type = "RaceSelection"
			ScrollRight1.Type = "RaceSelection"
			ScrollRight2.Type = "RaceSelection"
			if(src.key in IllithidList)
				var/obj/Illithid = new/obj/HUD/RaceSelection/Illithid(src.client)
				Illithid.screen_loc = "5,14"
				src.client.screen += Illithid
		CreateSkillDisplay()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			Scroll1.screen_loc = "2,15 to 14,15"
			ScrollLeft1.screen_loc = "1,15"
			ScrollLeft2.screen_loc = "1,2"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,2"
			H.screen_loc = "2,14 to 14,3"
			F.screen_loc = "2,3 to 2,14"
			G.screen_loc = "14,3 to 14,14"
			Scroll2.screen_loc = "2,2 to 14,2"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2
			H.Type = "SkillDisplay"
			F.Type = "SkillDisplay"
			G.Type = "SkillDisplay"
			Scroll1.Type = "SkillDisplay"
			Scroll2.Type = "SkillDisplay"
			ScrollLeft1.Type = "SkillDisplay"
			ScrollLeft2.Type = "SkillDisplay"
			ScrollRight1.Type = "SkillDisplay"
			ScrollRight2.Type = "SkillDisplay"
			src.Text("SkillDisplay",src,2,14,10,14,"--Skill Information--")
			src.Text("SkillDisplay",src,2,13,10,14,"SwordSkill-[src.SwordSkill]")
			src.Text("SkillDisplay",src,2,12,10,14,"SpearSkill-[src.SpearSkill]")
			src.Text("SkillDisplay",src,2,11,10,14,"BluntSkill-[src.BluntSkill]")
			src.Text("SkillDisplay",src,2,10,10,14,"AxeSkill-[src.AxeSkill]")
			src.Text("SkillDisplay",src,2,9,10,14,"DaggerSkill-[src.DaggerSkill]")
			src.Text("SkillDisplay",src,2,8,10,14,"RangedSkill-[src.RangedSkill]")
			src.Text("SkillDisplay",src,2,7,10,14,"UnarmedSkill-[src.UnarmedSkill]")
			src.Text("SkillDisplay",src,2,6,10,14,"ShieldSkill-[src.ShieldSkill]")
			src.Text("SkillDisplay",src,2,5,10,14,"Mining-[src.MiningSkill]")
			src.Text("SkillDisplay",src,2,4,10,14,"Smelting-[src.SmeltingSkill]")
			src.Text("SkillDisplay",src,2,3,10,14,"FirstAid-[src.FirstAidSkill]")
			src.Text("SkillDisplay",src,6,13,10,14,"Forging-[src.ForgingSkill]")
			src.Text("SkillDisplay",src,6,12,10,14,"Masonary-[src.MasonarySkill]")
			src.Text("SkillDisplay",src,6,11,10,14,"Cooking-[src.CookingSkill]")
			src.Text("SkillDisplay",src,6,10,10,14,"Fishing-[src.FishingSkill]")
			src.Text("SkillDisplay",src,6,9,10,14,"Alchemy-[src.AlchemySkill]")
			src.Text("SkillDisplay",src,6,8,10,14,"LeatherCraft-[src.LeatherCraftSkill]")
			src.Text("SkillDisplay",src,6,7,10,14,"WoodCutting-[src.WoodCuttingSkill]")
			src.Text("SkillDisplay",src,6,6,10,14,"Building-[src.BuildingSkill]")
			src.Text("SkillDisplay",src,6,5,10,14,"Farming-[src.FarmingSkill]")
			src.Text("SkillDisplay",src,6,4,10,14,"Weaving-[src.WeavingSkill]")
			src.Text("SkillDisplay",src,6,3,10,14,"Carpentry-[src.CarpentrySkill]")
			src.Text("SkillDisplay",src,10,13,10,14,"Skinning-[src.SkinningSkill]")
			src.Text("SkillDisplay",src,10,12,10,14,"Butchery-[src.ButcherySkill]")
			src.Text("SkillDisplay",src,10,11,10,14,"Engraving-[src.EngravingSkill]")
			src.Text("SkillDisplay",src,10,10,10,14,"Swimming-[src.SwimmingSkill]")
			src.Text("SkillDisplay",src,10,9,10,14,"BoneCraft-[src.BoneCraftSkill]")
			src.Text("SkillDisplay",src,10,8,10,14,"Astral Magic-[src.AstralMagic]")
			src.Text("SkillDisplay",src,10,7,10,14,"Necromancy-[src.Necromancery]")
			src.Text("SkillDisplay",src,10,6,10,14,"Blood Magic-[src.BloodMagic]")
		CreateHealthDisplay()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			Scroll1.screen_loc = "2,15 to 14,15"
			ScrollLeft1.screen_loc = "1,15"
			ScrollLeft2.screen_loc = "1,3"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,3"
			H.screen_loc = "2,14 to 14,4"
			F.screen_loc = "2,4 to 2,14"
			G.screen_loc = "14,4 to 14,14"
			Scroll2.screen_loc = "2,3 to 14,3"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2
			H.Type = "HealthDisplay"
			F.Type = "HealthDisplay"
			G.Type = "HealthDisplay"
			Scroll1.Type = "HealthDisplay"
			Scroll2.Type = "HealthDisplay"
			ScrollLeft1.Type = "HealthDisplay"
			ScrollLeft2.Type = "HealthDisplay"
			ScrollRight1.Type = "HealthDisplay"
			ScrollRight2.Type = "HealthDisplay"
			var/Blood
			if(src.Bleed)
				Blood = src.Bleed
			else
				Blood = "None"
			src.Text("HealthDisplay",src,4,14,1,14,"--Health Information--")
			if(src.Race != "Snakeman")
				src.Text("HealthDisplay",src,2,13,1,14,"RightLeg-[src.RightLeg]%")
				src.Text("HealthDisplay",src,2,12,1,14,"LeftLeg-[src.LeftLeg]%")
			src.Text("HealthDisplay",src,2,11,1,14,"RightArm-[src.RightArm]%")
			src.Text("HealthDisplay",src,2,10,1,14,"LeftArm-[src.LeftArm]%")
			src.Text("HealthDisplay",src,2,9,1,14,"Nose-[src.Nose]%")
			src.Text("HealthDisplay",src,2,8,1,14,"LeftEar-[src.LeftEar]%")
			src.Text("HealthDisplay",src,2,7,1,14,"RightEar-[src.RightEar]%")
			src.Text("HealthDisplay",src,2,6,1,14,"Teeth-[src.Teeth]%")
			if(src.Race != "Cyclops")
				src.Text("HealthDisplay",src,2,5,1,14,"LeftEye-[src.LeftEye]%")
				src.Text("HealthDisplay",src,2,4,1,14,"RightEye-[src.RightEye]%")
			else
				src.Text("HealthDisplay",src,2,5,1,14,"Eye-[src.RightEye]%")
			src.Text("HealthDisplay",src,7,13,1,14,"Tongue-[src.Tongue]%")
			src.Text("HealthDisplay",src,7,12,1,14,"Skull-[src.Skull]%")
			src.Text("HealthDisplay",src,7,11,1,14,"Brain-[src.Brain]%")
			src.Text("HealthDisplay",src,7,10,1,14,"Heart-[src.Heart]%")
			src.Text("HealthDisplay",src,7,9,1,14,"LeftLung-[src.LeftLung]%")
			src.Text("HealthDisplay",src,7,8,1,14,"RightLung-[src.RightLung]%")
			src.Text("HealthDisplay",src,7,7,1,14,"Liver-[src.Liver]%")
			src.Text("HealthDisplay",src,7,6,1,14,"Spleen-[src.Spleen]%")
			src.Text("HealthDisplay",src,7,5,1,14,"LeftKidney-[src.LeftKidney]%")
			src.Text("HealthDisplay",src,7,4,1,14,"RightKidney-[src.RightKidney]%")
			src.Text("HealthDisplay",src,11,13,-5,14,"Intestines-[src.Intestine]%")
			src.Text("HealthDisplay",src,11,12,-5,14,"Stomach-[src.Stomach]%")
			src.Text("HealthDisplay",src,11,11,-5,14,"Throat-[src.Throat]%")
			if(src.Claws != 0)
				src.Text("HealthDisplay",src,11,10,-5,14,"Claws-[src.Claws]%")
			src.Text("HealthDisplay",src,10,14,10,14,"Bleeding-[Blood]")
		CreateInfoDisplay()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			Scroll1.screen_loc = "4,15 to 14,15"
			ScrollLeft1.screen_loc = "3,15"
			ScrollLeft2.screen_loc = "3,3"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,3"
			H.screen_loc = "4,14 to 14,4"
			F.screen_loc = "4,4 to 4,14"
			G.screen_loc = "14,4 to 14,14"
			Scroll2.screen_loc = "4,3 to 14,3"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2
			H.Type = "InfoDisplay"
			F.Type = "InfoDisplay"
			G.Type = "InfoDisplay"
			Scroll1.Type = "InfoDisplay"
			Scroll2.Type = "InfoDisplay"
			ScrollLeft1.Type = "InfoDisplay"
			ScrollLeft2.Type = "InfoDisplay"
			ScrollRight1.Type = "InfoDisplay"
			ScrollRight2.Type = "InfoDisplay"
			src.Text("InfoDisplay",src,4,14,10,10,"--General Information--")
			src.Text("InfoDisplay",src,4,13,10,10,"Name-[src.name]")
			src.Text("InfoDisplay",src,4,12,10,10,"Age-[src.Age]")
			src.Text("InfoDisplay",src,4,11,10,10,"Gender-[src.Gender]")
			src.Text("InfoDisplay",src,4,10,10,10,"Hunger-[src.Hunger]")
			src.Text("InfoDisplay",src,4,9,10,10,"Tiredness-[src.Sleep]")
			src.Text("InfoDisplay",src,4,8,10,10,"Strength-[src.Strength]")
			src.Text("InfoDisplay",src,4,7,10,10,"Agility-[src.Agility]")
			src.Text("InfoDisplay",src,4,6,10,10,"Endurance-[src.Endurance]")
			src.Text("InfoDisplay",src,4,5,10,10,"Intelligence-[src.Intelligence]")

		Corruption()
			spawn(7000)
				if(src)
					if(src.WRightHand)
						var/obj/I = src.WRightHand
						src.Heal()
						if(I.icon_state == "Corruption6")
							src << "<font color = red>Your mind begins to spiral into oblivion, images of death, detruction, and doom plague your very sight. All of your senses feel numb, robbed from you by the [I], no emotion, no memory, only the overwhelming desire to obliterate all in your path. You begin to twitch violently, your entire body burns with pain. You slowly begin to float just off the ground as your entire being flares with the most immense pain that could ever be felt by a mortal. After what seems hours,but merely seconds, you fall to the ground. The [I] begins to spread all over your head, covering your body compleatly in a near impossible to break barrier of strange metal. You slowly rise from the ground with a new sense of purpose, one purpose, to kill all living beings. You feel no pain anymore, only numbness, and the cold whisper of doom in your ear, forever urging you to kill.<br>"
							src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							I.icon_state = "Corruption7"
							I.EquipState = I.icon_state
							src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
							I.Defence += 5
							I.Dura += 50
							if(src.WHead)
								var/obj/Q = src.WHead
								src.Weight -= Q.Weight
								del(Q)
							src.WHead = I
							src.Pain += 50
							src.icon = 'corrupted.dmi'
							I.Weight += 2
							src.Weight += 2
							return
						if(I.icon_state == "Corruption5")
							src << "<font color = red>Your mind explodes with images of death, slaughter, blood shed and decay. You hear whispers in your head, telling you to kill every being you see. Your entire body begins to pulse with energy as the [I] begins to spread, it wont be long now before it compleatly consumes your body and soul. You fall to the floor once more as the [I] fuses to your neck!<br>"
							src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							I.icon_state = "Corruption6"
							I.EquipState = I.icon_state
							src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
							I.Defence += 5
							I.Dura += 50
							src.Pain += 50
							I.Weight += 2
							src.Weight += 2
						if(I.icon_state == "Corruption4")
							src << "<font color = red>Your legs go compleatly dead as a numb feeling creeps down them, suddenly a massive bolt of pain expands all across your body as the [I] begins to spread down onto your legs. You fall flat on your face un-able to move as images of doom fill your mind and whisper for you to.....Kill...<br>"
							src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							I.icon_state = "Corruption5"
							I.EquipState = I.icon_state
							src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
							I.Defence += 5
							I.Dura += 50
							src.Pain += 50
							if(src.WLegs)
								var/obj/Q = src.WLegs
								src.Weight -= Q.Weight
								del(Q)
							if(src.WLeftFoot)
								var/obj/Q = src.WLeftFoot
								src.Weight -= Q.Weight
								del(Q)
							if(src.WRightFoot)
								var/obj/Q = src.WRightFoot
								src.Weight -= Q.Weight
								del(Q)
							src.WLegs = I
							src.WLeftFoot = I
							src.WRightFoot = I
							I.Weight += 10
							src.Weight += 10
						if(I.icon_state == "Corruption3")
							src << "<font color = red>Images of death, rage and destruction fill your mind as the [I] begins to expand even further over your chest. You roll on the ground in pain as it begins to fuse to your body!<br>"
							src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							I.icon_state = "Corruption4"
							I.EquipState = I.icon_state
							src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
							I.Defence += 5
							I.Dura += 25
							src.Pain += 50
							if(src.WLeftHand)
								var/obj/Q = src.WLeftHand
								src.Weight -= Q.Weight
								del(Q)
							src.WLeftHand = I
							I.Weight += 5
							src.Weight += 5
						if(I.icon_state == "Corruption2")
							src << "<font color = red>You fall to the ground with a loud thud as your body fills with agony, the [I] begins to spread onto your torso, you scream with rage as it begins to bind its self to your chest!<br>"
							src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							I.icon_state = "Corruption3"
							I.EquipState = I.icon_state
							src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
							I.Defence += 5
							I.Dura += 25
							src.Pain += 50
							if(src.WShoulders)
								var/obj/Q = src.WShoulders
								src.Weight -= Q.Weight
								del(Q)
							if(src.WChest)
								var/obj/Q = src.WChest
								src.Weight -= Q.Weight
								del(Q)
							if(src.WUpperBody)
								var/obj/Q = src.WUpperBody
								src.Weight -= Q.Weight
								del(Q)
							src.WShoulders = I
							src.WChest = I
							src.WUpperBody = I
							I.Weight += 10
							src.Weight += 10
						if(I.icon_state == "Corruption1")
							src << "<font color = red>You feel a very sharp pain shoot up your arm as the [I] begins to spread further, you fall to the floor in agony as it begins to fuse to your body even more!<br>"
							src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							I.icon_state = "Corruption2"
							I.EquipState = I.icon_state
							I.Defence += 5
							I.Dura += 25
							I.name = "Armour of Corruption"
							I.Weight += 5
							src.Weight += 5
							src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
							src.Pain += 50
					else
						return
				src.Corruption()
		Save()
			if(Ruining)
				return
			if(src.LoggedIn == 0)
				return
			src.TargetIcon = null
			src.overlays = null
			var/player_sav = "players/[ckey].sav"
			var/savefile/F = new(player_sav)
			var/X = src.x
			var/Y = src.y
			var/Z = src.z
			var/Ver = world.version
			F["X"] << X
			F["Y"] << Y
			F["Z"] << Z
			F["Version"] << Ver
			Write(F)
			src << "Saved"
		Load()
			var/player_sav = "players/[src.ckey].sav"
			if(length(file(player_sav)))
				var/savefile/F = new(player_sav)
				Read(F)
				var/X
				var/Y
				var/Z
				var/Ver
				F["X"] >> X
				F["Y"] >> Y
				F["Z"] >> Z
				F["Version"] >> Ver
				src.loc = locate(X,Y,Z)
				src.overlays = null
				src.client.dir = NORTH
				if(src.InWater == 2)
					src.Breathe()
				if(src.Weight <= 0)
					src.Weight = 0
				for(var/obj/I in src)
					I.layer = 20
					if(I.name == "DemonicSword")
						I.DemonicSwordMagic()
					if(I.suffix == "Fused")
						I.icon_state = I.EquipState
						src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
						if(I.icon_state != "Corruption6")
							src.Corruption()
					if(I.suffix == "Equip")
						if(I == src.Weapon2)
							I.icon_state = "[I.EquipState] left"
							src.overlays+=image(I.icon,"[I.icon_state]",I.ItemLayer)
						else
							I.icon_state = I.EquipState
							src.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
						if(I == src.WExtra)
							I.icon_state = I.CarryState
						if(I.Type == "Torch Lit")
							I.LightProc(src)
				for(var/obj/Items/Resources/Skin/S in src)
					S.CreateLeather()
				src.Attack()
				if(src.CanUseMagic == 0)
					spawn(100)
						if(src)
							src.CanUseMagic = 1
				if(src.CanExamine == 0)
					spawn(100)
						if(src)
							src.CanExamine = 1
				if(src.CanInteract == 0)
					spawn(100)
						if(src)
							src.CanInteract = 1
				if(src.Faction != "Undead")
					src.Regen()
					src.Bleed = null
					if(src.Blood >= src.BloodMax)
						src.Blood = src.BloodMax
					if(src.Blood != src.BloodMax)
						if(src.Dead == 0)
							src.Bleed()
							view(src) << "<font color =red>[src] is bleeding [src.Bleed]!<br>"
					src.BloodFlow()
				else
					src.UndeadProc()
				if(src.CanSleep)
					src.SleepTick()
				if(src.CanEat)
					src.HungerTick()
				src.Update()
				src.Noise()
				src.CheckAfflictions()
				src.RemoveCombatOverlays()
				src.CreateGUI()
				src.overlays -= /obj/Misc/Fire/
				if(src.Dead == 0)
					src.density = 1
					src.CanAttack = 1
				if(src.Jailed)
					src.JailTime()
				if(src.Hair)
					if(src.WHead == null)
						src.overlays += src.Hair
					if(src.WHead)
						var/obj/H = src.WHead
						if(H.Type == "Crown")
							src.overlays += src.Hair
				if(src.Beard)
					if(src.Race != "Stahlite")
						if(src.WHead == null)
							src.overlays += src.Beard
					else
						src.overlays += src.Beard
				if(src.OnFire)
					if(src.Fuel)
						src.overlays += /obj/Misc/Fire/
						src.luminosity = 5
						src.CreateSmoke()
						src.Burn(0)
						src.OnFire(1)
				if(src.Fainted)
					src.Fainted()
				if(src.Stunned)
					src.Stun()
				if(src.MortalWound)
					src.MortallyWounded()
				if(src.Sleeping)
					src.Sleeping = 0
					if(src.Fainted == 0)
						if(src.Stunned == 0)
							var/Legs = 1
							if(src.RightLeg == 0)
								if(src.LeftLeg == 0)
									Legs = 0
							if(Legs)
								src.CanMove = 1
					src.overlays -= /obj/Misc/Sleeping/
				if(src.CanMove == 0)
					if(src.Fainted == 0)
						if(src.Stunned == 0)
							var/Legs = 1
							if(src.RightLeg == 0)
								if(src.LeftLeg == 0)
									Legs = 0
							if(Legs)
								if(src.Sleeping == 0)
									src.CanMove = 1
				if(src.Dead == 0)
					src.luminosity = 0
					src.density = 1
					src.GoreCheck()
				else
					src.RemakeChoice()
			var/CurrentAge = Year - src.Born
			src.Age = CurrentAge
			if(src.Age <= 0)
				src.Age = 0
			var/SkillCaps = Age
			if(SkillCaps >= 0)
				while(SkillCaps)
					src.SkillCap += 16
					src.StrCap += 16
					src.EndCap += 16
					src.AgilCap += 16
					src.IntCap += 16
					SkillCaps -= 1
			if(src.SkillCap >= WorldSkillsCap)
				src.SkillCap = WorldSkillsCap
			if(src.StrCap >= WorldStrCap)
				src.StrCap = WorldStrCap
			if(src.AgilCap >= WorldAgilCap)
				src.AgilCap = WorldAgilCap
			if(src.EndCap >= WorldEndCap)
				src.EndCap = WorldEndCap
			if(src.IntCap >= WorldIntCap)
				src.IntCap = WorldIntCap
			if(src.Preg == 3)
				src.BirthTimer()
			for(var/turf/T in range(0,src))
				if(T.density && T.opacity)
					src.loc = locate(1,1,1)
					src << "<font color = teal>You were teleported to 1,1,1 because the Load Proc detected that you spawned on Dense Turf. It is possible that a Map wipe or Bug happened, please report this to an Admin.<br>"
			src << "<font color = teal>You are [src.Age] years old!<br>"
		CheckAfflictions()
			for(var/A in src.Afflictions)
				if(A == "Undead Bite")
					src.UndeadBite()
				if(A == "Ill")
					var/Illness = 0
					if(src.CanEatRawMeats == 0)
						Illness = 35
					if(src.CanEatRawMeats == 1)
						Illness = 20
					if(src.CanEatRawMeats == 2)
						Illness = 0
					src.Illness(Illness)
		MovementCheck()
			if(src.Stunned == 0 && src.Fainted == 0 && src.Sleeping == 0)
				if(src.Humanoid)
					var/Legs = 1
					if(src.RightLeg == 0)
						if(src.LeftLeg == 0)
							Legs = 0
					if(Legs)
						src.CanMove = 1
				else
					src.CanMove = 1
		GoreCheck()
			if(src.WoundHead)
				var/obj/W = src.WoundHead
				var/icon/I
				I = initial(W.icon)
				W.icon = I
				src.overlays += src.WoundHead
			if(src.WoundTorso)
				var/obj/W = src.WoundTorso
				var/icon/I
				I = initial(W.icon)
				W.icon = I
				src.overlays += src.WoundTorso
			if(src.WoundRightArm)
				var/obj/W = src.WoundRightArm
				var/icon/I
				I = initial(W.icon)
				W.icon = I
				src.overlays += src.WoundRightArm
			if(src.WoundLeftArm)
				var/obj/W = src.WoundLeftArm
				var/icon/I
				I = initial(W.icon)
				W.icon = I
				src.overlays += src.WoundLeftArm
			if(src.WoundLeftLeg)
				var/obj/W = src.WoundLeftLeg
				var/icon/I
				I = initial(W.icon)
				W.icon = I
				src.overlays += src.WoundLeftLeg
			if(src.WoundRightLeg)
				var/obj/W = src.WoundRightLeg
				var/icon/I
				I = initial(W.icon)
				W.icon = I
				src.overlays += src.WoundRightLeg
		GiveRank(var/Rank)
			if(Rank == "Human Empire Priest")
				src.WeightMax += 100
				src.Intelligence += 15
				src.IntCap += 15
				var/obj/Misc/Languages/Ancient/A = new
				A.SpeakPercent = 75
				A.WritePercent = 50
				src.LangKnow += A
				var/obj/Items/Weapons/Blunts/InquisitorsStaff/St = new
				var/obj/Items/Armour/Head/PriestHelmet/H = new
				var/obj/Items/Armour/Chest/PriestRobe/R = new
				var/obj/Items/Armour/UpperBody/PriestsChestPlate/C = new
				var/obj/Items/Armour/Waist/PriestBelt/B = new
				var/obj/Items/Armour/Shoulders/PriestsPauldrons/S = new
				var/obj/Items/Armour/LeftArm/PriestsLeftGauntlet/LG = new
				var/obj/Items/Armour/RightArm/PriestsRightGauntlet/RG = new
				var/obj/Items/Armour/LeftFoot/PriestsLeftBoot/LB = new
				var/obj/Items/Armour/RightFoot/PriestsRightBoot/RB = new
				var/obj/Items/Books_Scrolls/Book_of_Order/O = new
				O.Delete = 0
				St.Delete = 0
				H.Delete = 0
				R.Delete = 0
				C.Delete = 0
				B.Delete = 0
				S.Delete = 0
				LG.Delete = 0
				RG.Delete = 0
				LB.Delete = 0
				RB.Delete = 0
				O.Move(src)
				St.Move(src)
				H.Move(src)
				R.Move(src)
				C.Move(src)
				B.Move(src)
				S.Move(src)
				LG.Move(src)
				RG.Move(src)
				LB.Move(src)
				RB.Move(src)
				src.Weight += O.Weight
				src.Weight += St.Weight
				src.Weight += H.Weight
				src.Weight += R.Weight
				src.Weight += C.Weight
				src.Weight += B.Weight
				src.Weight += S.Weight
				src.Weight += LG.Weight
				src.Weight += RG.Weight
				src.Weight += LB.Weight
				src.Weight += RB.Weight
				O.suffix = "Carried"
				St.suffix = "Carried"
				H.suffix = "Carried"
				R.suffix = "Carried"
				C.suffix = "Carried"
				B.suffix = "Carried"
				S.suffix = "Carried"
				LG.suffix = "Carried"
				RG.suffix = "Carried"
				LB.suffix = "Carried"
				RB.suffix = "Carried"
				var/obj/Items/Misc/Key/K = new
				K.Material = "Gold"
				K.icon_state = "Gold key"
				K.tag = "Inquisitor Vault Key"
				for(var/obj/Items/Furniture/Doors/InquisitorIronDoor/D in world)
					if(D.loc == locate(106,45,3))
						K.KeyCode = D.KeyCode
				K.Move(src)
				K.suffix = "Carried"
				src.Weight += K.Weight
				var/obj/Items/Armour/Head/InquisitorsHelmet/IH = new
				var/obj/Items/Armour/UpperBody/InquisitorsChestPlate/IC = new
				var/obj/Items/Armour/Shoulders/InquisitorsPauldrons/IS = new
				var/obj/Items/Armour/LeftArm/InquisitorsLeftGauntlet/ILG = new
				var/obj/Items/Armour/RightArm/InquisitorsRightGauntlet/IRG = new
				var/obj/Items/Armour/LeftFoot/InquisitorsLeftBoot/ILB = new
				var/obj/Items/Armour/RightFoot/InquisitorsRightBoot/IRB = new
				IH.Delete = 0
				IC.Delete = 0
				IS.Delete = 0
				ILG.Delete = 0
				IRG.Delete = 0
				ILB.Delete = 0
				IRB.Delete = 0
				IH.pixel_y = 12
				IC.pixel_y = 12
				IS.pixel_y = 12
				ILG.pixel_y = 12
				IRG.pixel_y = 12
				ILB.pixel_y = 12
				IRB.pixel_y = 12
				IH.Move(locate(105,39,3))
				IC.Move(locate(105,39,3))
				IS.Move(locate(105,39,3))
				ILG.Move(locate(105,39,3))
				IRG.Move(locate(105,39,3))
				ILB.Move(locate(105,39,3))
				IRB.Move(locate(105,39,3))
				var/obj/Items/Weapons/Blunts/InquisitorsMaul/IM = new
				IM.pixel_y = 12
				IM.Delete = 0
				IM.Move(locate(103,40,3))
				var/obj/Items/Weapons/Swords/DemonicSword/DS = new
				DS.pixel_y = 12
				DS.Delete = 0
				DS.Move(locate(109,40,3))
				var/mob/NPC/Evil/Demonic/GreaterDemon/D = new
				D.CancelDefaultProc = 1
				spawn(100)
					D.loc = DS
					DS.DemonicSwordMagic()
				var/obj/Items/Armour/RightArm/Glove_of_Corruption/GoC = new
				GoC.pixel_y = 12
				GoC.Move(locate(107,39,3))
				var/obj/Items/Books_Scrolls/Book_of_Necromancy/NB = new
				NB.pixel_y = 10
				NB.Move(locate(106,41,3))
				var/obj/Items/Magical/Mystical_Ball/MB = new
				MB.pixel_y = 17
				MB.Move(locate(106,39,3))
				var/obj/Items/Currency/GoldCoin/G = new
				G.Type = 1000
				G.Move(src)
				G.suffix = "Carried"
				G.name = "[G.Type] [G.name]"
				G.icon_state = "gold coin >100"
				SaveMap()
				src << "<font color = teal>You have been granted the Rank of Human Priest of Order. Your Job will be to Role Play a high ranking Monk, making sure that no harm comes to anyone involved with the Human Empire, or the Inquisition. The King and Queen of the Human Empire know of you. You have been granted a full set of Priest Armour, and a Priest Staff, and also a very powerful Book of Order. You must never, ever, give this book to anyone, not even the King or Queen, the same goes for your armour. They belong to you, and they belong to the God of Order. If there is no offical King or Queen, the Priest rules in place, however, the Priest is never higher rank than the King and Queen, and as such, can not overule any orders that they give. You must be a Good Person, and not Evil, however, you are allowed to be Paranoid. If you suspect someone of being Evil, you can Torture them until they admit to wrong doings or Evil involement, but this all requires good RP reasons, ect. The Book of Order can Revive NPC and Players, but each time you use it, you Must Role Play doing so. Breaking any of the previously mentioned requirements or rules that involve the Priest Rank, will get you stripped of said Rank or even Ban. Your character now has knowledge of all Undead creatures, and also where the Undead lands are, ect. You also know of Demons, and all Gods, as well as any and all Evil Relics, Artifacts, or Books. You have also learned alot of the Ancient Language, from old Scrolls and Books, and have been given a Plus 15 Intelligence boost to help you learn other Languages faster. You've also been given a special key to un-lock the Inquisitor Artifact Vault. You are NOT to take ANYTHING from this vault without having both a Good Role Play Reason and having asked an Admin first. The vaults location is in the bottom of the Inquisitor Tower and is mainly used to lock away dangerous things.<br>"
				world << "<font color = yellow>All around the Human kingdom people far and wide begin to hear of a ceremony. A new Priest of Order had been selected by ancient Decree and instated with the responsibility of ruling the Inquisition and even the entire Human Empire when needed. Word of this slowly spreads outside of the Humans lands as both ally and enemy hear the news."
			if(Rank == "Diplomat")
				src.LangKnow = null
				src.LangKnow = list()

				var/obj/Misc/Languages/Altherian/A = new
				A.SpeakPercent = 100
				A.WritePercent = 100
				src.LangKnow += A
				src.CurrentLanguage = A

				var/obj/Misc/Languages/Common/C = new
				C.SpeakPercent = 100
				C.WritePercent = 100
				src.LangKnow += C

				var/obj/Misc/Languages/Human/H = new
				H.SpeakPercent = 100
				H.WritePercent = 100
				src.LangKnow += H

				var/obj/Misc/Languages/Ribbitus/R = new
				R.SpeakPercent = 100
				R.WritePercent = 100
				src.LangKnow += R

				var/obj/Misc/Languages/Scutter/S = new
				S.SpeakPercent = 100
				S.WritePercent = 100
				src.LangKnow += S

				var/obj/Misc/Languages/Slithus/Sl = new
				Sl.SpeakPercent = 100
				Sl.WritePercent = 100
				src.LangKnow += Sl

				var/obj/Misc/Languages/Stahliteian/St = new
				St.SpeakPercent = 100
				St.WritePercent = 100
				src.LangKnow += St

				var/obj/Misc/Languages/Wolfen/W = new
				W.SpeakPercent = 100
				W.WritePercent = 100
				src.LangKnow += W

				src << "<font color = teal>You have been Granted the Rank of Diplomat, your task is to work along side your King/Queen and his/her minions, translating what other races say and also being a messanger. You have all the Languages and are 100% Fluent in them all. The King/Queen of your Kingdom is aware of you ICly as soon as your Rank is given.<br>"
			if(Rank == "Weapon Master")
				src.Agility += 5
				src.Strength += 5
				src.WeightMax += 10
				src.Endurance += 5
				src.AgilCap += 5
				src.StrCap += 5
				src.EndCap += 5
				src.DieAge += 5
				src.Age += 25
				src.Born -= 25
				var/obj/Wep
				var/list/menu = new()
				menu += "Sword"
				menu += "Broad Sword"
				menu += "Battle Axe"
				menu += "Mace"
				menu += "Maul"
				menu += "Spear"
				menu += "Dagger"
				menu += "Bow"
				var/Result = input(src,"Choose a Custom Weapon. You will gain a +50 Skill Bonus in the weapon type you choose.", "Choose", null) in menu
				if(Result == "Sword")
					var/obj/Items/Weapons/Swords/LongSword/W = new
					Wep = W
					src.SwordSkill += 25
				if(Result == "Broad Sword")
					var/obj/Items/Weapons/Swords/BroadSword/W = new
					Wep = W
					src.SwordSkill += 25
				if(Result == "Battle Axe")
					var/obj/Items/Weapons/Axes/BattleAxe/W = new
					Wep = W
					src.AxeSkill += 25
				if(Result == "Mace")
					var/obj/Items/Weapons/Blunts/Mace/W = new
					Wep = W
					src.BluntSkill += 25
				if(Result == "Maul")
					var/obj/Items/Weapons/Blunts/Maul/W = new
					Wep = W
					src.BluntSkill += 25
				if(Result == "Spear")
					var/obj/Items/Weapons/Spears/Spear/W = new
					Wep = W
					src.SpearSkill += 25
				if(Result == "Dagger")
					var/obj/Items/Weapons/Daggers/Dagger/W = new
					Wep = W
					src.DaggerSkill += 25
				if(Result == "Bow")
					var/obj/Items/Weapons/Ranged/Bow/W = new
					Wep = W
					src.RangedSkill += 25
				Wep.Dura = 500
				Wep.Weight = 7
				Wep.Quality = 15
				Wep.Move(src)
				src.Weight += Wep.Weight
				Wep.suffix = "Carried"
				Wep.Material = "Iron"
				Wep.CarryState = "Iron [Wep.CarryState]"
				Wep.EquipState = "Iron [Wep.EquipState] equip"
				Wep.icon_state = Wep.CarryState
				Wep.overlays+=image(/obj/HUD/C/)
				Wep.desc = "This is a [Wep], it is made from Iron. The Date it was created is etched on the side, Year 1, Month 0. The [Wep] seems to be of Grand Quality."
				var/list/looks = new()
				looks += "Default"
				looks += "Artifact"
				looks += "Corrupted"
				var/Result2 = input(src,"Choose an apperance for your Custom Weapon.", "Choose", null) in looks
				if(Result2 == "Artifact")
					if(Wep.name == "LongSword")
						Wep.icon_state = "Artifact sword"
						Wep.CarryState = "Artifact sword"
						Wep.EquipState = "Artifact sword equip"
					if(Wep.name == "BroadSword")
						Wep.icon_state = "Artifact broadsword"
						Wep.CarryState = "Artifact broadsword"
						Wep.EquipState = "Artifact broadsword equip"
					if(Wep.name == "BattleAxe")
						Wep.icon_state = "Artifact axe"
						Wep.CarryState = "Artifact axe"
						Wep.EquipState = "Artifact axe equip"
					if(Wep.name == "Mace")
						Wep.icon_state = "Artifact mace2"
						Wep.CarryState = "Artifact mace2"
						Wep.EquipState = "Artifact mace2 equip"
					if(Wep.name == "Maul")
						Wep.icon_state = "Artifact maul"
						Wep.CarryState = "Artifact maul"
						Wep.EquipState = "Artifact maul equip"
					if(Wep.name == "Spear")
						Wep.icon_state = "Artifact spear"
						Wep.CarryState = "Artifact spear"
						Wep.EquipState = "Artifact spear equip"
					if(Wep.name == "Dagger")
						Wep.icon_state = "Artifact dagger"
						Wep.CarryState = "Artifact dagger"
						Wep.EquipState = "Artifact dagger equip"
					if(Wep.name == "Bow")
						Wep.icon_state = "Artifact bow"
						Wep.CarryState = "Artifact bow"
						Wep.EquipState = "Artifact bow equip"
				if(Result2 == "Corrupted")
					if(Wep.name == "LongSword")
						Wep.icon_state = "Corrupted sword"
						Wep.CarryState = "Corrupted sword"
						Wep.EquipState = "Corrupted sword equip"
					if(Wep.name == "BroadSword")
						Wep.icon_state = "Corrupted broadsword"
						Wep.CarryState = "Corrupted broadsword"
						Wep.EquipState = "Corrupted broadsword equip"
					if(Wep.name == "BattleAxe")
						Wep.icon_state = "Corrupted axe"
						Wep.CarryState = "Corrupted axe"
						Wep.EquipState = "Corrupted axe equip"
					if(Wep.name == "Mace")
						Wep.icon_state = "Corrupted mace2"
						Wep.CarryState = "Corrupted mace2"
						Wep.EquipState = "Corrupted mace2 equip"
					if(Wep.name == "Maul")
						Wep.icon_state = "Corrupted maul"
						Wep.CarryState = "Corrupted maul"
						Wep.EquipState = "Corrupted maul equip"
					if(Wep.name == "Spear")
						Wep.icon_state = "Corrupted spear"
						Wep.CarryState = "Corrupted spear"
						Wep.EquipState = "Corrupted spear equip"
					if(Wep.name == "Dagger")
						Wep.icon_state = "Corrupted dagger"
						Wep.CarryState = "Corrupted dagger"
						Wep.EquipState = "Corrupted dagger equip"
					if(Wep.name == "Bow")
						Wep.icon_state = "Corrupted bow"
						Wep.CarryState = "Corrupted bow"
						Wep.EquipState = "Corrupted bow equip"
				var/WepName=input(src,"Name your weapon.")as text
				Wep.name = WepName
				src << "<font color = teal>You have been Granted the Rank of Weapon Master, this Rank has no True Static Purpose, you could choose to be a Teacher, Hermit, General, Leader, Villian, anything you desire, but you cant instantly use your skills to attack any of the Kings/Queens directly until Year 15+, if you attempt to, you will be Stripped of your Rank and Deducted. You have also been granted a +5 in Strength, Endurance, and Agility. You are now Twenty Five(25) Years older than before, and you will now live +5 more Years longer than your Average Race. No one knows of you ICly.<br>"
			if(Rank == "King/Queen")
				var/list/kingdom = new()
				kingdom += "Human Kingdom"
				kingdom += "Alther Kingdom"
				kingdom += "Stahlite Kingdom"
				kingdom += "Snakeman Kingdom"
				kingdom += "Frogman Tribe"
				kingdom += "Ratling Horde"
				kingdom += "Giant Kingdom"
				kingdom += "Cyclops Horde"
				var/KingdomResult = input(usr,"Which Kingdom will they rule?", "Choose", null) in kingdom
				world << "<font color = yellow>All around the [KingdomResult] followers far and wide begin to hear of a ceremony. Someone of supposed royal blood had been elected ruler this day. Word of this grand event travels to every corner of the known world, even to those on ill terms with the [KingdomResult].<br>"
				src.DieAge += 10
				var/obj/Items/Currency/GoldCoin/G = new
				G.Type = 500
				G.suffix = "Carried"
				G.Move(src)
				G.name = "[G.Type] [G.name]"
				G.icon_state = "gold coin >100"
				if(src.Race != "Stahlite" && src.Race != "Ratling" && src.Race != "Giant" && src.Race != "Cyclops")
					var/obj/Items/Armour/Head/Crown/C = new
					C.Move(src)
					src.Weight += C.Weight
					C.suffix = "Carried"
					C.overlays+=image(/obj/HUD/C/)

					var/obj/Items/Armour/Chest/KingsRobe/R = new
					R.Move(src)
					src.Weight += R.Weight
					R.suffix = "Carried"
					R.overlays+=image(/obj/HUD/C/)

					var/obj/Items/Armour/Head/PlateHelmet3/H = new
					H.Move(src)
					H.Defence = 10
					H.Dura = 100
					H.CarryState = "Gold [H.icon_state]"
					H.EquipState = "Gold [H.icon_state] equip"
					H.icon_state = "Gold [H.icon_state]"
					src.Weight += H.Weight
					H.suffix = "Carried"
					H.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/UpperBody/ChestPlate/CP = new
					CP.Move(src)
					CP.Defence = 10
					CP.Dura = 100
					CP.CarryState = "Gold [CP.icon_state]"
					CP.EquipState = "Gold [CP.icon_state] equip"
					CP.icon_state = "Gold [CP.icon_state]"
					src.Weight += CP.Weight
					CP.suffix = "Carried"
					CP.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/Shoulders/PlatePauldrons/S = new
					S.Move(src)
					S.Defence = 10
					S.Dura = 100
					S.CarryState = "Gold [S.icon_state]"
					S.EquipState = "Gold [S.icon_state] equip"
					S.icon_state = "Gold [S.icon_state]"
					src.Weight += S.Weight
					S.suffix = "Carried"
					S.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftArm/PlateGauntletLeft/LG = new
					LG.Move(src)
					LG.Defence = 10
					LG.Dura = 100
					LG.CarryState = "Gold [LG.icon_state]"
					LG.EquipState = "Gold [LG.icon_state] equip"
					LG.icon_state = "Gold [LG.icon_state]"
					src.Weight += LG.Weight
					LG.suffix = "Carried"
					LG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightArm/PlateGauntletRight/RG = new
					RG.Move(src)
					RG.Defence = 10
					RG.Dura = 100
					RG.CarryState = "Gold [RG.icon_state]"
					RG.EquipState = "Gold [RG.icon_state] equip"
					RG.icon_state = "Gold [RG.icon_state]"
					src.Weight += RG.Weight
					RG.suffix = "Carried"
					RG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftFoot/PlateBootLeft/LB = new
					LB.Move(src)
					LB.Defence = 10
					LB.Dura = 100
					LB.CarryState = "Gold [LB.icon_state]"
					LB.EquipState = "Gold [LB.icon_state] equip"
					LB.icon_state = "Gold [LB.icon_state]"
					src.Weight += LB.Weight
					LB.suffix = "Carried"
					LB.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightFoot/PlateBootRight/RB = new
					RB.Move(src)
					RB.Defence = 10
					RB.Dura = 100
					RB.CarryState = "Gold [RB.icon_state]"
					RB.EquipState = "Gold [RB.icon_state] equip"
					RB.icon_state = "Gold [RB.icon_state]"
					src.Weight += RB.Weight
					RB.suffix = "Carried"
					RB.overlays+=image(/obj/HUD/C/)
				var/SmallRace = 0
				var/LargeRace = 0
				if(src.Race == "Stahlite")
					SmallRace = 1
					var/obj/Items/Armour/Head/SmallDwarvenHelmet2/H = new
					H.Move(src)
					H.Defence = 10
					H.Dura = 100
					H.CarryState = "Gold [H.icon_state]"
					H.EquipState = "Gold [H.icon_state] equip"
					H.icon_state = "Gold [H.icon_state]"
					src.Weight += H.Weight
					H.suffix = "Carried"
					H.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/UpperBody/SmallChestPlate/CP = new
					CP.Move(src)
					CP.Defence = 10
					CP.Dura = 100
					CP.CarryState = "Gold [CP.icon_state]"
					CP.EquipState = "Gold [CP.icon_state] equip"
					CP.icon_state = "Gold [CP.icon_state]"
					src.Weight += CP.Weight
					CP.suffix = "Carried"
					CP.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/Shoulders/SmallPlatePauldrons/S = new
					S.Move(src)
					S.Defence = 10
					S.Dura = 100
					S.CarryState = "Gold [S.icon_state]"
					S.EquipState = "Gold [S.icon_state] equip"
					S.icon_state = "Gold [S.icon_state]"
					src.Weight += S.Weight
					S.suffix = "Carried"
					S.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftArm/SmallPlateGauntletLeft/LG = new
					LG.Move(src)
					LG.Defence = 10
					LG.Dura = 100
					LG.CarryState = "Gold [LG.icon_state]"
					LG.EquipState = "Gold [LG.icon_state] equip"
					LG.icon_state = "Gold [LG.icon_state]"
					src.Weight += LG.Weight
					LG.suffix = "Carried"
					LG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightArm/SmallPlateGauntletRight/RG = new
					RG.Move(src)
					RG.Defence = 10
					RG.Dura = 100
					RG.CarryState = "Gold [RG.icon_state]"
					RG.EquipState = "Gold [RG.icon_state] equip"
					RG.icon_state = "Gold [RG.icon_state]"
					src.Weight += RG.Weight
					RG.suffix = "Carried"
					RG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftFoot/SmallPlateBootLeft/LB = new
					LB.Move(src)
					LB.Defence = 10
					LB.Dura = 100
					LB.CarryState = "Gold [LB.icon_state]"
					LB.EquipState = "Gold [LB.icon_state] equip"
					LB.icon_state = "Gold [LB.icon_state]"
					src.Weight += LB.Weight
					LB.suffix = "Carried"
					LB.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightFoot/SmallPlateBootRight/RB = new
					RB.Move(src)
					RB.Defence = 10
					RB.Dura = 100
					RB.CarryState = "Gold [RB.icon_state]"
					RB.EquipState = "Gold [RB.icon_state] equip"
					RB.icon_state = "Gold [RB.icon_state]"
					src.Weight += RB.Weight
					RB.suffix = "Carried"
					RB.overlays+=image(/obj/HUD/C/)
				if(src.Race == "Ratling")
					SmallRace = 1
					var/obj/Items/Armour/Head/PlateHelmetRat/H = new
					H.Move(src)
					H.Defence = 10
					H.Dura = 100
					H.CarryState = "Iron rat plate helm"
					H.EquipState = "Iron rat plate helm equip"
					H.icon_state = "Iron rat plate helm"
					src.Weight += H.Weight
					H.suffix = "Carried"
					H.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/Chest/RatChainShirt/CP = new
					CP.Move(src)
					CP.Defence = 10
					CP.Dura = 100
					CP.CarryState = "Iron folded chain"
					CP.EquipState = "Iron [CP.EquipState] equip"
					CP.icon_state = "Iron folded chain"
					src.Weight += CP.Weight
					CP.suffix = "Carried"
					CP.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/UpperBody/RatChestPlate/GCP = new
					GCP.Move(src)
					GCP.Defence = 10
					GCP.Dura = 100
					GCP.CarryState = "Iron rat chestplate"
					GCP.EquipState = "Iron rat chestplate equip"
					GCP.icon_state = "Iron rat chestplate"
					src.Weight += GCP.Weight
					GCP.suffix = "Carried"
					GCP.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/Legs/RatChainLeggings/L = new
					L.Move(src)
					L.Defence = 10
					L.Dura = 100
					L.CarryState = "Iron folded chain"
					L.EquipState = "Iron [L.EquipState] equip"
					L.icon_state = "Iron folded chain"
					src.Weight += CP.Weight
					L.suffix = "Carried"
					L.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftArm/RatPlateGauntletLeft/LG = new
					LG.Move(src)
					LG.Defence = 10
					LG.Dura = 100
					LG.CarryState = "Iron rat plateglove left"
					LG.EquipState = "Iron rat plateglove left equip"
					LG.icon_state = "Iron rat plateglove left"
					src.Weight += LG.Weight
					LG.suffix = "Carried"
					LG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightArm/RatPlateGauntletRight/RG = new
					RG.Move(src)
					RG.Defence = 10
					RG.Dura = 100
					RG.CarryState = "Iron rat plateglove right"
					RG.EquipState = "Iron rat plateglove right equip"
					RG.icon_state = "Iron rat plateglove right"
					src.Weight += RG.Weight
					RG.suffix = "Carried"
					RG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftFoot/RatPlateBootLeft/LB = new
					LB.Move(src)
					LB.Defence = 10
					LB.Dura = 100
					LB.CarryState = "Iron rat plateboot left"
					LB.EquipState = "Iron rat plateboot left equip"
					LB.icon_state = "Iron rat plateboot left"
					src.Weight += LB.Weight
					LB.suffix = "Carried"
					LB.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightFoot/RatPlateBootRight/RB = new
					RB.Move(src)
					RB.Defence = 10
					RB.Dura = 100
					RB.CarryState = "Iron rat plateboot right"
					RB.EquipState = "Iron rat plateboot right equip"
					RB.icon_state = "Iron rat plateboot right"
					src.Weight += RB.Weight
					RB.suffix = "Carried"
					RB.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/Shoulders/RatPlatePauldrons/S = new
					S.Move(src)
					S.Defence = 10
					S.Dura = 100
					S.CarryState = "Iron rat shoulders"
					S.EquipState = "Iron rat shoulders equip"
					S.icon_state = "Iron rat shoulders"
					src.Weight += S.Weight
					S.suffix = "Carried"
					S.overlays+=image(/obj/HUD/C/)
				if(SmallRace)
					var/obj/Items/Armour/Head/SmallCrown/C = new
					C.Move(src)
					src.Weight += C.Weight
					C.suffix = "Carried"
					C.overlays+=image(/obj/HUD/C/)
				if(src.Race == "Giant")
					LargeRace = 1
				if(src.Race == "Cyclops")
					LargeRace = 1
				if(LargeRace)
					var/obj/Items/Armour/Head/GiantCrown/C = new
					C.Move(src)
					src.Weight += C.Weight
					C.suffix = "Carried"
					C.overlays+=image(/obj/HUD/C/)

					var/obj/Items/Armour/Head/GiantChainCoif/H = new
					H.Move(src)
					H.Defence = 10
					H.Dura = 100
					H.CarryState = "Iron folded chain"
					H.EquipState = "Iron [H.EquipState] equip"
					H.icon_state = "Iron folded chain"
					src.Weight += H.Weight
					H.suffix = "Carried"
					H.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/Chest/GiantChainShirt/CP = new
					CP.Move(src)
					CP.Defence = 10
					CP.Dura = 100
					CP.CarryState = "Iron folded chain"
					CP.EquipState = "Iron [CP.EquipState] equip"
					CP.icon_state = "Iron folded chain"
					src.Weight += CP.Weight
					CP.suffix = "Carried"
					CP.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/UpperBody/GiantChestPlate/GCP = new
					GCP.Move(src)
					GCP.Defence = 10
					GCP.Dura = 100
					GCP.CarryState = "Iron giant chestplate"
					GCP.EquipState = "Iron giant chestplate equip"
					GCP.icon_state = "Iron giant chestplate"
					src.Weight += GCP.Weight
					GCP.suffix = "Carried"
					GCP.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/Legs/GiantChainLeggings/L = new
					L.Move(src)
					L.Defence = 10
					L.Dura = 100
					L.CarryState = "Iron folded chain"
					L.EquipState = "Iron [L.EquipState] equip"
					L.icon_state = "Iron folded chain"
					src.Weight += CP.Weight
					L.suffix = "Carried"
					L.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftArm/GiantPlateGloveLeft/LG = new
					LG.Move(src)
					LG.Defence = 10
					LG.Dura = 100
					LG.CarryState = "Iron giant plateglove left"
					LG.EquipState = "Iron giant plateglove left equip"
					LG.icon_state = "Iron giant plateglove left"
					src.Weight += LG.Weight
					LG.suffix = "Carried"
					LG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightArm/GiantPlateGloveRight/RG = new
					RG.Move(src)
					RG.Defence = 10
					RG.Dura = 100
					RG.CarryState = "Iron giant plateglove right"
					RG.EquipState = "Iron giant plateglove right equip"
					RG.icon_state = "Iron giant plateglove right"
					src.Weight += RG.Weight
					RG.suffix = "Carried"
					RG.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/LeftFoot/GiantPlateBootLeft/LB = new
					LB.Move(src)
					LB.Defence = 10
					LB.Dura = 100
					LB.CarryState = "Iron giant plateboot left"
					LB.EquipState = "Iron giant plateboot left equip"
					LB.icon_state = "Iron giant plateboot left"
					src.Weight += LB.Weight
					LB.suffix = "Carried"
					LB.overlays+=image(/obj/HUD/C/)
					var/obj/Items/Armour/RightFoot/GiantPlateBootRight/RB = new
					RB.Move(src)
					RB.Defence = 10
					RB.Dura = 100
					RB.CarryState = "Iron giant plateboot right"
					RB.EquipState = "Iron giant plateboot right equip"
					RB.icon_state = "Iron giant plateboot right"
					src.Weight += RB.Weight
					RB.suffix = "Carried"
					RB.overlays+=image(/obj/HUD/C/)
				var/obj/Wep
				var/list/menu = new()
				menu += "Sword"
				menu += "Broad Sword"
				menu += "Battle Axe"
				menu += "Mace"
				menu += "Maul"
				menu += "Spear"
				menu += "Dagger"
				menu += "Bow"
				var/Result = input(src,"Choose a Custom Royal Weapon.", "Choose", null) in menu
				if(Result == "Sword")
					var/obj/Items/Weapons/Swords/LongSword/W = new
					Wep = W
				if(Result == "Broad Sword")
					var/obj/Items/Weapons/Swords/BroadSword/W = new
					Wep = W
				if(Result == "Battle Axe")
					var/obj/Items/Weapons/Axes/BattleAxe/W = new
					Wep = W
				if(Result == "Mace")
					var/obj/Items/Weapons/Blunts/Mace/W = new
					Wep = W
				if(Result == "Maul")
					var/obj/Items/Weapons/Blunts/Maul/W = new
					Wep = W
				if(Result == "Spear")
					var/obj/Items/Weapons/Spears/Spear/W = new
					Wep = W
				if(Result == "Dagger")
					var/obj/Items/Weapons/Daggers/Dagger/W = new
					Wep = W
				if(Result == "Bow")
					var/obj/Items/Weapons/Ranged/Bow/W = new
					Wep = W
				Wep.Dura = 1000
				Wep.Weight = 5
				Wep.Quality = 15
				Wep.Move(src)
				src.Weight += Wep.Weight
				Wep.Material = "Iron"
				Wep.CarryState = "Iron [Wep.CarryState]"
				Wep.EquipState = "Iron [Wep.EquipState] equip"
				Wep.icon_state = Wep.CarryState
				Wep.suffix = "Carried"
				Wep.overlays+=image(/obj/HUD/C/)
				Wep.desc = "This is a [Wep], it is made from Iron. The Date it was created is etched on the side, Year 1, Month 0. The [Wep] seems to be of Grand Quality."
				var/list/looks = new()
				looks += "Default"
				looks += "Artifact"
				looks += "Corrupted"
				var/Result2 = input(src,"Choose an apperance for your Custom Weapon.", "Choose", null) in looks
				if(Result2 == "Artifact")
					if(Wep.name == "LongSword")
						Wep.icon_state = "Artifact sword"
						Wep.CarryState = "Artifact sword"
						Wep.EquipState = "Artifact sword equip"
					if(Wep.name == "BroadSword")
						Wep.icon_state = "Artifact broadsword"
						Wep.CarryState = "Artifact broadsword"
						Wep.EquipState = "Artifact broadsword equip"
					if(Wep.name == "BattleAxe")
						Wep.icon_state = "Artifact axe"
						Wep.CarryState = "Artifact axe"
						Wep.EquipState = "Artifact axe equip"
					if(Wep.name == "Mace")
						Wep.icon_state = "Artifact mace2"
						Wep.CarryState = "Artifact mace2"
						Wep.EquipState = "Artifact mace2 equip"
					if(Wep.name == "Maul")
						Wep.icon_state = "Artifact maul"
						Wep.CarryState = "Artifact maul"
						Wep.EquipState = "Artifact maul equip"
					if(Wep.name == "Spear")
						Wep.icon_state = "Artifact spear"
						Wep.CarryState = "Artifact spear"
						Wep.EquipState = "Artifact spear equip"
					if(Wep.name == "Dagger")
						Wep.icon_state = "Artifact dagger"
						Wep.CarryState = "Artifact dagger"
						Wep.EquipState = "Artifact dagger equip"
					if(Wep.name == "Bow")
						Wep.icon_state = "Artifact bow"
						Wep.CarryState = "Artifact bow"
						Wep.EquipState = "Artifact bow equip"
				if(Result2 == "Corrupted")
					if(Wep.name == "LongSword")
						Wep.icon_state = "Corrupted sword"
						Wep.CarryState = "Corrupted sword"
						Wep.EquipState = "Corrupted sword equip"
					if(Wep.name == "BroadSword")
						Wep.icon_state = "Corrupted broadsword"
						Wep.CarryState = "Corrupted broadsword"
						Wep.EquipState = "Corrupted broadsword equip"
					if(Wep.name == "BattleAxe")
						Wep.icon_state = "Corrupted axe"
						Wep.CarryState = "Corrupted axe"
						Wep.EquipState = "Corrupted axe equip"
					if(Wep.name == "Mace")
						Wep.icon_state = "Corrupted mace2"
						Wep.CarryState = "Corrupted mace2"
						Wep.EquipState = "Corrupted mace2 equip"
					if(Wep.name == "Maul")
						Wep.icon_state = "Corrupted maul"
						Wep.CarryState = "Corrupted maul"
						Wep.EquipState = "Corrupted maul equip"
					if(Wep.name == "Spear")
						Wep.icon_state = "Corrupted spear"
						Wep.CarryState = "Corrupted spear"
						Wep.EquipState = "Corrupted spear equip"
					if(Wep.name == "Dagger")
						Wep.icon_state = "Corrupted dagger"
						Wep.CarryState = "Corrupted dagger"
						Wep.EquipState = "Corrupted dagger equip"
					if(Wep.name == "Bow")
						Wep.icon_state = "Corrupted bow"
						Wep.CarryState = "Corrupted bow"
						Wep.EquipState = "Corrupted bow equip"
				var/WepName=input(src,"Name your weapon.")as text
				Wep.name = WepName
				src << "<font color = teal>You have been granted the rank of King/Queen, it is your duty to unite your Race under your banner and keep Order, or Choas, within your lands. Lead your Race to glory and create allies with the other Races, or become an Evil Tyrant and crush all that stand in your way. You will need to be fairly Active with this Rank and also Interact with others often. You can choose someone you deem worthy of being a good role player, intelligent, and active to be your spouse, and can also Appoint your own Diplomat and Blacksmith, but you must let an Admin know so they can grant the Player the Rank. As a King/Queen, you will live an extra Ten(10) years longer than anyone else of your race, depending on what your Die Age was orginally. You have been granted a Crown and Weapon, do not give either to anyone at any cost. All of your Race that make a character -After- you are crowned know your name and appearance ICly. You are aware of the Diplomat and BlackSmiths of your race ICly as soon as they recive their Ranks.<br>"
			if(Rank == "BlackSmith")
				src.SmeltingSkill += 10
				src.ForgingSkill += 10
				src.MiningSkill += 10
				src.SmeltingSkillMulti += 0.1
				src.ForgingSkillMulti += 0.1
				src.MiningSkillMulti += 0.1
				src.Strength += 5
				src.Agility += 5
				src.Endurance += 5
				src.SkillCap += 5
				src.StrCap += 5
				src.AgilCap += 5
				src.EndCap += 5
				src.WeightMax += 100
				src.CreateList = null
				src.CreateList = list()
				var/obj/Items/Weapons/Blunts/Hammer/H = new
				H.Material = "Iron"
				H.RandomItemQuality()
				src.Weight += H.Weight
				H.Move(src)
				H.suffix = "Carried"
				H.overlays += image(/obj/HUD/C/)
				H.icon_state = H.CarryState

				var/obj/Items/Weapons/Blunts/Shovel/S = new
				S.Material = "Iron"
				S.RandomItemQuality()
				S.Move(src)
				src.Weight += S.Weight
				S.suffix = "Carried"
				S.overlays += image(/obj/HUD/C/)
				S.icon_state = S.CarryState

				var/obj/Items/Weapons/Axes/Hatchet/Ax = new
				Ax.Material = "Iron"
				Ax.RandomItemQuality()
				Ax.Move(src)
				src.Weight += Ax.Weight
				Ax.suffix = "Carried"
				Ax.overlays += image(/obj/HUD/C/)
				Ax.icon_state = Ax.CarryState

				var/obj/Items/Weapons/Axes/PickAxe/P = new
				P.Material = "Iron"
				P.RandomItemQuality()
				P.Move(src)
				src.Weight += P.Weight
				P.suffix = "Carried"
				P.overlays += image(/obj/HUD/C/)
				P.icon_state = P.CarryState

				var/obj/Items/Weapons/Swords/Saw/Sa = new
				Sa.Material = "Iron"
				Sa.RandomItemQuality()
				Sa.Move(src)
				src.Weight += Sa.Weight
				Sa.suffix = "Carried"
				Sa.overlays += image(/obj/HUD/C/)
				Sa.icon_state = Sa.CarryState
				var/Swords = list()
				Swords += typesof(/obj/Items/Weapons/Swords/)
				for(var/O in Swords)
					var/obj/I = new O()
					if(I.CanBeCrafted)
						var/Mat = list("Iron","Copper","Silver")
						for(var/M in Mat)
							var/obj/A = new I.type()
							A.CarryState = "[M] [I.icon_state]"
							A.EquipState = "[M] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = M
							src.CreateList += A

					else
						del(I)
				var/Axes = list()
				Axes += typesof(/obj/Items/Weapons/Axes/)
				for(var/O in Axes)
					var/obj/I = new O()
					if(I.CanBeCrafted)
						var/Mat = list("Iron","Copper","Silver")
						for(var/M in Mat)
							var/obj/A = new I.type()
							A.CarryState = "[M] [I.icon_state]"
							A.EquipState = "[M] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = M
							src.CreateList += A

					else
						del(I)
				var/Spears = list()
				Spears += typesof(/obj/Items/Weapons/Spears/)
				for(var/O in Spears)
					var/obj/I = new O()
					if(I.CanBeCrafted)
						var/Mat = list("Iron","Copper","Silver")
						for(var/M in Mat)
							var/obj/A = new I.type()
							A.CarryState = "[M] [I.icon_state]"
							A.EquipState = "[M] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = M
							src.CreateList += A

					else
						del(I)
				var/Blunts = list()
				Blunts += typesof(/obj/Items/Weapons/Blunts/)
				for(var/O in Blunts)
					var/obj/I = new O()
					if(I.CanBeCrafted)
						var/Mat = list("Iron","Copper","Silver")
						for(var/M in Mat)
							var/obj/A = new I.type()
							A.CarryState = "[M] [I.icon_state]"
							A.EquipState = "[M] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = M
							src.CreateList += A

					else
						del(I)
				var/Ranged = list()
				Ranged += typesof(/obj/Items/Weapons/Ranged/)
				for(var/O in Ranged)
					var/obj/I = new O()
					if(I.CanBeCrafted)
						var/Mat = list("Iron","Copper","Silver")
						for(var/M in Mat)
							var/obj/A = new I.type()
							A.CarryState = "[M] [I.icon_state]"
							A.EquipState = "[M] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = M
							src.CreateList += A

					else
						del(I)
				var/Daggers = list()
				Daggers += typesof(/obj/Items/Weapons/Daggers/)
				for(var/O in Daggers)
					var/obj/I = new O()
					if(I.CanBeCrafted)
						var/Mat = list("Iron","Copper","Silver")
						for(var/M in Mat)
							var/obj/A = new I.type()
							A.CarryState = "[M] [I.icon_state]"
							A.EquipState = "[M] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = M
							src.CreateList += A

					else
						del(I)

				var/UpperBody = list()
				UpperBody += typesof(/obj/Items/Armour/UpperBody/)
				for(var/O in UpperBody)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/Shoulders = list()
				Shoulders += typesof(/obj/Items/Armour/Shoulders/)
				for(var/O in Shoulders)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/Shields = list()
				Shields += typesof(/obj/Items/Armour/Shields/)
				for(var/O in Shields)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.icon_state] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/Legs = list()
				Legs += typesof(/obj/Items/Armour/Legs/)
				for(var/O in Legs)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.EquipState] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/Chest = list()
				Chest += typesof(/obj/Items/Armour/Chest/)
				for(var/O in Chest)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.EquipState] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/Head = list()
				Head += typesof(/obj/Items/Armour/Head/)
				for(var/O in Head)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.EquipState] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/LeftArm = list()
				LeftArm += typesof(/obj/Items/Armour/LeftArm/)
				for(var/O in LeftArm)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.EquipState] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/RightArm = list()
				RightArm += typesof(/obj/Items/Armour/RightArm/)
				for(var/O in RightArm)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.EquipState] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/LeftFoot = list()
				LeftFoot += typesof(/obj/Items/Armour/LeftFoot/)
				for(var/O in LeftFoot)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.EquipState] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				var/RightFoot = list()
				RightFoot += typesof(/obj/Items/Armour/RightFoot/)
				for(var/O in RightFoot)
					var/obj/I = new O()
					if(I.CanBeCrafted && I.BaseMaterial == "Metal")
						var/Make = 3
						var/Mat = "Iron"
						while(Make)
							Make -= 1
							if(Make == 0)
								Mat = "Copper"
							if(Make == 1)
								Mat = "Gold"
							var/obj/A = new I.type()
							A.Material = I.Material
							A.CarryState = "[Mat] [I.icon_state]"
							A.EquipState = "[Mat] [I.EquipState] equip"
							A.icon_state = A.CarryState
							A.layer = 100
							A.Material = Mat
							src.CreateList += A

					else
						del(I)
				src << "<font color = teal>You have been granted the Rank of Black Smith, you will have the knowledge to craft any and all Designs for Armour and Weapons. You are currently in the service of your Kingdoms King and/or Queen but you may Role Play in any direction, so long as it makes sense. No one knows you are a Black Smith currently, except for the King and/or Queen of your Kingdom. You have also been granted a bonus to your blacksmithing skills and +5 to your strength. You also have +100 carrying Weight.<br>"