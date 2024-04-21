extends Node2D

var Boss = preload("res://Mobs/Frog/Boss/frog_boss.tscn")
var boss
var state
var startPlayerPosition

func init(state, playerFromSide):
	self.state = state
	startPlayerPosition = playerFromSide

func _ready():
	PlayerStats.setPlayerPosition(
		get_node("Player"),
		startPlayerPosition
	)
	handleMobSpawn()
	MapHandler.setupDoors(get_node("Doors"))
	
func handleMobSpawn():
	#todo: uncomment to handle saved state
	#if state.monstersCount > 0:
	var bossPosition
	
	match startPlayerPosition:
		"left": bossPosition = Vector2(50,100)
		"right": bossPosition = Vector2(250,100)
		"up": bossPosition = Vector2(150,30)
		"down": bossPosition = Vector2(150,150)
		"center": bossPosition = Vector2(50,100)
		
	boss = Boss.instantiate()
	boss.position = bossPosition
	get_node("Mobs").add_child(boss)

func _process(delta):
	state.monstersCount = get_node("Mobs").get_child_count()
	
	if state.monstersCount == 0:
		for child in get_node("Doors").get_children():
			child.open = true
	
	var progressBar = get_node("ProgressBar")
	if boss != null && boss.life > 0:
		progressBar.value = boss.life
	else:
		if progressBar != null:
			progressBar.queue_free()
