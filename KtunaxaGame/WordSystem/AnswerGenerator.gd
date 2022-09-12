extends Node2D

var answer : Array
const SPACING = 50.0
const HEIGHT = 80.0

onready var linePath = preload("res://WordSystem/Line.tscn")

func _ready():
	drawEmpty("1>2>3>4>6>7>8")

func drawEmpty(wordCode : String):
	# Starts the Genertion Process. takes a word code and draws out a fill in the blank answer
	answer = wordCode.split(">")
	var answerSize = answer.size()
	
	var posn = Vector2(0,0)
	var count = 0
	$Line0.position = $StartPosn.position
	
	# TODO:
	# Eventually you should get rid of this first conditional
	while (count < floor(($EndPosn.position.x - $StartPosn.position.x) / SPACING)) and (count < answer.size()):
		posn.x += SPACING
		
		if not (int(answer[count]) == 0):
			
			var blankInstance = load("res://WordSystem/BlankLetter.tscn").instance()
			var answerLetterInstance = load("res://WordSystem/AnswerLetter.tscn").instance()
			
			blankInstance.position = posn
			answerLetterInstance.position = posn
			answerLetterInstance.texture = getLetter(answer[count])
			answerLetterInstance.visible = false
			
			$Line0.add_child(blankInstance)
			$Line0.add_child(answerLetterInstance)
			
		count += 1
	# Loop finished, checking if there is more character left
	var lineCount = 0
	
	
	while (count < answer.size()):
		posn = Vector2(0,0)
		print("Line" + str(lineCount))
		
		for x in lineCount + 1:
			get_node("Line" + str(x)).position.y -= HEIGHT
		
		# This is Janky but it should work
		lineCount += 1
		
		var lineInstance = linePath.instance()
		lineInstance.name = "Line" + str(lineCount)
		lineInstance.position = $StartPosn.position
		add_child(lineInstance)
	
		while (count < (floor(($EndPosn.position.x - $StartPosn.position.x) / SPACING)) * (lineCount +1)) and (count < answer.size()):
			posn.x += SPACING
		
			if not (int(answer[count]) == 0):
				
				var blankInstance = load("res://WordSystem/BlankLetter.tscn").instance()
				var answerLetterInstance = load("res://WordSystem/AnswerLetter.tscn").instance()
				
				blankInstance.position = posn
				answerLetterInstance.position = posn
				answerLetterInstance.texture = getLetter(answer[count])
				answerLetterInstance.visible = false
				
				get_node("Line" + str(lineCount)).add_child(blankInstance)
				get_node("Line" + str(lineCount)).add_child(answerLetterInstance)
				
			count += 1

func revealLetter(guess : String):
	

func getLetter(index : String):
	# takes a number in a string and returns the corrosponding file. if given 0, will return a null
	# to create a space
	if int(index) > 0:
		return load("res://Assets/Letters/" + index + ".png")
	else:
		return null
