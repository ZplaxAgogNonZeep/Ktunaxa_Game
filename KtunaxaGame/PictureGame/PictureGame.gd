extends Node2D

onready var game = get_tree().root.get_node("Game")

var wordList := []

var firstTry := true
var score := 0

var choices := []
var answer := ""

func loadGame():
	# Inherit. Loads game in for the first time. Sets up variables.
	
	wordList = game.wordList
	startRound()


func startRound():
	# Starts a round by choosing a new answer and two fake words then adding them
	# to a list and shuffling
	choices = []
	var word = pullRandomWord()
	answer = word
	choices.append(word)
	choices.append(pullRandomWord())
	choices.append(pullRandomWord())
	print(answer)
	choices.shuffle()
	print(choices)

func pullRandomWord() -> String:
	# takes a random word from the list, removes it from the list, then returns the word.
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var word = wordList[rng.randf_range(0, wordList.size())]
	wordList.erase(word)
	return word

func _on_Button0_pressed():
	pass # Replace with function body.


func _on_Button1_pressed():
	pass # Replace with function body.


func _on_Button2_pressed():
	pass # Replace with function body.
