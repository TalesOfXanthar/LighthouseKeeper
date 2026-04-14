extends Control
class_name ActionButtons

# This is just a script, probably temporary, for the text and signal of the 
# attack button.

@export var action : ActionComponent
@export var stats : StatsComponent
@export var action_performer : ActionControllerComponent

@export var attack_button : BaseButton
@export var heal_button : BaseButton


func _ready() -> void:
	var heal_amount = int((stats.max_hit_points - stats.current_hit_points) * stats.heal_percentage)

func _on_attack_button_pressed() -> void:
	action.deal_damage()
	action_performer.perform_action()
	
func _on_heal_button_pressed() -> void:
	action.heal_damage()
	action_performer.perform_action()
	if stats.heal_charges == 0:
		heal_button.disabled = true
