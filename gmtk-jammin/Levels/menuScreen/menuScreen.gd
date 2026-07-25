extends Node2D

func startGame() -> void:
	global.paused = false
	get_tree().change_scene_to_file("res://Levels/testLevel.tscn")
