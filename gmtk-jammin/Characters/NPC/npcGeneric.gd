extends CharacterBody3D

@export var aggression = 0
# 0 for does nothing, 1 for gets annoyed, 2 for pushing you away, 3 for smacking you, 4 for chasing you
var pushForce = 70 # multiplied by severity


func _ready() -> void:
	$NPCSprite.modulate = Color("ff6f1d")

func _physics_process(_delta: float) -> void:
	rotation = Vector3(rotation.x, (Vector2(global.player.camera.global_position.x, -global.player.camera.global_position.z) - Vector2(global_position.x, -global_position.z)).angle() + PI/2, rotation.z)

func trigger(severity: float = 1): # after a photo has been photobombed, severity = how much reaction (1-3)
	if aggression == 0: #do nothing
		pass 
	if aggression == 1: # gets annoyed
		#play angry voice clip
		$NPCSprite.modulate = Color("ff171d")
	if aggression == 2: # pushes you away
		# angry voice
		$NPCSprite.modulate = Color("bc001d")
		global.player.knockbackVelocity = (global.player.global_position-global_position).normalized() * pushForce * (severity/3+1)
		global.time -= 5
	if aggression == 3:
		$NPCSprite.modulate = Color("bc001d")
		global.player.knockbackVelocity = (global.player.global_position-global_position).normalized() * pushForce * (severity/3+1)
		global.time -= 5


func spaceEntered(body: Node3D) -> void:
	pass # Replace with function body.


func spaceExited(body: Node3D) -> void:
	pass # Replace with function body.
