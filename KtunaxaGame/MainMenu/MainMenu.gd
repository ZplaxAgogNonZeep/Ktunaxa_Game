extends Node2D

onready var game = get_tree().root.get_node("Game")

func _on_Picture_Game_pressed():
	game.changeGame(1)
