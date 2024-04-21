extends CharacterBody2D

const SPEED = 100

const STATE_IDLE = 0
const STATE_JUMP = 1
const STATE_FALL = 2

var life = 10
var playerChaseArray

var state = STATE_IDLE
var stateChangeDelays = [1.2, 0.4, 0.4]
var stateChangeDelta = 0

func _process(delta):
	handleStateUpdate(delta)
	handleJump(delta)

func handleStateUpdate(delta):
	var player = get_tree().get_first_node_in_group("players")
	var animationPlayer = get_node("AnimationPlayer")
	var idleSprite = get_node("IdleSprite")
	var jumpSprite = get_node("JumpSprite")
	
	stateChangeDelta += delta
	if stateChangeDelta >= stateChangeDelays[state]:
		stateChangeDelta = 0
		
		if state == STATE_IDLE:
			state = STATE_JUMP
			idleSprite.visible = false
			jumpSprite.visible = true
			playerChaseArray = self.position.direction_to(player.position)
			animationPlayer.play("Jump")
		elif state == STATE_JUMP:
			state = STATE_FALL
			animationPlayer.play("Fall")
		else:
			state = STATE_IDLE
			animationPlayer.play("Idle")
			idleSprite.visible = true
			jumpSprite.visible = false

func handleJump(delta):
	if state == STATE_JUMP || state == STATE_FALL:
		self.position += playerChaseArray * delta * SPEED
		print(self.position.x)

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullets"):
		if life == 1:
			self.queue_free()
		else:
			life -= 1
			area.queue_free()
