extends Node
class_name FishComponent

@export var inventory : InventoryTopComponent
@export var stats : StatsComponent

var fishing_pools_json = "res://jsons/fishing_pools.json"
var fishing_pools_string = FileAccess.get_file_as_string(fishing_pools_json)
var fishing_pools_dictionary : Array = JSON.parse_string(fishing_pools_string)

func _ready() -> void:
	if FileAccess.file_exists("user://fishing_pools.json"):
		fishing_pools_json = "user://fishing_pools.json"
		fishing_pools_string = FileAccess.get_file_as_string(fishing_pools_json)
		fishing_pools_dictionary = JSON.parse_string(fishing_pools_string)
		
func fish():
	var fishing_pool : Dictionary = fishing_pools_dictionary[stats.fishing_power]
	var pool_list := []
	for item in fishing_pool.keys():
		for amount in range(fishing_pool[item]):
			pool_list.append(item)
	
	var fished_item = pool_list.pick_random()
	if fishing_pool[fished_item] == 1.1:
		fishing_pools_dictionary[stats.fishing_power][fished_item] = 0
		var file = FileAccess.open("user://fishing_pools.json", FileAccess.WRITE)
		file.store_string(str(fishing_pools_dictionary))
		file.close()
	inventory.add_item(fished_item)
	
