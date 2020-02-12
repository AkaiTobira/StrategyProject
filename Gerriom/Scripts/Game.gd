extends Node2D


func _input(event):
	if event is InputEventMouseButton && event.button_index == BUTTON_RIGHT:
		UIHandle.deactivate_territory()

func _ready():
	Utils.mouse_clicker_node = $MouseButtonMarker
