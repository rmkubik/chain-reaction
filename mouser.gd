extends Node2D

# true if the user has clicked
var is_dragging: bool
# the pos where the user originally clicked
var anchor: Vector2
# the current mouse pos
var mouse_pos: Vector2
# normalized direction vector
var normal: Vector2
# opposite of normal
var fire_normal: Vector2
# length of drag
var length: float

func _start_drag(pos: Vector2):
	is_dragging = true
	anchor = pos
	_update_mouse(pos)
	print("Mouse down at ", anchor)
	
func _update_mouse(pos: Vector2):
	mouse_pos = pos
	normal = (pos - anchor).normalized()
	fire_normal = (anchor - pos).normalized()
	length = (pos - anchor).length()

func _release(pos: Vector2):
	is_dragging = false
	print("Mouse up at ", pos)
	var vec = (pos - anchor).normalized()

func _input(event: InputEvent):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		var mbe = event as InputEventMouseButton
		if mbe.button_index != 1:
			return
		if mbe.pressed:
			_start_drag(mbe.position)
		else:
			_release(mbe.position)
		queue_redraw()
	elif event is InputEventMouseMotion:
		if not is_dragging:
			return
		var mme = event as InputEventMouseMotion
		_update_mouse(mme.position)
		queue_redraw()
		#print("Mouse Motion at: ", event.position)

	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)

func _draw():
	if not is_dragging:
		return
	draw_circle(anchor, 5, Color.WHEAT)
	draw_circle(mouse_pos, 5, Color.WHEAT)
	draw_line(anchor, mouse_pos, Color.ALICE_BLUE)
	draw_line(anchor, anchor + normal * 100, Color.GREEN, 3)
	draw_line(anchor, anchor + fire_normal * 100, Color.RED, 3)
	
