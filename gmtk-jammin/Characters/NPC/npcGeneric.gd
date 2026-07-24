extends CharacterBody3D

@export var aggression = 0
# 0 for does nothing, 1 for gets annoyed, 2 for pushing you away, 3 for smacking you, 4 for chasing you
var pushForce = 70 # multiplied by severity
var tooClose = false # if you enter the npc's personal space
var inTheWay = false # if you are inbetween the camera and the npc (raycast colliding)
@export var reactionTime = .5 # how fast the npc gets annoyed if you're too close
var cameraStage = 1 # 1 for before photo, 2 for counting down, 3 for after photo
@export var camera: SubViewport # camera taking this NPC's photo
@export var personalSpaceSize: float = 2.5
@export var pushRadius: float = 4 # how far you can be and they push you
var angryPersonalSpace = 4
var baseSpeed = 15
var speed = 0
var state = 1 # 1=default, 2 = acting, 3 = recovery
@onready var startingPoint: Vector3 = global_position
@onready var animationPlayer: Node = $AnimationPlayer

func _ready() -> void:
	camera.NPCRays.append($CameraRay)

func _physics_process(_delta: float) -> void:
	# rotation
	$NPCSprite.rotation = Vector3(rotation.x, (Vector2(global.player.camera.global_position.x, -global.player.camera.global_position.z) - Vector2(global_position.x, -global_position.z)).angle() + PI/2, rotation.z)
	
	$CameraRay.target_position = camera.point.global_position-$CameraRay.global_position
	$CameraRay.force_raycast_update()
	
	if $CameraRay.is_colliding():
		inTheWay = true
		if $AngerTimer.is_stopped():
			$AngerTimer.start(reactionTime)
			print("in the way!")
	else:
		inTheWay = false
	
	# camera stages
	if !camera.shutter.is_stopped() && camera.shutter.time_left < 3 && cameraStage==1:
		cameraStage = 2
		print("camera stage 2")
	elif !camera.shutter.is_stopped() && camera.shutter.time_left <= 1 && cameraStage==2:
		cameraStage = 3
		print("camera stage 3")
	elif camera.shutter.is_stopped() && cameraStage == 3:
		cameraStage = 4
		print("camera stage 4")
	
	if aggression==3 && state==2: # chasing personal space
		if (global.player.global_position-global_position).length() > angryPersonalSpace:
			tooClose = false
		else:
			tooClose = true
			if $AngerTimer.is_stopped():
				$AngerTimer.start(reactionTime)
				print("too close!")
	elif aggression!=3 || state==1: # personal space normally
		if (global.player.global_position-global_position).length() > personalSpaceSize:
			tooClose = false
		else:
			tooClose = true
			if $AngerTimer.is_stopped():
				$AngerTimer.start(reactionTime)
				print("too close!")
		
	
	if state==2 && aggression==3: # chases the player 
		velocity =  (global.player.global_position-global_position).normalized()
		velocity.y = 0
		velocity = velocity.normalized() * speed
	elif state == 3 && aggression == 3: # returning after chasing
		velocity =  (startingPoint-global_position).normalized()
		velocity.y = 0
		velocity = velocity.normalized() * baseSpeed
	else:
		velocity = Vector3.ZERO
		
	move_and_slide()
	
	# if done returning
	if state == 3 && aggression==3 && (startingPoint-global_position).length() < .5:
		state = 1

func trigger(severity: float = 1): # after a photo has been photobombed, severity = how much reaction (1-3)
	print("acting with severity: ", severity)
	if aggression == 0: #do nothing
		animationPlayer.play("npcAnims/standShock") 
	if aggression == 1: # gets annoyed
		#play angry voice clip
		animationPlayer.play("npcAnims/standAngry")
	if aggression == 2: # pushes you away
		# angry voice
		animationPlayer.play("npcAnims/standAngry")
		if (global.player.global_position-global_position).length() <= pushRadius:
			global.player.knockbackVelocity = (global.player.global_position-global_position).normalized() * pushForce * (severity/3+1)
			global.time -= 5
	if aggression == 3: #chases after you
		animationPlayer.play("npcAnims/standAngry")
		if (global.player.global_position-global_position).length() <= pushRadius:
			global.player.knockbackVelocity = (global.player.global_position-global_position).normalized() * pushForce * (severity/3+1)
		if $ActionTimer.is_stopped() && state == 1:
			$ActionTimer.start(severity/2)
			speed = baseSpeed * (severity/2+1)
			state = 2

func angerCheck() -> void: # check if player is still too close
	if (tooClose || inTheWay) && (cameraStage == 2 || cameraStage == 3):
		trigger(cameraStage)
	elif (tooClose || inTheWay):
		trigger(1)
	else:
		print("nvm, ur good")

func actionEnd() -> void:
	state = 3
