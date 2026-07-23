extends CharacterBody3D

var maxSpeed = 50
var speed = 50
var acceleration = 10 # how fast player changes movement
var gravity = -10
var dashVelocity = Vector2(100, 70)
var direction = Vector3(0,0,-1) # ALWAYS NORMALIZED

@onready var camera: Camera3D = $Camera
@onready var sprite: Sprite3D = $PlayerSprite
@onready var photo: Sprite2D = $Camera/PhotoLayer/Photo

func _ready():
	global.player = self
	

func _physics_process(delta: float) -> void:
	if Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0:
		# movement button is pressed
		direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward"))
		velocity = velocity.move_toward(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, acceleration)
		
	if Input.is_action_just_pressed("dash") && $DashCooldown.is_stopped():
		print("ZOOMY TIME")
		velocity += Vector3(dashVelocity.x * direction.x, dashVelocity.y, dashVelocity.x * direction.z)
		$DashCooldown.start()
		
	if !is_on_floor():
		velocity.y += gravity
	
	move_and_slide()
	
	$PlayerSprite.rotation = $Camera.rotation
