extends Sprite2D

var num = 0
var mod: bool = false

@onready var deleteTimer: Timer = $DeleteTimer

func _physics_process(delta: float) -> void:
	
	if(deleteTimer.is_stopped()):
		deleteTimer.start()
	
	if(mod && texture != null):
		modulate.a -= 10
	
	rotation = lerpf(rotation, PI/20 * num, 0.5)

func _on_delete_timer_timeout() -> void:
	mod = true
	global.player.updatePhotos()
	queue_free()
