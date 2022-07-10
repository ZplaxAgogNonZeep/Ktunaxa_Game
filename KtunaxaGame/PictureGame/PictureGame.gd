extends Node2D

onready var game = get_tree().root.get_node("Game")

var wordList := []

var firstTry := true
var score := 0
var roundNum := 0

var choices := []
var answer := ""

func loadGame():
	# Inherit. Loads game in for the first time. Sets up variables.
	startRound()

# Game Functions ===================================================================================

func startRound():
	# Starts a round by choosing a new answer and two fake words then adding them
	# to a list and shuffling
	disableButtons()
	
	choices = []
	answer = ""
	firstTry = true
	wordList = game.wordList.duplicate()
	
	roundNum += 1
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
	
	enableButtons()

func endGame():
	# Ends the game, giving a total score message and gives the option of retrying or returning to menu
	print("Game Over")
	$Word.text = "You Win!"

func isSelectionCorrect(ans : String, buttonNum: int):
	# takes a an answer as a string and decides if it was the correct answer
	if ans == answer:
		disableButtons()
		if firstTry:
			score += 1
		if roundNum == 5:
			endGame()
		else:
			startRound()
	else:
		#Make sure to add incorrect juice
		get_node("Button" + str(buttonNum)).disabled = true
		firstTry = false

# Helper Funtions ==================================================================================
func pullRandomWord() -> String:
	# takes a random word from the list, removes it from the list, then returns the word.
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var word = wordList[rng.randf_range(0, wordList.size())]
	wordList.erase(word)
	return word

func enableButtons():
	$Button0.disabled = false
	$Button1.disabled = false
	$Button2.disabled = false
	$PlayAudio.disabled = false

func disableButtons():
	$Button0.disabled = true
	$Button1.disabled = true
	$Button2.disabled = true
	$PlayAudio.disabled = true

# Signals ==========================================================================================

func _on_Button0_pressed():
	isSelectionCorrect(choices[0], 0)


func _on_Button1_pressed():
	isSelectionCorrect(choices[1], 1)


func _on_Button2_pressed():
	isSelectionCorrect(choices[2], 2)


func _on_PlayAudio_pressed():
	game.get_node("AudioManager").startTrack(int(answer.split("|")[0]), 0, false, int(answer.split("|")[0]))
