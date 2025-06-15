extends Node

func _init():
	print("Hello, world!")

func _unhandled_input(event: InputEvent):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
	if event is InputEventMouseButton:
		var inputEventMouseButton: InputEventMouseButton = event as InputEventMouseButton
		if inputEventMouseButton.button_index == MOUSE_BUTTON_LEFT:
			var smiley: Node2D = load("res://smiley.tscn").instantiate()
			add_child(smiley)
			smiley.position.x = inputEventMouseButton.position.x
			smiley.position.y = inputEventMouseButton.position.y
			
			
