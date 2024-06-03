extends GridContainer

var MapCell = preload("res://GUI/map_cell.tscn")

func _ready():
	var matrix = get_node(".")
	for row in MapHandler.mapRows:
		var rowContainer = VBoxContainer.new()
		rowContainer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		rowContainer.size_flags_vertical = Control.SIZE_EXPAND_FILL
		matrix.add_child(rowContainer)
		var columnsContainer = HBoxContainer.new()
		columnsContainer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		columnsContainer.size_flags_vertical = Control.SIZE_EXPAND_FILL
		rowContainer.add_child(columnsContainer)
		for col in MapHandler.mapColumns:
			columnsContainer.add_child(MapCell.instantiate())
			
func _process(delta):
	var matrix = get_node(".")
	
	basicPaint(matrix)
	playerPaint(matrix)

func basicPaint(matrix):
	for curRow in MapHandler.mapRows:
		for curCol in MapHandler.mapColumns:
			var guiCell = matrix.get_child(curRow).get_child(0).get_child(curCol)
			var mapCell = MapHandler.map[curRow][curCol]
			if(mapCell == 4):
				guiCell.modulate = Color(0,0,255,1)
			elif(mapCell != -1):
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
