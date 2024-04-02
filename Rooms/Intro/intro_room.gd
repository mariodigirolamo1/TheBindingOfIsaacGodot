extends Node2D

var mobsNumber = 4

func _ready():
	get_node("Doors/UpDoor").side = "up"
	get_node("Doors/DownDoor").side = "down"
	get_node("Doors/LeftDoor").side = "left"
	get_node("Doors/RightDoor").side = "right"

func _process(delta):
	mobsNumber = get_node("Mobs").get_child_count()
	
	if mobsNumber == 0:
		for child in get_node("Doors").get_children():
			child.open = true
