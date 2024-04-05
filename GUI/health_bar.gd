extends Panel

func _ready():
	modulate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate()
		
func modulate():
	var container = get_node("HBoxContainer")

	var i = 0

	while i < PlayerStats.playerHP:
		container.get_child(i).modulate = Color(1,1,1)
		i += 1
	
	while i < PlayerStats.maxPlayerHP:
		container.get_child(i).modulate = Color(0,0,0)
		i += 1
