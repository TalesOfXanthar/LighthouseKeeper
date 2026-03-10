extends Node
class_name HealthComponent

@export var health_label : Label

signal died()

@export var max_hit_points := 100
var current_hit_points := 100

func _ready() -> void:
	current_hit_points = max_hit_points
	health_label.text = "Health " + str(current_hit_points)

func lose_health(amount):
	current_hit_points -= amount
	health_label.text = "Health " + str(current_hit_points)
	if current_hit_points == 0:
		died.emit()
