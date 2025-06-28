class_name Bouncer
extends Node2D

@export var exploder : Exploder
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var rb: RigidBody2D = $"."
var should_explode = true
var bounce_count = 0

func _ready():
	# I never had to set this for Smiley! I'm not sure WHY that one 
	# actually works without this...
	rb.set_contact_monitor(true)
	rb.set_max_contacts_reported(3)
	animatedSprite.play("happy")
	

func _on_body_entered(body: Node) -> void:
	bounce_count += 1

	if (bounce_count == 1):
		animatedSprite.play("angry")
		return
		
	if (bounce_count == 2):
		animatedSprite.play("mad")
		return
	
	if should_explode:
		exploder.show_particles(rb.global_position)
		exploder.explode(rb.global_position)
	queue_free()
