extends Node2D

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
			var parameters = PhysicsPointQueryParameters2D.new()
			parameters.position = Vector2(
				inputEventMouseButton.position.x,
				inputEventMouseButton.position.y
			)
			var result: Array = get_world_2d().direct_space_state.intersect_point(parameters)
			if result.size() == 0: return
			
			var rigidBody = result[0]
			var parent = rigidBody.collider.get_parent()
			
			if parent is Cannon:
				parent.aim()
				parent.aim(Vector2(5,5))
				parent.fire(100 * rng.randf_range(10.0, 100.0))
