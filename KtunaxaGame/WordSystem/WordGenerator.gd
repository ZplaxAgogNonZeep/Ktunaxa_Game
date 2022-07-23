extends Node2D

# Creates a Ktuxana word by creating a series of sprites containing the letters

var letter = preload("res://WordSystem/Letter.tscn")

export var spacing := 30

func _ready():
	generateWord("17>0>24>21")

func generateWord(wordCode : String):
	# Starts the word generation process, takes a string of numbers that will make
	# up the word to be generated then creates Sprite nodes in the form of the word
	
	# Removes anything in the WordManager
	for i in range($WordManager.get_child_count()):
		$WordManager.get_child(i).queue_free()
	
	$WordManager.position = $AbsolutePosition.position
	var posn = Vector2(0,0)
	
	# Adds Letters and increases the posn
	var letterList : Array = wordCode.split(">")
	
	for i in range(letterList.size()):
		var newLetter = letter.instance()
		newLetter.texture = getLetter(letterList[i])
		posn.x = posn.x + spacing
		newLetter.global_position = Vector2(posn.x, posn.y)
		$WordManager.add_child(newLetter)
	
	posn.x += spacing
	
	# Makes the word centered onto the Absolute Position node
	$WordManager.position = Vector2(
		$AbsolutePosition.position.x - ((((posn.x + $WordManager.position.x) + $WordManager.global_position.x) / 2) - $WordManager.global_position.x), 
		$WordManager.position.y)



func getLetter(index : String):
	# takes a number in a string and returns the corrosponding file. if given 0, will return a null
	# to create a space
	if int(index) > 0:
		return load("res://Assets/Letters/" + index + ".png")
	else:
		return null
