extends Node2D

var mainMenu := preload("res://MainMenu/MainMenu.tscn")
var pictureGame := preload("res://PictureGame/PictureGame.tscn")
var spellingGame := preload("res://SpellingGame/SpellingGame.tscn")
onready var AudioManager = get_node("AudioManager")

# Options Variables
var voiceVolume := 0
var musicVolume := 0
var effectVolume := 0

# Word Variables
var wordList := []

func _ready():
	loadWordList()
	loadOptions()
	changeGame(0)
#	$GameManager.add_child(mainMenu.instance())


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
		2:
			$GameManager.add_child(spellingGame.instance())
		_:
			print("changeGame() Could not find appropriate scene with given input of " + str(game))
	
	$GameManager.get_child(0).loadGame()

# Saving and Loading ===============================================================================

func saveOptions():
	# Writes the variables for the options menu in a text file for loading later
	var file = File.new()
	
	if file.file_exists("res://Data/Options.txt"):
		file.open("res://Data/Options.txt", File.WRITE)
		var fileContent = ""
		
		# 0
		fileContent += "Voice Volume=" + str(voiceVolume) + "\n"
		# 1
		fileContent += "Music Volume=" + str(musicVolume) + "\n"
		# 2
		fileContent += "Sound Effect Volume=" + str(effectVolume) + "\n"
		
		file.store_string(fileContent)
		file.close()
	else:
		pass

func loadOptions():
	# Loads all the options menu reated information from a text file and updates all the variables
	var file = File.new()
	
	if file.file_exists("res://Data/Options.txt"):
		file.open("res://Data/Options.txt", File.READ)
		if file.get_as_text() != "":
			var splitList = file.get_as_text().split("\n")
			
			voiceVolume = int(splitList[0].split("=")[1])
			musicVolume = int(splitList[1].split("=")[1])
			effectVolume = int(splitList[2].split("=")[1])
		else:
			saveOptions()
		
		file.close()
	else:
		pass

func loadWordList():
	# Loads a list of all translatable words from a text file
	var file = File.new()
	if file.file_exists("res://Data/WordList.txt"):
		file.open("res://Data/WordList.txt", File.READ)
		
		wordList = file.get_as_text().split("\n")
		
		file.close()
	else:
		print("FILE DOES NOT EXIST")

# Asset Searching ==================================================================================

func getAssetByName(name : String):
	# Gets specifically portraits by it's name
	return load("res://Assets/Portraits/" + name + ".png")


# Signals ==========================================================================================
func _on_Options_pressed():
	var menu = load("res://OptionsMenu.tscn").instance()
	$UIManager.add_child(menu)


# DEBUG STUFF ======================================================================================

func _on_TestTimer_timeout():
	$AudioManager.startTrack(1, 0, false, 2)



