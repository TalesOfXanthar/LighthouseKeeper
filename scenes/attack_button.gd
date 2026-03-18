extends Button
class_name AttackButtonComponent

@export var attack : AttackComponent
@export var action_performer : ActionControllerComponent

func _ready() -> void:
	text = "Attack for " + str(attack.attack_damage)

func _pressed() -> void:
	attack.deal_damage()
	action_performer.perform_action()
