mob
	proc
		CraftBoneArmour(var/obj/Bone,var/obj/W)
			if(Bone && W)
				var/AddedDefense = 0
				var/AddedDura = 0
				var/Qual = null
				W.Weight += Bone.Weight
				AddedDura += Bone.Weight / 2
				AddedDura += Bone.CraftPotential / 4
				AddedDefense += Bone.Weight / 4
				if(src.BoneCraftSkill <= 1)
					Qual = "Extremely Poor"
					AddedDefense += 1
					AddedDefense += Bone.CraftPotential / 40
					AddedDura += 1
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 10)
					Qual = "Very Poor"
					AddedDefense += Bone.CraftPotential / 40
					AddedDefense += rand(2,4)
					AddedDura += rand(1,3)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 20)
					Qual = "Poor"
					AddedDefense += Bone.CraftPotential / 35
					AddedDefense += rand(4,5)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 30)
					Qual = "Average"
					AddedDefense += Bone.CraftPotential / 35
					AddedDefense += rand(5,6)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 40)
					Qual = "Above Average"
					AddedDefense += Bone.CraftPotential / 30
					AddedDefense += rand(6,7)
					AddedDura += rand(15,20)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 50)
					Qual = "Good"
					AddedDefense += Bone.CraftPotential / 30
					AddedDefense += rand(7,8)
					AddedDura += rand(20,25)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 60)
					Qual = "Very Good"
					AddedDefense += Bone.CraftPotential / 25
					AddedDefense += rand(8,9)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 70)
					Qual = "Excellent"
					AddedDefense += Bone.CraftPotential / 25
					AddedDefense += rand(9,10)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 80)
					Qual = "Grand"
					AddedDefense += Bone.CraftPotential / 20
					AddedDefense += rand(10,11)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 90)
					Qual = "Epic"
					AddedDefense += Bone.CraftPotential / 19
					AddedDefense += rand(12,13)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill <= 100)
					Qual = "Epic"
					AddedDefense += Bone.CraftPotential / 19
					AddedDefense += rand(13,14)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.BoneCraftSkill >= 101)
					Qual = "Legendary"
					AddedDefense += Bone.CraftPotential / 18
					AddedDefense += rand(14,15)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from Bone. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
		CraftLeatherArmour(var/obj/Leather,var/obj/W)
			if(Leather && W)
				var/AddedDefense = 0
				var/AddedDura = 0
				var/Qual = null
				W.Weight += Leather.Weight
				AddedDura += Leather.Weight / 2
				AddedDura += Leather.CraftPotential / 4
				AddedDefense += Leather.Weight / 4
				if(src.LeatherCraftSkill <= 1)
					Qual = "Extremely Poor"
					AddedDefense += Leather.CraftPotential / 40
					AddedDefense += 1
					AddedDura += 1
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 10)
					Qual = "Very Poor"
					AddedDefense += Leather.CraftPotential / 40
					AddedDefense += rand(3,4)
					AddedDura += rand(1,3)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 20)
					Qual = "Poor"
					AddedDefense += Leather.CraftPotential / 35
					AddedDefense += rand(4,5)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 30)
					Qual = "Average"
					AddedDefense += Leather.CraftPotential / 35
					AddedDefense += rand(5,6)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 40)
					Qual = "Above Average"
					AddedDefense += Leather.CraftPotential / 30
					AddedDefense += rand(6,7)
					AddedDura += rand(15,20)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 50)
					Qual = "Good"
					AddedDefense += Leather.CraftPotential / 30
					AddedDefense += rand(7,8)
					AddedDura += rand(20,25)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 60)
					Qual = "Very Good"
					AddedDefense += Leather.CraftPotential / 25
					AddedDefense += rand(8,9)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 70)
					Qual = "Excellent"
					AddedDefense += Leather.CraftPotential / 25
					AddedDefense += rand(9,10)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 80)
					Qual = "Grand"
					AddedDefense += Leather.CraftPotential / 20
					AddedDefense += rand(10,11)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 90)
					Qual = "Epic"
					AddedDefense += Leather.CraftPotential / 19
					AddedDefense += rand(14,15)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill <= 100)
					Qual = "Epic"
					AddedDefense += Leather.CraftPotential / 19
					AddedDefense += rand(14,15)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.LeatherCraftSkill >= 101)
					Qual = "Legendary"
					AddedDefense += Leather.CraftPotential / 18
					AddedDefense += rand(15,16)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Leather.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
		CraftArmour(var/obj/Ingot,var/obj/W)
			if(Ingot && W)
				var/AddedDefense = 0
				var/AddedDura = 0
				var/Qual = null
				if(Ingot.Material == "Iron")
					AddedDefense += rand(2,3)
					AddedDura += 25
				if(Ingot.Material == "Silver")
					AddedDefense += 1
					AddedDura += 15
				if(Ingot.Material == "Gold")
					AddedDefense += 1
					AddedDura += 10
				if(Ingot.Material == "Copper")
					AddedDefense += 1
					AddedDura += 5
				W.Weight += Ingot.Weight
				AddedDura += Ingot.Weight / 2
				AddedDura += Ingot.CraftPotential / 4
				AddedDefense += Ingot.Weight / 4
				if(src.ForgingSkill <= 1)
					Qual = "Extremely Poor"
					AddedDefense += Ingot.CraftPotential / 40
					AddedDefense += 1
					AddedDura += 1
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 10)
					Qual = "Very Poor"
					AddedDefense += Ingot.CraftPotential / 40
					AddedDefense += rand(1,2)
					AddedDura += rand(1,3)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 20)
					Qual = "Poor"
					AddedDefense += Ingot.CraftPotential / 35
					AddedDefense += rand(2,3)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 30)
					Qual = "Average"
					AddedDefense += Ingot.CraftPotential / 35
					AddedDefense += rand(3,4)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 40)
					Qual = "Above Average"
					AddedDefense += Ingot.CraftPotential / 30
					AddedDefense += rand(4,5)
					AddedDura += rand(15,20)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 50)
					Qual = "Good"
					AddedDefense += Ingot.CraftPotential / 30
					AddedDefense += rand(5,6)
					AddedDura += rand(20,25)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 60)
					Qual = "Very Good"
					AddedDefense += Ingot.CraftPotential / 25
					AddedDefense += rand(6,7)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 70)
					Qual = "Excellent"
					AddedDefense += Ingot.CraftPotential / 25
					AddedDefense += rand(7,8)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 80)
					Qual = "Grand"
					AddedDefense += Ingot.CraftPotential / 20
					AddedDefense += rand(8,9)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 90)
					Qual = "Epic"
					AddedDefense += Ingot.CraftPotential / 19
					AddedDefense += rand(10,11)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 100)
					Qual = "Epic"
					AddedDefense += Ingot.CraftPotential / 19
					AddedDefense += rand(10,11)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill >= 101)
					Qual = "Legendary"
					AddedDefense += Ingot.CraftPotential / 18
					AddedDefense += rand(12,13)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.Defense = AddedDefense
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
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
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 10)
					Qual = "Very Poor"
					AddedDMG += Ingot.CraftPotential / 40
					W.Quality = rand(1,2)
					AddedDura += rand(1,2)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 20)
					Qual = "Poor"
					AddedDMG += Ingot.CraftPotential / 35
					W.Quality = rand(2,3)
					AddedDura += rand(3,5)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 30)
					Qual = "Average"
					AddedDMG += Ingot.CraftPotential / 35
					W.Quality = rand(3,5)
					AddedDura += rand(10,15)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
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
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 60)
					Qual = "Very Good"
					AddedDMG += Ingot.CraftPotential / 25
					W.Quality = rand(13,15)
					AddedDura += rand(25,30)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 70)
					Qual = "Excellent"
					AddedDMG += Ingot.CraftPotential / 25
					W.Quality = rand(15,17)
					AddedDura += rand(30,35)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 80)
					Qual = "Grand"
					AddedDMG += Ingot.CraftPotential / 20
					W.Quality = rand(17,20)
					AddedDura += rand(40,45)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 90)
					Qual = "Epic"
					AddedDMG += Ingot.CraftPotential / 19
					W.Quality = rand(20,22)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill <= 100)
					Qual = "Epic"
					AddedDMG += Ingot.CraftPotential / 19
					W.Quality = rand(20,22)
					AddedDura += rand(60,70)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
					return
				if(src.ForgingSkill >= 101)
					Qual = "Legendary"
					AddedDMG += Ingot.CraftPotential / 18
					W.Quality = rand(22,24)
					AddedDura += rand(80,100)
					W.Dura = AddedDura
					W.desc = "This is a [W], made from [Ingot.Material]. The date it was created is etched on the side, Year [Year], Month [Month]. The [W] seems to be of [Qual] Quality."
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
					src.Defense = rand(1,2)
					src.Weight += 5
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(1,2)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Very Poor Quality."
			if(Q == 2)
				src.Dura = 50
				if(src.ObjectTag == "Armour")
					if(src.DefenseType == "Cloth")
						src.Defense = rand(1,2)
						src.Weight += 1
					if(src.DefenseType == "Leather")
						src.Defense = rand(1,3)
						src.Weight += 2
					if(src.DefenseType == "Chain")
						src.Defense = rand(2,3)
						src.Weight += 4
					if(src.DefenseType == "Plate")
						src.Defense = rand(3,4)
						src.Weight += 8
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(2,3)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Poor Quality."
			if(Q == 3)
				src.Dura = 70
				if(src.ObjectTag == "Armour")
					if(src.DefenseType == "Cloth")
						src.Defense = rand(1,3)
						src.Weight += 1
					if(src.DefenseType == "Leather")
						src.Defense = rand(2,3)
						src.Weight += 2
					if(src.DefenseType == "Chain")
						src.Defense = rand(3,4)
						src.Weight += 4
					if(src.DefenseType == "Plate")
						src.Defense = rand(4,5)
						src.Weight += 8
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(3,5)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Average Quality."
			if(Q == 4)
				src.Dura = 100
				if(src.ObjectTag == "Armour")
					if(src.DefenseType == "Cloth")
						src.Defense = rand(2,3)
						src.Weight += 1
					if(src.DefenseType == "Leather")
						src.Defense = rand(3,4)
						src.Weight += 2
					if(src.DefenseType == "Chain")
						src.Defense = rand(4,5)
						src.Weight += 4
					if(src.DefenseType == "Plate")
						src.Defense = rand(5,6)
						src.Weight += 8
				if(src.ObjectTag == "Weapon")
					src.Quality = rand(5,8)
					src.Weight += 10
				src.desc = "This is [src] looks to be made from [src.Material], it looks of Above Average Quality."