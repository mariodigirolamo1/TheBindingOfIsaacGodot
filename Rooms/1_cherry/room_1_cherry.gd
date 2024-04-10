extends Node2D

var doorClass = preload("res://Doors/basic_door.tscn")

func _ready():
	var upDoor = doorClass.instantiate()
	var downDoor = doorClass.instantiate()
	var leftDoor = doorClass.instantiate()
	var righDoor = doorClass.instantiate()
	
	upDoor.side = "up"
	downDoor.side = "down"
	leftDoor.side = "left"
	righDoor.side = "right"
	
	var upCellType = MapHandler.getCellValue(-1,0)
	var downCellType = MapHandler.getCellValue(1,0)
	var leftCellType = MapHandler.getCellValue(0,-1)
	var rightCellType = MapHandler.getCellValue(0,1)
	
	if upCellType != -1:
		get_node("Doors").add_child(upDoor)
	if downCellType != -1:
		get_node("Doors").add_child(downDoor)
	if leftCellType != -1:
		get_node("Doors").add_child(leftDoor)
	if rightCellType != -1:
		get_node("Doors").add_child(righDoor)
	
	for child in get_node("Doors").get_children():
		match child.side:
			"up":
				child.position = Vector2(144,10)
			"down":
				child.position = Vector2(144,182)
			"left":
				child.position = Vector2(9,96)
				child.rotation = deg_to_rad(90)
			"right":
				child.position = Vector2(278,96)
				child.rotation = deg_to_rad(90)

func _process(delta):
	for child in get_node("Doors").get_children():
		child.open = true
