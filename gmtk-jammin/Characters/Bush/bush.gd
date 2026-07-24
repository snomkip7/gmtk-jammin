extends Area3D


func _physics_process(_delta: float) -> void:
	pass
	#rotation = Vector3(rotation.x, (Vector2(global.player.camera.global_position.x, -global.player.camera.global_position.z) - Vector2(global_position.x, -global_position.z)).angle() + PI/2, rotation.z)


func _on_body_entered(_body: Node3D) -> void:
	global.player.speed = global.player.maxSpeed / 4


func _on_body_exited(_body: Node3D) -> void:
	global.player.speed = global.player.maxSpeed
