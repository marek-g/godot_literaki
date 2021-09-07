extends MarginContainer

var current_player = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	set_player(current_player)

func set_player(number):
	if number == 1:
		current_player = 1
		$VBoxContainer/HBoxContainer/VBoxContainer/PlayerRack1.enable()
		$VBoxContainer/HBoxContainer/VBoxContainer/PlayerRack2.disable()
	else:
		current_player = 2
		$VBoxContainer/HBoxContainer/VBoxContainer/PlayerRack1.disable()
		$VBoxContainer/HBoxContainer/VBoxContainer/PlayerRack2.enable()

func add_random_missing_tiles():
	if current_player == 1:
		$VBoxContainer/HBoxContainer/VBoxContainer/PlayerRack1.add_random_missing_tiles()
	else:
		$VBoxContainer/HBoxContainer/VBoxContainer/PlayerRack2.add_random_missing_tiles()

func next_player():
	if current_player == 1:
		set_player(2)
	else:
		set_player(1)

func _on_OkButton_pressed():
	add_random_missing_tiles()
	next_player()

func _on_ChangeLettersButton_pressed():
	$VBoxContainer/HBoxContainer/CenterContainer/ActionButtons.visible = false
	$VBoxContainer/HBoxContainer/CenterContainer/ChangeLettersButtons.visible = true

func _on_PassButton_pressed():
	next_player()

func _on_AcceptChangeButton_pressed():
	$VBoxContainer/HBoxContainer/CenterContainer/ActionButtons.visible = true
	$VBoxContainer/HBoxContainer/CenterContainer/ChangeLettersButtons.visible = false


func _on_CancelChangeButton_pressed():
	$VBoxContainer/HBoxContainer/CenterContainer/ActionButtons.visible = true
	$VBoxContainer/HBoxContainer/CenterContainer/ChangeLettersButtons.visible = false
