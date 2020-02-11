extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for area in $NavPoints.get_children():
		area.get_node("Sprite").modulate = Color( 0, 133.0/255.0, 0)
		
	
	pass # Replace with function body.
