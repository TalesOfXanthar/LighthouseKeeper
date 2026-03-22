extends Node
class_name EnemySwapperComponent

# This is a script for actualizing a new enemy whenever the previous enemy
# died. It takes references to all the base stats and the json with the next
# enemy's stats and changes the former to the latter.

@export var stats: StatsComponent

var stats_json = "res://stats.json"
var stats_string = FileAccess.get_file_as_string(stats_json)
var stats_dictionary = JSON.parse_string(stats_string)

var base_stats_defaults = [
	100,
	2,
	0,
	0,
	1,
	-1,
]

var base_stats_names = [
	"max_hit_points",
	"attack_damage",
	"defense",
	"dodge_chance",
	"attack_randomizer_floor",
	"attack_randomizer_ceiling",
]

func swap_enemy(enemy_name):
	var new_base_stats : Dictionary = stats_dictionary["enemies"][enemy_name]
	print(enemy_name)
	for stat_num in range(len(base_stats_names)):
		if new_base_stats.has(base_stats_names[stat_num]):
			stats.set(base_stats_names[stat_num], new_base_stats[base_stats_names[stat_num]])
		else:
			stats.set(base_stats_names[stat_num], base_stats_defaults[stat_num])
