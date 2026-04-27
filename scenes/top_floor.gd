extends Node
class_name TopFloor

@export var inventory : InventoryComponent
@export var equipper : EquipComponent
@export var stats : StatsComponent

signal descend(
	items:Dictionary, 
	armor:String, 
	weapon:String, 
	light:String, 
	fishing_rod:String
	)

func _ready() -> void:
	inventory.top_floor = true

func convert_save_to_inventory(
	items : Dictionary, 
	armor : String, 
	weapon : String, 
	light : String, 
	fishing_rod : String
	):
	inventory.dictionary_to_inventory(items)
	equipper.equip_unequip(armor, "armor")
	equipper.equip_unequip(weapon, "weapon")
	equipper.equip_unequip(light, "light")
	equipper.equip_unequip(fishing_rod, "fishing_rod")
	
func convert_inventory_to_save():
	var items = inventory.inventory_to_dictionary()
	var armor = stats.armor
	var weapon = stats.weapon
	var light = stats.light
	var fishing_rod = stats.fishing_rod
	GameSaver.convert_items_to_save(items, armor, weapon, light, fishing_rod)
	GameSaver.save()
	descend.emit(items, armor, weapon, light, fishing_rod)
