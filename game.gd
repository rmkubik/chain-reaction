extends Node2D


@export var levels: Array[PackedScene]

var level : Node2D
var currentLevel = 0

func _ready():
	print("doing it")
	loadCurrentLevel()

func _input(event):
	if event is InputEventKey:
		var iek = event as InputEventKey
		if iek.physical_keycode == KEY_R:
			loadCurrentLevel()

func _on_goal_completed():
	await get_tree().create_timer(3).timeout
	currentLevel = (currentLevel + 1) % levels.size()
	loadCurrentLevel()

func loadCurrentLevel():
	if level != null:
		level.queue_free()

	level = levels[currentLevel].instantiate()
	add_child(level)
	assert(level.goal != null, "Level must have a Goal node specified!")
	level.goal.goal_completed.connect(_on_goal_completed)
