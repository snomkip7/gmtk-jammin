extends CharacterBody3D

var maxSpeed = 50
var speed = 40
var acceleration = 5 # how fast player changes movement
var gravity = -7
var dashVelocity = Vector2(110, 60)
var direction = Vector3(0,0,-1) # ALWAYS NORMALIZED
var dashing = false
var moveVelocity: Vector3 = Vector3.ZERO
var knockbackVelocity: Vector3 = Vector3.ZERO
var knockbackDeceleration = 7
var photoArray: Array[Sprite2D] = []
var doRotate = true # disables rotation
var flashing = false
@onready var camera: Camera3D = $Camera
@onready var sprite: Sprite3D = $PlayerSprite
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var timer: RichTextLabel = $Camera/PhotoLayer/Timer
@onready var photoLayer = $Camera/PhotoLayer
@onready var cameraFlash = $Camera/PhotoLayer/CameraFlash
@onready var flashBuffer = $FlashBuffer
@onready var scoreLog = $Camera/PhotoLayer/ScoreLog
@onready var faceCheck = $PlayerSprite/FaceIndicator
@onready var footCheck = $PlayerSprite/FootIndicator

@onready var rft: RayCast3D = $PlayerSprite/Raycasts/FaceTop
@onready var rfb: RayCast3D = $PlayerSprite/Raycasts/FaceBot
@onready var rfl: RayCast3D = $PlayerSprite/Raycasts/FaceLeft
@onready var rfr: RayCast3D = $PlayerSprite/Raycasts/FaceRight
@onready var rbl: RayCast3D = $PlayerSprite/Raycasts/FaceTop
@onready var rbr: RayCast3D = $PlayerSprite/Raycasts/FaceTop
@onready var rbb: RayCast3D = $PlayerSprite/Raycasts/FaceTop

const PHOTO = preload("res://Characters/Player/photo.tscn")

func _ready():
	global.player = self
	

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("dash") and !dashing:
		$Dash.play()
	if is_on_floor() && !dashing && (Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0): 
		# movement button is pressed
		direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward")).normalized()
		moveVelocity = moveVelocity.move_toward(direction * speed, acceleration)
		animationPlayer.play("playerAnims/run")
	elif dashing && !is_on_floor():
		moveVelocity = moveVelocity.move_toward(Vector3(direction.x*speed, moveVelocity.y, direction.z*speed), acceleration)
	else:
		if !dashing:
			animationPlayer.play("playerAnims/stand")
		moveVelocity = moveVelocity.move_toward(Vector3.ZERO, acceleration)
		if Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0:
			direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward")).normalized()		
	
	if Input.is_action_just_pressed("dash") && !dashing && is_on_floor():
		print("ZOOMY TIME")
		animationPlayer.play("playerAnims/dash")
		moveVelocity = Vector3(dashVelocity.x * direction.x, dashVelocity.y, dashVelocity.x * direction.z)
		$DashCooldown.start()
		dashing = true
		rft.position = Vector3(-2.292, 1.314, 0)
		rfb.position = Vector3(-1.64, -.41, 0)
		rfl.position = Vector3(-1.31, .449, 0)
		rfr.position = Vector3(-2.54, .2, 0)
		rbr.position = Vector3(-.63, -1.62, 0)
		rbl.position = Vector3(-.28, .344, 0)
		rfb.position = Vector3(3.318, -1.08, 0)
		faceCheck.position = Vector3(-2.04, .504, 0)
		footCheck.position = Vector3(2.321, 2.125, 0)
		$PlayerSprite/PoseBlocker.process_mode = Node.PROCESS_MODE_INHERIT
		
	if !is_on_floor():
		moveVelocity.y += gravity
	
	if knockbackVelocity != Vector3.ZERO:
		knockbackVelocity = knockbackVelocity.move_toward(Vector3.ZERO, knockbackDeceleration)
	
	velocity = moveVelocity + knockbackVelocity
	
	move_and_slide()
	
	if doRotate and animationPlayer.current_animation != "playerAnims/dash":
		$PlayerSprite.rotation = $Camera.rotation
	
	if flashing && flashBuffer.time_left <= 0:
		cameraFlash.modulate.a -= 0.1
	
	if(cameraFlash.modulate.a <= 0):
		flashing = false
	
	if Input.is_action_just_pressed("restart"):
		call_deferred("restart")
		
	if !dashing:
		if velocity.x != 0 or velocity.z != 0:
			if $FootSteps.playing == false:
				$FootSteps.play()


func dashEnd() -> void:
	dashing = false
	rft.position = Vector3(0, 3.299, 0)
	rfb.position = Vector3(0, 1.399, 0)
	rfl.position = Vector3(.872, 2.159, 0)
	rfr.position = Vector3(-.84, 2.103, 0)
	rbr.position = Vector3(-1.45, -1.16, 0)
	rbl.position = Vector3(1.479, -1.16, 0)
	rbb.position = Vector3(-.02, -3.3, 0)
	faceCheck.position = Vector3(0, 2.524, 0)
	footCheck.position = Vector3(0, -2.91, 0)
	$PlayerSprite/PoseBlocker.process_mode = Node.PROCESS_MODE_DISABLED

func createImage(img: Image) -> void:
	var photo = PHOTO.instantiate()
	photo.texture = ImageTexture.create_from_image(img)
	photoLayer.add_child(photo)
	photo.num = photoArray.size()
	photo.rotation = PI/20 * photoArray.size()
	photoArray.append(photo)


func updatePhotos() -> void:
	photoArray.pop_at(0)
	for i in photoArray:
		i.num = photoArray.find(i)


func _on_camera_trigger_body_entered(body: Node3D) -> void:
	var subViewport = body.get_parent().get_parent()
	if(subViewport.shutter != null && subViewport.shutter.is_stopped() && subViewport.active):
		subViewport.shutter.start()
		subViewport.animationPlayer.play("countdown")
		subViewport.cameraSound.play()

func flash():
	cameraFlash.modulate.a = 1
	flashBuffer.start()
	flashing = true
	

func restart():
	get_tree().reload_current_scene()
