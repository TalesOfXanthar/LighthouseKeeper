extends Node
class_name HealthComponent

@export var stats : StatsComponent

@export var health_label : Label

signal died()

# Serves a dual purpose or resetting health to max and removing temporary hit
# points.
func reset_hit_points():
	stats.current_hit_points = stats.max_hit_points
	health_label.text = "Health " + str(stats.current_hit_points)

# Function for losing health, the "clampi" function doesn't allow it to go
# below zero.
func lose_hit_points(amount):
	stats.current_hit_points = clampi(stats.current_hit_points - amount, 0, stats.max_hit_points)
	health_label.text = "Health " + str(stats.current_hit_points)
	if stats.current_hit_points == 0:
		died.emit()

# Function for losing health, the clampi function here doesn't allow it to go
# above max hit points unless the parameter for going above zero is checked, 
# allowing the gaining of temporary hit points.
func heal_hit_points(amount, heal_beyond_max = false):
	if heal_beyond_max:
		stats.current_hit_points = clampi(stats.current_hit_points + amount, 0, 9999999)
	else:
		stats.current_hit_points = clampi(stats.current_hit_points + amount, 0, stats.max_hit_points)
	health_label.text = "Health " + str(stats.current_hit_points)
