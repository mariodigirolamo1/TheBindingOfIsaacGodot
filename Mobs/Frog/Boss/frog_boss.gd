extends CharacterBody2D

var life = 10

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullets"):
		if life == 1:
			self.queue_free()
		else:
			life -= 1
			area.queue_free()
