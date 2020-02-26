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
	Utils.GUI_control_node       = $GUI/Menus/Control
	Utils.GUI_UnitPreviev_node   = $GUI/Menus/Control/RaidMenu/UnitPreviev

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

func generate_atack_army( player ):
	var army = {}
	var number_of_units = len( PlayerInfo.armies[player])
	var commander_id = randi()%number_of_units
	var commander = PlayerInfo.armies[player][ commander_id ]
	var army_cap  = min( commander["stats"]["int"], number_of_units)
#	print(commander["stats"]["int"], " ", number_of_units, " army Cap", army_cap)
	var units     = PlayerInfo.armies[player].keys()
	
	var army_size = max( randi() % (army_cap), 2)
	army[commander_id] = Vector2(0,0)
	for i in range( army_size ):
		var random_unit = randi()%number_of_units
		while random_unit in army.keys(): random_unit = randi()%number_of_units
		army[random_unit] = Vector2(0,0)
	return army

func atak_neighbour():
	var can_attack = PlayerInfo.player_info[UIHandle.get_active_player()]["can_attack"]
	var enemy = can_attack[ randi()%len(can_attack)]
	
	UIHandle.army_owner1 = UIHandle.get_active_player()
	UIHandle.enemy_army1 = generate_atack_army(UIHandle.army_owner1)
	UIHandle.army_owner2 = get_node("World/NavPoints/" + enemy).current_owner
	UIHandle.enemy_army2 = generate_atack_army(UIHandle.army_owner2)
	
	#print(UIHandle.enemy_army1, " ", UIHandle.enemy_army2)
	$AttackAnimation.play_invade_animation( UIHandle.get_active_player(), get_node("World/NavPoints/" + enemy).current_owner, enemy )

