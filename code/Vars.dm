mob
	var
		WHead = null
		WChest = null
		WUpperBody = null
		WShoulders = null
		WLeftHand = null
		WRightHand = null
		WLegs = null
		WLeftFoot = null
		WRightFoot = null
		WWaist = null
		WBack = null
		WExtra = null

		Weapon = null
		Weapon2 = null

		Bleed = null
		BleedLast = 0
		BloodWallColour = null

		Pain = 0
		Fainted = 0
		Stunned = 0

		CanMove = 1
		CanAttack = 1
		CanSee = 1
		CanEat = 1
		CanSleep = 1
		CanBeRevived = 1
		CanEatBodies = 0
		CanEatRawMeats = 0 // 0 means you are guranteed to be posioned, 1 means that you can, but may get posioned, 2 means you can and will have no ill effects.
		CanSwimWell = 0
		CanRegenLimbs = 0
		CanBreathe = 1
		CanTakeDamage = 1 //For magic shields, ect.
		CanUseTK = 0 //Races that can use TK powers.

		OrginalName = null

		MouseLocationX = null
		MouseLocationY = null

		tmp/InvenUp = 0
		tmp/OOC = 1
		tmp/Moving = 1
		tmp/CanFireRanged = 1
		tmp/SleepNotice = 0
		tmp/EatNotice = 0
		tmp/StealNotice = 0
		tmp/Function = null
		tmp/Container = null
		tmp/Job = null
		tmp/GuardLoc = null
		tmp/Ready = 0
		tmp/UsingBook = null
		tmp/CantDoTask = 0
		tmp/Selling = null // List of objects a NPC is selling and that belong to them.

		GuardDir = null

		CurrentHand = "Right"
		DisableAttack = 0

		Age = 0
		Born = 0
		DieAge = 10000000

		StrengthMulti = 0
		AgilityMulti = 0
		EnduranceMulti = 0
		IntelligenceMulti = 0

		StrengthMax = 100
		AgilityMax = 100
		EnduranceMax = 100
		IntelligenceMax = 100

		SwordSkill = 1
		AxeSkill = 1
		SpearSkill = 1
		BluntSkill = 1
		RangedSkill = 1
		DaggerSkill = 1
		UnarmedSkill = 1

		SwordSkillMulti = 0
		AxeSkillMulti = 0
		SpearSkillMulti = 0
		BluntSkillMulti = 0
		RangedSkillMulti = 0
		DaggerSkillMulti = 0
		UnarmedSkillMulti = 0
		ShieldSkill = 0

		CarpentrySkill = 1
		MiningSkill = 1
		MasonarySkill = 1
		SmeltingSkill = 1
		ForgingSkill = 1
		WoodCuttingSkill = 1
		AlchemySkill = 1
		CookingSkill = 1
		ButcherySkill = 1
		SkinningSkill = 1
		LeatherCraftSkill = 1
		FishingSkill = 1
		BuildingSkill = 1
		FarmingSkill = 1
		WeavingSkill = 1
		EngravingSkill = 1
		FirstAidSkill = 1
		SwimmingSkill = 5
		BoneCraftSkill = 1

		CarpentrySkillMulti = 0
		MiningSkillMulti = 0
		MasonarySkillMulti = 0
		SmeltingSkillMulti = 0
		ForgingSkillMulti = 0
		WoodCuttingSkillMulti = 0
		AlchemySkillMulti = 0
		CookingSkillMulti = 0
		SkinningSkillMulti = 0
		ButcherySkillMulti = 0
		LeatherCraftSkillMulti = 0
		FishingSkillMulti = 0
		BuildingSkillMulti = 0
		FarmingSkillMulti = 0
		WeavingSkillMulti = 0
		EngravingSkillMulti = 0
		FirstAidSkillMulti = 0
		ShieldSkillMulti = 0
		SwimmingSkillMulti = 0.01
		BoneCraftMulti = 0

		HungerMulti = 0

		Necromancery = 0
		BloodMagic = 0
		AstralMagic = 0
		NatureMagic = 0
		WaterMagic = 0
		FireMagic = 0
		WindMagic = 0
		EarthMagic = 0
		MagicResistance = 10 // Default for now.
		MagicPotentcy = 0
		DiseaseResistance = 10 // Default for now
		CanUseMagic = 1

		StrCap = 11
		AgilCap = 11
		EndCap = 11
		IntCap = 11

		SkillCap = 11

		CurrentSkill = null
		CurrentSkillLevel = 0

		Energy = 0
		EnergyMax = 0

		LoggedIn = 0

		Hunger = 100
		Sleep = 100
		Sleeping = 0

		Dead = 0
		Soul = 1

		Gender = null

		DeadState = null
		DeadIcon = null

		Admin = 0
		AdminInvis = null

		Muted = 0

		HP = 0
		HPMAX = 0

		AdminEdit = 0
		AdminDelete = 0

		MoveSpeed = 1

		MortalWound = 0

		Class = null

		SpreadsAffliction = null

		Jailed = 0

		TargetIcon = null

		DarkVision = 0
		Vision = 4

		SparMode = 0

		RPpoints = 0

		InWater = 0

		SpeakingWith = null
		FollowUp = null

		StoredFaction = null
		PreviousFaction = null

		CurrentLanguage = null

		CancelDefaultProc = 0

		TextOutput = null

		CanExamine = 1
		CanInteract = 1

		HateList = list()
		KnowList = list()
		Afflictions = list()
		CreateList = list()

		LangKnow = list()

		Preg = 0 // 1 means an NPC birth, 2 for a Player, and 3 means they cant Mate for another year.
		PregType = null //How the person Breeds, Womb, Egg, Infection, ect.
		PregTimer = 0 //How long until they can have another baby.
		FatherStrength = 0
		FatherAgility = 0
		FatherEndurance = 0


turf
	var
		OrePath = null

		Supported = 0

		ManMade = 0 // Makes it so the AddObjects proc wont place boulders onto this turf

		AttachedKey = null
atom
	DblClick()
		if(usr.Function == "Interact")
			if(usr.CantDoTask)
				return
			var/obj/O = null
			if(usr.Ref)
				O = usr.Ref
			if(isturf(src))
				var/turf/T = src
				var/Dig = 0
				if(O)
					if(O.Type == "Shovel")
						Dig = 1
				if(usr.Race == "Ratling")
					Dig = 1
				if(Dig)
					if(T in range(1,usr))
						if(T.Dura == 0 && T.density == 0 && T.z != 3 && usr.Job == null)
							var/CanDig = 0
							if(T.icon_state == "dirt")
								CanDig = 1
							if(T.icon_state == "stone floor")
								CanDig = 1
							for(var/obj/Misc/Z in T)
								if(Z.GoesTo)
									CanDig = 0
							if(CanDig)
								view() << "<font color=yellow>[usr] begins to dig a hole into the [T]!<br>"
								usr.Job = "Dig"
								usr.CanMove = 0
								var/Time = 300 - usr.MiningSkill * 2
								if(Time <= 50)
									Time = 50
								spawn(Time)
									if(usr)
										if(T in range(1,usr))
											if(usr.Job == "Dig" && T.density == 0 && T.Dura == 0 && usr.CantDoTask == 0)
												if(T.icon_state == "dirt")
													CanDig = 1
												if(T.icon_state == "stone floor")
													CanDig = 1
												for(var/obj/Misc/Z in T)
													if(Z.GoesTo)
														CanDig = 0
												if(CanDig)
													usr.Job = null
													usr.MiningSkill += usr.MiningSkillMulti
													usr.GainStats(2)
													var/CanEnter = 0
													var/obj/Misc/Hole/H = new
													H.loc = locate(T.x,T.y,T.z)
													var/obj/Z = new
													var/Axis = 0
													if(usr.z == 2)
														Axis = 1
													if(usr.z == 1)
														Axis = 3
													Z.loc = locate(T.x,T.y,Axis)
													for(var/turf/T2 in range(0,Z))
														if(T2.icon_state == "stone" && T2.density)
															CanEnter = 1
														if(T2.icon_state == "stone floor" && T2.density == 0)
															CanEnter = 1
														if(CanEnter)
															T2.Dura = 0
															T2.icon_state = "stone floor"
															T2.Type = "Dark"
															T2.density = 0
															Tiles += T2
															T2.opacity = 0
															T2.luminosity = 0
													if(CanEnter)
														view() << "<font color=yellow>[usr] finishes digging a hole into the [T]!<br>"
														Tiles += T
													else
														usr << "<font color = red>Something underground stops you from digging, a wall, roof or ore vein perhaps.<br>"
														del(H)
													del(Z)
													if(O)
														O.Dura -= rand(0.5,1)
														usr.CheckWeaponDura(O)
													if(H)
														usr.CheckHole(H,"Dig")
												if(usr.Fainted == 0)
													if(usr.Stunned == 0)
														if(usr.Sleeping == 0)
															var/Legs = 1
															if(usr.RightLeg == 0)
																if(usr.LeftLeg == 0)
																	Legs = 0
															if(Legs)
																usr.CanMove = 1
						if(T.Dura == 0 && T.density == 0 && T.icon_state != "dirt" && usr.Job == null)
							view() << "<font color=yellow>[usr] begins to dig at the [T]!<br>"
							usr.Job = "Dig"
							usr.CanMove = 0
							var/Time = 150 - usr.MiningSkill * 2
							if(Time <= 20)
								Time = 20
							spawn(Time)
								if(usr)
									if(T in range(1,usr))
										if(usr.Job == "Dig" && T.density == 0 && T.Dura == 0 && usr.CantDoTask == 0)
											usr.Job = null
											usr.MiningSkill += usr.MiningSkillMulti / 2
											usr.GainStats(3)
											view() << "<font color=yellow>[usr] finishes digging at the [T]!<br>"
											T.icon_state = "dirt"
											T.name = "Dirt"
											Tiles += T
											if(O)
												O.Dura -= rand(0.5,1)
												usr.CheckWeaponDura(O)
											if(usr.Fainted == 0)
												if(usr.Stunned == 0)
													if(usr.Sleeping == 0)
														var/Legs = 1
														if(usr.RightLeg == 0)
															if(usr.LeftLeg == 0)
																Legs = 0
														if(Legs)
															usr.CanMove = 1
		if(usr.Function == "Combat")
			if(usr.Weapon)
				var/obj/W = usr.Weapon
				if(W.ObjectType == "Ranged")
					usr.FireRanged(src)
				if(usr.WExtra)
					var/Arrows = 0
					var/obj/O = usr.WExtra
					if(O.Type == "Quiver")
						for(var/obj/Items/Ammo/A in O)
							Arrows = 1
					if(Arrows == 0)
						usr << "<font color = red>Out of Arrows!<br>"
			if(usr.Weapon2)
				var/obj/W = usr.Weapon2
				if(W.ObjectType == "Ranged")
					usr.FireRanged(src)
				if(usr.WExtra)
					var/Arrows = 0
					var/obj/O = usr.WExtra
					if(O.Type == "Quiver")
						for(var/obj/Items/Ammo/A in O)
							Arrows = 1
					if(Arrows == 0)
						usr << "<font color = red>Out of Arrows!<br>"
		if(usr.AdminDelete)
			switch(alert("Kill [src], Delete [src], or Delete Entire Tile Contents?",,"Kill","One Object","All Objects"))
				if("Kill")
					switch(alert("Really Kill [src]?",,"Yes","No"))
						if("Yes")
							if(ismob(src))
								var/mob/M = src
								var/obj/Misc/Weather/LighteningHit/LH = new
								LH.loc = locate(M.x,M.y,M.z)
								usr.Log_admin("[usr] Admin Kills [M] at [M.x],[M.y],[M.z]")
								M.Death()
				if("One Object")
					switch(alert("Really Delete [src]?",,"Yes","No"))
						if("Yes")
							world << "<font color = teal>[src] was booted! <br>"
							usr.Log_admin("[usr] Deletes [src] at [src.x],[src.y],[src.z]")
							del(src)
				if("All Objects")
					switch(alert("Really Delete [src]'s Contents?",,"Yes","No"))
						if("Yes")
							world << "<font color = teal>[src]'s content's were booted! <br>"
							usr.Log_admin("[usr] Deletes [src]'s contents at [src.x],[src.y],[src.z]")
							for(var/atom/a in locate(src.x,src.y,src.z))
								if(a != src)
									del(a)
			return
		if(usr.AdminEdit)
			if(usr.Admin >= 2)
				var/AdminVar = null
				if(ismob(src))
					var/mob/M = src
					AdminVar = M.Admin
				var/atom/O = src
				var/variable=input("Which var?","Var") in O.vars
				var/default
				var/typeof=O.vars[variable]
				var/value = Edit_null_display(typeof)
				if(isnull(typeof))
					usr<<"Unknown Variable-Type"
				else if(istext(typeof))
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>TEXT</b> type [value]."
					default="text"
				else if(istype(typeof,/atom) || istype(typeof,/datum))
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>TYPE</b> type [value]."
					default="type"
				else if(isicon(typeof))
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>ICON</b> type [value]."
					typeof="\icon[typeof]"
					default="icon"
				else if(isloc(typeof))
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>REFERENCE</b> type [value]."
					default="reference"
				else if(isnum(typeof))
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>NUM</b> type [value]."
					default="num"
					usr.dir=1
				else if(istype(typeof,/list))
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>LIST</b> type [value]."
					usr<<"Unable to edit Lists."
				else if(istype(typeof,/client))
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>CLIENT</b> type [value]."
					usr<<"Unable to edit Client."
				else
					usr<<"[O]\'s variable, '[variable]', appears to be of <b>FILE</b> type [value]."
					default="file"
				var/class=input("What type?","Variable Type",default)as null|anything in list("text","num","type","reference","icon","file","default")
				switch(class)
					if("default")
						O.vars[variable]=initial(O.vars[variable])
					if("text")
						O.vars[variable]=input("Enter new text:","Text",\
							O.vars[variable]) as null|text
					if("num")
						O.vars[variable]=input("Enter new number:","Num",\
							O.vars[variable]) as null|num
					if("icon")
						O.vars[variable]=input("Pick icon:","Icon",O.vars[variable]) \
							as null|icon
					if("type")
						O.vars[variable]=input("Enter type:","Type",O.vars[variable]) \
							in typesof(/obj,/mob,/area,/turf)
					if("reference")
						O.vars[variable]=input("Select reference:","Reference",\
							O.vars[variable]) as null|mob|obj|turf|area in world
					if("file")
						O.vars[variable]=input("Pick file:","File",O.vars[variable]) \
							as null|file
				if(ismob(src))
					var/mob/M = src
					if(AdminVar != null && M.Admin != AdminVar && usr.key != "Ginseng")
						BanList += usr.key
						world << "<font color = teal>([usr.key]) [usr] was Auto-Ban for trying to Edit [M]'s Admin Var!<br>"
						usr.Log_admin("([usr.key])[usr] was Auto-Ban for Editing [M]'s Admin Var.")
						del(usr)
						return
				usr.Log_admin("[usr] Edits [O]'s [variable] to [O.vars[variable]]")
	var
		WoundLeftArm = null
		WoundRightArm = null
		WoundLeftLeg = null
		WoundRightLeg = null
		WoundHead = null
		WoundTorso = null

		CanBeCrafted = 0

		Faction = null

		Type = null

		Defence = 0

		Weight = 0
		WeightMax = 0

		Xloc = 0
		Yloc = 0

		Quality = 0

		Race = null

		DamageType = null
		DefenceType = null

		Dura = 0
		MaxDura = 0

		Humanoid = 1

		Material = null
		BaseMaterial = null

		Fuel = 0
		OnFire = 0

		Strength = 0
		Agility = 0
		Endurance = 0
		Intelligence = 0

		Blood = 100
		BloodMax = 100

		Hair = null
		Beard= null

		LeftArm = 0
		RightArm = 0
		Torso = 0
		Head = 0
		LeftLeg = 0
		RightLeg = 0

		Claws = 0

		Skull = 0
		Brain = 0
		LeftEye = 0
		RightEye = 0
		LeftEar = 0
		RightEar = 0
		Nose = 0
		Teeth = 0
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

		tmp/Target = null
		tmp/Ref = null
		tmp/Owner = null
		tmp/LastLoc = null
		tmp/LastHit = null //Last solid object someone under the influence of TK hit.
		tmp/Pull = null
		tmp/Controlling = null
		tmp/UnderTK = null //1 if the person is being controlled by TK.

		BloodColour = null
obj
	var
		BodysKey = null

		EquipState = null
		CarryState = null
		ItemLayer = 0

		ObjectType = null
		ObjectTag = null

		OpenState = null
		ClosedState = null

		Locked = 0
		KeyCode = null

		CantRaces = null
		Heals = null

		tmp/GoesTo = null

		Value = 0

		CraftPotential = 0

		Skinned = 0
		Butchered = 0

		CookedState = null //Icon state of the meat when cooked
		CookingFood = 0 // 1 means it needs to be cook, and 2 means it is cooked.

		Delete = 0 //Add this to items that should delete when the person holding them dies.

		TwoHander = 0 //Weapons that can used two hands to do damage with.

		SpeakPercent = 0 //How well you can speak that Language
		WritePercent = 0 //How well you can write that Language

		Standing = 0 //The standing that a players Contact object has, in ref to an NPC.

		WeaponDamageMax = 0
		WeaponDamageMin = 0

		//Spells
		WrittenIn = null
		Comprehensible = 0
		SpellWords = null
		MagicUsed = null
		SpellEffect = null

		BookContents = list()

		Red = 0
		Green = 0
		Blue = 0
		tmp/PreviousPages = list()
		tmp/FuturePages = list()



atom
	proc
		make_image(icon/icon,icon_state,layer)
			var/image/I=new
			I.icon=icon
			I.icon_state=icon_state
			I.layer=layer
			return I
		CreateChaos()
			if(src)
				var/num = rand(5,8)
				while(num)
					num -= 1
					var/obj/Misc/OtherWorldly/ChaosEnergy/E = new
					E.loc = locate(src.x,src.y,src.z)
					E.dir = rand(1,12)
			else
				return
			spawn(9)
				CreateChaos()
		CreateSmoke()
			if(src.OnFire)
				var/obj/Misc/Smoke/S = new
				S.loc = locate(src.x,src.y+1,src.z)
			else
				return
			spawn(9)
				CreateSmoke()
		Burn(var/Dis)
			if(src.Fuel && src.OnFire)
				src.Fuel -= 1
				if(src.Fuel <= 0)
					src.Fuel = 0
					if(isobj(src))
						src.luminosity = 0
						var/obj/O = src
						if(O.suffix != "Equip" && O.suffix != "Carried")
							var/obj/Items/Resources/Ash/A = new
							A.loc = O.loc
							if(O.Type == "Block")
								var/obj/Items/Resources/Charcoal/C = new
								C.loc = O.loc
							del(O)
					if(isturf(src))
						src.icon = 'terrain.dmi'
						src.icon_state = "ash floor"
						src.density = 0
						src.opacity = 0
						var/Z = 0
						var/obj/Misc/Layer/L = new
						if(src.z == 1)
							Z = 2
						L.loc = locate(src.x,src.y,Z)
						for(var/turf/T in range(0,L))
							T.icon_state = "clouds"
							T.Supported = 0
							T.density = 1
							T.overlays -= /obj/Misc/FireLarge/
							Tiles += T
						del(L)
						Tiles += src
						if(Night == 0)
							src.luminosity = 0
					src.OnFire = 0
					src.overlays -= /obj/Misc/Fire/
					src.overlays -= /obj/Misc/FireLarge/
					return
				else
					for(var/atom/A in view(Dis,src))
						if(ismob(A))
							var/mob/M = A
							var/Burn = prob(20)
							if(Burn)
								M.OnFire(0)
						if(A.Fuel && A.suffix != "Equip" && A.OnFire == 0)
							var/Burn = prob(3)
							if(Burn)
								spawn(rand(50,75))
									if(A in view(Dis,src))
										if(A.OnFire == 0 && A.Fuel && A.suffix != "Equip")
											if(isobj(A))
												A.overlays += /obj/Misc/Fire/
												A.overlays -= /obj/Items/Plants/Branches/Tree1Leaves1/
												A.overlays -= /obj/Items/Plants/Branches/Tree1Leaves2/
												A.overlays -= /obj/Items/Plants/Branches/Tree1Leaves3/
												A.overlays -= /obj/Items/Plants/Branches/Tree1Leaves4/
												A.overlays -= /obj/Items/Plants/Branches/Tree1Leaves5/
												A.overlays -= /obj/Items/Plants/Branches/Tree1Leaves6/
												A.overlays -= /obj/Items/Plants/Branches/Tree2Leaves1/
												A.overlays -= /obj/Items/Plants/Branches/Tree2Leaves2/
											if(isturf(A))
												var/Z = 0
												var/obj/Misc/Layer/L = new
												if(A.z == 1)
													Z = 2
												L.loc = locate(A.x,A.y,Z)
												for(var/turf/T in range(0,L))
													T.overlays += /obj/Misc/FireLarge/
												del(L)
												A.overlays += /obj/Misc/FireLarge/
												Dis = 1
											A.luminosity = 5
											A.OnFire = 1
											A.CreateSmoke()
											A.Burn(Dis)
											if(ismob(A))
												var/mob/M = A
												M.CheckFlamable()
			else
				src.overlays -= /obj/Misc/Fire/
				src.overlays -= /obj/Misc/FireLarge/
				return
			spawn(rand(25,30)) src.Burn(Dis)
