extends Control
class_name InventoryGUIController

@export var equipper : EquipComponent
@export var stats : StatsComponent
@export var item_profile : ItemProfileComponent
@export var action_performer : ActionControllerComponent

@export var inventory_container : Container
@export var items_group : ButtonGroup

var item_json = "res://items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

var inventory := []

# note to self: this system will work but its so convulted and wont allow for item
# descriptions (which we want) so change instead


func _ready() -> void:
	items_group.pressed.connect(pressed_item_to_menu)
	for item in ["fishbone_shiv", "fish_scalemail"]:
		item_button_action(item, item_dictionary[item]["type_tags"][0], false)
	array_to_inventory(["fishbone_shiv", "fish_scalemail", "salmon_spikemail"])

func add_item(item_name):
	var item = Button.new()
	#item.icon = null
	item.set_meta("name", item_name)
	item.toggle_mode = true
	item.custom_minimum_size = Vector2(80, 80)
	item.expand_icon = true
	item.icon = load(item_dictionary[item_name]["icon"])
	item.button_group = items_group
	inventory.append(item_name)
	inventory_container.add_child(item)

func array_to_inventory(item_array : Array):
	for item_name in item_array:
		add_item(item_name)

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
	
	if triggers_counteraction:
		action_performer.perform_action()

func disable_reenable_buttons(is_disabled : bool):
	for node : Node in inventory_container.get_children():
		if node.get_class() == "Button":
			node.disabled = is_disabled
