extends Area2D

export var current_owner       = 0
export var resources           = [ 0, 0, 0, 0 ]
export var resources_prodution = [ 0, 0, 0, 0 ]

enum TerritoryState{
	Inactive = 0,
	Active   = 1,
	Military = 2,
	Building = 3
}

var areaState = TerritoryState.Inactive 

func _ready():
	redraw()
	$Emblem.position = $Center.position
	adapt_emblem()

func _input(event):
	if Utils.lock_menu_actions : return
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			Utils.mouse_clicker_node.position = get_global_mouse_position()

func adapt_emblem():
	$Emblem.texture  = Utils.get_texture(Utils.factions[ current_owner ] + "Emblem") 
	$Emblem.modulate = PlayerColors.get_player_active_color( current_owner )
	
func change_owner( owner_id ): 
	current_owner = owner_id
	redraw()
	adapt_emblem()
	
func redraw():
	$Sprite.modulate = PlayerColors.get_player_inactive_color(   current_owner )
	
func set_active():  
	areaState = TerritoryState.Active 
	$Sprite.modulate = PlayerColors.get_player_active_color(   current_owner )
	
func set_disabled(): 
	areaState = TerritoryState.Inactive 
	redraw()

func handle_mouse_click(area):
	if not "MouseClicker" in area.get_groups(): return
	area.position = Vector2(-1000,-1000)
	if areaState == TerritoryState.Inactive : UIHandle.set_active_territory( self )

func _on_Area_area_entered(area):
	handle_mouse_click(area)
