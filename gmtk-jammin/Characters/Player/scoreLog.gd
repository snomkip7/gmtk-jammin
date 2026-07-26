extends Label

var lineList: Array[String] = []
var timeList: Array[float] = []

func addLine(line: String):
	lineList.append(line)
	timeList.append(6.5)

func _physics_process(delta: float) -> void:
	text = ""
	
	var removeList: Array[int] = []
	
	for i in range(0, lineList.size()):
		text += "\n"+lineList[i]
		timeList[i] -= delta
		if timeList[i] <= 0:
			removeList.append(i)
			
	removeList.reverse() # so it is descending
	
	for i in removeList:
		print("removing ", lineList[i], " ", timeList[i])
		timeList.remove_at(i)
		lineList.remove_at(i)
		
