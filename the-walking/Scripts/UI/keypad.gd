extends Control

var typed_text = ""
@onready var input_text = $VBoxContainer/Input

@onready var press_sfx = $KeypadButtonPress
@onready var fail_sfx = $KeypadFail
@onready var success_sfx = $KeypadSuccess


func _on_1_button_pressed() -> void:
	typed_text += "1"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_2_pressed() -> void:
	typed_text += "2"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_3_pressed() -> void:
	typed_text += "3"
	input_text.text = typed_text
	press_sfx.play()


func _on_4_button_pressed() -> void:
	typed_text += "4"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_5_pressed() -> void:
	typed_text += "5"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_6_pressed() -> void:
	typed_text += "6"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_7_pressed() -> void:
	typed_text += "7"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_8_pressed() -> void:
	typed_text += "8"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_9_pressed() -> void:
	typed_text += "9"
	input_text.text = typed_text
	press_sfx.play()


func _on_button_delete_pressed() -> void:
	typed_text = ""
	input_text.text = typed_text
	press_sfx.play()


func _on_button_enter_pressed() -> void:
	if typed_text == GlobalVariables.keypad_password:
		GlobalVariables.keypad_puzzle_complete.emit()
		success_sfx.play()
	else:
		typed_text = ""
		input_text.text = typed_text
		fail_sfx.play()


func _on_button_0_pressed() -> void:
	typed_text += "0"
	input_text.text = typed_text
	press_sfx.play()
