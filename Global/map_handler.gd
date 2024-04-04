extends Node

const mapRows = 3
const mapColumns = 5

# x left to right
# y top to bottom

var map = [
	[-1,1,-1,-1,-1],
	[-1,1,1,-1,-1],
	[-1,1,-1,-1,-1]
]

var currentRoomCoords = [2,1]

func getCellValue(dx,dy):
	var x = currentRoomCoords[0]+dx
	var y = currentRoomCoords[1]+dy
	
	var validX = x >= 0 && x < mapRows
	var validY = y >= 0 && y < mapColumns
	
	if validX && validY:
		return map[x][y]
	else:
		return -1

func changeRoom(side):
	
	var candidateCoords
	
	if side == "left":
		candidateCoords = subtract(currentRoomCoords,[0,1])
	if side == "right":
		candidateCoords = subtract(currentRoomCoords,[0,-1])
	if side == "up":
		candidateCoords = subtract(currentRoomCoords,[1,0])
	if side == "down":
		candidateCoords = subtract(currentRoomCoords,[-1,0])
	
	print("candidate coords: " + str(candidateCoords))
	
	var isXInRange = candidateCoords[0] < mapRows && candidateCoords[0] >= 0
	var isYInRange = candidateCoords[1] < mapColumns && candidateCoords[1] >= 0
	
	if isYInRange && isXInRange :
		var candidateMapPos = map[candidateCoords[0]][candidateCoords[1]]
		print("candidateMapPos: " + str(candidateMapPos))
		
		if candidateMapPos != -1:
			currentRoomCoords = candidateCoords
			get_tree().change_scene_to_file("res://Rooms/Intro/intro_room.tscn")
		else:
			print("Can't change room")

func subtract(a: Array, b: Array): 
	var result = []

	for i in a.size():
		result.append([0])
		result[i] = a[i] - b[i]
	return result
