extends Node

class_name RoomState

var monstersCount = -1
var items = []
var roomType = 1
var initialized = false

func init(roomType):
	if !initialized:
		initialized = true
		self.roomType = roomType
		match roomType:
			1: 
				monstersCount = 4
			2:
				monstersCount = 2
			3: 
				monstersCount = 0
				items.append("middleCherry")
			4:
				monstersCount = 1
