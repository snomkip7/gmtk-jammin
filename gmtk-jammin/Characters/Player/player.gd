extends CharacterBody3D

var speed = 50 

func _ready():
	global.cameraRotation = $Camera.global_basis
	global.player = self
	

func _physics_process(delta: float) -> void:
	if Input.get_axis("backward", "forward") != 0 || Input.get_axis("left", "right") != 0:
		# movement button is pressed
		var direction = Vector3(Input.get_axis("left", "right"), 0, Input.get_axis("forward", "backward"))
		velocity = direction.normalized() * speed
	else:
		velocity = Vector3.ZERO
	
	move_and_slide()
	
	$PlayerSprite.rotation = $Camera.rotation
