extends Node

@export var main_menu : MainMenu
var lower_floors = preload("res://scenes/lower_floors.tscn")

func _ready() -> void:
	main_menu.enter_game.connect(transition_to_game)
	print(lower_floors)

func transition_to_game():
	$MainMenu.queue_free()
	add_child(lower_floors.instantiate())
