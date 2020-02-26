extends Node

var mouse_clicker_node 
var mouse_unit_move_marker
var GUI_control_node
var GUI_UnitPreviev_node
var lock_menu_actions = false


var factions = {
	0 : "Fenix",
	1 : "Crusade",
	2 : "Empire",
	3 : "Magostad",
	4 : "Fenix"
}

var textures = {
	"FenixEmblem"    : preload("res://Textures/Emblems/Fenix.png"),
	"CrusadeEmblem"  : preload("res://Textures/Emblems/Crusate.png"),
	"EmpireEmblem"   : preload("res://Textures/Emblems/Railers.png"),
	"MagostadEmblem" : preload("res://Textures/Emblems/Magostad.png"),
	"B1"             : preload("res://Textures/GUI/B1.png"),
	"B2"             : preload("res://Textures/GUI/B2.png"),
	"B3"             : preload("res://Textures/GUI/B3.png"),
	"B4"             : preload("res://Textures/GUI/B4.png")
}

func get_mark( type ):
	match(type):
		"Warrior"  : return Utils.get_texture("B1")
		"Archer"   : return Utils.get_texture("B2")
		"Defender" : return Utils.get_texture("B3")
		_ : return null

func get_texture( texture_name ):
	return textures[texture_name]
