extends Area2D

var open = false
var side

func _process(delta):
	if open:
		get_node("Sprite").modulate = Color(0,0,255,0.5)
	else:
		get_node("Sprite").modulate = Color(255,0,0,0.5)

func _on_body_entered(body):
	if open:
		if body.is_in_group("players"):
			MapHandler.changeRoom(side)
