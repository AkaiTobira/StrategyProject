extends Node2D

#Handling presing on territories
func _input(event):
	if Utils.lock_menu_actions : return
	if event is InputEventMouseButton && event.button_index == BUTTON_RIGHT:
		UIHandle.deactivate_territory()
		on_disable_opstions()
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		on_active_show_options()

func _ready():
	Utils.mouse_clicker_node     = $MouseButtonMarker
	Utils.mouse_unit_move_marker = $GUI/UnitMoverMarker

func on_disable_opstions(): pass

func on_active_show_options():
	if not UIHandle.active_territory : return
	var options = generate_options()
	$GUI.show_options( options )

func generate_options():
	var options = []
	if is_terrirory_raidable():   options.append("Raid")
	if is_terrirory_attackable(): options.append("Invade")
	return options

func is_terrirory_raidable():
	if UIHandle.active_territory.current_owner == PlayerInfo.player_id: return false
	if not UIHandle.active_territory.name in PlayerInfo.player_info[ PlayerInfo.player_id ]["can_attack"] : return false
	return true

func is_terrirory_attackable():
	if UIHandle.active_territory.current_owner == PlayerInfo.player_id: return false
	if not UIHandle.active_territory.name in PlayerInfo.player_info[ PlayerInfo.player_id ]["can_attack"] : return false
	return true

func testable_auto_win():
	$AttackAnimation.play_invade_animation( PlayerInfo.player_id, UIHandle.active_territory.current_owner, UIHandle.active_territory.name )

#AI Section	
func make_AI_move():
	if UIHandle.get_active_player() == PlayerInfo.player_id: return
	Utils.lock_menu_actions = true
	if len(UIHandle.move_queue) <= 1: return
	atak_neighbour()

func atak_neighbour():
	var can_attack = PlayerInfo.player_info[UIHandle.get_active_player()]["can_attack"]
	var enemy = can_attack[ randi()%len(can_attack)]
	$AttackAnimation.play_invade_animation( UIHandle.get_active_player(), get_node("World/NavPoints/" + enemy).current_owner, enemy )

