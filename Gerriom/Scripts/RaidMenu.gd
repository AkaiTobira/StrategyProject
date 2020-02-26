extends Control


var unit_list      = {}

func activate():
	visible   = true
	unit_list = PlayerInfo.get_unit_list( PlayerInfo.player_id )
	$UnitList.clear()
	$UnitPreviev.clear()
	$ArmyPreviev.clear()

func _input(event):
	if not Utils.mouse_unit_move_marker.is_active: return
	if event is InputEventMouseMotion:
		Utils.mouse_unit_move_marker.position = get_viewport().get_mouse_position()
	
	if event is InputEventMouseButton:
		if not event.is_pressed() and event.button_index == BUTTON_LEFT:
			Utils.mouse_unit_move_marker.position  = Vector2(-1000, -1000)
			Utils.mouse_unit_move_marker.is_active = false
			Utils.mouse_unit_move_marker.pressed_button = null
