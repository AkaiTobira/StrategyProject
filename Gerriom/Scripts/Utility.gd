extends Node

var mouse_clicker_node 
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
	"MagostadEmblem" : preload("res://Textures/Emblems/Magostad.png")
}

func get_texture( texture_name ):
	return textures[texture_name]
