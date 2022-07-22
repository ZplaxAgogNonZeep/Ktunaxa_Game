extends Node2D

var letter = preload("res://WordSystem/Letter.tscn")

func _ready():
	generateWord("17>24>21")

func generateWord(wordCode : String):
	# Starts the word generation process, takes a string of numbers that will make
	# up the word to be generated then creates Sprite nodes in the form of the word
	var posn = Vector2(0,0)
	
	var letterList : Array = wordCode.split(">")
	
	for i in range(letterList.size()):
		var newLetter = letter.instance()
		newLetter.texture = getLetter(letterList[i])
		posn.x = posn.x + 48
		newLetter.position = Vector2(posn.x, posn.y)
		$WordManager.add_child(newLetter)
	
	posn.x += 48
	
	
	$WordManager.position = $Position2D.position
	$Position2D.position = posn
	
	$WordManager.global_position.x = $Position2D.global_position.x - $WordManager.global_position.x
	print($WordManager.global_position)


func getLetter(index : String):
	if int(index) > 0:
		return load("res://Assets/Letters/" + index + ".png")
	else:
		return null
