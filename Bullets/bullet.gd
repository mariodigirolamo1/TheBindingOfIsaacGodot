extends Area2D

var speed = 400.0
var direction = "unknown"

func _ready():
	if(direction == "up" || direction == "down"):
		rotation = deg_to_rad(90)

func _process(delta):
	handleEdges()
	updateBulletPosition(delta)

func handleEdges():
	var invalidX = position.x < 0 || position.x > 300
	var invalidY = position.y < 0 || position.y > 250
	
	if invalidX || invalidY:
		queue_free()

func updateBulletPosition(delta):
	match direction:
		"left":
			position.x += -1 * speed * delta
		"right":
			position.x += 1 * speed * delta
		"up":
			position.y += -1 * speed * delta
		"down":
			position.y += 1 * speed * delta

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
