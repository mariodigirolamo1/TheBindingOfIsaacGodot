var RoomState = preload("res://Rooms/room_state.gd")
var rng = RandomNumberGenerator.new()

func invoke(map: Array) -> Dictionary :
	var roomStates = {}
	
	var mapRows = map.size()
	var mapColumns = map[0].size()
	
	for i in mapRows:
		for j in mapColumns:
			if map[i][j] == 1:
				var roomStateKey = str(i) + "," + str(j)
				var roomState = RoomState.new()
				roomState.init(rng.randi_range(1,4))
				roomStates[roomStateKey] = roomState
				
	return roomStates
