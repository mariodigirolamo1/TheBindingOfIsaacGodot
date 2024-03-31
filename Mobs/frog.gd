extends CharacterBody2D

const SPEED = 30

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerPosition = get_node("../../Player").position
	var moveVector = playerPosition - position
	
	var x = moveVector.x
	var y = moveVector.y
	
	var xDir = sign(x)
	var yDir = sign(y)
	
	velocity.x = xDir * SPEED
	velocity.y = yDir * SPEED
	
	move_and_slide()

func _on_bullet_detection_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("bullets"):
		queue_free()
	pass
