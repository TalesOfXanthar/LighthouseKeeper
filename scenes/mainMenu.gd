extends Node
class_name MainMenu

signal enter_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_credit_button_pressed() -> void:
	print("debug")
	$"Menu Buttons".hide()
	$Credits.show()


func _on_credit_close_pressed() -> void:
	$Credits.hide()
	$"Menu Buttons".show()


func _on_new_game_button_pressed() -> void:
	var fishing_pools_json = "res://jsons/fishing_pools.json"
	var fishing_pools_string = FileAccess.get_file_as_string(fishing_pools_json)
	var file = FileAccess.open("user://fishing_pools.json", FileAccess.WRITE)
	file.store_string(fishing_pools_string)
	file.close()
	GameSaver.new_save_data()
	enter_game.emit()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_continue_button_pressed() -> void:
	GameSaver.load_save_data()
	enter_game.emit()
