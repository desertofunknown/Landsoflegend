atom
	proc
		LimbLoss()
			if(src.LeftArm == 0)
				src.icon_state = "NoLA"
			if(src.RightArm == 0)
				src.icon_state = "NoRA"
			if(src.RightArm == 0)
				if(src.LeftArm == 0)
					src.icon_state = "NoArms"
			if(src.LeftLeg == 0)
				src.icon_state = "NoLL"
			if(src.RightLeg == 0)
				src.icon_state = "NoRL"
			if(src.RightLeg == 0)
				if(src.LeftLeg == 0)
					src.icon_state = "NoLegs"
			if(src.RightArm == 0)
				if(src.RightLeg == 0)
					src.icon_state = "NoRARL"
			if(src.LeftArm == 0)
				if(src.LeftLeg == 0)
					src.icon_state = "NoLALL"
			if(src.LeftArm == 0)
				if(src.RightLeg == 0)
					src.icon_state = "NoLARL"
			if(src.RightArm == 0)
				if(src.LeftLeg == 0)
					src.icon_state = "NoRALL"
			if(src.LeftLeg == 0)
				if(src.RightLeg == 0)
					if(src.LeftArm == 0)
						src.icon_state = "NoLegsNoLA"
			if(src.LeftLeg == 0)
				if(src.RightLeg == 0)
					if(src.RightArm == 0)
						src.icon_state = "NoLegsNoRA"
			if(src.LeftArm == 0)
				if(src.RightArm == 0)
					if(src.LeftLeg == 0)
						src.icon_state = "NoArmsNoLL"
			if(src.LeftArm == 0)
				if(src.RightArm == 0)
					if(src.RightLeg == 0)
						src.icon_state = "NoArmsNoRL"
			if(src.LeftArm == 0)
				if(src.RightArm == 0)
					if(src.LeftLeg == 0)
						if(src.RightLeg == 0)
							src.icon_state = "None"
			if(src.RightLeg)
				if(src.LeftLeg)
					if(src.LeftArm)
						if(src.RightArm)
							src.icon_state = "N"
mob
	proc
		KnockBack(var/Dis,var/DIR)
			if(Dis >= 0 && src.Job == "KnockedBack" && src.Dead == 0)
				Dis -= 1
				var/LOC = src.loc
				step(src,DIR)
				if(src.BloodMax && src.Blood <= src.BloodMax / 2)
					var/obj/Misc/Gore/BloodTrail/T = new
					T.dir = src.dir
					T.Move(src)
				for(var/atom/a in range(0,src))
					if(a.density && a != src)
						view(src) << "<font color = red>[src] slams into [a]!<br>"
						src.Pain += rand(15,25)
						if(src.Weapon)
							var/Drop = prob(100 - src.Agility * 1.5)
							if(Drop)
								var/obj/I = src.Weapon
								view(src) << "<font color = red>[src] loses hold of their [I]!<br>"
								src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
								I.Move(src)
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
							var/Drop = prob(100 - src.Agility * 1.5)
							if(Drop)
								var/obj/I = src.Weapon2
								view(src) << "<font color = red>[src] loses hold of their [I]!<br>"
								src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
								src.overlays-=image(I.icon,"[I.icon_state] left",I.ItemLayer)
								I.Move(src)
								I.overlays = null
								I.suffix = null
								I.icon_state = I.CarryState
								src.Weight -= I.Weight
								src.Weapon2 = null
								if(src.client)
									src.client.screen -= I
								if(I.Delete)
									del(I)
						if(ismob(a))
							var/mob/M = a
							M.Pain += rand(15,25)
							if(M.Fainted == 0)
								M.Stunned = 1
								M.CanMove = 0
								M.Stun()
								view(6,M) << "<font color=red>[M] has been stunned!<br>"
						Dis = 0
						src.Move(LOC)
						if(src.Dead == 0)
							src.density = 1
						if(src.Job == "KnockedBack")
							src.Job = null
						return
				spawn(1)
					if(src)
						src.KnockBack(Dis,DIR)
			else
				if(src.Dead == 0)
					src.density = 1
				if(src.Job == "KnockedBack")
					src.Job = null
				return
		Stun()
			spawn(rand(50,150))
				if(src)
					if(src.Stunned)
						src.Stunned = 0
						view(src) << "<font color=green>[src] is no longer stunned!<br>"
						if(src.Fainted == 0)
							var/Legs = 1
							if(src.RightLeg == 0)
								if(src.LeftLeg == 0)
									Legs = 0
							if(Legs)
								if(src.Sleeping == 0)
									if(src.Job == null)
										src.CanMove = 1
									if(src.Job == "KnockedBack")
										src.CanMove = 1
		Fainted()
			spawn(rand(500,1000))
				if(src)
					if(src.Fainted)
						src.Fainted = 0
						src.Pain = 0
						view(src) << "<font color=green>[src] wakes up!<br>"
						if(src.Stunned == 0)
							var/Legs = 1
							if(src.RightLeg == 0)
								if(src.LeftLeg == 0)
									Legs = 0
							if(Legs)
								if(src.Sleeping == 0)
									if(src.Job == null)
										src.CanMove = 1
									if(src.Job == "KnockedBack")
										src.CanMove = 1
		RemoveCombatOverlays()
			src.overlays -= /obj/Misc/CombatOverlays/Block/
			src.overlays -= /obj/Misc/CombatOverlays/Dodge/
			src.overlays -= /obj/Misc/CombatOverlays/Head/
			src.overlays -= /obj/Misc/CombatOverlays/LeftArm/
			src.overlays -= /obj/Misc/CombatOverlays/RightArm/
			src.overlays -= /obj/Misc/CombatOverlays/LeftLeg/
			src.overlays -= /obj/Misc/CombatOverlays/RightLeg/
			src.overlays -= /obj/Misc/CombatOverlays/Torso/
			src.overlays -= /obj/Misc/CombatOverlays/Hit/
			if(src.RightArm <= 0)
				src.RightArm = 0
			if(src.LeftArm <= 0)
				src.LeftArm = 0
			if(src.LeftLeg <= 0)
				src.LeftLeg = 0
			if(src.RightLeg <=0)
				src.RightLeg = 0
		Splat()
			if(src.BloodMax >= 1)
				for(var/turf/Walls/W in range(1,src))
					var/Splat = prob(10)
					if(Splat)
						if(src.BloodColour)
							var/obj/BS = new src.BloodWallColour()
							BS.Move(locate(W.x,W.y,W.z))
				for(var/turf/Floors/F in range(0,src))
					if(F.Type != "Water")
						var/Splat = prob(10)
						if(Splat)
							if(src.BloodColour)
								var/obj/BS = new src.BloodColour()
								BS.Move(locate(F.x,F.y,F.z))
		ArrowDamage(var/DMG,var/obj/A)
			if(src.Humanoid)
				var/HLeftArm = 0
				var/HRightArm = 0
				var/HLeftLeg = 0
				var/HRightLeg = 0
				var/HHead = 0
				var/HTorso = 0
				var/Hits = rand(1,6)
				if(Hits == 1)
					HLeftArm = 1
				if(Hits == 2)
					HRightArm = 1
				if(Hits == 3)
					if(src.Race != "Snakeman")
						HLeftLeg = 1
					else
						Hits = 5
				if(Hits == 4)
					if(src.Race != "Snakeman")
						HRightLeg = 1
					else
						Hits = 5
				if(Hits == 5)
					HTorso = 1
				if(Hits == 6)
					HHead = 1
				if(src.LeftArm == 0)
					HLeftArm = 0
				if(src.RightArm == 0)
					HRightArm = 0
				if(src.LeftLeg == 0)
					HLeftLeg = 0
				if(src.RightLeg == 0)
					HRightLeg = 0
				if(src.Race == "Illithid" && src.Sleep >= 1 && src.Sleeping == 0 && src.Fainted == 0)
					src.overlays += /obj/Misc/SpellEffects/AstralShield
					view(6,src) << "<font color=purple>[src]'s mind deflects the [A]!<br>"
					src.Sleep -= DMG / 1.5
					DMG = 0
					if(src.Sleep <= 0)
						src.Sleep = 0
					spawn(10)
						if(src)
							src.overlays -= /obj/Misc/SpellEffects/AstralShield
				if(HTorso)
					var/GetsStuck = 0
					var/ArmourOpening = 0
					var/GetsThrough = 100
					var/Through = 0
					src.overlays += /obj/Misc/CombatOverlays/Torso/
					spawn(5)
						if(src)
							src.overlays -= /obj/Misc/CombatOverlays/Torso/
					if(src.WChest)
						var/obj/I = src.WChest
						if(I.DefenceType == "Plate")
							GetsStuck = prob(5)
						if(I.Defence == "Chain")
							GetsStuck = prob(25)
						if(I.Defence != "Chain" && I.Defence != "Plate")
							GetsStuck = 100
						DMG -= src.Endurance / 5
						if(DMG >= 0)
							I.Dura -= DMG / 10
							src.CheckArmourDura()
						if(I.DefenceType == "Plate")
							GetsThrough -= 65
							if(ArmourOpening == 0)
								ArmourOpening = prob(10 - I.Dura / 10)
						if(I.DefenceType == "Chain")
							GetsThrough -= 33
						if(I.DefenceType == "Leather")
							GetsThrough -= 10
						if(ArmourOpening == 0)
							DMG -= I.Defence
						if(ArmourOpening)
							DMG -= I.Defence / 2
							ArmourOpening = 0
					if(src.WUpperBody)
						var/obj/I = src.WUpperBody
						if(I.DefenceType == "Plate")
							GetsStuck = prob(5)
						if(I.Defence == "Chain")
							GetsStuck = prob(25)
						if(I.Defence != "Chain" && I.Defence != "Plate")
							GetsStuck = 100
						DMG -= src.Endurance / 5
						if(DMG >= 0)
							I.Dura -= DMG / 10
							src.CheckArmourDura()
						if(I.DefenceType == "Plate")
							GetsThrough -= 65
							if(ArmourOpening == 0)
								ArmourOpening = prob(10 - I.Dura / 10)
						if(I.DefenceType == "Chain")
							GetsThrough -= 33
						if(I.DefenceType == "Leather")
							GetsThrough -= 10
						if(ArmourOpening == 0)
							DMG -= I.Defence
						if(ArmourOpening)
							DMG -= I.Defence / 2
							ArmourOpening = 0
					if(src.WShoulders)
						var/obj/I = src.WShoulders
						if(I.DefenceType == "Plate")
							GetsStuck = prob(5)
						if(I.Defence == "Chain")
							GetsStuck = prob(25)
						if(I.Defence != "Chain" && I.Defence != "Plate")
							GetsStuck = 100
						DMG -= src.Endurance / 5
						if(DMG >= 0)
							I.Dura -= DMG / 10
							src.CheckArmourDura()
						if(I.DefenceType == "Plate")
							GetsThrough -= 65
							if(ArmourOpening == 0)
								ArmourOpening = prob(10 - I.Dura / 10)
						if(I.DefenceType == "Chain")
							GetsThrough -= 33
						if(I.DefenceType == "Leather")
							GetsThrough -= 10
						if(ArmourOpening == 0)
							DMG -= I.Defence
						if(ArmourOpening)
							DMG -= I.Defence / 2
							ArmourOpening = 0
					Through = prob(GetsThrough)
					if(Through == 0)
						view(src) << "<font color = red>[A] breaks on [src]'s Armour!<br>"
						del(A)
					if(DMG >= 0 && Through)
						var/HHeart = prob(15)
						var/HLeftLung = prob(15)
						var/HRightLung =prob(15)
						var/HStomach = prob(15)
						var/HIntestines = prob(15)
						var/HSpleen = prob(15)
						var/HLeftKidney = prob(15)
						var/HRightKidney = prob(15)
						var/HLiver = prob(15)
						src.Blood -= DMG / 1.5
						src.Pain += rand(DMG / 3, DMG / 2)
						src.Bleed()
						var/StunChance = 25
						StunChance -= src.Endurance / 6
						StunChance -= src.CurrentSkillLevel / 6
						if(StunChance <= 5)
							StunChance = 5
						var/Stunned = prob(StunChance)
						if(Stunned && src.Faction != "Undead")
							if(src.Stunned == 0 && src.Fainted == 0)
								src.Stunned = 1
								src.Pull = null
								src.CanMove = 0
								src.Stun()
								view(src) << "<font color=red>[src] has been stunned!<br>"
						if(HLiver)
							if(src.Liver)
								src.Liver -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Liver!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 33
								if(src.Liver <= 1 && src.Liver != 0)
									src.Liver = 0
									view(src) << "<font color = purple>[src]'s Liver has been pierced, it violently spasms then explodes through the wound in a spray of blood and goo!!<br>"
						if(HRightKidney)
							if(src.RightKidney)
								src.RightKidney -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Right Kidney!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 33
								if(src.RightKidney <= 1 && src.RightKidney != 0)
									src.RightKidney = 0
									view(src) << "<font color = purple>[src]'s RightKidney has been pierced, it violently spasms and shrinks into a mush as blood explodes from the wound!!<br>"
									if(src.LeftKidney <= 1 && src.LeftKidney != 0)
										view(src) << "<font color = purple>[src]'s Kidneys have failed! They die a slow painful death!<br>"
										src.Death()
										return
						if(HLeftKidney)
							if(src.LeftKidney)
								src.LeftKidney -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Left Kidney!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 33
								if(src.LeftKidney <= 1 && src.LeftKidney != 0)
									src.LeftKidney = 0
									view(src) << "<font color = purple>[src]'s LeftKidney has been pierced, it violently spasms and shrinks into a mush as blood explodes from the wound!!<br>"
									if(src.RightKidney <= 1 && src.RightKidney != 0)
										view(src) << "<font color = purple>[src]'s Kidneys have failed! They die a slow painful death!<br>"
										src.Death()
										return
						if(HSpleen)
							if(src.Spleen)
								src.Spleen -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Spleen!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 33
								if(src.Spleen <= 1 && src.Spleen != 0)
									src.Spleen = 0
									view(src) << "<font color = purple>[src]'s Spleen has been pierced, it violently spasms before pulsating blood everywhere from the wound!!<br>"
						if(HIntestines)
							if(src.Intestine)
								src.Intestine -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Intestines!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 20
								var/Puke = prob(20)
								if(Puke)
									var/obj/Misc/Gore/Puke/P = new
									P.Move(src.loc)
									view(src) << "<font color=green>[src] pukes!<br>"
								if(src.Intestine <= 1 && src.Intestine != 0)
									src.Intestine = 0
									view(src) << "<font color = purple>[src]'s Intestines has been pierced, it violently spasms before gushing with disgusting liquids!<br>"
						if(HStomach)
							if(src.Stomach)
								src.Stomach -= DMG
								src.AddGore("Torso",src.Race)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Stomach!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 20
								src.Pain += rand(DMG / 4, DMG / 3)
								var/Puke = prob(20)
								if(Puke)
									var/obj/Misc/Gore/Puke/P = new
									P.Move(src.loc)
									view(src) << "<font color=green>[src] pukes!<br>"
								if(src.Stomach <= 1 && src.Stomach != 0)
									src.Stomach = 0
									view(src) << "<font color = purple>[src]'s Stomach has been pierced, it violently spasms before gushing with disgusting liquids!<br>"
						if(HRightLung)
							if(src.RightLung)
								src.RightLung -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Right Lung!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 50
									src.Blood -= DMG / 4
									src.Bleed()
								if(src.RightLung <= 1 && src.RightLung != 0)
									src.RightLung = 0
									view(src) << "<font color = purple>[src]'s RightLung has been pierced, it violently spasms before collapsing!<br>"
									if(src.LeftLung == 0)
										spawn(300)
											if(src)
												if(src.Dead == 0 && src.Faction != "Undead")
													view(src) << "<font color =purple>[src]'s Lungs have collapsed, they die slowly!<br>"
													src.Death()
													return
						if(HLeftLung)
							if(src.LeftLung)
								src.LeftLung -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Left Lung!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 50
									src.Blood -= DMG / 4
									src.Bleed()
								if(src.LeftLung <= 1 && src.LeftLung != 0)
									src.LeftLung = 0
									view(src) << "<font color = purple>[src]'s LeftLung has been pierced, it violently spasms before collapsing!<br>"
									if(src.RightLung == 0)
										spawn(300)
											if(src)
												if(src.Dead == 0 && src.Faction != "Undead")
													view(src) << "<font color =purple>[src]'s Lungs have collapsed, they die slowly!<br>"
													src.Death()
													return
						if(HHeart)
							if(src.Heart)
								src.Heart -= DMG
								src.AddGore("Torso",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Heart!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 100
									src.Blood -= DMG
									src.Bleed()
								if(src.Heart <= 1 && src.Heart != 0)
									src.Heart = 0
									if(src.Faction != "Undead")
										view(src) << "<font color = purple>[src]'s Heart has been pierced through the middle [src] dies instantly!<br>"
										src.Death()
									return

				if(HHead)
					var/GetsStuck = 0
					var/ArmourOpening = 0
					var/GetsThrough = 100
					var/Through = 0
					src.overlays += /obj/Misc/CombatOverlays/Head/
					spawn(5)
						if(src)
							src.overlays -= /obj/Misc/CombatOverlays/Head/
					if(src.WHead)
						var/obj/I = src.WHead
						if(I.DefenceType == "Plate")
							GetsStuck = prob(5)
						if(I.Defence == "Chain")
							GetsStuck = prob(25)
						if(I.Defence != "Chain" && I.Defence != "Plate")
							GetsStuck = 100
						DMG -= src.Endurance / 5
						if(DMG >= 0)
							I.Dura -= DMG / 10
							src.CheckArmourDura()
						if(I.DefenceType == "Plate")
							GetsThrough -= 65
							if(ArmourOpening == 0)
								ArmourOpening = prob(10 - I.Dura / 10)
						if(I.DefenceType == "Chain")
							GetsThrough -= 33
						if(I.DefenceType == "Leather")
							GetsThrough -= 10
						if(ArmourOpening == 0)
							DMG -= I.Defence
						if(ArmourOpening)
							DMG -= I.Defence / 2
							ArmourOpening = 0
					Through = prob(GetsThrough)
					if(DMG >= 0 && Through)
						var/HSkull = prob(20)
						var/HBrain = prob(10)
						var/HThroat = prob(15)
						var/HLeftEye = prob(15)
						var/HRightEye = prob(15)
						var/HNose =prob(15)
						var/HLeftEar = prob(15)
						var/HRightEar = prob(15)
						var/StunChance = 25
						StunChance -= src.Endurance / 6
						StunChance -= src.CurrentSkillLevel / 6
						if(StunChance <= 5)
							StunChance = 5
						var/Stunned = prob(StunChance)
						if(Stunned && src.Faction != "Undead")
							if(src.Stunned == 0 && src.Fainted == 0)
								src.Stunned = 1
								src.Pull = null
								src.CanMove = 0
								src.Stun()
								view(src) << "<font color=red>[src] has been stunned!<br>"
						if(src.Faction == "Undead" && HBrain != 0)
							HBrain = prob(20)
						if(src.Faction == "Undead" && HSkull != 0)
							HSkull = prob(30)
						src.Blood -= DMG / 1.5
						src.Bleed()
						if(HBrain)
							if(src.Brain && src.Skull)
								var/GetsThroughSkull = prob(100 - src.Skull)
								if(GetsThroughSkull)
									src.Brain -= DMG
									src.AddGore("Head",src.Race)
									Pain += DMG / 2
									if(src.WHead == null)
										var/KO = prob(15)
										if(KO)
											view(src) << "<font color=red>The [A] smashes into [src]'s skull and knocks them out!<br>"
											src.Fainted = 1
											src.CanMove = 0
											src.Pull = null
											src.Fainted()
									if(GetsStuck)
										view(src) << "<font color = red>[A] becomes lodged in [src]'s Brain!<br>"
										A.suffix = "StuckIn"
										A.Move(src)
										A.overlays += image(/obj/HUD/C/)
										src.Weight += A.Weight
										GetsStuck = 0
										A.Type = 100
										src.Blood -= DMG
										src.Bleed()
									if(src.Brain <= 20 && src.Brain != 0)
										src.Brain = 0
										view(src) << "<font color = purple>[src]'s skull has been cracked open by an arrow, their brain becomes horrificly damaged and they die instantly!<br>"
										src.Death()
										return
						if(HThroat)
							if(src.Throat)
								src.Throat -= DMG
								src.AddGore("Head",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Throat!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 75
									src.Blood -= DMG / 3
									src.Bleed()
								if(src.Throat <= 1 && src.Throat != 0)
									src.Throat = 0
									if(src.Faction != "Undead")
										view(src) << "<font color = purple>An arrow flies into [src]'s Throat, blood begins to gush from the wound as they slowy fall to the floor dieng almost instantly!<br>"
										src.Death()
										return
						if(HSkull)
							if(src.Skull)
								src.Skull -= DMG
								src.AddGore("Head",src.Race)
								Pain += DMG / 2
								if(src.WHead == null)
									var/KO = prob(10)
									if(KO)
										view(src) << "<font color=red>The [A] smashes into [src]'s skull and knocks them out!<br>"
										src.Fainted = 1
										src.CanMove = 0
										src.Pull = null
										src.Fainted()
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Skull!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 33
									src.Blood -= DMG / 4
									src.Bleed()
								if(src.Skull <= 1 && src.Skull != 0)
									src.Skull = 10
									src.Brain -= 50
									if(src.Brain <= 20)
										src.Brain = 0
										view(src) << "<font color = purple>[src]'s skull has been cracked open by an arrow, their brain becomes horrificly damaged and they die instantly!<br>"
										src.Death()
										return
						if(HNose)
							if(src.Nose)
								src.Nose -= DMG
								src.AddGore("Head",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Nose!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 15
								if(src.Nose <= 1 && src.Nose != 0)
									src.Nose = 10
						if(HRightEar)
							if(src.RightEar)
								src.RightEar -= DMG
								src.AddGore("Head",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Right Ear!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 10
								if(src.RightEar <= 1 && src.RightEar != 0)
									src.RightEar = 10
						if(HLeftEar)
							if(src.LeftEar)
								src.LeftEar -= DMG
								src.AddGore("Head",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Left Ear!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 10
								if(src.LeftEar <= 1 && src.LeftEar != 0)
									src.LeftEar = 10
						if(HRightEye)
							if(src.RightEye)
								src.RightEye -= DMG
								src.AddGore("Head",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Right Eye!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 20
									src.Blood -= DMG / 4
									src.Bleed()
								if(src.RightEye <= 0)
									src.RightEye = 0
								if(src.LeftEye <= 1 && src.LeftEye != 0)
									src.LeftEye = 0
									src << "<font color=red>You go blind!!<br>"
									src.CanSee = 0
									src.ResetButtons()
									src.Function = null
						if(HLeftEye)
							if(src.LeftEye)
								src.LeftEye -= DMG
								src.AddGore("Head",src.Race)
								src.Pain += rand(DMG / 4, DMG / 3)
								if(GetsStuck)
									view(src) << "<font color = red>[A] becomes lodged in [src]'s Left Eye!<br>"
									A.suffix = "StuckIn"
									A.Move(src)
									A.overlays += image(/obj/HUD/C/)
									src.Weight += A.Weight
									GetsStuck = 0
									A.Type = 20
									src.Blood -= DMG / 4
									src.Bleed()
								if(src.LeftEye <= 0)
									src.LeftEye = 0
								if(src.RightEye <= 1 && src.RightEye != 0)
									src.RightEye = 0
									src << "<font color=red>You go blind!!<br>"
									src.CanSee = 0
									src.ResetButtons()
									src.Function = null
				if(HLeftArm)
					if(src.LeftArm)
						var/GetsStuck = 0
						var/ArmourOpening = 0
						var/GetsThrough = 100
						var/Through = 0
						src.overlays += /obj/Misc/CombatOverlays/LeftArm/
						spawn(5)
							if(src)
								src.overlays -= /obj/Misc/CombatOverlays/LeftArm/
						if(src.WShoulders)
							var/obj/I = src.WShoulders
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						if(src.WLeftHand)
							var/obj/I = src.WLeftHand
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						Through = prob(GetsThrough)
						if(DMG >= 0 && Through)
							if(GetsStuck)
								view(src) << "<font color = red>[A] becomes lodged in [src]'s Left Arm!<br>"
								A.suffix = "StuckIn"
								A.Move(src)
								A.overlays += image(/obj/HUD/C/)
								src.Weight += A.Weight
								GetsStuck = 0
								A.Type = 25
							src.Blood -= DMG / 1.5
							src.Bleed()
							src.LeftArm -= DMG
							src.AddGore("LeftArm",src.Race)
							src.Pain += rand(DMG / 4, DMG / 3)
							var/StunChance = 25
							StunChance -= src.Endurance / 6
							StunChance -= src.CurrentSkillLevel / 6
							if(StunChance <= 5)
								StunChance = 5
							var/Stunned = prob(StunChance)
							if(Stunned && src.Faction != "Undead")
								if(src.Stunned == 0 && src.Fainted == 0)
									src.Stunned = 1
									src.Pull = null
									src.CanMove = 0
									src.Stun()
									view(src) << "<font color=red>[src] has been stunned!<br>"
							if(src.LeftArm <= 0)
								src.LeftArm = 10
				if(HRightArm)
					if(src.RightArm)
						var/GetsStuck = 0
						var/ArmourOpening = 0
						var/GetsThrough = 100
						var/Through = 0
						src.overlays += /obj/Misc/CombatOverlays/RightArm/
						spawn(5)
							if(src)
								src.overlays -= /obj/Misc/CombatOverlays/RightArm/
						if(src.WShoulders)
							var/obj/I = src.WShoulders
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						if(src.WRightHand)
							var/obj/I = src.WRightHand
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						Through = prob(GetsThrough)
						if(DMG >= 0 && Through)
							if(GetsStuck)
								view(src) << "<font color = red>[A] becomes lodged in [src]'s Right Arm!<br>"
								A.suffix = "StuckIn"
								A.Move(src)
								A.overlays += image(/obj/HUD/C/)
								src.Weight += A.Weight
								GetsStuck = 0
								A.Type = 25
							src.Blood -= DMG / 1.5
							src.Bleed()
							src.RightArm -= DMG
							src.AddGore("RightArm",src.Race)
							src.Pain += rand(DMG / 4, DMG / 3)
							var/StunChance = 25
							StunChance -= src.Endurance / 6
							StunChance -= src.CurrentSkillLevel / 6
							if(StunChance <= 5)
								StunChance = 5
							var/Stunned = prob(StunChance)
							if(Stunned && src.Faction != "Undead")
								if(src.Stunned == 0 && src.Fainted == 0)
									src.Stunned = 1
									src.Pull = null
									src.CanMove = 0
									src.Stun()
									view(src) << "<font color=red>[src] has been stunned!<br>"
							if(src.RightArm <= 0)
								src.RightArm = 10
				if(HRightLeg)
					if(src.RightLeg)
						var/GetsStuck = 0
						var/ArmourOpening = 0
						var/GetsThrough = 100
						var/Through = 0
						src.overlays += /obj/Misc/CombatOverlays/RightLeg/
						spawn(5)
							if(src)
								src.overlays -= /obj/Misc/CombatOverlays/RightLeg/
						if(src.WLegs)
							var/obj/I = src.WLegs
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						if(src.WRightFoot)
							var/obj/I = src.WRightFoot
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						Through = prob(GetsThrough)
						if(DMG >= 0 && Through)
							if(GetsStuck)
								view(src) << "<font color = red>[A] becomes lodged in [src]'s Right Leg!<br>"
								A.suffix = "StuckIn"
								A.Move(src)
								A.overlays += image(/obj/HUD/C/)
								src.Weight += A.Weight
								GetsStuck = 0
								A.Type = 25
							src.Blood -= DMG / 1.5
							src.Bleed()
							src.RightLeg -= DMG
							src.AddGore("RightLeg",src.Race)
							src.Pain += rand(DMG / 4, DMG / 3)
							var/StunChance = 25
							StunChance -= src.Endurance / 6
							StunChance -= src.CurrentSkillLevel / 6
							if(StunChance <= 5)
								StunChance = 5
							var/Stunned = prob(StunChance)
							if(Stunned && src.Faction != "Undead")
								if(src.Stunned == 0 && src.Fainted == 0)
									src.Stunned = 1
									src.Pull = null
									src.CanMove = 0
									src.Stun()
									view(src) << "<font color=red>[src] has been stunned!<br>"
							if(src.RightLeg <= 0)
								src.RightLeg = 10
				if(HLeftLeg)
					if(src.LeftLeg)
						var/GetsStuck = 0
						var/ArmourOpening = 0
						var/GetsThrough = 100
						var/Through = 0
						src.overlays += /obj/Misc/CombatOverlays/LeftLeg/
						spawn(5)
							if(src)
								src.overlays -= /obj/Misc/CombatOverlays/LeftLeg/
						if(src.WLegs)
							var/obj/I = src.WLegs
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						if(src.WLeftFoot)
							var/obj/I = src.WLeftFoot
							if(I.DefenceType == "Plate")
								GetsStuck = prob(5)
							if(I.Defence == "Chain")
								GetsStuck = prob(25)
							if(I.Defence != "Chain" && I.Defence != "Plate")
								GetsStuck = 100
							DMG -= src.Endurance / 5
							if(DMG >= 0)
								I.Dura -= DMG / 10
								src.CheckArmourDura()
							if(I.DefenceType == "Plate")
								GetsThrough -= 65
								if(ArmourOpening == 0)
									ArmourOpening = prob(10 - I.Dura / 10)
							if(I.DefenceType == "Chain")
								GetsThrough -= 33
							if(I.DefenceType == "Leather")
								GetsThrough -= 10
							if(ArmourOpening == 0)
								DMG -= I.Defence
							if(ArmourOpening)
								DMG -= I.Defence / 2
								ArmourOpening = 0
						Through = prob(GetsThrough)
						if(DMG >= 0 && Through)
							if(GetsStuck)
								view(src) << "<font color = red>[A] becomes lodged in [src]'s Left Leg!<br>"
								A.suffix = "StuckIn"
								A.Move(src)
								A.overlays += image(/obj/HUD/C/)
								src.Weight += A.Weight
								GetsStuck = 0
								A.Type = 25
							src.Blood -= DMG / 1.5
							src.Bleed()
							src.LeftLeg -= DMG
							src.AddGore("LeftLeg",src.Race)
							src.Pain += rand(DMG / 4, DMG / 3)
							var/StunChance = 25
							StunChance -= src.Endurance / 6
							StunChance -= src.CurrentSkillLevel / 6
							if(StunChance <= 5)
								StunChance = 5
							var/Stunned = prob(StunChance)
							if(Stunned && src.Faction != "Undead")
								if(src.Stunned == 0 && src.Fainted == 0)
									src.Stunned = 1
									src.Pull = null
									src.CanMove = 0
									src.Stun()
									view(src) << "<font color=red>[src] has been stunned!<br>"
							if(src.LeftLeg <= 0)
								src.LeftLeg = 10
			else
				DMG -= src.Endurance
				if(DMG >= 0)
					src.Blood -= DMG / 1.5
					src.Bleed()
					src.HP -= DMG
					var/StunChance = 25
					StunChance -= src.Endurance / 6
					StunChance -= src.CurrentSkillLevel / 6
					if(StunChance <= 5)
						StunChance = 5
					var/Stunned = prob(StunChance)
					if(Stunned && src.Faction != "Undead")
						if(src.Stunned == 0 && src.Fainted == 0)
							src.Stunned = 1
							src.Pull = null
							src.CanMove = 0
							src.Stun()
							view(src) << "<font color=red>[src] has been stunned!<br>"
					if(src.HP <= 0)
						src.Death()
						return

		BloodFlow()
			if(src.Dead)
				return
			if(src.Pain >= 50)
				src.Pain = 50
			if(src.Fainted == 0)
				var/Faint = prob(src.Pain / 8)
				if(src.Type != "Egg")
					if(Faint)
						view(src) << "<font color=red>[src] loses consciousness due to pain!<br>"
						src.Fainted = 1
						src.CanMove = 0
						src.Pull = null
						src.Fainted()
			if(src.BloodMax >= 1)
				var/Die
				var/Drip = prob(15)
				var/Recover = prob(5)
				if(src.Bleed)
					if(Drip)
						if(src.BloodColour)
							var/obj/BS = new src.BloodColour()
							BS.Move(src.loc)
				if(src.Bleed == "Badly")
					Die = prob(1)
				if(src.Bleed == "Very Badly")
					Die = prob(4)
				if(src.Bleed == "Extremely Badly")
					Die = prob(7)
				if(src.Bleed == "Horrifically")
					Die = prob(10)
				if(src.Bleed)
					if(src.Bleed != src.BleedLast)
						if(src.BloodMax >= 1)
							view(src) << "<font color =red>[src] is bleeding [src.Bleed]!<br>"
							src.BleedLast = src.Bleed
				if(Die)
					view(src) << "<font color=red>[src] has bled to death!<br>"
					if(src.BloodColour == /obj/Misc/Gore/BloodSplat/)
						var/obj/BS = new src.BloodColour()
						BS.Move(src.loc)
						BS.icon_state = "floor puddle"
					src.Death()
				if(Recover)
					src.Blood += rand(10,20)
					src.Bleed()
					if(src.Blood >= src.BloodMax)
						src.Blood = src.BloodMax
						src.Bleed()
			else
				return
			spawn(30) BloodFlow()

		Bleed()
			if(src.BloodMax >= 1)
				if(src.Blood <= src.BloodMax / 4)
					src.Bleed = "Horrifically"
					return
				if(src.Blood <= src.BloodMax / 3)
					src.Bleed = "Extremely Badly"
					return
				if(src.Blood <= src.BloodMax / 2)
					src.Bleed = "Very Badly"
					return
				if(src.Blood <= src.BloodMax / 1.6)
					src.Bleed = "Badly"
					return
				if(src.Blood <= src.BloodMax / 1.1)
					src.Bleed = "Mildly"
					return
				if(src.Blood != src.BloodMax)
					src.Bleed = "Very Mildly"
					return
				if(src.Blood == src.BloodMax)
					src.Bleed = null
					return
		CheckArmourDura()
			if(src.WExtra)
				var/obj/I = src.WExtra
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WExtra = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.overlays-=image(/obj/HUD/E/)
						I.icon_state = I.CarryState
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WBack)
				var/obj/I = src.WBack
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WBack = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.overlays-=image(/obj/HUD/E/)
						I.icon_state = I.CarryState
						src << "<font color =red>Your [I] has been damaged badly!<br>"
						if(src.OrginalName)
							src.name = src.OrginalName
							src.OrginalName = null
						if(src.StoredFaction)
							src.Faction = src.StoredFaction
							src.StoredFaction = null
			if(src.WHead)
				var/obj/I = src.WHead
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WHead = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.overlays-=image(/obj/HUD/E/)
						I.icon_state = I.CarryState
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WUpperBody)
				var/obj/I = src.WUpperBody
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WUpperBody = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WLeftHand)
				var/obj/I = src.WLeftHand
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WLeftHand = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WRightHand)
				var/obj/I = src.WRightHand
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WRightHand = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WWaist)
				var/obj/I = src.WWaist
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WWaist = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WLeftFoot)
				var/obj/I = src.WLeftFoot
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WLeftFoot = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WRightFoot)
				var/obj/I = src.WLeftFoot
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WRightFoot = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WChest)
				var/obj/I = src.WChest
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WChest = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WLegs)
				var/obj/I = src.WLegs
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WLegs = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"
			if(src.WShoulders)
				var/obj/I = src.WShoulders
				if(I)
					if(I.Dura <= 0)
						I.Dura = 0
						src.WShoulders = null
						src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
						I.suffix = "Carried"
						I.icon_state = I.CarryState
						I.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [I] has been damaged badly!<br>"


		CheckWeaponDura(var/obj/W)
			if(W)
				if(W == src.Weapon)
					if(W.Dura <= 0)
						W.Dura = 0
						src.Weapon = null
						src.overlays-=image(W.icon,W.icon_state,W.ItemLayer)
						W.suffix = "Carried"
						W.icon_state = W.CarryState
						W.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [W] has been damaged badly!<br>"
					return
				if(W == src.Weapon2)
					if(W.Dura <= 0)
						W.Dura = 0
						src.Weapon2 = null
						src.overlays-=image(W.icon,"[W.icon_state]",W.ItemLayer)
						src.overlays-=image(W.icon,"[W.icon_state] left",W.ItemLayer)
						W.suffix = "Carried"
						W.icon_state = W.CarryState
						W.overlays-=image(/obj/HUD/E/)
						src << "<font color =red>Your [W] has been damaged badly!<br>"
					return
			else
				world << "Dura Check Error..."
				return
		CombatSkillTransfer(var/mob/Learner,var/Extra)
			if(Learner && Learner.Target == src)
				if(Learner in range(1,src))
					if(Extra == "Block" && Learner.ShieldSkill <= src.ShieldSkill / 2 && Learner.ShieldSkill <= Learner.SkillCap && Learner.ShieldSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.ShieldSkill += Learner.ShieldSkillMulti
						return
					if(src.CurrentSkill == "Sword" && Learner.SwordSkill <= src.SwordSkill / 2 && Learner.SwordSkill <= Learner.SkillCap && Learner.SwordSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.SwordSkill += Learner.SwordSkillMulti
					if(src.CurrentSkill == "Axe" && Learner.AxeSkill <= src.AxeSkill / 2 && Learner.AxeSkill <= Learner.SkillCap && Learner.AxeSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.AxeSkill += Learner.AxeSkillMulti
					if(src.CurrentSkill == "Spear" && Learner.SpearSkill <= src.SpearSkill / 2 && Learner.SpearSkill <= Learner.SkillCap && Learner.SpearSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.SpearSkill += Learner.SpearSkillMulti
					if(src.CurrentSkill == "Blunt" && Learner.BluntSkill <= src.BluntSkill / 2 && Learner.BluntSkill <= Learner.SkillCap && Learner.BluntSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.BluntSkill += Learner.BluntSkillMulti
					if(src.CurrentSkill == "Dagger" && Learner.DaggerSkill <= src.DaggerSkill / 2 && Learner.DaggerSkill <= Learner.SkillCap && Learner.DaggerSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.DaggerSkill += Learner.DaggerSkillMulti
					if(src.CurrentSkill == "Ranged" && Learner.RangedSkill <= src.RangedSkill / 2 && Learner.RangedSkill <= Learner.SkillCap && Learner.RangedSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.RangedSkill += Learner.RangedSkillMulti
					if(src.Weapon == null && Learner.UnarmedSkill <= src.UnarmedSkill / 2 && Learner.UnarmedSkill <= Learner.SkillCap && Learner.UnarmedSkill <= WorldSkillsCap)
						var/Gain = prob(10)
						if(Gain)
							Learner.UnarmedSkill += Learner.UnarmedSkillMulti
		GainStats(var/Divide,var/AddInt)
			var/GainStr = 22 + GainRate
			var/GainAgil = 22 + GainRate
			var/GainEnd = 22 + GainRate
			var/GainInt = 22 + GainRate
			var/RemoveStr = src.Strength / 2.5
			var/RemoveAgil = src.Agility /  2.5
			var/RemoveEnd = src.Endurance /  2.5
			var/RemoveInt = src.Intelligence /  2.5
			if(src.Weapon && src.Weapon2)
				var/obj/W1 = src.Weapon
				var/obj/W2 = src.Weapon2
				if(W1.ObjectTag == "Weapon" && W2.ObjectTag == "Weapon")
					RemoveStr = RemoveStr * 2
					RemoveAgil = RemoveAgil * 2
					RemoveEnd = RemoveEnd * 2
			GainStr = GainStr - RemoveStr
			GainAgil = GainAgil - RemoveAgil
			GainEnd = GainEnd - RemoveEnd
			GainInt = GainInt - RemoveInt
			if(GainStr <= 2)
				GainStr = 2
			if(GainAgil <= 2)
				GainAgil = 2
			if(GainEnd <= 2)
				GainEnd = 2
			if(GainInt <= 2)
				GainInt = 2
			var/GainsStr = prob(GainStr)
			var/GainsAgil = prob(GainAgil)
			var/GainsEnd = prob(GainEnd)
			var/GainsInt = prob(GainInt)
			if(GainsStr)
				if(src.Strength <= src.StrCap && src.Strength <= WorldStrCap && src.Strength <= src.StrengthMax)
					if(Divide)
						src.Strength += src.StrengthMulti / Divide
						src.WeightMax += rand(1,2)
					else
						src.Strength += src.StrengthMulti
						src.WeightMax += rand(2,3)
			if(GainsAgil)
				if(src.Agility <= src.AgilCap && src.Agility <= WorldAgilCap && src.Agility <= src.AgilityMax)
					if(Divide)
						src.Agility += src.AgilityMulti / Divide
					else
						src.Agility += src.AgilityMulti
			if(GainsEnd)
				if(src.Endurance <= src.EndCap && src.Endurance <= WorldEndCap && src.Endurance <= src.EnduranceMax)
					if(Divide)
						src.Endurance += src.EnduranceMulti / Divide
					else
						src.Endurance += src.EnduranceMulti
					if(src.BloodMax)
						src.BloodMax += rand(0.5,1)
			if(AddInt == "Yes")
				if(GainsInt)
					if(src.Intelligence <= src.IntCap && src.Intelligence <= WorldIntCap && src.Intelligence <= src.IntelligenceMax)
						if(Divide)
							src.Intelligence += src.IntelligenceMulti / Divide
						else
							src.Intelligence += src.IntelligenceMulti
		ApplyCombatSkills(var/obj/HasWep)
			if(HasWep)
				var/Dual = 0
				if(HasWep == src.Weapon && src.Weapon2)
					var/obj/Wep2 = src.Weapon2
					if(Wep2.ObjectTag == "Weapon")
						Dual = 1
				if(HasWep == src.Weapon2 && src.Weapon)
					var/obj/Wep = src.Weapon
					if(Wep.ObjectTag == "Weapon")
						Dual = 1
				if(Dual)
					Dual = 5
				if(HasWep.ObjectType == "Sword")
					var/Gain = 25 - src.SwordSkill / 3
					Gain -= Dual
					if(Gain <= 2)
						Gain = 2
					var/Gains = prob(Gain)
					if(Gains)
						if(src.SwordSkill <= src.SkillCap && src.SwordSkill <= WorldSkillsCap)
							src.SwordSkill += src.SwordSkillMulti
				if(HasWep.ObjectType == "Axe")
					var/Gain = 25 - src.AxeSkill / 3
					Gain -= Dual
					if(Gain <= 2)
						Gain = 2
					var/Gains = prob(Gain)
					if(Gains)
						if(src.AxeSkill <= src.SkillCap && src.AxeSkill <= WorldSkillsCap)
							src.AxeSkill += src.AxeSkillMulti
				if(HasWep.ObjectType == "Blunt")
					var/Gain = 25 - src.BluntSkill / 3
					Gain -= Dual
					if(Gain <= 2)
						Gain = 2
					var/Gains = prob(Gain)
					if(Gains)
						if(src.BluntSkill <= src.SkillCap && src.BluntSkill <= WorldSkillsCap)
							src.BluntSkill += src.BluntSkillMulti
				if(HasWep.ObjectType == "Dagger")
					var/Gain = 25 - src.DaggerSkill / 3
					Gain -= Dual
					if(Gain <= 2)
						Gain = 2
					var/Gains = prob(Gain)
					if(Gains)
						if(src.DaggerSkill <= src.SkillCap && src.DaggerSkill <= WorldSkillsCap)
							src.DaggerSkill += src.DaggerSkillMulti
				if(HasWep.ObjectType == "Spear")
					var/Gain = 25 - src.SpearSkill / 3
					Gain -= Dual
					if(Gain <= 2)
						Gain = 2
					var/Gains = prob(Gain)
					if(Gains)
						if(src.SpearSkill <= src.SkillCap && src.SpearSkill <= WorldSkillsCap)
							src.SpearSkill += src.SpearSkillMulti
				if(HasWep.ObjectType == "Ranged")
					var/Gain = 25 - src.BluntSkill / 3
					Gain -= Dual
					if(Gain <= 2)
						Gain = 2
					var/Gains = prob(Gain)
					if(Gains)
						if(src.BluntSkill <= src.SkillCap && src.BluntSkill <= WorldSkillsCap)
							src.BluntSkill += src.BluntSkillMulti
			else
				var/Gain = 25 - src.UnarmedSkill / 3
				if(Gain <= 2)
					Gain = 2
				var/Gains = prob(Gain)
				if(Gains)
					if(src.UnarmedSkill <= src.SkillCap && src.UnarmedSkill <= WorldSkillsCap)
						src.UnarmedSkill += src.UnarmedSkillMulti
		DetermineWeaponSkill(var/obj/Wep)
			if(Wep == null)
				if(src.Weapon == null && src.Weapon2)
					Wep = src.Weapon2
				if(src.Weapon && src.Weapon2 == null)
					Wep = src.Weapon
				if(src.Weapon && src.Weapon2)
					var/Weps = list()
					Weps += src.Weapon
					Weps += src.Weapon2
					for(var/obj/Z in Weps)
						if(Z.ObjectTag == "Weapon")
							Wep = Z
			if(Wep)
				if(Wep.ObjectType == "Sword")
					src.CurrentSkill = "Sword"
					src.CurrentSkillLevel = src.SwordSkill
				if(Wep.ObjectType == "Axe")
					src.CurrentSkill = "Axe"
					src.CurrentSkillLevel = src.AxeSkill
				if(Wep.ObjectType == "Blunt")
					src.CurrentSkill = "Blunt"
					src.CurrentSkillLevel = src.BluntSkill
				if(Wep.ObjectType == "Dagger")
					src.CurrentSkill = "Dagger"
					src.CurrentSkillLevel = src.DaggerSkill
				if(Wep.ObjectType == "Spear")
					src.CurrentSkill = "Spear"
					src.CurrentSkillLevel = src.SpearSkill
			else
				src.CurrentSkill = "Unarmed"
				src.CurrentSkillLevel = src.UnarmedSkill
		Attack()
			if(src.DisableAttack)
				return
			src.RemoveCombatOverlays()
			if(ismob(src.Target) && src.Target)
				var/mob/T = src.Target
				if(T.Dead)
					src.Target = null
					src << "Target lost!<br>"
					if(src.client)
						src.client.images -= T.TargetIcon
				if(T in range(1,src))
					var/SeeTarget = 1
					if(src.CanSee == 0)
						SeeTarget = 0
						var/HearTarget = prob(50)
						if(HearTarget)
							SeeTarget = 1
					if(SeeTarget)
						var/obj/Wep1 = null
						if(src.Weapon)
							Wep1 = src.Weapon
							if(Wep1.ObjectTag != "Weapon")
								Wep1 = null
						src.Combat(Wep1)
						if(src.Weapon && src.Weapon2)
							var/obj/W = src.Weapon
							var/obj/W2 = src.Weapon2
							if(W.ObjectTag == "Weapon")
								if(W2.ObjectTag == "Weapon")
									src.Combat(W2)
						if(src.Weapon == null && src.Weapon2)
							var/obj/W = src.Weapon2
							if(W.ObjectTag == "Weapon")
								src.Combat(W)
				if(src.Target == src)
					src.Target = null
			var/Delay
			Delay = 100 - src.Agility
			if(src.Weight >= src.WeightMax / 1.1)
				Delay += 10
			if(src.Weight >= src.WeightMax / 1.2)
				Delay += 10
			var/DelayMath = 0
			for(var/obj/Items/Armour/A in src)
				if(A.suffix == "Equip")
					DelayMath += A.Weight / 3
			if(src.Strength <= DelayMath)
				Delay += 10
			if(src.Weapon)
				var/obj/W = src.Weapon
				Delay = Delay + W.Weight * 2
			if(src.Weapon2)
				var/obj/W = src.Weapon2
				Delay = Delay + W.Weight * 2
			if(src.Sleep <= 10)
				Delay += 25
			if(src.Hunger <= 10)
				Delay += 25
			if(Delay <= 10)
				Delay = 10
			spawn(Delay) Attack()
		Combat(var/obj/MainWeapon)
			var/IsMob = 0
			if(src.Target)
				if(ismob(src.Target))
					IsMob = 1
			if(IsMob == 0)
				return
			if(src.Dead)
				return
			if(src.Fainted)
				return
			if(src.Stunned)
				return
			if(src.CanAttack == 0)
				return
			if(src.Humanoid)
				if(src.RightArm <= 25)
					if(src.LeftArm <= 25)
						return
			var/mob/T
			if(src.Target)
				T = src.Target
			var/Dir = get_dir(src,T)
			src.dir = Dir
			if(T)
				if(T.Target == null)
					var/IsClient = 0
					T.CallForHelp(src)
					if(T.client)
						IsClient = 1
					if(IsClient == 0)
						T.Target = src
			else
				return
			if(T.client)
				if(src.client)
					if(T.client.address == src.client.address && T != src)
						world << "<font color = teal><b>([usr.key])[usr] - [usr.OrginalName] was booted for Alt Key Interaction!<br>"
						del(src)
						return
			if(T.Sleeping)
				T.overlays -= /obj/Misc/Sleeping/
				T.Sleeping = 0
				view(src) << "<font color=red>[T] wakes up in shock!<br>"
				if(T.Fainted == 0)
					if(T.Stunned == 0)
						var/Legs = 1
						if(T.RightLeg == 0)
							if(T.LeftLeg == 0)
								Legs = 0
						if(Legs)
							T.CanMove = 1
			if(T.Job)
				T.Job = null
				if(T.client)
					view(src) << "<font color=red>[T] stops doing their task and turns to [src]!<br>"
				T.MovementCheck()
			var/Dodge = 0
			Dodge += T.Agility
			Dodge -= src.Agility / 1.3
			var/DodgeMath = 0
			for(var/obj/Items/Armour/A in T)
				if(A.suffix == "Equip")
					DodgeMath += A.Weight / 3
			if(T.Strength <= DodgeMath)
				Dodge -= DodgeMath
			if(Dodge >= 50)
				Dodge = 50
			if(Dodge <= 1)
				Dodge = 1
			var/Dodged = prob(Dodge)
			if(Dodged)
				if(T.Fainted == 0)
					if(T.Stunned == 0)
						T.overlays += /obj/Misc/CombatOverlays/Dodge/
						spawn(5)
							if(T)
								T.overlays -= /obj/Misc/CombatOverlays/Dodge/
						return

			src.DetermineWeaponSkill(MainWeapon)
			T.DetermineWeaponSkill()
			src.CombatSkillTransfer(T)

			var/Parry = 0
			Parry += T.Agility / 2
			Parry += T.CurrentSkillLevel
			Parry -= src.Agility / 2.5
			Parry -= src.CurrentSkillLevel / 1.5
			var/ParryMath = 0
			for(var/obj/Items/Armour/A in T)
				if(A.suffix == "Equip")
					ParryMath += A.Weight / 3
			if(T.Strength <= ParryMath)
				Parry -= ParryMath
			if(Parry >= 50)
				Parry = 50
			if(Parry <= 1)
				Parry = 0
			var/Parried = prob(Parry)
			if(Parried)
				if(src.Fainted == 0)
					if(src.Stunned == 0)
						T.overlays += /obj/Misc/CombatOverlays/Block/
						spawn(5)
							if(T)
								T.overlays -= /obj/Misc/CombatOverlays/Block/
						var/WeaponColide = 0
						var/obj/W = null
						if(MainWeapon)
							if(T.Weapon)
								WeaponColide = 1
								W = T.Weapon
						if(MainWeapon)
							if(T.Weapon2)
								WeaponColide = 1
								W = T.Weapon2
						if(WeaponColide)
							if(W && W.ObjectTag == "Weapon")
								W.Dura -= rand(1,2)
								MainWeapon.Dura -= rand(1,2)
								src.CheckWeaponDura(MainWeapon)
								T.CheckWeaponDura(W)
						return
			var/Damage
			var/StunChance
			StunChance += src.CurrentSkillLevel / 6
			StunChance -= T.Endurance / 6
			StunChance -= T.CurrentSkillLevel / 6
			if(StunChance >= 20)
				StunChance = 20
			if(T.Type == "Egg")
				StunChance = 0
			Damage = Damage + src.Strength / 4
			Damage = Damage + src.CurrentSkillLevel / 6
			if(src.Claws && src.Weapon == null && src.Weapon2 == null)
				Damage = Damage + src.Strength / 5
			if(MainWeapon)
				var/Noise = rand(1,8)
				if(Noise == 1)
					range(5) << 'Weapon1.wav'
				if(Noise == 2)
					range(5) << 'Weapon2.wav'
				if(Noise == 3)
					range(5) << 'Weapon3.wav'
				if(Noise == 4)
					range(5) << 'Weapon4.wav'
				if(Noise == 5)
					range(5) << 'Weapon5.wav'
				if(Noise == 6)
					range(5) << 'Weapon6.wav'
				if(Noise == 7)
					range(5) << 'Weapon7.wav'
				if(Noise == 8)
					range(5) << 'Weapon8.wav'
				Damage = Damage +  rand(MainWeapon.Quality / 2,MainWeapon.Quality)
				Damage = Damage + MainWeapon.Weight / 4
				var/Dual = 0
				if(MainWeapon == src.Weapon && src.Weapon2)
					Dual = 1
				if(MainWeapon == src.Weapon2 && src.Weapon)
					Dual = 1
				if(Dual == 0)
					if(src.LeftArm && MainWeapon.TwoHander)
						Damage = Damage + MainWeapon.Weight / 2
			else
				var/Noise = rand(1,2)
				if(Noise == 1)
					view(5) << 'Punch.wav'
				if(Noise == 2)
					view(5) << 'PunchHard.wav'
			Damage = Damage - T.Endurance / 5
			if(usr.SparMode && T.client)
				Damage = Damage / 4
			var/Block = 0
			if(T.Weapon)
				if(T.Type != "Torch" && T.Type != "Torch Lit")
					if(istype(T.Weapon,/obj/Items/Armour/Shields/))
						var/obj/S = T.Weapon
						Block += T.ShieldSkill
						Block += T.Agility / 2
						Block -= src.Agility
						Damage -= S.Defence / 4
						var/BlockMath = 0
						for(var/obj/Items/Armour/A in T)
							if(A.suffix == "Equip")
								BlockMath += A.Weight / 3
						if(T.Strength <= BlockMath)
							Block -= BlockMath
						if(Block >= 50)
							Block = 50
						if(Block <= 1)
							Block = 1
						var/Blocked = prob(Block)
						if(Blocked)
							T.CombatSkillTransfer(src,"Block")
							var/Gain = 50 - T.ShieldSkill / 3
							if(Gain <= 2)
								Gain = 2
							var/Gains = prob(Gain)
							if(Gains)
								T.ShieldSkill += T.ShieldSkillMulti
							T.overlays += /obj/Misc/CombatOverlays/Block/
							spawn(5)
								if(T)
									T.overlays -= /obj/Misc/CombatOverlays/Block/
							if(MainWeapon)
								MainWeapon.Dura -= rand(0.1,0.3)
								src.CheckWeaponDura(MainWeapon)
							if(Damage >= 0)
								S.Dura -= Damage / 10
								T.CheckArmourDura()
			if(T.Weapon2)
				if(T.Type != "Torch" && T.Type != "Torch Lit")
					if(istype(T.Weapon2,/obj/Items/Armour/Shields/))
						var/obj/S = T.Weapon2
						Block += T.ShieldSkill
						Block += T.Agility / 2
						Block -= src.Agility
						Damage -= S.Defence / 4
						var/BlockMath = 0
						for(var/obj/Items/Armour/A in T)
							if(A.suffix == "Equip")
								BlockMath += A.Weight / 3
						if(T.Strength <= BlockMath)
							Block -= BlockMath
						if(Block >= 50)
							Block = 50
						if(Block <= 1)
							Block = 1
						var/Blocked = prob(Block)
						if(Blocked)
							T.CombatSkillTransfer(src,"Block")
							var/Gain = 50 - T.ShieldSkill / 3
							if(Gain <= 2)
								Gain = 2
							var/Gains = prob(Gain)
							if(Gains)
								T.ShieldSkill += T.ShieldSkillMulti
							T.overlays += /obj/Misc/CombatOverlays/Block/
							spawn(5)
								if(T)
									T.overlays -= /obj/Misc/CombatOverlays/Block/
							if(MainWeapon)
								MainWeapon.Dura -= rand(0.1,0.3)
								src.CheckWeaponDura(MainWeapon)
							if(Damage >= 0)
								S.Dura -= Damage / 10
								T.CheckArmourDura()
			if(T.Weapon)
				var/obj/Z = T.Weapon
				var/KnockOffRight = prob(0.5)
				if(KnockOffRight)
					T.overlays-=image(Z.icon,Z.icon_state,Z.ItemLayer)
					T.Weapon = null
					T.Weight -= Z.Weight
					Z.suffix = null
					Z.icon_state = Z.CarryState
					Z.overlays = null
					if(Z.Type == "Torch Lit")
						T.luminosity = 0
					if(T.client)
						T.client.screen -= Z
					Z.Move(T.loc)
					view(src) << "<font color=red>[src] dis-arms [T] of their [Z]!<br>"
					if(Z.Delete)
						del(Z)
					return
			if(T.Weapon2)
				var/obj/Z2 = T.Weapon2
				var/KnockOffLeft = prob(0.5)
				if(KnockOffLeft)
					T.overlays-=image(Z2.icon,"[Z2.icon_state]",Z2.ItemLayer)
					T.overlays-=image(Z2.icon,"[Z2.icon_state] left",Z2.ItemLayer)
					T.Weapon2 = null
					T.Weight -= Z2.Weight
					Z2.suffix = null
					Z2.icon_state = Z2.CarryState
					Z2.overlays = null
					if(Z2.Type == "Torch Lit")
						T.luminosity = 0
					if(T.client)
						T.client.screen -= Z2
					Z2.Move(T.loc)
					view(src) << "<font color=red>[src] dis-arms [T] of their [Z2]!<br>"
					if(Z2.Delete)
						del(Z2)
					return
			if(T.Dead == 0)
				if(Damage >= 0)
					var/obj/HasWep = null
					if(MainWeapon)
						HasWep = MainWeapon
					src.ApplyCombatSkills(HasWep)
					src.GainStats()
					if(MainWeapon)
						if(MainWeapon.Material == "Silver" && T.Faction == "Undead")
							Damage = Damage * 1.5
					if(T.Race == "Illithid" && T.Sleep >= 1 && T.Sleeping == 0 && T.Fainted == 0)
						T.overlays += /obj/Misc/SpellEffects/AstralShield
						view(6,T) << "<font color=purple>[T]'s mind deflects [src]'s attack!<br>"
						T.Sleep -= Damage / 1.5
						Damage = 0
						if(T.Sleep <= 0)
							T.Sleep = 0
						spawn(10)
							if(T)
								T.overlays -= /obj/Misc/SpellEffects/AstralShield
					if(T.Faction == "Undead" && T.Humanoid && T.LeftArm <= 5 && T.RightArm <= 5 && T.LeftLeg <= 5 && T.RightLeg <= 5)
						var/Die = prob(10)
						if(Die)
							T.Death()
							return
				if(T)
					if(T.Humanoid == 0)
						if(Damage >= 0)
							T.overlays += /obj/Misc/CombatOverlays/Hit/
							spawn(5)
								if(T)
									T.overlays -= /obj/Misc/CombatOverlays/Hit/
							var/Stunned = prob(StunChance)
							if(Stunned && T.Faction != "Undead")
								if(T.Stunned == 0 && T.Fainted == 0)
									T.Stunned = 1
									T.Pull = null
									T.CanMove = 0
									T.Stun()
									view(src) << "<font color=red>[T] has been stunned!<br>"
							T.Blood -= Damage / 1.5
							T.Affliction(src.SpreadsAffliction,T)
							T.HP -= Damage
							T.Pain += rand(Damage / 4,Damage / 3)
							T.Bleed()
							T.Splat()
							if(T.HP <= 1)
								view(src) << "<font color=red>[T] has been slain by [src]!<br>"
								for(var/obj/Items/I in T)
									if(I.icon == null)
										del(I)
								T.Death()
							return
				if(T.Humanoid)
					var/HitsLeftArm = 0
					var/HitsRightArm = 0
					var/HitsLeftLeg = 0
					var/HitsRightLeg = 0
					var/HitsHead = 0
					var/HitsTorso = 0
					var/Hits = rand(1,6)
					if(Hits == 1)
						HitsLeftArm = 1
					if(Hits == 2)
						HitsRightArm = 1
					if(Hits == 3)
						if(T.Race != "Snakeman")
							HitsLeftLeg = 1
						else
							Hits = 5
					if(Hits == 4)
						if(T.Race != "Snakeman")
							HitsRightLeg = 1
						else
							Hits = 5
					if(Hits == 5)
						HitsTorso = 1
					if(Hits == 6)
						HitsHead = 1
					if(T.LeftArm == 0)
						HitsLeftArm = 0
					if(T.RightArm == 0)
						HitsRightArm = 0
					if(T.LeftLeg == 0)
						HitsLeftLeg = 0
					if(T.RightLeg == 0)
						HitsRightLeg = 0
					if(HitsTorso)
						var/ArmourOpening = 0
						T.overlays += /obj/Misc/CombatOverlays/Torso/
						spawn(5)
							if(T)
								T.overlays -= /obj/Misc/CombatOverlays/Torso/
						if(T.WBack)
							var/obj/H = T.WBack
							Damage -= H.Defence
							if(MainWeapon)
								if(MainWeapon.DamageType == "Slash")
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.1
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.3,0.4)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.5,1)
								if(MainWeapon.DamageType == "Blunt")
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.2
										StunChance += rand(1,2)
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.1,0.3)
										StunChance += rand(2,4)
								if(MainWeapon.DamageType == "Pierce")
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.2
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.3,0.8)
								T.CheckArmourDura()
								src.CheckWeaponDura(MainWeapon)
							else
								H.Dura -= rand(0.1,0.2)
								T.CheckArmourDura()
								var/Hand = rand(1,2)
								if(Hand == 1 && src.UnarmedSkill <= 20)
									src.LeftArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(Hand == 2 && src.UnarmedSkill <= 20)
									src.RightArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(src.Claws)
									src.Claws -= rand(0.1,1)
									if(src.Claws <= 0)
										src.Claws = 0
							if(ArmourOpening == 0)
								ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening)
									Damage = Damage * 1.4
						if(T.WWaist)
							var/obj/H = T.WWaist
							if(MainWeapon)
								if(MainWeapon.DamageType == "Slash")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.3,0.6)
										Damage = Damage / 1.2
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.1
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.3,0.4)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.5,1)
								if(MainWeapon.DamageType == "Blunt")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.3,0.6)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.2
										StunChance += rand(1,2)
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.1,0.3)
										StunChance += rand(2,4)
								if(MainWeapon.DamageType == "Pierce")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.4,0.6)
										Damage = Damage / 1.3
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.2
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.3,0.8)
								T.CheckArmourDura()
								src.CheckWeaponDura(MainWeapon)
							else
								H.Dura -= rand(0.1,0.2)
								T.CheckArmourDura()
								var/Hand = rand(1,2)
								if(Hand == 1 && src.UnarmedSkill <= 20)
									src.LeftArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(Hand == 2 && src.UnarmedSkill <= 20)
									src.RightArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(src.Claws)
									src.Claws -= rand(0.1,1)
									if(src.Claws <= 0)
										src.Claws = 0
								if(H.DefenceType == "Plate")
									if(ArmourOpening == 0)
										ArmourOpening = prob(5 - H.Dura / 20)
							if(ArmourOpening == 0)
								Damage -= H.Defence
							if(ArmourOpening)
								Damage -= H.Defence / rand(1.1,7)
								ArmourOpening = 0
						if(T.WUpperBody)
							var/obj/H = T.WUpperBody
							if(MainWeapon)
								if(MainWeapon.DamageType == "Slash")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.3,0.6)
										Damage = Damage / 1.2
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.1
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.3,0.4)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.5,1)
								if(MainWeapon.DamageType == "Blunt")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.3,0.6)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.2
										StunChance += rand(1,2)
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.1,0.3)
										StunChance += rand(2,4)
								if(MainWeapon.DamageType == "Pierce")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.4,0.6)
										Damage = Damage / 1.3
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.2
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.3,0.8)
								T.CheckArmourDura()
								src.CheckWeaponDura(MainWeapon)
							else
								H.Dura -= rand(0.1,0.2)
								T.CheckArmourDura()
								var/Hand = rand(1,2)
								if(Hand == 1 && src.UnarmedSkill <= 20)
									src.LeftArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(Hand == 2 && src.UnarmedSkill <= 20)
									src.RightArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(src.Claws)
									src.Claws -= rand(0.1,1)
									if(src.Claws <= 0)
										src.Claws = 0
								if(H.DefenceType == "Plate")
									if(ArmourOpening == 0)
										ArmourOpening = prob(5 - H.Dura / 20)
							if(ArmourOpening == 0)
								Damage -= H.Defence
							if(ArmourOpening)
								Damage -= H.Defence / rand(1.1,7)
								ArmourOpening = 0
						if(T.WShoulders)
							var/obj/H = T.WShoulders
							if(MainWeapon)
								if(MainWeapon.DamageType == "Slash")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.3,0.6)
										Damage = Damage / 1.2
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.1
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.3,0.4)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.5,1)
								if(MainWeapon.DamageType == "Blunt")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.3,0.6)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.2
										StunChance += rand(1,2)
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.1,0.3)
										StunChance += rand(2,4)
								if(MainWeapon.DamageType == "Pierce")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.4,0.6)
										Damage = Damage / 1.3
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.2
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.3,0.8)
								T.CheckArmourDura()
								src.CheckWeaponDura(MainWeapon)
							else
								H.Dura -= rand(0.1,0.2)
								T.CheckArmourDura()
								var/Hand = rand(1,2)
								if(Hand == 1 && src.UnarmedSkill <= 20)
									src.LeftArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(Hand == 2 && src.UnarmedSkill <= 20)
									src.RightArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(src.Claws)
									src.Claws -= rand(0.1,1)
									if(src.Claws <= 0)
										src.Claws = 0
								if(H.DefenceType == "Plate")
									if(ArmourOpening == 0)
										ArmourOpening = prob(5 - H.Dura / 20)
							if(ArmourOpening == 0)
								Damage -= H.Defence
							if(ArmourOpening)
								Damage -= H.Defence / rand(1.1,7)
								ArmourOpening = 0
						if(T.WChest)
							var/obj/H = T.WChest
							if(MainWeapon)
								if(MainWeapon.DamageType == "Slash")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.3,0.6)
										Damage = Damage / 1.2
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.1
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.3,0.4)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.5,1)
								if(MainWeapon.DamageType == "Blunt")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.3,0.6)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.2
										StunChance += rand(1,2)
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.1,0.3)
										StunChance += rand(2,4)
								if(MainWeapon.DamageType == "Pierce")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.4,0.6)
										Damage = Damage / 1.3
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.2
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.3,0.8)
								T.CheckArmourDura()
								src.CheckWeaponDura(MainWeapon)
							else
								H.Dura -= rand(0.1,0.2)
								T.CheckArmourDura()
								var/Hand = rand(1,2)
								if(Hand == 1 && src.UnarmedSkill <= 20)
									src.LeftArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(Hand == 2 && src.UnarmedSkill <= 20)
									src.RightArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(src.Claws)
									src.Claws -= rand(0.1,1)
									if(src.Claws <= 0)
										src.Claws = 0
								if(H.DefenceType == "Plate")
									if(ArmourOpening == 0)
										ArmourOpening = prob(5 - H.Dura / 20)
							if(ArmourOpening == 0)
								Damage -= H.Defence
							if(ArmourOpening)
								Damage -= H.Defence / rand(1.1,7)
								ArmourOpening = 0
						if(Damage >= 0)
							var/KnockBack = prob(0 + src.Strength / 5)
							if(KnockBack && T.Job != "KnockedBack")
								StunChance += 50
								view(src) << "<font color = red>[T] is propelled back by the force of the blow!<br>"
								T.density = 0
								T.Job = "KnockedBack"
								var/DIR = get_dir(src,T)
								var/Dis = 1 + src.Strength / 33
								if(T.Stunned == 0 && T.Fainted == 0)
									T.Stunned = 1
									T.Pull = null
									T.CanMove = 0
									T.Stun()
									view(src) << "<font color=red>[T] has been stunned!<br>"
								T.KnockBack(Dis,DIR)
							var/HitsHeart = prob(15)
							var/HitsLeftLung = prob(15)
							var/HitsRightLung = prob(15)
							var/HitsSpleen = prob(15)
							var/HitsLeftKidney = prob(15)
							var/HitsRightKidney = prob(15)
							var/HitsLiver = prob(15)
							var/HitsBladder = prob(15)
							var/HitsIntestine = prob(15)
							var/HitsStomach = prob(15)
							if(HitsIntestine)
								if(T && T.Intestine)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										var/Puke = prob(20)
										if(Puke && T.Faction != "Undead")
											var/obj/Misc/Gore/Puke/P = new
											P.Move(T.loc)
											view(src) << "<font color=green>[T] pukes!<br>"
										T.AddGore("Torso",T.Race)
										T.Intestine -= Damage
										T.Blood -= Damage / 6
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 5,Damage / 4)
										T.Bleed()
										T.Splat()
										if(T.Intestine <= 1 && T.Intestine != 0)
											T.Intestine = 0
											T.CanEat = 0
											T.Blood -= Damage / 3
											view(src) << "<font color =purple>[T]'s Intestines have been mangled!<br>"
											if(T.MortalWound == 0)
												T.MortalWound = 1
												T.MortallyWounded()
									else
										T.Pain += rand(Damage / 5,Damage / 4)
							if(HitsStomach)
								if(T && T.Stomach)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										if(T.Faction != "Undead")
											var/obj/Misc/Gore/Puke/P = new
											P.Move(T.loc)
											view(src) << "<font color=green>[T] pukes!<br>"
										T.AddGore("Torso",T.Race)
										T.Stomach -= Damage
										T.Blood -= Damage / 6
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 5,Damage / 4)
										T.Bleed()
										T.Splat()
										if(T.Stomach <= 1 && T.Stomach != 0)
											T.Stomach = 0
											T.CanEat = 0
											T.Blood -= Damage / 3
											view(src) << "<font color =purple>[T]'s Stomach has been mangled!<br>"
											if(T.MortalWound == 0)
												T.MortalWound = 1
												T.MortallyWounded()
									else
										T.Pain += rand(Damage / 5,Damage / 4)
							if(HitsBladder)
								if(T && T.Bladder)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.Bladder -= Damage
										T.Blood -= Damage / 6
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 5,Damage / 4)
										T.Bleed()
										T.Splat()
										if(T.Bladder <= 1 && T.Bladder != 0)
											T.Bladder = 0
											T.Blood -= Damage / 3
											view(src) << "<font color =purple>[T]'s Bladder has been mangled!<br>"
											if(T.MortalWound == 0)
												T.MortalWound = 1
												T.MortallyWounded()
									else
										T.Pain += rand(Damage / 5,Damage / 4)
							if(HitsLiver)
								if(T && T.Liver)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.Liver -= Damage
										T.Blood -= Damage
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 4,Damage / 3)
										T.Bleed()
										T.Splat()
										if(T.Liver <= 1 && T.Liver != 0)
											T.Liver = 0
											T.Blood -= Damage / 3
											view(src) << "<font color =purple>[T]'s Liver has been mangled!<br>"
											if(T.MortalWound == 0)
												T.MortalWound = 1
												T.MortallyWounded()
									else
										T.Pain += rand(Damage / 4,Damage / 3)
							if(HitsRightKidney)
								if(T && T.RightKidney)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.RightKidney -= Damage
										T.Blood -= Damage / 5
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 4,Damage / 3)
										T.Bleed()
										T.Splat()
										if(T.RightKidney <= 1 && T.RightKidney != 0)
											T.RightKidney = 0
											T.Blood -= Damage / 3
											view(src) << "<font color =purple>[T]'s Right Kidney has been mangled!<br>"
											if(T.MortalWound == 0)
												T.MortalWound = 1
												T.MortallyWounded()
											if(T)
												if(T.LeftKidney == 0)
													spawn(300)
														if(T)
															if(T.Dead == 0 && T.Faction != "Undead")
																view(src) << "<font color =purple>[T]'s Kidneys have been destroyed, they die a painful death!<br>"
																T.Death()
																return
									else
										T.Pain += rand(Damage / 4,Damage / 3)
							if(HitsLeftKidney)
								if(T && T.LeftKidney)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.LeftKidney -= Damage
										T.Blood -= Damage / 5
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 4,Damage / 3)
										T.Bleed()
										T.Splat()
										if(T.LeftKidney <= 1 && T.LeftKidney != 0)
											T.LeftKidney = 0
											T.Blood -= Damage / 3
											view(src) << "<font color =purple>[T]'s Left Kidney has been mangled!<br>"
											if(T.MortalWound == 0)
												T.MortalWound = 1
												T.MortallyWounded()
											if(T)
												if(T.RightKidney == 0)
													spawn(300)
														if(T)
															if(T.Dead == 0 && T.Faction != "Undead")
																view(src) << "<font color =purple>[T]'s Kidneys have been destroyed, they die a painful death!<br>"
																T.Death()
																return
											else
												return
									else
										T.Pain += rand(Damage / 4,Damage / 3)
							if(HitsSpleen)
								if(T && T.Spleen)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.Spleen -= Damage
										T.Blood -= Damage / 6
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 4,Damage / 3)
										T.Bleed()
										T.Splat()
										if(T.Spleen <= 1 && T.Spleen != 0)
											T.Spleen = 0
											T.Blood -= Damage / 3
											view(src) << "<font color =purple>[T]'s Spleen has been mangled!<br>"
											if(T.MortalWound == 0)
												T.MortalWound = 1
												T.MortallyWounded()
									else
										T.Pain += rand(Damage / 4,Damage / 3)
							if(HitsRightLung)
								if(T && T.RightLung)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.RightLung -= Damage
										T.Blood -= Damage / 5
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 4,Damage / 3)
										T.Bleed()
										T.Splat()
										if(T.RightLung <= 1 && T.RightLung != 0)
											T.RightLung = 0
											view(src) << "<font color =purple>[T]'s Right Lung has collapsed!<br>"
											if(T.LeftLung == 0)
												spawn(300)
													if(T)
														if(T.Dead == 0 && T.Faction != "Undead")
															view(src) << "<font color =purple>[T]'s Lungs have collapsed, they die slowly!<br>"
															T.Death()
															return
													else
														return
									else
										T.Pain += rand(Damage / 4,Damage / 3)
							if(HitsLeftLung)
								if(T && T.LeftLung)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.LeftLung -= Damage
										T.Blood -= Damage / 5
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 4,Damage / 3)
										T.Bleed()
										T.Splat()
										if(T.LeftLung <= 1 && T.LeftLung != 0)
											T.LeftLung = 0
											view(src) << "<font color =purple>[T]'s Left Lung has collapsed!<br>"
											if(T.RightLung == 0)
												spawn(300)
													if(T)
														if(T.Dead == 0 && T.Faction != "Undead")
															view(src) << "<font color =purple>[T]'s Lungs have collapsed, they die slowly!<br>"
															T.Death()
															return
									else
										T.Pain += rand(Damage / 4,Damage / 3)
							if(HitsHeart)
								if(T && T.Heart)
									var/GetsThrough = 100
									if(T.WChest)
										var/obj/A = T.WChest
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 15
									if(T.WUpperBody)
										var/obj/A = T.WUpperBody
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 33
									if(T.WWaist)
										var/obj/A = T.WWaist
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 5
									if(T.WShoulders)
										var/obj/A = T.WShoulders
										if(A.DefenceType != "Leather")
											if(A.DefenceType != "Cloth")
												GetsThrough -= 10
									var/Through = prob(GetsThrough)
									if(Through)
										T.AddGore("Torso",T.Race)
										T.Heart -= Damage
										T.Blood -= Damage
										T.Affliction(src.SpreadsAffliction,T)
										T.Pain += rand(Damage / 3,Damage / 2)
										T.Bleed()
										T.Splat()
										if(T.Heart <= 1 && T.Heart != 0)
											T.Heart = 0
											if(T.Faction != "Undead")
												view(src) << "<font color =purple>[T]'s Heart has failed, they die instantly!<br>"
												T.Death()
											return
									else
										T.Pain += rand(Damage / 3,Damage / 2)
						return
					if(HitsRightLeg)
						var/ArmourOpening = 0
						if(T.RightLeg)
							T.overlays += /obj/Misc/CombatOverlays/RightLeg/
							spawn(5)
								if(T)
									T.overlays -= /obj/Misc/CombatOverlays/RightLeg/
							if(T.WLegs)
								var/obj/H = T.WLegs
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(T.WRightFoot)
								var/obj/H = T.WRightFoot
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(Damage >= 0)
								var/Stunned = prob(StunChance)
								if(Stunned)
									if(T.Stunned == 0 && T.Fainted == 0)
										T.Stunned = 1
										T.Pull = null
										T.CanMove = 0
										T.Stun()
										view(src) << "<font color=red>[T] has been stunned!<br>"
								T.AddGore("RightLeg",T.Race)
								T.Blood -= Damage / 1.5
								T.Affliction(src.SpreadsAffliction,T)
								T.RightLeg -= Damage
								T.Pain += rand(Damage / 4,Damage / 3)
								T.Bleed()
								T.Splat()
								if(T.RightLeg <= 1 && T.RightLeg != 0)
									if(T.WLegs)
										var/obj/A = T.WLegs
										var/obj/A2 = null
										if(T.WRightFoot)
											A2 = T.WRightFoot
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(A.DefenceType != "Plate")
											if(A.DefenceType != "Chain")
												if(CanSlice)
													T.RightLeg = 0
													if(T.WoundRightLeg)
														var/obj/Wnd = T.WoundRightLeg
														T.overlays -= Wnd
														T.WoundRightLeg = null
													T.MoveSpeed += 1
													T.LimbLoss()
													T.Pain += 20
													T.Blood -= T.BloodMax / 4
													T.Bleed()
													view(src) << "<font color =red>[src] hacks [T]'s Right Leg off!<br>"
													var/obj/Items/Limb/L = new
													L.icon = T.icon
													L.icon_state = "limb"
													L.name = "[T]'s RightLeg"
													L.Move(T.loc)
													step_rand(L)
													if(A.suffix == "Equip")
														A.suffix = null
														A.overlays = null
														A.Move(T.loc)
														T.overlays-=image(A.icon,A.icon_state,A.ItemLayer)
														A.icon_state = A.CarryState
														A.layer = 4
														T.Weight -= A.Weight
														T.WLegs = null
														if(A.Delete)
															del(A)

													if(A2)
														if(A2.suffix == "Equip")
															A2.suffix = null
															A2.overlays = null
															A2.Move(T.loc)
															A2.layer = 4
															T.overlays-=image(A2.icon,A2.icon_state,A2.ItemLayer)
															A2.icon_state = A2.CarryState
															T.Weight -= A2.Weight
															T.WRightFoot = null
															if(A2.Delete)
																del(A2)
													if(T.Race == "Skeleton")
														view(src) << "<font color =red>[T]'s Right Leg is Completely pulverised, their bones fall apart and smash to the ground!<br>"
														T.Death()
														return
												else
													T.RightLeg = 5
									else
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(CanSlice)
											T.RightLeg = 0
											if(T.WoundRightLeg)
												var/obj/Wnd = T.WoundRightLeg
												T.overlays -= Wnd
												T.WoundRightLeg = null
											T.MoveSpeed += 1
											T.LimbLoss()
											T.Pain += 20
											T.Blood -= T.BloodMax / 4
											T.Bleed()
											view(src) << "<font color =red>[src] hacks [T]'s Right Leg off!<br>"
											var/obj/Items/Limb/L = new
											L.icon = T.icon
											L.icon_state = "limb"
											L.name = "[T]'s RightLeg"
											L.Move(T.loc)
											step_rand(L)
											if(T.WRightFoot)
												var/obj/A2 = T.WRightFoot
												if(A2.suffix == "Equip")
													A2.suffix = null
													A2.overlays = null
													A2.Move(T.loc)
													A2.layer = 4
													T.overlays-=image(A2.icon,A2.icon_state,A2.ItemLayer)
													A2.icon_state = A2.CarryState
													T.Weight -= A2.Weight
													if(A2.Delete)
														del(A2)
												T.WRightFoot = null
											if(T.Race == "Skeleton")
												view(src) << "<font color =red>[T]'s Right Leg is Completely pulverised, their bones fall apart and smash to the ground!<br>"
												T.Death()
												return
										else
											T.RightLeg = 5
						return
					if(HitsLeftLeg)
						var/ArmourOpening = 0
						if(T.LeftLeg)
							T.overlays += /obj/Misc/CombatOverlays/LeftLeg/
							spawn(5)
								if(T)
									T.overlays -= /obj/Misc/CombatOverlays/LeftLeg/
							if(T.WLegs)
								var/obj/H = T.WLegs
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(T.WLeftFoot)
								var/obj/H = T.WLeftFoot
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(Damage >= 0)
								var/Stunned = prob(StunChance)
								if(Stunned)
									if(T.Stunned == 0 && T.Fainted == 0)
										T.Stunned = 1
										T.Pull = null
										T.CanMove = 0
										T.Stun()
										view(src) << "<font color=red>[T] has been stunned!<br>"
								T.AddGore("LeftLeg",T.Race)
								T.Blood -= Damage / 1.5
								T.Affliction(src.SpreadsAffliction,T)
								T.LeftLeg -= Damage
								T.Pain += rand(Damage / 4,Damage / 3)
								T.Bleed()
								T.Splat()
								if(T.LeftLeg <= 1 && T.LeftLeg != 0)
									if(T.WLegs)
										var/obj/A = T.WLegs
										var/obj/A2 = null
										if(T.WLeftFoot)
											A2 = T.WLeftFoot
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(A.DefenceType != "Plate")
											if(A.DefenceType != "Chain")
												if(CanSlice)
													T.LeftLeg = 0
													if(T.WoundLeftLeg)
														var/obj/Wnd = T.WoundLeftLeg
														T.overlays -= Wnd
														T.WoundLeftLeg = null
													T.MoveSpeed += 1
													T.LimbLoss()
													T.Pain += 20
													T.Blood -= T.BloodMax / 4
													T.Bleed()
													view(src) << "<font color =red>[src] hacks [T]'s Left Leg off!<br>"
													var/obj/Items/L = new
													L.icon = T.icon
													L.icon_state = "limb"
													L.name = "[T]'s LeftLeg"
													L.Move(T.loc)
													step_rand(L)
													if(A.suffix == "Equip")
														A.suffix = null
														A.overlays = null
														A.Move(T.loc)
														T.overlays-=image(A.icon,A.icon_state,A.ItemLayer)
														A.icon_state = A.CarryState
														A.layer = 4
														T.Weight -= A.Weight
														T.WLegs = null
														if(A.Delete)
															del(A)

													if(A2)
														if(A2.suffix == "Equip")
															A2.suffix = null
															A2.overlays = null
															A2.Move(T.loc)
															A2.layer = 4
															T.overlays-=image(A2.icon,A2.icon_state,A2.ItemLayer)
															A2.icon_state = A2.CarryState
															T.Weight -= A2.Weight
															T.WLeftFoot = null
															if(A2.Delete)
																del(A2)
													if(T.Race == "Skeleton")
														view(src) << "<font color =red>[T]'s Left Leg is Completely pulverised, their bones fall apart and smash to the ground!<br>"
														T.Death()
														return
												else
													T.LeftLeg = 5
									else
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(CanSlice)
											T.LeftLeg = 0
											if(T.WoundLeftLeg)
												var/obj/Wnd = T.WoundLeftLeg
												T.overlays -= Wnd
												T.WoundLeftLeg = null
											T.MoveSpeed += 1
											T.LimbLoss()
											T.Pain += 20
											T.Blood -= T.BloodMax / 4
											T.Bleed()
											view(src) << "<font color =red>[src] hacks [T]'s Left Leg off!<br>"
											var/obj/Items/Limb/L = new
											L.icon = T.icon
											L.icon_state = "limb"
											L.name = "[T]'s LeftLeg"
											L.Move(T.loc)
											step_rand(L)
											if(T.WLeftFoot)
												var/obj/A2 = T.WLeftFoot
												if(A2.suffix == "Equip")
													A2.suffix = null
													A2.overlays = null
													A2.Move(T.loc)
													A2.layer = 4
													T.overlays-=image(A2.icon,A2.icon_state,A2.ItemLayer)
													A2.icon_state = A2.CarryState
													T.Weight -= A2.Weight
													T.WLeftFoot = null
													if(A2.Delete)
														del(A2)
											if(T.Race == "Skeleton")
												view(src) << "<font color =red>[T]'s Left Leg is Completely pulverised, their bones fall apart and smash to the ground!<br>"
												T.Death()
												return
										else
											T.LeftLeg = 5
						return
					if(HitsLeftArm)
						var/ArmourOpening = 0
						if(T.LeftArm)
							T.overlays += /obj/Misc/CombatOverlays/LeftArm/
							spawn(5)
								if(T)
									T.overlays -= /obj/Misc/CombatOverlays/LeftArm/
							if(T.WShoulders)
								var/obj/H = T.WShoulders
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(T.WLeftHand)
								var/obj/H = T.WLeftHand
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(Damage >= 0)
								var/Stunned = prob(StunChance)
								if(Stunned)
									if(T.Stunned == 0 && T.Fainted == 0)
										T.Stunned = 1
										T.Pull = null
										T.CanMove = 0
										T.Stun()
										view(src) << "<font color=red>[T] has been stunned!<br>"
								T.AddGore("LeftArm",T.Race)
								T.Blood -= Damage / 1.5
								T.Affliction(src.SpreadsAffliction,T)
								T.LeftArm -= Damage
								T.Pain += rand(Damage / 4,Damage / 3)
								T.Bleed()
								T.Splat()
								if(T.LeftArm <= 25)
									if(T.Weapon2)
										var/obj/O = T.Weapon2
										T.overlays-=image(O.icon,"[O.icon_state] left",O.ItemLayer)
										T.overlays-=image(O.icon,"[O.icon_state]",O.ItemLayer)
										O.overlays = null
										O.Move(T.loc)
										O.suffix = null
										O.layer = 4
										O.icon_state = O.CarryState
										T.Weapon2 = null
										if(T.client)
											T.client.screen -= O
										T.Weight -= O.Weight
										if(O.Delete)
											del(O)
										view(src) << "<font color =red>[src] shatters [T]'s Left Arm, they drop their [O]!<br>"
										view(5) << 'BreakBone.wav'
										if(T.Race == "Skeleton")
											view(src) << "<font color =red>[T]'s Left Arm is Completely pulverised, their bones fall apart and smash to the ground!<br>"
											T.Death()
											return
								if(T.LeftArm <= 1 && T.LeftArm != 0)
									if(T.WLeftHand)
										var/obj/A = T.WLeftHand
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(A.DefenceType != "Plate")
											if(A.DefenceType != "Chain")
												if(CanSlice)
													T.LeftArm = 0
													if(T.WoundLeftArm)
														var/obj/Wnd = T.WoundLeftArm
														T.overlays -= Wnd
														T.WoundLeftArm = null
													T.LimbLoss()
													T.Pain += 20
													T.Blood -= T.BloodMax / 4
													T.Bleed()
													view(src) << "<font color =red>[src] hacks [T]'s Left Arm off!<br>"
													var/obj/Items/Limb/L = new
													L.icon = T.icon
													L.icon_state = "limb"
													L.name = "[T]'s LeftArm"
													L.Move(T.loc)
													step_rand(L)
													if(A.suffix == "Equip")
														A.suffix = null
														A.overlays = null
														A.Move(T.loc)
														T.overlays-=image(A.icon,A.icon_state,A.ItemLayer)
														A.icon_state = A.CarryState
														A.layer = 4
														T.Weight -= A.Weight
														T.WLeftHand = null
														if(A.Delete)
															del(A)
													if(T.Race == "Skeleton")
														view(src) << "<font color =red>[T]'s Left Arm is Completely pulverised, their bones fall apart and smash to the ground!<br>"
														T.Death()
														return
												else
													T.LeftArm = 5
									else
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(CanSlice)
											T.LeftArm = 0
											if(T.WoundLeftArm)
												var/obj/Wnd = T.WoundLeftArm
												T.overlays -= Wnd
												T.WoundLeftArm = null
											T.LimbLoss()
											T.Pain += 20
											T.Blood -= T.BloodMax / 4
											T.Bleed()
											view(src) << "<font color =red>[src] hacks [T]'s Left Arm off!<br>"
											var/obj/Items/Limb/L = new
											L.icon = T.icon
											L.icon_state = "limb"
											L.name = "[T]'s LeftArm"
											L.Move(T.loc)
											step_rand(L)
											if(T.Race == "Skeleton")
												view(src) << "<font color =red>[T]'s Left Arm is Completely pulverised, their bones fall apart and smash to the ground!<br>"
												T.Death()
												return
										else
											T.LeftArm = 5
						return
					if(HitsRightArm)
						var/ArmourOpening = 0
						if(T.RightArm)
							T.overlays += /obj/Misc/CombatOverlays/RightArm/
							spawn(5)
								if(T)
									T.overlays -= /obj/Misc/CombatOverlays/RightArm/
							if(T.WShoulders)
								var/obj/H = T.WShoulders
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(T.WRightHand)
								var/obj/H = T.WRightHand
								if(MainWeapon)
									if(MainWeapon.DamageType == "Slash")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.3,0.6)
											Damage = Damage / 1.2
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.1
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.3,0.4)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.5,1)
									if(MainWeapon.DamageType == "Blunt")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.3,0.6)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.1,0.3)
											StunChance += rand(1,3)
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.2
											StunChance += rand(1,2)
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.1,0.3)
											StunChance += rand(2,4)
									if(MainWeapon.DamageType == "Pierce")
										if(H.DefenceType == "Plate")
											H.Dura -= rand(0.1,0.2)
											MainWeapon.Dura -= rand(0.4,0.6)
											Damage = Damage / 1.3
											if(ArmourOpening == 0)
												ArmourOpening = prob(5 - H.Dura / 20)
										if(H.DefenceType == "Chain")
											H.Dura -= rand(0.1,0.3)
											MainWeapon.Dura -= rand(0.2,0.4)
											Damage = Damage / 1.2
										if(H.DefenceType == "Leather")
											H.Dura -= rand(0.2,0.3)
											MainWeapon.Dura -= rand(0.1,0.2)
											Damage = Damage / 1.1
										if(H.DefenceType == "Cloth")
											H.Dura -= rand(0.3,0.8)
									T.CheckArmourDura()
									src.CheckWeaponDura(MainWeapon)
								else
									H.Dura -= rand(0.1,0.2)
									T.CheckArmourDura()
									var/Hand = rand(1,2)
									if(Hand == 1 && src.UnarmedSkill <= 20)
										src.LeftArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(Hand == 2 && src.UnarmedSkill <= 20)
										src.RightArm -= rand(1,3)
										src.Pain += rand(0.5,1)
									if(src.Claws)
										src.Claws -= rand(0.1,1)
										if(src.Claws <= 0)
											src.Claws = 0
									if(H.DefenceType == "Plate")
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
								if(ArmourOpening == 0)
									Damage -= H.Defence
								if(ArmourOpening)
									Damage -= H.Defence / rand(1.1,7)
									ArmourOpening = 0
							if(Damage >= 0)
								var/Stunned = prob(StunChance)
								if(Stunned)
									if(T.Stunned == 0 && T.Fainted == 0)
										T.Stunned = 1
										T.Pull = null
										T.CanMove = 0
										T.Stun()
										view(src) << "<font color=red>[T] has been stunned!<br>"
								T.AddGore("RightArm",T.Race)
								T.Blood -= Damage / 1.5
								T.Affliction(src.SpreadsAffliction,T)
								T.RightArm -= Damage
								T.Pain += rand(Damage / 4,Damage / 3)
								T.Bleed()
								T.Splat()
								if(T.RightArm <= 25)
									if(T.Weapon)
										var/obj/O = T.Weapon
										T.overlays-=image(O.icon,O.icon_state,O.ItemLayer)
										O.overlays = null
										O.Move(T.loc)
										O.suffix = null
										O.layer = 4
										O.icon_state = O.CarryState
										T.Weapon = null
										if(T.client)
											T.client.screen -= O
										T.Weight -= O.Weight
										if(O.Delete)
											del(O)
										view(src) << "<font color =red>[src] shatters [T]'s Right Arm, they drop their weapon!<br>"
										view(5) << 'BreakBone.wav'
										if(T.Race == "Skeleton")
											view(src) << "<font color =red>[T]'s Right Arm is Completely pulverised, their bones fall apart and smash to the ground!<br>"
											T.Death()
											return
								if(T.RightArm <= 1 && T.RightArm != 0)
									if(T.WRightHand)
										var/obj/A = T.WRightHand
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(A.DefenceType != "Plate")
											if(A.DefenceType != "Chain")
												if(CanSlice)
													T.RightArm = 0
													if(T.WoundRightArm)
														var/obj/Wnd = T.WoundRightArm
														T.overlays -= Wnd
														T.WoundRightArm = null
													T.LimbLoss()
													T.Pain += 20
													T.Blood -= T.BloodMax / 4
													T.Bleed()
													view(src) << "<font color =red>[src] hacks [T]'s Right Arm off!<br>"
													if(A.suffix == "Equip")
														A.suffix = null
														A.overlays = null
														A.Move(T.loc)
														T.overlays-=image(A.icon,A.icon_state,A.ItemLayer)
														A.icon_state = A.CarryState
														A.layer = 4
														T.Weight -= A.Weight
														T.WRightHand = null
														if(A.Delete)
															del(A)
													if(T.Race == "Skeleton")
														view(src) << "<font color =red>[T]'s Right Arm is Completely pulverised, their bones fall apart and smash to the ground!<br>"
														T.Death()
														return
												else
													T.RightArm = 5
									else
										var/CanSlice = 0
										if(MainWeapon)
											if(MainWeapon.DamageType != "Blunt")
												CanSlice = 1
										if(src.Claws && src.Weapon == null)
											CanSlice = 1
										if(CanSlice)
											T.RightArm = 0
											if(T.WoundRightArm)
												var/obj/Wnd = T.WoundRightArm
												T.overlays -= Wnd
												T.WoundRightArm = null
											T.LimbLoss()
											T.Pain += 20
											T.Blood -= T.BloodMax / 4
											T.Bleed()
											view(src) << "<font color =red>[src] hacks [T]'s Right Arm off!<br>"
											if(T.Race == "Skeleton")
												view(src) << "<font color =red>[T]'s Right Arm is Completely pulverised, their bones fall apart and smash to the ground!<br>"
												T.Death()
												return
										else
											T.RightArm = 5
						return
					if(HitsHead)
						var/ArmourOpening = 0
						T.overlays += /obj/Misc/CombatOverlays/Head/
						spawn(5)
							if(T)
								T.overlays -= /obj/Misc/CombatOverlays/Head/
						if(T.WHead)
							var/obj/H = T.WHead
							var/KnockOff = prob(0.5)
							if(KnockOff && H.suffix == "Equip")
								T.overlays-=image(H.icon,H.icon_state,H.ItemLayer)
								T.WHead = null
								T.Weight -= H.Weight
								H.suffix = null
								H.icon_state = H.CarryState
								H.overlays = null
								if(T.client)
									T.client.screen -= H
								H.Move(T.loc)
								view(src) << "<font color=red>[src] knocks [T]'s [H] off!<br>"
								if(H.Delete)
									del(H)
								return
							if(MainWeapon)
								if(MainWeapon.DamageType == "Slash")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.3,0.6)
										Damage = Damage / 1.2
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.1
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.3,0.4)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.5,1)
								if(MainWeapon.DamageType == "Blunt")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.3,0.6)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.1,0.3)
										StunChance += rand(1,3)
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.2
										StunChance += rand(1,2)
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.1,0.3)
										StunChance += rand(2,4)
								if(MainWeapon.DamageType == "Pierce")
									if(H.DefenceType == "Plate")
										H.Dura -= rand(0.1,0.2)
										MainWeapon.Dura -= rand(0.4,0.6)
										Damage = Damage / 1.3
										if(ArmourOpening == 0)
											ArmourOpening = prob(5 - H.Dura / 20)
									if(H.DefenceType == "Chain")
										H.Dura -= rand(0.1,0.3)
										MainWeapon.Dura -= rand(0.2,0.4)
										Damage = Damage / 1.2
									if(H.DefenceType == "Leather")
										H.Dura -= rand(0.2,0.3)
										MainWeapon.Dura -= rand(0.1,0.2)
										Damage = Damage / 1.1
									if(H.DefenceType == "Cloth")
										H.Dura -= rand(0.3,0.8)
								T.CheckArmourDura()
								src.CheckWeaponDura(MainWeapon)
							else
								H.Dura -= rand(0.1,0.2)
								T.CheckArmourDura()
								var/Hand = rand(1,2)
								if(Hand == 1 && src.UnarmedSkill <= 20)
									src.LeftArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(Hand == 2 && src.UnarmedSkill <= 20)
									src.RightArm -= rand(1,3)
									src.Pain += rand(0.5,1)
								if(src.Claws)
									src.Claws -= rand(0.1,1)
									if(src.Claws <= 0)
										src.Claws = 0
								if(H.DefenceType == "Plate")
									if(ArmourOpening == 0)
										ArmourOpening = prob(5 - H.Dura / 20)
							if(ArmourOpening == 0)
								Damage -= H.Defence
							if(ArmourOpening)
								Damage -= H.Defence / rand(1.1,7)
								ArmourOpening = 0

						if(Damage >= 0)
							var/KnockBack = prob(0 + src.Strength / 5)
							if(KnockBack && T.Job != "KnockedBack")
								StunChance += 50
								view(src) << "<font color = red>[T] is propelled back by the force of the blow!<br>"
								T.density = 0
								T.Job = "KnockedBack"
								var/DIR = get_dir(src,T)
								var/Dis = 1 + src.Strength / 33
								if(T.Stunned == 0 && T.Fainted == 0)
									T.Stunned = 1
									T.Pull = null
									T.CanMove = 0
									T.Stun()
									view(src) << "<font color=red>[T] has been stunned!<br>"
								T.KnockBack(Dis,DIR)
							var/HitsSkull = prob(20)
							var/HitsBrain = prob(10)
							var/HitsThroat = prob(10)
							var/HitsNose = prob(15)
							var/HitsLeftEar = prob(15)
							var/HitsRightEar = prob(15)
							if(T.Race == "Skeleton")
								HitsSkull = prob(45)
							var/HitsLeftEye = prob(15)
							var/HitsRightEye = prob(15)
							var/HitsTeeth = prob(15)
							if(HitsThroat)
								if(T.Throat)
									T.Blood -= Damage
									T.Affliction(src.SpreadsAffliction,T)
									T.Throat -= Damage * 1.5
									T.AddGore("Head",T.Race)
									T.Pain += rand(Damage / 3,Damage / 2)
									T.Bleed()
									if(T.Throat <= 1 && T.Throat != 0)
										T.Throat = 0
										if(T.Faction != "Undead")
											if(MainWeapon)
												if(MainWeapon.DamageType != "Blunt")
													view(src) << "<font color =red>[T]'s Throat is torn to shreds, blood gushes everywhere as they fall to the ground dead!<br>"
												else
													view(src) << "<font color = red>[T]'s Throat is crushed by [src]'s [MainWeapon], [T] falls to the ground, dieing instantly!<br>"
											else
												view(src) << "<font color = red>[T]'s Throat is crushed by [src], [T] falls to the ground, dieing instantly!<br>"
											T.Death()
											return
							if(HitsSkull)
								T.AddGore("Head",T.Race)
								T.Blood -= Damage / 2.2
								T.Affliction(src.SpreadsAffliction,T)
								T.Skull -= Damage / 2.5
								T.Pain += Damage / 2
								if(T.WHead == null)
									var/KO = prob(10)
									if(KO)
										view(src) << "<font color=red>[src] smashes [T] in the skull and knocks them out!<br>"
										T.Fainted = 1
										T.CanMove = 0
										T.Pull = null
										T.Fainted()
								T.Bleed()
								if(T.Skull <= 20)
									T.Blood -= Damage
									T.Pain += Damage / 2
									T.Brain -= Damage / 2
									if(T.Race == "Skeleton")
										view(src) << "<font color =red>[T]'s skull is Completely shattered, their bones fall apart and turn to ash!<br>"
										view(5) << 'BreakBone.wav'
										var/obj/Items/Resources/Ash/A = new
										A.Move(T.loc)
										del(T)
										return
									if(T)
										if(T.Brain <= 1 && T.Brain != 0)
											T.Brain = 0
											view(src) << "<font color =red>[T]'s Brain gets Completely mangled, they die instantly!<br>"
											T.Death()
											return
								T.Splat()
							if(HitsBrain)
								if(T.Brain)
									T.AddGore("Head",T.Race)
									T.Brain -= Damage
									T.Blood -= Damage
									T.Pain += Damage / 2
									T.Affliction(src.SpreadsAffliction,T)
									if(T.WHead == null)
										var/KO = prob(15)
										if(KO)
											view(src) << "<font color=red>[src] smashes [T] in the skull and knocks them out!<br>"
											T.Fainted = 1
											T.CanMove = 0
											T.Pull = null
											T.Fainted()
											T.Bleed()
											T.Splat()
									if(T)
										if(T.Brain <= 1 && T.Brain != 0)
											T.Brain = 0
											T.Death()
											view(src) << "<font color =red>[T]'s Brain gets Completely mangled, they die instantly!<br>"
											return
							if(HitsTeeth)
								if(T.Teeth)
									T.Teeth -= Damage
									T.AddGore("Head",T.Race)
									T.Blood -= Damage / 3
									T.Affliction(src.SpreadsAffliction,T)
									T.Pain += rand(Damage / 5,Damage / 4)
									T.Bleed()
									T.Splat()
									if(T.Teeth <= 1 && T.Teeth != 0)
										T.Teeth = 0
										T.Blood -= Damage / 3
										view(src) << "<font color =red>[T]'s Teeth gets Completely mangled!<br>"
							if(HitsRightEye)
								if(T.RightEye)
									T.RightEye -= Damage
									T.AddGore("Head",T.Race)
									T.Blood -= Damage / 2.5
									T.Affliction(src.SpreadsAffliction,T)
									T.Pain += rand(Damage / 5,Damage / 4)
									T.Bleed()
									T.Splat()
									if(T.RightEye <= 1 && T.RightEye != 0)
										T.RightEye = 0
										T.Blood -= Damage
										view(src) << "<font color =red>[T]'s RightEye gets Completely mangled!<br>"
										var/Die = prob(5)
										if(Die && T.Faction != "Undead")
											T.Death()
											return
										if(T.LeftEye <= 1)
											T << "<font color=red>You go blind!!<br>"
											T.CanSee = 0
											T.ResetButtons()
											T.Function = null
										if(T.Race == "Cyclops")
											T << "<font color=red>You go blind!!<br>"
											T.CanSee = 0
											T.ResetButtons()
											T.Function = null
							if(HitsLeftEye)
								if(T.LeftEye)
									T.LeftEye -= Damage
									T.AddGore("Head",T.Race)
									T.Blood -= Damage / 2.5
									T.Affliction(src.SpreadsAffliction,T)
									T.Pain += rand(Damage / 5,Damage / 4)
									T.Bleed()
									T.Splat()
									if(T.LeftEye <= 1 && T.LeftEye != 0)
										T.LeftEye = 0
										T.Blood -= Damage
										view(src) << "<font color =red>[T]'s LeftEye gets Completely mangled!<br>"
										var/Die = prob(5)
										if(Die && T.Faction != "Undead")
											T.Death()
											return
										if(T.RightEye <= 1)
											T << "<font color=red>You go blind!!<br>"
											T.CanSee = 0
											T.ResetButtons()
											T.Function = null
							if(HitsRightEar)
								if(T.RightEar)
									T.RightEar -= Damage
									T.AddGore("Head",T.Race)
									T.Blood -= Damage / 4
									T.Affliction(src.SpreadsAffliction,T)
									T.Pain += rand(Damage / 5,Damage / 4)
									T.Bleed()
									T.Splat()
									if(T.RightEar <= 1 && T.RightEar != 0)
										T.RightEar = 0
										T.Blood -= Damage / 3
										view(src) << "<font color =red>[T]'s RightEar gets Completely mangled!<br>"
							if(HitsLeftEar)
								if(T.LeftEar)
									T.LeftEar -= Damage
									T.AddGore("Head",T.Race)
									T.Blood -= Damage / 4
									T.Affliction(src.SpreadsAffliction,T)
									T.Pain += rand(Damage / 5,Damage / 4)
									T.Bleed()
									T.Splat()
									if(T.LeftEar <= 1 && T.LeftEar != 0)
										T.LeftEar = 0
										T.Blood -= Damage / 3
										view(src) << "<font color =red>[T]'s LeftEar gets Completely mangled!<br>"
							if(HitsNose)
								if(T.Nose)
									T.AddGore("Head",T.Race)
									T.Nose -= Damage
									T.Blood -= Damage / 2.5
									T.Affliction(src.SpreadsAffliction,T)
									T.Pain += rand(Damage / 5,Damage / 4)
									T.Bleed()
									T.Splat()
									if(T.Nose <= 1 && T.Nose != 0)
										T.Nose = 0
										T.Blood -= Damage / 3
										view(src) << "<font color =red>[T]'s Nose gets Completely mangled!<br>"
						return
		Affliction(var/A,var/mob/Victim)
			if(A == null)
				return
			if(Victim == null)
				return
			var/GotAlready = 0
			if(A in src.Afflictions)
				GotAlready = 1
			if(GotAlready == 0)
				if(A == "Undead Bite")
					var/Infect = prob(1)
					if(Infect)
						Victim.Afflictions += "Undead Bite"
						Victim.UndeadBite()


//Affliction Codes
		Illness(var/SeverityFactor)
			spawn(rand(200,1000))
				if(src && src.Dead == 0)
					src << "<font color = purple>You start to feel a little fevorish...<br>"
					spawn(rand(500,1500))
						if(src && src.Dead == 0)
							var/WontRecover = prob(SeverityFactor)
							if(WontRecover)
								src << "<font color = purple>You start to feel really ill!<br>"
								src.Pain += 100
								var/obj/Misc/Gore/Puke/P = new
								P.Move(src.loc)
								view(src) << "<font color=green>[src] pukes!<br>"
								if(src.client)
									for(var/obj/HUD/GUI/ScreenOverlay/SO in src.client.screen)
										SO.icon_state = "sick screen"
								src.High(20)
								src.Afflictions -= "Ill"
								return
							else
								src << "<font color = purple>You start to feel a little better!<br>"
								src.Afflictions -= "Ill"
								return
						else
							if(src)
								src.Afflictions -= "Ill"
							return
				else
					if(src)
						src.Afflictions -= "Ill"
					return
		UndeadBite()
			if(src.Faction == "Undead")
				return
			spawn(rand(200,1000))
				if(src)
					if(src.Dead== 0)
						src << "<font color = purple>You start to feel a little fevorish...<br>"
						spawn(rand(200,1000))
						if(src)
							if(src.Dead == 0)
								src << "<font color = purple>Your body begins to feel numb and cold, you also twitch a little now and then, you suddenly feel the chill of death deep inside of you!<br>"
								spawn(rand(200,1000))
									if(src)
										if(src.Dead == 0)
											src << "<font color = purple>You fall to the ground gasping for air, the very life force in your body begins to drain, you die and lie on the ground. After a moment you awake to find you have turned into one of the living dead, forever cursed to walk between the realm of the living, and the dead!<br>"
											src.icon += rgb(50,50,50)
											for(var/obj/Items/I in src)
												if(I.suffix == "Equip" && I.Type == "Conceals")
													I.layer = I.ItemLayer
													src.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
													src.WBack = null
													I.suffix = "Carried"
													I.overlays-=image(/obj/HUD/E/)
													I.overlays+=image(/obj/HUD/C/)
													I.icon_state = I.CarryState
													I.layer = 20
													src.DeleteInventoryMenu()
													if(src.OrginalName)
														src.name = src.OrginalName
														src.OrginalName = null
													if(src.StoredFaction)
														src.Faction = src.StoredFaction
														src.StoredFaction = null
											src.Faction = "Undead"
											src.CanEatBodies = 1
											src.HateList = null
											src.Target = null
											src.see_in_dark = 8
											src.CanEat = 1
											src.CanSleep = 0
											src.BloodMax = 0
											src.Blood = 0
											src.Bleed()
											src.Pain = 0
											src.MoveSpeed = 3
											src.Strength = src.Strength * 1.1
											src.Endurance = src.Endurance * 1.2
											src.Agility = src.Agility / 2
											src.Intelligence = src.Intelligence / 2
											src.UndeadReset()
											src.HateList = list("Stahlite Empire","Frogmen Hordes","Giant Hordes","Altherian Empire","Dragons","Demonic Legions","Human Empire","Chaos","Dangerous Beasts","Cyclops Hordes","Goblin Hordes","Spider Hordes","Snakeman Empire","Neutral","Human Empire Unholy","Human Empire Outlaw","None","Ratling Hordes")
											src.Afflictions -= "Undead Bite"
											src.Afflictions += "Undeath"
											src.SpreadsAffliction = "Undead Bite"
											src.DieAge = 1000
											src.UndeadProc()
											for(var/mob/M in range(6,src))
												if(M.Faction == "Undead" && M.Target == src)
													M.Target = null
											view(src) << "<font color = purple>[src]'s body turns pale!<br>"
											if(src.client == null)
												src.CancelDefaultProc = 1
												spawn(50)
													if(src)
														src.CancelDefaultProc = 0
														src.NormalAI()
														src.name = "{NPC} Zombie"
											else
												for(var/mob/M in Players)
													if(M.client && M.Admin)
														M << "<font color = teal><font size = 3>([usr.key])[usr] was turned into a Zombie at [usr.x],[usr.y],[usr.z]!<br>"