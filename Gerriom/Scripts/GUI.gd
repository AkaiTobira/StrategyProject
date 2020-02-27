extends CanvasLayer

var buttons_actions = []
var active_menu     = -1

var is_menu_hided   = true

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
		buttons_actions[button_id]    = get_action_id(options[button_id])

func hide_options():
	
	for button_id in $Control.get_child_count():
		var button = $Control.get_child(button_id)
		button.visible = false

func show_menu( menu_id ):
	Utils.lock_menu_actions = true
	#Hide currenlty active Menu
	for child in $Menus/Control.get_children():
		child.visible = false
	$Menus/Control/TextureRect.visible = true
	active_menu = menu_id
	match( active_menu ):
		1 : $Menus/Control/RaidMenu.activate()
	#	_ : return
	if not is_menu_hided: return
	$Menus/AnimationPlayer.play("Show")
	is_menu_hided = false

func _input(event):
	if event is InputEventMouseButton && event.button_index == BUTTON_RIGHT:
		close_current_active_menu()
		
func close_current_active_menu():
	match( active_menu ):
		1 : $Menus/Control/RaidMenu.on_exit()
		_ : return

func hide_menu():
	if is_menu_hided: return
	Utils.lock_menu_actions = false
	is_menu_hided = true
	hide_options()
	$Menus/AnimationPlayer.play_backwards("Show")

func _on_TextureButton1_button_down():
	show_menu(   buttons_actions[0] )
#	make_action( buttons_actions[0] )
	
func _on_TextureButton2_button_down():
	show_menu(   buttons_actions[1] )
#	make_action( buttons_actions[1] )


func _on_TextureButton3_button_down():
	show_menu(   buttons_actions[2] )
#	make_action( buttons_actions[2] )
