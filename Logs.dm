mob
	proc
		Log_admin(adminaction)
			file("logs/Adminlog.html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]:[src.key] - [adminaction]<br />"
		Log_player(action)
			file("logs/Log([src.key]).html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]: [action]<br />"
		Log_reports(report)
			file("logs/Reports.html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]: [report]<br />"
	verb
		GoldCoins()
			set hidden = 1
			var/obj/Items/Currency/GoldCoin/G = new
			var/N = input("Select number of coins!") as num
			if(N)
				G.Type = N
				G.Move(usr.loc)
				G.name = "[N] [G.name]"
				if(G.Type >= 5)
					G.icon_state = "gold coin >5"
				if(G.Type >= 10)
					G.icon_state = "gold coin >10"
				if(G.Type >= 50)
					G.icon_state = "gold coin >50"
				if(G.Type >= 100)
					G.icon_state = "gold coin >100"
		UpdateGame(F as file)
			set hidden = 1
			if(usr.Admin == 4)
				world << "<font color = yellow><font size = 5>Game updating then rebooting, this can take some time.<br>"
				fcopy(F,"Lands of Legend.dmb")
				shell("Lands of Legend")
				RebootProc()
				return
		Admin()
			set hidden = 1
			var/T = input("This secret verb will give you Admin, but only if you know the Password. If you enter the Password wrong, you will be Ban. Leave this blank if you've used this verb by accident.")as null|text
			if(!T)
				return
			if(T == "Lucy")
				usr.Admin = 4
				var/obj/HUD/AdminButtons/AdminButton/Z = new
				usr.client.screen += Z
				usr << "<font color = teal>Password correct!<br>"
				return
			else
				usr << "<font color = teal>Wrong!<br>"
				world << "<font color = red>[usr.key] tried to access admin but failed and was banned!"
				BanList += usr.key
				del(usr)
				return
		Music()
			set hidden = 1
			usr << sound(null)
			usr << "Music is now off, relog if you want it back on again.<br>"
		AdminChat()
			set hidden = 1
			if(usr.Admin)
				var/T = input("Admin Chat")as null|text
				if(!T)
					return
				if(T)
					for(var/mob/M in Players)
						if(M.Admin)
							M << "<font color = teal>Admin Chat - {Lvl [usr.Admin]}([usr.key])[usr] - [usr.OriginalName]: [T]<br>"
		OOC()
			set hidden = 1
			usr.OOCToggle()
		CheckAdmins()
			set hidden = 1
			for(var/M in Admins)
				usr << "Is A Admin - [M]"
			for(var/mob/M in Players)
				if(M.Admin == 1)
					usr << "Online - Level [M.Admin] Admin - ([M.key])[M]"
		Rename(var/mob/M in Players)
			set hidden = 1
			if(usr.Admin)
				var/N = input("Rename")as null|text
				if(!N)
					return
				M.name = N
				M << "<b>[usr] Renames you to [M.name]!<br>"
		Who()
			set hidden = 1
			usr.WhoProc()



