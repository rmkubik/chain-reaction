extends Node2D
class_name Cannon

func fire(power: float):
	var smiley: Node2D = load("res://smiley.tscn").instantiate()
	add_child(smiley)
	smiley.position.x = $".".position.x
	smiley.position.y = $".".position.y
	var rb: RigidBody2D = smiley.get_node('RigidBody2D')
	rb.add_constant_central_force(Vector2.from_angle($".".rotation) * power)

func aim(direction: Vector2):
	$".".rotation = direction.angle()


func _on_rigid_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mbe = event as InputEventMouseButton
		if mbe.button_index != 1:
			return
		if mbe.pressed:
			print("calling")
			$"../Mouser".on_cannon_clicked(self)
