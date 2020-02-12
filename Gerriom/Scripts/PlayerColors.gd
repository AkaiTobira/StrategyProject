extends Node

var Colors = {
	0 : {
		"inactive" : Color( 0, 0.5, 0, 1 ),
		"active"   : Color( 0, 0.75, 0, 1 )
	},
	1 : {
		"inactive" : Color( 0.5,  0, 0, 1 ),
		"active"   : Color( 0.75, 0, 0, 1 )
	},
	2 : {
		"inactive" : Color( 0.5,   0.5, 0, 1 ),
		"active"   : Color( 0.75, 0.75, 0, 1 )
	},
	3 : {
		"inactive" : Color( 0.5,   0.5,  0.5, 1 ),
		"active"   : Color( 0.75, 0.75,  0.75, 1 )
	},
	4 : {
		"inactive" : Color( 0,   0.5,  0.5, 1 ),
		"active"   : Color( 0, 0.75,  0.75, 1 )
	}
}

func get_player_active_color( color_id ):
	return Colors[color_id]["active"]

func get_player_inactive_color( color_id ):
	return Colors[color_id]["inactive"]
