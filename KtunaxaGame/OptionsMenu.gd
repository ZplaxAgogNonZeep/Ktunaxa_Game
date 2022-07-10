extends Control

onready var game = get_tree().root.get_node("Game")

func _ready():
	$HSlider.value = game.voiceVolume




func _on_MainMenu_pressed():
	game.get_node("AudioManager").startTrack(0, 0, true)


func _on_HSlider_value_changed(value):
	game.voiceVolume = value
