extends Node

@export var main_menu_script : MainMenu
@export var top_floor_script : TopFloor
@export var lower_floors_script : LowerFloors

var lower_floors_scene = preload("res://scenes/lower_floors.tscn")
var top_floor_scene = preload("res://scenes/top_floor.tscn")

func _ready() -> void:
	main_menu_script.enter_game.connect(transition_to_game)

func transition_to_game():
	$MainMenu.queue_free()
	add_child(top_floor_scene.instantiate())
	top_floor_script = get_node("TopFloor")
	top_floor_script.descend.connect(transition_to_lower)
	var save_data = GameSaver.save_data
	top_floor_script.convert_save_to_inventory(
		GameSaver.save_data.items, 
		GameSaver.save_data.armor, 
		GameSaver.save_data.weapon,
		GameSaver.save_data.light, 
		GameSaver.save_data.fishing_rod)
	
func transition_to_lower(inventory, armor, weapon, light, fishing_rod):
	get_node("TopFloor").queue_free()
	add_child(lower_floors_scene.instantiate())
	lower_floors_script = get_node("LowerFloors")
	lower_floors_script.ascend.connect(transition_to_higher)
	lower_floors_script.convert_save_to_inventory(inventory, armor, weapon, light, fishing_rod)
	
func transition_to_higher(inventory, armor, weapon, light, fishing_rod):
	get_node("LowerFloors").queue_free()
	add_child(top_floor_scene.instantiate())
	top_floor_script = get_node("TopFloor")
	top_floor_script.descend.connect(transition_to_lower)
	top_floor_script.convert_save_to_inventory(inventory, armor, weapon, light, fishing_rod)
