extends Node

# Manages various audio track signals. 

func startTrack(trackIndex : int, trackType : int, isLooping : bool, toReplace:=-1):
	# Takes a track and decides what to do with it with the given variables.
	# toReplace variable will end any playing track at the given index with 0 as null
	# Track Type will affect which library to pull track from:
	# 0 = Voice Recording
	# 1 = Music
	# 2 = Sound Effect
	
	var track = preload("res://AudioSystem/Track.tscn").instance()
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
	
	# This will crash if things go wrong so don't get things wrong!!!!
	track.stream = load("res://Assets/" + folder + "/" + str(trackIndex) + ".wav")
	
	track.trackIndex = trackIndex
	track.isLooping = isLooping
	
	if toReplace >= 0:
		for i in range(get_child_count()):
			if get_children()[i].trackIndex == toReplace:
				get_children()[i].queue_free()
				break
	
	add_child(track)
	track.play()

