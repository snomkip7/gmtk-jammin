extends Sprite2D

var num = 0
var mod: bool = false

@onready var deleteTimer: Timer = $DeleteTimer

func _ready() -> void:
	modulate.r = 0
	modulate.g = 0
	modulate.b = 0

func _physics_process(delta: float) -> void:
	
	if(deleteTimer.is_stopped()):
		deleteTimer.start()
	
	if(mod && texture != null):
		modulate.a -= 0.1
	
	if(modulate.r <= 1 && modulate.g <= 1 && modulate.b <= 1):
		modulate.r += 0.05
		modulate.g += 0.05
		modulate.b += 0.05
	
	if(modulate.a <= 0):
		global.player.updatePhotos()
		queue_free()
	
	rotation = lerpf(rotation, PI/20 * num, 0.5)

func _on_delete_timer_timeout() -> void:
	mod = true
