extends Node

func _init():
	print("Hello, world!")

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var smiley: Node2D = load("res://smiley.tscn").instantiate()
			add_child(smiley)
			smiley.position.x = (event as InputEventMouseButton).position.x
			smiley.position.y = (event as InputEventMouseButton).position.y
			
			
