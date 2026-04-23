extends Control
class_name ChillButtons

@export var fish_button : BaseButton

@export var fisher : FishComponent
@export var top_floor : TopFloor
@export var gear_profile : GearProfileComponent
@export var fader : FadeInOutComponent


func _on_fish_button_pressed() -> void:
	fisher.fish()

func _on_enter_button_pressed() -> void:
	fader.fade_out_done.connect(_fade_out_descend)
	fader.fade_out()

func _fade_out_descend() -> void:
	fader.fade_out_done.disconnect(_fade_out_descend)
	top_floor.convert_inventory_to_save()

func _on_gear_button_pressed() -> void:
	gear_profile.show()
