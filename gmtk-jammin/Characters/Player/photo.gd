extends Sprite2D

var num = 0

@onready var deleteTimer: Timer = $DeleteTimer

func _physics_process(delta: float) -> void:
	
	if(num == 0 && deleteTimer.is_stopped()):
		deleteTimer.start()
	
	if(deleteTimer.time_left < 1):
		global_position.y += 10


func _on_delete_timer_timeout() -> void:
	queue_free()
