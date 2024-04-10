extends GridContainer

func _process(delta):
	var matrix = get_node(".")
	
	basicPaint(matrix)
	playerPaint(matrix)

func basicPaint(matrix):
	for curRow in MapHandler.mapRows:
		for curCol in MapHandler.mapColumns:
			var guiCell = matrix.get_child(curRow).get_child(0).get_child(curCol)
			if(MapHandler.map[curRow][curCol] != -1):
				guiCell.modulate = Color(255,255,255,1)
			else:
				guiCell.modulate = Color(105,105,105,0.25)

func playerPaint(matrix):
	var row = MapHandler.currentRoomCoords[0]
	var col = MapHandler.currentRoomCoords[1]
	
	var rown = matrix.get_child(row)
	var coln = rown.get_child(0)
	var rectn = coln.get_child(col)
	rectn.modulate = Color(255,0,0,1)
