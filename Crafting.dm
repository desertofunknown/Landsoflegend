mob
	proc
		CraftBoneArmour(var/obj/Bone,var/obj/W)
			if(Bone && W)
				var/AddedDefence = 0
				var/AddedDura = 0
				var/Qual = null
				W.Weight += Bone.Weight
				AddedDura += Bone.Weight / 2
				AddedDura += Bone.CraftPotential / 4
				AddedDefence += Bone.Weight / 4
				if(src.BoneCraftSkill <= 1)
					Qual = "Extremely Poor"
					AddedDefence += 1
					AddedDefence += Bone.CraftPotential / 40
					AddedDura += 1
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 10)
					Qual = "Very Poor"
					AddedDefence += Bone.CraftPotential / 40
					AddedDefence += rand(2,4)
					AddedDura += rand(1,3)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 20)
					Qual = "Poor"
					AddedDefence += Bone.CraftPotential / 35
					AddedDefence += rand(4,5)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 30)
					Qual = "Average"
					AddedDefence += Bone.CraftPotential / 35
					AddedDefence += rand(5,6)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 40)
					Qual = "Above Average"
					AddedDefence += Bone.CraftPotential / 30
					AddedDefence += rand(6,7)
					AddedDura += rand(15,20)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 50)
					Qual = "Good"
					AddedDefence += Bone.CraftPotential / 30
					AddedDefence += rand(7,8)
					AddedDura += rand(20,25)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 60)
					Qual = "Very Good"
					AddedDefence += Bone.CraftPotential / 25
					AddedDefence += rand(8,9)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 70)
					Qual = "Excellent"
					AddedDefence += Bone.CraftPotential / 25
					AddedDefence += rand(9,10)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 80)
					Qual = "Grand"
					AddedDefence += Bone.CraftPotential / 20
					AddedDefence += rand(10,11)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 90)
					Qual = "Epic"
					AddedDefence += Bone.CraftPotential / 19
					AddedDefence += rand(12,13)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 100)
					Qual = "Epic"
					AddedDefence += Bone.CraftPotential / 19
					AddedDefence += rand(13,14)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill >= 101)
					Qual = "Legendary"
					AddedDefence += Bone.CraftPotential / 18
					AddedDefence += rand(14,15)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from Bone. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
		CraftLeatherArmour(var/obj/Leather,var/obj/W)
			if(Leather && W)
				var/AddedDefence = 0
				var/AddedDura = 0
				var/Qual = null
				W.Weight += Leather.Weight
				AddedDura += Leather.Weight / 2
				AddedDura += Leather.CraftPotential / 4
				AddedDefence += Leather.Weight / 4
				if(src.LeatherCraftSkill <= 1)
					Qual = "Extremely Poor"
					AddedDefence += Leather.CraftPotential / 40
					AddedDefence += 1
					AddedDura += 1
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 10)
					Qual = "Very Poor"
					AddedDefence += Leather.CraftPotential / 40
					AddedDefence += rand(3,4)
					AddedDura += rand(1,3)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 20)
					Qual = "Poor"
					AddedDefence += Leather.CraftPotential / 35
					AddedDefence += rand(4,5)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 30)
					Qual = "Average"
					AddedDefence += Leather.CraftPotential / 35
					AddedDefence += rand(5,6)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 40)
					Qual = "Above Average"
					AddedDefence += Leather.CraftPotential / 30
					AddedDefence += rand(6,7)
					AddedDura += rand(15,20)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 50)
					Qual = "Good"
					AddedDefence += Leather.CraftPotential / 30
					AddedDefence += rand(7,8)
					AddedDura += rand(20,25)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 60)
					Qual = "Very Good"
					AddedDefence += Leather.CraftPotential / 25
					AddedDefence += rand(8,9)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 70)
					Qual = "Excellent"
					AddedDefence += Leather.CraftPotential / 25
					AddedDefence += rand(9,10)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 80)
					Qual = "Grand"
					AddedDefence += Leather.CraftPotential / 20
					AddedDefence += rand(10,11)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 90)
					Qual = "Epic"
					AddedDefence += Leather.CraftPotential / 19
					AddedDefence += rand(14,15)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 100)
					Qual = "Epic"
					AddedDefence += Leather.CraftPotential / 19
					AddedDefence += rand(14,15)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill >= 101)
					Qual = "Legendary"
					AddedDefence += Leather.CraftPotential / 18
					AddedDefence += rand(15,16)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Leather.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
		CraftArmour(var/obj/Ingot,var/obj/W)
			if(Ingot && W)
				var/AddedDefence = 0
				var/AddedDura = 0
				var/Qual = null
				if(Ingot.Material == "Iron")
					AddedDefence += rand(2,3)
					AddedDura += 25
				if(Ingot.Material == "Silver")
					AddedDefence += 1
					AddedDura += 15
				if(Ingot.Material == "Gold")
					AddedDefence += 1
					AddedDura += 10
				if(Ingot.Material == "Copper")
					AddedDefence += 1
					AddedDura += 5
				W.Weight += Ingot.Weight
				AddedDura += Ingot.Weight / 2
				AddedDura += Ingot.CraftPotential / 4
				AddedDefence += Ingot.Weight / 4
				if(src.ForgingSkill <= 1)
					Qual = "Extremely Poor"
					AddedDefence += Ingot.CraftPotential / 40
					AddedDefence += 1
					AddedDura += 1
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 10)
					Qual = "Very Poor"
					AddedDefence += Ingot.CraftPotential / 40
					AddedDefence += rand(1,2)
					AddedDura += rand(1,3)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 20)
					Qual = "Poor"
					AddedDefence += Ingot.CraftPotential / 35
					AddedDefence += rand(2,3)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 30)
					Qual = "Average"
					AddedDefence += Ingot.CraftPotential / 35
					AddedDefence += rand(3,4)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 40)
					Qual = "Above Average"
					AddedDefence += Ingot.CraftPotential / 30
					AddedDefence += rand(4,5)
					AddedDura += rand(15,20)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 50)
					Qual = "Good"
					AddedDefence += Ingot.CraftPotential / 30
					AddedDefence += rand(5,6)
					AddedDura += rand(20,25)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 60)
					Qual = "Very Good"
					AddedDefence += Ingot.CraftPotential / 25
					AddedDefence += rand(6,7)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 70)
					Qual = "Excellent"
					AddedDefence += Ingot.CraftPotential / 25
					AddedDefence += rand(7,8)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 80)
					Qual = "Grand"
					AddedDefence += Ingot.CraftPotential / 20
					AddedDefence += rand(8,9)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 90)
					Qual = "Epic"
					AddedDefence += Ingot.CraftPotential / 19
					AddedDefence += rand(10,11)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 100)
					Qual = "Epic"
					AddedDefence += Ingot.CraftPotential / 19
					AddedDefence += rand(10,11)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill >= 101)
					Qual = "Legendary"
					AddedDefence += Ingot.CraftPotential / 18
					AddedDefence += rand(12,13)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.Defence = AddedDefence
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
		CraftWeapon(var/obj/Ingot,var/obj/W)
			if(Ingot && W)
				var/AddedDMG = 0
				var/AddedDura = 0
				var/Qual = null
				if(Ingot.Material == "Iron")
					AddedDMG += rand(2,3)
					AddedDura += 33
				if(Ingot.Material == "Silver")
					AddedDMG += rand(1,3)
					AddedDura += 20
				if(Ingot.Material == "Gold")
					AddedDMG += rand(1,2)
					AddedDura += 15
				if(Ingot.Material == "Copper")
					AddedDMG += rand(1,2)
					AddedDura += 7
				W.Weight += Ingot.Weight
				AddedDura += Ingot.Weight / 2
				AddedDura += Ingot.CraftPotential / 3
				AddedDMG += Ingot.Weight / 4
				if(src.ForgingSkill <= 1)
					Qual = "Extremely Poor"
					AddedDMG += Ingot.CraftPotential / 40
					W.Quality = 1
					AddedDura += 1
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 10)
					Qual = "Very Poor"
					AddedDMG += Ingot.CraftPotential / 40
					W.Quality = rand(1,2)
					AddedDura += rand(1,2)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 20)
					Qual = "Poor"
					AddedDMG += Ingot.CraftPotential / 35
					W.Quality = rand(2,3)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 30)
					Qual = "Average"
					AddedDMG += Ingot.CraftPotential / 35
					W.Quality = rand(3,5)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 40)
					Qual = "Above Average"
					AddedDMG += Ingot.CraftPotential / 30
					W.Quality = rand(5,8)
					AddedDura += rand(15,20)
					W.Dura = AddedDura
					return
				if(src.ForgingSkill <= 50)
					Qual = "Good"
					AddedDMG += Ingot.CraftPotential / 30
					W.Quality = rand(8,13)
					AddedDura += rand(20,25)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 60)
					Qual = "Very Good"
					AddedDMG += Ingot.CraftPotential / 25
					W.Quality = rand(13,15)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 70)
					Qual = "Excellent"
					AddedDMG += Ingot.CraftPotential / 25
					W.Quality = rand(15,17)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 80)
					Qual = "Grand"
					AddedDMG += Ingot.CraftPotential / 20
					W.Quality = rand(17,20)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 90)
					Qual = "Epic"
					AddedDMG += Ingot.CraftPotential / 19
					W.Quality = rand(20,22)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 100)
					Qual = "Epic"
					AddedDMG += Ingot.CraftPotential / 19
					W.Quality = rand(20,22)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill >= 101)
					Qual = "Legendary"
					AddedDMG += Ingot.CraftPotential / 18
					W.Quality = rand(22,24)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.desc = "This is a [W], it is made from [Ingot.Material]. The Date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
obj
	proc
		RandomItemQuality()
			if(src.Material)
				var/E = "[src.EquipState]"
				src.CarryState = "[src.Material] [src.icon_state]"
				src.EquipState = "[src.Material] [E] equip"
			var/Q = rand(1,4)
			if(Q == 1)
				src.Dura = 30
				if(src.ObjectTag == "Armour")
					src.Defence = rand(1,2)
					src.Weight += 5
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(1,2)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Very Poor Quality."
			if(Q == 2)
				src.Dura = 50
				if(src.ObjectTag == "Armour")
					if(src.DefenceType == "Cloth")
						src.Defence = rand(1,2)
						src.Weight += 1
					if(src.DefenceType == "Leather")
						src.Defence = rand(1,3)
						src.Weight += 2
					if(src.DefenceType == "Chain")
						src.Defence = rand(2,3)
						src.Weight += 4
					if(src.DefenceType == "Plate")
						src.Defence = rand(3,4)
						src.Weight += 8
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(2,3)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Poor Quality."
			if(Q == 3)
				src.Dura = 70
				if(src.ObjectTag == "Armour")
					if(src.DefenceType == "Cloth")
						src.Defence = rand(1,3)
						src.Weight += 1
					if(src.DefenceType == "Leather")
						src.Defence = rand(2,3)
						src.Weight += 2
					if(src.DefenceType == "Chain")
						src.Defence = rand(3,4)
						src.Weight += 4
					if(src.DefenceType == "Plate")
						src.Defence = rand(4,5)
						src.Weight += 8
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(3,5)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Average Quality."
			if(Q == 4)
				src.Dura = 100
				if(src.ObjectTag == "Armour")
					if(src.DefenceType == "Cloth")
						src.Defence = rand(2,3)
						src.Weight += 1
					if(src.DefenceType == "Leather")
						src.Defence = rand(3,4)
						src.Weight += 2
					if(src.DefenceType == "Chain")
						src.Defence = rand(4,5)
						src.Weight += 4
					if(src.DefenceType == "Plate")
						src.Defence = rand(5,6)
						src.Weight += 8
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(5,8)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Above Average Quality."