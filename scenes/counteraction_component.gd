extends Node
class_name CounterActionComponent

# Script for the enemy's turn and action in response to the player's one.

@export var defendant_action_controller : ActionControllerComponent

@export var attack : AttackComponent
@export var enemy_traits : Enemy

# This is for giving a signal to the enemy script that basically says: "hey, I'm
# dead, you should swap out my base stats and reset me."
signal death_action

func _ready() -> void:
	defendant_action_controller.connect("performed_action", _defendant_performed_action)

func _defendant_performed_action():
	if enemy_traits.is_dead:
		death_action.emit()
	else:
		attack.deal_damage()
