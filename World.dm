#define DEBUG
#define REMOTE_SERVER
world
	view = 7
	version = 63
	name = "Lands of Legend - Version 0.63"
	status = "Lands of Legend - Version 0.63"
	hub = "Godsring.LandsofLegend"
	hub_password = ""
	loop_checks = 0
	tick_lag = 0.75
	New()
		log = file("ErrorLog.txt")
		LoadMisc()
		CreateOre()
		LoadMap()
		DayNightCyle()
		var/Finish_Remote_Server_Access
		for(var/turf/T in block(locate(98,42,3),locate(114,38,3)))
			var/InTiles = 0
			if(T in Tiles)
				InTiles = 1
			if(InTiles == 0)
				Tiles += T
		for(var/turf/T in world)
			if(T in Tiles)
				for(var/obj/Items/Plants/P in T)
					if(P.icon_state != "big stump" && P.icon_state != "small stump")
						del(P)
		while(1)
			sleep(18000)
			Time()
			SaveMisc()
/var
	WantedHumans = list()

	Tiles = list()
	Admins = list()

	Year = 0

	Month = 0

	WorldName = 0

	Night = 1

	BanList = list()
	LizardmanList = list()
	IllithidList = list()

	Mute = 0

	ChaosIntensity = 10

	Weather = null

	Season = null

	Ruining = 0

	CanJoin = 1

	Players = list()

	WorldStrCap = 22
	WorldAgilCap = 22
	WorldEndCap = 22
	WorldIntCap = 22
	WorldSkillsCap = 22

	GainRate = 0

	MapSaves = 0

	Ranks = "<font color = teal><font size = 3>.:Human Kingdom:.<p>King - <br>Queen - <br>Priest - <p>.:Altherian Kingdom:.<p>King - <br>Queen - <br><p>.:Stahlite Kingdom:.<p>King - <br>Queen - <br><p>.:Frogman Kingdom:.<p>King - <br>Queen - <br><p>.:Snakeman Kingdom:.<p>Emperor - <br>Emperess - <br><p>.:Giant Kingdom:.<p>Leader - <p>.:Cyclops Hordes:.<p>Warlord - <p>.:Ratling Hordes:.<p>Plague King - <br>Plague Queen - <br>"
	Notes = ""
	AdminRules = "Admin Rules<p>Any action, regardless of size, should be defended if an admin asks why it was performed.<p>1. Admins should not use powers to benefit themselves.<p>2. Any major action(edits, fixes, events, spawning, punishments, ect...) Should be promptly added to the notes.<p>2B. Any action, regardless of size, should be defended if an admin asks why it was performed.<p>3. All admins should put forth an effort to maintain a proper attitude and should set a good example for players.<p>4. Any dispute between admins should be held in the form of a friendly debate, or avoided, or highly monitored and contained, and should NEVER be held over OOC.<p>5. Before hosting an event, an admin should have players vote, and the simple majority wins. Any two admins can agree to overrule the vote, however, and the event will be discounted and out of the question unless the host of the event can convince both of them to agree to overturn the overruling.<p>6. An admin should not engage an unfriendly argument with players, and should treat them with respect, even if they don't treat the admin in question with respect.<p>7. Punishment is left up to the disgression of the admin, however, the admin who performed the punishment must inform the host and defend his decision. If any other admin inquires as to why the punishment was taken, though, the punishing admin should also explain it to them and defend themselves just as they would to the host.<p>8. Any spawning for anything outside of events should be specifically added to the notes. This includes what the admin spawned, how many, and why.<p>9. Non-event single-person icon edits are not required to be added to the notes. However, if multiple player icons are edited, it must be added to the notes.<p>10. Any rewards given to a player must be for truly excellent RP and must be confirmed by a second admin. It should also be added to the notes.<p>11. If a player who is known to RP well and an admin would both like the same role in the RP, the player shall get the role. If a player who is not known to RP quite as well, but is not known to RP badly, tryouts should be held between the player, and any other players who want the role, and the admin who wants the role. Another admin shall hold the tryouts and should fairly pick the best RPers, via his own disgression, and grant that person the role."
	Story = ""
	PublicNotes = "<font color = teal><u>.:Public Notes:.</u><p>Welcome to Lands of Legend. I'd like to first off say Sorry for taking so long to Update and Thank everyone for waiting.<p>This version will no doubt contain alot of bugs due to the fact alot of tweaks to the code have been made. For a full list of Updates, click your (?) Question Mark button once logged in. Please also use the Report Bugs Option as well, I always look at this when I log in and it always helps. Thanks again, Ginseng."
	Rules = "<font color = teal><center><u>Rules</u><p>Before reading these rules, let me just remind you that these are here for everyone to see when they log in, so there is no excuse about not knowing the rules.<p>Rule One - Do NOT randomly kill Players, you may only attack people if you have warned them AND you have a Role Play Reason to attack them in the first place. A warning consists of you using the Role Play button and typing something along the lines of 'Blank swiftly extends their blade at Target and charges at them, with the intention of slashing them to bits' You would then allow at least Twenty (20) for the Target to reply. If the player says (Wait, I'm writing a reply RP!), then you must give them another 1(One) Minute to react, providing the first 1(One) Minute has already passed.<p>Rule Two - Do NOT use In Character (IC) Chat in Out of Character (OOC) Chat. This means no using in character information in out of character chat. This means you are not allowed give out locations of places, or speak of plans and/or events. Do not use OOC to Role-play with another player if you cannot find him/her. OOC chat is for asking for help, general chat, and greeting and/or checking if a certain player is online. No exceptions. <p>Rule Three - If you wish to speak Out of Character using the 'say' verb, put your text in parentheses (). <p>Rule Four - Keep your role play consistent, no turning evil suddenly or going crazy for no reason. This means you can’t suddenly become evil because someone evil asks you to join them when your actually a good person. If the guards in town attack you by default you generally have to RP an evil character. <p>Rule Five - Do NOT create Campfires in town. This will cause fire and get you banned! Admins know when a fire is created, so you will not get away with it. And do NOT burn player bodies, unless you have a RP reason. That is considered greifing, and will also result in a visit from the magical ban hammer fairy.<p>Rule Six – Don’t kill people or NPC’s for their items. Although you can obviously pick up items that a dead NPC drops, if you kill an NPC for his/her Items, and your not RPing a evil character, that is bad RP.<p>Rule Seven – Do not attack an NPC that is on your Side/Race/Faction unless it is has you trapped and wont move or you have a valid RP reason to do so. <p>Rule Eight - No foul language, spamming or trolling.<p>Rule Nine – If you are fighting another player, and you wish to flee you must RP running away using the Role-play Verb. The RP for a run must at least contain Seven(7) words, so you cant just say, 'Blank runs away from Attacker'. For Run RP's you do not need to give reaction time.<p> Rule Ten - You MUST Role-play the act of stealing an Item that belongs to someone else. you cannot grab an item that a blacksmith just created then flee. You will get punished for this. You will need to RP at least Six words for a steal RP, then give 1(One) Minute for the Victim to react.<p>Rule Elven - You MUST have a RP reason to destroy a building, damage it, block its door ways, or anything else that may cause distress to other players regarding housing.<p>Rule Twelve - Do NOT use information learned from a previous character with a newly made one, this means you can not remake with the same name and know everything you knew before. However, you can still have the same name, but you must inform people OOCly that you no longer know them or anything about them.<p>Rule Thirteen - You must give your character a proper Role-Play name that fits the setting. This means no using famous names from real life or other works of fiction, and no using futuristic sounding names. A properly named character will have both a first and a last name. Do not use titles such as 'King' 'Queen' or 't3h 1337' in your characters name. Admins can rename your character if they feel it has an inappropriate name.<p>Rule Fourteen - You can NEVER Role Play anything offensive that may upset someone OOCly, this includes Burning a book and saying its the Bible or Rapeing people RPly. <p>Rule Fifthteen - You must RP Burning or Cutting up a players corpse, the RP must at least contain Ten(10) words, and you must have a RP reason.<p>Notes - Failing to follow these SIMPLE rules will get you Deducted, with a boot and warning, then Ban if continued. - Admins keep logs of what players say, so if your Role Play sounds off, an Admin will find out, and will take action - Any Negative actions towards players needs to be Role Played, the victim must be given time to react, this is called reaction time, other wise the RP you do is void and can be ignored. If you catch somebody breaking these rules report it to an Admin, if no Admins are online, then note down the player who attacked you, their Key, the location it happened, Time, what happened, Why, ect.<p>"
client
	macro_mode=1
	Southeast()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
				..()
	Southwest()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
			..()
	Northeast()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
				..()
	Northwest()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
				..()
	North()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
				..()
	South()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
				..()
	East()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
				..()
	West()
		if(mob.Moving)
			mob.Moving = 0
			var/Speed = mob.MoveSpeed
			if(mob.Weight >= mob.WeightMax / 1.1)
				Speed += 1
			if(mob.Weight >= mob.WeightMax / 1.2)
				Speed += 1
			if(mob.Pull)
				Speed += 1
			var/BadLeg = 0
			if(mob.RightLeg <= 50)
				BadLeg = 1
			if(mob.LeftLeg <= 50)
				BadLeg = 1
			if(BadLeg && mob.Race != "Snakeman")
				Speed += 1
			if(mob.InWater && mob.Dead == 0)
				Speed += 1
				if(mob.CanSwimWell)
					Speed -= 2
				var/MoveChance = 0
				MoveChance += mob.Strength / 4 + mob.SwimmingSkill / 4
				var/Moves = 0
				Moves = prob(MoveChance)
				if(Moves == 0)
					Speed += 2
					mob.SwimmingSkill += mob.SwimmingSkillMulti / 2
					mob.GainStats(20)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				else
					mob.SwimmingSkill += mob.SwimmingSkillMulti
					mob.GainStats(10)
					if(mob.SwimmingSkill >= 100)
						mob.SwimmingSkill = 100
				if(mob.InWater == 1)
					var/Sink = 0
					Sink += mob.Weight / 10
					for(var/obj/Items/Armour/A in mob)
						if(A.suffix == "Equip")
							Sink += A.Weight / 6
					Sink -= usr.Strength / 4
					Sink -= usr.SwimmingSkill / 4
					var/Sinks = prob(Sink)
					if(Sinks)
						view() << "<font color = yellow>[mob] sinks underwater due to what they are carrying!<br>"
						mob.loc = locate(mob.x,mob.y,3)
						mob.InWater = 2
						mob.overlays -= /obj/Misc/Swim/
						mob.overlays += /obj/Misc/Bubbles/
						mob.Breathe()
			spawn(Speed)
				if(mob)
					mob.Moving = 1
			if(mob.CanMove == 0)
				return
			else
				mob.LastLoc = mob.loc
				..()
/proc
	RuinAll()
		Ruining = 1
		fdel("players/")
		fdel("map/")
		fdel("logs/")
		fdel("backups/")
		world << "<font color = teal><b><font size = 3>Deleting all Player Saves...<br>"
		world << "<font color = teal><b><font size = 3>Done...<br>"
		spawn(10)
			world << "<font color = teal><b><font size = 3>Deleting all Map Saves...<br>"
			world << "<font color = teal><b><font size = 3>Done...<br>"
			spawn(10)
				world << "<font color = teal><b><font size = 3>Deleting Logs...<br>"
				world << "<font color = teal><b><font size = 3>Done...<br>"
				spawn(10)
					world << "<font color = teal><b><font size = 3>Shutting Down...<br>"
					del(world)
	AutoReboot()
		spawn(216000)
			world << "<font color=yellow><font size =3>Server will reboot in 5 minutes!<br>"
			spawn(3000)
				world << "<font color=yellow><font size =3>Server will reboot in 30 seconds!<br>"
				SaveMap()
				SaveMisc()
				spawn(300)
					world << "<font color =yellow>World rebooting!<br>"
					world.Reboot()
	RebootProc()
		SaveMap()
		spawn(300)
			world << "<font color=yellow><font size =3>Server will reboot in 30 seconds!<br>"
			spawn(300)
				world << "<font color =yellow>World rebooting!<br>"
				world.Reboot()
	CreateOre()
		for(var/turf/Walls/SolidStone/S in block(locate(1,1,1),locate(300,300,3)))
			if(S.density && S.opacity)
				var/Ore = prob(1)
				if(Ore)
					var/OreType = rand(1,5)
					var/Path = null
					if(OreType == 1)
						var/Choose = prob(25)
						if(Choose)
							OreType = "Gold"
							Path = /obj/Items/Resources/GoldOre/
						else
							OreType = 4
					if(OreType == 2)
						var/Choose = prob(25)
						if(Choose)
							OreType = "Silver"
							Path = /obj/Items/Resources/SilverOre/
						else
							OreType = 3
					if(OreType == 3)
						OreType = "Copper"
						Path = /obj/Items/Resources/CopperOre/
					if(OreType == 4)
						OreType = "Iron"
						Path = /obj/Items/Resources/IronOre/
					if(OreType == 5)
						OreType = "Coal"
						Path = /obj/Items/Resources/Coal/
					for(var/turf/Walls/SolidStone/W in range(rand(4,6),S))
						if(W.density && W.opacity && W.Material != OreType)
							var/Choose = prob(25)
							if(Choose)
								W.Material = OreType
								W.icon_state = "[OreType]"
								W.OrePath = Path
								W.name = "[OreType] Vein"
								W.Dura += 50
	Populate()
		world.Repop()
		for(var/turf/T in world)
			if(T in Tiles)
				for(var/obj/Items/Plants/P in T)
					if(P.icon_state != "big stump" && P.icon_state != "small stump")
						del(P)
		world << "<font color =yellow>Evil stirs in the land, monsters of all shapes and sizes begin to awaken and hunt for victims...<br>"
	LoadMisc()
		var/ban_sav = "players/bans.sav"
		if(length(file(ban_sav)))
			var/savefile/B = new(ban_sav)
			B["Bans"] >> BanList

		var/admin_sav = "players/admins.sav"
		if(length(file(admin_sav)))
			var/savefile/A = new(admin_sav)
			A["Admins"] >> Admins

		var/time_sav = "map/time.sav"
		if(length(file(time_sav)))
			var/savefile/Z = new(time_sav)
			Z["Month"] >> Month
			Z["Year"] >> Year
			Z["WorldSkillsCap"] >> WorldSkillsCap
			Z["WorldStrCap"] >> WorldStrCap
			Z["WorldEndCap"] >> WorldEndCap
			Z["WorldAgilCap"] >> WorldAgilCap
			Z["WorldIntCap"] >> WorldIntCap
			Z["GainRate"] >> GainRate

		var/ranks_sav = "map/ranks.sav"
		if(length(file(ranks_sav)))
			var/savefile/R = new(ranks_sav)
			R["Ranks"] >> Ranks

		var/notes_sav = "map/notes.sav"
		if(length(file(notes_sav)))
			var/savefile/N = new(notes_sav)
			N["Notes"] >> Notes

		var/pub_notes_sav = "map/pubnotes.sav"
		if(length(file(pub_notes_sav)))
			var/savefile/P = new(pub_notes_sav)
			P["Public Notes"] >> PublicNotes

		var/story_sav = "map/story.sav"
		if(length(file(story_sav)))
			var/savefile/S = new(story_sav)
			S["Story"] >> Story
	LoadMap()
		for(var/turf/T in world)
			var/map_sav = "map/[T.x],[T.y],[T.z].sav"
			if(length(file(map_sav)))
				var/savefile/F = new(map_sav)
				F >> T
				Tiles += T
			for(var/obj/Items/Misc/StoneForge/S in T)
				if(S.icon_state == "forge lit")
					S.icon_state = "forge"
					S.Type = "Not Lit"
		world << "<font color = teal><b>Map Loaded!<br>"
	SaveMap(var/Time)
		if(Time == null)
			Time = 1
		world << "<font color = teal><b>Map Saving Soon...<br>"
		spawn(Time)
			var/Mobs = list()
			var/Objects = list()
			var/Turfs = list()
			for(var/turf/T in Tiles)
				var/In = 0
				if(T in Turfs)
					In = 1
				if(In == 0)
					Turfs += T
			for(var/turf/T in Turfs)
				spawn(1)
					for(var/mob/M in locate(T.x,T.y,T.z))
						M.LastLoc = M.loc
						M.loc = locate(0,0,0)
						Mobs += M
					for(var/obj/O in locate(T.x,T.y,T.z))
						for(var/V in O.vars)
							var/variable = V
							var/typeof=O.vars[variable]
							if(istype(typeof,/atom/))
								if(O.LastLoc == null && typeof != T)
									O.LastLoc = O.loc
									O.loc = locate(0,0,0)
									Objects += O
						if(O.name == "Rock")
							del(O)
					T.overlays -= /obj/Misc/Weather/Snow/
					T.overlays -= /obj/Misc/Weather/Rain/
					var/tile_sav = "map/[T.x],[T.y],[T.z].sav"
					var/savefile/F = new(tile_sav)
					F << T
					for(var/mob/M in Mobs)
						M.loc = M.LastLoc
					for(var/obj/O in Objects)
						O.loc = O.LastLoc
			world << "<font color = teal><b>Map Saving...<br>"
	SaveMisc()
		var/ban_sav = "players/bans.sav"
		var/savefile/B = new(ban_sav)
		B["Bans"] << BanList

		var/admin_sav = "players/admins.sav"
		var/savefile/A = new(admin_sav)
		A["Admins"] << Admins

		var/time_sav = "map/time.sav"
		var/savefile/Z = new(time_sav)
		Z["Month"] << Month
		Z["Year"] << Year
		Z["WorldSkillsCap"] << WorldSkillsCap
		Z["WorldStrCap"] << WorldStrCap
		Z["WorldEndCap"] << WorldEndCap
		Z["WorldAgilCap"] << WorldAgilCap
		Z["WorldIntCap"] << WorldIntCap
		Z["GainRate"] << GainRate

		var/ranks_sav = "map/ranks.sav"
		var/savefile/R = new(ranks_sav)
		R["Ranks"] << Ranks

		var/notes_sav = "map/notes.sav"
		var/savefile/N = new(notes_sav)
		N["Notes"] << Notes

		var/pub_notes_sav = "map/pubnotes.sav"
		var/savefile/P = new(pub_notes_sav)
		P["Public Notes"] << PublicNotes

		var/story_sav = "map/story.sav"
		var/savefile/S = new(story_sav)
		S["Story"] << Story
	Weather()
		if(Season == "Winter")
			if(Weather == null)
				Weather = "Snow"
				for(var/turf/T in block(locate(1,1,1),locate(215,250,1)))
					T.overlays -= /obj/Misc/Weather/Rain/
					if(T.Type != "Dark" && T.density == 0 && T.Type != "Inside")
						T.overlays += /obj/Misc/Weather/Snow/
				return
			else
				Weather = null
				for(var/turf/T in block(locate(1,1,1),locate(215,250,1)))
					T.overlays -= /obj/Misc/Weather/Snow/
				return
		if(Season == "Spring")
			Weather = null
			for(var/turf/T in block(locate(1,1,1),locate(215,250,1)))
				T.overlays -= /obj/Misc/Weather/Snow/
			return
		if(Season == "Autumn")
			if(Weather == null)
				Weather = "Rain"
				for(var/turf/T in block(locate(1,1,1),locate(215,250,1)))
					if(T.Type != "Dark" && T.density == 0 && T.Type != "Inside")
						T.overlays += /obj/Misc/Weather/Rain/
				CreateLightening()
				return
			else
				Weather = null
				for(var/turf/T in block(locate(1,1,1),locate(215,250,1)))
					T.overlays -= /obj/Misc/Weather/Rain/
				return
	RandomEvents(var/EventNum)
		if(EventNum == null)
			EventNum = rand(1,5)
		if(EventNum == 1)
			world << "<font color = yellow><b>From under the ground, hundreds upon hundreds of sounds could be heard. Thumps and pitter pattering of tiny feet, hordes of Ratling invaders forming an army and rushing through the dark underpaths of the known world. From every passage leading to the upper kingdoms, these creatures pour forth and attack the surface dwellers.<br>"
			for(var/obj/Misc/SewerGrate/G in world)
				var/Invaders = rand(35,50)
				while(Invaders)
					Invaders -= 1
					var/mob/NPC/Evil/Chaos/Ratling_Invader/I = new
					I.loc = G.loc
				var/Assassins = rand(5,10)
				while(Assassins)
					Assassins -= 1
					var/mob/NPC/Evil/Chaos/Ratling_Assassin/A = new
					A.loc = G.loc
		if(EventNum == 2)
			world << "<font color = yellow><b>A strange cold wind begins to blow as dark clouds form. Strange noises from under the ground could be heard across the country side. Dealthly screams, moans and voices echoe in all directions as the wind settles and a faint mist begins to set. From ancient graves the deceased begin to rise, grouping together and heading towards the living, hungry for flesh and vengence.<br>"
			for(var/obj/Items/Misc/GraveStone/G in world)
				var/Skeletons = rand(2,5)
				while(Skeletons)
					Skeletons -= 1
					var/mob/NPC/Evil/Undead/Undead_Skeleton/S = new
					S.loc = G.loc
		if(EventNum == 3)
			world << "<font color = yellow><b>The number of bandits in the area begins to steadily increase accross the land. After a while, it becomes apprant to those who wander the country side that all is not well. Once in a while, the Bandit leaders decide to form up and attack the Human Kingdom and anyone else who got in their way, and this was one such gathering. The massive, but sligthly clunky and un-organised army, begins to decend down upon the inhabbitants of the world.<br>"
			var/Bandits = rand(40,60)
			var/mob/NPC/Evil/Misc/Human_Bandit/B = new
			B.Type = "Leader"
			B.FindSuitableLocation()
			spawn(10)
				if(B)
					while(Bandits)
						Bandits -= 1
						var/mob/NPC/Evil/Misc/Human_Bandit/Ba = new
						Ba.loc = B.loc
		if(EventNum == 4)
			world << "<font color = yellow><b>Goblin numbers start to rise frantically, signs of a large horde begin to show. After some time, a rag tag squabble forms and starts to roam the country side in search of shiney objects. The Goblins leave destruction in their wake and appear to be following a large Troll.<br>"
			var/Gobs = rand(40,60)
			var/mob/NPC/Evil/Misc/Troll/Troll/T = new
			T.Type = "Leader"
			T.FindSuitableLocation()
			spawn(10)
				if(T)
					while(Gobs)
						Gobs -= 1
						var/mob/NPC/Evil/Misc/Goblin/G = new
						G.loc = T.loc
		if(EventNum == 5)
			world << "<font color = yellow><b>Like a torrent, hundreds of Kobold suddenly burst forth from a cave that leads to a vast underground network. After many years of inner fighting, this immense disgusting force of creatures had finally reached the limit on living space and had little choice to venture out. However, food was short and before long the horde was massing upon the country side in search of Nurishment.<br>"
			var/Bandits = rand(50,70)
			var/mob/NPC/Evil/Misc/Kobold/KL = new
			KL.Type = "Leader"
			KL.FindSuitableLocation()
			spawn(10)
				if(KL)
					while(Bandits)
						Bandits -= 1
						var/mob/NPC/Evil/Misc/Kobold/K = new
						K.loc = KL.loc
	CreateLightening()
		if(Season == "Autumn" && Weather == "Rain")
			var/X = rand(1,215)
			var/Y = rand(1,250)
			var/obj/Misc/Layer/L = new
			L.loc = locate(X,Y,1)
			for(var/turf/T in range(0,L))
				if(T.Type != "Dark" && T.density == 0)
					var/obj/Misc/Weather/LighteningHit/LH = new
					LH.loc = locate(X,Y,1)
					for(var/mob/M in range(0,LH))
						view(6,LH) << "<font color = yellow>[M] is struck by [LH]!<br>"
						M.Blood -= 33
						M.Pain += 50
						M.Bleed()
					var/obj/Items/Resources/Ash/A = new
					A.loc = LH.loc
			del(L)
		else
			return
		spawn(100) CreateLightening()
	Seasons()
		if(Month == 3)
			Season = "Spring"
			world << "<font color = green><font size = 4><b>It is now Spring<br>"
			Populate()
		if(Month == 6)
			Season = "Summer"
			world << "<font color = yellow><font size = 4><b>It is now Summer<br>"
			Populate()
		if(Month == 9)
			Season = "Autumn"
			world << "<font color = red><font size = 4><b>It is now Autumn<br>"
			Populate()
		if(Month == 12)
			Season = "Winter"
			world << "<font color = blue><font size = 4><b>It is now Winter<br>"
			Populate()
	DayNightCyle()
		var/Delay
		if(Night == 0)
			Night = 1
			world << "<font color =teal>The sun sets<br>"
			Delay = 10000
			for(var/turf/T in block(locate(1,1,1),locate(300,300,1)))
				if(T.OnFire == 0)
					T.luminosity = 0
			spawn(Delay)
				DayNightCyle()
			return
		if(Night)
			Night = 0
			world << "<font color =teal>The sun rises<br>"
			Delay = 20000
			for(var/turf/T in block(locate(1,1,1),locate(300,300,1)))
				if(T.Type != "Dark")
					if(T.OnFire == 0)
						T.luminosity = 1
			spawn(Delay)
				DayNightCyle()
			return
	Time()
		Month += 1
		Seasons()
		Weather()
		var/NeedRewards = list()
		WorldSkillsCap += 3
		WorldStrCap += 3
		WorldAgilCap += 3
		WorldEndCap += 3
		WorldIntCap += 3
		for(var/mob/M in Players)
			if(M.LoggedIn)
				M.SkillCap += 3
				M.StrCap += 3
				M.AgilCap += 3
				M.EndCap += 3
				M.IntCap += 3
				M.HairGrowth()
				if(M.RPpoints >= 1)
					NeedRewards += M
					if(M.RPpoints >= 100)
						M.RPpoints = 100
		for(var/mob/M in Players)
			if(M.Admin)
				var/RPers = 0
				for(var/mob/Z in NeedRewards)
					M << "<font color = teal><b>([Z.key])[Z] has [Z.RPpoints] RP Points.<br>"
					RPers = 1
				if(RPers)
					M << "<font color = teal><b>Check their logs to make sure they did not spam the Emote button, then reward them +1 in each stat for every 1 RP Point they have.<br>"
		if(Month == 12)
			Month = 0
			Year += 1
			RandomEvents()
			SaveMap(600)
			for(var/mob/M in Players)
				if(M.LoggedIn)
					M.Age += 1
					if(M.Age >= M.DieAge && M.client)
						if(M.Faction != "Undead")
							view(M) << "<font color = yellow>[M] suddenly falls to the ground grasping their heart. It seems they have died of old age and suffered a massive heart attack!<br>"
							M.Death()
		world << "<font color =green><b>It is now Year [Year], Month [Month]<br>"
		world << "<font color = teal><font size = 3>Visit <a href=http://z4.invisionfree.com/Lands_of_Legend/index.php?showtopic=264>This Guide</a> for help on how to play Lands of Legend! Or press G for an in game Help Menu.<br>"




proc
	Edit_null_display(typeof)
		if(typeof=="")return"and currently equals null"
		else return"and currently equals [typeof]"