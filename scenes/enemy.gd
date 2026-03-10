extends Node

@export var health : HealthComponent

@export var floor_number := 1

func _ready() -> void:
	health.connect("died", enemy_died)

func enemy_died():
	new_enemy()

func new_enemy():
	$HealthComponent.max_hit_points = 10
	$HealthComponent._ready()
	$AttackComponent.attack_damage = 5

# Here is the function for determining the spawntable set for 
# each floor. It uses integers conversion property of only 
# taking the first digit when converting from a float, which 
# this creates momentarily. 

func determine_spawntable(floor_number):
	var spawntable_number = int((floor_number - 1) / 5)
	return spawntable_number
