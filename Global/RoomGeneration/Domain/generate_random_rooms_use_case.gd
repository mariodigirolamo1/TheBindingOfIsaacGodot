var RoomState = preload("res://Rooms/room_state.gd")
var rng = RandomNumberGenerator.new()

const BOSS_ROOM_ID = 4

var hasBossRoomSpawned = false

func invoke(map: Array) -> Dictionary :
	var roomStates = {}
	
	var mapRows = map.size()
	var mapColumns = map[0].size()
	
	for i in mapRows:
		for j in mapColumns:
			if map[i][j] == 1:
				if(isBossRoomCandidate(map,mapRows,mapColumns,i,j)):
					if(!hasBossRoomSpawned):
						hasBossRoomSpawned = true
						var roomStateKey = str(i) + "," + str(j)
						var roomState = RoomState.new()
						roomState.init(4)
						roomStates[roomStateKey] = roomState
					else:
						var roomStateKey = str(i) + "," + str(j)
						var roomState = RoomState.new()
						roomState.init(rng.randi_range(1,4))
						roomStates[roomStateKey] = roomState
				else:
					var roomStateKey = str(i) + "," + str(j)
					var roomState = RoomState.new()
					roomState.init(rng.randi_range(1,4))
					roomStates[roomStateKey] = roomState
				
	return roomStates

func isBossRoomCandidate(
	map: Array,
	mapRows: int,
	mapCols: int,
	rowIndex: int,
	colIndex: int
) -> bool :
	var adjacentRoomsCount = 0
	if(rowIndex+1 < mapRows):
		if(map[rowIndex+1][colIndex] == 1):
			adjacentRoomsCount += 1
	if(rowIndex-1 >= 0):
		if(map[rowIndex-1][colIndex] == 1):
			adjacentRoomsCount += 1
	if(colIndex+1 < mapCols):
		if(map[rowIndex][colIndex+1] == 1):
			adjacentRoomsCount += 1
	if(colIndex-1 >= 0):
		if(map[rowIndex][colIndex-1] == 1):
			adjacentRoomsCount += 1
	return adjacentRoomsCount < 2
