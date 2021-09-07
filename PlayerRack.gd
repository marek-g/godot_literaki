extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var button = preload("res://Button.tscn")

var styleR = preload("res://style_boxes/letter_background_1.tres")
var styleB = preload("res://style_boxes/letter_background_2.tres")
var styleG = preload("res://style_boxes/letter_background_3.tres")
var styleY = preload("res://style_boxes/letter_background_4.tres")

var letters = []


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_random_missing_tiles()

func add_random_missing_tiles():
	for i in range(7 - letters.size()):
		var b = button.instance()
		b.size_flags_horizontal = SIZE_EXPAND_FILL
		b.size_flags_vertical = SIZE_SHRINK_CENTER
		var letter = random_letter()
		var letter_points = Global.letter_points[letter]
		if letter_points == 1:
			b.find_node("Button").add_stylebox_override("normal", styleY)
			b.find_node("Button").add_stylebox_override("disabled", styleY)
		elif letter_points == 2:
			b.find_node("Button").add_stylebox_override("normal", styleG)
			b.find_node("Button").add_stylebox_override("disabled", styleG)
		elif letter_points == 3:
			b.find_node("Button").add_stylebox_override("normal", styleB)
			b.find_node("Button").add_stylebox_override("disabled", styleB)
		elif letter_points == 5:
			b.find_node("Button").add_stylebox_override("normal", styleR)
			b.find_node("Button").add_stylebox_override("disabled", styleR)
		b.find_node("Button").text = letter
		
		b.find_node("Button").toggle_mode = false
		
		b.find_node("Button").connect("pressed", self, "_on_button_pressed", [b])
		
		add_child(b)
		letters.append(b)

func random_letter():
	var max_number = 0
	for amount in Global.letter_amount.values():
		max_number += amount
	var number = randi() % max_number
	
	var final_letter;
	for letter in Global.letter_amount:
		var value = Global.letter_amount[letter]
		if number < value:
			final_letter = letter
			break
		number -= value

	return final_letter

func enable():
	$StarLabel.modulate = Color(1, 1, 1, 1)
	for letter in letters:
		letter.get_node("Button").disabled = false

func disable():
	$StarLabel.modulate = Color(1, 1, 1, 0)
	for letter in letters:
		letter.get_node("Button").disabled = true


func _on_button_pressed(button):
	var letter = button.find_node("Button").text
	
	var style = button.find_node("Button").get_stylebox("normal")
	
	for board_button in Global.board_buttons:
		if board_button.find_node("Button").pressed:
			board_button.find_node("Button").text = letter
			board_button.find_node("Button").add_stylebox_override("normal", style)
			letters.remove(letters.find(button))
			remove_child(button)
