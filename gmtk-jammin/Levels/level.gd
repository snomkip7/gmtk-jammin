extends Node3D

func _ready() -> void:
	$Decoration/Trees/TreeLoadMiddle.visible = false
	$Decoration/Trees/TreeLoadMiddle.process_mode = Node.PROCESS_MODE_DISABLED
	$Decoration/Trees/TreeLoadLeft.visible = false
	$Decoration/Trees/TreeLoadLeft.process_mode = Node.PROCESS_MODE_DISABLED
	$Decoration/Trees/TreeLoadRight.visible = false
	$Decoration/Trees/TreeLoadRight.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Bushes/BushLoadMiddle.visible = false
	$Decoration/Bushes/BushLoadMiddle.process_mode = Node.PROCESS_MODE_DISABLED
	$Decoration/Bushes/BushLoadLeft.visible = false
	$Decoration/Bushes/BushLoadLeft.process_mode = Node.PROCESS_MODE_DISABLED
	$Decoration/Bushes/BushLoadRight.visible = false
	$Decoration/Bushes/BushLoadRight.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Hedges/HedgeLoad.visible = false
	$Decoration/Hedges/HedgeLoad.process_mode = Node.PROCESS_MODE_DISABLED

func loadMiddle(_body: Node3D) -> void:
	$Decoration/Trees/TreeLoadMiddle.visible = true
	$Decoration/Trees/TreeLoadMiddle.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/Bushes/BushLoadMiddle.visible = true
	$Decoration/Bushes/BushLoadMiddle.process_mode = Node.PROCESS_MODE_INHERIT
	

func loadLeft(_body: Node3D) -> void:
	$Decoration/Trees/TreeLoadLeft.visible = true
	$Decoration/Trees/TreeLoadLeft.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/Bushes/BushLoadLeft.visible = true
	$Decoration/Bushes/BushLoadLeft.process_mode = Node.PROCESS_MODE_INHERIT
	
	# deload start
	$Decoration/Trees/TreeLoadStart.visible = false
	$Decoration/Trees/TreeLoadStart.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Bushes/BushLoadStart.visible = false
	$Decoration/Bushes/BushLoadStart.process_mode = Node.PROCESS_MODE_DISABLED
	
	#deload right
	$Decoration/Trees/TreeLoadRight.visible = false
	$Decoration/Trees/TreeLoadRight.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Bushes/BushLoadRight.visible = false
	$Decoration/Bushes/BushLoadRight.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Hedges/HedgeLoad.visible = false
	$Decoration/Hedges/HedgeLoad.process_mode = Node.PROCESS_MODE_DISABLED
	

func loadRight(_body: Node3D) -> void:
	$Decoration/Trees/TreeLoadRight.visible = true
	$Decoration/Trees/TreeLoadRight.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/Bushes/BushLoadRight.visible = true
	$Decoration/Bushes/BushLoadRight.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/Hedges/HedgeLoad.visible = true
	$Decoration/Hedges/HedgeLoad.process_mode = Node.PROCESS_MODE_INHERIT
	
	# deload start
	$Decoration/Trees/TreeLoadStart.visible = false
	$Decoration/Trees/TreeLoadStart.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Bushes/BushLoadStart.visible = false
	$Decoration/Bushes/BushLoadStart.process_mode = Node.PROCESS_MODE_DISABLED
	
	#deload left
	$Decoration/Trees/TreeLoadLeft.visible = false
	$Decoration/Trees/TreeLoadLeft.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Bushes/BushLoadLeft.visible = false
	$Decoration/Bushes/BushLoadLeft.process_mode = Node.PROCESS_MODE_DISABLED

func loadStart(_body: Node3D) -> void:
	$Decoration/Trees/TreeLoadStart.visible = true
	$Decoration/Trees/TreeLoadStart.process_mode = Node.PROCESS_MODE_INHERIT
	
	$Decoration/Bushes/BushLoadStart.visible = true
	$Decoration/Bushes/BushLoadStart.process_mode = Node.PROCESS_MODE_INHERIT
	
	#deload left
	$Decoration/Trees/TreeLoadLeft.visible = false
	$Decoration/Trees/TreeLoadLeft.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Bushes/BushLoadLeft.visible = false
	$Decoration/Bushes/BushLoadLeft.process_mode = Node.PROCESS_MODE_DISABLED
	
	#deload right
	$Decoration/Trees/TreeLoadRight.visible = false
	$Decoration/Trees/TreeLoadRight.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Bushes/BushLoadRight.visible = false
	$Decoration/Bushes/BushLoadRight.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Decoration/Hedges/HedgeLoad.visible = false
	$Decoration/Hedges/HedgeLoad.process_mode = Node.PROCESS_MODE_DISABLED
