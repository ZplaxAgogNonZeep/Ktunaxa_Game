extends Node2D

var mainMenu := preload("res://MainMenu/MainMenu.tscn")
var pictureGame := preload("res://PictureGame/PictureGame.tscn")

# Options Variables
var voiceVolume := 0.0
var musicVolume := 0.0
var effectVolume := 0.0

func _ready():
	$GameManager.add_child(mainMenu.instance())
	$AudioManager.startTrack(2, 0, true)
	$TestTimer.start(3)
	

func changeGame(game : int):
	# Changes the node in the GameManager using a given int as reference
	# 0 = Main Menu
	# 1 = Picture Game
	# 2 = Spelling Game
	if $GameManager.get_children() != []:
		while $GameManager.get_child_count() != 0:
			$GameManager.get_child(0).queue_free()
	yield(get_tree(), "idle_frame")
	
	match game:
		0:
			$GameManager.add_child(mainMenu.instance())
		1:
			$GameManager.add_child(pictureGame.instance())
		_:
			print("changeGame() Could not find appropriate scene with given input of " + str(game))
	
	

# DEBUG STUFF ==============================================

func _on_TestTimer_timeout():
	$AudioManager.startTrack(1, 0, false, 2)
