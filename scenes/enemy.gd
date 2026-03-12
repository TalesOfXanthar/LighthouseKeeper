extends Node
class_name Enemy

@export var health : HealthComponent
@export var attack : AttackComponent

@export var floor_number := 0

var traits_json = "res://traits.json"
var traits_string = FileAccess.get_file_as_string(traits_json)
var traits_dictionary = JSON.parse_string(traits_string)
var spawntables = traits_dictionary["spawntables"]
var enemy_traits = traits_dictionary["enemies"]

# Connects the signal emitted by health so it actually registers here,
# and chooses a new enemy. This is the reason why we start at floor 0
# and not floor 1, because the enemy_died() automatically upticks the floor
# by 1 anyways.
func _ready() -> void:
	health.connect("died", enemy_died)
	enemy_died()


# This function chooses a new enemy. The reason we call it at the ready
# function is so it can randomly choose the first enemy. Might have to
# change later if we want to prevent duplicate enemies in a row.
func enemy_died():
	floor_number += 1
	var current_spawntable = spawntables[_floor_to_spawntable(floor_number)]
	
	# Subtract one here since the len function starts at 1, not 0 like 
	# arrays do.
	var enemy_picker = randi_range(0, len(current_spawntable) - 1)
	var enemy_name = current_spawntable[enemy_picker]
	_new_enemy(enemy_name)

func _new_enemy(enemy_name):
	var current_enemy_traits = traits_dictionary["enemies"][enemy_name]
	health.max_hit_points = current_enemy_traits["hit_points"]
	health.reset_hit_points()
	attack.attack_damage = current_enemy_traits["attack_damage"]

# Here is the function for determining the spawntable set for 
# each floor. It uses integers conversion property of only 
# taking the first digit when converting from a float, which 
# this creates momentarily. 
func _floor_to_spawntable(floor_number):
	var spawntable_number = int((floor_number - 1) / 5)
	return spawntable_number
