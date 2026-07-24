extends CharacterBody3D

var maxSpeed = 50
var speed = 40
var acceleration = 10 # how fast player changes movement
var gravity = -10
var dashVelocity = Vector2(70, 90)
var direction = Vector3(0,0,-1) # ALWAYS NORMALIZED
var dashing = false
var moveVelocity: Vector3 = Vector3.ZERO
var knockbackVelocity: Vector3 = Vector3.ZERO
var knockbackDeceleration = 7
var photoArray: Array[Sprite2D] = []
@onready var camera: Camera3D = $Camera
@onready var sprite: Sprite3D = $PlayerSprite
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var timer: RichTextLabel = $Camera/PhotoLayer/Timer
@onready var photoLayer = $Camera/PhotoLayer

@onready var rft: RayCast3D = $Raycasts/FaceTop
@onready var rfb: RayCast3D = $Raycasts/FaceBot
@onready var rfl: RayCast3D = $Raycasts/FaceLeft
@onready var rfr: RayCast3D = $Raycasts/FaceRight
@onready var rbl: RayCast3D = $Raycasts/FaceTop
@onready var rbr: RayCast3D = $Raycasts/FaceTop
@onready var rbb: RayCast3D = $Raycasts/FaceTop


const PHOTO = preload("res://Characters/Player/photo.tscn")

func _ready():
	global.player = self
	

func _physics_process(_delta: float) -> void:
	if is_on_floor() && Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0:
		# movement button is pressed
		direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward")).normalized()
		moveVelocity = moveVelocity.move_toward(direction * speed, acceleration)
		animationPlayer.play("playerAnims/run")
	else:
		animationPlayer.play("playerAnims/stand")
		moveVelocity = moveVelocity.move_toward(Vector3.ZERO, acceleration)
		
	if Input.is_action_just_pressed("dash") && !dashing && is_on_floor():
		print("ZOOMY TIME")
		moveVelocity = Vector3(dashVelocity.x * direction.x, dashVelocity.y, dashVelocity.x * direction.z)
		$DashCooldown.start()
		dashing = true
		
	if !is_on_floor():
		moveVelocity.y += gravity
	
	if knockbackVelocity != Vector3.ZERO:
		knockbackVelocity = knockbackVelocity.move_toward(Vector3.ZERO, knockbackDeceleration)
	
	velocity = moveVelocity + knockbackVelocity
	
	move_and_slide()
	
	$PlayerSprite.rotation = $Camera.rotation


func dashEnd() -> void:
	dashing = false

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
