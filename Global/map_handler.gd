extends Node

const mapRows = 5
const mapColumns = 5

var room4Frogs = preload("res://Rooms/4_frogs/room_4_frogs.tscn")
var room2Frogs = preload("res://Rooms/2_frogs/room_2_frogs.tscn")
var room1Cherry = preload("res://Rooms/1_cherry/room_1_cherry.tscn")

var RoomState = preload("res://Rooms/room_state.gd")

var rng = RandomNumberGenerator.new()

# x left to right
# y top to bottom

# this will not be used, just use dictionary
var map = [
	[-1,-1,-1,-1,-1],
	[-1,-1,1,-1,-1],
	[-1,1,1,1,-1],
	[-1,-1,1,-1,-1],
	[-1,-1,-1,-1,-1]
]

var subMap1 = [-1,-1,1,-1,-1]

var subMap2 = [1,1,1,-1,-1]

var subMap3 = [-1,-1,1,1,1]

var roomStates = {}
var currentRoomCoords = [2,1]

func _ready():
	shuffle()
	
func shuffle():
	map = [
		[-1,-1,-1,-1,-1],
		[-1,-1,1,-1,-1],
		[-1,1,1,1,-1],
		[-1,-1,1,-1,-1],
		[-1,-1,-1,-1,-1]
	]
	setRoomTemplate()
	generateRandomRooms()
	
func setRoomTemplate():
	currentRoomCoords = [2,2]
	# set map top
	var submap
	submap = getRandomSubmap()
	for i in mapColumns:
		if submap[i] != -1:
			map[0][i] = submap[i]
	# set map bottom
	submap = getRandomSubmap()
	for i in mapColumns:
		if submap[i] != -1:
			map[4][i] = submap[i]
	# set map right
	submap = getRandomSubmap()
	for i in mapRows:
		if submap[i] != -1:
			map[i][4] = submap[i]
	# set map left
	submap = getRandomSubmap()
	for i in mapRows:
		if submap[i] != -1:
			map[i][0] = submap[i]
			
func getRandomSubmap() -> Array:
	var submap
	match rng.randi_range(1,3):
			1: submap = subMap1
			2: submap = subMap2
			3: submap = subMap3
	return submap
			
func rotate90DegressRigth(map):
	var rotated = [[],[],[],[],[]]
	for i in mapRows:
		for j in mapColumns:
			rotated[i].append(1)
	
	for j in mapColumns:
		for i in range(mapRows - 1, 0, -1):
			rotated[j][mapRows - 1 - i] = map[i][j]
	
	return rotated
	
func buildFirstRoom():
	addRoomToTree(currentRoomCoords, "center")

func generateRandomRooms():
	for i in mapRows:
		for j in mapColumns:
			if map[i][j] == 1:
				var roomStateKey = str(i) + "," + str(j)
				var roomState = RoomState.new()
				roomState.init(rng.randi_range(1,3))
				roomStates[roomStateKey] = roomState

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
		#var candidateMapPos = map[candidateCoords[0]][candidateCoords[1]]
		#print("candidateMapPos: " + str(candidateMapPos))
		addRoomToTree(candidateCoords, side)
		

func addRoomToTree(coords, fromSide):
	var row = coords[0]
	var col = coords[1]
	var key = str(row) + "," + str(col)
	
	currentRoomCoords = coords
	
	var roomsGroup = get_tree().get_nodes_in_group("rooms")
	var roomNode = roomsGroup[0]
	for child in roomNode.get_children():
		child.queue_free()
		
	var room
	var roomState = roomStates.get(key)
	
	match roomState.roomType:
		1: room = room4Frogs.instantiate()
		2: room = room2Frogs.instantiate()
		3: room = room1Cherry.instantiate()
		
	room.init(roomState, fromSide)
	roomNode.add_child(room)

func subtract(a: Array, b: Array): 
	var result = []

	for i in a.size():
		result.append([0])
		result[i] = a[i] - b[i]
	return result
