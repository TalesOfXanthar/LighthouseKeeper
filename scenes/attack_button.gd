extends Button
class_name AttackButtonComponent

# This is just a script, probably temporary, for the text and signal of the 
# attack button.

@export var attack : AttackComponent
@export var stats : StatsComponent
@export var action_performer : ActionControllerComponent

func _ready() -> void:
	text = "Attack for " + str(stats.attack_damage)

func _pressed() -> void:
	attack.deal_damage()
	action_performer.perform_action()
