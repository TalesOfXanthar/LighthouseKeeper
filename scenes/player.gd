extends Node
class_name Player

@export var health : HealthComponent
@export var enemy : Enemy


func _ready() -> void:
	# The idea that the player's health resets on every encounter is still 
	# unclear if were implementing that, uncomment code below for that feature
	# to be implemented.
	#enemy.connect("new_enemy", rejuvinate_player)
	health.max_hit_points = 40
	health.reset_hit_points()

func rejuvinate_player():
	health.reset_hit_points()
