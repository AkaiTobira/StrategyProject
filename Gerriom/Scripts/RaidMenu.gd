extends Control


var unit_list      = {}

func activate():
	visible   = true
	unit_list = PlayerInfo.get_unit_list( PlayerInfo.player_id )
	$UnitList.clear()
	$UnitPreviev.clear()
	$ArmyPreviev.clear()

