extends Control
class_name ChillButtons

@export var fish_button : BaseButton

@export var fisher : FishComponent
@export var top_floor : TopFloor


func _on_fish_button_pressed() -> void:
	fisher.fish()


func _on_enter_button_pressed() -> void:
	top_floor.descend.emit()
