extends Node2D

onready var game = get_tree().root.get_node("Game")

var answerCode : String



func loadGame():
	# Inherit. Loads game in for the first time. Sets up variables.
	print(game)
	var newWordList = game.wordList.duplicate()
	newWordList.shuffle()
	answerCode = newWordList[0].split("|")[2]
	
	print(answerCode)
	$AnswerGenerator.drawEmpty(answerCode)
	
	var count = 1
	
	while (count <= $LetterManager.get_child_count()):
		$LetterManager.get_node(str(count)).texture = getLetter(str(count))
		count += 1


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			for i in $LetterManager.get_child_count():
				if ($LetterManager.get_child(i).isMouse):
					$AnswerGenerator.typeLetter($LetterManager.get_child(i).letterCode)
					break

# Helper Functions
func getLetter(index : String):
	# takes a number in a string and returns the corrosponding file. if given 0, will return a null
	# to create a space
	if int(index) > 0:
		return load("res://Assets/Letters/" + index + ".png")
	else:
		return null
