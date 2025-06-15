extends Node

var rng = RandomNumberGenerator.new()


func _init():
	print("Hello, world!")

func _unhandled_input(event: InputEvent):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
	if event is InputEventMouseButton:
		var inputEventMouseButton: InputEventMouseButton = event as InputEventMouseButton
		if inputEventMouseButton.button_index == MOUSE_BUTTON_LEFT:
			$Cannon.aim(Vector2(5,5))
			$Cannon.fire(100 * rng.randf_range(10.0, 100.0))
