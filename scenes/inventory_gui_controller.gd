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

# note to self: this system will work but its so convulted and wont allow for item
# descriptions (which we want) so change instead


func _ready() -> void:
	items_group.pressed.connect(pressed_item_to_menu)
	array_to_inventory(["none", "fish_scalemail", "salmon_spikemail"])

func add_item(item_name):
	var item = Button.new()
	#item.icon = null
	item.text = item_name
	item.set_meta("name", item_name)
	item.toggle_mode = true
	item.icon = load(item_dictionary[item_name]["icon"])
	item.button_group = items_group
	inventory_container.add_child(item)

func array_to_inventory(item_array : Array):
	for item_name in item_array:
		add_item(item_name)

func pressed_item_to_menu(useless_var):
	var selected_item_button = items_group.get_pressed_button()
	if selected_item_button != null:
		items_group.get_pressed_button().button_pressed = false
		item_profile.instate_item_profile(selected_item_button.get_meta("name"))
		item_profile.action_button_pressed.connect(item_button_action)

func item_button_action(item_name, tag_type):
	if tag_type != "use":
		equipper.equip_unequip(item_name, tag_type)
	
	action_performer.perform_action()
