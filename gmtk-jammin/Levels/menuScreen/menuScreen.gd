extends Control

func _ready() -> void:
	global.ended = false
	global.time = 6
	global.score = 0
	global.musicTime = 64.75
	global.paused = true

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("continue"):
		#global.paused = false
		#get_tree().change_scene_to_file("res://Levels/Level.tscn")
	#if Input.is_action_just_pressed("interact"):
		#global.paused = false
		#get_tree().change_scene_to_file("res://Levels/testLevel.tscn")

func startGame() -> void:
	global.paused = false
	get_tree().change_scene_to_file("res://Levels/Level.tscn")
