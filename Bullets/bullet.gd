extends Area2D

var speed = 400.0
var direction = "unknown"

func _ready():
	if(direction == "up" || direction == "down"):
		rotation = deg_to_rad(90)

# Called when the node enters the scene tree for the first time.
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

func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
