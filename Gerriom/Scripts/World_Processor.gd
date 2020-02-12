extends Node

var active_territory = null

func set_active_territory( territory ):
	if active_territory :
		active_territory.set_disabled()
		territory.set_active()
		active_territory = territory
	else:
		active_territory = territory
		territory.set_active()

func deactivate_territory():
	if active_territory :
		active_territory.set_disabled()
		active_territory = null

func is_player_teritory_selected():
	return true if active_territory else false
