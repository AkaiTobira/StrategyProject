extends TextureButton

var mouse_over = false
var timeOfShow = 1

var timer = 0
var wait  = 3

func _process(delta):
	if not mouse_over: return
	timer += delta
	if timer < wait : return
	$Tip.modulate.a = min( 1, $Tip.modulate.a + delta * timeOfShow )

func _on_TextureButton_mouse_entered():
	$Tip.modulate.a = 0
	$Tip.visible    = true
	mouse_over = true

func _on_TextureButton_mouse_exited():
	timer      = 0
	mouse_over = false
	$Tip.visible    = false
