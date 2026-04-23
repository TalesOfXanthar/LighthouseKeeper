extends Node

var recipeCount = 0
var recipe = {}
var recipeValues = {}
var recipes = {}

var items = {
	3: "Rock",
	2: "Fish Bone",
	1: "Fish"
}

func createRecipe(rec, nam):
	recipeValues[recipeCount] = rec
	recipeCount += 1
	recipes[str(rec)] = nam
	print ("NEW RECIPE")
	print(recipes[str(rec)], " : ", rec)
	
func saveC():
	var saveC_arr = [recipes, recipeValues, recipeCount]
	
	return saveC_arr
	
func save_craft():
	var save_craft = FileAccess.open("user://crafting.save", FileAccess.READ)
	var json_string = JSON.stringify(saveC())
	save_craft.store_line(json_string)
	
#func load_craft():
	#if not FileAccess
