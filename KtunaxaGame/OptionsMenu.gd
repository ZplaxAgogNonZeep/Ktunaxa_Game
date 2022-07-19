extends Control

onready var game = get_tree().root.get_node("Game")

var voiceValue : int
var musicValue : int
var effectValue : int

func _ready():
	$VoiceSlider.value = game.voiceVolume


func updateSettings():
	game.saveOptions()

func _on_MainMenu_pressed():
	game.changeGame(0)
	queue_free()


func _on_VoiceSlider_value_changed(value):
	voiceValue = value
	$VoiceSlider/VoiceTimer.start(.1)
	


func _on_VoiceTimer_timeout():
	game.voiceVolume = voiceValue
	game.get_node("AudioManager").changeVolume(0, voiceValue)
	updateSettings()


func _on_CloseButton_pressed():
	queue_free()
