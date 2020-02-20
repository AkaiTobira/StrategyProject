extends Node2D

var is_traveling = false
var is_stopped   = true

var timer      = 0
var breakk     = 1
var target_pos = Vector2(0,0)

var SPEED = 500

func _ready():
	position = get_world_navPoint().position
	$Line2D.points[0] = Vector2(0,0)

func get_world_navPoint():
	var node = get_node("../../World/NavPoints")
	return node.get_node( next_fort[1]  ).get_node("Center")

func get_fort_position():
	var node      = get_node("../../World/NavPoints")
	var area      = node.get_node( current_area_name )
	var forts     = area.get_node("Forts")
	var next_fort1 = forts.get_child(randi()%forts.get_child_count())
	return [ next_fort1.position, next_fort1.neighbourArea ]

func get_starting_area():
	var node = get_node("../../World/NavPoints")
	return node.get_child( randi() % node.get_child_count() )

onready var current_area_name = get_starting_area().name
onready var next_fort         = get_fort_position() 

var travel_to_fort = true
func get_next_travel_point():
	if travel_to_fort :
		travel_to_fort = false
		return next_fort[0]
	else :
		travel_to_fort = true
		var new_position = get_world_navPoint().position
		current_area_name = next_fort[1]
		next_fort = get_fort_position()
		return new_position

func _process(delta):
	if is_stopped:
		target_pos   = get_next_travel_point()
		is_traveling = true
		is_stopped   = false
		timer        = 0
		$Line2D.visible = false

	if is_traveling:
		timer += delta
		if timer < breakk : return
		$Line2D.visible = true
		position += (target_pos - position).normalized() * SPEED * delta
		$Line2D.points[1] = target_pos - position
		if position.distance_to(target_pos) < 5 : 
			position = target_pos
			is_traveling = false
			is_stopped   = true
			timer        = 0

	if position.x < 0 : target_pos   = get_world_navPoint().position
	if position.y < 0 : target_pos   = get_world_navPoint().position
