extends Node

var player: CharacterBody3D
var score = 0
var time = 70
var paused = false

func _process(delta: float) -> void:
	if !paused:
		time -= delta
		if player != null && player.timer != null:
			if roundi(time) % 60 < 10:
				@warning_ignore("integer_division")
				player.timer.text = str(roundi(time)/60)+":0"+str(roundi(time)%60)
			else:
				@warning_ignore("integer_division")
				player.timer.text = str(roundi(time)/60)+":"+str(roundi(time)%60)
		if time <= 0:
			endGame()
			
			
func endGame():
	# ends the game
	print("GAME OVER")
	time = 80
