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
	#get_tree().current_scene.get_node("NPCGeneric").trigger(1)
