extends Node

var roomsArray = [0,1,1,0,0]
var currentRoomIndex = 2

func changeRoom():
	# only goes left for now
	if currentRoomIndex > 0:
		currentRoomIndex -= 1
		# go to new room, no previous scene saved
		# we should just save the state for each scene
		# and recreate the scene from there
		# don't store scene forever in an array
		
		# for now, navigate to same intro_room
		# this will change to a different room based on type
		print("new room index " + str(currentRoomIndex))
		get_tree().change_scene_to_file("res://Rooms/Intro/intro_room.tscn")
	else:
		print("Can't change room")
