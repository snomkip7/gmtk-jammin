extends Area3D


func _on_body_entered(_body: Node3D) -> void:
	global.player.speed = global.player.maxSpeed / 4


func _on_body_exited(_body: Node3D) -> void:
	global.player.speed = global.player.maxSpeed
