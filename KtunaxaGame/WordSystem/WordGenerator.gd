extends Node2D

var letter = preload("res://WordSystem/Letter.tscn")

func generateWord(wordCode : String):
	# Starts the word generation process, takes a string of numbers that will make
	# up the word to be generated then creates Sprite nodes in the form of the word
	var posn = $Position2D.position
	
	var letterList : Array = wordCode.split(">")
	
	for i in range(letterList.size()):
		var newLetter = letter.instance()
		newLetter.texture = getLetter(letterList[i])
		posn.x = posn.x + 48
		newLetter.position.x = posn.x
		$WordManager.add_child(newLetter)


func getLetter(index : String):
	return load("res://Assets/Letters/" + index)
