extends CharacterBody2D

const SPEED = 30

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handleChase()
	move_and_slide()

func handleChase():
	var playerPosition = get_node("../../Player").position
	var moveVector = playerPosition - position
	
	var x = moveVector.x
	var y = moveVector.y
	
	var xDir = sign(x)
	var yDir = sign(y)
	
	velocity.x = xDir * SPEED
	velocity.y = yDir * SPEED
	
	playJump(xDir == 1)
	
func playJump(flipped):
	var spriteNode = get_node("AnimatedSprite2D")
	
	spriteNode.flip_h = flipped 
	spriteNode.play("Jump")

func _on_bullet_detection_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("bullets"):
		queue_free()
	pass
