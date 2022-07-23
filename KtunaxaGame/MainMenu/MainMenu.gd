extends Node2D

onready var game = get_tree().root.get_node("Game")

func loadGame():
	# Inherit. Loads game in for the first time. Sets up variables.
	$WordGenerator.generateWord("6>12>19>1>21>0>6>1>21>15>1>15>1")


func _on_Picture_Game_pressed():
	game.changeGame(1)
