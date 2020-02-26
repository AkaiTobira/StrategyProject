extends Control

var army_position = Vector2(-1,-1)
var unit_id       = -1

func clear_holder( ):
	$Fill.texture  = null
	$Name.text     = ""
	$Name2.text    = ""
	$Const.visible = false
	$Count.text    = ""
	$Count2.text   = ""
	unit_id        = -1

func fill_holder( unit, r_id ):
	$Const.visible = true
	$Name.text     = unit["name"].substr(0, 2)
	var t = unit["name"].split(" ")[1]
	$Name2.text    = t.substr(0, min( len(t), 2) )
	$Fill.texture  = Utils.get_mark(unit["tags"][0])
	$Count.text    = str(unit["amout"]["curr"])
	$Count2.text   = str(unit["amout"]["max"] )
	unit_id        = r_id

func _input(event):
	if not Utils.mouse_unit_move_marker.is_active: return
	if event is InputEventMouseButton:
		if not event.is_pressed() and event.button_index == BUTTON_LEFT:
			var angry_rect_wow_wow = $Back.get_rect()
			var position_change    = Utils.GUI_control_node.rect_position + rect_position
			angry_rect_wow_wow.position += position_change
			if angry_rect_wow_wow.has_point( Utils.mouse_unit_move_marker.position ):
				add_to_army()

func add_to_army():
	var unit = PlayerInfo.armies[0][Utils.mouse_unit_move_marker.active_unit_id]
	if unit_id == -1 : 
		get_parent().place_unit(unit, 
								Utils.mouse_unit_move_marker.active_unit_id, 
								army_position)
	else :
		get_parent().replace_unit(unit, 
								unit_id,
								Utils.mouse_unit_move_marker.active_unit_id, 
								army_position)
	unit_id = Utils.mouse_unit_move_marker.active_unit_id

func _on_TextureButton2_button_down():
	if unit_id == -1 : return
	Utils.mouse_unit_move_marker.is_active      = true
	Utils.mouse_unit_move_marker.active_unit_id = unit_id

func _on_ArmyUnitHolder_mouse_entered():
	if unit_id == -1 : return
	Utils.GUI_UnitPreviev_node.fill_temporary_preview(unit_id)

func _on_ArmyUnitHolder_mouse_exited():
	if unit_id == -1 : return
	Utils.GUI_UnitPreviev_node.clear_temporary_preview()

func _on_Back_button_down():
	if unit_id == -1 : return
	Utils.mouse_unit_move_marker.is_active      = true
	Utils.mouse_unit_move_marker.active_unit_id = unit_id
