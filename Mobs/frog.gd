extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_bullet_detection_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("bullets"):
		queue_free()
