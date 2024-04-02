extends GridContainer

func _process(delta):
	var row = MapHandler.currentRoomCoords[0]
	var col = MapHandler.currentRoomCoords[1]
	
	var matrix =  get_node(".")
	var rown = matrix.get_child(row)
	var coln = rown.get_child(0)
	var rectn = coln.get_child(col)
	rectn.modulate = Color(255,0,0,1)
