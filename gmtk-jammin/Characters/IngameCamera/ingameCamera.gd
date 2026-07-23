extends SubViewport

@onready var shutter: Timer = $Shutter
@onready var timeDisplay: Label3D = $Camera/TimeDisplay

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_released("interact")):
		$Shutter.start()
	
	timeDisplay.text = str(shutter.time_left)
	timeDisplay.rotation = Vector3(timeDisplay.rotation.x, (Vector2(global.player.camera.global_position.x, -global.player.camera.global_position.z) - Vector2(timeDisplay.global_position.x, -timeDisplay.global_position.z)).angle() + PI/2, timeDisplay.rotation.z)

func _on_shutter_timeout() -> void:
	print("Timer ran out")
	global.player.photo.texture = ImageTexture.create_from_image(get_texture().get_image())
	print(get_texture().get_image().get_height())
	print(get_texture().get_image().get_width())
	print(get_texture().get_image().get_height()*get_texture().get_image().get_width())
	#get_tree().current_scene.get_node("NPCGeneric").trigger(1)
	var score: float = 0
	for x: int in get_texture().get_image().get_width()/10:
		for y: int in get_texture().get_image().get_height()/10:
			if get_texture().get_image().get_pixel(x*5, y*5) == Color("9E80BC"):
				score += 1
			print(get_texture().get_image().get_pixel(x*5, y*5))
			print(x*5, y*5)
	print(score, " pixels")
	score /= get_texture().get_image().get_height()*get_texture().get_image().get_width()
	print(score, "%")
