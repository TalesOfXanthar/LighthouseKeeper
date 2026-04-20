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
	
func transition_to_lower():
	get_node("TopFloor").queue_free()
	add_child(lower_floors_scene.instantiate())
	lower_floors_script = get_node("LowerFloors")
	
