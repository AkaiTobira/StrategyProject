extends Control

#00:00 Lemon - コバソロ & 春茶
func is_army_valid():
	return $ArmyPart/ClicablePart.visible

func get_army():
	return $ArmyPart.active_army

func clear():
	$CommanderPart.clear()
	$ArmyPart.clear()

func update_commander_capcity(unit, new_size ):
	$CommanderPart.update_commander_capability(unit,new_size)

func check_commander_part():
	var angry_rect_wow_wow = $CommanderPart/TextureRect2.get_rect()
	angry_rect_wow_wow.position += Utils.GUI_control_node.rect_position
	if angry_rect_wow_wow.has_point( Utils.mouse_unit_move_marker.position ):
		var unit = get_parent().unit_list[Utils.mouse_unit_move_marker.active_unit_id]
		$CommanderPart.set_commander( unit )
		$ArmyPart.enable()
		$ArmyPart.place_commander( unit, Utils.mouse_unit_move_marker.active_unit_id )
		return true
	return false
		
func check_if_outside() :
	if Utils.mouse_unit_move_marker.from_unit_list: return
	if  Utils.mouse_unit_move_marker.position == Vector2(-1000, -1000): return
	var angry_rect_wow_wow = $ArmyPart/Disabled.get_rect()
	angry_rect_wow_wow.position += Utils.GUI_control_node.rect_position
	print( angry_rect_wow_wow,  Utils.mouse_unit_move_marker.position)
	if not angry_rect_wow_wow.has_point( Utils.mouse_unit_move_marker.position ):
		
		$ArmyPart/ClicablePart/ArmyPlaces.remove_unit_from_board( Utils.mouse_unit_move_marker.active_unit_id )
		return true
	return false

func _input(event):
	if not Utils.mouse_unit_move_marker.is_active: return
	if event is InputEventMouseButton:
		if not event.is_pressed() and event.button_index == BUTTON_LEFT:
			if check_commander_part(): return
			if check_if_outside(): return

func refresh_holder( unit_id ):
	$ArmyPart/ClicablePart/ArmyPlaces.refresh_holder(unit_id)
