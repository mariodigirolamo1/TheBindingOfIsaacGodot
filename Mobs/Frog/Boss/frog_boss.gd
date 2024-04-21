extends CharacterBody2D

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullets"):
		self.queue_free()
