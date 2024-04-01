extends Node

var maxPlayerHP = 3
var playerHP = 3

var damageDelta = 1

func _process(delta):
	updateDamageDelta(delta)
	
	if playerHP == 0:
		get_tree().change_scene_to_file("res://Menus/main.tscn")
		resetPlayerStats()
	
func updateDamageDelta(delta):
	if damageDelta < 1:
		damageDelta += delta

func resetPlayerStats():
	playerHP = 3
	maxPlayerHP = 3
	damageDelta = 1

func updatePlayerHP():
	if damageDelta >= 1:
		damageDelta = 0
		playerHP -= 1
