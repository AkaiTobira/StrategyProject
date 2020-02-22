extends Control

#00:00 Lemon - コバソロ & 春茶
func is_army_valid():
	return $ArmyPart/ClicablePart.visible

func get_army():
	return $ArmyPart.active_army

func clear():
	$CommanderPart.clear()
	$ArmyPart.clear()

func _input(event):
	if not Utils.mouse_unit_move_marker.is_active: return
	if event is InputEventMouseButton:
		if not event.is_pressed() and event.button_index == BUTTON_LEFT:
			var angry_rect_wow_wow = $CommanderPart/TextureRect2.get_rect()
			angry_rect_wow_wow.position += get_parent().get_parent().rect_position
			if angry_rect_wow_wow.has_point( Utils.mouse_unit_move_marker.position ):
				$CommanderPart.set_commander( get_parent().unit_list[Utils.mouse_unit_move_marker.active_unit_id])
				$ArmyPart.enable()
