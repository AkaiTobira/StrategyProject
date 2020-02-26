extends Control

#Should be moved to new Script on $ConfirmButton
func _on_ConfirmButton1_button_down():
	if not get_node("../ArmyPreviev").is_army_valid() : return 
	UIHandle.selected_army = get_parent().get_node("ArmyPreviev/ArmyPart/ClicablePart/ArmyPlaces").army_posiitons
	get_parent().get_parent().get_parent().get_parent().hide_menu()
	get_parent().get_parent().get_parent().get_parent().make_action( 1 )


func _on_ReplenishButton_button_down():
	var preview_node = get_parent().get_node("UnitPreviev")
	var unit_id = preview_node.current_unit
	PlayerInfo.armies[0][unit_id]["amout"]["curr"] = PlayerInfo.armies[0][unit_id]["amout"]["max"]
	get_parent().get_node("UnitList").refresh_holder(unit_id)
	get_parent().get_node("ArmyPreviev").refresh_holder(unit_id)
	pass # Replace with function body.
