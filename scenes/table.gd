extends Node2D
#@onready var crafting = $".."
#var table = [0,0,0,0,0,0,0,0,0]
#var recipe = {}
#var items = 0 
#var firstItem = 0
#var record = false
#
#func updateTable():
	#if !record:
		#items = 0
		#recipe = {}
		#firstItem = 0
		#for n in range(get_child_count()):
			#table[n] = int(get_child(n).num)
			#if table[n] != 0:
				#if items == 0:
					#recipe[str(items)] = [crafting.items[table[n]], firstItem]
					#items += 1
					#firstItem = n
				#else:
					#recipe[str(items)] = [crafting.items[table[n]], n - firstItem]
					#items += 1
		#for n in crafting.recipeValues:
			#if str(crafting.recipeValues[str(n)] == str(recipe)):
				#print(crafting.recipes[str(recipe)])
