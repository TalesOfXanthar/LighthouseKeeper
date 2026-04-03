extends Node
class_name EquipComponent

# Future script for inventory and equipped stuff.

@export var stats : StatsComponent

var item_json = "res://items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

# Aether-fueled circular lamp

func equip_unequip(item_name, equip_slot : String, is_equip := true):
	if is_equip && stats.get(equip_slot) == "none":
		stats.set(equip_slot, item_name)
	elif is_equip:
		_change_stats_from_item(item_dictionary[stats.get(equip_slot)], false)
		stats.set(equip_slot, item_name)
	else:
		stats.set(equip_slot, "none")
	print("cool")
	_change_stats_from_item(item_dictionary[item_name], is_equip)

func _change_stats_from_item(item_stats : Dictionary, positive := true) -> void:
	for stat_name in item_stats.keys():
		print(stats.get(stat_name))
		if stats.get(stat_name) != null:	
			print("cool")
			var current_stat_value = stats.get(stat_name)
			if positive:	
				stats.set(stat_name, current_stat_value + item_stats[stat_name])
			else:
				stats.set(stat_name, current_stat_value - item_stats[stat_name])
		
		#if new_base_stats.has(base_stats_names[stat_num]):
		#	stats.set(base_stats_names[stat_num], new_base_stats[base_stats_names[stat_num]])
		#else:
		#	stats.set(base_stats_names[stat_num], base_stats_defaults[stat_num])
