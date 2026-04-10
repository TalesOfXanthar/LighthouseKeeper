extends Node
class_name ItemProfileComponent

@export var window : Window
@export var description : RichTextLabel

var item_json = "res://items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

signal action_button_pressed(item_name, type_tag)

var button_locations = [256, 320, 384, 448]

func _ready() -> void:
	window.close_requested.connect(close_profile)
	window.popup_window = true

func instate_item_profile(item_name : String):
	var item_stats = item_dictionary[item_name]
	window.size = Vector2(512, 256 + 64 * (len(item_stats["type_tags"])))
	for tag_number in range(len(item_stats["type_tags"])):
		var action_button := Button.new()
		var type_tag = item_stats["type_tags"][tag_number]
		action_button.size = Vector2(256, 64)
		action_button.position = Vector2(0, button_locations[tag_number])
		description.text = item_stats["description"]
		if type_tag != "use":
			action_button.text = "equip " + type_tag
			action_button.set_meta("type_tag", "equip")
			action_button.set_meta("equip_type", type_tag)
		else:
			action_button.text = type_tag
			action_button.set_meta("type_tag", type_tag)
		action_button.pressed.connect(action_button_pressed.emit.bind(item_name, type_tag))
		window.add_child(action_button)
	window.visible = true
	
func close_profile():
	window.visible = false
	for node : Node in window.get_children():
		if node.get_class() == "Button":
			node.queue_free()
	window.visible = false
