extends CharacterBody2D

var bulletScene = preload("res://Bullets/bullet.tscn")

const SPEED = 100.0
const SHOT_MILLIS_THRESHOLD = 0.5

var shotElapsedMillis = 100.0

func _physics_process(delta):
	updateXVelocity()
	updateYVelocity()
	handleIdle()
	handleShooting(delta)
	move_and_slide()
	
func updateXVelocity():
	if Input.is_action_pressed("Left"):
		velocity.x = -1 * SPEED
		get_node("AnimatedSprite2D").flip_h = true
		playRun()
	elif Input.is_action_pressed("Right"):
		velocity.x = 1 * SPEED
		get_node("AnimatedSprite2D").flip_h = false
		playRun()
	else:
		velocity.x = 0

func updateYVelocity():
	if Input.is_action_pressed("Up"):
		velocity.y = -1 * SPEED
		playRun()
	elif Input.is_action_pressed("Down"):
		velocity.y = 1 * SPEED
		playRun()
	else:
		velocity.y = 0
		
func handleShooting(delta):
	shotElapsedMillis += delta
	
	if shotElapsedMillis >= SHOT_MILLIS_THRESHOLD:
		if Input.is_action_pressed("ShootRight"):
			shoot("right")
		elif Input.is_action_pressed("ShootLeft"):
			shoot("left")
		elif Input.is_action_pressed("ShootUp"):
			shoot("up")
		elif Input.is_action_pressed("ShootDown"):
			shoot("down")

func handleIdle():
	if velocity.x == 0 && velocity.y == 0:
		get_node("AnimatedSprite2D").play("Idle")

func playRun():
	get_node("AnimatedSprite2D").play("Run")
	
func playIdle():
	get_node("AnimatedSprite2D").play("Idle")

func shoot(direction):
	var bullet = bulletScene.instantiate()
	
	shotElapsedMillis = 0.0
	
	bullet.position = position
	bullet.direction = direction
	
	get_node("../Bullets").add_child(bullet)
