extends Node2D

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	print("exploding")
	var explosion: Node2D = load("res://explosion.tscn").instantiate()
	var rb = get_node("RigidBody2D")
	explosion.position.x = rb.global_position.x
	explosion.position.y = rb.global_position.y
	var particles = explosion.get_node("CPUParticles2D") as CPUParticles2D
	get_node("/root").add_child(explosion)
	particles.emitting = true
	queue_free()
