extends Node

# Manages various audio track signals. 

func startTrack(trackIndex : int, trackType : int, isLooping : bool, toReplace:=0):
	# Takes a track and decides what to do with it with the given variables.
	# toReplace variable will end any playing track at the given index with 0 as null
	# Track Type will affect which library to pull track from:
	# 0 = Voice Recording
	# 1 = Music
	# 2 = Sound Effect
	
	var track = AudioStreamPlayer.new()
	var folder : String
	match trackType:
		0:
			track.volume_db = get_parent().voiceVolume
			folder = "VoiceRecordings"
		1:
			track.volume_db = get_parent().musicVolume
			folder = "Music"
		2:
			track.volume_db = get_parent().effectVolume
			folder = "SoundEffects"
		_:
			print("Start Track given an Invalid trackType at " + str(trackType))
	
	track.stream = load("res://Assets/" + folder + "/" + str(trackIndex) + ".wav")
	
	
	
	add_child(track)
	track.play()

