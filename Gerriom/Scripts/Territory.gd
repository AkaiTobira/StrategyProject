extends Area2D

export var current_owner = 0
var is_active     = false

export var resources           = [ 0, 0, 0, 0 ]
export var resources_prodution = [ 0, 0, 0, 0 ]

func _ready():
	modulate = PlayerColors.get_player_inactive_color( current_owner )

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			Utils.mouse_clicker_node.position = get_global_mouse_position()

func change_owner( owner_id ): pass

func set_active():  
	is_active = true 
	modulate = PlayerColors.get_player_active_color(   current_owner )
	
func set_disabled(): 
	is_active = false
	modulate = PlayerColors.get_player_inactive_color( current_owner )

func handle_mouse_click(area):
	if not "MouseClicker" in area.get_groups(): return
	area.position = Vector2(-1000,-1000)
	if not is_active : UIHandle.set_active_territory( self )

func _on_Area_area_entered(area):
	handle_mouse_click(area)
