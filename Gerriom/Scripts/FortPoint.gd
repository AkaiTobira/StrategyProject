extends Node2D

export var neighbourArea = ""
var target_point = Vector2(0,0)

func _ready():
	target_point = get_parent().get_parent().get_parent().get_node(neighbourArea + "/Center").position
