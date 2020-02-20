extends AnimationPlayer

func find_closest_node(attacker_info, attacked_territory):
	var nav_node          = get_node("../World/NavPoints")
	var attacked_position = nav_node.get_node( attacked_territory + "/Center" ).position
	var distance          = 999999999
	var attacker_node     = nav_node.get_node(attacker_info["owned"][0])

	for attacker_area in attacker_info["owned"]:
		var area = nav_node.get_node(attacker_area)
		var new_distance = area.get_node("Center").position.distance_to( attacked_position )
		if new_distance < distance:
			distance      = new_distance
			attacker_node = area
	return attacker_node

func find_fort_in_territory( territory, seeked_fort ):
	for fort in territory.get_node("Forts").get_children():
		if fort.neighbourArea == seeked_fort : return fort.position

func calculate_animation_points( attacker_node, defender_node ):
	var center1 = attacker_node.get_node("Center").position
	var center2 = defender_node.get_node("Center").position
	
	var point1 = find_fort_in_territory( attacker_node, defender_node.name );
	var point2 = find_fort_in_territory( defender_node, attacker_node.name );
	
	return [ center1, point1, center2, point2]

func play_invade_animation( attacker, defender, attacked_territory ): 
	var info = PlayerInfo.player_info[ attacker ]
	
	var attacker_node = find_closest_node(info,  attacked_territory )
	var defender_node = get_node("../World/NavPoints/" + attacked_territory)
	
	animation_set( calculate_animation_points( attacker_node, defender_node ) )
	
	$OfensiveArmy/Emblem.texture  = Utils.get_texture( Utils.factions[attacker] + "Emblem")
	$OfensiveArmy/Front.modulate  = PlayerColors.get_player_inactive_color( attacker )
	$DefenceArmy/Emblem.texture   = Utils.get_texture( Utils.factions[defender] + "Emblem")
	$DefenceArmy/Front.modulate   = PlayerColors.get_player_inactive_color( defender )
	
	Utils.lock_menu_actions = true
	
	PlayerInfo.attacked_territory = defender_node
	PlayerInfo.attacker_id        = attacker
	play("Invade")

func animation_set( points ):
	var anim = get_animation( "Invade" )
	var pos_track1 = anim.find_track( "AttackAnimation/OfensiveArmy:position")
	var pos_track2 = anim.find_track( "AttackAnimation/DefenceArmy:position")

	anim.track_set_key_value( pos_track1, 0, points[0])
	anim.track_set_key_value( pos_track1, 1, points[1])
	anim.track_set_key_value( pos_track2, 0, points[2])
	anim.track_set_key_value( pos_track2, 1, points[3])

func _on_AttackAnimation_animation_finished(anim_name):
	if anim_name == "Invade":
		Utils.lock_menu_actions = false
		
		if randi()%100 < 25:
			var previous_owner = PlayerInfo.attacked_territory.current_owner
			PlayerInfo.attacked_territory.change_owner( PlayerInfo.attacker_id )
			get_node("../World").update_player_territory_info()
			if not PlayerInfo.player_info.has(previous_owner):
				UIHandle.move_queue.erase( previous_owner )
		if UIHandle.get_active_player() != PlayerInfo.player_id:
			get_node("../GUI/TurnControl")._on_NextTurn_button_down()
	pass # Replace with function body.
