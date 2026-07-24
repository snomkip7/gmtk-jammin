extends Node

var player: CharacterBody3D
var score = 0
var time = 70
var paused = false
var musicNormal
var musicFrantic
var musicTime = 64.75
var musicFader

func _ready() -> void:
	musicNormal = AudioStreamPlayer.new()
	musicFrantic = AudioStreamPlayer.new()
	#musicNormal.process_mode = Node.PROCESS_MODE_ALWAYS
	#musicFrantic.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(musicNormal)
	add_child(musicFrantic)
	musicNormal.stream = load("res://Assets/Music/gmtk game wandering.mp3")
	musicFrantic.stream = load("res://Assets/Music/frantic wandering.mp3")
	musicFrantic.volume_linear = 0.0

func _physics_process(delta: float) -> void:
	musicTime -= delta
	#print(ceili(musicTime))
	if musicNormal.playing == false and ceili(musicTime) == 64:
		musicNormal.play()
	if musicFrantic.playing == false and ceili(musicTime) == 56:
		musicFrantic.play()
	if musicTime <= 24:
		panic()
	else:
		calm()
		
	if !paused:
		time -= delta
		if player != null && player.timer != null:
			if ceili(time) % 60 < 10:
				@warning_ignore("integer_division")
				player.timer.text = str(ceili(time)/60)+":0"+str(ceili(time)%60)
			else:
				@warning_ignore("integer_division")
				player.timer.text = str(ceili(time)/60)+":"+str(ceili(time)%60)
		if time <= 0:
			endGame()
			
func endGame():
	# ends the game
	print("GAME OVER")
	time = 80
	
func calm():
	musicFader = create_tween()
	musicFader.tween_property(musicNormal, "volume_linear", float(1.0), 1.0)
	musicFader.parallel().tween_property(musicFrantic, "volume_linear", float(0.0), 1.0)

func panic():
	musicFader = create_tween()
	musicFader.tween_property(musicNormal, "volume_linear", float(0.0), 1.0)
	musicFader.parallel().tween_property(musicFrantic, "volume_linear", float(1.0), 1.0)
