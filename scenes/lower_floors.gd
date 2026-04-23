extends Node
class_name LowerFloors

@export var inventory : InventoryGUIController
@export var equipper : EquipComponent
@export var stats : StatsComponent

var item_json = "res://jsons/items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

signal ascend(items:Array, armor:String, weapon:String, light:String, fishing_rod:String)

func convert_save_to_inventory(items:Array, armor:String, weapon:String, light:String, fishing_rod:String):
	inventory.array_to_inventory(items)
	equipper.equip_unequip(armor, "armor")
	equipper.equip_unequip(weapon, "weapon")
	equipper.equip_unequip(light, "light")
	equipper.equip_unequip(fishing_rod, "fishing_rod")
	stats.heal_charges = item_dictionary[light]["heal_charges"]
	
func convert_inventory_to_save():
	var items = inventory.inventory_to_array()
	var armor = stats.armor
	var weapon = stats.weapon
	var light = stats.light
	var fishing_rod = stats.fishing_rod
	ascend.emit(items, armor, weapon, light, fishing_rod)
