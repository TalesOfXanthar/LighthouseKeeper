extends Control
class_name InventoryGUIController

@export var equipper : EquipComponent
@export var stats : StatsComponent
@export var item_profile : ItemProfileComponent

@export var inventory_container : Container
@export var equip_button : Button
@export var items_group : ButtonGroup

var item_json = "res://items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

# note to self: this system will work but its so convulted and wont allow for item
# descriptions (which we want) so change instead

func _ready() -> void:
	items_group.get_pressed_button().button_pressed = false
	items_group.pressed.connect(pressed_item_to_menu)
	equip_button.pressed.connect(equip_item)

func add_item(item_name):
	var item = Button.new()
	#item.icon = null
	item.set_meta("name", item_name)
	item.button_group = items_group
	inventory_container.add_child(item)

func pressed_item_to_menu(int):
	var selected_item_button = items_group.get_pressed_button()
	if selected_item_button != null:
		items_group.get_pressed_button().button_pressed = false
		item_profile.instate_item_profile(selected_item_button.get_meta("name"))
		

func equip_button_show(int):
	var selected_item_button = items_group.get_pressed_button()
	if selected_item_button != null:
		print(items_group.get_pressed_button())
		var selected_item_name = selected_item_button.get_meta("name")
		var selected_item_stats = item_dictionary[selected_item_name]
		if !selected_item_stats["type_tags"].is_empty():
			equip_button.show()
		if selected_item_name == stats.weapon:
			equip_button.text = "unequip"
		else:
			equip_button.text = "equip"
		#selected_item_button.set_pressed_no_signal(false)
	
	#i realize this will trigger on all items, even if they arent equipment, so this
	# should check if the item can be equipped even and then show the button if yes

func equip_item():
	var selected_item = items_group.get_pressed_button().get_meta("name")
	equipper.equip_unequip(selected_item, "weapon")
	
	
	
	
	
