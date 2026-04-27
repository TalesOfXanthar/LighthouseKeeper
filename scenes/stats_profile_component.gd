extends Node
class_name GearProfileComponent

@export var inventory : InventoryComponent
@export var stats : StatsComponent
@export var equipper : EquipComponent

@export var window : Window
# Different descriptions, buttons, and images for each equipment type.
@export var armor_description : RichTextLabel
@export var weapon_description : RichTextLabel
@export var light_description : RichTextLabel
@export var fishing_rod_description : RichTextLabel

@export var armor_texture : TextureRect
@export var weapon_texture : TextureRect
@export var light_texture : TextureRect
@export var fishing_rod_texture : TextureRect

@export var armor_button : BaseButton
@export var weapon_button : BaseButton
@export var light_button : BaseButton
@export var fishing_rod_button : BaseButton

var item_json = "res://jsons/items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

signal action_button_pressed(item_name, type_tag)

var button_locations = {
	"armor": 0,
	"weapon": 256,
	"light": 512,
	"fishing_rod": 768,
}

var empty_descriptions = {
	"armor": "You have no armor equipped.",
	"weapon": "You do not have a weapon equipped.",
	"light": "You do not have a light source equipped.",
	"fishing_rod": "You do not have a fishing rod equipped."
}

func _ready() -> void:
	window.close_requested.connect(close_profile)
	window.popup_window = true
	set_process(false)
	
	armor_button.pressed.connect(unequip_item.bind("armor"))
	weapon_button.pressed.connect(unequip_item.bind("weapon"))
	light_button.pressed.connect(unequip_item.bind("light"))
	fishing_rod_button.pressed.connect(unequip_item.bind("fishing_rod"))

func show():
	if window.visible:
		window.visible = false
	else:
		window.visible = true

func update_equipment(item_name : String, equip_slot : String):
	var equip_prefix = equip_slot.to_pascal_case()
	var item_traits: Dictionary = item_dictionary[item_name]
	print(equip_prefix + "Texture")
	get(equip_slot + "_texture").set("texture", load(item_traits["texture"]))
	if item_name == "none":
		get(equip_slot + "_description").set("text",
		empty_descriptions[equip_slot]) 
		get(equip_slot + "_button").set("visible", false)
	else:
		var equip_text = equip_slot.capitalize()
		get(equip_slot + "_description").set("text",
		"Equipped " + equip_text + ":\n" + item_traits["description"]) 
		get(equip_slot + "_button").set("visible", true)

func close_profile():
	window.visible = false
	

func disable_reenable_buttons(is_disabled : bool):
	for node : Node in window.get_children():
		if node.get_class() == "Button":
			node.disabled = is_disabled

## Gets the current item in the slot you're trying to equip in, adds it to
## your inventory, and 
func unequip_item(tag_type : String):
	var item = stats.get(tag_type)
	inventory.add_item(item)
	print(item)
	update_equipment("none", tag_type)
	
