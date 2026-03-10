extends Button
class_name AttackButtonComponent

@export var attack : AttackComponent

func _ready() -> void:
	text = "Attack for " + str(attack.attack_damage)

func _pressed() -> void:
	attack.deal_damage()
