extends Node2D

func fire(power: float):
	var smiley: Node2D = load("res://smiley.tscn").instantiate()
	add_child(smiley)
	smiley.position.x = $".".position.x
	smiley.position.y = $".".position.y
	var rb: RigidBody2D = smiley.get_node('RigidBody2D')
	rb.add_constant_central_force(Vector2.from_angle($".".rotation) * power)

func aim(direction: Vector2):
	$".".rotation = direction.angle()
