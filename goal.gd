extends Node2D
class_name Goal

var area: Area2D
var collisionShape: CollisionShape2D
var isColliding: bool
@onready var animatedSprite: AnimatedSprite2D = $Area2D/AnimatedSprite2D

func _ready() -> void:
	area = get_node("Area2D")
	collisionShape = get_node('Area2D/CollisionShape2D')
	animatedSprite.play("open")
	

#func _draw():
	##var collisionShape: CollisionShape2D = get_node('Area2D/CollisionShape2D')
	##print(collisionShape.shape.get_rect().size.x)
	##print($".".position)
	#var color = Color.hex(0xa9ff9cff)
	#if (isColliding):
		#color = Color.hex(0x13ad3cff)
	#draw_circle(Vector2(0,0), collisionShape.shape.radius, color)

	
#func _process(delta):
	#for body in area.get_overlapping_bodies():
		##if body.is_in_group("somegroup"):
		#print("collisions!")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print('entered')
	if body is Target:
		animatedSprite.play("lick")
		body.queue_free()
	isColliding = true
	queue_redraw()

func _on_area_2d_body_exited(body: Node2D) -> void:
	print('exited')
	isColliding = false
	queue_redraw()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animatedSprite.animation == 'lick':
		animatedSprite.play('closed')
	
