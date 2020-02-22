extends Control

func fill_preview( unit_id ):
	fill_const_element()
	var unit = get_parent().unit_list[unit_id]
	$Name.text = unit["name"]
	$Race.text = unit["race"]

func fill_const_element():
	$Const.text  = "Commander Name :"
	$Const2.text = "Race :"

func clear():
	for child in get_children():
		if child.get("text"): child.text = ""
