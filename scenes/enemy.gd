extends Node
class_name Enemy

# Mainly a script for when controlling the type of enemy and when to instate a
# new one.

@export var stats : StatsComponent
@export var health : HealthComponent
@export var attack : AttackComponent
@export var action : CounterActionComponent
@export var enemy_swapper : EnemySwapperComponent

signal new_enemy

var stats_json = "res://stats.json"
var stats_string = FileAccess.get_file_as_string(stats_json)
var stats_dictionary = JSON.parse_string(stats_string)
var spawntables = stats_dictionary["spawntables"]

@export var floor_number := 0
var current_enemy_name
var next_enemy_name 
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
	health.connect("died", _enemy_died)
	action.connect("death_action", _new_enemy)
	_enemy_died()
	_new_enemy()


## This function chooses a new enemy. The reason we call it at the ready
## function is so it can randomly choose the first enemy. Might have to
## change later if we want to prevent duplicate enemies in a row.
func _enemy_died() -> void:
	is_dead = true
	var next_spawntable = spawntables[_floor_to_spawntable(floor_number + 1)]
	
	# Subtract one here since the len function starts at 1, not 0 like 
	# arrays do.
	var enemy_picker = randi_range(0, len(next_spawntable) - 1)
	next_enemy_name = next_spawntable[enemy_picker]

## Swaps out enemy stats and resets enemy condition, and increases the floor
## number.
func _new_enemy() -> void:
	enemy_swapper.swap_enemy(next_enemy_name)
	health.reset_hit_points()
	is_dead = false
	current_enemy_name = next_enemy_name
	next_enemy_name = "null"
	floor_number += 1
	new_enemy.emit()

## Here is the function for determining the spawntable set for 
## each floor. It uses integers conversion property of only 
## taking the first digit when converting from a float, which 
## this creates momentarily. 
func _floor_to_spawntable(floor_number : int):
	var spawntable_number = int((floor_number - 1) / 5)
	return spawntable_number
