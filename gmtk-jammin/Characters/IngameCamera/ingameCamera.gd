extends Node3D

@onready var subViewport = $SubViewport
@onready var tempTexture = $TempTexture

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_released("interact")):
		$Shutter.start()

func _on_shutter_timeout() -> void:
	print("Timer ran out")
	var img = subViewport.get_texture().get_image()
	global.player.photo.texture = ImageTexture.create_from_image(img)
