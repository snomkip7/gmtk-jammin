extends CharacterBody3D

var maxSpeed = 50
var speed = 50
var gravity = 10
var dashVelocity = Vector3(100, 40, 0)

@onready var camera: Camera3D = $Camera
@onready var sprite: Sprite3D = $PlayerSprite

func _ready():
	global.player = self
	

func _physics_process(delta: float) -> void:
	if Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0:
		# movement button is pressed
		var direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward"))
		velocity = direction.normalized() * speed
	else:
		velocity = Vector3.ZERO
		
	if Input.is_action_just_pressed("dash"):
		print("ZOOMY TIME")
		velocity += dashVelocity
		
	if !is_on_floor():
		velocity.y += gravity
	
	move_and_slide()
	
	$PlayerSprite.rotation = $Camera.rotation
