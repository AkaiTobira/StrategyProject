extends CanvasLayer

var buttons_actions = []
var active_menu     = -1

func _ready():
	for i in range($Control.get_child_count()):
		buttons_actions.append(-1)
	show_options([])

func show_build_menu():
	if not UIHandle.is_player_teritory_selected(): pass
		#show_menu()

func get_action_id( action ):
	match(action):
		"Invade" : return 1
		"Raid"   : return 2
		_: return -1

func make_action( action_id ):
	match( action_id ):
		1 : get_parent().testable_auto_win()
		2 : get_parent().testable_auto_win()
		3 : get_parent().testable_auto_win()
		_ : return

func show_options(options):
	for button_id in $Control.get_child_count():
		var button = $Control.get_child(button_id)
		button.visible = button_id < len(options)
		if button_id >= len(options): continue
		button.get_node("Label").text = options[button_id]
		buttons_actions[button_id] = get_action_id(options[button_id])

func show_menu( menu_id ):
	print( buttons_actions )
	print( menu_id )
	#Hide currenlty active Menu
	for child in $Menus/Control.get_children():
		child.visible = false
	$Menus/Control/TextureRect.visible = true
	active_menu = menu_id
	match( active_menu ):
		1 : $Menus/Control/RaidMenu.visible = true
	#	_ : return

	$Menus/AnimationPlayer.play("Show")

func hide_menu():
	show_options([])
	$Menus/AnimationPlayer.play_backwards("Show")

func _on_TextureButton1_button_down():
	show_menu(   buttons_actions[0] )
#	make_action( buttons_actions[0] )
	
func _on_TextureButton2_button_down():
	show_menu(   buttons_actions[1] )
#	make_action( buttons_actions[1] )

func _on_ConfirmButton1_button_down():
	hide_menu()
	make_action( 1 )

func _on_TextureButton3_button_down():
	show_menu(   buttons_actions[2] )
#	make_action( buttons_actions[2] )
