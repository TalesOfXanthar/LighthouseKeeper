extends Node
class_name CounterActionComponent

@export var defendant_action_controller : ActionControllerComponent

@export var attack : AttackComponent
@export var enemy_traits : Enemy

signal death_action

func _ready() -> void:
	defendant_action_controller.connect("performed_action", defendant_performed_action)

func defendant_performed_action():
	if enemy_traits.is_dead:
		death_action.emit()
	else:
		attack.deal_damage()
