extends Node
class_name ActionControllerComponent

# This is a script for emiting the fact that an action was performed to give to
# the counteraction component. It's usefullness is that any type of action
# (ex. Attacking, using an item, healing) calls it instead of all of those 
# emiting their own signal.

signal performed_action

func perform_action():
	performed_action.emit()
