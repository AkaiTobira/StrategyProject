extends Control

var active_army = {}
var is_commander_hovered = false

func clear():
	$ClicablePart.visible = false
	$Disabled.visible = true

func enable():
	$ClicablePart.visible = true
	$Disabled.visible = false
