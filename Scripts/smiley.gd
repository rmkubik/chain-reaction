extends Node2D
class_name Smiley

@export var exploder : Exploder
var should_explode = true

func _on_rigid_body_2d_body_entered(_body: Node) -> void:
	if should_explode:
		var rb = get_node("RigidBody2D")
		exploder.show_particles(rb.global_position)
		exploder.explode(rb.global_position)
	queue_free()
