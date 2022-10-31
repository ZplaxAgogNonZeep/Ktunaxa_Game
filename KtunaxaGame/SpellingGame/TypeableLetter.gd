extends Sprite

# A letter that can be typed in a spelling game

var active := true
var isMouse := false
var letterCode := "0"


func _on_Area2D_mouse_entered():
	isMouse = true

func _on_Area2D_mouse_exited():
	isMouse = false

# Public Functions =================================================================================

func setLetter(codeNumber : int, typable : bool):
	# Changes the texture and the code of the letter
	letterCode = str(codeNumber)
	texture = getLetter(letterCode)
	active = typable

# Common Functions =================================================================================

func getLetter(index : String):
	# takes a number in a string and returns the corrosponding file. if given 0, will return a null
	# to create a space
	if int(index) > 0:
		return load("res://Assets/Letters/" + index + ".png")
	else:
		return null
