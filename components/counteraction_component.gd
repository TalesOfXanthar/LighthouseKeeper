extends Node
class_name CounterActionComponent

# Script for the enemy's turn and action in response to the player's one.

@export var defendant_action_controller : ActionControllerComponent
@export var fader : FadeInOutComponent

@export var action : ActionComponent
@export var enemy_traits : Enemy
@export var health : HealthComponent

# This is for giving a signal to the enemy script that basically says: "hey, I'm
# dead, you should swap out my base stats and reset me."
signal death_action

func _ready() -> void:
	defendant_action_controller.connect("performed_action", _defendant_performed_action)
	fader.fade_out_done.connect(death_action_after_timer)

func _defendant_performed_action():
	if health.is_dead:
		fader.fade_out()
	else:
		action.deal_damage()

func death_action_after_timer():
	death_action.emit()
