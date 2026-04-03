extends Control
class_name ActionButtons

# This is just a script, probably temporary, for the text and signal of the 
# attack button.

@export var action : ActionComponent
@export var stats : StatsComponent
@export var action_performer : ActionControllerComponent

@export var attack_button : Button
@export var heal_button : Button


func _ready() -> void:
	attack_button.text = "Attack for " + str(stats.attack_damage)
	var heal_amount = int((stats.max_hit_points - stats.current_hit_points) * stats.heal_percentage)
	heal_button.text =  "Heal for " + str(heal_amount)

func _on_attack_button_pressed() -> void:
	action.deal_damage()
	action_performer.perform_action()
	heal_button.text =  "Heal for " + str(int((stats.max_hit_points - stats.current_hit_points) * stats.heal_percentage))
	attack_button.text = "Attack for " + str(stats.attack_damage)
	
func _on_heal_button_pressed() -> void:
	action.heal_damage()
	action_performer.perform_action()
	heal_button.text =  "Heal for " + str(int((stats.max_hit_points - stats.current_hit_points) * stats.heal_percentage))
	if stats.heal_charges == 0:
		heal_button.disabled = true
