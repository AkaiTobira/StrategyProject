extends Control

#Should be moved to new Script on $ConfirmButton
func _on_ConfirmButton1_button_down():
	if not get_node("../ArmyPreviev").is_army_valid() : return 
	get_parent().get_parent().get_parent().get_parent().hide_menu()
	get_parent().get_parent().get_parent().get_parent().make_action( 1 )
