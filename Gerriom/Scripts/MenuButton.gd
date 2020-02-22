extends "res://Scripts/OnHooverTips.gd"

#UNUSUED NOW

var state = 0

func show_menu():
	if state == 0: 
		get_node( "../AnimationPlayer").play("Show")
		state = 2

func hide_menu():
	if state == 2: 
		get_node( "../AnimationPlayer").play_backwards("Show")
		state = 0

func _on_TextureButton_button_down():
	if state == 0: 
		get_node( "../AnimationPlayer").play("Show")
		state = 2
	elif state == 2: 
		get_node( "../AnimationPlayer").play_backwards("Show")
		state = 0
