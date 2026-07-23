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
var numPhotos = 0
@onready var camera: Camera3D = $Camera
@onready var sprite: AnimatedSprite3D = $PlayerSprite
@onready var timer: RichTextLabel = $Camera/PhotoLayer/Timer
@onready var photoLayer = $Camera/PhotoLayer

const PHOTO = preload("res://Characters/Player/photo.tscn")

func _ready():
	global.player = self
	

func _physics_process(_delta: float) -> void:
	if is_on_floor() && Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0:
		# movement button is pressed
		direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward")).normalized()
		moveVelocity = moveVelocity.move_toward(direction * speed, acceleration)
	else:
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
	photoLayer.add_child(photo)
	numPhotos += 1
	photo.position = Vector2(159.0,547.0)
	photo.texture = ImageTexture.create_from_image(img)
