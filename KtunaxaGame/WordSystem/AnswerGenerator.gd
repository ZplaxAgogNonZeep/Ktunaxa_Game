extends Node2D

var answer : Array
const SPACING = 30

func drawEmpty(wordCode : String):
	# Starts the Genertion Process. takes a word code and draws out a fill in the blank answer
	answer = wordCode.split(">")
	var answerSize = answer.size()
	
	var posn = $StartPosn.position.x 
	var count = 0
	
	# TODO:
	# Need to make sure that words don't get cutoff :((((((((((
	while (count < ($EndPosn.position.x - $StartPosn.position.x) / SPACING):
		pass
