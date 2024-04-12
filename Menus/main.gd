extends Node2D

func _on_button_pressed():
	MapHandler.shuffle()
	get_tree().change_scene_to_file("res://Rooms/Intro/levels_container.tscn")
