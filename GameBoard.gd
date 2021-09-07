extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var button = preload("res://Button.tscn")

var styleR = preload("res://style_boxes/letter_background_1.tres")
var styleB = preload("res://style_boxes/letter_background_2.tres")
var styleG = preload("res://style_boxes/letter_background_3.tres")
var styleY = preload("res://style_boxes/letter_background_4.tres")

# " "  - normal
# "R"  - red (5 points)
# "G"  - green (2 points)
# "B"  - blue (3 points)
# "Y"  - yellow (1 point)
# "2W" - 2x word
# "3W" - 3x word
var board_template = [
	"R" , " " , "3W", " " , " " , "G" , " " , "R" , " " , "G" , " " , " " , "3W", " " , "R"  ,
	" " , " " , " " , " " , "G" , " " , "R" , " " , "R" , " " , "G" , " " , " " , " " , " "  ,
	"3W", " " , " " , "G" , " " , "2W", " " , "Y" , " " , "2W", " " , "G" , " " , " " , "3W" ,
	" " , " " , "G" , " " , "2W", " " , "Y" , " " , "Y" , " " , "2W", " " , "G" , " " , " "  ,
	" " , "G" , " " , "2W", " " , "Y" , " " , " " , " " , "Y" , " " , "2W", " " , "G" , " "  ,
	"G" , " " , "2W", " " , "Y" , " " , " " , "B" , " " , " " , "Y" , " " , "2W", " " , "G"  ,
	" " , "R" , " " , "Y" , " " , " " , "B" , " " , "B" , " " , " " , "Y" , " " , "R" , " "  ,
	"R" , " " , "Y" , " " , " " , "B" , " " , "R" , " " , "B" , " " , " " , "Y" , " " , "R"  ,
	" " , "R" , " " , "Y" , " " , " " , "B" , " " , "B" , " " , " " , "Y" , " " , "R" , " "  ,
	"G" , " " , "2W", " " , "Y" , " " , " " , "B" , " " , " " , "Y" , " " , "2W", " " , "G"  ,
	" " , "G" , " " , "2W", " " , "Y" , " " , " " , " " , "Y" , " " , "2W", " " , "G" , " "  ,
	" " , " " , "G" , " " , "2W", " " , "Y" , " " , "Y" , " " , "2W", " " , "G" , " " , " "  ,
	"3W", " " , " " , "G" , " " , "2W", " " , "Y" , " " , "2W", " " , "G" , " " , " " , "3W" ,
	" " , " " , " " , " " , "G" , " " , "R" , " " , "R" , " " , "G" , " " , " " , " " , " "  ,
	"R" , " " , "3W", " " , " " , "G" , " " , "R" , " " , "G" , " " , " " , "3W", " " , "R"  ,
]

# Called when the node enters the scene tree for the first time.
func _init():
	for type in board_template:
		var b = button.instance()
		b.size_flags_horizontal = SIZE_EXPAND_FILL
		b.size_flags_vertical = SIZE_EXPAND_FILL

		b.find_node("Button").text = " "

		if type == "R":
			b.find_node("Button").add_stylebox_override("normal", styleR)
		elif type == "G":
			b.find_node("Button").add_stylebox_override("normal", styleG)
		elif type == "B":
			b.find_node("Button").add_stylebox_override("normal", styleB)
		elif type == "Y":
			b.find_node("Button").add_stylebox_override("normal", styleY)
		elif type == "2W":
			b.find_node("Button").text = "2X"
			b.find_node("Button").add_color_override("font_color", Color(0.5,0.5,0.5,1))
		elif type == "3W":
			b.find_node("Button").text = "3X"
			b.find_node("Button").add_color_override("font_color", Color(0.5,0.5,0.5,1))

		b.find_node("Button").connect("pressed", self, "_on_button_pressed", [b])

		Global.board_buttons.append(b)
		add_child(b)

func _on_button_pressed(button):
	var pressed = button.find_node("Button").pressed
	if pressed:
		for b in Global.board_buttons:
			if b != button && b.find_node("Button").pressed:
				b.find_node("Button").pressed = false
	pass
