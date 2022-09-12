extends Control

onready var game = get_tree().root.get_node("Game")

var voiceValue : int
var musicValue : int
var effectValue : int

func _ready():
	$VoiceSlider.value = game.voiceVolume


func updateSettings():
	game.saveOptions()

func setVolumeTexture(value : int):
	# Takes a value between -24 and 24, and stretches a ColorRect to an appropriate size.
	var percentage : float = (float(value) + 24.0) / 48.0 
	$"VoiceFill-in".rect_size.x = 212 * percentage


# Butt Stuff =======================================================================================

func _on_MainMenu_pressed():
	game.changeGame(0)
	queue_free()

func _on_VoiceSlider_value_changed(value):
	setVolumeTexture(value)
	voiceValue = value
	$VoiceSlider/VoiceTimer.start(.1)

func _on_VoiceTimer_timeout():
	game.voiceVolume = voiceValue
	game.get_node("AudioManager").changeVolume(0, voiceValue)
	updateSettings()

func _on_CloseButton_pressed():
	queue_free()


