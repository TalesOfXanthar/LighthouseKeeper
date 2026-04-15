extends Node
class_name ButtonDisabler

@export var action_buttons : ActionButtons
@export var item_profile : ItemProfileComponent
@export var inventory : InventoryGUIController

@export var disable_timer : Timer


func disable_enable_all_buttons(is_disabled : bool):
	disable_timer.timeout.connect(disable_enable_all_buttons.bind(false))
	action_buttons.disable_reenable(is_disabled)
	item_profile.disable_reenable_buttons(is_disabled)
	inventory.disable_reenable_buttons(is_disabled)
	if is_disabled:
		disable_timer.start()
