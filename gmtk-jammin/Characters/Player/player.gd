extends CharacterBody3D

var maxSpeed = 50
var speed = 50
var acceleration = 10 # how fast stuff moves
var gravity = -10
var dashVelocity = Vector2(100, 40)

@onready var camera: Camera3D = $Camera
@onready var sprite: Sprite3D = $PlayerSprite

func _ready():
	global.player = self
	

func _physics_process(delta: float) -> void:
	if Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0:
		# movement button is pressed
		var direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward"))
		velocity = velocity.move_toward(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, acceleration)
		
	if Input.is_action_just_pressed("dash"):
		print("ZOOMY TIME")
		var direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward")).normalized()
		if direction == Vector3.ZERO:
			direction = Vector3(0,0,-1)
		velocity += Vector3(dashVelocity.x * direction.x, dashVelocity.y, dashVelocity.x * direction.z)
		
	if !is_on_floor():
		velocity.y += gravity
	
	move_and_slide()
	
	$PlayerSprite.rotation = $Camera.rotation
