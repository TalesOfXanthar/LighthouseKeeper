extends Node
class_name ActionControllerComponent

signal performed_action

func perform_action():
	performed_action.emit()
