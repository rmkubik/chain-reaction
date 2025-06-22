extends Node2D

var color = Color.GREEN_YELLOW

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	color = Color.RED
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2(300, 300), 100, color, true)
