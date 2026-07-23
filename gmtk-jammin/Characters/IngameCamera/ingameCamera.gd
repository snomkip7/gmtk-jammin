extends SubViewport

@onready var shutter: Timer = $Shutter

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_released("interact")):
		$Shutter.start()

func _on_shutter_timeout() -> void:
	print("Timer ran out")
	global.player.photo.texture = ImageTexture.create_from_image(get_texture().get_image())
	#get_tree().current_scene.get_node("NPCGeneric").trigger(1)
