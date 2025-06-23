extends Node2D

@export var Level : PackedScene

var level : Node2D;

func _ready():
	print("doing it")
	level = Level.instantiate()
	add_child(level)

func _input(event):
	if event is InputEventKey:
		var iek = event as InputEventKey
		if iek.physical_keycode == KEY_R:
			level.queue_free()
			level = Level.instantiate()
			add_child(level)
