extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_build_menu():
	if not UIHandle.is_player_teritory_selected(): pass
		#show_menu()


func _process(delta):
	$UpperPart/Label.text = str(PlayerInfo.gold).pad_zeros(7)

