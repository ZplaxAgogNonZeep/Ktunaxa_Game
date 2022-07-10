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
	choices.shuffle()
	
	for i in range(choices.size()):
		get_node("Button" + str(i)).icon = game.getAssetByIndex(int(choices[i].split("|")[0]))
	
	# THIS IS WHERE WE BUILD THE SPELLING LATER
	$Word.text = answer.split("|")[1]
	
	$Button0.disabled = false
	$Button1.disabled = false
	$Button2.disabled = false

func pullRandomWord() -> String:
	# takes a random word from the list, removes it from the list, then returns the word.
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var word = wordList[rng.randf_range(0, wordList.size())]
	wordList.erase(word)
	return word

func isSelectionCorrect(ans : String):
	# takes a an answer as a string and decides if it was the correct answer
	if ans == answer:
		pass # Correct Answer path
	else:
		pass # Incorrect Answer path

func _on_Button0_pressed():
	isSelectionCorrect(choices[0])


func _on_Button1_pressed():
	isSelectionCorrect(choices[1])


func _on_Button2_pressed():
	isSelectionCorrect(choices[2])


func _on_PlayAudio_pressed():
	game.get_node("AudioManager").startTrack(int(answer.split("|")[0]), 0, false, int(answer.split("|")[0]))
