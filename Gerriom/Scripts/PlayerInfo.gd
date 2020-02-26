extends Node

var player_id   = 0
var gold        = 1000
var player_info = {}

var attacked_territory = null
var attacker_id        = -1

func _ready():
	#for test
	generate_enemy_army()


var armies = {
	0 :
		{
		0 : {
			"name"  : "Yuuki Cross",
			"tags"  : ["Warrior", "Human", "Attacker1"],
			"race"  : "Human",
			"stats" : { "str" : 5,   "def" : 5,  "int" : 2 },
			"amout" : { "max" : 200, "curr" : 200} 
		},
		1 : {
			"name"  : "Ameruno Cross",
			"tags"  : ["Defender", "Human", "Defender1"],
			"race"  : "Human",
			"stats" : { "str" : 2,   "def" : 7,  "int" : 3  },
			"amout" : { "max" : 300, "curr" : 300} 
		},
		2 : {
			"name"  : "Kiryou Cross",
			"tags"  : ["Archer", "Driad", "Range1"],
			"race"  : "Human",
			"stats" : { "str" : 7,   "def" : 2,  "int" : 2  },
			"amout" : { "max" : 150, "curr" : 150} 
		},
		3 : {
			"name"  : "Gerryu Rei",
			"tags"  : ["Warrior", "Demigod", "Attacker1", "Range1" ],
			"race"  : "Demigod",
			"stats" : { "str" : 10,   "def" : 10,  "int" : 10  },
			"amout" : { "max" : 500, "curr" : 500} 
		},
		5 : {
			"name"  : "Rantis Phoenix",
			"tags"  : ["Warrior", "Gerrion", "Attacker3", "Range3"],
			"race"  : "Gerrion",
			"stats" : { "str" : 99,   "def" : 99 , "int" : 99  },
			"amout" : { "max" : 30,  "curr" : 30 } 
		},
		4 : {
			"name"  : "Unit 0",
			"tags"  : ["Archer", "NoRace", "Attacker1", "Range1"],
			"race"  : "Unknown",
			"stats" : { "str" : 99,   "def" : 99, "int" : 99  },
			"amout" : { "max" : 999, "curr" : 999} 
		}
		},
	1 :
		{},
	2 : 
		{},
	3 :
		{},
	4 : 
		{},
}

var unit_types = [ "Warrior", "Archer", "Defender"]
var races      = [ "Unknown", "Human", "Demigod", "Driad", "Mage"]
var traits     = [ "Attacker1", "Range1", "Defender1", "Commander1"]

#33:03 Risky Game - MARiA
func generate_enemy_army():
	var commander_id = 0
	for army in range( 5 ):
		if army == 0 : continue
		for unit in range( (randi() % 5) + 2):
			var new_unit = {}
			new_unit[ "name" ]  = "RandomlyGeneratedUnit " + str(commander_id)
			new_unit[ "type" ]  = unit_types[ randi()%len(unit_types) ]
			new_unit[ "race" ]  = races[ randi()%len(races) ]
			new_unit["tags"]    = [ new_unit[ "type" ], new_unit[ "race" ], traits[ randi()%len(traits) ] ]
			new_unit["stats"]   = { "str" : randi()%11, "def" : randi()%11, "int" : randi()%11 }
			var number_of_units = randi()%701
			new_unit["amout"]   = { "max" : number_of_units, "curr" : number_of_units} 
			armies[army][unit]  = new_unit
			commander_id += 1

func get_unit_list( index ): 
	return armies[index]
