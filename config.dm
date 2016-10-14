mob/proc/loadadmins()
	var/text = file2text("config/admins.txt")
	if (!text)
	else
		var/list/lines = dd_text2list(text, "\n")
		for(var/line in lines)
			if (!line)
				continue
			if (copytext(line, 1, 2) == ";")
				continue
			var/dkey = copytext(line, 1, length(line)+1)
			if("[dkey]"=="[usr.ckey] = 5")
				usr.Admin = 5
				var/obj/Misc/Admins/Z = new
				Z.Value = 5
				Z.name = usr.key
				Admins += Z
				usr << "Admins Reloaded: Your rank is now super admin level."
			if("[dkey]"=="[usr.ckey] = 4")
				usr.Admin = 4
				var/obj/Misc/Admins/Z = new
				Z.Value = 4
				Z.name = usr.key
				Admins += Z
				usr << "Admins Reloaded: Your rank is now advanced admin level."
			if("[dkey]"=="[usr.ckey] = 3")
				usr.Admin = 3
				var/obj/Misc/Admins/Z = new
				Z.Value = 3
				Z.name = usr.key
				Admins += Z
				usr << "Admins Reloaded: Your rank is now story admin level."
			if("[dkey]"=="[usr.ckey] = 2")
				usr.Admin = 2
				var/obj/Misc/Admins/Z = new
				Z.Value = 2
				Z.name = usr.key
				Admins += Z
				usr << "Admins Reloaded: Your rank is now basic admin level."
			if("[dkey]"=="[usr.ckey] = 1")
				usr.Admin = 1
				var/obj/Misc/Admins/Z = new
				Z.Value = 1
				Z.name = usr.key
				Admins += Z
				usr << "Admins Reloaded: Your rank is now server admin level."