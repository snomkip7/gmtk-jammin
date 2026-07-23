extends Node3D

@onready var subViewport = $SubViewport
@onready var tempTexture = $TempTexture
@onready var camera = $SubViewport/Camera

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_released("interact")):
		$Shutter.start()

func _on_shutter_timeout() -> void:
	print("SNAP! You dun got photoed")
	await RenderingServer.frame_post_draw
	global.player.photo.texture = ImageTexture.create_from_image(get_viewport().get_texture().get_image())
