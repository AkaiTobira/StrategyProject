extends Camera2D
class_name MainCamera

var _previousPosition: Vector2 = Vector2(0, 0);
var _moveCamera: bool = false;
var MoveSpeed  = 2
var zoom_speed = 0.1 
var MAX_ZOOM   = Vector2( 4, 4)
var MIN_ZOOM   = Vector2( 1, 1)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		get_tree().set_input_as_handled();
		if event.is_pressed():
			_previousPosition = event.position;
			_moveCamera = true;
		else:
			_moveCamera = false;
	elif event is InputEventMouseMotion && _moveCamera:
		get_tree().set_input_as_handled();
		position += (_previousPosition - event.position) * MoveSpeed;
		_previousPosition = event.position;

	if event is InputEventMouseButton :
		if event.button_index ==  BUTTON_WHEEL_DOWN:
			zoom.x = min( MAX_ZOOM.x,  zoom.x + zoom_speed )
			zoom.y = min( MAX_ZOOM.y,  zoom.y + zoom_speed )
		elif event.button_index == BUTTON_WHEEL_UP:
			zoom.x = max( MIN_ZOOM.x,  zoom.x - zoom_speed )
			zoom.y = max( MIN_ZOOM.y,  zoom.y - zoom_speed )
