extends Node2D
class_name Smiley

@export var explosion : PackedScene

var explosion_radius = 128
var explosion_force = 5
var should_explode = true

## push away objects in a radius
func explode(pos: Vector2):
	var space_state = get_world_2d().direct_space_state
	var params : PhysicsShapeQueryParameters2D = PhysicsShapeQueryParameters2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = explosion_radius
	params.shape = circle_shape
	params.transform = Transform2D(0, pos)
	params.collide_with_areas = false
	params.collide_with_bodies = true
	var result = space_state.intersect_shape(params)
	for r in result:
		# apparently in godot you can't get the point of intersection from
		# the intersect test, so we have to just push the object away based
		# on the center of the explosion vs the center of the object.  so this
		# is not good physics for complicated objects and won't apply torque
		# properly, and the distance to explosion will be wrong.
		# todo - find a workaround?
		if r["collider"] is RigidBody2D:
			var rb : RigidBody2D = r["collider"]
			var vec = rb.global_position - pos
			rb.apply_impulse(vec.normalized() * max(0, (explosion_radius - vec.length()) * explosion_force))

func show_particles(pos: Vector2):
	var expl: Node2D = explosion.instantiate()
	expl.position.x = pos.x
	expl.position.y = pos.y
	var particles = expl.get_node("CPUParticles2D") as CPUParticles2D
	get_node("/root").add_child(expl)
	particles.emitting = true
	# delete the particles after a couple seconds
	get_tree().create_timer(2).timeout.connect(expl.queue_free)

func _on_rigid_body_2d_body_entered(_body: Node) -> void:
	if should_explode:
		var rb = get_node("RigidBody2D")
		show_particles(rb.global_position)
		explode(rb.global_position)
	queue_free()
