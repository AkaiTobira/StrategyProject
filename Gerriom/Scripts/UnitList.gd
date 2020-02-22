extends Control

var numer_of_units = 24
var unit_list      = {}


func clear():
	unit_list = PlayerInfo.get_unit_list( PlayerInfo.player_id )
	load_all_units()

func _ready():
	build_unit_holders()
	
func build_unit_holders():
	var unit_holder = $List/Control
	
	for i in range( numer_of_units ):
		var new_holder = unit_holder.duplicate()
		new_holder.rect_position.y += 25 * (i+1) 
		new_holder.get_node("Arg1").text = str(i)
		$List.add_child(new_holder)

func load_units( must_have_trait ):
	
	var unit_to_show = []
	for unit in unit_list.keys():
		if must_have_trait in unit_list[unit]["tags"]:
			unit_to_show.append(unit)
			
	for child_index in $List.get_child_count():
		var child = $List.get_child(child_index)
		child.visible = false
		if child_index >= len(unit_to_show): continue
		child.visible = true
		fill_label( child, unit_to_show[child_index])

func fill_label(child, unit_index):
	child._unit_id = unit_index
	child.get_node("Name").text = unit_list[child._unit_id]["name"]
	child.get_node("Arg1").text = str(unit_list[child._unit_id]["stats"]["str"])
	child.get_node("Arg2").text = str(unit_list[child._unit_id]["stats"]["def"])
	child.get_node("Arg3").text = ""
	child.get_node("Arg4").text = ""
	child.get_node("Arg5").text = str(unit_list[child._unit_id]["amout"]["curr"])
	child.get_node("Arg6").text = "/" + str(unit_list[child._unit_id]["amout"]["max"])

func load_all_units():
	for child_index in $List.get_child_count():
		var child = $List.get_child(child_index)
		child.visible = false
		if child_index >= len(unit_list.keys()): continue
		child.visible = true
		fill_label(child, unit_list.keys()[child_index])

func _on_ConfirmButton1_button_down( sortType ):
	match( sortType ):
		0 : load_all_units()
		1 : load_units("Warrior")
		2 : load_units("Defender")
		3 : load_units("Archer")
