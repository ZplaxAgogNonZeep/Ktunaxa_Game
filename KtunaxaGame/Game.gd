extends Node2D

var mainMenu := preload("res://MainMenu/MainMenu.tscn")
var pictureGame := preload("res://PictureGame/PictureGame.tscn")
onready var AudioManager = get_node("AudioManager")

# Options Variables
var voiceVolume := 0.0
var musicVolume := 0.0
var effectVolume := 0.0

var wordList := ["0|Yellow|0", "1|Red|0", "2|Blue|0", "3|Green|0", "4|Purple|0", "5|Orange|0", "6|Pink|0", "7|Brown|0", "8|Black|0", "9|White|0"]
var translationList := []

func _ready():
	$GameManager.add_child(mainMenu.instance())


func changeGame(game : int):
	# Changes the node in the GameManager using a given int as reference
	# 0 = Main Menu
	# 1 = Picture Game
	# 2 = Spelling Game
	if $GameManager.get_children() != []:
		while $GameManager.get_child_count() != 0:
			$GameManager.get_child(0).queue_free()
			yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	match game:
		0:
			$GameManager.add_child(mainMenu.instance())
		1:
			$GameManager.add_child(pictureGame.instance())
		_:
			print("changeGame() Could not find appropriate scene with given input of " + str(game))
	
	$GameManager.get_child(0).loadGame()

# Asset Searching ===============================================================

func getAssetByIndex(index : int):
	# Gets specifically portraits by taking a given int and returning that filepath
	return load("res://Assets/Portraits/" + str(index) + ".png")


# DEBUG STUFF ==============================================

func _on_TestTimer_timeout():
	$AudioManager.startTrack(1, 0, false, 2)
