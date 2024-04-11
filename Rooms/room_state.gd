extends Node

var monstersCount = -1
var roomType = 1

func init(roomType):
	self.roomType = roomType
	match roomType:
		1: monstersCount = 4
		2: monstersCount = 2
		3: monstersCount = 0
