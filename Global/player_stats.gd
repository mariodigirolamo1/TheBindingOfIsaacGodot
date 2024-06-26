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

func updatePlayerHP(valueToAdd):
	if damageDelta >= 1:
		if valueToAdd > 0 && playerHP == 3:
			pass
		else:
			damageDelta = 0
			playerHP += valueToAdd

func setPlayerPosition(playerNode, playerFromSide):
	match playerFromSide:
		"up":
			playerNode.position = Vector2(130,140)
		"down":
			playerNode.position = Vector2(130,35)
		"left":
			playerNode.position = Vector2(240,100)
		"right":
			playerNode.position = Vector2(35,100)
		"center":
			playerNode.position = Vector2(130,110)
