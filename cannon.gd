extends Node2D
class_name Cannon

func fire(power: float):
	var smiley: Node2D = load("res://smiley.tscn").instantiate()
	var cannonRB: RigidBody2D = get_node('RigidBody2D')
	var smileyRB: RigidBody2D = smiley.get_node('RigidBody2D')
	var spawnPoint = get_node('SpawnPoint')
	smileyRB.position.x = spawnPoint.global_position.x
	smileyRB.position.y = spawnPoint.global_position.y
	smileyRB.add_collision_exception_with(cannonRB)
	get_node("/root").add_child(smiley)
	#smileyRB.add_constant_central_force(Vector2.from_angle($".".rotation) * power)
	smileyRB.apply_impulse(Vector2.from_angle($".".rotation) * power)

func aim(direction: Vector2):
	$".".rotation = direction.angle()
