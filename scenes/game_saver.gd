extends Node

var SAVE_PATH := "user://save_data.tres"

var save_data : SaveData

signal no_loaded_data

func load_save_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_data = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		no_loaded_data.emit()

func new_save_data() -> void:
	save_data = SaveData.new()

func convert_items_to_save(
	items : Dictionary, 
	armor : String, 
	weapon : String, 
	light : String, 
	fishing_rod : String
	):
	save_data.items = items
	save_data.armor = armor
	save_data.weapon = weapon
	save_data.light = light
	save_data.fishing_rod = fishing_rod

func save():
	ResourceSaver.save(save_data, SAVE_PATH)


	
