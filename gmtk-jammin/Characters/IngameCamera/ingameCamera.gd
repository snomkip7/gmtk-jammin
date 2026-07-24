extends SubViewport

@onready var shutter: Timer = $Shutter
@onready var timeDisplay: Label3D = $Camera/TimeDisplay
@onready var point: Node3D = $Camera/Point

var NPCRays: Array[RayCast3D] = []

var faceScore = 50
var bodyScore = 25
var dashScore = 70
var npcScore = 80
var active: bool = true

func _physics_process(delta: float) -> void:
	
	if(active):
		timeDisplay.text = str(shutter.time_left)
		timeDisplay.rotation = Vector3(timeDisplay.rotation.x, (-Vector2(global.player.camera.global_position.x, -global.player.camera.global_position.z) + Vector2(timeDisplay.global_position.x, -timeDisplay.global_position.z)).angle() + PI/2, timeDisplay.rotation.z)
		if !shutter.is_stopped() && shutter.time_left < .02:
			global.player.doRotate = false
			global.player.get_node("PlayerSprite").rotation = Vector3(global.player.rotation.x, (-Vector2($Camera.global_position.x, -$Camera.global_position.z) + Vector2(global.player.global_position.x, -global.player.global_position.z)).angle() + PI/2, global.player.rotation.z)
			if global.player.dashing:
				global.player.animationPlayer.play("playerAnims/poseLay")
			else:
				global.player.animationPlayer.play("playerAnims/poseSmirk")
			for i in NPCRays:
				var e: CharacterBody3D = i.get_parent()
				e.doRotate = false
				e.get_node("NPCSprite").rotation = Vector3(e.rotation.x, (-Vector2($Camera.global_position.x, -$Camera.global_position.z) + Vector2(e.global_position.x, -e.global_position.z)).angle() + PI/2, e.rotation.z)


func _on_shutter_timeout() -> void:
	if(active):
		print("Timer ran out")
		for i in NPCRays:
			var e: CharacterBody3D = i.get_parent()
			e.get_node("NPCSprite").rotation = Vector3(e.rotation.x, (-Vector2($Camera.global_position.x, -$Camera.global_position.z) + Vector2(e.global_position.x, -e.global_position.z)).angle() + PI/2, e.rotation.z)
			#e.rotation = $Camera.rotation
		
		global.player.get_node("PlayerSprite").rotation = Vector3(global.player.rotation.x, (-Vector2($Camera.global_position.x, -$Camera.global_position.z) + Vector2(global.player.global_position.x, -global.player.global_position.z)).angle() + PI/2, global.player.rotation.z)
		
		var img = get_texture().get_image()
		if(img == null):
			return
		#print(img.get_height())
		#print(img.get_width())
		#print(img.get_height()*img.get_width())
		#get_tree().current_scene.get_node("NPCGeneric").trigger(1)
		
		var score: float = 0
		for x: int in img.get_width()/2:
			for y: int in img.get_height()/2:
				#if img.get_pixel(x, y).is_equal_approx(Color("9E80BC")):
				if colorEqual(img.get_pixel(x*2, y*2), Color("9E80BC")):
					score += 1
				#print(img.get_pixel(x*5, y*5))
				#print(x*5, " ", y*5)
		print(score, " pixels")
		score /= (img.get_height()*img.get_width()/4)
		print(score, "%")
		score = sqrt(score)*1000
		
		print(score, " from being in the img")
		global.score += score
		if score > 0:
			addToScore()
		
		global.player.createImage(img)
		
		timeDisplay.visible = false
		active = false
		global.player.doRotate = true
		for i in NPCRays:
				var e: CharacterBody3D = i.get_parent()
				e.doRotate = true
	
func colorEqual(c1: Color, c2: Color):
	if abs(c1.r8-c2.r8) < 10 && abs(c1.g8-c2.g8) < 10 && abs(c1.b8-c2.b8) < 10:
		return true
	else:
		return false
		
func addToScore():
	if global.player.dashing && !global.player.is_on_floor():
		global.score += dashScore
		print("Dashing in the photo! +", dashScore, "!")
	
	# checking if the face is the the picture
	global.player.rft.target_position = point.global_position-global.player.rft.global_position
	global.player.rfb.target_position = point.global_position-global.player.rfb.global_position
	global.player.rfl.target_position = point.global_position-global.player.rfl.global_position
	global.player.rfr.target_position = point.global_position-global.player.rfr.global_position
	
	global.player.rft.force_raycast_update()
	global.player.rfb.force_raycast_update()
	global.player.rfl.force_raycast_update()
	global.player.rfr.force_raycast_update()
	# if face is not obscured
	if !(global.player.rft.is_colliding() && global.player.rfb.is_colliding() && global.player.rfl.is_colliding() && global.player.rfr.is_colliding()):
		global.score += faceScore
		print("Face in photo! +", faceScore, "!")
		
		#checking if body is in the photo
		global.player.rbl.target_position = point.global_position-global.player.rbl.global_position
		global.player.rbr.target_position = point.global_position-global.player.rbr.global_position
		global.player.rbb.target_position = point.global_position-global.player.rbb.global_position
	
		if !(global.player.rbb.is_colliding() && global.player.rbl.is_colliding() && global.player.rbr.is_colliding()):
			global.score += bodyScore
			print("Body in photo! +", bodyScore, "!")
		else:
			print("no body in photo :(")
			
	else:
		print("no face in photo :(")
	
	for i in NPCRays:
		i.force_raycast_update()
		if i.is_colliding():
			global.score += npcScore
			print("In the way! +", npcScore, "!")
	
	print("Total Score: ", global.score)
