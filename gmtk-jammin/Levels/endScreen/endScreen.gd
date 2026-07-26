extends Control

@onready var ogPos = $MainMenu.global_position

func _ready() -> void:
	$ScoreLabel.text = "Final Score: " + str(global.score)
	if global.score == 0:
		$ScoreLabel.text = "Final Score: " + str(global.score) + " nice job bigfoot"
	global.ended = true



func _on_button_button_down() -> void:
	$MainMenu.global_position.y = ogPos.y + 20

func _on_button_button_up() -> void:
	$MainMenu.global_position.y = ogPos.y
	get_tree().change_scene_to_file("res://Levels/menuScreen/menuScreen.tscn")
