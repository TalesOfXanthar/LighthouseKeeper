extends Node
class_name Player

@export var health : HealthComponent


func _ready() -> void:
	health.max_hit_points = 40
	health.reset_hit_points()
