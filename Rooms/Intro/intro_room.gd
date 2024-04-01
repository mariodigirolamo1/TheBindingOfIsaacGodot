extends Node2D

var mobsNumber = 4

func _process(delta):
	mobsNumber = get_node("Mobs").get_child_count()
	
	if mobsNumber == 0:
		for child in get_node("Doors").get_children():
			child.open = true
