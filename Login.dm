mob
	Logout()
		for(var/mob/M in Players)
			if(M.Admin)
				M << "<font color = teal>([usr.key])[usr] Logs Out!<br>"
		usr.RemoveOwnedItems()
		range(6,usr) << "<font color = teal>([usr.key])[usr] Logs Out!<br>"
		usr.Save()
		del(usr)
	Login()
		if(usr.client.address in BanList)
			usr << "You are banned..."
			del(usr)
			return
		if(usr.key in BanList)
			usr << "You are banned..."
			del(usr)
			return
		/*if(!usr.client.address || usr.client.address == world.address || usr.client.address == world.internet_address || usr.client.address == "127.0.0.1")
			usr.Admin = 4
			var/obj/Misc/Admins/Z = new
			Z.Value = 4
			Z.name = usr.key
			Admins += Z
			usr << "Localhost detected: Your rank is now Head Admin level."*/
		var/image/I = new('Target.dmi',usr)
		loadadmins()
		usr.TargetIcon = I
		usr.loc = locate(11,11,2)
		usr.density = 0
		usr.CanMove = 0
		usr.luminosity = 0
		usr.client.mouse_pointer_icon = 'Cursor.dmi'
		usr << sound('Intro.mid',1)
		for(var/mob/M in Players)
			if(M.Admin)
				M << "<font color = teal>[usr] Logs In!<br>"
		var/html_doc="<head><title>Public Notes</title></head><body bgcolor=#000000 text=#FFFF00><center>[PublicNotes]"
		usr<<browse(Rules,"window=Rules")
		usr<<browse('TOS.txt',"window=Terms of Service")
		usr<<browse('GPL.txt',"window=GPL")
		usr<<browse('AGPL.txt',"window=AGPL")
		usr<<browse(html_doc,"window=Public Notes")
		usr << "<font color = blue><b>.:Rules:. - This is a RP game, you must never use Out of Character (OOC) information in a In Character (IC) Role Play (RP), failure to follow this -VERY- simple rule will most likely end up in a Punish.<p>"
		usr << "Macros - S = Say, O = OOC, R = RolePlay<p>"
		usr << "<font color =teal>It is Year [Year], Month [Month]<p>"
		if(usr.client.IsByondMember())
			var/Add_GobKoboldLizard_instead
			var/InList = 0
			if(usr.key in LizardmanList)
				InList = 1
			if(InList == 0)
				LizardmanList += usr.key
				usr << "<font color = teal><font size = 4><b>Thank you for being a Member and supporting Byond. You can now play as a Lizardman.<br>"
		Players += usr