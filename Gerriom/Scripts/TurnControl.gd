extends Control

func _ready(): update()

func update():
	var active_player = UIHandle.get_active_player()
	$ActiveEmblem.texture  = Utils.get_texture(Utils.factions[ active_player ] + "Emblem") 
	$ActiveEmblem.modulate = PlayerColors.get_player_active_color( active_player )
	
	var next_player = UIHandle.get_next_player()
	$NextEmblem.texture  = Utils.get_texture(Utils.factions[ next_player ] + "Emblem") 
	$NextEmblem.modulate = PlayerColors.get_player_active_color( next_player )
	$NextEmblem.modulate.a = 0

func _on_NextTurn_button_down():
	UIHandle.deactivate_territory()
	get_parent().hide_menu()
	get_parent().hide_options()

	var anim  = $AnimationPlayer.get_animation( "Switch" )
	
	var index_1 = anim.find_track("ActiveEmblem:modulate")
	var index_2 = anim.find_track("NextEmblem:modulate")
	
	anim.track_set_key_value( index_1, 0, PlayerColors.get_player_active_color( UIHandle.get_active_player() ) )
	anim.track_set_key_value( index_2, 2, PlayerColors.get_player_active_color( UIHandle.get_next_player() ) )
	
	$AnimationPlayer.play("Switch")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Switch":
		UIHandle.next_turn()
		update()
		get_node("../..").make_AI_move()
