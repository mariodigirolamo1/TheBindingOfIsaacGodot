extends Area2D

var speed = 100.0
var direction = "unknown"

var speedX = [speed]
var speedY = [0]

var x = 0
var middlePoint = 40
var exponent = 2

var thresholdY = 8
var startY

func _ready():
	get_node("Shadow").position.y -= thresholdY - 6
	
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
	print(self.monitorable)
	match direction:
		"left":
			position.x += -1 * speed * delta
		"right":
			position.x += 1 * speedX[0] * delta
			position.y += 1 * speedY[0] * delta
			get_node("Shadow").position.y -= 1 * speedY[0] * delta
			
			updateSpeed(speedY,1,10,3,15,false)
			if abs(startY - position.y) > thresholdY:
				get_node("Sprite2D").modulate = Color(255,0,0,1)
				get_node("CollisionShape2D").disabled = true
			else:
				get_node("Sprite2D").modulate = Color(255,255,255,1)
				get_node("CollisionShape2D").disabled = false
		"up":
			position.y += -1 * speed * delta
		"down":
			position.y += 1 * speed * delta

func updateSpeed(speed, baseSpeedMulti, yOffset, exp, minSpeed, log):
	if log:
		print(speed)
	
	if x == 0:
		startY = position.y
		get_node("Shadow").visible = true
		
	if x <= middlePoint*2:
		var powerValue = pow(x - middlePoint,exp) + yOffset
		var normalizedValue = powerValue/pow(middlePoint,exp)
		var candidateSpeed = self.speed * baseSpeedMulti * normalizedValue
		if candidateSpeed >= 0:
			speed[0] = max(candidateSpeed, minSpeed)
		else:
			speed[0] = min(candidateSpeed, -1 * minSpeed)
		x += 1

	if x > middlePoint*2:
		self.queue_free()
