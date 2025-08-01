extends Interactable
class_name Lamp

@export var lampRefs : Array[Lamp] = []
@export var puzzleLamps : Array[Lamp]

var puzzle_completed = false

@onready var light = $OmniLight3D

@onready var head_scare = $HeadScare
@onready var lamp_model = $Desk_lamp

func handle_toggle():
	if not puzzle_completed:
		_turn_on_all()
		_check_puzzle_completion()

func _turn_on_all():
	for lamp : Lamp in lampRefs:
		lamp.light.visible = !lamp.light.visible

func switch_scare():
	lamp_model.visible = false
	head_scare.visible = true
	light.visible = false
	puzzle_completed = true

func _check_puzzle_completion():
	var lamps_on = 0
	for lamp in puzzleLamps:
		if lamp.light.visible:
			lamps_on += 1
	
	if lamps_on == puzzleLamps.size() and not GlobalVariables.is_lamp_puzzle_complete:
		GlobalVariables.is_lamp_puzzle_complete = true
		GlobalVariables.lamp_puzzle_complete.emit()
		for lamp in puzzleLamps:
			lamp.switch_scare()
