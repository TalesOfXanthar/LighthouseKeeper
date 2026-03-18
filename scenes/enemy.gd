extends Node
class_name Enemy

@export var health : HealthComponent
@export var attack : AttackComponent
@export var action : CounterActionComponent

@export var floor_number := 0
var current_enemy_name
var next_enemy_name 
signal new_enemy

var traits_json = "res://traits.json"
var traits_string = FileAccess.get_file_as_string(traits_json)
var traits_dictionary = JSON.parse_string(traits_string)
var spawntables = traits_dictionary["spawntables"]
var enemy_traits = traits_dictionary["enemies"]
var is_dead := false

# Connects the signal emitted by health so it actually registers here,
# and chooses a new enemy. This is the reason why we start at floor 0
# and not floor 1, because the enemy_died() automatically upticks the floor
# by 1 anyways.
# "death_action" is the last attempted counteraction by the counteraction
# component. It is performed when the enemy is dead, but there hasn't been
# instated a new enemy yet since that death action is what instates the new
# enemy itself. (enemy's last action is calling for next enemy)
func _ready() -> void:
	health.connect("died", enemy_died)
	action.connect("death_action", _new_enemy)
	enemy_died()
	_new_enemy()


# This function chooses a new enemy. The reason we call it at the ready
# function is so it can randomly choose the first enemy. Might have to
# change later if we want to prevent duplicate enemies in a row.
func enemy_died():
	is_dead = true
	var next_spawntable = spawntables[_floor_to_spawntable(floor_number + 1)]
	
	# Subtract one here since the len function starts at 1, not 0 like 
	# arrays do.
	var enemy_picker = randi_range(0, len(next_spawntable) - 1)
	next_enemy_name = next_spawntable[enemy_picker]

func _new_enemy():
	var current_enemy_traits = traits_dictionary["enemies"][next_enemy_name]
	health.max_hit_points = current_enemy_traits["hit_points"]
	health.reset_hit_points()
	attack.attack_damage = current_enemy_traits["attack_damage"]
	is_dead = false
	current_enemy_name = next_enemy_name
	next_enemy_name = "error"
	floor_number += 1
	new_enemy.emit()

# Here is the function for determining the spawntable set for 
# each floor. It uses integers conversion property of only 
# taking the first digit when converting from a float, which 
# this creates momentarily. 
func _floor_to_spawntable(floor_number):
	var spawntable_number = int((floor_number - 1) / 5)
	return spawntable_number
