extends Control

#Should be moved to new Script on $ConfirmButton
func _on_ConfirmButton1_button_down():
	if not get_node("../ArmyPreviev").is_army_valid() : return 

	var node_string = "ArmyPreviev/ArmyPart/ClicablePart/ArmyPlaces"
	var player_army =  get_parent().get_node(node_string).army_positions
	if PlayerInfo.is_player_attacking : process_defence( player_army )
	else : process_attack(player_army)
	Utils.GUI_control_node.get_parent().get_parent().close_current_active_menu()

func process_attack(army):
	Utils.GUI_control_node.get_parent().get_parent().make_action( 1 )
	UIHandle.army_owner1 = PlayerInfo.player_id
	UIHandle.enemy_army1 = army
	var gui_node = Utils.GUI_control_node.get_parent().get_parent()
	UIHandle.army_owner2 = UIHandle.active_territory.current_owner
	UIHandle.enemy_army2 = gui_node.get_parent().generate_atack_army(UIHandle.army_owner2)

func process_defence(army):
	UIHandle.army_owner2           = PlayerInfo.player_id
	UIHandle.enemy_army2           = army
	PlayerInfo.is_player_attacking = false
	var gui_node = Utils.GUI_control_node.get_parent().get_parent()
	gui_node.get_parent().get_node("AttackAnimation").continue_fight()

func _on_ReplenishButton_button_down():
	var preview_node = get_parent().get_node("UnitPreviev")
	var unit_id = preview_node.current_unit
	PlayerInfo.armies[0][unit_id]["amout"]["curr"] = PlayerInfo.armies[0][unit_id]["amout"]["max"]
	get_parent().get_node("UnitList").refresh_holder(unit_id)
	get_parent().get_node("ArmyPreviev").refresh_holder(unit_id)

func _on_DeclineButton_button_down():
	get_parent().get_parent().get_node("EscapeConfirm").visible = false

func _on_EscapeButton_button_down():
	get_parent().get_parent().get_node("EscapeConfirm").visible = false
	PlayerInfo.is_player_attacking = false
	UIHandle.army_owner2           = PlayerInfo.player_id
	UIHandle.enemy_army2           = {}
	var gui_node = Utils.GUI_control_node.get_parent().get_parent()
	gui_node.close_current_active_menu()
	gui_node.get_parent().get_node("AttackAnimation").continue_fight()
