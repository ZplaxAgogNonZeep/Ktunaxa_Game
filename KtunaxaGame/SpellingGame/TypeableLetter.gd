extends Sprite

var isMouse := false
var letterCode := "0"

func _ready():
	letterCode = name
	texture = getLetter(name)

func _on_Area2D_mouse_entered():
	isMouse = true


func _on_Area2D_mouse_exited():
	isMouse = false

func getLetter(index : String):
	# takes a number in a string and returns the corrosponding file. if given 0, will return a null
	# to create a space
	if int(index) > 0:
		return load("res://Assets/Letters/" + index + ".png")
	else:
		return null
