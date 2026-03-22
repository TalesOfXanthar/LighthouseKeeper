extends Node
class_name Player

@export var stats : StatsComponent
@export var health : HealthComponent

# Just starts you out with health. In the future, this will give you your saved
# stats.
func _ready() -> void:
	stats.max_hit_points = 40
	health.reset_hit_points()
