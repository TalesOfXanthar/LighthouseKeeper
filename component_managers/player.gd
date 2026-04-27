extends Node
class_name Player

@export var stats : StatsComponent
@export var health : HealthComponent
@export var lower_floors : LowerFloors
@export var fader : FadeInOutComponent

# Just starts you out with health. In the future, this will give you your saved
# stats.
func _ready() -> void:
	health.reset_hit_points()
	health.died.connect(_fade_out_death)

func _fade_out_death() -> void:
	fader.fade_out_done.connect(_fade_out_ascend)
	fader.fade_out()
	
func _fade_out_ascend() -> void:
	fader.fade_out_done.disconnect(_fade_out_ascend)
	lower_floors.convert_inventory_to_save()
