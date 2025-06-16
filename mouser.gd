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
# cannon we're firing
var cannon: Cannon

func _start_drag(pos: Vector2, cannon: Cannon = null):
	is_dragging = true
	anchor = pos
	_update_mouse(pos)
	print("Mouse down at ", anchor)
	self.cannon = cannon
	print("cannon is ", cannon)
	
func _update_mouse(pos: Vector2):
	mouse_pos = pos
	normal = (pos - anchor).normalized()
	fire_normal = (anchor - pos).normalized()
	length = (pos - anchor).length()
	if cannon != null and length > 5:
		cannon.aim(fire_normal)

func _release(pos: Vector2):
	is_dragging = false
	print("Mouse up at ", pos)
	var vec = (pos - anchor).normalized()
	if cannon != null and length > 5:
		cannon.fire(length)

func _get_cannon(mouse_pos: Vector2) -> Cannon:
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = mouse_pos
	var result: Array = get_world_2d().direct_space_state.intersect_point(parameters)
	if result.size() == 0: return
	var rigidBody = result[0]
	var parent = rigidBody.collider.get_parent()	
	if parent is Cannon:
		return parent
	return null

func _input(event: InputEvent):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		var mbe = event as InputEventMouseButton
		if mbe.button_index != 1:
			return
		if mbe.pressed:
			var cannon = _get_cannon(mbe.position)
			if cannon:
				_start_drag(mbe.position, cannon)
		elif is_dragging:
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

#func _draw():
	#if not is_dragging:
		#return
	#draw_circle(anchor, 5, Color.WHEAT)
	#draw_circle(mouse_pos, 5, Color.WHEAT)
	#draw_line(anchor, mouse_pos, Color.ALICE_BLUE)
	#draw_line(anchor, anchor + normal * 100, Color.GREEN, 3)
	#draw_line(anchor, anchor + fire_normal * 100, Color.RED, 3)
	#
