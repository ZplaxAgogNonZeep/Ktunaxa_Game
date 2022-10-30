extends Node2D

var letterList : Array = []
const SIZE = 14

func _ready():
	var count = 1
	
	while count < 30:
		letterList.append(str(count))
		count += 1
	
	generateKeyboard(["1", "12", "13"])

func generateKeyboard(answerList : Array):
	# Takes a list of string numbers that represent the word that needs to be spelled.
	# Then generates a keyboard that consists of those letters plus extra random letters
	var validLetterList : Array = []
	
	for i in letterList:
		if not answerList.has(i):
			validLetterList.append(i)
	
	var finalKeyboardList = answerList.duplicate()
	randomize()
	validLetterList.shuffle()
	
	var count = 0
	while finalKeyboardList.size() < SIZE:
		finalKeyboardList.append(validLetterList[count])
		count += 1
	
	finalKeyboardList.shuffle()
	
	print(finalKeyboardList)
