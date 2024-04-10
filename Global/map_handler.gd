extends Node

const mapRows = 3
const mapColumns = 5

var room4Frogs = preload("res://Rooms/4_frogs/room_4_frogs.tscn")
var room2Frogs = preload("res://Rooms/2_frogs/room_2_frogs.tscn")
var room1Cherry = preload("res://Rooms/1_cherry/room_1_cherry.tscn")

# x left to right
# y top to bottom

var map = [
	[-1,3,-1,-1,-1],
	[-1,1,2,-1,-1],
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
		
		# this scales very poorly
		
		if candidateMapPos == 1:
			currentRoomCoords = candidateCoords
			var room = room4Frogs.instantiate()
			var roomNode = get_tree().get_nodes_in_group("rooms")[0]
			for child in roomNode.get_children():
				child.queue_free()
			roomNode.add_child(room)
		elif candidateMapPos == 2:
			currentRoomCoords = candidateCoords
			var room = room2Frogs.instantiate()
			var roomNode = get_tree().get_nodes_in_group("rooms")[0]
			for child in roomNode.get_children():
				child.queue_free()
			roomNode.add_child(room)
		elif candidateMapPos == 3:
			currentRoomCoords = candidateCoords
			var room = room1Cherry.instantiate()
			var roomNode = get_tree().get_nodes_in_group("rooms")[0]
			for child in roomNode.get_children():
				child.queue_free()
			roomNode.add_child(room)
		else:
			print("Can't change room")

func subtract(a: Array, b: Array): 
	var result = []

	for i in a.size():
		result.append([0])
		result[i] = a[i] - b[i]
	return result
