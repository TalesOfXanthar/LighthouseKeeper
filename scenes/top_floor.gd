extends Node
class_name TopFloor

@export var inventory : InventoryTopComponent
@export var equipper : EquipComponent
@export var stats : StatsComponent

signal descend(items:Array, armor:String, weapon:String, light:String, fishing_rod:String)

func convert_save_to_inventory(items:Array, armor:String, weapon:String, light:String, fishing_rod:String):
	inventory.array_to_inventory(items)
	equipper.equip_unequip(armor, "armor")
	equipper.equip_unequip(weapon, "weapon")
	equipper.equip_unequip(light, "light")
	equipper.equip_unequip(fishing_rod, "fishing_rod")
	
func convert_inventory_to_save():
	var items = inventory.inventory_to_array()
	var armor = stats.armor
	var weapon = stats.weapon
	var light = stats.light
	var fishing_rod = stats.fishing_rod
	descend.emit(items, armor, weapon, light, fishing_rod)
