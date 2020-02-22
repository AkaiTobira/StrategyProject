extends Node2D

var playerTerritoryInfo = {}


func _ready():
	parse()

	UIHandle.move_queue = playerTerritoryInfo.keys()
	PlayerInfo.player_info = playerTerritoryInfo

func remove_dupplicants():
	for player_id in playerTerritoryInfo.keys():
		var owned      = playerTerritoryInfo[ player_id ]["owned"]
		var can_attack = []
		
		for attackable in playerTerritoryInfo[ player_id ]["can_attack"]:
			if attackable in owned: continue
			if attackable in can_attack: continue
			can_attack.append(attackable)
		
		playerTerritoryInfo[ player_id ]["can_attack"] = can_attack

func parse():
	playerTerritoryInfo = {}
	for territory in $NavPoints.get_children():
		if not playerTerritoryInfo.has( territory.current_owner ):
			var owned     = [ territory.name ]
			var can_atack = []
			for fort in territory.get_node("Forts").get_children():
				can_atack.append( fort.neighbourArea )
			playerTerritoryInfo[ territory.current_owner ] = { "can_attack": can_atack, "owned" : owned }
		else:
			playerTerritoryInfo[ territory.current_owner ]["owned"].append( territory.name )
			for fort in territory.get_node("Forts").get_children():
				playerTerritoryInfo[ territory.current_owner ]["can_attack"].append( fort.neighbourArea )
	remove_dupplicants()

func update_player_territory_info():
	parse()
	PlayerInfo.player_info = playerTerritoryInfo
	return playerTerritoryInfo
