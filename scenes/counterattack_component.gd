extends Node
class_name CounterattackComponent

@export var defendant_attack_button : Button

@export var attack : AttackComponent
@export var enemy_traits : Enemy

func _ready() -> void:
	defendant_attack_button.connect("pressed", defendant_attacked)
	

func defendant_attacked():
	attack.deal_damage()
