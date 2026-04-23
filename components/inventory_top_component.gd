extends Control
class_name InventoryTopComponent

@export var equipper : EquipComponent
@export var item_profile : Node

@export var inventory_container : Container
@export var items_group : ButtonGroup

var item_json = "res://jsons/items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

var inventory := []

func _ready() -> void:
	items_group.pressed.connect(pressed_item_to_menu)
	#for item in ["fishbone_shiv", "fish_scalemail"]:
	#	item_button_action(item, item_dictionary[item]["type_tags"][0], false)
	#array_to_inventory(["fishbone_shiv", "fish_scalemail", "salmon_spikemail"])

func add_item(item_name):
	var item = TextureButton.new()
	#item.icon = null
	item.set_meta("name", item_name)
	item.toggle_mode = true
	item.custom_minimum_size = Vector2(80, 80)
	item.stretch_mode = 0
	item.texture_normal = load(item_dictionary[item_name]["icon"])
	item.button_group = items_group
	inventory.append(item_name)
	inventory_container.add_child(item)

func array_to_inventory(item_array : Array):
	for item_name in item_array:
		add_item(item_name)

func inventory_to_array():
	var items_array := []
	for item in items_group.get_buttons():
		items_array.append(item.get_meta("name"))
	return items_array

func pressed_item_to_menu(useless_var):
	var selected_item_button : BaseButton = items_group.get_pressed_button()
	var item_position = selected_item_button.global_position
	print(item_position)
	if selected_item_button != null:
		items_group.get_pressed_button().button_pressed = false
		item_profile.instate_item_profile(selected_item_button.get_meta("name"), item_position)
		item_profile.action_button_pressed.connect(item_button_action)

func item_button_action(item_name, tag_type, triggers_counteraction := true):
	if tag_type != "use":
		equipper.equip_unequip(item_name, tag_type)
		for item in inventory_container.get_children():
			if item.get_meta("name") == item_name:
				item.queue_free()
				break
	


func disable_reenable_buttons(is_disabled : bool):
	for node : Node in inventory_container.get_children():
		if node.get_class() == "Button":
			node.disabled = is_disabled
