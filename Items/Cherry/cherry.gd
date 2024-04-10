extends CharacterBody2D

func _on_detection_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("players"):
		PlayerStats.updatePlayerHP(1)
		self.queue_free()
