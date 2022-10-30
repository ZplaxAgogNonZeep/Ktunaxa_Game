extends Node2D

# Rules:
# Each Round, a new animal will be chosen and a random selection of letters will be generated that contain 
# the the neccesary characters. The player must then type out the word using the on-screen keyboard

onready var game = get_tree().root.get_node("Game")

var answerCode : String
var answerArray : Array

var currentGuess : Array = []

func loadGame():
	# Inherit. Loads game in for the first time. Sets up variables.
	print(game)
	var newWordList = game.wordList.duplicate()
	randomize()
	newWordList.shuffle()
	answerCode = newWordList[0].split("|")[2]
	answerArray = answerCode.split(">")
	$Image.texture = game.getAssetByName(newWordList[0].split("|")[1])
	
	print(answerCode)
	$AnswerGenerator.drawEmpty(answerCode)
	
#	var count = 1
	
	SetKeyboard()
#	while (count <= $LetterManager.get_child_count()):
#		$LetterManager.get_node(str(count)).texture = getLetter(str(count))
#		count += 1

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			for i in $LetterManager.get_child_count():
				if ($LetterManager.get_child(i).isMouse):
					$AnswerGenerator.typeLetter($LetterManager.get_child(i).letterCode)
					currentGuess.append($LetterManager.get_child(i).letterCode)
					checkForWin()
					break

func _on_Button_pressed():
	$AnswerGenerator.deleteLetter()
	currentGuess.remove(currentGuess.size() - 1)

# Helper Functions =================================================================================
func getLetter(index : String):
	# takes a number in a string and returns the corrosponding file. if given 0, will return null
	# to create a space
	if int(index) > 0:
		return load("res://Assets/Letters/" + index + ".png")
	else:
		return null

func checkForWin():
	if (currentGuess == answerArray):
		print("Game Over")

func SetKeyboard():
	# sets the keyboard to a set of random letters
	var keyboardlist : Array = [] # list of letterCodes to be assigned
	
	for i in range(answerArray.size()):
		keyboardlist.append(int(answerArray[i]))
	
	while keyboardlist.size() < 15:
		var randomLetter = rand_range(0, 29)
		while keyboardlist.bsearch(randomLetter):
			randomLetter = rand_range(0, 29)
		
		keyboardlist.append(randomLetter)
	
	randomize()
	keyboardlist.shuffle()
	
	
