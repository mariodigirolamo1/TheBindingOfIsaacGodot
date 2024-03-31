extends Node

var maxPlayerHP = 3
var playerHP = 3

var damageDelta = 1

func _process(delta):
	if damageDelta < 1:
		damageDelta += delta

func updatePlayerHP():
	if damageDelta >= 1:
		damageDelta = 0
		playerHP -= 1
