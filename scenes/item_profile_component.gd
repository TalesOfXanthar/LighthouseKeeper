extends Node
class_name ItemProfileComponent

@export var window : Window
@export var description : RichTextLabel
@export var label : Label
@export var texture : TextureRect

var item_json = "res://jsons/items.json"
var item_string = FileAccess.get_file_as_string(item_json)
var item_dictionary = JSON.parse_string(item_string)

signal action_button_pressed(item_name, type_tag)

var button_locations = [256, 320, 384, 448]

func _ready() -> void:
	window.close_requested.connect(close_profile)
	window.popup_window = true
	set_process(false)

func instate_item_profile(
	item_name : String, 
	item_amount : int,
	item_position : Vector2, 
	top_floor : bool
	):
	if window.visible:
		close_profile()
	var item_stats = item_dictionary[item_name]
	window.size = Vector2(192, 392 + 56 * (len(item_stats["type_tags"])))
	window.position = item_position
	description.text = item_stats["description"]
	label.text = "Amount: " + str(item_amount)
	texture.texture = load(item_stats["texture"])
	for tag_number in range(len(item_stats["type_tags"])):
		var action_button := Button.new()
		var type_tag = item_stats["type_tags"][tag_number]
		action_button.size = Vector2(192, 56)
		action_button.position = Vector2(0, 392 + 56 * tag_number)
		if type_tag != "use":
			action_button.text = "equip " + type_tag
			action_button.set_meta("type_tag", "equip")
			action_button.set_meta("equip_type", type_tag)
		elif top_floor == false:
			action_button.text = type_tag
			action_button.set_meta("type_tag", type_tag)
		action_button.pressed.connect(action_button_pressed.emit.bind(item_name, type_tag))
		action_button.pressed.connect(close_profile)
		window.add_child(action_button)
	set_process(true)
	window.visible = true
	
func close_profile():
	window.visible = false
	for node : Node in window.get_children():
		if node.get_class() == "Button":
			node.queue_free()
	window.visible = false

func disable_reenable_buttons(is_disabled : bool):
	for node : Node in window.get_children():
		if node.get_class() == "Button":
			node.disabled = is_disabled

func _process(delta: float) -> void:
	var hovering_button = false
	for node : Node in window.get_children():
		if node.get_class() == "Button":
			if node.is_hovered():
				hovering_button = true
	if Input.is_action_just_pressed("left_click") && hovering_button == false:
		set_process(false)
		close_profile()
	elif Input.is_action_just_pressed("left_click"):
		set_process(false)
