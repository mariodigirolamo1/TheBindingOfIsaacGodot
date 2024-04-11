extends Node2D

var doorClass = preload("res://Doors/basic_door.tscn")
var Frog = preload("res://Mobs/frog.tscn")
var state

func init(state):
	self.state = state

func _ready():
	handleMobSpawn()
	
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

func handleMobSpawn():
	if state.monstersCount > 0:
		var frog1 = Frog.instantiate()
		var frog2 = Frog.instantiate()
		var frog3 = Frog.instantiate()
		var frog4 = Frog.instantiate()
		
		frog1.position = Vector2(50,75)
		frog2.position = Vector2(50,125)
		frog3.position = Vector2(200,75)
		frog4.position = Vector2(200,125)
		
		get_node("Mobs").add_child(frog1)
		get_node("Mobs").add_child(frog2)
		get_node("Mobs").add_child(frog3)
		get_node("Mobs").add_child(frog4)

func _process(delta):
	state.monstersCount = get_node("Mobs").get_child_count()
	
	if state.monstersCount == 0:
		for child in get_node("Doors").get_children():
			child.open = true
