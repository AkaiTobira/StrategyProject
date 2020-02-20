extends Node

var move_queue       = []
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

func get_active_player():
	return move_queue[0]

func get_next_player():
	if len(move_queue) < 2: return move_queue[0] 
	return move_queue[1]
	
func next_turn():
	move_queue.append(move_queue[0])
	move_queue.pop_front()
	print( move_queue )
