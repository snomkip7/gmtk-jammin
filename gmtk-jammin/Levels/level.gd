extends Node3D

func _ready() -> void:
	$Decoration/Trees/TreeLoadMiddle.visible = false
	$Decoration/Trees/TreeLoadMiddle.process_mode = Node.PROCESS_MODE_DISABLED

	
	$Decoration/Bushes/BushLoadMiddle.visible = false
	$Decoration/Bushes/BushLoadMiddle.process_mode = Node.PROCESS_MODE_DISABLED

func loadMiddle(_body: Node3D) -> void:
	$Decoration/Trees/TreeLoadMiddle.visible = true
	$Decoration/Trees/TreeLoadMiddle.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/Bushes/BushLoadMiddle.visible = true
	$Decoration/Bushes/BushLoadMiddle.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/MiddleLoader/Sprite3D.visible = false

func loadStart(_body: Node3D) -> void:
	$Decoration/Trees/TreeLoadStart.visible = true
	$Decoration/Trees/TreeLoadStart.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/Bushes/BushLoadStart.visible = true
	$Decoration/Bushes/BushLoadStart.process_mode = Node.PROCESS_MODE_INHERIT
	
