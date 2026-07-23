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
	var img = get_texture().get_image()
	if(img == null):
		return
	print(img.get_height())
	print(img.get_width())
	print(img.get_height()*img.get_width())
	#get_tree().current_scene.get_node("NPCGeneric").trigger(1)
	
	var score: float = 0
	for x: int in img.get_width():
		for y: int in img.get_height():
			#if img.get_pixel(x, y).is_equal_approx(Color("9E80BC")):
			if colorEqual(img.get_pixel(x, y), Color("9E80BC")):
				score += 1
			#print(img.get_pixel(x*5, y*5))
			#print(x*5, " ", y*5)
	print(score, " pixels")
	score /= (img.get_height()*img.get_width())
	print(score, "%")
	
	print(sqrt(score)*1000)
	global.player.createImage(img)
	
func colorEqual(c1: Color, c2: Color):
	if abs(c1.r8-c2.r8) < 10 && abs(c1.g8-c2.g8) < 10 && abs(c1.b8-c2.b8) < 10:
		return true
	else:
		return false
