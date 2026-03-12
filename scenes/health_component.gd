extends Node
class_name HealthComponent

@export var health_label : Label

signal died()

@export var max_hit_points := 100
var current_hit_points := 100

func reset_hit_points():
	current_hit_points = max_hit_points
	health_label.text = "Health " + str(current_hit_points)

func lose_health(amount):
	current_hit_points = clampi(current_hit_points - amount, 0, max_hit_points)
	health_label.text = "Health " + str(current_hit_points)
	if current_hit_points == 0:
		died.emit()
